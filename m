Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbTBQOQj>; Mon, 17 Feb 2003 09:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTBQOOP>; Mon, 17 Feb 2003 09:14:15 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:17675 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267265AbTBQOOF>; Mon, 17 Feb 2003 09:14:05 -0500
Date: Mon, 17 Feb 2003 17:23:19 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Richard Henderson <rth@twiddle.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Protect smp_call_function_data w/ spinlocks on Alpha
Message-ID: <20030217172319.A1161@jurassic.park.msu.ru>
References: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com> <20030214175332.A19234@jurassic.park.msu.ru> <Pine.LNX.4.50.0302141158070.3518-100000@montezuma.mastecende.com> <20030217001544.A13101@twiddle.net> <Pine.LNX.4.50.0302170316500.18087-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.50.0302170316500.18087-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Mon, Feb 17, 2003 at 03:32:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 03:32:09AM -0500, Zwane Mwaikambo wrote:
> Assigns whatever the pointer happens to be at the time, be it NULL or the 
> next incoming message call.

No, the pointer is guaranteed to be valid.

> Therefore we'd need a lock to protect both the variable and critical 
> section.

But smp_call_function_data pointer itself is exactly such a lock -
other CPUs can't enter the section between 'if (pointer_lock())' and
'smp_call_function_data = 0', so there is no need for extra lock
variable. Additionally, pointer_lock() with retry = 0 acts as spin_trylock.

> > I happen to like the pointer_lock a lot, and think we should
> > make more use of it on systems known to have cmpxchg.  It
> > saves on the number of cache lines that have to get bounced
> > between processors.
> 
> I have to agree there, it would save on locked operations per 
> 'acquisition' which can be a win on a lot of systems.

Here's cmpxchg version for illustration (untested).

Ivan.

--- linux/arch/alpha/kernel/smp.c.orig	Mon Feb 10 21:38:15 2003
+++ linux/arch/alpha/kernel/smp.c	Mon Feb 17 17:05:47 2003
@@ -680,17 +680,7 @@ pointer_lock (void *lock, void *data, in
 	mb();
  again:
 	/* Compare and swap with zero.  */
-	asm volatile (
-	"1:	ldq_l	%0,%1\n"
-	"	mov	%3,%2\n"
-	"	bne	%0,2f\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,1b\n"
-	"2:"
-	: "=&r"(old), "=m"(*(void **)lock), "=&r"(tmp)
-	: "r"(data)
-	: "memory");
-
+	old = cmpxchg(lock, 0, data);
 	if (old == 0)
 		return 0;
 	if (! retry)
