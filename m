Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318353AbSG3RDC>; Tue, 30 Jul 2002 13:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318354AbSG3RDC>; Tue, 30 Jul 2002 13:03:02 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:16106 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S318353AbSG3RDB>; Tue, 30 Jul 2002 13:03:01 -0400
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F3B2@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Andi Kleen'" <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
Date: Tue, 30 Jul 2002 12:06:54 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are ways of fixing the writer starvation and allowing recursive
> > read locks, but that is more work (and heavier-weight than desirable).
> 
> One such way would be a variant of queued locks, like John Stultz's
>
http://oss.software.ibm.com/developer/opensource/linux/patches/?patch_id=218
> These are usually needed for fairness even with plain spinlocks on NUMA 
> boxes in any case (so if your box is NUMA then you will need it anyways) 
> They only exist for plain  spinlocks yet, but I guess they could be
extended 
> to readlocks.

This ES7000 system is not NUMA.  All memory is equidistant from all
processors,
with a full non-blocking crossbar interconnect, and the hardware guarantees
fairness under cacheline contention.  So the processors aren't being starved
or treated unfairly by the hardware, just by the reader-preference locking
code.

It isn't obvious to me how to extend those queued to reader/writer locks if
you
have to allow recursive readers without incurring the same overhead of
tracking
which processors already have a reader lock.

If you do want to trigger recursive rw_locks, simply change the header file
to
make them normal spinlocks.  Then whenever the kernel hangs, see where it
is.
Of course, this approach only finds all of them if you execute every code
path.

Does anyone want to chip in on why we need recursive r/w locks?  Or why it
is hard to remove them?  It doesn't sound like they are used much.

Kevin
