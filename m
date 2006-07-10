Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161305AbWGJCvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161305AbWGJCvL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 22:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWGJCvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 22:51:11 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:51081 "HELO
	cerise.buici.com") by vger.kernel.org with SMTP id S1161305AbWGJCvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 22:51:10 -0400
Date: Sun, 9 Jul 2006 19:51:03 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
Message-ID: <20060710025103.GC28166@cerise.buici.com>
References: <20060709000703.GA9806@cerise.buici.com> <44B0774E.5010103@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B0774E.5010103@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 01:26:06PM +1000, Nick Piggin wrote:
> Marc Singer wrote:
> >I'm investigating why I am triggering a BUG_ON in split_page() when I
> >use the sound subsystems dma memory allocation aide.
> >
> >The crux of the problem appears to be that snd_malloc_dev_pages()
> >passes __GFP_COMP into dma_alloc_coherent().  On the ARM and several
> >other architectures, the dma allocation code calls split_page () with
> >pages allocated with this flag which, in turn, triggers the BUG_ON()
> >check for the CompoundPage flag.
> >
> >So, the questions are these: Who is doing the wrong thing?  Should the
> >snd_malloc_dev_pages() call drop the __GFP_COMP flag?  Should
> >split_page() allow the page to be compound?  Should __GFP_COMP be 0 on
> >ARM and other architectures that don't support compound pages?
> 
> I personally never liked the explicit __GFP_COMP going in everywhere,
> and would have much preferred a GFP_USERMAP, which the architecture /
> allocator could satisfy as they liked.

Thus, the __GFP_COMP bit would be part of another flags such that it
is set on x86 (or any other architecture that supports it) and clear
on those that don't.

> As a hack, you can make arm's dma_alloc_coherent() drop __GFP_COMP,
> which should work.

There are many architectures that have this problem, so I suspect that
such a patch would be unappreciated.
