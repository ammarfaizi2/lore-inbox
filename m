Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSEVLTg>; Wed, 22 May 2002 07:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEVLTf>; Wed, 22 May 2002 07:19:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39185 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312486AbSEVLTf>; Wed, 22 May 2002 07:19:35 -0400
Date: Wed, 22 May 2002 12:19:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
Message-ID: <20020522121929.A16934@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 10:16:35PM -0700, Linus Torvalds wrote:
> Various FS updates (including merges of quota and iget_locked), and
> Makefile cleanups from Kai.
> 
> And yet more TLB shootdown stuff.

We seem to have inconsistent cache handling in the new TLB shootdown stuff.
Or maybe its just my misunderstanding of what's going on; whatever it is,
the new TLB shootdown stuff appears to be quite messy.

Lets look at the flow of the 3 places where tlb_gather_mmu is used:

zap_page_range		unmap_region		exit_mmap
  flush_cache_range	  tlb_gather_mmu	  tlb_gather_mmu
  tlb_gather_mmu	  unmap_page_range	  flush_cache_mm
  unmap_page_range	  free_pgtables		  unmap_page_range
  tlb_finish_mmu	  tlb_finish_mmu	  clear_page_tables
						  tlb_finish_mmu

So we have 3 different functions, 2 different orders of gather_mmu
and cache handling, and one with no cache handling what so ever.

I think we have two options - either leave the cache handling up to
tlb_start_vma() (in which case, flush_cache_range and flush_cache_mm
are redundant and should be removed) or let it be up to the caller
of tlb_gather_mmu to call the right cache handling function.

I think which is actually function dependent - in zap_page_range,
we're only removing one vma.  In exit_mmap, we're removing all vmas.
In unmap_region, we're removing an unspecified number of vmas.
Depending on which option we choose, we'll either end up calling
flush_cache_range() many times, or flush_cache_mm() and flushing
the cache for a munmap of a small area.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

