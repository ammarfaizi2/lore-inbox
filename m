Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318264AbSG3N2q>; Tue, 30 Jul 2002 09:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSG3N2q>; Tue, 30 Jul 2002 09:28:46 -0400
Received: from ns.suse.de ([213.95.15.193]:37649 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318264AbSG3N2p>;
	Tue, 30 Jul 2002 09:28:45 -0400
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
References: <3FAD1088D4556046AEC48D80B47B478C0101F3AE@usslc-exch-4.slc.unisys.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Jul 2002 15:32:08 +0200
In-Reply-To: "Van Maren, Kevin"'s message of "29 Jul 2002 23:12:33 +0200"
Message-ID: <p73vg6xs5nr.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Van Maren, Kevin" <kevin.vanmaren@unisys.com> writes:

> There are ways of fixing the writer starvation and allowing recursive
> read locks, but that is more work (and heavier-weight than desirable).

One such way would be a variant of queued locks, like John Stultz's
http://oss.software.ibm.com/developer/opensource/linux/patches/?patch_id=218
These are usually needed for fairness even with plain spinlocks on NUMA 
boxes in any case (so if your box is NUMA then you will need it anyways) 
They only exist for plain  spinlocks yet, but I guess they could be extended 
to readlocks. 

IIRC the benchmarks correctly they were about 3 times slower for the
uncontended case, but somewhat faster for contended locks. Of course
this is the wrong priority for linux - contended locks should be eliminated,
not optimized, but if there is no other choice for correctness it has to do.

> How pervasive are recursive reader locks?  Should they be a special
> type of reader lock?

Not very common I hope, at least I cannot think of a case right now
(but then I don't claim to know all locks in linux) 
Verifying that this case does not occur by code audit (or that
you have catched all instances if you made it a special case) would 
be a lot of work:  the 2.5.29 kernel has about 800 calls to read/write_lock

-Andi

