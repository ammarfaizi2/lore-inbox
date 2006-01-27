Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWA0BmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWA0BmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWA0BmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:42:00 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:57860 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030254AbWA0Bl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:41:59 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mingo@elte.hu (Ingo Molnar)
Subject: Re: [lock validator] net/ipv4/fib_hash.c: illegal {enabled-softirqs} -> {used-in-softirq} usage?
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20060127001807.GA17179@elte.hu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au>
Date: Fri, 27 Jan 2006 12:41:47 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> the lock validator i'm working on found another item:
> 
>  ============================
>  [ BUG: illegal lock usage! ]
>  ----------------------------
>  illegal {enabled-softirqs} -> {used-in-softirq} usage.
>  hackbench/8407 [HC0[0]:SC1[2]:HE1:SE0] takes:
>   {&state[i].lock} [<c0bf7d08>] wrandom_flush+0x2a/0xb3
>  {enabled-softirqs} state was registered at:
>   [<c0befc33>] fn_hash_insert+0x565/0x5c3
>  hardirqs last enabled at: [<c0d29a36>] _spin_unlock_irq+0xd/0x10
>  softirqs last enabled at: [<c012d0a0>] irq_exit+0x36/0x38
>  
>  other info that might help us debug this:
>  locks held by hackbench/8407: <none>
>  
>  stack backtrace:
>   [<c0103e86>] show_trace+0xd/0xf
>   [<c0103e9d>] dump_stack+0x15/0x17
>   [<c013eb40>] print_usage_bug+0x16d/0x177
>   [<c013f130>] mark_lock+0xe3/0x248
>   [<c013f65d>] debug_lock_chain+0x3c8/0xb1d
>   [<c013fde3>] debug_lock_chain_spin+0x31/0x48
>   [<c0410c4e>] _raw_spin_lock+0x34/0x7f
>   [<c0d298fd>] _spin_lock+0x8/0xa
>   [<c0bf7d08>] wrandom_flush+0x2a/0xb3

Good catch.  In fact the other spin lock operation in the same file needs
BH protection as well since it is invoked by the output route path which
can be in user-context for local packets.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
