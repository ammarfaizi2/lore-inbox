Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTHZFaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTHZFaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:30:46 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:38207 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262649AbTHZFao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:30:44 -0400
Date: Tue, 26 Aug 2003 01:30:41 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
In-Reply-To: <20030825210606.5912bac4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308260123050.1912-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Aug 2003, Andrew Morton wrote:

> Two issues:
> 
> a) what to do about futexes in file-backed pages?  At present the
>    attacker can pin arbitrary amount of memory by backing it with a file.
> 
>    Your solution won't scale to solving this, because we need to perform
>    a futex lookup on every add_to_page_cache().  (Well, it will scale
>    fairly well because add_to_page_cache() is ratelimited by the IO speed. 
>    But it will still suck quite a bit for some people).

add_to_page_cache() can be fairly high-frequency when the pagecache is
created anew (write) and torn down immediately afterwards (temporary
files). So i dont think it's 100% ratelimited by IO speed.

the cleanest thing would be to do the hashtable registration with every
futex existing in the system. But we might get away with doing it only for
FUTEX_FD 'asynchronous' futexes (which are only limited by the # of open
files, per process), and do the usual page pinning (and thus fast) thing
with the 'synchronous' futexes (which are limited to one per context, so
they are resource-limited automatically). As long as the hashtable is
empty, the lookup ought to be really fast.

> Or create RLIM_NRFUTEX.

futexes do have some small lowmem footprint nevertheless (they have a
queue entry structure, etc.), but much less than PAGE_SIZE. So basically
the overhead can be added to the already existing fd footprint, without
changing the balance too much.

but if all futexes pin down one page (worst-case), then to make it really
safe we'll have to use a fairly low default RLIM_NRFUTEX value - which
will decrease the generic utility of futexes.

	Ingo

