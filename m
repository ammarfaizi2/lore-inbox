Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314872AbSD2IVZ>; Mon, 29 Apr 2002 04:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSD2IVY>; Mon, 29 Apr 2002 04:21:24 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:13420 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314872AbSD2IVX>; Mon, 29 Apr 2002 04:21:23 -0400
Message-Id: <5.1.0.14.2.20020429085356.00b17820@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Apr 2002 09:22:04 +0100
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] module locking
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204290711.g3T7Bm217822@linux06.vertis.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three comments:

1) Unless I am missing something this is complete and utter nonsense! You 
are defining a proc_handler but not defining a strategy which means the 
kernel's automatic r/w will be used which means that I can just set your 
module_lock to zero using a sysctl() system call, thus defeating the whole 
point of your patch.

2) Even if you did add a strategy as to refuse changing the value from a 
sysctl() system call, as you say yourself, one can just set module_lock = 0 
by accessing /dev/kmem, which makes any form of this patch completely 
pointless. If the CAP_SYS_MODULE capability is not sufficient to stop you 
from loading modules then your module_lock won't help, either...

3) Check your numbers, I think at the bottom of the patch, that was 
supposed to be KERN_MODLOCK=55 and not =65.

Best regards,

Anton

At 08:11 29/04/02, Rolf Fokkens wrote:
>This patch adds the option op locking module operations, which
>means that no more insmod en rmmod operations are possible. This
>hopefully satisfies some security requirements that state that no
>modularized kernels should be used to be really safe in some
>environents.
>
>It can be used during boot (i.e. initrd) to load modules as needed
>and afterwards locking module operations, making it a little harder
>for hackers to tamper with kernel functionality... though changing
>kmem still allows some changes...
>
>It adds a /proc/sys/kernel/module-lock entry with default 0, which
>means that module operations aren't locked. This value can be
>changed to 1, which locks all module operations. Once the value is
>changed to 1 it cannot be changed back to 0.
>
>diff -ruN linux.orig/kernel/kmod.c linux/kernel/kmod.c
>--- linux.orig/kernel/kmod.c    Wed Jul 18 03:23:50 2001
>+++ linux/kernel/kmod.c Sat Apr 27 22:23:07 2002
>@@ -29,6 +29,7 @@
>  #include <asm/uaccess.h>
>
>  extern int max_threads;
>+extern int module_lock;
>
>  static inline void
>  use_init_fs_context(void)
>@@ -179,6 +180,8 @@
>         static atomic_t kmod_concurrent = ATOMIC_INIT(0);
>  #define MAX_KMOD_CONCURRENT 50 /* Completely arbitrary value - KAO */
>         static int kmod_loop_msg;
>+
>+       if ( module_lock ) return -EPERM;
>
>         /* Don't allow request_module() before the root fs is mounted!  */
>         if ( ! current->fs->root ) {
>diff -ruN linux.orig/kernel/module.c linux/kernel/module.c
>--- linux.orig/kernel/module.c  Sat Nov 24 02:05:28 2001
>+++ linux/kernel/module.c       Sat Apr 27 22:25:01 2002
>@@ -68,6 +68,11 @@
>  static int kmalloc_failed;
>
>  /*
>+ * This flag blocks any adding or removing of modules.
>+ */
>+int module_lock = 0;
>+
>+/*
>   *     This lock prevents modifications that might race the kernel fault
>   *     fixups. It does not prevent reader walks that the modules code
>   *     does. The kernel lock does that.
>@@ -296,7 +301,7 @@
>         struct module *mod;
>         unsigned long flags;
>
>-       if (!capable(CAP_SYS_MODULE))
>+       if (module_lock || !capable(CAP_SYS_MODULE))
>                 return -EPERM;
>         lock_kernel();
>         if ((namelen = get_mod_name(name_user, &name)) < 0) {
>@@ -351,7 +356,7 @@
>         unsigned long mod_user_size;
>         struct module_ref *dep;
>
>-       if (!capable(CAP_SYS_MODULE))
>+       if (module_lock || !capable(CAP_SYS_MODULE))
>                 return -EPERM;
>         lock_kernel();
>         if ((namelen = get_mod_name(name_user, &name)) < 0) {
>@@ -599,7 +604,7 @@
>         long error;
>         int something_changed;
>
>-       if (!capable(CAP_SYS_MODULE))
>+       if (module_lock || !capable(CAP_SYS_MODULE))
>                 return -EPERM;
>
>         lock_kernel();
>diff -ruN linux.orig/kernel/sysctl.c linux/kernel/sysctl.c
>--- linux.orig/kernel/sysctl.c  Sat Apr 27 22:44:10 2002
>+++ linux/kernel/sysctl.c       Sat Apr 27 22:44:16 2002
>@@ -49,9 +49,13 @@
>  extern atomic_t nr_queued_signals;
>  extern int max_queued_signals;
>  extern int sysrq_enabled;
>+extern int module_lock;
>  extern int core_uses_pid;
>  extern int cad_pid;
>
>+extern int proc_module_lock(ctl_table *table, int write, struct file *filp,
>+                            void *buffer, size_t *lenp);
>+
>  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and 
> GID */
>  static int maxolduid = 65535;
>  static int minolduid;
>@@ -209,6 +213,8 @@
>  #ifdef CONFIG_KMOD
>         {KERN_MODPROBE, "modprobe", &modprobe_path, 256,
>         0644, NULL, &proc_dostring, &sysctl_string },
>+       {KERN_MODLOCK, "module-lock", &module_lock, sizeof (int),
>+       0644, NULL, &proc_module_lock},
>  #endif
>  #ifdef CONFIG_HOTPLUG
>         {KERN_HOTPLUG, "hotplug", &hotplug_path, 256,
>@@ -998,6 +1004,23 @@
>  {
>      return do_proc_dointvec(table,write,filp,buffer,lenp,1,OP_SET);
>  }
>+
>+/*
>+ * Try to change the module-lock status. Once it's set it cannot
>+ * be cleared however!
>+ */
>+int proc_module_lock(ctl_table *table, int write, struct file *filp,
>+                       void *buffer, size_t *lenp)
>+{
>+       int retval, sav;
>+
>+       sav = module_lock;
>+       retval = do_proc_dointvec(table,write,filp,buffer,lenp,1,OP_SET);
>+       if (!retval) module_lock = (sav || module_lock);
>+
>+       return retval;
>+}
>+
>
>  /*
>   *     init may raise the set.
>diff -ruN linux.orig/include/linux/sysctl.h linux/include/linux/sysctl.h
>--- linux.orig/include/linux/sysctl.h   Sat Apr 27 22:44:10 2002
>+++ linux/include/linux/sysctl.h        Sat Apr 27 22:45:18 2002
>@@ -124,6 +124,7 @@
>         KERN_CORE_USES_PID=52,          /* int: use core or core.%pid */
>         KERN_TAINTED=53,        /* int: various kernel tainted flags */
>         KERN_CADPID=54,         /* int: PID of the process to notify on 
> CAD */
>+       KERN_MODLOCK=65,        /* module_lock value */
>  };
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

