Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbRGZMUh>; Thu, 26 Jul 2001 08:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267784AbRGZMU1>; Thu, 26 Jul 2001 08:20:27 -0400
Received: from chiara.elte.hu ([157.181.150.200]:58629 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S267743AbRGZMUH>;
	Thu, 26 Jul 2001 08:20:07 -0400
Date: Thu, 26 Jul 2001 14:17:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kmap() while holding spinlock
In-Reply-To: <20010726161219.D4963@krispykreme>
Message-ID: <Pine.LNX.4.33.0107261409110.3796-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Thu, 26 Jul 2001, Anton Blanchard wrote:

> do_wp_page calls break_cow with the page_table_lock held.
>
> Since I dont think we can drop the lock, do we need a kmap_atomic for
> these?

calling kmap() with a spinlock held is indeed Very Bad, and break_cow()
uses kmap(). I dont know why this didnt get noticed earlier. Perhaps
because kmap() schedules very rarely.

the solution is to either use (per-CPU) atomic_kmap(), or to do the
clearing (and copying) speculatively, after allocating the page but before
locking the pagetable lock. This might lead to a bit more work in the
pagefault-race case, but we dont care about that window. It will on the
other hand reduce pagetable_lock contention (because the clearing/copying
is done outside the lock), so perhaps this solution is better.

	Ingo

