Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291576AbSBAHI6>; Fri, 1 Feb 2002 02:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291575AbSBAHIs>; Fri, 1 Feb 2002 02:08:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2536 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291576AbSBAHId>;
	Fri, 1 Feb 2002 02:08:33 -0500
Date: Fri, 1 Feb 2002 10:04:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <20020131231242.GA4138@krispykreme>
Message-ID: <Pine.LNX.4.33.0202010958220.2111-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Feb 2002, Anton Blanchard wrote:

> There were a few solutions (from davem and ingo) to allocate a larger
> hash but with the radix patch we no longer have to worry about this.

there is one big issue we forgot to consider.

in the case of radix trees it's not only search depth that gets worse with
big files. The thing i'm worried about is the 'big pagecache lock' being
reintroduced again. If eg. a database application puts lots of data into a
single file (multiple gigabytes - why not), then the
mapping->i_shared_lock becomes a 'big pagecache lock' again, causing
serious SMP contention for even the read() case. Benchmarks show that it's
the distribution of locks that matters on big boxes.

dbench hides this issue, because it uses many temporary files, so the
locking overhead is distributed. Would you be willing to run benchmarks
that measure the scalability of reading from one bigger file, from
multiple CPUs?

with hash based locking, the locking overhead is *always* distributed.

with radix trees the locking overhead is distributed only if multiple
files are used. With one big file (or a few big files), the i_shared_lock
will always bounce between CPUs wildly in read() workloads, degrading
scalability just as much as it is degraded with the pagecache_lock now.

	Ingo

