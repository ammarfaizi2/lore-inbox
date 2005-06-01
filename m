Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFAVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFAVUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVFAUpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:45:18 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:64747 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261205AbVFAUhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:37:36 -0400
From: David Brownell <david-b@pacbell.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: External USB2 HDD affects speed hda
Date: Wed, 1 Jun 2005 13:37:29 -0700
User-Agent: KMail/1.7.1
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Mark Lord <lkml@rtr.ca>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <429BA001.2030405@keyaccess.nl> <429E0965.1090809@vc.cvut.cz> <429E1049.20903@keyaccess.nl>
In-Reply-To: <429E1049.20903@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011337.29656.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 12:45 pm, Rene Herman wrote:
> Petr Vandrovec wrote:
> 
> > Rene Herman wrote:
> 
> >> No, that's not it. Both ide0 (14) and EHCI (3) are on private, 
> >> unshared IRQs. rmmodding ehci_hcd as per Pavel's sugestion gets me 
> >> back my speed. Exactly _why_ I've no idea though. I've just added you 
> >> to the CC on that reply...
> > 
> > 
> > Because EHCI hardware continuously watches some memory area to
> > find whether there are some transfers from host to your USB
> > devices ready... 

No it doesn't ... it's not supposed to issue any DMA requests unless
it's been told to do so by activating one of the two transfer schedules
(async or periodic).  The problem Rene is seeing is altoghether more
wierd than that.

So for example USB network drivers do something similar ... they post
a read, and so the EHCI controller will be polling more or less eight
times per millisecond, even if no other USB transfers are active.  It's
never going to be "continuously"; and network drivers are atypical.

But something like usb-storage isn't going to post a request until
it's told to read or write a disk block, which means there'll be no
need for DMA most of the time.  And no DMA activity.

You might be thinking about UHCI, which _will_ do DMA all the time
and has no way to turn off the DMA.  Or even OHCI in certain modes,
where it'll write a frame counter to memory once per millisecond
unless the controller suspended itself.


> > You just need better memory bandwidth so all 
> > your devices transfers fit on your bus.  Or maybe EHCI driver
> > could program hardware to not query transfer descriptors
> > that often. But it would increase latency for people
> > who use USB only and do not care about other parts of system.
> 
> I see. I was totally unaware of that, many thanks for the information. 
> Getting more memory bandwidth (to/from the PCI bus at least) will have 
> to wait for my next system, I suppose.
> 
> Added EHCI maintainer to this one as well. If possible, this looks like 
> a good candidate for a /proc or /sys knob?

No, it's based on a mis-understanding of the hardware.

The controller should only be doing DMA when some driver has submitted
an URB and that URB hasn't yet completed.  Pretty much like any other
hardware, like a disk or network controller.


> Or maybe even starting out with a low querying frequency and dynamically 
> adjusting it up (and down again!) with traffic? Probably not that. I'd 
> like to have the knob though, so that I can have EHCI builtin and still 
> tell the controller to take it easy (certainly after I've switched of 
> the external HDD again, but on this system possibly also while in use).

For periodic transfers -- interrupt, isochronous, neither used for
disk I/O -- the driver issuing the transfer always has control over
the polling period.  But that's mostly related to the USB activity;
if a periodic transfer is active, then the current segment of the
periodic schedule has to be scanned (by DMA) every microframe (8x/msec).
If that segment is empty, that's just one word (32 bits).  If there
are transfers, it's got to read them and maybe perform them.

- Dave



> 
> Rene.
> 
