Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273739AbRI0Rqy>; Thu, 27 Sep 2001 13:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273745AbRI0Rqo>; Thu, 27 Sep 2001 13:46:44 -0400
Received: from chiara.elte.hu ([157.181.150.200]:55053 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S273739AbRI0Rqd>;
	Thu, 27 Sep 2001 13:46:33 -0400
Date: Thu, 27 Sep 2001 19:44:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        <bcrl@redhat.com>, <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.33.0109270835130.17030-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109271925400.9180-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Linus Torvalds wrote:

> prefetching and friends won't do _anything_ for the case of a cache
> line bouncing back and forth between CPU's.

yep. that is exactly what was happening with pagecache_lock, while an
8-way system served 300+ MB/sec worth of SPECweb99 HTTP content in 1500
byte packets. Under that kind of workload the pagecache is used
read-mostly, and due to zerocopy (and Linux's hyper-scalable networking
code) there isnt much left that pollutes caches and/or inhibits raw
performance in any way. pagecache_lock was the top non-conceptual
cacheline-miss offender in instruction-level profiles of such workloads.
Does it show up on a dual PIII with 128 MB RAM? Probably not as strongly.
Are there other offenders under other kinds of workloads that have a
bigger effect than pagecache_lock? Probably yes - but this does not
justify ignoring the effects of pagecache_lock.

(to be precise there was another offender - timerlist_lock, we've fixed it
before fixing pagecache_lock, and posted a patch for that one too. It's
available under http://redhat.com/~mingo/scalable-timers/. I know no other
scalability offenders for read-mostly pagecache & network-intensive
workloads for the time being.)

	Ingo

