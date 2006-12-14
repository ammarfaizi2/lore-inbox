Return-Path: <linux-kernel-owner+w=401wt.eu-S932642AbWLNL5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWLNL5E (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbWLNL5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:57:04 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:2578 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642AbWLNL5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:57:01 -0500
Date: Thu, 14 Dec 2006 13:56:58 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Karsten Weiss <K.Weiss@science-computing.de>
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214115658.GR6674@rhun.haifa.ibm.com>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <458051FD.1060900@scientia.net> <20061213195345.GA16112@tuatara.stupidest.org> <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de> <20061214092208.GB6674@rhun.haifa.ibm.com> <Pine.LNX.4.61.0612141215590.17792@palpatine.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612141215590.17792@palpatine.science-computing.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:38:08PM +0100, Karsten Weiss wrote:
> On Thu, 14 Dec 2006, Muli Ben-Yehuda wrote:
> 
> > On Wed, Dec 13, 2006 at 09:34:16PM +0100, Karsten Weiss wrote:
> > 
> > > BTW: It would be really great if this area of the kernel would get some 
> > > more and better documentation. The information at 
> > > linux-2.6/Documentation/x86_64/boot_options.txt is very terse. I had to 
> > > read the code to get a *rough* idea what all the "iommu=" options 
> > > actually do and how they interact.
> > 
> > Patches happily accepted :-)
> 
> Well, you asked for it. :-) So here's my little contribution. Please 
> *double* *check*!

Looks good, some nits below.

> (BTW: I would like to know what "DAC" and "SAC" means in this
> context)

Single / Double Address Cycle. DAC is used with 32-bit PCI to push a
64-bit address in two cycles.

> @@ -458,6 +458,11 @@
>  # need this always selected by IOMMU for the VIA workaround
>  config SWIOTLB
>  	bool
> +	help
> +	  Support for a software bounce buffer based IOMMU used on Intel
> +	  systems which don't have a hardware IOMMU. Using this code
> +	  PCI devices with 32bit memory access only are able to be
> +	  used on systems with more than 3 GB.

I would rephrase as follows: "Support for software bounce buffers used
on x86-64 systems which don't have a hardware IOMMU. Using this PCI
devices which can only access 32-bits of memory can be used on systems
with more than 3 GB of memory".

> +   size             set size of IOMMU (in bytes)

Due to historical precedence, some of these options are only valid for
GART. Perhaps mention for each option which IOMMUs it is valid for or
split them on a per IOMMU basis?

This one (size) is gart only.

> +   noagp            don't initialize the AGP driver and use full
>     aperture.

gart only.

> +   off              don't initialize and use any kind of IOMMU.

all.

> +   leak             turn on simple iommu leak tracing (only when
> +                    CONFIG_IOMMU_LEAK is on)

gart only.

> +   memaper[=order]  allocate an own aperture over RAM with size 32MB<<order.
> +                    (default: order=1, i.e. 64MB)

gart only.

> +   noforce          don't force hardware IOMMU usage when it is not needed.
> +                    (default).

all.

> +   force            Force the use of the hardware IOMMU even when it is
> +                    not actually needed (e.g. because < 3 GB
>                      memory).

all.

> +   merge            Do scather-gather (SG) merging. Implies force
>     (experimental)

gart only.

> +   nomerge          Don't do scather-gather (SG) merging.

gart only.

> +   forcesac         For SAC mode for masks <40bits  (experimental)

gart only.

> +   fullflush        Flush AMD GART based hardware IOMMU on each allocation
> +                    (default)

gart only.

> +   nofullflush      Don't use IOMMU fullflush

gart only.

> +   allowed          overwrite iommu off workarounds for specific
>     chipsets.

gart only.

> +   soft             Use software bounce buffering (SWIOTLB) (default for Intel
> +                    machines). This can be used to prevent the usage
> +                    of a available hardware IOMMU.

all.

> +   noaperture       Ask the AMD GART based hardware IOMMU driver not to 
> +                    touch the aperture for AGP.

gart only.

> +   allowdac         Allow DMA >4GB
> +                    When off all DMA over >4GB is forced through an IOMMU or
> +                    bounce buffering.

gart only.

> +   nodac            Forbid DMA >4GB

gart only.

> +   panic            Always panic when IOMMU overflows

gart and Calgary.

The rest looks good. Please resend and I'll add my Acked-by.

Cheers,
Muli
