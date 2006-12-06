Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937202AbWLFTSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937202AbWLFTSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937295AbWLFTSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:18:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36758 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937202AbWLFTSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:18:22 -0500
Date: Wed, 6 Dec 2006 19:18:20 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: and more of the same...
Message-ID: <20061206191820.GF4587@ftp.linux.org.uk>
References: <20061206184145.GC4587@ftp.linux.org.uk> <20061206185140.GD4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206185140.GD4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index a2cef57..2af2d9b 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -54,7 +54,7 @@ static void dasd_flush_request_queue(str
 static void dasd_int_handler(struct ccw_device *, unsigned long, struct irb *);
 static int dasd_flush_ccw_queue(struct dasd_device *, int);
 static void dasd_tasklet(struct dasd_device *);
-static void do_kick_device(void *data);
+static void do_kick_device(struct work_struct *);
 
 /*
  * SECTION: Operations on the device structure.
@@ -100,7 +100,7 @@ dasd_alloc_device(void)
 		     (unsigned long) device);
 	INIT_LIST_HEAD(&device->ccw_queue);
 	init_timer(&device->timer);
-	INIT_WORK(&device->kick_work, do_kick_device, device);
+	INIT_WORK(&device->kick_work, do_kick_device);
 	device->state = DASD_STATE_NEW;
 	device->target = DASD_STATE_NEW;
 
@@ -407,11 +407,9 @@ dasd_change_state(struct dasd_device *de
  * event daemon.
  */
 static void
-do_kick_device(void *data)
+do_kick_device(struct work_struct *work)
 {
-	struct dasd_device *device;
-
-	device = (struct dasd_device *) data;
+	struct dasd_device *device = container_of(work, struct dasd_device, kick_work);
 	dasd_change_state(device);
 	dasd_schedule_bh(device);
 	dasd_put_device(device);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index ad7f7e1..26cf2f5 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -334,7 +334,7 @@ static LIST_HEAD(slow_subchannels_head);
 static DEFINE_SPINLOCK(slow_subchannel_lock);
 
 static void
-css_trigger_slow_path(void)
+css_trigger_slow_path(struct work_struct *unused)
 {
 	CIO_TRACE_EVENT(4, "slowpath");
 
@@ -359,8 +359,7 @@ css_trigger_slow_path(void)
 	spin_unlock_irq(&slow_subchannel_lock);
 }
 
-typedef void (*workfunc)(void *);
-DECLARE_WORK(slow_path_work, (workfunc)css_trigger_slow_path, NULL);
+DECLARE_WORK(slow_path_work, css_trigger_slow_path);
 struct workqueue_struct *slow_path_wq;
 
 /* Reprobe subchannel if unregistered. */
@@ -397,7 +396,7 @@ static int reprobe_subchannel(struct sub
 }
 
 /* Work function used to reprobe all unregistered subchannels. */
-static void reprobe_all(void *data)
+static void reprobe_all(struct work_struct *unused)
 {
 	int ret;
 
@@ -413,7 +412,7 @@ static void reprobe_all(void *data)
 		      need_reprobe);
 }
 
-DECLARE_WORK(css_reprobe_work, reprobe_all, NULL);
+DECLARE_WORK(css_reprobe_work, reprobe_all);
 
 /* Schedule reprobing of all unregistered subchannels. */
 void css_schedule_reprobe(void)
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 6a54334..e4dc947 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -37,7 +37,7 @@ #include <asm/s390_rdev.h>
 #include "ap_bus.h"
 
 /* Some prototypes. */
-static void ap_scan_bus(void *);
+static void ap_scan_bus(struct work_struct *);
 static void ap_poll_all(unsigned long);
 static void ap_poll_timeout(unsigned long);
 static int ap_poll_thread_start(void);
@@ -71,7 +71,7 @@ static struct device *ap_root_device = N
 static struct workqueue_struct *ap_work_queue;
 static struct timer_list ap_config_timer;
 static int ap_config_time = AP_CONFIG_TIME;
-static DECLARE_WORK(ap_config_work, ap_scan_bus, NULL);
+static DECLARE_WORK(ap_config_work, ap_scan_bus);
 
 /**
  * Tasklet & timer for AP request polling.
@@ -732,7 +732,7 @@ static void ap_device_release(struct dev
 	kfree(ap_dev);
 }
 
-static void ap_scan_bus(void *data)
+static void ap_scan_bus(struct work_struct *unused)
 {
 	struct ap_device *ap_dev;
 	struct device *dev;
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 08d4e47..e5665b6 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -67,7 +67,7 @@ static char debug_buffer[255];
  * Some prototypes.
  */
 static void lcs_tasklet(unsigned long);
-static void lcs_start_kernel_thread(struct lcs_card *card);
+static void lcs_start_kernel_thread(struct work_struct *);
 static void lcs_get_frames_cb(struct lcs_channel *, struct lcs_buffer *);
 static int lcs_send_delipm(struct lcs_card *, struct lcs_ipm_list *);
 static int lcs_recovery(void *ptr);
@@ -1724,8 +1724,9 @@ lcs_stopcard(struct lcs_card *card)
  * Kernel Thread helper functions for LGW initiated commands
  */
 static void
-lcs_start_kernel_thread(struct lcs_card *card)
+lcs_start_kernel_thread(struct work_struct *work)
 {
+	struct lcs_card *card = container_of(work, struct lcs_card, kernel_thread_starter);
 	LCS_DBF_TEXT(5, trace, "krnthrd");
 	if (lcs_do_start_thread(card, LCS_RECOVERY_THREAD))
 		kernel_thread(lcs_recovery, (void *) card, SIGCHLD);
@@ -2053,8 +2054,7 @@ lcs_probe_device(struct ccwgroup_device 
 	ccwgdev->cdev[0]->handler = lcs_irq;
 	ccwgdev->cdev[1]->handler = lcs_irq;
 	card->gdev = ccwgdev;
-	INIT_WORK(&card->kernel_thread_starter,
-		  (void *) lcs_start_kernel_thread, card);
+	INIT_WORK(&card->kernel_thread_starter, lcs_start_kernel_thread);
 	card->thread_start_mask = 0;
 	card->thread_allowed_mask = 0;
 	card->thread_running_mask = 0;
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 7fdc527..2bde4f1 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -1039,8 +1039,9 @@ qeth_do_start_thread(struct qeth_card *c
 }
 
 static void
-qeth_start_kernel_thread(struct qeth_card *card)
+qeth_start_kernel_thread(struct work_struct *work)
 {
+	struct qeth_card *card = container_of(work, struct qeth_card, kernel_thread_starter);
 	QETH_DBF_TEXT(trace , 2, "strthrd");
 
 	if (card->read.state != CH_STATE_UP &&
@@ -1103,8 +1104,7 @@ #endif
 	card->thread_start_mask = 0;
 	card->thread_allowed_mask = 0;
 	card->thread_running_mask = 0;
-	INIT_WORK(&card->kernel_thread_starter,
-		  (void *)qeth_start_kernel_thread,card);
+	INIT_WORK(&card->kernel_thread_starter, qeth_start_kernel_thread);
 	INIT_LIST_HEAD(&card->ip_list);
 	card->ip_tbd_list = kmalloc(sizeof(struct list_head), GFP_KERNEL);
 	if (!card->ip_tbd_list) {
diff --git a/drivers/scsi/oktagon_esp.c b/drivers/scsi/oktagon_esp.c
index dd67a68..c116a6a 100644
--- a/drivers/scsi/oktagon_esp.c
+++ b/drivers/scsi/oktagon_esp.c
@@ -72,12 +72,12 @@ static void dma_advance_sg(Scsi_Cmnd *);
 static int  oktagon_notify_reboot(struct notifier_block *this, unsigned long code, void *x);
 
 #ifdef USE_BOTTOM_HALF
-static void dma_commit(void *opaque);
+static void dma_commit(struct work_struct *unused);
 
 long oktag_to_io(long *paddr, long *addr, long len);
 long oktag_from_io(long *addr, long *paddr, long len);
 
-static DECLARE_WORK(tq_fake_dma, dma_commit, NULL);
+static DECLARE_WORK(tq_fake_dma, dma_commit);
 
 #define DMA_MAXTRANSFER 0x8000
 
@@ -266,7 +266,7 @@ #ifdef USE_BOTTOM_HALF
  */
  
  
-static void dma_commit(void *opaque)
+static void dma_commit(struct work_struct *unused)
 {
     long wait,len2,pos;
     struct NCR_ESP *esp;
