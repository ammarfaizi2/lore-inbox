Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTDPPdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTDPPdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:33:37 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:63957 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264539AbTDPPdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:33:17 -0400
Date: Wed, 16 Apr 2003 17:45:04 +0200
Subject: PATCH: usb-ohci: interrupt out with urb->interval 0 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v551)
Cc: linux-kernel@vger.kernel.org
To: weissg@vienna.at
From: Frode Isaksen <fisaksen@bewan.com>
Content-Transfer-Encoding: 7bit
Message-Id: <6451EBA9-7022-11D7-8F05-003065EF6010@bewan.com>
X-Mailer: Apple Mail (2.551)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the usb-ohci driver, the interrupt out transfer is always 
rescheduled, even if the urb->interval is set to 0 to signal a one-shot 
transfer.
The other usb drivers (usb-uhci,uhci) allows one-shot interrupt out 
transfers.
Tested with kernel 2.4.21 and previous kernels.

Thanks,
Frode

--- drivers/usb/usb-ohci.c.orig	2003-04-16 15:42:46.000000000 +0200
+++ drivers/usb/usb-ohci.c	2003-04-16 15:45:41.000000000 +0200
@@ -490,12 +490,17 @@
  				usb_pipeout (urb->pipe)
  					? PCI_DMA_TODEVICE
  					: PCI_DMA_FROMDEVICE);
-			urb->complete (urb);
+			if (urb->interval) {
+				urb->complete (urb);

-			/* implicitly requeued */
-  			urb->actual_length = 0;
-			urb->status = -EINPROGRESS;
-			td_submit_urb (urb);
+				/* implicitly requeued */
+				urb->actual_length = 0;
+				urb->status = -EINPROGRESS;
+				td_submit_urb (urb);
+			} else {
+				urb_rm_priv(urb);
+				urb->complete (urb);
+			}
    			break;
    			
  		case PIPE_ISOCHRONOUS:

