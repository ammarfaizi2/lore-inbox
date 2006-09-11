Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWIKXaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWIKXaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWIKXaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:30:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:29906 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965078AbWIKXaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:30:07 -0400
Subject: Re: [RFC] patch[1/1] i386 numa kva conversion to use
	bootmem	reserve
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4505D8D3.1000301@shadowen.org>
References: <1150871711.8518.61.camel@keithlap>
	 <45037B5F.1080509@shadowen.org> <1158000628.5755.48.camel@keithlap>
	 <4505D8D3.1000301@shadowen.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Mon, 11 Sep 2006 16:30:04 -0700
Message-Id: <1158017404.7284.35.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 22:44 +0100, Andy Whitcroft wrote:


> >> The primary reason that the mem_map is cut from the end of ZONE_NORMAL
> >> is so that memory that would back that stolen KVA gets pushed out into
> >> ZONE_HIGHMEM, the boundary between them is moved down.  By using
> >> reserve_bootmem we will mark the pages which are currently backing the
> >> KVA you are 'reusing' as reserved and prevent their release; we pay
> >> double for the mem_map.
> > Perhaps just freeing the reserve pages and remapping them at an
> > appropriate time could accomplish this?  Sorry I don't know the KVA
> > "freeing" path can you describe it a little more?  When are these pages
> > returned to the system?  It was my understanding that that KVA pages
> > were lost (the original wayu shrinks ZONE_NORMAL and creates a hole
> > between the zones).
> 
> 
> No it does seem like we loose the memory at the end of NORMAL when we
> shrink it, but really happens is we move the boundary down. Any page
> above the boundary is then in HIGHMEM and available to be allocated.

How is it available for allocation?  I see it is in highmem but the
pmd's for the kva area are set with node local information.  I don't see
any special code to reclaim the kva area or extend ZONE_HIGHMEM.... How
does having the KVA area in ZONE_HIGHMEM allow you to reclaim it?
(sorry if this is an easy question but I an still sorting out how it is
"reclaimed" in the original implementation and why it can't be reclaimed
as part of ZONE_NORMAL). 

> > 
> >> If the initrd's are falling into this space, can we not allocate some
> >> bootmem for those and move them out of our way?  As filesystem images
> >> they are essentially location neutral so this should be safe?
> > 
> > AFAIK bootloaders choose where map initrds.  Grub seems to put it around
> > the top of ZONE_NORMAL but it is pretty free to map it where it wants. I
> > suppose INITRD_START INITRD_END and all that could be dynamic and moved
> > around a bit but it seems a little messy. I would rather see the special
> > case (i386 numa the rare beast it is) jump thought a few extra hoops
> > than to muck with the initrd code. 
> 
> Right we can't change where grub puts it.  But doesn't it tell us where
> it is as part of the kernel parameterisation.  That would allow us to
> move it out of our way and change the parameters to that new location,
> allowing normal processing to find it in the new location.

Yea we know right where the initrd is at.  All this code is running
before the bootmem allocator is even setup in fact this function is
setting everything up to call setup_bootmem_allocator (at the end of the
function)... 

 Are you sure there isn't another way to reclaim these pages?

> Be interested to see the layout during boot on one of these boxes :).

It is as easy as booting with an initrd :)  I can post some initrd
locations it a little while. 

Thanks,
  Keith 




