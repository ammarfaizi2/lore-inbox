Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVATIn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVATIn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVATIn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:43:27 -0500
Received: from canuck.infradead.org ([205.233.218.70]:12297 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262079AbVATInT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:43:19 -0500
Subject: Re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage
	oops]
From: David Woodhouse <dwmw2@infradead.org>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <E1CrPQ4-0000pW-00@penngrove.fdns.net>
References: <E1CrPQ4-0000pW-00@penngrove.fdns.net>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 08:40:07 +0000
Message-Id: <1106210408.6932.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 15:39 -0800, John Mock wrote:
> New to 2.6.11-rc1 is that 'lsusb' exhibits 'endian' problems on the
> PowerMac.

Is that really new to 2.6.11-rc1? The kernel byte-swaps the bcdUSB,
idVendor, idProduct, and bcdDevice fields in the device descriptor. It
should probably swap them back before copying it up to userspace.

===== drivers/usb/core/devio.c 1.93 vs edited =====
--- 1.93/drivers/usb/core/devio.c	2004-12-16 23:35:55 +00:00
+++ edited/drivers/usb/core/devio.c	2005-01-20 08:33:50 +00:00
@@ -123,13 +123,26 @@
 	}
 
 	if (pos < sizeof(struct usb_device_descriptor)) {
+		struct usb_device_descriptor *desc = kmalloc(sizeof(*desc), GFP_KERNEL);
+		if (!desc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		memcpy(desc, &dev->descriptor, sizeof(dev->descriptor));
+		le16_to_cpus(&desc->bcdUSB);
+		le16_to_cpus(&desc->idVendor);
+		le16_to_cpus(&desc->idProduct);
+		le16_to_cpus(&desc->bcdDevice);
+
 		len = sizeof(struct usb_device_descriptor) - pos;
 		if (len > nbytes)
 			len = nbytes;
-		if (copy_to_user(buf, ((char *)&dev->descriptor) + pos, len)) {
+		if (copy_to_user(buf, ((char *)desc) + pos, len)) {
+			kfree(desc);
 			ret = -EFAULT;
 			goto err;
 		}
+		kfree(desc);
 
 		*ppos += len;
 		buf += len;


-- 
dwmw2

