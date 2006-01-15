Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWAOEKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWAOEKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWAOEKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:10:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:62899 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751857AbWAOEKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:10:42 -0500
Date: Sun, 15 Jan 2006 05:10:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: [patch 2.6.15-mm4] undo cdu31a.c mutex conversion
Message-ID: <20060115041057.GA23127@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

undo cdu31a.c mutex conversion - handle_abort_timeout() is used from an 
interrupt context.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/cdrom/cdu31a.c |   51 ++++++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 26 deletions(-)

Index: linux-2.6.15-mm4.q/drivers/cdrom/cdu31a.c
===================================================================
--- linux-2.6.15-mm4.q.orig/drivers/cdrom/cdu31a.c
+++ linux-2.6.15-mm4.q/drivers/cdrom/cdu31a.c
@@ -177,7 +177,6 @@
 
 #define MAJOR_NR CDU31A_CDROM_MAJOR
 #include <linux/blkdev.h>
-#include <linux/mutex.h>
 
 #define CDU31A_MAX_CONSECUTIVE_ATTENTIONS 10
 
@@ -265,7 +264,7 @@ static int sony_toc_read = 0;	/* Has the
 static struct s_sony_subcode last_sony_subcode;	/* Points to the last
 						   subcode address read */
 
-static DEFINE_MUTEX(sony_mutex);		/* Semaphore for drive hardware access */
+static DECLARE_MUTEX(sony_sem);		/* Semaphore for drive hardware access */
 
 static int is_double_speed = 0;	/* does the drive support double speed ? */
 
@@ -341,11 +340,11 @@ static int scd_drive_status(struct cdrom
 		return -EINVAL;
 	if (sony_spun_up)
 		return CDS_DISC_OK;
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	if (scd_spinup() == 0)
 		sony_spun_up = 1;
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	return sony_spun_up ? CDS_DISC_OK : CDS_DRIVE_NOT_READY;
 }
 
@@ -454,7 +453,7 @@ static int scd_reset(struct cdrom_device
 {
 	unsigned long retry_count;
 
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	reset_drive();
 
@@ -463,7 +462,7 @@ static int scd_reset(struct cdrom_device
 		sony_sleep();
 	}
 
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	return 0;
 }
 
@@ -657,10 +656,10 @@ static int scd_select_speed(struct cdrom
 	else
 		sony_speed = speed - 1;
 
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	set_drive_params(sony_speed);
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	return 0;
 }
 
@@ -675,10 +674,10 @@ static int scd_lock_door(struct cdrom_de
 	} else {
 		is_auto_eject = 0;
 	}
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	set_drive_params(sony_speed);
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	return 0;
 }
 
@@ -1145,7 +1144,7 @@ static void handle_abort_timeout(unsigne
 {
 	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 	/* If it is in use, ignore it. */
-	if (!mutex_trylock(&sony_mutex) == 0) {
+	if (down_trylock(&sony_sem) == 0) {
 		/* We can't use abort_read(), because it will sleep
 		   or schedule in the timer interrupt.  Just start
 		   the operation, finish it on the next access to
@@ -1156,7 +1155,7 @@ static void handle_abort_timeout(unsigne
 
 		sony_blocks_left = 0;
 		abort_read_started = 1;
-		mutex_unlock(&sony_mutex);
+		up(&sony_sem);
 	}
 	pr_debug(PFX "Leaving %s\n", __FUNCTION__);
 }
@@ -1302,7 +1301,7 @@ static void do_cdu31a_request(request_qu
 	pr_debug(PFX "Entering %s\n", __FUNCTION__);
 
 	spin_unlock_irq(q->queue_lock);
-	if (mutex_lock_interruptible(&sony_mutex)) {
+	if (down_interruptible(&sony_sem)) {
 		spin_lock_irq(q->queue_lock);
 		return;
 	}
@@ -1435,7 +1434,7 @@ static void do_cdu31a_request(request_qu
 	add_timer(&cdu31a_abort_timer);
 #endif
 
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	spin_lock_irq(q->queue_lock);
 	pr_debug(PFX "Leaving %s at %d\n", __FUNCTION__, __LINE__);
 }
@@ -1906,10 +1905,10 @@ static int scd_get_last_session(struct c
 		return 1;
 
 	if (!sony_toc_read) {
-		if (mutex_lock_interruptible(&sony_mutex))
+		if (down_interruptible(&sony_sem))
 			return -ERESTARTSYS;
 		sony_get_toc();
-		mutex_unlock(&sony_mutex);
+		up(&sony_sem);
 	}
 
 	ms_info->addr_format = CDROM_LBA;
@@ -1988,11 +1987,11 @@ scd_get_mcn(struct cdrom_device_info *cd
 	unsigned int res_size;
 
 	memset(mcn->medium_catalog_number, 0, 14);
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	do_sony_cd_cmd(SONY_REQ_UPC_EAN_CMD,
 		       NULL, 0, resbuffer, &res_size);
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	if ((res_size < 2) || ((resbuffer[0] & 0xf0) == 0x20));
 	else {
 		/* packed bcd to single ASCII digits */
@@ -2207,7 +2206,7 @@ static int read_audio(struct cdrom_read_
 	unsigned int res_size;
 	unsigned int cframe;
 
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	if (!sony_spun_up)
 		scd_spinup();
@@ -2343,7 +2342,7 @@ static int read_audio(struct cdrom_read_
 	}
 
  out_up:
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 
 	return retval;
 }
@@ -2373,7 +2372,7 @@ static int scd_tray_move(struct cdrom_de
 {
 	int retval;
 
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	if (position == 1 /* open tray */ ) {
 		unsigned char res_reg[12];
@@ -2392,7 +2391,7 @@ static int scd_tray_move(struct cdrom_de
 			sony_spun_up = 1;
 		retval = 0;
 	}
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	return retval;
 }
 
@@ -2407,7 +2406,7 @@ static int scd_audio_ioctl(struct cdrom_
 	unsigned char params[7];
 	int i, retval;
 
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	switch (cmd) {
 	case CDROMSTART:	/* Spin up the drive */
@@ -2665,7 +2664,7 @@ static int scd_audio_ioctl(struct cdrom_
 		retval = -EINVAL;
 		break;
 	}
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	return retval;
 }
 
@@ -2675,7 +2674,7 @@ static int scd_read_audio(struct cdrom_d
 	void __user *argp = (void __user *)arg;
 	int retval;
 
-	if (mutex_lock_interruptible(&sony_mutex))
+	if (down_interruptible(&sony_sem))
 		return -ERESTARTSYS;
 	switch (cmd) {
 	case CDROMREADAUDIO:	/* Read 2352 byte audio tracks and 2340 byte
@@ -2749,7 +2748,7 @@ static int scd_read_audio(struct cdrom_d
 	default:
 		retval = -EINVAL;
 	}
-	mutex_unlock(&sony_mutex);
+	up(&sony_sem);
 	return retval;
 }
 
