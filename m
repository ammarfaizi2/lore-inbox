Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVJTWPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVJTWPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVJTWPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:15:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932537AbVJTWPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:15:51 -0400
Date: Thu, 20 Oct 2005 15:15:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
In-Reply-To: <20051020220228.GA26247@elte.hu>
Message-ID: <Pine.LNX.4.64.0510201512480.10477@g5.osdl.org>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
 <1129035658.23677.46.camel@localhost.localdomain> <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
 <434BDB1C.60105@cosmosbay.com> <Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
 <434BEA0D.9010802@cosmosbay.com> <20051017000343.782d46fc.akpm@osdl.org>
 <1129533603.2907.12.camel@laptopd505.fenrus.org> <20051020215047.GA24178@elte.hu>
 <Pine.LNX.4.64.0510201455030.10477@g5.osdl.org> <20051020220228.GA26247@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Oct 2005, Ingo Molnar wrote:
> 
> the unlock is simple even in the preemption case

No it's not. It needs to decrement the preemption counter and test it.

See kernel/spinlock.c:

	void __lockfunc _spin_unlock(spinlock_t *lock)
	{
	        _raw_spin_unlock(lock);
	        preempt_enable();
	}
	EXPORT_SYMBOL(_spin_unlock);

and look at what "preempt_enable()" does.

In other words, with CONFIG_PREEMPT, your patch is WRONG. You made 
"spin_unlock()" just skip the preempt_enable.

In fact, with preemption, the _locking_ is the simpler part. Unlock is the 
complex one.


			Linus
