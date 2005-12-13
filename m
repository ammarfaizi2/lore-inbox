Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVLMKfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVLMKfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 05:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVLMKfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 05:35:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59355 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964831AbVLMKfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 05:35:03 -0500
Date: Tue, 13 Dec 2005 11:34:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213103420.GA6681@elte.hu>
References: <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <20051213101300.GA2178@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213101300.GA2178@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > > We have atomic_cmpxchg. Can you use that for a sufficient generic
> > > implementation?
> > 
> > No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.
> 
> take a look at the PREEMPT_RT implementation of mutexes: it uses 
> cmpxchg(), and thus both the down() and the up() fastpath is lockless!  
> (And that is a mutex type that does alot more things, as it supports 
> priority inheritance.)
> 
> architectures which dont have cmpxchg can use a spinlock just fine.

the cost of a spinlock-based generic_cmpxchg could be significantly 
reduced by adding a generic_cmpxchg() variant that also includes a 
'spinlock pointer' parameter.

Architectures that do not have the instruction, can use the specified 
spinlock to do the cmpxchg. This means that there wont be one single 
global spinlock to emulate cmpxchg, but the mutex's own spinlock can be 
used for it.

Architectures that have the cmpxchg instruction would simply ignore the 
parameter, and would incur no overhead.

	Ingo
