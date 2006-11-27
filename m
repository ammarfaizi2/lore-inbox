Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758306AbWK0PkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758306AbWK0PkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 10:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbWK0PkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 10:40:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:45703 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1758304AbWK0PkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 10:40:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y5cfNJGdx675xYKF6a7Cl3vzQf1HYkH4wlEvzGK2O1Osr/5IJt1nSmENcuIwn1x6SPJ+sxK5Y3UAQQ2ZZrxoiW00GL8sju1ues+UThcdCvwfAbLTjzQzn0D/zuTOxHbSQWGsadNvlcnAGwM+57fX4+EdGUIbH3HQ3SylOwUaE8U=
Message-ID: <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>
Date: Mon, 27 Nov 2006 08:39:59 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>
	 <4564C4C7.5060403@s5r6.in-berlin.de>
	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> One thing you could try next is to add a debug logging macro which
> prints the contents of OHCI1394_IntEventClear, OHCI1394_IntEventSet, and
> OHCI1394_IntMaskSet, right after ohci1394's call to
> hpsb_selfid_complete. (I'm merely poking in the dark here.)

I think you've got something!  I managed to provoke failure from 3 of
the 5 interfaces in a single burst of reset clicking!  And yes, all 3
failed interfaces are on the Indigita card, and no, the Fireboard has
never failed.

The last thing I see from the failed interfaces is this:

Nov 27 08:25:51 spanky kernel: ohci1394: fw-host3: PhyReqFilter=0000000000000000
Nov 27 08:25:51 spanky kernel: ohci1394: fw-host3: IntEventClear
00000000 IntEventSet 6ffdc33f IntMaskSet 00000000

which looks very different from the entries by the interfaces that
survive (these are the lines immediately before the one above)

Nov 27 08:25:51 spanky kernel: ohci1394: fw-host4: IntEventClear
00000000 IntEventSet 04508000 IntMaskSet 818300f3
Nov 27 08:25:51 spanky kernel:
Nov 27 08:25:51 spanky kernel: ohci1394: fw-host2: IntEventClear
00000000 IntEventSet 04508000 IntMaskSet 818300f3
Nov 27 08:25:51 spanky kernel:

I'm not sure if this says anything to you except "hey, don't use those
Indigita cards".  The problem is, I can't get the number of ports I
need using only Fireboards (I think I need 6, and I have 5 PCI slots
but need to use some of the other slots).

Is there further diagnostic poking about that I can do to narrow down
the problem?   Is something for Indigita?  The card is pretty basic: 4
of the TI TSB82AA2 (Ice Lynx) links behind a IBM/Tundra PCI-X bridge.
I have an Intel quad ethernet card that uses the exact same part
(well, one rev older, actually).  Here's a chunk of my lspci for
completeness sake:

01:04.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 03)
01:06.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01)
02:04.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01)
02:05.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01)
02:06.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01)
02:07.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01)

I will also try cramming a machine full of Fireboards and seeing if I
can't get one of them to fail.

-- 
Robert Crocombe
rcrocomb@gmail.com
