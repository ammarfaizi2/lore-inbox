Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUCDSRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUCDSRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:17:51 -0500
Received: from ahmler1.mail.eds.com ([192.85.154.71]:40592 "EHLO
	ahmler1.mail.eds.com") by vger.kernel.org with ESMTP
	id S262062AbUCDSRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:17:18 -0500
Message-ID: <7FD257BF8564D4119DA800508BDF07AA0FB51EDD@USAHM012.amer.corp.eds.com>
From: "Bailey, Scott" <scott.bailey@eds.com>
To: "'mjacob@feral.com'" <mjacob@feral.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Bailey, Scott" <scott.bailey@eds.com>
Subject: RE: [BUG?] Recent feral ISP interaction with alpha dma
Date: Thu, 4 Mar 2004 13:17:08 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The scatterlist code in sg_classify isn't quite what you need to look
>at- this sets up some kind of private scheme in alpha which then gets
>decoded into an output list in sg_fill where it looks like more
>dma_length entries get filled than the 'leader'.

Okay, I see that now. I was so busy looking for sg-> stuff that the
rewriting using out-> went right past me. My head still hurts from trying to
understand the transformations. :-)

Anyway, my kernel built from the Debian kernel-source-2.4.22-5 package with
I think about the 10/31/2003 release of the feral ISP driver works like a
dream on my Alphaserver 4100, so everything is definitely okay at that
point. There appear to have been no intervening changes to pci_iommu.c, so
that rules any really obvious typos... :-) Thus I wonder if the isp driver
may be feeding subtly different input to these routines.

Looking at the current state of affairs with the Debian
kernel-source-2.4.24-3 package and using the feral driver sources slurped
from your bitkeeper repository, I get the dma errors:

	pci_map_sg failed: could not allocate dma page tables
	isp2: unable to dma map request

There are three routines in pci_isp.c that call pci_map_sg:

- tdma_mk(). I mentioned this in my first e-mail, but on reflection
(actually, staring at paper printout) I see it actually is encapsulated in a
"#ifdef LINUX_ISP_TARGET_MODE" block, and I don't have that defined, so it
couldn't be this routine.

- tdma_mkfc(). Except that I believe this is still within the same #ifdef
block, and appears to be used for fibre channel, which I don't have, so this
also is eliminated as a suspect.

- isp_pci_dmasetup(). By process of elimination, I believe the call to
pci_map_sg() must have come from here. The "unable to dma map request" could
only have occurred when:

1. pci_isp.c:isp_pci_dmasetup() is called with Cmnd->use_sg != 0
2. the call to arch/alpha/kernel/pci_iommu.c:pci_map_sg() returns a value of
0

So my earlier blather about page counting appears to be totally irrelevant.
:-)

But I don't see any changes between old (happy) and new (dma-challenged)
isp_pci_dmasetup() prior to the point of the error, and you do minimal
transformation of inputs to get arguments for pci_map_sg(), so I get the
feeling maybe you are getting screwed by bad data coming in.

The only place arch/alpha/kernel/pci_iommu.c:pci_map_sg() displays the
"could not allocate dma page tables" error message is after a call to
sg_fill() fails. The circumstances would appear to require that the
scatterlist contain more than 1 entry, and I see sg_fill() will only be
called for scatterlist leaders.

Maybe my disk subsystem is the only thing that is generating multisegment
DMA activity, and this is just a symptom of more general brokenness? I dread
it, but it looks like I may need to add some instrumentation to (and/or
enable some of the debugging stuff in) pci_iommu.c.

Any other gratuitous advice is welcomed,

	Scott
	scott <dot> bailey <at> eds <dot> com
