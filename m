Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbTIAVWB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTIAVWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:22:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15086 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263297AbTIAVVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:21:47 -0400
Date: Mon, 1 Sep 2003 23:21:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] add 4 missing returns to drivers/isdn/i4l/isdn_common.c
Message-ID: <20030901212139.GF23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds 4 missing returns to drivers/isdn/i4l/isdn_common.c.
I'm not 100% sure whether other return values are possible (and I don't 
have a good knowledge of the ISDN code) but at a first glance it seems 
there are no other possible return values in these functions.

I've tested the compilation with 2.6.0-test4-mm4.

cu
Adrian

--- linux-2.6.0-test4-mm4-no-smp/drivers/isdn/i4l/isdn_common.c.old	2003-09-01 23:07:10.000000000 +0200
+++ linux-2.6.0-test4-mm4-no-smp/drivers/isdn/i4l/isdn_common.c	2003-09-01 23:08:23.000000000 +0200
@@ -586,78 +586,82 @@
 
 static int
 drv_register(struct fsm_inst *fi, int pr, void *arg)
 {
 	struct isdn_driver *drv = fi->userdata;
 	isdn_if *iif = arg;
 	
 	fsm_change_state(fi, ST_DRV_LOADED);
 	drv->maxbufsize = iif->maxbufsize;
 	drv->interface = iif;
 	iif->channels = drv->di;
 	iif->rcvcallb_skb = isdn_receive_skb_callback;
 	iif->statcallb = isdn_status_callback;
 
 	isdn_info_update();
+	return 0;
 }
 
 static int
 drv_stat_run(struct fsm_inst *fi, int pr, void *arg)
 {
 	struct isdn_driver *drv = fi->userdata;
 	fsm_change_state(fi, ST_DRV_RUNNING);
 
 	drv->features = drv->interface->features;
 	isdn_v110_add_features(drv);
 	set_global_features();
+	return 0;
 }
 
 static int
 drv_stat_stop(struct fsm_inst *fi, int pr, void *arg)
 {
 	fsm_change_state(fi, ST_DRV_LOADED);
 	set_global_features();
+	return 0;
 }
 
 static int
 drv_stat_unload(struct fsm_inst *fi, int pr, void *arg)
 {
 	struct isdn_driver *drv = fi->userdata;
 	unsigned long flags;
 
 	spin_lock_irqsave(&drivers_lock, flags);
 	drivers[drv->di] = NULL;
 	spin_unlock_irqrestore(&drivers_lock, flags);
 	put_drv(drv);
 
 	dev->channels -= drv->channels;
 
 	isdn_info_update();
 	return 0;
 }
 
 static int
 drv_stat_stavail(struct fsm_inst *fi, int pr, void *arg)
 {
 	struct isdn_driver *drv = fi->userdata;
 	unsigned long flags;
 	isdn_ctrl *c = arg;
 	
 	spin_lock_irqsave(&stat_lock, flags);
 	drv->stavail += c->arg;
 	spin_unlock_irqrestore(&stat_lock, flags);
 	wake_up_interruptible(&drv->st_waitq);
+	return 0;
 }
 
 static int
 drv_to_slot(struct fsm_inst *fi, int pr, void *arg)
 {
 	struct isdn_driver *drv = fi->userdata;
 	isdn_ctrl *c = arg;
 	int ch = c->arg & 0xff;
 
 	return fsm_event(&drv->slots[ch].fi, pr, arg);
 }
 
 static struct fsm_node drv_fn_tbl[] = {
 	{ ST_DRV_NULL,    EV_DRV_REGISTER, drv_register     },
 
