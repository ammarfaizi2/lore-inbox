Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbULFRS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbULFRS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbULFRS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:18:59 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:20100 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261581AbULFRQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:16:32 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1102349255.25841.189.camel@localhost.localdomain>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
	 <1101748258.25841.53.camel@localhost.localdomain>
	 <20041205234605.GF2953@stusta.de>
	 <1102349255.25841.189.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 06 Dec 2004 12:16:28 -0500
Message-Id: <1102353388.25841.198.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 11:07 -0500, Steven Rostedt wrote:
> On Mon, 2004-12-06 at 00:46 +0100, Adrian Bunk wrote:
> > 
> > Why don't you EXPORT_SYMBOL_GPL dsyscall_{,un}register?
> > 
> > This should at least fix the binary only module concerns.
> 
> Done!
> 
> Updated on http://home.stny.rr.com/rostedt/dynamic as well as included
> in this email for ease.  
> 
> Now, I guess you can still get around this if the "Bad Vendor" were to
> write a GPL module with their added system calls, and have that module
> include hooks to their binary module.  So, until we can fix that, I
> guess Linus won't allow for this module to be included in the main line.

I added the following to my sys_dsyscall routine. The routine that is
the only system call for a user process to access dynamic system calls
(at anytime), even if dynamic system calls are loaded.

	static int is_tainted = 0;

	if (tainted & TAINT_PROPRIETARY_MODULE) {
		if (!is_tainted) {
			printk(KERN_INFO "Sorry, can't use dynamic system calls with proprietary modules\n");
			is_tainted = 1;
		}
		return -EINVAL;
	}

Once a proprietary module is loaded then all dynamic system calls will
become useless.

This way, only systems that never loaded a proprietary module may be
able to use dynamic system calls.  This may suck for those that have
NVidia cards, but this may be a start to overcome the problem of
allowing binary hooks into default kernels. It also is a way to motivate
end users to not use proprietary modules.

What do others think about this?

Once again I've update my account and added here the patch.

Index: kernel/Makefile
===================================================================
--- kernel/Makefile	(revision 15)
+++ kernel/Makefile	(working copy)
@@ -29,6 +29,7 @@
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash.o
+obj-$(CONFIG_DSYSCALL) += dsyscall.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: kernel/dsyscall.c
===================================================================
--- kernel/dsyscall.c	(revision 0)
+++ kernel/dsyscall.c	(revision 0)
@@ -0,0 +1,294 @@
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
+	static int is_tainted = 0;
+
+	if (tainted & TAINT_PROPRIETARY_MODULE) {
+		if (!is_tainted) {
+			printk(KERN_INFO "Sorry, can't use dynamic system calls with proprietary modules\n");
+			is_tainted = 1;
+		}
+		return -EINVAL;
+	}
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
+EXPORT_SYMBOL_GPL(dsyscall_register);
+EXPORT_SYMBOL_GPL(dsyscall_unregister);
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
Index: include/asm-i386/unistd.h
===================================================================
--- include/asm-i386/unistd.h	(revision 15)
+++ include/asm-i386/unistd.h	(working copy)
@@ -300,8 +300,9 @@
 #define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
 #define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
 #define __NR_vperfctr_read	(__NR_perfctr_info+5)
+#define __NR_dsyscall		295
 
-#define NR_syscalls 295
+#define NR_syscalls 296
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
Index: include/linux/dsyscall.h
===================================================================
--- include/linux/dsyscall.h	(revision 0)
+++ include/linux/dsyscall.h	(revision 0)
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
Index: init/Kconfig
===================================================================
--- init/Kconfig	(revision 15)
+++ init/Kconfig	(working copy)
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
Index: arch/i386/kernel/entry.S
===================================================================
--- arch/i386/kernel/entry.S	(revision 15)
+++ arch/i386/kernel/entry.S	(working copy)
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

