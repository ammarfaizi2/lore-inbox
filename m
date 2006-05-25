Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWEYHWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWEYHWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWEYHWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:22:07 -0400
Received: from mkedef2.rockwellautomation.com ([63.161.86.254]:15683 "EHLO
	ramilwsmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S965068AbWEYHVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:21:43 -0400
Message-ID: <44755B31.9020204@ra.rockwell.com>
Date: Thu, 25 May 2006 09:22:25 +0200
From: Milan Svoboda <msvoboda@ra.rockwell.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] usb gadget: update pxa2xx_udc.c driver to fully support
 IXP4xx platform
X-MIMETrack: Itemize by SMTP Server on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release
 6.5.4FP1|June 19, 2005) at 05/25/2006 02:22:27 AM,
	Serialize by Router on RAMilwSMTP01/Milwaukee/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 05/25/2006 02:22:28 AM,
	Serialize complete at 05/25/2006 02:22:28 AM
Content-Type: multipart/mixed;
 boundary="------------000309010107090901060402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000309010107090901060402
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

From: Milan Svoboda <msvoboda@ra.rockwell.com>

This patch adds IXP465 into the list of known devices and
adds IXP465 to the list of devices that have cfr. This
is not described in the hardware documentation, but without
it driver don't work.

Workaround (#if 1) that seemed to get rid of lost
status irqs is disabled for IXP4XX as it caused freezes
during testing of control messages. No lost irqs are
visible on IXP4XX.

Driver survived tests running over night without any
visible problems.

This patch is against 2.6.16.13 with previous patches applied.

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
---




--------------000309010107090901060402
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="work_with_ixp465.patch"
Content-Disposition: inline;
 filename="work_with_ixp465.patch"

--- orig/drivers/usb/gadget/pxa2xx_udc.c	2006-05-15 16:08:27.000000000 +0000
+++ new_gadget/drivers/usb/gadget/pxa2xx_udc.c	2006-05-15 15:59:13.000000000 +0000
@@ -548,6 +548,7 @@ write_ep0_fifo (struct pxa2xx_ep *ep, st
 		count = req->req.length;
 		done (ep, req, 0);
 		ep0_idle(ep->dev);
+#ifndef CONFIG_ARCH_IXP4XX
 #if 1
 		/* This seems to get rid of lost status irqs in some cases:
 		 * host responds quickly, or next request involves config
@@ -568,6 +569,7 @@ write_ep0_fifo (struct pxa2xx_ep *ep, st
 			} while (count);
 		}
 #endif
+#endif
 	} else if (ep->dev->req_pending)
 		ep0start(ep->dev, 0, "IN");
 	return is_short;
@@ -2430,6 +2432,7 @@ static struct pxa2xx_udc memory = {
 #define PXA210_B1		0x00000123
 #define PXA210_B0		0x00000122
 #define IXP425_A0		0x000001c1
+#define IXP465_AD		0x00000200
 
 /*
  * 	probe - binds to the platform device
@@ -2465,6 +2468,9 @@ static int pxa2xx_udc_probe(struct platf
 	case PXA250_C0: case PXA210_C0:
 		break;
 #elif	defined(CONFIG_ARCH_IXP4XX)
+	case IXP465_AD:
+		dev->has_cfr = 1;
+		/* fall through */
 	case IXP425_A0:
 		out_dma = 0;
 		break;





--------------000309010107090901060402--
