Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUCCXRB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUCCXQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:16:55 -0500
Received: from ahmler4.mail.eds.com ([192.85.154.77]:45793 "EHLO
	ahmler4.mail.eds.com") by vger.kernel.org with ESMTP
	id S261246AbUCCXQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:16:44 -0500
Message-ID: <7FD257BF8564D4119DA800508BDF07AA0FB51ED8@USAHM012.amer.corp.eds.com>
From: "Bailey, Scott" <scott.bailey@eds.com>
To: "'mjacob@feral.com'" <mjacob@feral.com>
Cc: "Bailey, Scott" <scott.bailey@eds.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [BUG?] Recent feral ISP interaction with alpha dma
Date: Wed, 3 Mar 2004 18:16:28 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a weird problem for which I maybe have an answer except I'm not sure
if it's right. Hopefully the "many eyes" safety net will stop me from doing
anything truly stupid. :-)

I have an Alphaserver 4100 where I have been testing a build of kernel
2.4.24 with the most recent snapshot of the feral isp driver. (A previous
release of the driver, patched onto 2.4.22, is running great but I want to
get onto the newer kernel.)

The system boots happily enough, but eventually I start seeing sequences of:

pci_map_sg failed: could not allocate dma page tables
isp2: unable to dma map request

and processes start wedging.

After poking around in the source, I am suspecting my problem in the feral
isp_pci.c:tdma_mk() where a little snippet goes:

while (resid > 0) {
    nseg++;
    resid -= sg_dma_len(sg);
    sg++;
}

The previous (working) version of this code is:

while (resid > 0) {
    nseg++;
    resid -= sg->length;
    sg++;
}

The problem is, that looking at arch/alpha/kernel/pci_iommu.c:sg_classify()
in the recent 2.4 kernels, I see that sg->dma_length only gets filled in for
scatterlist elements that are leaders. I suspect the non-leader elements
contain crud that confuse the resid count in unpredictable ways.

The question for everybody: is it better to fix this by reverting the
isp_pci.c stuff to refer to sg->length again instead of sg->dma_length, so
that I'm always referencing a valid quantity, or should I tweak pci_iommu.c
so it sets this value to 0 for non-leader elements (and ignore the fact that
code may still not be paying attention to sg->dma_address before making
decisions about the element)?

I couldn't figure out what other architectures were doing from sniffing
around the other directories.

What will break the least? :-)

Thanks,

	Scott Bailey
	scott <dot> bailey <at> eds <dot> com
