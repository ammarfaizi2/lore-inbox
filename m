Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTEVLXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 07:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTEVLXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 07:23:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49083 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261757AbTEVLXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 07:23:39 -0400
Date: Thu, 22 May 2003 13:34:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Martin Wirth <martin.wirth@dlr.de>
Cc: linux-kernel@vger.kernel.org, <rusty@rustcorp.com.au>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
In-Reply-To: <3ECCB319.4060706@dlr.de>
Message-ID: <Pine.LNX.4.44.0305221328130.6965-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 May 2003, Martin Wirth wrote:

> - Specify the futexes to be mm-local: By using the pair mm* and vaddr as
>    key it is possible to have process local futexes living on the same
>    hash with the following advantages:
>    1. no page_table lock contention (I implemented mm-local futexes
>       for my application after I noticed long latencies on SMP where a
>       high prio tasks spun in futex_wake while another task was doing 		
>       mmap/munmap on a second processor).
>    2. no vcache pollution (I guess 99% of all futexes will not be in 		 
>      shared memory)
>    3. Slightly faster, since no page pinning is needed

there's a patch in the works to change futex hashing to not require page
pinning, without making futexes process-local. This should also fix the
FUTEX_FD problems.

basically the idea is that struct page remains to be a good hash whenever
the page is present, and the swapout pte value is a good hash key when the
page is swapped out. So we basically can make futexes swappable.

this gets rid of pinned pages and pagetable locking, without the need for
API-level changes.

> By the way, your latest futex patch still contains the bogus if
> (!list_empty(&q.list)) conditional, that's always true since you hold
> the locks at this point and no one can have removed us from the list:

ok, i'll fix this! I knew i missed something ...

	Ingo


