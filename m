Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279301AbRJ2R2m>; Mon, 29 Oct 2001 12:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279307AbRJ2R2c>; Mon, 29 Oct 2001 12:28:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:64429 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S279301AbRJ2R2W>;
	Mon, 29 Oct 2001 12:28:22 -0500
Date: Mon, 29 Oct 2001 09:13:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Juergen Doelle <jdoelle@de.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Pls apply this spinlock patch to the kernel
In-Reply-To: <3BDD8241.8002B946@de.ibm.com>
Message-ID: <Pine.LNX.4.33.0110290907300.8729-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Juergen Doelle wrote:
>
> I had created a patch for improving the spinlock behavior on IA32 SMP
> systems for file system work load created with dbench
> (ftp://samba.org/pub/tridge/dbench). The work load is a mix of create,
> delete, write, and read operations executed from a scalable number of
> clients. It is mainly handled in buffer cache.

Fair enough. However, I wonder why you didn't just use the existing
(unaligned) types, and then on a lock-by-lock basis just mark them
aligned. That implies no code-changes.

Something like this should do it:

	.. regular "spinlock_t" type

	#define cachealign \
	 __attribute__((section("aligned"),__aligned__(SMP_CACHELINE_SIZE)))

(use a separate section so that subsequent data structures are also
guaranteed to be aligned - otherwise you might get false sharing from
non-aligned data structures that follow this one).

Eh?

Yes, we already try to do something like this, but due to the false
sharing with other stuff it doesn't _guarantee_ an exclusive cacheline.
Sometimes that is what you want (ie once you get the lock, it _can_ be
advantageous to have the hottest data structure associated with the lock
be in the same cacheline)

		Linus

