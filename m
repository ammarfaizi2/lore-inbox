Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRCRSOO>; Sun, 18 Mar 2001 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRCRSOF>; Sun, 18 Mar 2001 13:14:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15113 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131244AbRCRSOA>; Sun, 18 Mar 2001 13:14:00 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
Date: 18 Mar 2001 10:13:11 -0800
Organization: Transmeta Corporation
Message-ID: <992trn$lk1$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0103181407520.1426-100000@mikeg.weiden.de> <Pine.LNX.4.21.0103181122480.13050-100000@imladris.rielhome.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0103181122480.13050-100000@imladris.rielhome.conectiva>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>
>OK, I'll write some code to prevent multiple threads from
>stepping all over each other when they pagefault at the
>same address.
>
>What would be the preferred method of fixing this ?
>
>- fixing do_swap_page and all ->nopage functions

There is no need to fix gthe "nopage" functions. They never see the page
table directly anyway. 

So the only thing that _should_ be needed is to make sure that
do_no_page(), do_swap_page() and do_anonymous_page() will re-aquire the
mm->page_table_lock and undo their work if it turns out that the page
table entry is no longer empty.. 

(do_wp_page() should already be ok in this regard - it already does this
exactly because present pagetable entries can already race with kswapd. 
What we're adding is that _nonpresent_ page table entries can race with
multiple invocations of concurrent page faults)

>- hacking handle_mm_fault to make sure no overlapping
>  pagefaults will be served at the same time

No. The whole reason the rw_semaphores were done in the first place was
to allow page faults to happen concurrently to allow threaded
applictions to scale up even when faulting.

		Linus
