Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUHaVsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUHaVsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbUHaVrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:47:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15574 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267505AbUHaUTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:19:17 -0400
Date: Tue, 31 Aug 2004 22:20:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831202051.GA1111@elte.hu>
References: <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net> <20040831070658.GA31117@elte.hu> <1093980065.1603.5.camel@krustophenia.net> <20040831193734.GA29852@elte.hu> <1093981634.1633.2.camel@krustophenia.net> <20040831195107.GA31327@elte.hu> <20040831200912.GA32378@elte.hu> <1093983034.1633.11.camel@krustophenia.net> <20040831201420.GA899@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831201420.GA899@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > File under boot-time stuff, I guess.  This could be bad if X crashes,
> > but I can't remember the last time this happened to me, and I use xorg
> > CVS.
> 
> but the first wbinvd() within prepare_set() seems completely unnecessary
> - we can flush the cache after disabling the cache just fine.

the third wbinvd() in post_set() seems unnecessary too - what kind of
cache do we expect to flush, we've disabled caching in the CPU ... But
the Intel pseudocode does it too - this is a thinko i think.

another thing is that interrupts are not disabled (although the Intel
docs suggest so). It is best to disable interrupts because any handler
executing in this window will perform extremely slowly (because caches
are disabled), and might even interfere with MTRR setting. Best disable
IRQs.

so ... could you try the patch below - does it work and how does the
latency look like now? (ontop of an unmodified generic.c)

	Ingo

--- linux/arch/i386/kernel/cpu/mtrr/generic.c.orig	
+++ linux/arch/i386/kernel/cpu/mtrr/generic.c	
@@ -240,11 +240,14 @@ static void prepare_set(void)
 	/*  Note that this is not ideal, since the cache is only flushed/disabled
 	   for this CPU while the MTRRs are changed, but changing this requires
 	   more invasive changes to the way the kernel boots  */
-	spin_lock(&set_atomicity_lock);
+	/*
+	 * Since we are disabling the cache dont allow any interrupts - they
+	 * would run extremely slow and would only increase the pain:
+	 */
+	spin_lock_irq(&set_atomicity_lock);
 
 	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | 0x40000000;	/* set CD flag */
-	wbinvd();
 	write_cr0(cr0);
 	wbinvd();
 
@@ -266,8 +269,7 @@ static void prepare_set(void)
 
 static void post_set(void)
 {
-	/*  Flush caches and TLBs  */
-	wbinvd();
+	/*  Flush TLBs (no need to flush caches - they are disabled)  */
 	__flush_tlb();
 
 	/* Intel (P6) standard MTRRs */
@@ -279,7 +281,7 @@ static void post_set(void)
 	/*  Restore value of CR4  */
 	if ( cpu_has_pge )
 		write_cr4(cr4);
-	spin_unlock(&set_atomicity_lock);
+	spin_unlock_irq(&set_atomicity_lock);
 }
 
 static void generic_set_all(void)
