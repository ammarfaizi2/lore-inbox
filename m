Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWIMXKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWIMXKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWIMXKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 19:10:19 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:59063 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751073AbWIMXKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 19:10:18 -0400
Subject: Re: [RFC] patch[1/1] i386 numa kva conversion to
	use	bootmem	reserve
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <45066F1D.8000203@shadowen.org>
References: <1150871711.8518.61.camel@keithlap>
	 <45037B5F.1080509@shadowen.org> <1158000628.5755.48.camel@keithlap>
	 <4505D8D3.1000301@shadowen.org> <1158017404.7284.35.camel@keithlap>
	 <45066F1D.8000203@shadowen.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Wed, 13 Sep 2006 16:10:15 -0700
Message-Id: <1158189015.5683.50.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 09:26 +0100, Andy Whitcroft wrote:
> keith mannthey wrote:
> > On Mon, 2006-09-11 at 22:44 +0100, Andy Whitcroft wrote:
> > 
> > 
> >>>> The primary reason that the mem_map is cut from the end of ZONE_NORMAL
> >>>> is so that memory that would back that stolen KVA gets pushed out into
> >>>> ZONE_HIGHMEM, the boundary between them is moved down.  By using
> >>>> reserve_bootmem we will mark the pages which are currently backing the
> >>>> KVA you are 'reusing' as reserved and prevent their release; we pay
> >>>> double for the mem_map.
> >>> Perhaps just freeing the reserve pages and remapping them at an
> >>> appropriate time could accomplish this?  Sorry I don't know the KVA
> >>> "freeing" path can you describe it a little more?  When are these pages
> >>> returned to the system?  It was my understanding that that KVA pages
> >>> were lost (the original wayu shrinks ZONE_NORMAL and creates a hole
> >>> between the zones).
> >>
> >> No it does seem like we loose the memory at the end of NORMAL when we
> >> shrink it, but really happens is we move the boundary down. Any page
> >> above the boundary is then in HIGHMEM and available to be allocated.
> > 
> > How is it available for allocation?  I see it is in highmem but the
> > pmd's for the kva area are set with node local information.  I don't see
> > any special code to reclaim the kva area or extend ZONE_HIGHMEM.... How
> > does having the KVA area in ZONE_HIGHMEM allow you to reclaim it?
> > (sorry if this is an easy question but I an still sorting out how it is
> > "reclaimed" in the original implementation and why it can't be reclaimed
> > as part of ZONE_NORMAL). 
> 
> If the boundary is at page 1024 then pages 0-1024 are direct mapped into
> KVA, page 1024 is not mapped at all and part of HIGHMEM, when that zone
> is freed up later those pages will be in the HIGHMEM zone and
> allocatable.  Move the boundary down to 1000 then 24 pages of KVA will
> no longer be used as direct maps, and pages from 1000 onwards are in
> zone HIGHMEM, non direct mapped, but available to allocatable.  Cut a
> section out of the middle of NORMAL and you just have to bin the pages
> 'behind' that KVA as you can persuade them to be part of HIGHMEM.  You
> can't adjust the boundary to allow for it.
> 
> The key here is that moving the end of NORMAL downwards moves the
> beginning of HIGHMEM downwards also pulling the pages into HIGHMEM
> implicitly, that cannot be done anywhere but at the end of NORMAL.
> 
> >>>> If the initrd's are falling into this space, can we not allocate some
> >>>> bootmem for those and move them out of our way?  As filesystem images
> >>>> they are essentially location neutral so this should be safe?
> >>> AFAIK bootloaders choose where map initrds.  Grub seems to put it around
> >>> the top of ZONE_NORMAL but it is pretty free to map it where it wants. I
> >>> suppose INITRD_START INITRD_END and all that could be dynamic and moved
> >>> around a bit but it seems a little messy. I would rather see the special
> >>> case (i386 numa the rare beast it is) jump thought a few extra hoops
> >>> than to muck with the initrd code. 
> >> Right we can't change where grub puts it.  But doesn't it tell us where
> >> it is as part of the kernel parameterisation.  That would allow us to
> >> move it out of our way and change the parameters to that new location,
> >> allowing normal processing to find it in the new location.
> > 
> > Yea we know right where the initrd is at.  All this code is running
> > before the bootmem allocator is even setup in fact this function is
> > setting everything up to call setup_bootmem_allocator (at the end of the
> > function)... 
> > 
> 
> Right, so the instant we detect it at the location grub specifies can we
> not just move it somewhere else random like 20Mb up or something and
> change the pointer, then carry on?
> 
> >  Are you sure there isn't another way to reclaim these pages?
> 
> Not that I am aware of, as if a page is in NORMAL it is expected to be
> direct mapped, you have stolen their mapping for KVA thus they have to
> be junked.
> 
> >> Be interested to see the layout during boot on one of these boxes :).
> > 
> > It is as easy as booting with an initrd :)  I can post some initrd
> > locations it a little while. 

kernel /vmlinuz-2.6.18-km ro root=/dev/VolGroup00/LogVol00
console=ttyS0,115200
 console=tty0
   [Linux-bzImage, setup=0x1e00, size=0x1ca562]
initrd /initrd-18km
   [Linux-initrd @ 0x37ddf000, 0x21008a bytes]

Linux version 2.6.17 (root@elm3a25) (gcc version 4.1.1 20060817 (Red Hat
4.1.1-18)) #1 SMP Wed Sep 13 01:42:30 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
 BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000eff91840 (usable)
 BIOS-e820: 00000000eff91840 - 00000000eff9c340 (ACPI data)
 BIOS-e820: 00000000eff9c340 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001d0000000 (usable)
Node: 0, start_pfn: 0, end_pfn: 156
Node: 0, start_pfn: 256, end_pfn: 982929
Node: 0, start_pfn: 1048576, end_pfn: 1900544

My box isn't booting numa right now.  My SRAT isn't getting loaded right
I am looking at that first. 

Thanks,
  Keith 

