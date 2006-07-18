Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWGRN2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWGRN2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWGRN2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:28:45 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:20199
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932197AbWGRN2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:28:41 -0400
Date: Tue, 18 Jul 2006 15:29:41 +0200
From: andrea@cpushare.com
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "bruce@andrew.cmu.edu" <bruce@andrew.cmu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] TIF_NOTSC and SECCOMP prctl
Message-ID: <20060718132941.GG5726@opteron.random>
References: <200607180623_MC3-1-C54F-3802@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607180623_MC3-1-C54F-3802@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 06:20:20AM -0400, Chuck Ebbert wrote:
> AFAIC the /proc method of controlling seccomp is so ugly it should
> just go, but what about backwards compatibility?

Given that so far CPUShare seems the only user there should be no
problem, I already uploaded a new CPUShare package that handles both
the old and new interfaces transparently, no matter what kernel runs
under it.

> I have a couple of questions:
> 
> 
> +void disable_TSC(void)
> +{
> +       if (!test_and_set_thread_flag(TIF_NOTSC))
> +               /*
> +                * Must flip the CPU state synchronously with
> +                * TIF_NOTSC in the current running context.
> +                */
> +               hard_disable_TSC();
> +}
> 
> This gets called from sys_prctl().  Do you need to worry about preemption
> between the test_and_set and TSC disable?

I tend to completely forget about preempt.

> Maybe these should be inline?  They're really small and that way you
> don't need #ifdef around the code for them.

I wanted to reduce the bytecode overhead to the minimum when seccomp
is set to y, for that I tried to avoided inlines.

> For x86_64 you need this:
> 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/tif-flags-for-debug-regs-and-io-bitmap-in-ctxsw
> 
> But I don't think Andi plans on pushing it for 2.6.18.

Thanks for the pointer.

For now the patch I posted already works on x86-64 and on all other
archs (x86_64 misses the notsc feature for now, but that's not a
problem, the patch is self contained and we can take care of the notsc
for x86-64 later on).

This is the incremental patch to address the preempt=y kernel builds.

diff -r 373f0be00c40 arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Sun Jul 16 15:51:54 2006 +0200
+++ b/arch/i386/kernel/process.c	Tue Jul 18 14:59:23 2006 +0200
@@ -542,12 +542,14 @@ void hard_disable_TSC(void)
 }
 void disable_TSC(void)
 {
+	preempt_disable();
 	if (!test_and_set_thread_flag(TIF_NOTSC))
 		/*
 		 * Must flip the CPU state synchronously with
 		 * TIF_NOTSC in the current running context.
 		 */
 		hard_disable_TSC();
+	preempt_enable();
 }
 void hard_enable_TSC(void)
 {
