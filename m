Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVA1E2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVA1E2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 23:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVA1E2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 23:28:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:14532 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261439AbVA1E2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 23:28:30 -0500
Date: Fri, 28 Jan 2005 05:28:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, pwil3058@bigpond.net.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling bugs
Message-ID: <20050128042815.GA29751@elte.hu>
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au> <20041116232827.GA842@elte.hu> <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org> <20050127165330.6f388054.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127165330.6f388054.pj@sgi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> A long time ago, Linus wrote:
> > An atomic op is pretty much as expensive as a spinlock/unlock pair on x86.  
> > Not _quite_, but it's pretty close.
> 
> Are both read and modify atomic ops relatively expensive on some CPUs,
> or is it just modify atomic ops?
> 
> (Ignoring for this question the possibility that a mix of read and
> modify ops could heat up a cache line on multiprocessor systems, and
> focusing for the moment just on the CPU internals ...)

if by 'some CPUs' you mean x86 then it's the LOCK prefixed ops that are
expensive. I.e. all the LOCK-prefixed RMW variants of instructions:

 atomic.h:               LOCK "addl %1,%0"
 atomic.h:               LOCK "subl %1,%0"
 atomic.h:               LOCK "subl %2,%0; sete %1"
 atomic.h:               LOCK "incl %0"
 atomic.h:               LOCK "decl %0"
 atomic.h:               LOCK "decl %0; sete %1"
 atomic.h:               LOCK "incl %0; sete %1"
 atomic.h:               LOCK "addl %2,%0; sets %1"
 atomic.h:               LOCK "xaddl %0, %1;"
 atomic.h:__asm__ __volatile__(LOCK "andl %0,%1" \
 atomic.h:__asm__ __volatile__(LOCK "orl %0,%1" \

pure reads/writes are architecturally guaranteed to be atomic (so
atomic.h uses them, not some fancy instruction) and they are (/better
be) fast.

interestingly, the x86 spinlock implementation uses a LOCK-ed
instruction only on acquire - it uses a simple atomic write (and
implicit barrier assumption) on the way out:

 #define spin_unlock_string \
         "movb $1,%0" \
                 :"=m" (lock->slock) : : "memory"

no LOCK prefix. Due to this spinlocks can sometimes be _cheaper_ than
doing the same via atomic inc/dec.

	Ingo
