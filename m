Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUCDBig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUCDBig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:38:36 -0500
Received: from ns1.feral.com ([192.67.166.1]:8712 "EHLO ns1.feral.com")
	by vger.kernel.org with ESMTP id S261390AbUCDBid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:38:33 -0500
Date: Wed, 3 Mar 2004 17:38:29 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
X-X-Sender: mjacob@quaver.in1.lcl
Reply-To: mjacob@feral.com
To: "Bailey, Scott" <scott.bailey@eds.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] Recent feral ISP interaction with alpha dma
In-Reply-To: <7FD257BF8564D4119DA800508BDF07AA0FB51ED8@USAHM012.amer.corp.eds.com>
Message-ID: <20040303172418.W58994@quaver.in1.lcl>
References: <7FD257BF8564D4119DA800508BDF07AA0FB51ED8@USAHM012.amer.corp.eds.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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

> Here's a weird problem for which I maybe have an answer except I'm not sure
> if it's right. Hopefully the "many eyes" safety net will stop me from doing
> anything truly stupid. :-)
>
> I have an Alphaserver 4100 where I have been testing a build of kernel
> 2.4.24 with the most recent snapshot of the feral isp driver. (A previous
> release of the driver, patched onto 2.4.22, is running great but I want to
> get onto the newer kernel.)
>
> The system boots happily enough, but eventually I start seeing sequences of:
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
> The problem is, that looking at arch/alpha/kernel/pci_iommu.c:sg_classify()
> in the recent 2.4 kernels, I see that sg->dma_length only gets filled in for
> scatterlist elements that are leaders. I suspect the non-leader elements
> contain crud that confuse the resid count in unpredictable ways.
>
> The question for everybody: is it better to fix this by reverting the
> isp_pci.c stuff to refer to sg->length again instead of sg->dma_length, so
> that I'm always referencing a valid quantity, or should I tweak pci_iommu.c
> so it sets this value to 0 for non-leader elements (and ignore the fact that
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
