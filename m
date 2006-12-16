Return-Path: <linux-kernel-owner+w=401wt.eu-S1030733AbWLPIHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030733AbWLPIHd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbWLPIHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:07:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38662 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030733AbWLPIHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:07:32 -0500
Date: Sat, 16 Dec 2006 09:04:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
Message-ID: <20061216080458.GC16116@elte.hu>
References: <20061216062633.GY21070@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216062633.GY21070@parisc-linux.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matthew Wilcox <matthew@wil.cx> wrote:

> Moreover, do we want to get stack dumps while running the locking 
> testsuite in the first place?  From various comments, it looks like 
> it's supposed to be turned off, but it looks like the sense of 
> debug_locks_silent is inverted in the definition of 
> DEBUG_LOCKS_WARN_ON:
> 
>         if (unlikely(c)) {                                              \
>                 if (debug_locks_silent || debug_locks_off())            \
>                         WARN_ON(1);                                     \
> 
> Surely that should be:
> 
> 		if (!debug_locks_silent && debug_locks_off())
> 			WARN_ON(1);

oops, indeed! Fix below.

	Ingo

------------->
Subject: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
From: Ingo Molnar <mingo@elte.hu>

Matthew Wilcox noticed that the debug_locks_silent use should be
inverted in DEBUG_LOCKS_WARN_ON(). This bug was causing spurious
stacktraces and incorrect failures in the locking self-test on the
parisc kernel.

Bug-found-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/debug_locks.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/linux/debug_locks.h
===================================================================
--- linux.orig/include/linux/debug_locks.h
+++ linux/include/linux/debug_locks.h
@@ -24,7 +24,7 @@ extern int debug_locks_off(void);
 	int __ret = 0;							\
 									\
 	if (unlikely(c)) {						\
-		if (debug_locks_silent || debug_locks_off())		\
+		if (!debug_locks_silent && debug_locks_off())		\
 			WARN_ON(1);					\
 		__ret = 1;						\
 	}								\
