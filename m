Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVAIQso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVAIQso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 11:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVAIQso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 11:48:44 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:679 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261592AbVAIQsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 11:48:39 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: for USB guys - strange things in dmesg
Date: Sun, 9 Jan 2005 08:48:37 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lBW4Bfd/dj8m/Dy"
Message-Id: <200501090848.37978.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_lBW4Bfd/dj8m/Dy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Pete Zaitcev writes:
> What happens here is that the device disconnects itself during or after
> it's initialized.
> 
> Once the HC hardware detects the disconnect, future URBs will end with
> -84 error. However, the HID driver does not do anything about it.

Right ... -EILSEQ one of those awkward faults that can appear both during
disconnect processing and during normal operation.  So it's never clear
when a driver should treat it as fatal or try to recover.


> It continues to attempt to resubmit until the khubd does its processing
> and enters its disconnect method. In extreme cases, it is possible to
> have this submit-and-error-and-repeat loop to monopolize the CPU and
> prevent khubd from working ever, thus effectively locking up the box.

Right ... these being two separate problems:  (a) too much resubmitting,
and (b) too much printk.  The resubmitting is barely noticeable in terms
of load (and HID doesn't track such faults), but the printks are trouble.

For (b), printk_ratelimit() would be an appropriate fix for HID and
other drivers that log this fault and then attempt to recover by
resubmitting.  The attached patch should help.


> Fortunately, in 2.6 kernel we standardized error codes, and thus drivers
> like hid can rely on -84 meaning a disconnect and not something else.

That's not  true; -EILSEQ doesn't always indicate disconnect.
See Documentation/usb/error-oodes.txt ...


> In such case, hid has to stop resubmitting before its disconnect method
> is executed.
> 
> This is relevant to all drivers which submit interrupt URBs. One driver
> which does it correctly is mct_u232 (surprisingly enough), so the code
> can be taken from there.

Since mct_u232 treats -EILSEQ as always-fatal, when it's not, that's not
the best example.  I think a better example is usbnet, which handles this
fault -- for bulk RX and TX of network packets, it doesn't currently use
interrupt URBs! -- by briefly throttling back traffic.  (It also has more
complete handling of other urb->status values than most other drivers.)

During disconnect processing, there's neither log flooding nor hundreds of
false network errors; during normal processing, there's still a chance for
hardware to recover itself.

- Dave

--Boundary-00=_lBW4Bfd/dj8m/Dy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hid.patch"

Ratelimit some HID messages that can happen during disconnect processing.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- 1.105/drivers/usb/input/hid-core.c	2005-01-07 20:55:37 -08:00
+++ edited/drivers/usb/input/hid-core.c	2005-01-09 08:40:17 -08:00
@@ -931,7 +931,9 @@
 		case -ETIMEDOUT:	/* NAK */
 			break;
 		default:		/* error */
-			warn("input irq status %d received", urb->status);
+			if (!printk_ratelimit())
+				warn("input irq status %d received",
+						urb->status);
 	}
 	
 	status = usb_submit_urb(urb, SLAB_ATOMIC);

--Boundary-00=_lBW4Bfd/dj8m/Dy--
