Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVJAXcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVJAXcX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVJAXcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:32:23 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:23991 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750901AbVJAXcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:32:22 -0400
Date: Sat, 1 Oct 2005 16:01:27 -0400
From: Christopher Li <chrisl@vmware.com>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux kernel mail list <linux-kernel@vger.kernel.org>
Subject: [PATCH] increase the usbdevfs control transfer buffer size
Message-ID: <20051001200127.GD3453@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the size setup data size.

This happen with a few devices that need to send control transfer
with data exactly 4K. But the devio fail those URB, as it count
setup data as part of the 4K size limit as well.

This patch increase the size limit by 8 byte to allow those setup
transfer to pass through.

In theory the size limit of the setup transfer is 64K data.
But I did not see any device need to use more than 4K of data so far.

Tested with EX200 USB explore used in a VM, (which is one of the device
hit this limit.)


Signed-Off-By: Christopher Li <chrisl@vmware.com>
Index: linux-2.6.13.2/drivers/usb/core/devio.c
===================================================================
--- linux-2.6.13.2.orig/drivers/usb/core/devio.c	2005-09-16 18:02:12.000000000 -0700
+++ linux-2.6.13.2/drivers/usb/core/devio.c	2005-09-28 12:56:37.000000000 -0700
@@ -854,7 +854,7 @@ static int proc_do_submiturb(struct dev_
 				!= USB_ENDPOINT_XFER_CONTROL)
 			return -EINVAL;
 		/* min 8 byte setup packet, max arbitrary */
-		if (uurb->buffer_length < 8 || uurb->buffer_length > PAGE_SIZE)
+		if (uurb->buffer_length < 8 || uurb->buffer_length > PAGE_SIZE + 8)
 			return -EINVAL;
 		if (!(dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
 			return -ENOMEM;
