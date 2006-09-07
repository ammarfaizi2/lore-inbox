Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWIGIMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWIGIMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWIGIMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:12:19 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:58534 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1750965AbWIGIMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:12:17 -0400
Date: Thu, 07 Sep 2006 17:11:58 +0900 (JST)
Message-Id: <20060907.171158.130239448.nemoto@toshiba-tops.co.jp>
To: sebastien.dugue@bull.net
Cc: jakub@redhat.com, arjan@infradead.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org, pierre.peiffer@bull.net
Subject: Re: NPTL mutex and the scheduling priority
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060613.010628.41632745.anemo@mba.ocn.ne.jp>
References: <20060612124406.GZ3115@devserv.devel.redhat.com>
	<1150125869.3835.12.camel@frecb000686>
	<20060613.010628.41632745.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006 01:06:28 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > > Really FUTEX_WAKE/FUTEX_REQUEUE can't use a FIFO.  I think there was a patch
> > > floating around to use a plist there instead, which is one possibility,
> > > another one is to keep the queue sorted by priority (and adjust whenever
> > > priority changes - one thread can be waiting on at most one futex at a
> > > time).
> > > 
> > 
> >   The patch you refer to is at
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=114725326712391&w=2
> 
> Thank you all.  I'll look into PI futexes which seems the right
> direction, but I still welcome short term (limited) solutions,
> hopefully work with existing glibc.  I'll look at the plist patch.

Three months after, I have tried kernel 2.6.18 with recent glibc.  I
got desired results for pthread_mutex_unlock and
pthread_cond_broadcast, with PI-mutex.

But pthread_cond_signal and sem_post still wakeup a thread in FIFO
order, as you can guess.

With the plist patch (applied by hand), I can get desired behavior.
Thank you.  But It seems the patch lacks reordering on priority
changes.

Are there any patch or future plan to address remaining wakeup-order
issues?


<off_topic>
BTW, If I tried to create a PI mutex on a kernel without PI futex
support, pthread_mutexattr_setprotocol(PTHREAD_PRIO_INHERIT) returned
0 and pthread_mutex_init() returned ENOTSUP.  This is not a right
behavior according to the manual ...
</off_topic>

---
Atsushi Nemoto
