Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVJ2KNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVJ2KNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 06:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVJ2KNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 06:13:36 -0400
Received: from mail.suse.de ([195.135.220.2]:65234 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750823AbVJ2KNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 06:13:35 -0400
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [was Re: Linux 2.6.14 ] Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"
Date: Sat, 29 Oct 2005 12:14:34 +0200
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org> <20051028225812.GA6744@localhost.localdomain>
In-Reply-To: <20051028225812.GA6744@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510291214.34718.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 00:58, Ravikiran G Thirumalai wrote:
> On Thu, Oct 27, 2005 at 05:28:50PM -0700, Linus Torvalds wrote:
> >       Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"
>
> (http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=com
>mitdiff;h=79b95a454bb5c1d9b7287d1016a70885ba3f346c)
>
> Well, Andi's patch here wasn't just a small optimization as the changelog
> suggests. It helped EM64T boxes a great deal.  \

First to be honest swiotlb performance is not very high on the priority list. 
It will always be bad. If you care about performance you should use devices 
that can address all your memory.

EM64T server boxes shouldn't have big problems with that because they usually
support AHCI for IDE, and firewire/usb2/sound is not that critical. And the 
EM64T boxes with other chipsets typically don't support >4G phys because they 
only support the lowerend Intel CPUs. Summit might be an exception, but those
normally only use IDE for CDROMs, which are also not a big issue.

> Just to make sure, I 
> reran 2.6.14 with the attached patch and got about 45% better performance
> with iozone Initial write.  This was on a 2 cpu 4 thread SMP Xeon with 8G
> ram, with 2 processes performing io to 4G files on a IDE drive.
> Maybe it wouldn't have caused breakage on some AMD boxes if the following
> additional check for swiotlb was added.  Can this go into 2.6.15 please?

Not in this form no. Problem first needs to be understood fully and
then no_iommu should be set properly.

>   * On AMD64 it mostly equals, but we set it to zero to tell some
> subsystems - * that an IOMMU is available.
> + * that a hard or soft IOMMU is available.
>   */
> -#define PCI_DMA_BUS_IS_PHYS	(no_iommu ? 1 : 0)
> +#define PCI_DMA_BUS_IS_PHYS	((no_iommu && !swiotlb) ? 1 : 0)

That is ugly and I don't like it.  Need to track down the real problem 

-Andi
