Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319863AbSINKTM>; Sat, 14 Sep 2002 06:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319865AbSINKTM>; Sat, 14 Sep 2002 06:19:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41700 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319863AbSINKTL>;
	Sat, 14 Sep 2002 06:19:11 -0400
Date: Sat, 14 Sep 2002 12:30:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Larson <plars@linuxtestproject.org>, <linux-kernel@vger.kernel.org>
Subject: [patch] Re: New failures in nightly LTP test
In-Reply-To: <1031951881.9630.74.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0209141227410.16893-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Sep 2002, Paul Larson wrote:

> The nightly LTP test against the 2.5 kernel bk tree last night turned up
> some test failures we don't normally see.  These failures did not show
> up in the run from the previous night.

[...]
> I found what was breaking this, looks like it was this change from your
> shared thread signals patch:
> -	if (sig < 1 || sig > _NSIG ||
> -	    (act && (sig == SIGKILL || sig == SIGSTOP)))
> +	if (sig < 1 || sig > _NSIG || (act && sig_kernel_only(sig)))

the attached patch (against BK-curr) fixes this bug and a number of others
in the same class - the signal behavior bitmasks should never be consulted
before making sure that the signal is in the word range. Paul, does this
fix all the LTP regressions?

	Ingo

--- linux/kernel/signal.c.orig	Sat Sep 14 11:25:30 2002
+++ linux/kernel/signal.c	Sat Sep 14 11:42:29 2002
@@ -118,14 +118,18 @@
 #define T(sig, mask) \
 	((1UL << (sig)) & mask)
 
-#define sig_user_specific(sig)		T(sig, SIG_USER_SPECIFIC_MASK)
+#define sig_user_specific(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_USER_SPECIFIC_MASK))
 #define sig_user_load_balance(sig) \
-		(T(sig, SIG_USER_LOAD_BALANCE_MASK) || ((sig) >= SIGRTMIN))
-#define sig_kernel_specific(sig)	T(sig, SIG_KERNEL_SPECIFIC_MASK)
+		(((sig) >= SIGRTMIN) || T(sig, SIG_USER_LOAD_BALANCE_MASK))
+#define sig_kernel_specific(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_SPECIFIC_MASK))
 #define sig_kernel_broadcast(sig) \
-		(T(sig, SIG_KERNEL_BROADCAST_MASK) || ((sig) >= SIGRTMIN))
-#define sig_kernel_only(sig)		T(sig, SIG_KERNEL_ONLY_MASK)
-#define sig_kernel_coredump(sig)	T(sig, SIG_KERNEL_COREDUMP_MASK)
+		(((sig) >= SIGRTMIN) || T(sig, SIG_KERNEL_BROADCAST_MASK))
+#define sig_kernel_only(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_ONLY_MASK))
+#define sig_kernel_coredump(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_COREDUMP_MASK))
 
 #define sig_user_defined(t, sig) \
 	(((t)->sig->action[(sig)-1].sa.sa_handler != SIG_DFL) &&	\

