Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbUDFUIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbUDFUHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:07:21 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:27377 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S263978AbUDFUGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:06:51 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] 2.6.5-rc3-mm4 breaks xsane, hangs on device scan at launch
Date: Tue, 6 Apr 2004 16:06:49 -0400
User-Agent: KMail/1.6
References: <200404032113.01355.gene.heskett@verizon.net> <200404061334.49888.gene.heskett@verizon.net> <407300D0.4030100@pacbell.net>
In-Reply-To: <407300D0.4030100@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z3wcAu0rwg7wT3m"
Message-Id: <200404061606.49587.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.9.226] at Tue, 6 Apr 2004 15:06:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Z3wcAu0rwg7wT3m
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 06 April 2004 15:11, David Brownell wrote:
>Gene Heskett wrote:
>> Nope, 2.6.5-mm1 hangs xsane just like 2.6.5-rc3-mm4 did...
>
>Ah, I think I see the problem.  This .text.lock.devio entry is more
>like devio::driver_disconnect(), which wouldn't previously have been
>called on that path.
>
>Try this patch.

Well, if you were a trophy hunter, I'd have to say "Skin that one, 
take it to the taxidermist and mount it on the wall, Dave" :-)

2.6.5-mm1 & xsane works again.  I'd assume that 2.6.5-rc3-mm4 would 
also respond correctly to this patch, but of course I haven't tried 
it.

Good catch & many thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

--Boundary-00=_Z3wcAu0rwg7wT3m
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Diff-xsane-hang"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Diff-xsane-hang"

Disable a usbfs disconnect() synchronization hack, which recently
started deadlocking because this routine is now called in a different 
context.

It shouldn't be needed any longer now that usbcore shuts down endpoints
as part of driver unbinding.  (Except maybe on UHCI, which will have
canceled but not necessarily completed all requests.)


--- 1.60/drivers/usb/core/devio.c	Tue Mar 30 09:19:53 2004
+++ edited/drivers/usb/core/devio.c	Tue Apr  6 12:07:06 2004
@@ -339,18 +339,17 @@
 	if (!ps)
 		return;
 
-	/* this waits till synchronous requests complete */
-	down_write (&ps->devsem);
+	/* NOTE:  this relies on usbcore having canceled and completed
+	 * all pending I/O requests; 2.6 does that.
+	 */
 
 	/* prevent new I/O requests */
 	ps->dev = 0;
-	ps->ifclaimed = 0;
+	clear_bit(intf->cur_altsetting->desc.bInterfaceNumber, &ps->ifclaimed);
 	usb_set_intfdata (intf, NULL);
 
 	/* force async requests to complete */
 	destroy_all_async (ps);
-
-	up_write (&ps->devsem);
 }
 
 struct usb_driver usbdevfs_driver = {

--Boundary-00=_Z3wcAu0rwg7wT3m--
