Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRJQCHY>; Tue, 16 Oct 2001 22:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJQCHP>; Tue, 16 Oct 2001 22:07:15 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:5516 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S273902AbRJQCHC>;
	Tue, 16 Oct 2001 22:07:02 -0400
Message-ID: <3BCCE721.8A72910E@sun.com>
Date: Tue, 16 Oct 2001 19:04:17 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: groudier@club-internet.fr, alan@redhat.com, torvalds@transmeta.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] resubmitting sym53c8xx patches
Content-Type: multipart/mixed;
 boundary="------------3B2BA453D4E881480368170B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3B2BA453D4E881480368170B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

I've submitted this patch a few times, and had it OKed each time, but it
hasn't made it in.

it does:
* cleanup timer handling
* spin lock host list
* adds a reboot handler
* remove __init from a function called from a non __init (needed for reboot
handler)


Please apply this for the next 2.4.x.

Appreciated!

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------3B2BA453D4E881480368170B
Content-Type: text/plain; charset=us-ascii;
 name="sym53c8xx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym53c8xx.diff"

diff -ruN dist-2.4.12+patches/drivers/scsi/sym53c8xx.c cvs-2.4.12+patches/drivers/scsi/sym53c8xx.c
--- dist-2.4.12+patches/drivers/scsi/sym53c8xx.c	Mon Oct 15 10:22:43 2001
+++ cvs-2.4.12+patches/drivers/scsi/sym53c8xx.c	Mon Oct 15 10:22:42 2001
@@ -111,6 +111,8 @@
 #elif LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 #include <asm/spinlock.h>
 #endif
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -635,8 +637,11 @@
 #if LINUX_VERSION_CODE >= LinuxVersionCode(2,1,93)
 
 spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t sym53c8xx_host_lock = SPIN_LOCK_UNLOCKED;
 #define	NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
 #define	NCR_UNLOCK_DRIVER(flags)   spin_unlock_irqrestore(&sym53c8xx_lock,flags)
+#define	NCR_LOCK_HOSTS(flags)     spin_lock_irqsave(&sym53c8xx_host_lock, flags)
+#define	NCR_UNLOCK_HOSTS(flags)   spin_unlock_irqrestore(&sym53c8xx_host_lock,flags)
 
 #define NCR_INIT_LOCK_NCB(np)      spin_lock_init(&np->smp_lock);
 #define	NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
@@ -651,6 +656,8 @@
 
 #define	NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
 #define	NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
+#define	NCR_LOCK_HOSTS(flags)     do { save_flags(flags); cli(); } while (0)
+#define	NCR_UNLOCK_HOSTS(flags)   do { restore_flags(flags); } while (0)
 
 #define	NCR_INIT_LOCK_NCB(np)      do { } while (0)
 #define	NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
@@ -696,7 +703,7 @@
 	return page_remapped? (page_remapped + page_offs) : 0UL;
 }
 
-static void __init unmap_pci_mem(u_long vaddr, u_long size)
+static void unmap_pci_mem(u_long vaddr, u_long size)
 {
 	if (vaddr)
 		iounmap((void *) (vaddr & PAGE_MASK));
@@ -1302,6 +1309,15 @@
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
@@ -2250,7 +2266,6 @@
 	**----------------------------------------------------------------
 	*/
 	struct usrcmd	user;		/* Command from user		*/
-	volatile u_char	release_stage;	/* Synchronisation stage on release  */
 
 	/*----------------------------------------------------------------
 	**	Fields that are used (primarily) for integrity check
@@ -5869,7 +5884,12 @@
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
@@ -7232,23 +7252,14 @@
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
@@ -7278,7 +7289,6 @@
 
 	return 1;
 }
-#endif
 
 /*==========================================================
 **
@@ -8605,23 +8615,11 @@
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
@@ -13070,7 +13075,8 @@
 	}
 
 	m_free(devtbl, PAGE_SIZE, "devtbl");
-
+	if (attach_count)
+ 	          register_reboot_notifier(&sym53c8xx_notifier);
 	return attach_count;
 }
 
@@ -13802,19 +13808,49 @@
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
@@ -14209,13 +14245,15 @@
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
@@ -14227,25 +14265,22 @@
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
+proc_done:
+	NCR_UNLOCK_HOSTS(flags);
 
 	return retv;
 }
 

--------------3B2BA453D4E881480368170B--

