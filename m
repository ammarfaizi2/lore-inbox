Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291607AbSBAIe1>; Fri, 1 Feb 2002 03:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBAIeR>; Fri, 1 Feb 2002 03:34:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11651 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291607AbSBAIeG>;
	Fri, 1 Feb 2002 03:34:06 -0500
Date: Fri, 1 Feb 2002 11:29:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Momchil Velikov <velco@fadata.bg>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <87u1t1ws20.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 Feb 2002, Momchil Velikov wrote:

> Hmm, worse, yes, the same way as page tables get "worse" with larger
> address spaces.

with the difference that for address spaces one of the preferred methods
of operation is read() [or sendfile(), or any other non-mmap() operation],
while for pagetables the hardware helps to get locking-free access to the
mapped contents.

> Ingo> big files. The thing i'm worried about is the 'big pagecache lock' being
> Ingo> reintroduced again. If eg. a database application puts lots of data into a
>
> Yes, though I'd strongly suspect big database engines can/should/do
> benefit from doing their application specific caching and indexing,
> outperforming whatever cache implementation the OS has.

it's not just databases. It's webservers too, serving content via
sendfile() from a single, bigger file. Think streaming media servers,
where the 'movie of the night' sits in a single big binary glob.

> Ingo> single file (multiple gigabytes - why not), then the
> mapping-> i_shared_lock becomes a 'big pagecache lock' again, causing
> Ingo> serious SMP contention for even the read() case. Benchmarks show that it's
> Ingo> the distribution of locks that matters on big boxes.
>
> So, we can use a read-write spinlock instead ->i_shared_lock, ok ?

using read-write locks does not solve the scalability problem: the problem
is the bouncing of the spinlock cacheline from CPU to CPU.

	Ingo

