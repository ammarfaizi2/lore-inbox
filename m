Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWGLWys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWGLWys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWGLWys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:54:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19876 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932413AbWGLWyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:54:47 -0400
Date: Thu, 13 Jul 2006 00:49:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712224904.GA14500@elte.hu>
References: <20060630014050.GI19712@stusta.de> <200607130006.12705.ak@suse.de> <20060712221910.GA12905@elte.hu> <200607130033.16555.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607130033.16555.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> 
> > > I can put in a patch into my tree for the next merge to disable the 
> > > TSC disable code on i386 too like I did earlier for x86-64.
> > 
> > please do.
> 
> Hmm, with the new thread test as it was pointed out it can be indeed 
> made zero cost for the common case. Perhaps that's not needed then.

putting aside the fundamental fallacy of disabling TSC based timing 
attacks while not even considering network-based timing attacks (which 
are still very much possible), Chuck's approach of pushing the seccomp 
TSC cr4 twiddling into the context-switch slowpath is the right 
solution, given the circumstances. Will Chuck's patch be in 2.6.18? If 
not then my months-old patch below should be applied.

	Ingo

----

remove TSC-disabling logic from the context-switch hotpath. It has
marginal security relevance. Truly paranoid users can boot with the
TSC disabled anyway.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 arch/i386/kernel/process.c |   29 -----------------------------
 1 files changed, 29 deletions(-)

Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -589,33 +589,6 @@ handle_io_bitmap(struct thread_struct *n
 }
 
 /*
- * This function selects if the context switch from prev to next
- * has to tweak the TSC disable bit in the cr4.
- */
-static inline void disable_tsc(struct task_struct *prev_p,
-			       struct task_struct *next_p)
-{
-	struct thread_info *prev, *next;
-
-	/*
-	 * gcc should eliminate the ->thread_info dereference if
-	 * has_secure_computing returns 0 at compile time (SECCOMP=n).
-	 */
-	prev = prev_p->thread_info;
-	next = next_p->thread_info;
-
-	if (has_secure_computing(prev) || has_secure_computing(next)) {
-		/* slow path here */
-		if (has_secure_computing(prev) &&
-		    !has_secure_computing(next)) {
-			write_cr4(read_cr4() & ~X86_CR4_TSD);
-		} else if (!has_secure_computing(prev) &&
-			   has_secure_computing(next))
-			write_cr4(read_cr4() | X86_CR4_TSD);
-	}
-}
-
-/*
  *	switch_to(x,yn) should switch tasks from x to y.
  *
  * We fsave/fwait so that an exception goes off at the right time
@@ -709,8 +682,6 @@ struct task_struct fastcall * __switch_t
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
 		handle_io_bitmap(next, tss);
 
-	disable_tsc(prev_p, next_p);
-
 	return prev_p;
 }
 
