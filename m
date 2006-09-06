Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWIFGz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWIFGz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWIFGz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:55:29 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:51845 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751509AbWIFGz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:55:28 -0400
Date: Wed, 6 Sep 2006 08:54:51 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060906065451.GA6898@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <20060905181241.GC16207@elte.hu> <20060905190807.GA27171@elte.hu> <20060905193742.GA1566@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905193742.GA1566@elte.hu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > The reason is that the BUILD_LOCK_OPS macros in kernel/lockdep.c 
> > > > don't contain any of the *_acquire calls, while all of the _unlock 
> > > > functions contain a *_release call. Hence I get immediately 
> > > > unbalanced locks.
> > > 
> > > hmmm ... that sounds like a bug. Weird - i recently ran 
> > > PREEMPT+SMP+LOCKDEP kernels and didnt notice this.
> > 
> > ok, the reason i didnt find this problem is because this is fixed in 
> > my tree, but i didnt realize that it's a fix also for upstream ...
> 
> actually ... it works fine in the upstream kernel due to this:
> 
>   * If lockdep is enabled then we use the non-preemption spin-ops
>   * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
>   * not re-enabled during lock-acquire (which the preempt-spin-ops do):
>   */
>  #if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
>          defined(CONFIG_DEBUG_LOCK_ALLOC)
> 
> so i'm wondering, how did you you manage to get into the 
> BUILD_LOCK_OPS() branch?

That seems to be code that isn't upstream. 2.6.18-rc5-mm1 as well as
Linus' current git tree have this:

/*
 * If lockdep is enabled then we use the non-preemption spin-ops
 * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
 * not re-enabled during lock-acquire (which the preempt-spin-ops do):
 */
#if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
        defined(CONFIG_PROVE_LOCKING)

And yes, using CONFIG_DEBUG_LOCK_ALLOC instead of CONFIG_PROVE_LOCKING fixes
this for me :)
