Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUCKN2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUCKN2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:28:24 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11841 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261248AbUCKN2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:28:22 -0500
Date: Thu, 11 Mar 2004 13:23:24 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040311065254.GT30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403111248450.1402-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Thu, 11 Mar 2004, Andrea Arcangeli wrote:
> 
> this is the full current status of my anon_vma work. Now fork() and all
> the other page_add/remove_rmap in memory.c plus the paging routines
> seems fully covered and I'm now dealing with the  vma merging and the
> anon_vma garbage collection (the latter is easy but I need to track all
> the kmem_cache_free).

I'm still making my way through all the relevant mails, and not even
glanced at your code yet: I hope later today.  But to judge by the
length of your essay on vma merging, it strikes me that you've taken
a wrong direction in switching from my anon mm to your anon vma.

Go by vmas and you have tiresome problems as they are split and merged,
very commonly.  Plus you have the overhead of new data structure per vma.
If your design magicked those problems away somehow, okay, but it seems
you're finding issues with it: I think you should go back to anon mms.

Go by mms, and there's only the exceedingly rare (does it ever occur
outside our testing?) awkward case of tracking pages in a private anon
vma inherited from parent, when parent or child mremaps it with MAYMOVE.

Which I reused the pte_chain code for, but it's probably better done
by conjuring up an imaginary tmpfs object as backing at that point
(that has its own little cost, since the object lives on at full size
until all its mappers unmap it, however small the portion they have
mapped).  And the overhead of the new data structre is per mm only.

I'll get back to reading through the mails now: sorry if I'm about to
find the arguments against anonmm in my reading.  (By the way, several
times you mention the size of a 2.6 struct page as larger than a 2.4
struct page: no, thanks to wli and others it's the 2.6 that's smaller.)

Hugh

