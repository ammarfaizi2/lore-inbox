Return-Path: <linux-kernel-owner+w=401wt.eu-S1750761AbWLMUel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWLMUel (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWLMUek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:34:40 -0500
Received: from smtp2.belwue.de ([129.143.2.15]:43581 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbWLMUek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:34:40 -0500
Date: Wed, 13 Dec 2006 21:34:16 +0100 (CET)
From: Karsten Weiss <K.Weiss@science-computing.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives //
 memory hole mapping related bug?!
In-Reply-To: <20061213195345.GA16112@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet>
 <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
 <458051FD.1060900@scientia.net> <20061213195345.GA16112@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006, Chris Wedgwood wrote:

> > Any ideas why iommu=disabled in the bios does not solve the issue?
> 
> The kernel will still use the IOMMU if the BIOS doesn't set it up if
> it can, check your dmesg for IOMMU strings, there might be something
> printed to this effect.

FWIW: As far as I understand the linux kernel code (I am no kernel 
developer so please correct me if I am wrong) the PCI dma mapping code is 
abstracted by struct dma_mapping_ops. I.e. there are currently four 
possible implementations for x86_64 (see linux-2.6/arch/x86_64/kernel/)

1. pci-nommu.c : no IOMMU at all (e.g. because you have < 4 GB memory)
   Kernel boot message: "PCI-DMA: Disabling IOMMU."

2. pci-gart.c : (AMD) Hardware-IOMMU.
   Kernel boot message: "PCI-DMA: using GART IOMMU" (this message
   first appeared in 2.6.16)

3. pci-swiotlb.c : Software-IOMMU (used e.g. if there is no hw iommu)
   Kernel boot message: "PCI-DMA: Using software bounce buffering 
   for IO (SWIOTLB)"

4. pci-calgary.c : Calgary HW-IOMMU from IBM; used in pSeries servers. 
   This HW-IOMMU supports dma address mapping with memory proctection,
   etc.
   Kernel boot message: "PCI-DMA: Using Calgary IOMMU" (since 2.6.18!)

What all this means is that you can use "dmesg|grep ^PCI-DMA:" to see 
which implementation your kernel is currently using.

As far as our problem machines are concerned the "PCI-DMA: using GART 
IOMMU" case is broken (data corruption). But both "PCI-DMA: Disabling 
IOMMU" (trigged with mem=2g) and "PCI-DMA: Using software bounce buffering 
for IO (SWIOTLB)" (triggered with iommu=soft) are stable.

BTW: It would be really great if this area of the kernel would get some 
more and better documentation. The information at 
linux-2.6/Documentation/x86_64/boot_options.txt is very terse. I had to 
read the code to get a *rough* idea what all the "iommu=" options 
actually do and how they interact.
 
> > 1) And does this now mean that there's an error in the hardware
> > (chipset or CPU/memcontroller)?
> 
> My guess is it's a kernel bug, I don't know for certain.  Perhaps we
> shaould start making a more comprehensive list of affected kernels &
> CPUs?

BTW: Did someone already open an official bug at 
http://bugzilla.kernel.org ?

Best regards,
Karsten

-- 
__________________________________________creating IT solutions
Dipl.-Inf. Karsten Weiss               science + computing ag
phone:    +49 7071 9457 452            Hagellocher Weg 73
teamline: +49 7071 9457 681            72070 Tuebingen, Germany
email:    knweiss@science-computing.de www.science-computing.de

