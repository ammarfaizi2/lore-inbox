Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269753AbTGKB1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269759AbTGKB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:27:39 -0400
Received: from ns.suse.de ([213.95.15.193]:63762 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269753AbTGKB1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:27:13 -0400
Date: Fri, 11 Jul 2003 03:41:54 +0200
From: Andi Kleen <ak@suse.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH/RFC] Deprecate sysctl(2), add sysctl_name
Message-ID: <20030711014154.GA15238@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I know I am a bit late with this. But I hope it can be done for 2.6.

I want to deprecate the numerical sysctl interface for 2.6. The numerical
name space always a bad design and never particularly stable
(e.g. most distribution kernels assigned freely new numbers so you cannot
really rely on it). There are a lot of duplicated and moved sysctls
around now. It's not a stable ABI. 

Also near all people just use /proc/sys to change sysctls. The 
sysctl.h/sysctl.c file were always one of the number one
sources of rejections when merging different trees.
I don't see the point in having a hard to maintain numerical name space
for this when there is a perfectly good symbolic name space. 

This patch deprecates sysctl(2) by adding a printk to it. There is one
important user of it - glibc checks kernel.version in the startup code -
which is still handled without message. This needs to be still handled,
but the hope is that there are no other users of the numerical interface.

With the deprecation it can be hopefully removed for 2.8 except for a small
stub to emulate kernel.version for old binaries.

If there are any real others users of the numerical namespace we will
soon know, but I consider it unlikely.

The primary interface is /proc/sys now. This was always the most widely
used way to change sysctl. However there were some objections that embedded
systems don't want to have /proc mounted due to memory usage. To offer
them an alternative I added a new sysctl_name(2) system call.
It has the same semantics as the existing sysctl(2), except that
it takes a string instead of a list of numbers to specify the 
Unlike /proc sysctl_name has low memory overhead (no dentries, no inodes)
etc. Still it likely is only useful for embedded users, everybody else
should just use /proc/sys. 

I hope in 2.7 the internal implementation can be replaced by something
based on ELF segments, so that the central sysctl.c file can go away
and declaring sysctls will be finally easy. There already is an replacement
for it (include/linux/moduleparam.h), but it seems to be not widely used
yet. It unfortunately is a bit bloated, which makes it not nice to use 
for everything.

I also added an compat interface for 64bit architectures with 32bit
emulation.

Please consider adding,

-Andi


--- linux-2.5/include/linux/sysctl.h	2003-06-06 17:55:40.000000000 +0200
+++ linux-2.5-amd64/include/linux/sysctl.h	2003-07-09 23:15:45.000000000 +0200
@@ -6,16 +6,10 @@
  ****************************************************************
  ****************************************************************
  **
- **  WARNING:  
  **  The values in this file are exported to user space via 
- **  the sysctl() binary interface.  Do *NOT* change the 
- **  numbering of any existing values here, and do not change
- **  any numbers within any one set of values.  If you have
- **  to redefine an existing interface, use a new number for it.
- **  The kernel will then return ENOTDIR to any application using
- **  the old binary interface.
- **
- **  --sct
+ **  the sysctl() binary interface.  However this interface
+ **  is unstable and deprecated and will be removed in the future. 
+ **  For a stable interface use /proc/sys.
  **
  ****************************************************************
  ****************************************************************
--- linux-2.5/kernel/sysctl.c	2003-07-04 23:52:20.000000000 +0200
+++ linux-2.5-amd64/kernel/sysctl.c	2003-07-11 03:25:18.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/writeback.h>
 #include <linux/hugetlb.h>
 #include <linux/security.h>
+#include <linux/compat.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_ROOT_NFS
@@ -106,6 +107,10 @@
 
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
+static int parse_table_name(char *name, 
+			    void __user *oldval, size_t *oldlenp,
+			    void __user *newval, size_t newlen,
+			    ctl_table *table, void **context);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp);
 
@@ -823,7 +838,16 @@
 
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
-		
+	
+	if (tmp.nlen != 2 || tmp.name[0] != CTL_KERN ||
+	    tmp.name[1] != KERN_VERSION) { 
+		int i;
+		printk(KERN_INFO "%s: numerical sysctl ", current->comm); 
+		for (i = 0; i < tmp.nlen; i++) 
+			printk("%d ", tmp.name[i]); 
+		printk("is obsolete.\n");
+	} 
+
 	lock_kernel();
 	error = do_sysctl(tmp.name, tmp.nlen, tmp.oldval, tmp.oldlenp,
 			  tmp.newval, tmp.newlen);
@@ -831,6 +855,76 @@
 	return error;
 }
 
+/* 
+ * Symbolic name space access for sysctl.
+ * /proc/sys is the better interface really, this is just for people with
+ * not enough memory for /proc.
+ */
+asmlinkage long sys_sysctl_name(char __user *username,
+				void __user *oldval, unsigned long *oldlenp,
+				void __user *newval, unsigned long newlen)
+{
+	struct list_head *node; 
+	char *name = getname(username);
+	int err = PTR_ERR(name);
+	if (IS_ERR(name))
+		return err;
+	lock_kernel();
+	node = &root_table_header.ctl_entry; 
+	do { 
+		struct ctl_table_header *tbl = 
+			list_entry(node, struct ctl_table_header, ctl_entry);	
+		void *context = NULL;
+		err = parse_table_name(name, oldval, oldlenp, newval, newlen,
+				       tbl->ctl_table, &context);
+		if (context)
+			kfree(context);
+		if (err != -ENOTDIR) 
+			break;	 
+		node = node->next;
+	} while (node != &root_table_header.ctl_entry);
+	unlock_kernel(); 
+	putname(name); 
+	return err;
+}
+
+#ifdef CONFIG_COMPAT
+asmlinkage long compat_sysctl_name(char __user *username,
+				void __user *coldval, compat_size_t *coldlenp,
+				void __user *cnewval, unsigned long newlen)
+{
+	unsigned long oldlen; 
+	char *name;
+	int err;
+	void *newval, *oldval; 
+	mm_segment_t oldfs;
+
+	if (get_user(oldlen, coldlenp))
+		return -EFAULT;
+
+	oldval = compat_alloc_user_space(oldlen + newlen); 
+	newval = oldval + oldlen; 
+	if (copy_in_user(newval, cnewval, newlen))
+		return -EFAULT; 
+
+	name = getname(username);
+	err = PTR_ERR(name);
+	if (IS_ERR(name))
+		return err;
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS); 
+	err = sys_sysctl_name(name, oldval, &oldlen, newval, newlen); 
+	set_fs(oldfs); 
+	putname(name); 
+	if (err)
+		return err;
+	if (copy_in_user(coldval, oldval, oldlen)) 
+		return -EFAULT; 
+	return put_user(oldlen, coldlenp); 
+}
+#endif
+
 /*
  * ctl_perm does NOT grant the superuser all rights automatically, because
  * some sysctl variables are readonly even to root.
@@ -895,6 +989,42 @@
 	return -ENOTDIR;
 }
 
+static int parse_table_name(char *name, 
+		       void __user *oldval, size_t __user *oldlenp,
+		       void __user *newval, size_t __user newlen,
+		       ctl_table *table, void **context)
+{
+	int error;
+	char *s;
+repeat:
+	s = strsep(&name, "./"); 
+	for ( ; table->procname; table++) {
+		if (strcmp(s, table->procname))
+			continue; 
+		if (table->child) {
+			if (ctl_perm(table, 001))
+				return -EPERM;
+			if (table->strategy) {
+				/* We don't bother passing name down. None of the 
+				   existing strategy functions use it. */ 
+				error = table->strategy(
+					table, NULL, 0,
+					oldval, oldlenp,
+					newval, newlen, context);
+				if (error)
+					return error; 
+			}
+			table = table->child;
+			goto repeat;
+		}
+		error = do_sysctl_strategy(table, NULL, 0, 
+					   oldval, oldlenp,
+					   newval, newlen, context);
+		return error;
+	}
+	return -ENOTDIR;
+}
+
 /* Perform the actual read/write of a sysctl table entry. */
 int do_sysctl_strategy (ctl_table *table, 
 			int __user *name, int nlen,
--- linux-2.5/include/asm-i386/unistd.h	2003-07-09 22:50:06.000000000 +0200
+++ linux-2.5-amd64/include/asm-i386/unistd.h	2003-07-10 13:10:05.000000000 +0200
@@ -276,8 +276,9 @@
 #define __NR_statfs64		268
 #define __NR_fstatfs64		269
 #define __NR_tgkill		270
+#define __NR_sysctl_name	271
 
-#define NR_syscalls 271
+#define NR_syscalls 272
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
--- linux-2.5/arch/i386/kernel/entry.S	2003-07-09 22:49:57.000000000 +0200
+++ linux-2.5-amd64/arch/i386/kernel/entry.S	2003-07-10 13:09:43.000000000 +0200
@@ -877,5 +877,6 @@
 	.long sys_statfs64
 	.long sys_fstatfs64	
 	.long sys_tgkill
- 
+	.long sys_sysctl_name
+	
 nr_syscalls=(.-sys_call_table)/4
