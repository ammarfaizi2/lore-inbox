Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWCKBmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWCKBmo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWCKBmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:42:44 -0500
Received: from soohrt.org ([85.131.246.150]:6301 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S932367AbWCKBmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:42:44 -0500
Date: Sat, 11 Mar 2006 02:42:42 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] usbcore: fix check_ctrlrecip to allow control transfers in state ADDRESS
Message-ID: <20060311014242.GQ22994@quickstop.soohrt.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_ctrlrecip() disallows any control transfers if the device is
deconfigured (in configuration 0, ie. state ADDRESS). This for example
makes it impossible to read the device descriptors without configuring
the device, although most standard device requests are allowed in this
state by the spec. This patch allows control transfers for the ADDRESS
state, too.

Signed-off-by: Horst Schirmeier <horst@schirmeier.com> 

---

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 2b68998..3461476 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -498,7 +498,8 @@ static int check_ctrlrecip(struct dev_st
 {
 	int ret = 0;
 
-	if (ps->dev->state != USB_STATE_CONFIGURED)
+	if (ps->dev->state != USB_STATE_ADDRESS
+	 && ps->dev->state != USB_STATE_CONFIGURED)
 		return -EHOSTUNREACH;
 	if (USB_TYPE_VENDOR == (USB_TYPE_MASK & requesttype))
 		return 0;
