Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267488AbTA1SLB>; Tue, 28 Jan 2003 13:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267630AbTA1SLB>; Tue, 28 Jan 2003 13:11:01 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:41891 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267488AbTA1SLA>; Tue, 28 Jan 2003 13:11:00 -0500
Date: Tue, 28 Jan 2003 10:28:15 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re:  [CHECKER] 87 potential array bounds error/buffer overruns in
 2.5.53
To: yxie@cs.stanford.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <3E36CBBF.6000309@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ---------------------------------------------------------
> [BUG] possible, but not sure

Call this a USB 1.0 design bug, partially papered over in the code.

There are two adjacent variable length bitmaps.  One of the notable
changes in USB 1.1 was to say the second bitmap isn't really used,
and must be filled with ones.

The code in 2.4.9 (or thereabouts) behaved reasonably here, by
declaring just one single bitmap and expecting users of that bitmap
to cope with its quirkiness.  But somewhere along the line that
bit map got changed to two fixed-size bitmaps.

The checker is basically complaining about a "#define bitmap"
that lets driver code be written to reflect the reality of
two adjacent variable-size bitmaps.  Quite reasonably so.

Somehow, making drivers/usb/core/hub.h go back to having a
more sensible declaration has never been high on the priority
list.  Worth fixing someday, but not a "bug" in the sense of
being incorrect -- only in the sense of being confusing.

- Dave



> /home/yxie/linux-2.5.53/drivers/usb/host/ohci-hub.c:145:ohci_hub_descrip
> tor: ERROR:BUFFER:145:145:Array bounds error (off >= len)
> ((*desc).DeviceRemovable[3], len = 3, off = 3, min(off-len) = 0) 
> 	/* two bitmaps:  ports removable, and usb 1.0 legacy
> PortPwrCtrlMask */
> 	rh = roothub_b (ohci);
> 	desc->bitmap [0] = rh & RH_B_DR;
> 	if (ports > 7) {
> 		desc->bitmap [1] = (rh & RH_B_DR) >> 8;
> 
> Error --->	desc->bitmap [2] = desc->bitmap [3] = 0xff;
> 	} else
> 		desc->bitmap [1] = 0xff;
> }


