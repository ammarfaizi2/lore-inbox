Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSHFWxr>; Tue, 6 Aug 2002 18:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSHFWxr>; Tue, 6 Aug 2002 18:53:47 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:225 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316667AbSHFWxm>;
	Tue, 6 Aug 2002 18:53:42 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15696.21218.406438.634687@argo.ozlabs.ibm.com>
Date: Wed, 7 Aug 2002 08:51:14 +1000 (EST)
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] USB root hub polling and suspend
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently with 2.5, when I suspend and resume my powerbook, I find
that the USB subsystem no longer sees root hub events, i.e. it doesn't
notice when I plug in a new USB device (it doesn't notice when I
unplug a device either but of course the driver for the device sees
that it is no longer responding).

It turns out that what happens is that the root hub timer goes off
after the OHCI driver has done its suspend stuff.  The timer routine
sees that the HCD is not running at the moment and doesn't schedule
another timeout.  Hence the series of timeouts stops.

The patch below fixes the problem for me.  Comments welcome.

Paul.

diff -urN linuxppc-2.5/drivers/usb/core/hcd.c pmac-2.5/drivers/usb/core/hcd.c
--- linuxppc-2.5/drivers/usb/core/hcd.c	Sun Jul 21 12:58:49 2002
+++ pmac-2.5/drivers/usb/core/hcd.c	Tue Jul 23 22:21:25 2002
@@ -454,7 +454,6 @@
 	/* rh_timer protected by hcd_data_lock */
 	if (timer_pending (&hcd->rh_timer)
 			|| urb->status != -EINPROGRESS
-			|| !HCD_IS_RUNNING (hcd->state)
 			|| urb->transfer_buffer_length < len) {
 		dbg ("not queuing status urb, stat %d", urb->status);
 		return -EINVAL;
@@ -508,8 +507,12 @@
 				BUG ();
 			}
 			spin_unlock_irqrestore (&hcd_data_lock, flags);
-		} else
+		} else {
 			spin_unlock_irqrestore (&urb->lock, flags);
+			spin_lock_irqsave (&hcd_data_lock, flags);
+			rh_status_urb (hcd, urb);
+			spin_unlock_irqrestore (&hcd_data_lock, flags);
+		}
 	} else {
 		/* this urb's been unlinked */
 		urb->hcpriv = 0;
