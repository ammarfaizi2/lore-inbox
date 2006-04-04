Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWDCX70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWDCX70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWDCX7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:59:25 -0400
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:2999 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S964889AbWDCX7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:59:25 -0400
Date: Tue, 4 Apr 2006 02:00:26 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Karsten Keil <kkeil@suse.de>
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/13] isdn4linux: Siemens Gigaset drivers - sysfs usage
Message-ID: <gigaset307x.2006.04.04.001.5@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.04.04.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.1@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.2@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.3@hjlipp.my-fqdn.de> <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gigaset307x.2006.04.04.001.4@hjlipp.my-fqdn.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>

This patch corrects the way the Gigaset drivers create their sysfs
entries. Please merge.

Signed-off-by: Hansjoerg Lipp <hjlipp@web.de>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 drivers/isdn/gigaset/bas-gigaset.c |   20 ++++++++++----------
 drivers/isdn/gigaset/common.c      |    6 ++++++
 drivers/isdn/gigaset/gigaset.h     |    4 ++--
 drivers/isdn/gigaset/proc.c        |   16 ++++++----------
 drivers/isdn/gigaset/usb-gigaset.c |   23 +++++++++++------------
 5 files changed, 35 insertions(+), 34 deletions(-)

--- linux-2.6.16-gig-log/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/gigaset.h	2006-04-02 18:41:27.000000000 +0200
@@ -778,8 +778,8 @@ void gigaset_handle_modem_response(struc
  */
 
 /* initialize sysfs for device */
-void gigaset_init_dev_sysfs(struct usb_interface *interface);
-void gigaset_free_dev_sysfs(struct usb_interface *interface);
+void gigaset_init_dev_sysfs(struct cardstate *cs);
+void gigaset_free_dev_sysfs(struct cardstate *cs);
 
 /* ===========================================================================
  *  Functions implemented in common.c/gigaset.h
--- linux-2.6.16-gig-log/drivers/isdn/gigaset/common.c	2006-04-03 02:17:56.000000000 +0200
+++ linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/common.c	2006-04-02 18:40:48.000000000 +0200
@@ -833,6 +833,9 @@ int gigaset_start(struct cardstate *cs)
 
 	wait_event(cs->waitqueue, !cs->waiting);
 
+	/* set up device sysfs */
+	gigaset_init_dev_sysfs(cs);
+
 	up(&cs->sem);
 	return 1;
 
@@ -882,6 +885,9 @@ void gigaset_stop(struct cardstate *cs)
 {
 	down(&cs->sem);
 
+	/* clear device sysfs */
+	gigaset_free_dev_sysfs(cs);
+
 	atomic_set(&cs->connected, 0);
 
 	cs->waiting = 1;
--- linux-2.6.16-gig-log/drivers/isdn/gigaset/proc.c	2006-04-03 02:17:56.000000000 +0200
+++ linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/proc.c	2006-04-02 18:41:27.000000000 +0200
@@ -19,16 +19,14 @@
 static ssize_t show_cidmode(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	struct usb_interface *intf = to_usb_interface(dev);
-	struct cardstate *cs = usb_get_intfdata(intf);
+	struct cardstate *cs = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", atomic_read(&cs->cidmode));
 }
 
 static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct usb_interface *intf = to_usb_interface(dev);
-	struct cardstate *cs = usb_get_intfdata(intf);
+	struct cardstate *cs = dev_get_drvdata(dev);
 	long int value;
 	char *end;
 
@@ -63,17 +61,15 @@ static ssize_t set_cidmode(struct device
 static DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
 
 /* free sysfs for device */
-void gigaset_free_dev_sysfs(struct usb_interface *interface)
+void gigaset_free_dev_sysfs(struct cardstate *cs)
 {
 	gig_dbg(DEBUG_INIT, "removing sysfs entries");
-	device_remove_file(&interface->dev, &dev_attr_cidmode);
+	device_remove_file(cs->dev, &dev_attr_cidmode);
 }
-EXPORT_SYMBOL_GPL(gigaset_free_dev_sysfs);
 
 /* initialize sysfs for device */
-void gigaset_init_dev_sysfs(struct usb_interface *interface)
+void gigaset_init_dev_sysfs(struct cardstate *cs)
 {
 	gig_dbg(DEBUG_INIT, "setting up sysfs");
-	device_create_file(&interface->dev, &dev_attr_cidmode);
+	device_create_file(cs->dev, &dev_attr_cidmode);
 }
-EXPORT_SYMBOL_GPL(gigaset_init_dev_sysfs);
--- linux-2.6.16-gig-log/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:40:48.000000000 +0200
+++ linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/bas-gigaset.c	2006-04-02 18:41:27.000000000 +0200
@@ -2217,7 +2217,7 @@ static int gigaset_probe(struct usb_inte
 	usb_get_dev(udev);
 	ucs->udev = udev;
 	ucs->interface = interface;
-	cs->dev = &udev->dev;
+	cs->dev = &interface->dev;
 
 	/* allocate URBs:
 	 * - one for the interrupt pipe
@@ -2289,14 +2289,13 @@ static int gigaset_probe(struct usb_inte
 	/* tell common part that the device is ready */
 	if (startmode == SM_LOCKED)
 		atomic_set(&cs->mstate, MS_LOCKED);
-	if (!gigaset_start(cs))
-		goto error;
 
 	/* save address of controller structure */
 	usb_set_intfdata(interface, cs);
 
-	/* set up device sysfs */
-	gigaset_init_dev_sysfs(interface);
+	if (!gigaset_start(cs))
+		goto error;
+
 	return 0;
 
 error:
@@ -2313,23 +2312,24 @@ static void gigaset_disconnect(struct us
 	struct cardstate *cs;
 	struct bas_cardstate *ucs;
 
-	/* clear device sysfs */
-	gigaset_free_dev_sysfs(interface);
-
 	cs = usb_get_intfdata(interface);
-	usb_set_intfdata(interface, NULL);
 
 	IFNULLRET(cs);
 	ucs = cs->hw.bas;
 	IFNULLRET(ucs);
 
-	dev_info(cs->dev, "disconnecting GigaSet base");
+	dev_info(cs->dev, "disconnecting Gigaset base\n");
 	gigaset_stop(cs);
 	freeurbs(cs);
+	usb_set_intfdata(interface, NULL);
 	kfree(ucs->rcvbuf);
 	ucs->rcvbuf = NULL;
 	ucs->rcvbuf_size = 0;
 	atomic_set(&ucs->basstate, 0);
+	usb_put_dev(ucs->udev);
+	ucs->interface = NULL;
+	ucs->udev = NULL;
+	cs->dev = NULL;
 	gigaset_unassign(cs);
 }
 
--- linux-2.6.16-gig-log/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:40:51.000000000 +0200
+++ linux-2.6.16-gig-sysfs/drivers/isdn/gigaset/usb-gigaset.c	2006-04-02 18:41:29.000000000 +0200
@@ -748,7 +748,10 @@ static int gigaset_probe(struct usb_inte
 	usb_get_dev(udev);
 	ucs->udev = udev;
 	ucs->interface = interface;
-	cs->dev = &udev->dev;
+	cs->dev = &interface->dev;
+
+	/* save address of controller structure */
+	usb_set_intfdata(interface, cs); // dev_set_drvdata(&interface->dev, cs);
 
 	endpoint = &hostif->endpoint[0].desc;
 
@@ -805,17 +808,12 @@ static int gigaset_probe(struct usb_inte
 	/* tell common part that the device is ready */
 	if (startmode == SM_LOCKED)
 		atomic_set(&cs->mstate, MS_LOCKED);
+
 	if (!gigaset_start(cs)) {
 		tasklet_kill(&cs->write_tasklet);
 		retval = -ENODEV; //FIXME
 		goto error;
 	}
-
-	/* save address of controller structure */
-	usb_set_intfdata(interface, cs);
-
-	/* set up device sysfs */
-	gigaset_init_dev_sysfs(interface);
 	return 0;
 
 error:
@@ -827,6 +825,7 @@ error:
 	kfree(cs->inbuf[0].rcvbuf);
 	if (ucs->read_urb != NULL)
 		usb_free_urb(ucs->read_urb);
+	usb_set_intfdata(interface, NULL);
 	ucs->read_urb = ucs->bulk_out_urb = NULL;
 	cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
 	usb_put_dev(ucs->udev);
@@ -845,16 +844,12 @@ static void gigaset_disconnect(struct us
 	struct usb_cardstate *ucs;
 
 	cs = usb_get_intfdata(interface);
-
-	/* clear device sysfs */
-	gigaset_free_dev_sysfs(interface);
-
-	usb_set_intfdata(interface, NULL);
 	ucs = cs->hw.usb;
 	usb_kill_urb(ucs->read_urb);
 
 	gigaset_stop(cs);
 
+	usb_set_intfdata(interface, NULL);
 	tasklet_kill(&cs->write_tasklet);
 
 	usb_kill_urb(ucs->bulk_out_urb);	/* FIXME: only if active? */
@@ -868,6 +863,10 @@ static void gigaset_disconnect(struct us
 	ucs->read_urb = ucs->bulk_out_urb = NULL;
 	cs->inbuf[0].rcvbuf = ucs->bulk_out_buffer = NULL;
 
+	usb_put_dev(ucs->udev);
+	ucs->interface = NULL;
+	ucs->udev = NULL;
+	cs->dev = NULL;
 	gigaset_unassign(cs);
 }
 
