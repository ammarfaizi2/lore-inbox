Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbRFABYf>; Thu, 31 May 2001 21:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbRFABYZ>; Thu, 31 May 2001 21:24:25 -0400
Received: from patan.Sun.COM ([192.18.98.43]:21164 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263298AbRFABYU>;
	Thu, 31 May 2001 21:24:20 -0400
Message-ID: <3B16EF26.2F44BE3F@sun.com>
Date: Thu, 31 May 2001 18:25:58 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: groudier@club-internet.fr
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: [PATCH] sym53c8xx timer and smp fixes
Content-Type: multipart/mixed;
 boundary="------------E03F44A0EB21B0FBB2CCAB81"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E03F44A0EB21B0FBB2CCAB81
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a patch for sym53c8xx.c to handle the error timer better, and
be more proper for SMP.  The changes are very simple, and have been beaten
on by us.  Please let me know if there are any problems accepting this
patch for general inclusion.

Tim 
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------E03F44A0EB21B0FBB2CCAB81
Content-Type: text/plain; charset=us-ascii;
 name="sym53c8xx-timer,smp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym53c8xx-timer,smp.diff"

diff -ruN dist-2.4.5/drivers/scsi/sym53c8xx.c cobalt-2.4.5/drivers/scsi/sym53c8xx.c
--- dist-2.4.5/drivers/scsi/sym53c8xx.c	Fri Apr 27 13:59:19 2001
+++ cobalt-2.4.5/drivers/scsi/sym53c8xx.c	Thu May 31 14:32:43 2001
@@ -634,8 +636,11 @@
 #if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 
 spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t sym53c8xx_host_lock = SPIN_LOCK_UNLOCKED;
 #define	NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
 #define	NCR_UNLOCK_DRIVER(flags)   spin_unlock_irqrestore(&sym53c8xx_lock,flags)
+#define	NCR_LOCK_HOSTS(flags)     spin_lock_irqsave(&sym53c8xx_host_lock, flags)
+#define	NCR_UNLOCK_HOSTS(flags)   spin_unlock_irqrestore(&sym53c8xx_host_lock,flags)
 
 #define NCR_INIT_LOCK_NCB(np)      spin_lock_init(&np->smp_lock);
 #define	NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
@@ -650,6 +655,8 @@
 
 #define	NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
 #define	NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
+#define	NCR_LOCK_HOSTS(flags)     do { save_flags(flags); cli(); } while (0)
+#define	NCR_UNLOCK_HOSTS(flags)   do { restore_flags(flags); } while (0)
 
 #define	NCR_INIT_LOCK_NCB(np)      do { } while (0)
 #define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
@@ -695,7 +702,7 @@
 	return page_remapped? (page_remapped + page_offs) : 0UL;
 }
 
-static void __init unmap_pci_mem(u_long vaddr, u_long size)
+static void unmap_pci_mem(u_long vaddr, u_long size)
 {
 	if (vaddr)
 		iounmap((void *) (vaddr & PAGE_MASK));
@@ -2249,7 +2265,6 @@
 	**----------------------------------------------------------------
 	*/
 	struct usrcmd	user;		/* Command from user		*/
-	volatile u_char	release_stage;	/* Synchronisation stage on release  */
 
 	/*----------------------------------------------------------------
 	**	Fields that are used (primarily) for integrity check
@@ -5868,7 +5883,12 @@
 	**	start the timeout daemon
 	*/
 	np->lasttime=0;
-	ncr_timeout (np);
+#ifdef SCSI_NCR_PCIQ_BROKEN_INTR
+	np->timer.expires = ktime_get((HZ+9)/10);
+#else
+	np->timer.expires = ktime_get(SCSI_NCR_TIMER_INTERVAL);
+#endif
+	add_timer(&np->timer);
 
 	/*
 	**  use SIMPLE TAG messages by default
@@ -7227,23 +7247,19 @@
 **==========================================================
 */
 
-#ifdef MODULE
 static int ncr_detach(ncb_p np)
 {
-	int i;
+	unsigned long flags;
 
 	printk("%s: detaching ...\n", ncr_name(np));
 
 /*
-**	Stop the ncr_timeout process
-**	Set release_stage to 1 and wait that ncr_timeout() set it to 2.
+**	Stop the ncr_timeout process - lock it to ensure no timer is running
+**	on a different CPU, or anything
 */
-	np->release_stage = 1;
-	for (i = 50 ; i && np->release_stage != 2 ; i--) MDELAY (100);
-	if (np->release_stage != 2)
-		printk("%s: the timer seems to be already stopped\n",
-			ncr_name(np));
-	else np->release_stage = 2;
+	NCR_LOCK_NCB(np, flags);
+	del_timer(&np->timer);
+	NCR_UNLOCK_NCB(np, flags);
 
 /*
 **	Reset NCR chip.
@@ -7273,7 +7289,6 @@
 
 	return 1;
 }
-#endif
 
 /*==========================================================
 **
@@ -8600,23 +8615,11 @@
 {
 	u_long	thistime = ktime_get(0);
 
-	/*
-	**	If release process in progress, let's go
-	**	Set the release stage from 1 to 2 to synchronize
-	**	with the release process.
-	*/
-
-	if (np->release_stage) {
-		if (np->release_stage == 1) np->release_stage = 2;
-		return;
-	}
-
 #ifdef SCSI_NCR_PCIQ_BROKEN_INTR
-	np->timer.expires = ktime_get((HZ+9)/10);
+	mod_timer(&np->timer, ktime_get((HZ+9)/10));
 #else
-	np->timer.expires = ktime_get(SCSI_NCR_TIMER_INTERVAL);
+	mod_timer(&np->timer, ktime_get(SCSI_NCR_TIMER_INTERVAL));
 #endif
-	add_timer(&np->timer);
 
 	/*
 	**	If we are resetting the ncr, wait for settle_time before 
@@ -13071,7 +13075,7 @@
 		(int) (PciDeviceFn(pdev) & 7));
 
 #ifdef SCSI_NCR_DYNAMIC_DMA_MAPPING
-	if (pci_set_dma_mask(pdev, (dma_addr_t) (0xffffffffUL))) {
+	if (!pci_dma_supported(pdev, (dma_addr_t) (0xffffffffUL))) {
 		printk(KERN_WARNING NAME53C8XX
 		       "32 BIT PCI BUS DMA ADDRESSING NOT SUPPORTED\n");
 		return -1;
@@ -14181,13 +14215,15 @@
 {
 	struct Scsi_Host *host;
 	struct host_data *host_data;
+	unsigned long flags;
 	ncb_p ncb = 0;
-	int retv;
+	int retv = -EINVAL;
 
 #ifdef DEBUG_PROC_INFO
 printk("sym53c8xx_proc_info: hostno=%d, func=%d\n", hostno, func);
 #endif
 
+	NCR_LOCK_HOSTS(flags);
 	for (host = first_host; host; host = host->next) {
 		if (host->hostt != first_host->hostt)
 			continue;
@@ -14199,25 +14235,22 @@
 	}
 
 	if (!ncb)
-		return -EINVAL;
+		goto proc_done;
 
 	if (func) {
 #ifdef	SCSI_NCR_USER_COMMAND_SUPPORT
 		retv = ncr_user_command(ncb, buffer, length);
-#else
-		retv = -EINVAL;
 #endif
-	}
-	else {
+	} else {
 		if (start)
 			*start = buffer;
 #ifdef SCSI_NCR_USER_INFO_SUPPORT
 		retv = ncr_host_info(ncb, buffer, offset, length);
-#else
-		retv = -EINVAL;
 #endif
 	}
+	NCR_UNLOCK_HOSTS(flags);
 
+proc_done:
 	return retv;
 }
 

--------------E03F44A0EB21B0FBB2CCAB81--

