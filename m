Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265119AbSJPABY>; Tue, 15 Oct 2002 20:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265120AbSJPABY>; Tue, 15 Oct 2002 20:01:24 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53769 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265119AbSJPABK>;
	Tue, 15 Oct 2002 20:01:10 -0400
Date: Tue, 15 Oct 2002 17:07:06 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: becker@scyld.com, jmorris@intercode.com.au, kuznet@ms2.inr.ac.ru,
       netdev@oss.sgi.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: [RFC] change format of LSM hooks
Message-ID: <20021016000706.GI16966@kroah.com>
References: <20021015194545.GC15864@kroah.com> <20021015.124502.130514745.davem@redhat.com> <20021015201209.GE15864@kroah.com> <20021015.131037.96602290.davem@redhat.com> <20021015202828.GG15864@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015202828.GG15864@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 01:28:28PM -0700, Greg KH wrote:
> On Tue, Oct 15, 2002 at 01:10:37PM -0700, David S. Miller wrote:
> > 
> > I will not even look at the networking LSM bits until
> > CONFIG_SECURITY=n is available.
> 
> Good enough reason for me, I'll start working on this.  Help from the
> other LSM developers is appreciated :)

Ok, this wasn't that tough...

Here's a first cut at what will need to be changed.  It's a patch
against Linus's latest BK tree.  I only converted one hook (the ptrace
one), and this will not link, but will build and gives people an idea of
where I'm heading.

David, does something like this look acceptable?

With it, and CONFIG_SECURITY=n the size of the security/*.o files are
now:
   text    data     bss     dec     hex filename
    138       0       0     138      8a security/built-in.o

which I hope are a bit more to your liking :)
I still need an empty sys_security stub in order to link properly,
that's the only function needed.  The extra #includes are needed as
some files were getting security.h picked up from shed.h in the past.

I'll work on fixing up the rest of the hooks, and removing the external
reference to security_ops, and actually test this thing, later this
evening.

thanks,

greg k-h

diff -Naur -X ../dontdiff bleeding_edge-2.5/arch/i386/kernel/ptrace.c lsm-2.5/arch/i386/kernel/ptrace.c
--- bleeding_edge-2.5/arch/i386/kernel/ptrace.c	Tue Oct 15 16:47:14 2002
+++ lsm-2.5/arch/i386/kernel/ptrace.c	Tue Oct 15 16:41:44 2002
@@ -160,8 +160,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
diff -Naur -X ../dontdiff bleeding_edge-2.5/drivers/base/fs/class.c lsm-2.5/drivers/base/fs/class.c
--- bleeding_edge-2.5/drivers/base/fs/class.c	Tue Oct 15 16:47:37 2002
+++ lsm-2.5/drivers/base/fs/class.c	Tue Oct 15 16:13:11 2002
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/stat.h>
 #include "fs.h"
 
 static struct driver_dir_entry class_dir;
diff -Naur -X ../dontdiff bleeding_edge-2.5/drivers/base/fs/intf.c lsm-2.5/drivers/base/fs/intf.c
--- bleeding_edge-2.5/drivers/base/fs/intf.c	Tue Oct 15 16:47:37 2002
+++ lsm-2.5/drivers/base/fs/intf.c	Tue Oct 15 16:14:27 2002
@@ -4,6 +4,8 @@
 
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/limits.h>
+#include <linux/errno.h>
 #include "fs.h"
 
 /**
diff -Naur -X ../dontdiff bleeding_edge-2.5/fs/exec.c lsm-2.5/fs/exec.c
--- bleeding_edge-2.5/fs/exec.c	Tue Oct 15 16:48:19 2002
+++ lsm-2.5/fs/exec.c	Tue Oct 15 16:09:05 2002
@@ -43,6 +43,7 @@
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
diff -Naur -X ../dontdiff bleeding_edge-2.5/fs/locks.c lsm-2.5/fs/locks.c
--- bleeding_edge-2.5/fs/locks.c	Tue Oct 15 16:48:19 2002
+++ lsm-2.5/fs/locks.c	Tue Oct 15 16:10:52 2002
@@ -122,6 +122,7 @@
 #include <linux/timer.h>
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
diff -Naur -X ../dontdiff bleeding_edge-2.5/fs/namespace.c lsm-2.5/fs/namespace.c
--- bleeding_edge-2.5/fs/namespace.c	Tue Oct 15 16:48:19 2002
+++ lsm-2.5/fs/namespace.c	Tue Oct 15 16:12:00 2002
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
diff -Naur -X ../dontdiff bleeding_edge-2.5/fs/proc/base.c lsm-2.5/fs/proc/base.c
--- bleeding_edge-2.5/fs/proc/base.c	Tue Oct 15 16:48:26 2002
+++ lsm-2.5/fs/proc/base.c	Tue Oct 15 16:21:45 2002
@@ -28,6 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
diff -Naur -X ../dontdiff bleeding_edge-2.5/fs/readdir.c lsm-2.5/fs/readdir.c
--- bleeding_edge-2.5/fs/readdir.c	Tue Oct 15 16:48:19 2002
+++ lsm-2.5/fs/readdir.c	Tue Oct 15 16:09:51 2002
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
diff -Naur -X ../dontdiff bleeding_edge-2.5/fs/xattr.c lsm-2.5/fs/xattr.c
--- bleeding_edge-2.5/fs/xattr.c	Tue Oct 15 16:48:19 2002
+++ lsm-2.5/fs/xattr.c	Tue Oct 15 16:13:59 2002
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/xattr.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 /*
diff -Naur -X ../dontdiff bleeding_edge-2.5/include/linux/sched.h lsm-2.5/include/linux/sched.h
--- bleeding_edge-2.5/include/linux/sched.h	Tue Oct 15 16:48:49 2002
+++ lsm-2.5/include/linux/sched.h	Tue Oct 15 15:59:24 2002
@@ -600,9 +600,11 @@
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
+
+#ifdef CONFIG_SECURITY
 /* capable prototype and code moved to security.[hc] */
 #include <linux/security.h>
-#if 0
+#else
 static inline int capable(int cap)
 {
 	if (cap_raised(current->cap_effective, cap)) {
@@ -611,7 +613,7 @@
 	}
 	return 0;
 }
-#endif	/* if 0 */
+#endif
 
 /*
  * Routines for handling mm_structs
diff -Naur -X ../dontdiff bleeding_edge-2.5/include/linux/security.h lsm-2.5/include/linux/security.h
--- bleeding_edge-2.5/include/linux/security.h	Wed Oct  9 08:51:48 2002
+++ lsm-2.5/include/linux/security.h	Tue Oct 15 16:40:09 2002
@@ -22,8 +22,6 @@
 #ifndef __LINUX_SECURITY_H
 #define __LINUX_SECURITY_H
 
-#ifdef __KERNEL__
-
 #include <linux/fs.h>
 #include <linux/binfmts.h>
 #include <linux/signal.h>
@@ -33,6 +31,7 @@
 #include <linux/shm.h>
 #include <linux/msg.h>
 
+
 /*
  * Values used in the task_security_ops calls
  */
@@ -848,6 +847,16 @@
 	                            struct security_operations *ops);
 };
 
+#ifdef CONFIG_SECURITY
+
+/* global variables */
+extern struct security_operations *security_ops;
+
+/* inline stuff */
+static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
+{
+	return security_ops->ptrace (parent, child);
+}
 
 /* prototypes */
 extern int security_scaffolding_startup	(void);
@@ -857,11 +866,17 @@
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
 extern int capable		(int cap);
 
-/* global variables */
+
+#endif /* CONFIG_SECURITY */
+
+static inline int security_scaffolding_startup (void) { return 0; }
 extern struct security_operations *security_ops;
 
+static inline int security_ptrace (struct task_struct *parent, struct task_struct * child)
+{
+	return 0;
+}
 
-#endif /* __KERNEL__ */
 
 #endif /* ! __LINUX_SECURITY_H */
 
diff -Naur -X ../dontdiff bleeding_edge-2.5/init/do_mounts.c lsm-2.5/init/do_mounts.c
--- bleeding_edge-2.5/init/do_mounts.c	Mon Oct  7 13:46:56 2002
+++ lsm-2.5/init/do_mounts.c	Tue Oct 15 16:05:18 2002
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
+#include <linux/security.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
diff -Naur -X ../dontdiff bleeding_edge-2.5/kernel/capability.c lsm-2.5/kernel/capability.c
--- bleeding_edge-2.5/kernel/capability.c	Tue Oct 15 16:48:52 2002
+++ lsm-2.5/kernel/capability.c	Tue Oct 15 16:08:08 2002
@@ -8,6 +8,7 @@
  */ 
 
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
diff -Naur -X ../dontdiff bleeding_edge-2.5/kernel/kmod.c lsm-2.5/kernel/kmod.c
--- bleeding_edge-2.5/kernel/kmod.c	Tue Oct 15 16:48:52 2002
+++ lsm-2.5/kernel/kmod.c	Tue Oct 15 16:10:50 2002
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/file.h>
 #include <linux/workqueue.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
diff -Naur -X ../dontdiff bleeding_edge-2.5/kernel/ptrace.c lsm-2.5/kernel/ptrace.c
--- bleeding_edge-2.5/kernel/ptrace.c	Tue Oct 15 16:48:52 2002
+++ lsm-2.5/kernel/ptrace.c	Tue Oct 15 16:09:07 2002
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff -Naur -X ../dontdiff bleeding_edge-2.5/kernel/signal.c lsm-2.5/kernel/signal.c
--- bleeding_edge-2.5/kernel/signal.c	Tue Oct 15 16:48:52 2002
+++ lsm-2.5/kernel/signal.c	Tue Oct 15 16:09:55 2002
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/security.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
diff -Naur -X ../dontdiff bleeding_edge-2.5/security/Config.in lsm-2.5/security/Config.in
--- bleeding_edge-2.5/security/Config.in	Tue Oct 15 16:49:00 2002
+++ lsm-2.5/security/Config.in	Tue Oct 15 15:41:13 2002
@@ -3,5 +3,8 @@
 #
 mainmenu_option next_comment
 comment 'Security options'
-define_bool CONFIG_SECURITY_CAPABILITIES y
+bool 'Enable different security models' CONFIG_SECURITY
+if [ "$CONFIG_SECURITY" = "y" ]; then
+   dep_tristate '  Default Linux Capabilities' CONFIG_SECURITY_CAPABILITIES $CONFIG_SECURITY
+fi
 endmenu
diff -Naur -X ../dontdiff bleeding_edge-2.5/security/Makefile lsm-2.5/security/Makefile
--- bleeding_edge-2.5/security/Makefile	Tue Oct 15 16:49:00 2002
+++ lsm-2.5/security/Makefile	Tue Oct 15 16:34:21 2002
@@ -6,8 +6,8 @@
 export-objs	:= security.o
 
 # Object file lists
-obj-y		:= security.o dummy.o
-
+obj-y					+= sys_security.o
+obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
 
 include $(TOPDIR)/Rules.make
diff -Naur -X ../dontdiff bleeding_edge-2.5/security/sys_security.c lsm-2.5/security/sys_security.c
--- bleeding_edge-2.5/security/sys_security.c	Wed Dec 31 16:00:00 1969
+++ lsm-2.5/security/sys_security.c	Tue Oct 15 16:34:03 2002
@@ -0,0 +1,45 @@
+/*
+ * Security plug functions
+ *
+ * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
+ * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/security.h>
+
+/**
+ * sys_security - security syscall multiplexor.
+ * @id: module id
+ * @call: call identifier
+ * @args: arg list for call
+ *
+ * Similar to sys_socketcall.  Can use id to help identify which module user
+ * app is talking to.  The recommended convention for creating the
+ * hexadecimal id value is:
+ * 'echo "Name_of_module" | md5sum | cut -c -8'.
+ * By following this convention, there's no need for a central registry.
+ */
+#ifdef CONFIG_SECURITY
+asmlinkage long sys_security (unsigned int id, unsigned int call,
+			      unsigned long *args)
+{
+	return security_ops->sys_security (id, call, args);
+}
+#else
+asmlinkage long sys_security (unsigned int id, unsigned int call,
+			      unsigned long *args)
+{
+	return -ENOSYS;
+}
+#endif
+
