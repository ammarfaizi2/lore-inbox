Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWAMJFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWAMJFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWAMJFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:05:16 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:64143 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030330AbWAMJFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:05:14 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 06/13] USBATM: shutdown open connections when disconnected
Date: Fri, 13 Jan 2006 10:05:15 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L12xDf2zKR8Lgh+"
Message-Id: <200601131005.15690.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_L12xDf2zKR8Lgh+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch causes vcc_release_async to be applied to any open
vcc's when the modem is disconnected.  This signals a socket
shutdown, letting the socket user know that the game is up.
I wrote this patch because of reports that pppd would keep
connections open forever when the modem is disconnected.
This patch does not fix that problem, but it's a step in the
right direction.  It doesn't help because the pppoatm module
doesn't yet monitor state changes on the ATM socket, so simply
never realises that the ATM connection has gone down (meaning
it doesn't tell the ppp layer).  But at least there is a socket
state change now.  Unfortunately this patch may create problems
for those rare users like me who use routed IP or some other
non-ppp connection method that goes via the ATM ARP daemon: the
daemon is buggy, and with this patch will crash when the modem
is disconnected.  Users with a buggy atmarpd can simply restart
it after disconnecting the modem.

Signed-off-by: Duncan Sands <baldrick@free.fr>

--Boundary-00=_L12xDf2zKR8Lgh+
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="06-disconnect"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="06-disconnect"

Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 08:51:00.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 08:57:48.000000000 +0100
@@ -602,8 +602,12 @@
 
 	vdbg("%s called (skb 0x%p, len %u)", __func__, skb, skb->len);
 
-	if (!instance) {
-		dbg("%s: NULL data!", __func__);
+	/* racy disconnection check - fine */
+	if (!instance || instance->disconnected) {
+#ifdef DEBUG
+		if (printk_ratelimit())
+			printk(KERN_DEBUG "%s: %s!\n", __func__, instance ? "disconnected" : "NULL instance");
+#endif
 		err = -ENODEV;
 		goto fail;
 	}
@@ -715,15 +719,19 @@
 			       atomic_read(&atm_dev->stats.aal5.rx_err),
 			       atomic_read(&atm_dev->stats.aal5.rx_drop));
 
-	if (!left--)
-		switch (atm_dev->signal) {
-		case ATM_PHY_SIG_FOUND:
-			return sprintf(page, "Line up\n");
-		case ATM_PHY_SIG_LOST:
-			return sprintf(page, "Line down\n");
-		default:
-			return sprintf(page, "Line state unknown\n");
-		}
+	if (!left--) {
+		if (instance->disconnected)
+			return sprintf(page, "Disconnected\n");
+		else
+			switch (atm_dev->signal) {
+			case ATM_PHY_SIG_FOUND:
+				return sprintf(page, "Line up\n");
+			case ATM_PHY_SIG_LOST:
+				return sprintf(page, "Line down\n");
+			default:
+				return sprintf(page, "Line state unknown\n");
+			}
+	}
 
 	return 0;
 }
@@ -757,6 +765,12 @@
 
 	down(&instance->serialize);	/* vs self, usbatm_atm_close, usbatm_usb_disconnect */
 
+	if (instance->disconnected) {
+		atm_dbg(instance, "%s: disconnected!\n", __func__);
+		ret = -ENODEV;
+		goto fail;
+	}
+
 	if (usbatm_find_vcc(instance, vpi, vci)) {
 		atm_dbg(instance, "%s: %hd/%d already in use!\n", __func__, vpi, vci);
 		ret = -EADDRINUSE;
@@ -845,6 +859,13 @@
 static int usbatm_atm_ioctl(struct atm_dev *atm_dev, unsigned int cmd,
 			  void __user * arg)
 {
+	struct usbatm_data *instance = atm_dev->dev_data;
+
+	if (!instance || instance->disconnected) {
+		dbg("%s: %s!", __func__, instance ? "disconnected" : "NULL instance");
+		return -ENODEV;
+	}
+
 	switch (cmd) {
 	case ATM_QUERYLOOP:
 		return put_user(ATM_LM_NONE, (int __user *)arg) ? -EFAULT : 0;
@@ -1129,6 +1150,7 @@
 {
 	struct device *dev = &intf->dev;
 	struct usbatm_data *instance = usb_get_intfdata(intf);
+	struct usbatm_vcc_data *vcc_data;
 	int i;
 
 	dev_dbg(dev, "%s entered\n", __func__);
@@ -1141,12 +1163,18 @@
 	usb_set_intfdata(intf, NULL);
 
 	down(&instance->serialize);
+	instance->disconnected = 1;
 	if (instance->thread_pid >= 0)
 		kill_proc(instance->thread_pid, SIGTERM, 1);
 	up(&instance->serialize);
 
 	wait_for_completion(&instance->thread_exited);
 
+	down(&instance->serialize);
+	list_for_each_entry(vcc_data, &instance->vcc_list, list)
+		vcc_release_async(vcc_data->vcc, -EPIPE);
+	up(&instance->serialize);
+
 	tasklet_disable(&instance->rx_channel.tasklet);
 	tasklet_disable(&instance->tx_channel.tasklet);
 
@@ -1156,6 +1184,14 @@
 	del_timer_sync(&instance->rx_channel.delay);
 	del_timer_sync(&instance->tx_channel.delay);
 
+	/* turn usbatm_[rt]x_process into something close to a no-op */
+	/* no need to take the spinlock */
+	INIT_LIST_HEAD(&instance->rx_channel.list);
+	INIT_LIST_HEAD(&instance->tx_channel.list);
+
+	tasklet_enable(&instance->rx_channel.tasklet);
+	tasklet_enable(&instance->tx_channel.tasklet);
+
 	if (instance->atm_dev && instance->driver->atm_stop)
 		instance->driver->atm_stop(instance, instance->atm_dev);
 
@@ -1164,14 +1200,6 @@
 
 	instance->driver_data = NULL;
 
-	/* turn usbatm_[rt]x_process into noop */
-	/* no need to take the spinlock */
-	INIT_LIST_HEAD(&instance->rx_channel.list);
-	INIT_LIST_HEAD(&instance->tx_channel.list);
-
-	tasklet_enable(&instance->rx_channel.tasklet);
-	tasklet_enable(&instance->tx_channel.tasklet);
-
 	for (i = 0; i < num_rcv_urbs + num_snd_urbs; i++) {
 		kfree(instance->urbs[i]->transfer_buffer);
 		usb_free_urb(instance->urbs[i]);
Index: Linux/drivers/usb/atm/usbatm.h
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.h	2006-01-13 08:48:09.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-13 08:57:48.000000000 +0100
@@ -168,6 +168,7 @@
 
 	struct kref refcount;
 	struct semaphore serialize;
+	int disconnected;
 
 	/* heavy init */
 	int thread_pid;

--Boundary-00=_L12xDf2zKR8Lgh+--
