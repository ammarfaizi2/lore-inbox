Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbWCTPYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWCTPYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWCTPYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:24:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64226 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965280AbWCTPXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:23:49 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Peter Beutner <p.beutner@gmx.net>,
       Johannes Stezenbach <js@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 114/141] V4L/DVB (3386): Dvb-core: remove dead code
Date: Mon, 20 Mar 2006 12:08:56 -0300
Message-id: <20060320150856.PS109912000114@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Beutner <p.beutner@gmx.net>
Date: 1141009763 -0300

The field "dvr" in struct dmxdev is competely unused. Remove
it and code which allocates, initializes and frees it.

Signed-off-by: Peter Beutner <p.beutner@gmx.net>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-core/dmxdev.c b/drivers/media/dvb/dvb-core/dmxdev.c
diff --git a/drivers/media/dvb/dvb-core/dmxdev.c b/drivers/media/dvb/dvb-core/dmxdev.c
index ead5343..4c52c85 100644
--- a/drivers/media/dvb/dvb-core/dmxdev.c
+++ b/drivers/media/dvb/dvb-core/dmxdev.c
@@ -160,13 +160,6 @@ static struct dmx_frontend * get_fe(stru
 	return NULL;
 }
 
-static inline void dvb_dmxdev_dvr_state_set(struct dmxdev_dvr *dmxdevdvr, int state)
-{
-	spin_lock_irq(&dmxdevdvr->dev->lock);
-	dmxdevdvr->state=state;
-	spin_unlock_irq(&dmxdevdvr->dev->lock);
-}
-
 static int dvb_dvr_open(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
@@ -1106,22 +1099,12 @@ dvb_dmxdev_init(struct dmxdev *dmxdev, s
 	if (!dmxdev->filter)
 		return -ENOMEM;
 
-	dmxdev->dvr = vmalloc(dmxdev->filternum*sizeof(struct dmxdev_dvr));
-	if (!dmxdev->dvr) {
-		vfree(dmxdev->filter);
-		dmxdev->filter = NULL;
-		return -ENOMEM;
-	}
-
 	mutex_init(&dmxdev->mutex);
 	spin_lock_init(&dmxdev->lock);
 	for (i=0; i<dmxdev->filternum; i++) {
 		dmxdev->filter[i].dev=dmxdev;
 		dmxdev->filter[i].buffer.data=NULL;
 		dvb_dmxdev_filter_state_set(&dmxdev->filter[i], DMXDEV_STATE_FREE);
-		dmxdev->dvr[i].dev=dmxdev;
-		dmxdev->dvr[i].buffer.data=NULL;
-		dvb_dmxdev_dvr_state_set(&dmxdev->dvr[i], DMXDEV_STATE_FREE);
 	}
 
 	dvb_register_device(dvb_adapter, &dmxdev->dvbdev, &dvbdev_demux, dmxdev, DVB_DEVICE_DEMUX);
@@ -1141,8 +1124,6 @@ dvb_dmxdev_release(struct dmxdev *dmxdev
 
 	vfree(dmxdev->filter);
 	dmxdev->filter=NULL;
-	vfree(dmxdev->dvr);
-	dmxdev->dvr=NULL;
 	dmxdev->demux->close(dmxdev->demux);
 }
 EXPORT_SYMBOL(dvb_dmxdev_release);
diff --git a/drivers/media/dvb/dvb-core/dmxdev.h b/drivers/media/dvb/dvb-core/dmxdev.h
diff --git a/drivers/media/dvb/dvb-core/dmxdev.h b/drivers/media/dvb/dvb-core/dmxdev.h
index ec2a7a4..fafdf47 100644
--- a/drivers/media/dvb/dvb-core/dmxdev.h
+++ b/drivers/media/dvb/dvb-core/dmxdev.h
@@ -94,19 +94,11 @@ struct dmxdev_filter {
 };
 
 
-struct dmxdev_dvr {
-	int state;
-	struct dmxdev *dev;
-	struct dmxdev_buffer buffer;
-};
-
-
 struct dmxdev {
 	struct dvb_device *dvbdev;
 	struct dvb_device *dvr_dvbdev;
 
 	struct dmxdev_filter *filter;
-	struct dmxdev_dvr *dvr;
 	struct dmx_demux *demux;
 
 	int filternum;

