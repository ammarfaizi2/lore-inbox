Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270366AbRHNEPM>; Tue, 14 Aug 2001 00:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269491AbRHNEOz>; Tue, 14 Aug 2001 00:14:55 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:5089 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S270373AbRHNEOm>;
	Tue, 14 Aug 2001 00:14:42 -0400
Message-ID: <3B78A5E2.AB763F8D@sun.com>
Date: Mon, 13 Aug 2001 21:15:30 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: groudier@club-internet.fr, torvalds@transmeta.com, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2 sym53c8xx patches
Content-Type: multipart/mixed;
 boundary="------------117D4D1420ACC1F39A4F3AD9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------117D4D1420ACC1F39A4F3AD9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Gerard,

A while back I sent you two diffs for the sym53c8xx driver, and you OK'ed
them, but I haven't seen them turn up in the mainline kernel yet.

I've attached the same patches, against 2.4.8 here.  

Let me know if there is any reason NOT to include these.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------117D4D1420ACC1F39A4F3AD9
Content-Type: text/plain; charset=us-ascii;
 name="sym_timer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym_timer.diff"

diff -ruN dist+patches-2.4.8/drivers/scsi/sym53c8xx.c cobalt-2.4.8/drivers/scsi/sym53c8xx.c
--- dist+patches-2.4.8/drivers/scsi/sym53c8xx.c	Thu Jul  5 11:28:16 2001
+++ cobalt-2.4.8/drivers/scsi/sym53c8xx.c	Mon Aug 13 16:42:25 2001
@@ -2252,7 +2268,6 @@
 	**----------------------------------------------------------------
 	*/
 	struct usrcmd	user;		/* Command from user		*/
-	volatile u_char	release_stage;	/* Synchronisation stage on release  */
 
 	/*----------------------------------------------------------------
 	**	Fields that are used (primarily) for integrity check
@@ -5871,7 +5886,12 @@
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
@@ -7234,23 +7254,14 @@
 **==========================================================
 */
 
-#ifdef MODULE
 static int ncr_detach(ncb_p np)
 {
-	int i;
-
 	printk("%s: detaching ...\n", ncr_name(np));
 
 /*
 **	Stop the ncr_timeout process
-**	Set release_stage to 1 and wait that ncr_timeout() set it to 2.
 */
-	np->release_stage = 1;
-	for (i = 50 ; i && np->release_stage != 2 ; i--) MDELAY (100);
-	if (np->release_stage != 2)
-		printk("%s: the timer seems to be already stopped\n",
-			ncr_name(np));
-	else np->release_stage = 2;
+	del_timer_sync(&np->timer);
 
 /*
 **	Reset NCR chip.
@@ -7280,7 +7291,6 @@
 
 	return 1;
 }
-#endif
 
 /*==========================================================
 **
@@ -8607,23 +8617,11 @@
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

--------------117D4D1420ACC1F39A4F3AD9
Content-Type: text/plain; charset=us-ascii;
 name="sym_reboot_and_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym_reboot_and_cleanup.diff"

diff -ruN dist+patches-2.4.8/drivers/scsi/sym53c8xx.c cobalt-2.4.8/drivers/scsi/sym53c8xx.c
--- dist+patches-2.4.8/drivers/scsi/sym53c8xx.c	Thu Jul  5 11:28:16 2001
+++ cobalt-2.4.8/drivers/scsi/sym53c8xx.c	Mon Aug 13 16:42:25 2001
@@ -113,6 +113,8 @@
 #elif LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 #include <asm/spinlock.h>
 #endif
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -637,8 +639,11 @@
 #if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 
 spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t sym53c8xx_host_lock = SPIN_LOCK_UNLOCKED;
 #define	NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
 #define	NCR_UNLOCK_DRIVER(flags)   spin_unlock_irqrestore(&sym53c8xx_lock,flags)
+#define	NCR_LOCK_HOSTS(flags)     spin_lock_irqsave(&sym53c8xx_host_lock, flags)
+#define	NCR_UNLOCK_HOSTS(flags)   spin_unlock_irqrestore(&sym53c8xx_host_lock,flags)
 
 #define NCR_INIT_LOCK_NCB(np)      spin_lock_init(&np->smp_lock);
 #define	NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
@@ -653,6 +658,8 @@
 
 #define	NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
 #define	NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
+#define	NCR_LOCK_HOSTS(flags)     do { save_flags(flags); cli(); } while (0)
+#define	NCR_UNLOCK_HOSTS(flags)   do { restore_flags(flags); } while (0)
 
 #define	NCR_INIT_LOCK_NCB(np)      do { } while (0)
 #define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
@@ -698,7 +705,7 @@
 	return page_remapped? (page_remapped + page_offs) : 0UL;
 }
 
-static void __init unmap_pci_mem(u_long vaddr, u_long size)
+static void unmap_pci_mem(u_long vaddr, u_long size)
 {
 	if (vaddr)
 		iounmap((void *) (vaddr & PAGE_MASK));
@@ -1304,6 +1311,15 @@
 			int length, int hostno, int func);
 #endif
 
+/* 
+** reset the scsi controller on a "reboot." it should be way at the
+** end.
+*/
+static int sym53c8xx_halt(struct notifier_block *, ulong, void *);
+static struct notifier_block sym53c8xx_notifier = {
+  sym53c8xx_halt, NULL, 0
+};
+
 /*
 **	Driver setup.
 **
@@ -12300,6 +12298,13 @@
 	ncr_rd  = INL (nc_scratcha);
 	ncr_bk  = INL (nc_temp);
 	/*
+	**	check for timeout
+	*/
+	if (i>=NCR_SNOOP_TIMEOUT) {
+		printk ("CACHE TEST FAILED: timeout.\n");
+		return (0x20);
+	};
+	/*
 	**	Check termination position.
 	*/
 	if (pc != NCB_SCRIPTH0_PHYS (np, snoopend)+8) {
@@ -13072,7 +13077,8 @@
 	}
 
 	m_free(devtbl, PAGE_SIZE, "devtbl");
-
+	if (attach_count)
+ 	          register_reboot_notifier(&sym53c8xx_notifier);
 	return attach_count;
 }
 
@@ -13804,19 +13810,49 @@
 }
 
 
+static int sym53c8xx_halt(struct notifier_block *block, ulong event, void *buf)
+{
+	unsigned long flags;
+	struct Scsi_Host *host, *next;
+
+	switch (event) {
+	case SYS_RESTART:
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	printk(KERN_INFO "resetting sym53c8xx scsi bus(es)\n");
+	NCR_LOCK_HOSTS(flags);
+	next = first_host;
+	while ((host = next)) {
+		struct host_data *data = (struct host_data *)host->hostdata;
+
+		next = host->next;	
+		if (data && data->ncb)
+			ncr_detach(data->ncb);
+	}
+	NCR_UNLOCK_HOSTS(flags);
+
+	return NOTIFY_OK;
+}
+
 #ifdef MODULE
 int sym53c8xx_release(struct Scsi_Host *host)
 {
 #ifdef DEBUG_SYM53C8XX
 printk("sym53c8xx : release\n");
 #endif
+     if (first_host)
+	unregister_reboot_notifier(&sym53c8xx_notifier);
      ncr_detach(((struct host_data *) host->hostdata)->ncb);
 
      return 1;
 }
 #endif
 
-
 /*
 **	Scsi command waiting list management.
 **
@@ -14211,13 +14247,15 @@
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
@@ -14229,25 +14267,22 @@
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
 

--------------117D4D1420ACC1F39A4F3AD9--

