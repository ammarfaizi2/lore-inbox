Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131105AbRBPTdU>; Fri, 16 Feb 2001 14:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131099AbRBPTdK>; Fri, 16 Feb 2001 14:33:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27396 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131098AbRBPTcx>; Fri, 16 Feb 2001 14:32:53 -0500
Date: Fri, 16 Feb 2001 11:32:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <Pine.LNX.4.30.0102161355270.17251-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.10.10102161124500.1046-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Feb 2001, Ben LaHaise wrote:
> 
> Actually, in the filemap_sync case, the flush_tlb_page is redundant --
> there's already a call to flush_tlb_range in filemap_sync after the dirty
> bits are cleared.

This is not enough. 

If another CPU has started write-out of one of the dirty pages (which, as
far as I can tell, is certainly unlikely but not impossible) while we were
still handling other dirty pages, that other CPU might clear the physical
dirty bit of that page while a third CPU (or the same writer, but that
makes the timing even _more_ unlikely) is still using a stale "dirty" TLB
entry and writing to the page (and not updating the virtual dirty bit
because it doesn't know that it has already been cleared).

So you have to somehow guarantee that you invalidate the TLB's before the
dirty bit from the "struct page" can be cleared (which in turn has to
happen before the writeout). That can obviously be done with the tlb range
flushing, but it needs more locking.

This is, actually, a problem that I suspect ends up being _very_ similar
to the zap_page_range() case. zap_page_range() needs to make sure that
everything has been updated by the time the page is actually free'd. While
filemap_sync() needs to make sure that everything has been updated before
the page is written out (or marked dirty - which obviously also guarantees
the ordering, and makes the problems look even more similar).

		Linus

