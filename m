Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVLOPyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVLOPyR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVLOPyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:54:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750776AbVLOPyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:54:16 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0512141840370.3292@g5.osdl.org> 
References: <Pine.LNX.4.64.0512141840370.3292@g5.osdl.org>  <1134559121.25663.14.camel@localhost.localdomain> <13820.1134558138@warthog.cambridge.redhat.com> <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com> <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org> <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu> <6281.1134498864@warthog.cambridge.redhat.com> <14242.1134558772@warthog.cambridge.redhat.com> <16315.1134563707@warthog.cambridge.redhat.com> <1134568731.4275.4.camel@tglx.tec.linutronix.de> <43A0AD54.6050109@rtr.ca> <1134604667.2542.86.camel@tglx.tec.linutronix.de> <43A0B172.7020800@rtr.ca> <1134605406.2542.91.camel@tglx.tec.linutronix.de> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Lord <lkml@rtr.ca>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Jackson <pj@sgi.com>,
       mingo@elte.hu, hch@infradead.org, akpm@osdl.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 15 Dec 2005 15:53:48 +0000
Message-ID: <4691.1134662028@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> Dammit, unless the pure mutex has a _huge_ performance advantage on major 
> architectures, we're not changing it.

Whilst it's true that the major archs are generally where the least advantage
will be seen, consider the following points:

 (1) The major archs are generally the ones where consuming a few extra bytes
     of kernel code so as to hold the slow paths for the mutexes would matter
     least.

 (2) The minor archs are where the performance gain would be most noticable
     because many of them only have unconditional state substitution
     capabilities (XCHG/TAS/SWAP/BSET), and no matter how much you may not
     care for them, they do matter.

     Having to use spinlocks and interrupt disablement in lieu of conditional
     state substitution (such as CMPXCHG) can cost quite a bit.

 (3) Mutex performance should in no way be slower on any arch than counting
     semaphores being used to do the same job. Now, admittedly, my first
     attempt was suboptimal for archs that have better-than-XCHG capabilities,
     but I've amended that with Ingo's help, just not released it yet.

> There's absolutely zero point. A counting semaphore is a perfectly fine
> mutex

But that isn't so in one particular case: debugging. A mutex would balk at a
double-release, but a counting semaphore will just silently let things go
wrong, because that's the nature of the beast.

> - the fact that it can _also_ be used to allow more than 1 user into a
> critical region and generally do other things is totally immaterial.

There are about a dozen such uses of counting semaphores in the kernel, and
they're mainly used as token/message counters.

> It's _extra_ stupid to re-use the names "down()" and "up()" on a 
> non-counting mutex, since then the names make zero sense at all. Use 
> "lock_mutex()" and "unlock_mutex()" or something, and don't break existing 
> code for no measurable gain.

Okay. Repurposing up(), down(), DECLARE_MUTEX() and init_MUTEX() had the major
benefit that the kernel required relatively few changes. The biggest problem
with doing a whole new mutex type with a new and different API is that
DECLARE_MUTEX and init_MUTEX are already taken... :-/

David
