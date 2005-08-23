Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVHWOgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVHWOgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 10:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVHWOgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 10:36:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932070AbVHWOgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 10:36:23 -0400
Date: Tue, 23 Aug 2005 10:36:08 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Jakub Jelinek <jakub@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FUTEX_WAKE_OP (pthread_cond_signal speedup)
In-Reply-To: <20050823131817.GA7403@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0508231033270.18304@devserv.devel.redhat.com>
References: <20050823131817.GA7403@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Aug 2005, Jakub Jelinek wrote:

> Hi!
> 
> ATM pthread_cond_signal is unnecessarily slow, because it wakes one
> waiter (which at least on UP usually means an immediate context switch
> to one of the waiter threads).  This waiter wakes up and after a few
> instructions it attempts to acquire the cv internal lock, but that lock
> is still held by the thread calling pthread_cond_signal.  So it goes
> to sleep and eventually the signalling thread is scheduled in, unlocks
> the internal lock and wakes the waiter again.


> With the following benchmark on UP x86-64 I get:
> 
> for i in nptl-orig nptl-requeue nptl-wake_op; do echo time elf/ld.so --library-path .:$i /tmp/bench; \
> for j in 1 2; do echo ( time elf/ld.so --library-path .:$i /tmp/bench ) 2>&1; done; done
> time elf/ld.so --library-path .:nptl-orig /tmp/bench
> real 0m0.655s user 0m0.253s sys 0m0.403s
> real 0m0.657s user 0m0.269s sys 0m0.388s
> time elf/ld.so --library-path .:nptl-requeue /tmp/bench
> real 0m0.496s user 0m0.225s sys 0m0.271s
> real 0m0.531s user 0m0.242s sys 0m0.288s
> time elf/ld.so --library-path .:nptl-wake_op /tmp/bench
> real 0m0.380s user 0m0.176s sys 0m0.204s
> real 0m0.382s user 0m0.175s sys 0m0.207s

translation: effective thread switching is now almost twice as fast with
the WAKE_OP extension of the futex interface. Cool!

a detail: many of the futex_atomic_op_inuser() seem to be duplicated
across architectures. Might be worth putting into asm-generic, to avoid
the duplication?

	Ingo
