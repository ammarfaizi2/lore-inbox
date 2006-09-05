Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWIESUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWIESUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWIESUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:20:32 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28885 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030206AbWIESUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:20:30 -0400
Date: Tue, 5 Sep 2006 20:12:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060905181241.GC16207@elte.hu>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905130356.GB6940@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> The lock validator gives me this (latest -mm and 2.6.18-rc6):
> 
> ===================================== 
> [ BUG: bad unlock balance detected! ] 
> ------------------------------------- 
> swapper/0 is trying to release lock (resource_lock) at:
> [<0000000000042842>] request_resource+0x52/0x88 
> but there are no more locks to release! 
> 
> The reason is that the BUILD_LOCK_OPS macros in kernel/lockdep.c don't 
> contain any of the *_acquire calls, while all of the _unlock functions 
> contain a *_release call. Hence I get immediately unbalanced locks.

hmmm ... that sounds like a bug. Weird - i recently ran 
PREEMPT+SMP+LOCKDEP kernels and didnt notice this.

> Found this will debugging some random memory corruptions that happen 
> when CONFIG_PROVE_LOCKING and CONFIG_PROFILE_LIKELY are both on. 
> Switching both off or having only one of them on seems to work.

previously i had some weirdnesses with PROFILE_LIKELY too, they were 
caused by it generating cross-calls from within lockdep. Do the 
corruptions go away if you remove all likely() and unlikely() markings 
from kernel/lockdep.c?

	Ingo
