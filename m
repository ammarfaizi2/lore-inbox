Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUIAUwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUIAUwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUIAUuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:50:54 -0400
Received: from ahmler2.mail.eds.com ([192.85.154.72]:41364 "EHLO
	ahmler2.mail.eds.com") by vger.kernel.org with ESMTP
	id S267519AbUIAUnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:43:32 -0400
Message-ID: <1CF4FE310DCDD3119A1F00508BDF0A6823C3DF9E@usahm019.exmi01.exch.eds.com>
From: "Bailey, Scott" <scott.bailey@EDS.COM>
To: "'mjacob@feral.com'" <mjacob@feral.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Bailey, Scott" <scott.bailey@EDS.COM>
Subject: RE: [BUG?] Recent feral ISP interaction with alpha dma
Date: Wed, 1 Sep 2004 16:42:31 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew, just a quick update for your amusement or peace of mind or
whatever... :-)

I have continued slogging along with this, mostly upgrading to newer kernel
releases as they appeared and trying to ignore the dma errors. I now am up
to kernel 2.4.27, compiled with gcc 3.3.4 (actually Debian's gcc
3.3.4-6sarge1.0.1 package) and amazingly the errors seem to have disappeared
for me. They were always a bit sporadic, so this isn't a totally sure thing,
but I've been running for a couple days now and done all the things that
tending to spazz it out before, and everything has been quite nice.

Maybe something between 2.4.26 and 2.4.27 fixed this, but I have given up
trying to figure out what.

Anyway, I wanted to let you know that your driver is still working fine for
me and I'm really glad to have it, since our Alphaservers are just infested
with QLogic-based KZPBA controllers :-) and I really need to be able to use
disks and tape drives.

Thanks again,

	Scott

R. Scott Bailey
EDS - Software Services Linux/Tru64 UNIX Capability
MS 2O
1075 W. Entrance Dr.
Auburn Hills, MI  48326
 
( Phone:+1-248-276-5770 (8-351)
+ mailto:scott.bailey@eds.com


-----Original Message-----
From: Matthew Jacob [mailto:mjacob@feral.com] 
Sent: Wednesday, March 03, 2004 8:38 PM
To: Bailey, Scott
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: [BUG?] Recent feral ISP interaction with alpha dma



Thanks for spotting this...

Hmm- I guess I never really asked anyone what sg_dma_len was supposed to
apply to.

The best comment about this seems to be in the mips header

/*
 * These macros should be used after a pci_map_sg call has been done
 * to get bus addresses of each of the SG entries and their lengths.
 * You should only work with the number of sg entries pci_map_sg
 * returns, or alternatively stop on the first sg_dma_len(sg) which
 * is 0.
 */

So- I believe I'm using it correctly (well, not quite as I'm not
checking for a length of zero) - I call pci_map_sg, and for each
platform I should be using sg_dma_len- after all, there may be
architectures which don't have sg->length.

The scatterlist code in sg_classify isn't quite what you need to look
at- this sets up some kind of private scheme in alpha which then gets
decoded into an output list in sg_fill where it looks like more
dma_length entries get filled than the 'leader'.

I just gave away my Alphaserver 4100, but I know that the 2.4.18 kernels
used to work with my stuff on it- I wonder what the real issue is?

On Wed, 3 Mar 2004, Bailey, Scott wrote:

> Here's a weird problem for which I maybe have an answer except I'm not
sure
> if it's right. Hopefully the "many eyes" safety net will stop me from
doing
> anything truly stupid. :-)
>
> I have an Alphaserver 4100 where I have been testing a build of kernel
> 2.4.24 with the most recent snapshot of the feral isp driver. (A previous
> release of the driver, patched onto 2.4.22, is running great but I want to
> get onto the newer kernel.)
>
> The system boots happily enough, but eventually I start seeing sequences
of:
>
> pci_map_sg failed: could not allocate dma page tables
> isp2: unable to dma map request
>
> and processes start wedging.
>
> After poking around in the source, I am suspecting my problem in the feral
> isp_pci.c:tdma_mk() where a little snippet goes:
>
> while (resid > 0) {
>     nseg++;
>     resid -= sg_dma_len(sg);
>     sg++;
> }
>
> The previous (working) version of this code is:
>
> while (resid > 0) {
>     nseg++;
>     resid -= sg->length;
>     sg++;
> }
>
> The problem is, that looking at
arch/alpha/kernel/pci_iommu.c:sg_classify()
> in the recent 2.4 kernels, I see that sg->dma_length only gets filled in
for
> scatterlist elements that are leaders. I suspect the non-leader elements
> contain crud that confuse the resid count in unpredictable ways.
>
> The question for everybody: is it better to fix this by reverting the
> isp_pci.c stuff to refer to sg->length again instead of sg->dma_length, so
> that I'm always referencing a valid quantity, or should I tweak
pci_iommu.c
> so it sets this value to 0 for non-leader elements (and ignore the fact
that
> code may still not be paying attention to sg->dma_address before making
> decisions about the element)?
>
> I couldn't figure out what other architectures were doing from sniffing
> around the other directories.
>
> What will break the least? :-)
>
> Thanks,
>
> 	Scott Bailey
> 	scott <dot> bailey <at> eds <dot> com
>
