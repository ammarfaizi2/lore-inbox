Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291742AbSBHTCE>; Fri, 8 Feb 2002 14:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291743AbSBHTBz>; Fri, 8 Feb 2002 14:01:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2474 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291742AbSBHTBr>;
	Fri, 8 Feb 2002 14:01:47 -0500
Date: Fri, 8 Feb 2002 21:59:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@ns.caldera.de>,
        yodaiken <yodaiken@fsmlabs.com>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        torvalds <torvalds@transmet.com>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.GSO.4.21.0202081352400.28514-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0202082156530.16418-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Feb 2002, Alexander Viro wrote:

> > i'd suggest 64-bit update instructions on x86 as well, they do exist.
> > spinlock only for the truly hopeless cases like SMP boxes composed of
> > i486's. We really want llseek() to scale ...
>
> Ingo, are you sure that you actually saw llseek() causing problems?

yes.

> And not, say it, ext2_get_block()?

no. I saw ext2_get_block() overhead in other workloads, but not this one.
(this was a fully cached pagecache-only workload.)

> If you've got a heavy holder of some lock + lots of guys who grab it
> for a short periods, the real trouble is the former, not the latter.

no, i simply had code that called llseek() pretty often for the same inode
(big database file), and on multiple CPUs it was just way too easy for one
semaphore user to cause another one to block.

> I'm going to send ext2-without-BKL patches to Linus - tonight or
> tomorrow. I really wonder what effect that would have on the things.

oh, that is a really cool thing!

llseek() is unrelated, and i think pretty gross. Is there any other reason
to llseek()'s i_sem usage other than the 64-bit atomic update of the file
offset value? We can do lockless, SMP-correct 64-bit updates on x86 pretty
easily.

	Ingo

