Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261667AbSI2Umq>; Sun, 29 Sep 2002 16:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261779AbSI2Ump>; Sun, 29 Sep 2002 16:42:45 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:34014 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261667AbSI2Umo>; Sun, 29 Sep 2002 16:42:44 -0400
Date: Sun, 29 Sep 2002 13:48:38 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PROBLEM: kernel BUG in usb-ohci.c:902!
To: Franco Saliola <saliola@polygon.math.cornell.edu>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D976726.4070909@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, if I look at that line in the 2.4.20-pre7 kernel, I see:

	/* likely some interface's driver has a refcount bug */
	err ("bus %s devnum %d deletion in interrupt",
			ohci->ohci_dev->slot_name, usb_dev->devnum);
	BUG ();

That BUG() has been an "oops now predictably, or oops later randomly"
situation, and EVERY (!!!) time it's been an issue, the problem has
been traced to exactly what that comment says:  some interface's
driver has bogus disconnect() processing, and is not cleaning up. (*)

It's likely the problem is in the driver for one of your USB devices.
Given what I saw, it sure looks like "prism2_usb" is the problem.

And from what I saw last time I looked at that driver, I can VERY
easily believe that ... in fact I think I've seen similar reports
show up before, that's why I took a look at it.  The prism2_usb folk
need to make sure their disconnect() routine (a) prevents all further
driver requests to that device, (b) unlinks all urbs it submitted,
and (c) waits for them to finish unlinking.

- Dave

(*) Maybe a better response would be to just leak memory, but
     that's how the ohci driver evolved ... it took a long time
     to establish that the oopsing was really caused by bogus
     disconnect() processing in the layered usb device handling.



