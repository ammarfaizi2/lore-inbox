Return-Path: <linux-kernel-owner+w=401wt.eu-S1030687AbWLPHqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030687AbWLPHqP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 02:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030694AbWLPHqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 02:46:15 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51655 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030687AbWLPHqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 02:46:14 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 02:46:14 EST
X-Originating-Ip: 216.16.235.2
Date: Sat, 16 Dec 2006 02:37:42 -0500
From: Chris Frey <cdfrey@foursquare.net>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix to usbfs_snoop logging of user defined control urbs
Message-ID: <20061216073742.GA23625@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.275, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	SARE_OBFU_VALUE 0.53)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH,

According to a Linux Journal article, you were the original author of the
usbfs_snoop patch, so I'm sending this patch to you.

When sending CONTROL URB's using the usual CONTROL ioctl, logging works
fine, but when sending them via SUBMITURB, like VMWare does, the
control fields are not logged.  This patch fixes that.

I didn't see any major changes to devio.c recently, so this patch should apply
cleanly to even the latest kernel.  I can resubmit if it doesn't.

Take care,
- Chris


diff -ru linux-2.6.18.1/drivers/usb/core/devio.c linux-2.6.18.1-cdf/drivers/usb/core/devio.c
--- linux-2.6.18.1/drivers/usb/core/devio.c	2006-10-13 23:34:03.000000000 -0400
+++ linux-2.6.18.1-cdf/drivers/usb/core/devio.c	2006-12-15 17:00:48.000000000 -0500
@@ -950,7 +950,11 @@
 			kfree(dr);
 			return -EFAULT;
 		}
-		snoop(&ps->dev->dev, "control urb\n");
+		snoop(&ps->dev->dev, "control urb: bRequest=%02x "
+			"bRrequestType=%02x wValue=%04x "
+			"wIndex=%04x wLength=%04x\n",
+			dr->bRequest, dr->bRequestType, dr->wValue,
+			dr->wIndex, dr->wLength);
 		break;
 
 	case USBDEVFS_URB_TYPE_BULK:

