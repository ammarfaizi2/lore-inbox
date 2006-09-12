Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWILI0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWILI0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWILI0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:26:38 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:35076 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965067AbWILI0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:26:38 -0400
Message-ID: <45066F1D.8000203@shadowen.org>
Date: Tue, 12 Sep 2006 09:26:05 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: kmannth@us.ibm.com
CC: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] patch[1/1] i386 numa kva conversion to use	bootmem	reserve
References: <1150871711.8518.61.camel@keithlap>	 <45037B5F.1080509@shadowen.org> <1158000628.5755.48.camel@keithlap>	 <4505D8D3.1000301@shadowen.org> <1158017404.7284.35.camel@keithlap>
In-Reply-To: <1158017404.7284.35.camel@keithlap>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keith mannthey wrote:
> On Mon, 2006-09-11 at 22:44 +0100, Andy Whitcroft wrote:
> 
> 
>>>> The primary reason that the mem_map is cut from the end of ZONE_NORMAL
>>>> is so that memory that would back that stolen KVA gets pushed out into
>>>> ZONE_HIGHMEM, the boundary between them is moved down.  By using
>>>> reserve_bootmem we will mark the pages which are currently backing the
>>>> KVA you are 'reusing' as reserved and prevent their release; we pay
>>>> double for the mem_map.
>>> Perhaps just freeing the reserve pages and remapping them at an
>>> appropriate time could accomplish this?  Sorry I don't know the KVA
>>> "freeing" path can you describe it a little more?  When are these pages
>>> returned to the system?  It was my understanding that that KVA pages
>>> were lost (the original wayu shrinks ZONE_NORMAL and creates a hole
>>> between the zones).
>>
>> No it does seem like we loose the memory at the end of NORMAL when we
>> shrink it, but really happens is we move the boundary down. Any page
>> above the boundary is then in HIGHMEM and available to be allocated.
> 
> How is it available for allocation?  I see it is in highmem but the
> pmd's for the kva area are set with node local information.  I don't see
> any special code to reclaim the kva area or extend ZONE_HIGHMEM.... How
> does having the KVA area in ZONE_HIGHMEM allow you to reclaim it?
> (sorry if this is an easy question but I an still sorting out how it is
> "reclaimed" in the original implementation and why it can't be reclaimed
> as part of ZONE_NORMAL). 

If the boundary is at page 1024 then pages 0-1024 are direct mapped into
KVA, page 1024 is not mapped at all and part of HIGHMEM, when that zone
is freed up later those pages will be in the HIGHMEM zone and
allocatable.  Move the boundary down to 1000 then 24 pages of KVA will
no longer be used as direct maps, and pages from 1000 onwards are in
zone HIGHMEM, non direct mapped, but available to allocatable.  Cut a
section out of the middle of NORMAL and you just have to bin the pages
'behind' that KVA as you can persuade them to be part of HIGHMEM.  You
can't adjust the boundary to allow for it.

The key here is that moving the end of NORMAL downwards moves the
beginning of HIGHMEM downwards also pulling the pages into HIGHMEM
implicitly, that cannot be done anywhere but at the end of NORMAL.

>>>> If the initrd's are falling into this space, can we not allocate some
>>>> bootmem for those and move them out of our way?  As filesystem images
>>>> they are essentially location neutral so this should be safe?
>>> AFAIK bootloaders choose where map initrds.  Grub seems to put it around
>>> the top of ZONE_NORMAL but it is pretty free to map it where it wants. I
>>> suppose INITRD_START INITRD_END and all that could be dynamic and moved
>>> around a bit but it seems a little messy. I would rather see the special
>>> case (i386 numa the rare beast it is) jump thought a few extra hoops
>>> than to muck with the initrd code. 
>> Right we can't change where grub puts it.  But doesn't it tell us where
>> it is as part of the kernel parameterisation.  That would allow us to
>> move it out of our way and change the parameters to that new location,
>> allowing normal processing to find it in the new location.
> 
> Yea we know right where the initrd is at.  All this code is running
> before the bootmem allocator is even setup in fact this function is
> setting everything up to call setup_bootmem_allocator (at the end of the
> function)... 
> 

Right, so the instant we detect it at the location grub specifies can we
not just move it somewhere else random like 20Mb up or something and
change the pointer, then carry on?

>  Are you sure there isn't another way to reclaim these pages?

Not that I am aware of, as if a page is in NORMAL it is expected to be
direct mapped, you have stolen their mapping for KVA thus they have to
be junked.

>> Be interested to see the layout during boot on one of these boxes :).
> 
> It is as easy as booting with an initrd :)  I can post some initrd
> locations it a little while. 

Cool.

-apw
