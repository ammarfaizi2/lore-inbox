Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWJRHUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWJRHUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWJRHUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:20:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7071 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751114AbWJRHUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:20:51 -0400
Date: Wed, 18 Oct 2006 09:12:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20061018071258.GA27949@elte.hu>
References: <20060920141907.GA30765@elte.hu> <1159639564.4067.43.camel@mindpipe> <20060930181804.GA28768@in.ibm.com> <200610132318.02512.annabellesgarden@yahoo.de> <20061013212450.GC7477@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013212450.GC7477@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> Sorry, I should have published my investigations long ago. I tracked 
> this down (atleast the crash in my machine) to NMI interference with 
> rcu_read_lock()/rcu_read_unlock(). We use those APIs from NMI context 
> as well 
> (default_do_nmi()->notify_die()->atomic_notifier_call_chain()).
> 
> Can you try with nmi_watchdog=0 in the kernel command line ?
> 
> Paul has an NMI-safe patch for rcupreempt which I am adopting and 
> testing at the moment. If this works well, I will publish a new 
> patchset.

spent some good time debugging this 2 weeks ago and added the fix below 
to rt5, but i forgot to do the symmetric fix for x86_64...

	Ingo

----------->
 arch/i386/kernel/traps.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -716,9 +716,6 @@ static void default_do_nmi(struct pt_reg
 		reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
-		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 2, SIGINT)
-							== NOTIFY_STOP)
-			return;
 #ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
@@ -729,6 +726,9 @@ static void default_do_nmi(struct pt_reg
 			return;
 		}
 #endif
+		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 2, SIGINT)
+							== NOTIFY_STOP)
+			return;
 		unknown_nmi_error(reason, regs);
 		return;
 	}

