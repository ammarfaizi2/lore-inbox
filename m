Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVAOOnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVAOOnd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 09:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVAOOnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 09:43:33 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9604 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262287AbVAOOna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 09:43:30 -0500
Date: Sat, 15 Jan 2005 15:43:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050115144302.GG10114@elte.hu>
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050111212139.GA22817@elte.hu> <87ekgnwaqx.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ekgnwaqx.fsf@sulphur.joq.us>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jack O'Quin <joq@io.com> wrote:

> --- kernel/sched.c~	Fri Dec 24 15:35:24 2004
> +++ kernel/sched.c	Wed Jan 12 23:48:49 2005
> @@ -95,7 +95,7 @@
>  #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
>  #define INTERACTIVE_DELTA	  2
>  #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
> -#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
> +#define STARVATION_LIMIT	0
>  #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
>  #define CREDIT_LIMIT		100

could you try the patch below? The above patch wasnt enough. With the
patch below we turn off the starvation limits for nice --20 tasks only. 
This is still a hack only. If we cannot make nice --20 perform like
RT-prio-1 then there's some problem with SCHED_OTHER scheduling.

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2245,10 +2245,10 @@ EXPORT_PER_CPU_SYMBOL(kstat);
  * if a better static_prio task has expired:
  */
 #define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
+	((task_nice(current) > -20) && ((STARVATION_LIMIT && ((rq)->expired_timestamp && \
 		(jiffies - (rq)->expired_timestamp >= \
 			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
+			((rq)->curr->static_prio > (rq)->best_expired_prio)))
 
 /*
  * Do the virtual cpu time signal calculations.
