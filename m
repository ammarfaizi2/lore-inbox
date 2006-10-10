Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWJJQBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWJJQBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWJJQBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:01:24 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:3716 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1750912AbWJJQBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:01:23 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 12:00:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: thoughts on potential cleanup of semaphores?
Message-ID: <Pine.LNX.4.64.0610101025080.8855@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  after submitting one patch related to semaphores and before i submit
any others, any thoughts whether any of the following clean-ups are
valid and/or worthwhile?  (some are admittedly simply aesthetic but
better aesthetics is never a bad thing.)


1) can all instances of sema_init() in the header files be simplified
based on the comment you can see in some of those header files?

========================
static inline void sema_init (struct semaphore *sem, int val)
{
/*
 *      *sem = (struct semaphore)__SEMAPHORE_INITIALIZER((*sem),val);
 *
 * i'd rather use the more flexible initialization above, but sadly
 * GCC 2.7.2.3 emits a bogus warning. EGCS doesnt. Oh well.
 */
        atomic_set(&sem->count, val);
        sem->sleepers = 0;
        init_waitqueue_head(&sem->wait);
}
========================

  one would think there's little value in retaining code that
accommodates something as old as GCC 2.7.2.3, but i'm not the expert
here.


2) [aesthetic] update all __SEMAPHORE_INITIALIZER initialization to
use C99-style structure initializers


3) i'm not a multi-arch wizard so is it true that all architectures
should have a struct semaphore with (approximately) the following
basic structure defined in their semaphore.h?

========================
struct semaphore {
        atomic_t count;
        int sleepers;
        wait_queue_head_t wait;
};
=======================

  you'd think so but there are some discrepancies.  in asm-frv, you
have

struct semaphore {
        unsigned                counter;
        spinlock_t              wait_lock;
        struct list_head        wait_list;

why "unsigned" and not "atomic_t"?  and why "counter" and not just
"count"?  (although, for the frv arch, that variable appears to be
unused except in a single place for debugging.)  and why a "struct
list_head" rather than what everyone else uses, a "wait_queue_head_t"?

i also note that some arches (m68knommu, m68k, cris) define a
"waking" variable instead of "sleepers".  is this supposed to
represent the same thing?  i haven't looked closely enough, sorry.


  and stepping back and looking at the bigger picture, it seems that
the semaphore.h files across all architectures are *almost* identical,
with a small number of differences, such as:

* some take a spinlock
* one (sparc) uses ATOMIC24_INIT rather than just ATOMIC_INIT

and there's probably a couple other things but, if these header files
are so similar, what about defining a single, generic semaphore.h
header file with a couple #ifdef's to handle the few possible
architecture-specific differences?  superficially, it doesn't look
like it would be that hard but that's the voice of youthful enthusiasm
speaking.

rday

p.s.  trying to condense all of the separate semaphore.h files into a
single, configurable one would also solve the problem of incorrect
documentation in some of them that is clearly the result of
cut-and-paste.  but i'm interested in what the experts have to say.
