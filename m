Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSBAOoj>; Fri, 1 Feb 2002 09:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291777AbSBAOo3>; Fri, 1 Feb 2002 09:44:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23328 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291775AbSBAOoP>; Fri, 1 Feb 2002 09:44:15 -0500
Date: Fri, 1 Feb 2002 15:44:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020201154433.C9904@athlon.random>
In-Reply-To: <20020131231242.GA4138@krispykreme> <Pine.LNX.4.33.0202010958220.2111-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0202010958220.2111-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Feb 01, 2002 at 10:04:50AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 10:04:50AM +0100, Ingo Molnar wrote:
> 
> On Fri, 1 Feb 2002, Anton Blanchard wrote:
> 
> > There were a few solutions (from davem and ingo) to allocate a larger
> > hash but with the radix patch we no longer have to worry about this.
> 
> there is one big issue we forgot to consider.
> 
> in the case of radix trees it's not only search depth that gets worse with
> big files. The thing i'm worried about is the 'big pagecache lock' being
> reintroduced again. If eg. a database application puts lots of data into a
> single file (multiple gigabytes - why not), then the
> mapping->i_shared_lock becomes a 'big pagecache lock' again, causing
> serious SMP contention for even the read() case. Benchmarks show that it's
> the distribution of locks that matters on big boxes.

exactly, this is the same thing I mentioned in some past email. It's not
that having per-inode data structures solves the locking completly, DBMS
are used to store stuff in a single file. And of course with a structure
like radix tree it would be a pain to have it scale within the same
file, unlike with the hashtable where each bucket is indipendent from
the others.

> 
> dbench hides this issue, because it uses many temporary files, so the

Indeed, a lot of workloads would benefit from the separate data
structure and locking, but not all, some important one not.

> locking overhead is distributed. Would you be willing to run benchmarks
> that measure the scalability of reading from one bigger file, from
> multiple CPUs?

Agreed, also with DaveM patch applied, sizing the hash properly so it
has a mean distribution of 1 entry per bucket or so, will decrease the
window for the spinlock collisions as well btw.

> 
> with hash based locking, the locking overhead is *always* distributed.
> 
> with radix trees the locking overhead is distributed only if multiple
> files are used. With one big file (or a few big files), the i_shared_lock
> will always bounce between CPUs wildly in read() workloads, degrading
> scalability just as much as it is degraded with the pagecache_lock now.
> 
> 	Ingo


Andrea
