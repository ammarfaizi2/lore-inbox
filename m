Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751917AbWIHAVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbWIHAVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWIHAVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:21:07 -0400
Received: from god.demon.nl ([83.160.164.11]:47552 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S1751942AbWIHAVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:21:03 -0400
Date: Fri, 8 Sep 2006 02:21:01 +0200
From: Henk Vergonet <Henk.Vergonet@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix unload oops and memory leak in yealink driver - TAKE II
Message-ID: <20060908002101.GA31531@god.dyndns.org>
References: <20060907234614.GA31195@god.dyndns.org> <20060907235458.GA30701@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20060907235458.GA30701@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2006 at 04:54:58PM -0700, Greg KH wrote:
> How about a version of the patch without the spelling and other stuff in
> it, and only the bugfix?

This patch fixes a memory leak and a kernel oops when trying to unload
the driver, due to an unbalanced cleanup.
Thanks Ivar Jensen for spotting my mistake.

Signed-off-by: Henk Vergonet <henk.vergonet@gmail.com>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="yealink.c.patch"

--- linux-2.6.18-rc6/drivers/usb/input/yealink.c.orig	2006-09-07 23:49:18.000000000 +0200
+++ linux-2.6.18-rc6/drivers/usb/input/yealink.c	2006-09-08 02:18:35.000000000 +0200
@@ -810,12 +810,9 @@ static int usb_cleanup(struct yealink_de
 	if (yld == NULL)
 		return err;
 
-        if (yld->urb_irq) {
-		usb_kill_urb(yld->urb_irq);
-		usb_free_urb(yld->urb_irq);
-	}
-        if (yld->urb_ctl)
-		usb_free_urb(yld->urb_ctl);
+	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
+	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
+
         if (yld->idev) {
 		if (err)
 			input_free_device(yld->idev);
@@ -831,6 +828,9 @@ static int usb_cleanup(struct yealink_de
 	if (yld->irq_data)
 		usb_buffer_free(yld->udev, USB_PKT_LEN,
 				yld->irq_data, yld->irq_dma);
+
+	usb_free_urb(yld->urb_irq);	/* parameter validation in core/urb */
+	usb_free_urb(yld->urb_ctl);	/* parameter validation in core/urb */
 	kfree(yld);
 	return err;
 }

--qDbXVdCdHGoSgWSk--
