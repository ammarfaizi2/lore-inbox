Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279053AbRJ2Gvt>; Mon, 29 Oct 2001 01:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279058AbRJ2Gvj>; Mon, 29 Oct 2001 01:51:39 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:45006 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S279053AbRJ2Gvc>; Mon, 29 Oct 2001 01:51:32 -0500
Date: Mon, 29 Oct 2001 01:52:10 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Patch to make 2.4.13 compile on s390
Message-ID: <20011029015210.A10144@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone broke s390 and s390x, it did not even compile.
Do we actually have a maintainer for that thing?
Or do we blindly apply whatever IBM bestows?

MAINTAINERS lists some e-mails and lists for s390, but I did
not receive any replies from those people. Must have
been eaten by evil Lotus or something...

-- Pete

diff -ur -X dontdiff linux-2.4.13-0.2/Makefile linux-2.4.13-0.2-t1/Makefile
--- linux-2.4.13-0.2/Makefile	Mon Oct 29 04:28:50 2001
+++ linux-2.4.13-0.2-t1/Makefile	Mon Oct 29 05:00:08 2001
diff -ur -X dontdiff linux-2.4.13-0.2/arch/s390/config.in linux-2.4.13-0.2-t1/arch/s390/config.in
--- linux-2.4.13-0.2/arch/s390/config.in	Mon Oct 29 04:28:40 2001
+++ linux-2.4.13-0.2-t1/arch/s390/config.in	Mon Oct 29 06:22:48 2001
@@ -10,6 +10,7 @@
 define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 define_bool CONFIG_GENERIC_BUST_SPINLOCK n
+define_bool CONFIG_GENERIC_ISA_DMA y
 
 mainmenu_name "Linux Kernel Configuration"
 define_bool CONFIG_ARCH_S390 y
diff -ur -X dontdiff linux-2.4.13-0.2/arch/s390/mm/fault.c linux-2.4.13-0.2-t1/arch/s390/mm/fault.c
--- linux-2.4.13-0.2/arch/s390/mm/fault.c	Thu Oct 11 18:04:57 2001
+++ linux-2.4.13-0.2-t1/arch/s390/mm/fault.c	Mon Oct 29 07:19:03 2001
@@ -30,6 +30,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/hardirq.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_userprocess_debug;
@@ -38,7 +39,9 @@
 extern void die(const char *,struct pt_regs *,long);
 static void force_sigsegv(struct task_struct *tsk, int code, void *address);
 
+#if 0  /* #ifdef CONFIG_HWC_CONSOLE */	/* Ask IBM to fix XXX */
 extern spinlock_t timerlist_lock;
+#endif
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
@@ -47,13 +50,18 @@
  */
 void bust_spinlocks(int yes)
 {
-	spin_lock_init(&timerlist_lock);
+#if 0  /* #ifdef CONFIG_HWC_CONSOLE */	/* Ask IBM to fix XXX */
+	spin_lock_init(&timerlist_lock);	/* Does not link... */
+#endif
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
 		int loglevel_save = console_loglevel;
 		oops_in_progress = 0;
-		console_unblank();
+#ifdef CONFIG_HWC_CONSOLE
+		if (CONSOLE_IS_HWC)
+			hwc_console_unblank();
+#endif
 		/*
 		 * OK, the message is on the console.  Now we call printk()
 		 * without oops_in_progress set so that printk will give klogd
diff -ur -X dontdiff linux-2.4.13-0.2/fs/partitions/ibm.c linux-2.4.13-0.2-t1/fs/partitions/ibm.c
--- linux-2.4.13-0.2/fs/partitions/ibm.c	Tue Oct  2 05:03:26 2001
+++ linux-2.4.13-0.2-t1/fs/partitions/ibm.c	Mon Oct 29 05:48:53 2001
@@ -123,7 +123,7 @@
 					    GFP_KERNEL);
 	if ( geo == NULL )
 		return 0;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
+	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo))
 		return 0;
 	blocksize = hardsect_size[MAJOR(dev)][MINOR(dev)];
 	if ( blocksize <= 0 ) {
@@ -131,7 +131,7 @@
 	}
 	blocksize >>= 9;
 	
-	data = read_dev_sector(bdev, inode->label_block*blocksize, &sect);
+	data = read_dev_sector(bdev, info->label_block*blocksize, &sect);
 	if (!data)
 		return 0;
 
