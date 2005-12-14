Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVLNDQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVLNDQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVLNDQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:16:13 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:23870 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030338AbVLNDQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:16:10 -0500
Message-Id: <20051214031459.265809000@localhost>
References: <20051214031344.031534000@localhost>
Date: Wed, 14 Dec 2005 01:13:45 -0200
From: mchehab@brturbo.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, js@linuxtv.org,
       Deti Fliegl <deti@fliegl.de>
Subject: [patch-mm 1/6] DVB (2401): USB hot unplug Oops fix.
Content-Disposition: inline; filename=dvb_2401_usb_hot_unplug_oops_fix-fixed.patch
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deti Fliegl <deti@fliegl.de>

- USB hot unplug Oops fix.

Signed-off-by: Deti Fliegl <deti@fliegl.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

 drivers/media/dvb/cinergyT2/cinergyT2.c |   71 +++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 24 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-12-11 01:09:39.000000000 +0100
+++ linux-2.6.15-rc5/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-12-11 01:18:06.000000000 +0100
@@ -131,6 +131,8 @@ struct cinergyt2 {
 
 	wait_queue_head_t poll_wq;
 	int pending_fe_events;
+	int disconnect_pending;
+	atomic_t inuse;
 
 	void *streambuf;
 	dma_addr_t streambuf_dmahandle;
@@ -343,7 +345,7 @@ static int cinergyt2_start_feed(struct d
 	struct dvb_demux *demux = dvbdmxfeed->demux;
 	struct cinergyt2 *cinergyt2 = demux->priv;
 
-	if (down_interruptible(&cinergyt2->sem))
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
 	if (cinergyt2->streaming == 0)
@@ -359,7 +361,7 @@ static int cinergyt2_stop_feed(struct dv
 	struct dvb_demux *demux = dvbdmxfeed->demux;
 	struct cinergyt2 *cinergyt2 = demux->priv;
 
-	if (down_interruptible(&cinergyt2->sem))
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
 	if (--cinergyt2->streaming == 0)
@@ -479,23 +481,37 @@ static int cinergyt2_open (struct inode 
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct cinergyt2 *cinergyt2 = dvbdev->priv;
-	int err;
+	int err = -ERESTARTSYS;
 
-	if ((err = dvb_generic_open(inode, file)))
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
+		return -ERESTARTSYS;
+
+	if ((err = dvb_generic_open(inode, file))) {
+		up(&cinergyt2->sem);
 		return err;
+	}
 
-	if (down_interruptible(&cinergyt2->sem))
-		return -ERESTARTSYS;
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 		cinergyt2_sleep(cinergyt2, 0);
 		schedule_delayed_work(&cinergyt2->query_work, HZ/2);
 	}
 
+	atomic_inc(&cinergyt2->inuse);
+
 	up(&cinergyt2->sem);
 	return 0;
 }
 
+static void cinergyt2_unregister(struct cinergyt2 *cinergyt2)
+{
+	dvb_unregister_device(cinergyt2->fedev);
+	dvb_unregister_adapter(&cinergyt2->adapter);
+
+	cinergyt2_free_stream_urbs(cinergyt2);
+	kfree(cinergyt2);
+}
+
 static int cinergyt2_release (struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
@@ -504,7 +520,7 @@ static int cinergyt2_release (struct ino
 	if (down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
-	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
+	if (!cinergyt2->disconnect_pending && (file->f_flags & O_ACCMODE) != O_RDONLY) {
 		cancel_delayed_work(&cinergyt2->query_work);
 		flush_scheduled_work();
 		cinergyt2_sleep(cinergyt2, 1);
@@ -512,6 +528,11 @@ static int cinergyt2_release (struct ino
 
 	up(&cinergyt2->sem);
 
+	if (atomic_dec_and_test(&cinergyt2->inuse) && cinergyt2->disconnect_pending) {
+		warn("delayed unregister in release");
+		cinergyt2_unregister(cinergyt2);
+	}
+
 	return dvb_generic_release(inode, file);
 }
 
@@ -519,7 +540,14 @@ static unsigned int cinergyt2_poll (stru
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct cinergyt2 *cinergyt2 = dvbdev->priv;
+
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
+		return -ERESTARTSYS;
+
 	poll_wait(file, &cinergyt2->poll_wq, wait);
+
+	up(&cinergyt2->sem);
+
 	return (POLLIN | POLLRDNORM | POLLPRI);
 }
 
@@ -585,7 +613,7 @@ static int cinergyt2_ioctl (struct inode
 		if (copy_from_user(&p, (void  __user*) arg, sizeof(p)))
 			return -EFAULT;
 
-		if (down_interruptible(&cinergyt2->sem))
+		if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
 			return -ERESTARTSYS;
 
 		param->cmd = CINERGYT2_EP1_SET_TUNER_PARAMETERS;
@@ -696,7 +724,7 @@ static void cinergyt2_query_rc (void *da
 	struct cinergyt2_rc_event rc_events[12];
 	int n, len, i;
 
-	if (down_interruptible(&cinergyt2->sem))
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
 		return;
 
 	len = cinergyt2_command(cinergyt2, buf, sizeof(buf),
@@ -791,7 +819,6 @@ static int cinergyt2_register_rc(struct 
 static void cinergyt2_unregister_rc(struct cinergyt2 *cinergyt2)
 {
 	cancel_delayed_work(&cinergyt2->rc_query_work);
-	flush_scheduled_work();
 	input_unregister_device(cinergyt2->rc_input_dev);
 }
 
@@ -822,7 +849,7 @@ static void cinergyt2_query (void *data)
 	uint8_t lock_bits;
 	uint32_t unc;
 
-	if (down_interruptible(&cinergyt2->sem))
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
 		return;
 
 	unc = s->uncorrected_block_count;
@@ -922,28 +949,25 @@ static void cinergyt2_disconnect (struct
 {
 	struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 
-	if (down_interruptible(&cinergyt2->sem))
-		return;
+	flush_scheduled_work();
 
 	cinergyt2_unregister_rc(cinergyt2);
 
+	cancel_delayed_work(&cinergyt2->query_work);
+	wake_up_interruptible(&cinergyt2->poll_wq);
+
 	cinergyt2->demux.dmx.close(&cinergyt2->demux.dmx);
-	dvb_net_release(&cinergyt2->dvbnet);
-	dvb_dmxdev_release(&cinergyt2->dmxdev);
-	dvb_dmx_release(&cinergyt2->demux);
-	dvb_unregister_device(cinergyt2->fedev);
-	dvb_unregister_adapter(&cinergyt2->adapter);
+	cinergyt2->disconnect_pending = 1;
 
-	cinergyt2_free_stream_urbs(cinergyt2);
-	up(&cinergyt2->sem);
-	kfree(cinergyt2);
+	if (!atomic_read(&cinergyt2->inuse))
+		cinergyt2_unregister(cinergyt2);
 }
 
 static int cinergyt2_suspend (struct usb_interface *intf, pm_message_t state)
 {
 	struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 
-	if (down_interruptible(&cinergyt2->sem))
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
 	if (state.event > PM_EVENT_ON) {
@@ -966,7 +990,7 @@ static int cinergyt2_resume (struct usb_
 	struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 	struct dvbt_set_parameters_msg *param = &cinergyt2->param;
 
-	if (down_interruptible(&cinergyt2->sem))
+	if (cinergyt2->disconnect_pending || down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
 	if (!cinergyt2->sleeping) {
@@ -1020,4 +1044,3 @@ module_exit (cinergyt2_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Holger Waechtler, Daniel Mack");
-

--

