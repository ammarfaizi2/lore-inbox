Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293291AbSCEPKq>; Tue, 5 Mar 2002 10:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293301AbSCEPKl>; Tue, 5 Mar 2002 10:10:41 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:46434 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293291AbSCEPKZ>; Tue, 5 Mar 2002 10:10:25 -0500
Date: Tue, 5 Mar 2002 16:10:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305161032.F20606@dualathlon.random>
In-Reply-To: <200203050835.g258ZpW25134@fenrus.demon.nl> <Pine.LNX.4.44L.0203050934340.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203050934340.1413-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 09:41:56AM -0300, Rik van Riel wrote:
> On Tue, 5 Mar 2002 arjan@fenrus.demon.nl wrote:
> > In article <20020305005215.U20606@dualathlon.random> you wrote:
> >
> > > I don't see how per-zone lru lists are related to the kswapd deadlock.
> > > as soon as the ZONE_DMA will be filled with filedescriptors or with
> > > pagetables (or whatever non pageable/shrinkable kernel datastructure you
> > > prefer) kswapd will go mad without classzone, period.
> >
> > So does it with class zone on a scsi system....
> 
> Furthermore, there is another problem which is present in
> both 2.4 vanilla, -aa and -rmap.

Please check the code. scsi_resize_dma_pool is called when you insmod a
module. It doesn't really matter if kswapd runs for 2 seconds during
insmod. And anyways if there would be some buggy code allocating dma in
a flood by mistake on a high end machine, then I can fix it completly by
tracking down when somebody freed dma pages over some watermark, but
that would add additional accounting that I don't feel needed, simply
because if you don't need DMA zone you shouldn't use GFP_DMA, I feel
fixing scsi is the right thing if something (but again, I don't see any
flood allocation during production with scsi).

> Suppose that (1) we are low on memory in ZONE_NORMAL and
> (2) we have enough free memory in ZONE_HIGHMEM and (3) the
> memory in ZONE_NORMAL is for a large part taken by buffer
> heads belonging to pages in ZONE_HIGHMEM.
> 
> In that case, none of the VMs will bother freeing the buffer
> heads associated with the highmem pages and kswapd will have

wrong, classzone will do that, both for NORMAL and HIGHMEM allocations.
You won't free the buffer headers only if you do DMA allocations and
by luck there will be no buffer headers in the DMA zone, otherwise it
will free the bh during DMA allocations too. remeber highmem classzone
means all the ram in the machine, not just highmem zone.

> to work hard trying to free something else in ZONE_NORMAL.
> 
> Now before you say this is a strange theoretical situation,
> I've seen it here when using highmem emulation. Low memory
> was limited to 30 MB (16 MB ZONE_DMA, 14 MB ZONE_NORMAL)
> and the rest of the machine was HIGHMEM.  Buffer heads were
> taking up 8 MB of low memory, dcache and inode cache were a
> good second with 2 MB and 5 MB respectively.
> 
> 
> How to efficiently fix this case ?   I wouldn't know right now...

I don't see anything to fix, that should be just handled flawlessy.

> However, I guess we might want to come up with a fix because it's
> a quite embarassing scenario ;)
> 
> regards,
> 
> Rik
> -- 
> Will hack the VM for food.
> 
> http://www.surriel.com/		http://distro.conectiva.com/


Andrea
