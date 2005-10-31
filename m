Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVJaVtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVJaVtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVJaVtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:49:11 -0500
Received: from serv01.siteground.net ([70.85.91.68]:21649 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932536AbVJaVtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:49:10 -0500
Date: Mon, 31 Oct 2005 13:48:59 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [was Re: Linux 2.6.14 ] Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"
Message-ID: <20051031214859.GA3721@localhost.localdomain>
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org> <20051028225812.GA6744@localhost.localdomain> <200510291214.34718.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510291214.34718.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 12:14:34PM +0200, Andi Kleen wrote:
> On Saturday 29 October 2005 00:58, Ravikiran G Thirumalai wrote:
> > On Thu, Oct 27, 2005 at 05:28:50PM -0700, Linus Torvalds wrote:
> > >       Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"
> >
> > (http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=com
> >mitdiff;h=79b95a454bb5c1d9b7287d1016a70885ba3f346c)
> >
> > Well, Andi's patch here wasn't just a small optimization as the changelog
> > suggests. It helped EM64T boxes a great deal.  \
> 
> First to be honest swiotlb performance is not very high on the priority list. 
> It will always be bad. If you care about performance you should use devices 
> that can address all your memory.

I realise swiotlb will have bad performance.  But with the revert, swiotlb
is not going to be used at all!!.  PCI_DMA_BUS_IS_PHYS is used by the block
subsystem to check if any kind of iommu (soft or hard) is available. If none
is present, block layer uses the ISA pool for bounce buffering bringing down 
performance.

> 
> EM64T server boxes shouldn't have big problems with that because they usually
> support AHCI for IDE, and firewire/usb2/sound is not that critical. 

But you have to use SATA disks to use AHCI right?.  IDE disks will work with 
32bit dma addresses only (please correct me if I am wrong).  And I belive 
there are 1U racks/blades out there with IDE disks on these server boards with 
more than 4G memory (I am told it saves them $$ to use IDE disks over SATA
when you deploy large numbers).
Whatever the reasons might be, IMHO, it is not correct to assume no one is 
going to use 32 bit capable only devices on 64bit boxes.  swiotlb code need 
not have been in the kernel otherwise.  This one line revert is just force 
turning off swiotlb on x86_64 boxes with no option whatsover :(

> EM64T boxes with other chipsets typically don't support >4G phys because they 
> only support the lowerend Intel CPUs. Summit might be an exception, but those
> normally only use IDE for CDROMs, which are also not a big issue.
> 
> > Just to make sure, I 
> > reran 2.6.14 with the attached patch and got about 45% better performance
> > with iozone Initial write.  This was on a 2 cpu 4 thread SMP Xeon with 8G
> > ram, with 2 processes performing io to 4G files on a IDE drive.
> > Maybe it wouldn't have caused breakage on some AMD boxes if the following
> > additional check for swiotlb was added.  Can this go into 2.6.15 please?
> 
> Not in this form no. Problem first needs to be understood fully and
> then no_iommu should be set properly.
> 
> >   * On AMD64 it mostly equals, but we set it to zero to tell some
> > subsystems - * that an IOMMU is available.
> > + * that a hard or soft IOMMU is available.
> >   */
> > -#define PCI_DMA_BUS_IS_PHYS	(no_iommu ? 1 : 0)
> > +#define PCI_DMA_BUS_IS_PHYS	((no_iommu && !swiotlb) ? 1 : 0)
> 
> That is ugly and I don't like it.  Need to track down the real problem 

I agree it is ugly.  But it atleast shows and does what the comment says.
Is reverting a bug-fix to mask another bug (probably due to a broken bios or
user not setting the IOMMU in the bios) any cleaner?  Yes it doesn't show
though ;)

Seriously, are there plans to fix the broken AMD boxes for 2.6.15?  Will
swiotlb be forced off even for 2.6.15?  Linus, Andrew?

Thanks,
Kiran
