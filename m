Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUK2PNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUK2PNI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUK2PNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:13:08 -0500
Received: from bgm-24-94-59-124.stny.rr.com ([24.94.59.124]:20644 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261723AbUK2PMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:12:00 -0500
Subject: [PATCH][RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 29 Nov 2004 10:11:58 -0500
Message-Id: <1101741118.25841.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before you just ignore me and throw me to the dogs, hear me out. Please!

I've seen previous attempts to get dynamic system calls into the kernel
and they just get dumped, but usually with good reason.  They require a
change to all architectures quite drastically and is usually a problem
implementing them for the module to use them.

The approach I take here is to only add one static system call
(sys_dsyscall) and move all processing into architecture independent
code.  This interface is not meant to replace other interfaces or system
calls in general, but gives the developer an easy way to test their work
and maybe use this when other solutions don't make sense.  I don't want
to make kernel developers lazy and use this when other ways are better,
but I've found myself wishing for an easy interface into the driver
without recompiling the kernel that I'm using.

This method requires a driver to register their system call with the
following line:

dsyscall_register("syscall_name",args,DSYSCALL_FUNC(dsys_syscall_func));

This call checks to see if syscall_name is in use, and fails if it is.
It then adds the system call to a list of dynamic system calls for user
programs to use.  This is all protected with semaphores to prevent
problems with race conditions of multiple modules using the same name.
The system call is now associated with an unique number (that has
nothing to do with the numbers used by static system calls).

When the user wants to use this, the following is done:

This code is best for a library and user header file:

#include <linux/dsyscall.h>

_syscall3(int,dsyscall,int,type,char *,user_name, struct dsyscall *, dcall);
_dsyscall2(int,mysyscall,long,arg1,char *,arg2);  /* system call with 2 arguments */

The driver would have used something like:

static dsys_mysyscall(long arg1, char * arg2) { ... }

int driver_init(void) { 
  if (dsyscall_register("mysyscall",2,DSYSCALL_FUNC(dsys_mysyscall)) < 0) {
    printk("mysyscall already in use!\n");
    return -1;
  }
}

Back in the code where you want to call this in user land:

int main(int argc, char **argv) {
   ... 
   if (mysyscall(2,"hello world") < 0) {
      perror("mysyscall");
      exit(0);
   }
   ...
}


The user header file only needed two lines (one for the dsyscall system
call and the other for each dynamic system call. If glibc added
dsyscall, then only one line per dynamic syscall is needed. In my
dreams).  So you can see that this code is very easy to use and that it
doesn't intrude on the current kernel.  All that is needed (per
architecture) is the addition of the sys_dsyscall system call, and once
that is done, then you have dynamic system calls available for that
architecture.

Some notes of design:

The system call dsyscall takes three parameters: a command (get or
call), the syscall name, and finally a pointer to a descriptor.

With the get command, the descriptor is filled with a handle to get to
the system call. The name is used to find that system call, and if is
not found, and error is returned.  

The call command calls the system call using the same descriptor.  This
descriptor has two long numbers to make sure that the dynamic system
call is unique. The two long numbers should never repeat as long as the
machine is up. Once a dynamic syscall is used, it's numbers will never
repeat (hopefully, unless the machine is up for a really really long
time!) and the system call is called by that number. So even if the user
wrapper (shown later) gets the system call, then the module is removed
and the associated system call is also removed, then the user program
calls that system call, a -ENODEV is returned and no harm is done. Even
if another module in that same time registered that system call. Which
shouldn't happen!

Dynamic system calls are only allowed to have up to 6 arguments.  I have
written wrapper macros to help in using these calls, with _dsyscall0 to
_dsyscall6 to handle each type of argument.  Here's a simple view of
what _dsyscall3 does:


#define _dsyscall_call(name,args,arg) \
{ \
 long __res;  \
 static int has_init = 0; \
 static struct dsyscall ds; \
 if (!has_init) { \
	 __res = dsyscall(DSYSCALL_GET,#name,&ds); \
	 if (!__res) \
		 has_init = 1; \
	 else \
		 return __res; \
 } \
 ds.argc = args; \
 ds.argv = arg; \
 __res = dsyscall(DSYSCALL_CALL,#name,&ds); \
 if (__res < 0 && errno == ENODEV) { \
	 has_init = 0; \
 } \
 return __res; \
}

#define _dsyscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
type name(type1 arg1, type2 arg2, type3 arg3) \
{ \
 long argv[3]; \
 argv[0] = (long)arg1; \
 argv[1] = (long)arg2; \
 argv[2] = (long)arg3; \
 _dsyscall_call(name,3,argv); \
 return 0; /* not reached */ \
}

_dsyscall_call is used by all the _dsyscall macros. _dsyscall3 first
assigns each of the argument to an array that will be passed to the
system call as the actual arguments.

You can see that _dsyscall_call handles the getting and calling of the
system call, so the user does not have to.  I still need to make these
wrappers thread safe but that will come later.

I've added a config option, so that if you don't want to use this, just
turn it off and it wont be available for drivers.

For sample programs, and updates to the patch you can goto
http://home.stny.rr.com/rostedt/dynamic

Even if this doesn't get into the kernel, I hope that this can help some
developers out for testing.

-- Steve


diff -Nur -X diff.ignore rt_2.6.10-rc2-mm2/arch/i386/kernel/entry.S rt_2.6.10-rc2-mm2_dynamic/arch/i386/kernel/entry.S
--- rt_2.6.10-rc2-mm2/arch/i386/kernel/entry.S	2004-11-18 13:33:18.000000000 -0500
+++ rt_2.6.10-rc2-mm2_dynamic/arch/i386/kernel/entry.S	2004-11-28 20:12:38.000000000 -0500
@@ -906,5 +906,10 @@
 	.long sys_vperfctr_unlink
 	.long sys_vperfctr_iresume
 	.long sys_vperfctr_read
+#ifdef CONFIG_DSYSCALL
+	.long sys_dsyscall		/* 295 */
+#else
+	.long sys_ni_syscall		/* 295 */
+#endif
 
 syscall_table_size=(.-sys_call_table)
diff -Nur -X diff.ignore rt_2.6.10-rc2-mm2/include/asm-i386/unistd.h rt_2.6.10-rc2-mm2_dynamic/include/asm-i386/unistd.h
--- rt_2.6.10-rc2-mm2/include/asm-i386/unistd.h	2004-11-18 13:33:22.000000000 -0500
+++ rt_2.6.10-rc2-mm2_dynamic/include/asm-i386/unistd.h	2004-11-28 19:30:49.000000000 -0500
@@ -300,8 +300,9 @@
 #define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
 #define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
 #define __NR_vperfctr_read	(__NR_perfctr_info+5)
+#define __NR_dsyscall		295
 
-#define NR_syscalls 295
+#define NR_syscalls 296
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -Nur -X diff.ignore rt_2.6.10-rc2-mm2/include/linux/dsyscall.h rt_2.6.10-rc2-mm2_dynamic/include/linux/dsyscall.h
--- rt_2.6.10-rc2-mm2/include/linux/dsyscall.h	1969-12-31 19:00:00.000000000 -0500
+++ rt_2.6.10-rc2-mm2_dynamic/include/linux/dsyscall.h	2004-11-29 08:00:39.000000000 -0500
@@ -0,0 +1,174 @@
+/*
+ * dsyscall.h
+ *
+ * Copyright (C) 2004 Steven Rostedt <steven.rostedt@kihontech.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#ifndef _LINUX_DSYSCALL_H
+#define _LINUX_DSYSCALL_H
+
+#define DSYSCALL_NAME_SZ 128
+#define DSYSCALL_MAX_ARGS 6
+
+enum dsyscall_cmd {
+	DSYSCALL_GET = 1,
+	DSYSCALL_CALL,
+};
+
+struct dsyscall {
+	char name[DSYSCALL_NAME_SZ];	/* Name of system call */
+	long id;			/* unique id of available dynamic syscalls */
+	long iteration;			/* incase this box runs longer than we have been on earth
+					   count the iterations of id's. If interation overflows,
+					   then we are simply out of luck! */
+	int argc;			/* Number of arguments that this system call takes. */
+	long *argv;			/* pointer to the argument list */
+};
+
+#define DSYSCALL_FUNC(func) ((int(*)(long,...))func)
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+
+struct dsyscall_struct {
+	struct list_head next;		/* list of all dynamic syscalls */
+	struct list_head link;		/* used in the hash */
+	char name[DSYSCALL_NAME_SZ];	/* name of the dynamic syscall */	
+	int args;			/* number of arguments for this syscall */
+	int (*func)(long,...);		/* The actual dynamic system call */
+	long id;
+	long iteration;
+
+};
+
+int dsyscall_register(char *name, int args, int (*func)(long,...));
+int dsyscall_unregister(char *name);
+
+#else /* !__KERNEL__ */
+
+/* OK, this should probably be in another file for users */
+#include <asm/unistd.h>
+
+#define _dsyscall_call(name,args,arg) \
+{ \
+ long __res;  \
+ static int has_init = 0; \
+ static struct dsyscall ds; \
+ if (!has_init) { \
+	 __res = dsyscall(DSYSCALL_GET,#name,&ds); \
+	 if (!__res) \
+		 has_init = 1; \
+	 else \
+		 return __res; \
+ } \
+ ds.argc = args; \
+ ds.argv = arg; \
+ __res = dsyscall(DSYSCALL_CALL,#name,&ds); \
+ if (__res < 0 && errno == ENODEV) { \
+	 has_init = 0; \
+ } \
+ return __res; \
+}
+
+#define _dsyscall0(type,name) \
+type name(void) \
+{ \
+ long argv[0]; \
+ _dsyscall_call(name,0,argv); \
+ return 0; /* not reached */ \
+}
+
+#define _dsyscall1(type,name,type1,arg1) \
+type name(type1 arg1) \
+{ \
+ long argv[1]; \
+ argv[0] = (long)arg1; \
+ _dsyscall_call(name,1,argv); \
+ return 0; /* not reached */ \
+}
+
+#define _dsyscall2(type,name,type1,arg1,type2,arg2) \
+type name(type1 arg1, type2 arg2) \
+{ \
+ long argv[2]; \
+ argv[0] = (long)arg1; \
+ argv[1] = (long)arg2; \
+ _dsyscall_call(name,2,argv); \
+ return 0; /* not reached */ \
+}
+
+#define _dsyscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
+type name(type1 arg1, type2 arg2, type3 arg3) \
+{ \
+ long argv[3]; \
+ argv[0] = (long)arg1; \
+ argv[1] = (long)arg2; \
+ argv[2] = (long)arg3; \
+ _dsyscall_call(name,3,argv); \
+ return 0; /* not reached */ \
+}
+
+#define _dsyscall4(type,name,type1,arg1,type2,arg2,type3,arg3, \
+                   type4,arg4) \
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
+{ \
+ long argv[4]; \
+ argv[0] = (long)arg1; \
+ argv[1] = (long)arg2; \
+ argv[2] = (long)arg3; \
+ argv[3] = (long)arg4; \
+ _dsyscall_call(name,4,argv); \
+ return 0; /* not reached */ \
+}
+
+#define _dsyscall5(type,name,type1,arg1,type2,arg2,type3,arg3, \
+                   type4,arg4,type5,arg5) \
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
+          type5 arg5) \
+{ \
+ long argv[5]; \
+ argv[0] = (long)arg1; \
+ argv[1] = (long)arg2; \
+ argv[2] = (long)arg3; \
+ argv[3] = (long)arg4; \
+ argv[4] = (long)arg5; \
+ _dsyscall_call(name,5,argv); \
+ return 0; /* not reached */ \
+}
+
+#define _dsyscall6(type,name,type1,arg1,type2,arg2,type3,arg3, \
+                   type4,arg4,type5,arg5,type6,arg6) \
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
+          type5 arg5, type6 arg6) \
+{ \
+ long argv[6]; \
+ argv[0] = (long)arg1; \
+ argv[1] = (long)arg2; \
+ argv[2] = (long)arg3; \
+ argv[3] = (long)arg4; \
+ argv[4] = (long)arg5; \
+ argv[5] = (long)arg6; \
+ _dsyscall_call(name,6,argv); \
+ return 0; /* not reached */ \
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_DSYSCALL_H */
diff -Nur -X diff.ignore rt_2.6.10-rc2-mm2/init/Kconfig rt_2.6.10-rc2-mm2_dynamic/init/Kconfig
--- rt_2.6.10-rc2-mm2/init/Kconfig	2004-11-18 13:33:31.000000000 -0500
+++ rt_2.6.10-rc2-mm2_dynamic/init/Kconfig	2004-11-28 15:57:29.000000000 -0500
@@ -249,6 +249,14 @@
 	  through /proc/config.gz.
 

+config DSYSCALL
+	bool "Enable dynamic system calls"
+	default y
+	help
+	  This option enables usage of dynamic system calls by drivers.
+	  This allows drivers to register system calls that are not
+	  already defined by the compiled kernel.
+
 menuconfig EMBEDDED
 	bool "Configure standard kernel features (for small systems)"
 	help
diff -Nur -X diff.ignore rt_2.6.10-rc2-mm2/kernel/dsyscall.c rt_2.6.10-rc2-mm2_dynamic/kernel/dsyscall.c
--- rt_2.6.10-rc2-mm2/kernel/dsyscall.c	1969-12-31 19:00:00.000000000 -0500
+++ rt_2.6.10-rc2-mm2_dynamic/kernel/dsyscall.c	2004-11-29 07:03:15.000000000 -0500
@@ -0,0 +1,286 @@
+/*
+ * dsyscall.c
+ *
+ * Copyright (C) 2004 Steven Rostedt <steven.rostedt@kihontech.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/dsyscall.h>
+#include <linux/module.h>
+#include <linux/rwsem.h>
+
+#include <asm/uaccess.h>
+
+#undef DEBUG
+#ifdef DEBUG
+#define dprintk(x...) printk(x)
+#else
+#define dprintk(x...) do { } while(0)
+#endif
+
+#define DSYSCALL_HASH_SIZE 32
+
+DECLARE_RWSEM(dsyscall_sem);
+
+static long dsyscall_next_id = 0;
+static long dsyscall_iterations = 0;
+static kmem_cache_t *dsyscall_cache;
+static struct list_head dsyscall_hash[DSYSCALL_HASH_SIZE];
+static LIST_HEAD(dsyscall_syscalls);
+
+static int dsyscall_hash_add(struct dsyscall_struct *ds)
+{
+	list_add(&ds->link,&dsyscall_hash[ds->id & (DSYSCALL_HASH_SIZE - 1)]);
+	return 0;
+}
+
+static struct dsyscall_struct * find_dsyscall_by_name(char *name)
+{
+	struct list_head *li;
+	struct dsyscall_struct *ds, *ret = NULL;
+
+	/* slow, but this should not be called often. */
+	list_for_each(li,&dsyscall_syscalls) {
+		ds = list_entry(li, struct dsyscall_struct, next);
+		if (strcmp(ds->name,name) == 0) {
+			ret = ds;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static struct dsyscall_struct * find_dsyscall_by_id(struct dsyscall *d)
+{
+	struct list_head *li;
+	struct dsyscall_struct *ds, *ret = NULL;
+
+	/* For now it's a little faster. We can optimize this if we need to */
+	list_for_each(li,&dsyscall_hash[d->id & (DSYSCALL_HASH_SIZE - 1)]) {
+		ds = list_entry(li, struct dsyscall_struct, link);
+		if (ds->id == d->id) {
+			if (likely(ds->iteration == d->iteration)) 
+				ret = ds;
+			break;
+		}
+	}
+	return ret;
+}
+
+
+int sys_dsyscall(int type, char *user_name, struct dsyscall *dcall)
+{
+	int ret;
+	struct dsyscall_struct *ds;
+	struct dsyscall d;
+	long argv[DSYSCALL_MAX_ARGS];
+
+	/*
+	 * OK, this is pretty long to hold a semaphore, even if
+	 * if is just for reading. But if you want speed, don't use
+	 * dynamic system calls!
+	 */
+	down_read(&dsyscall_sem);
+	switch (type) {
+	case DSYSCALL_GET:
+		dprintk("sys_dsyscall: DSYSCALL_GET, ");
+		memset (&d,0,sizeof(d));
+		ret = -EFAULT;
+		if (strncpy_from_user(d.name,user_name,DSYSCALL_NAME_SZ-1) < 0) {
+			dprintk(">>>BAD NAME<<<\n");
+			goto out;
+		}
+		dprintk("%s: ", d.name);
+
+		/* just in case */
+		d.name[DSYSCALL_NAME_SZ-1] = 0;
+
+		ds = find_dsyscall_by_name(d.name);
+
+		if (!ds) {
+			dprintk("not found\n");
+			ret = -ENODEV;
+			goto out;
+		}
+
+		dprintk("found\n");
+		d.id = ds->id;
+		d.iteration = ds->iteration;
+		d.argc = ds->args;
+
+		ret = 0;
+		if (copy_to_user(dcall,&d,sizeof(d)) != 0) { 
+			ret = -EFAULT;
+		}
+		break;
+
+	case DSYSCALL_CALL:
+		ret = -EFAULT;
+		if (copy_from_user(&d,dcall,sizeof(d)) != 0) {
+			goto out;
+		}
+
+		ds = find_dsyscall_by_id(&d);
+		if (!ds) {
+			ret = -ENODEV;
+			goto out;
+		}
+		/* Comparing to ds->args which can not be bigger than DSYSCALL_MAX_ARGS */
+		if (d.argc != ds->args) {
+			ret = -EINVAL;
+			goto out;
+		}
+		
+		if (d.argc > 0) {
+			if (copy_from_user(argv,d.argv,sizeof(char*)*d.argc) != 0) {
+				ret = -EFAULT;
+				goto out;
+			}
+		}
+
+		switch (d.argc) {
+		case 0:
+			ret = ds->func(0); /* The argument should be ignored */
+			break;
+		case 1:
+			ret = ds->func(argv[0]);
+			break;
+		case 2:
+			ret = ds->func(argv[0],argv[1]);
+			break;
+		case 3:
+			ret = ds->func(argv[0],argv[1],argv[2]);
+			break;
+		case 4:
+			ret = ds->func(argv[0],argv[1],argv[2],argv[3]);
+			break;
+		case 5:
+			ret = ds->func(argv[0],argv[1],argv[2],argv[3],argv[4]);
+			break;
+		case 6:
+			ret = ds->func(argv[0],argv[1],argv[2],argv[3],argv[4],argv[5]);
+			break;
+		}	
+		goto out;
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+ out:
+	up_read(&dsyscall_sem);
+
+	return ret;
+}
+
+int dsyscall_register(char *name, int args, int (*func)(long,...))
+{
+	int ret = -1;
+	struct dsyscall_struct *ds;
+
+	dprintk("dsyscall_register: %s args: %d func=%p\n",name,args,func);
+
+	if (strlen(name) >= DSYSCALL_NAME_SZ) {
+		printk(KERN_INFO "dsyscall: name %s is too large.", name);
+		return -1;
+	}
+	if (args > DSYSCALL_MAX_ARGS) {
+		printk(KERN_INFO "dsyscall: args is too big.");
+		return -1;
+	}
+	
+	down_write(&dsyscall_sem);
+	if ((ds = find_dsyscall_by_name(name)) != NULL) {
+		printk(KERN_INFO "dsyscall: name %s is already in use.",name);
+		goto out;
+	}
+
+	ds = kmem_cache_alloc(dsyscall_cache,GFP_KERNEL);
+	if (!ds) {
+		printk(KERN_INFO "dsyscall: could not allocate dsyscall_struct");
+		goto out;
+	}
+
+	ds->args = args;
+	ds->func = func;
+	ds->id = dsyscall_next_id++;
+	ds->iteration = dsyscall_iterations;
+	if (!dsyscall_next_id) {
+		if (!++dsyscall_iterations) {
+			printk(KERN_WARNING "dsyscall: iterations has overflowed???");
+		}
+	}
+	strcpy(ds->name,name);
+	
+	list_add(&ds->next,&dsyscall_syscalls);
+	dsyscall_hash_add(ds);
+
+	ret = 0;
+ out:
+	up_write(&dsyscall_sem);
+	return ret;
+}
+
+int dsyscall_unregister(char *name)
+{
+	struct dsyscall_struct *ds;
+
+	down_write(&dsyscall_sem);
+	if ((ds = find_dsyscall_by_name(name)) == NULL) {
+		printk("dsyscall: name %s is not registered\n",name);
+		up_write(&dsyscall_sem);
+		return -1;
+	}
+
+	list_del(&ds->next);
+	list_del(&ds->link);
+
+	up_write(&dsyscall_sem);
+
+	kmem_cache_free(dsyscall_cache,ds);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(dsyscall_register);
+EXPORT_SYMBOL(dsyscall_unregister);
+
+int __init dsyscall_init(void)
+{
+	int i;
+
+	dsyscall_cache = kmem_cache_create("dsyscalls", sizeof(struct dsyscall_struct),
+					   0, 0, NULL, NULL);
+	if (!dsyscall_cache)
+		panic ("Can't allocate dsyscall cache!");  /* Too much? something else is wrong if
+							      we fail here. */
+	
+	for (i=0; i < DSYSCALL_HASH_SIZE; i++) {
+		INIT_LIST_HEAD(&dsyscall_hash[i]);
+	}
+
+	return 0;
+}
+__initcall(dsyscall_init);
diff -Nur -X diff.ignore rt_2.6.10-rc2-mm2/kernel/Makefile rt_2.6.10-rc2-mm2_dynamic/kernel/Makefile
--- rt_2.6.10-rc2-mm2/kernel/Makefile	2004-11-18 13:33:30.000000000 -0500
+++ rt_2.6.10-rc2-mm2_dynamic/kernel/Makefile	2004-11-28 18:25:13.000000000 -0500
@@ -29,6 +29,7 @@
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash.o
+obj-$(CONFIG_DSYSCALL) += dsyscall.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is

