Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVJ1GeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVJ1GeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVJ1Gby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:44266 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965144AbVJ1GbY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:24 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] usb device wakeup flags
In-Reply-To: <11304810222258@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:22 -0700
Message-Id: <11304810223635@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] usb device wakeup flags

This patch teaches "usb_device" about the new driver model wakeup support:

 - It updates device wakeup capabilities when entering a configuration
   with the WAKEUP attribute;

 - During suspend processing it consults the policy bit to see
   whether it should enable wakeup for that device.  (This resolves
   a FIXME to not assume the answer is always "yes"; some devices
   lie about supporting remote wakeup.)

Support for root hubs and the HCDs is separate (and more complex).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f69079c91f8ade0bb306d137d60cc9892e89f35a
tree 40b0e76157521b9c422267c7c6d693be16e93e77
parent 79eef3cfd105168a2115fff06971af8efa27db82
author David Brownell <david-b@pacbell.net> Mon, 12 Sep 2005 19:39:39 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:59 -0700

 drivers/usb/core/hub.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a12cab5..c3e2024 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1020,9 +1020,15 @@ void usb_set_device_state(struct usb_dev
 	spin_lock_irqsave(&device_state_lock, flags);
 	if (udev->state == USB_STATE_NOTATTACHED)
 		;	/* do nothing */
-	else if (new_state != USB_STATE_NOTATTACHED)
+	else if (new_state != USB_STATE_NOTATTACHED) {
 		udev->state = new_state;
-	else
+		if (new_state == USB_STATE_CONFIGURED)
+			device_init_wakeup(&udev->dev,
+				(udev->actconfig->desc.bmAttributes
+				 & USB_CONFIG_ATT_WAKEUP));
+		else if (new_state != USB_STATE_SUSPENDED)
+			device_init_wakeup(&udev->dev, 0);
+	} else
 		recursively_mark_NOTATTACHED(udev);
 	spin_unlock_irqrestore(&device_state_lock, flags);
 }
@@ -1546,11 +1552,7 @@ static int hub_port_suspend(struct usb_h
 	 * NOTE:  OTG devices may issue remote wakeup (or SRP) even when
 	 * we don't explicitly enable it here.
 	 */
-	if (udev->actconfig
-			// && FIXME (remote wakeup enabled on this bus)
-			// ... currently assuming it's always appropriate
-			&& (udev->actconfig->desc.bmAttributes
-				& USB_CONFIG_ATT_WAKEUP) != 0) {
+	if (device_may_wakeup(&udev->dev)) {
 		status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				USB_REQ_SET_FEATURE, USB_RECIP_DEVICE,
 				USB_DEVICE_REMOTE_WAKEUP, 0,

