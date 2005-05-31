Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVEaSxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVEaSxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEaSxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:53:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22250 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261176AbVEaSxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:53:31 -0400
Date: Tue, 31 May 2005 20:41:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Machine Freezes while Running Crossover Office
Message-ID: <20050531184101.GA3175@elte.hu>
References: <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org> <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org> <courier.429C05C1.00005CC5@courier.cs.helsinki.fi> <20050531065456.GA21948@elte.hu> <1117558435.9228.7.camel@localhost> <Pine.LNX.4.58.0505311010410.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505311010410.1876@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> Ingo, any ideas? This is bothersome, because it could hit any number 
> of people, and we'd never have realized because it's not usually 
> repeatable and not usually quite that extreme. [...]

it's the fundamental unfairness of the interactivity code (or any 
interactivity code that plays favorites between tasks), and the larger 
pipe buffers made this more common it seems. It's quite dangerous to 
tune the scheduler so close to 2.6.12, but the issue seems serious 
enough. I think we could try to change INTERACTIVE_DELTA from 2 to 3 (or
even 4) instead of turning off the back-into-the-active-array logic
altogether.

Pekka, i've attached a quick hack that turns INTERACTIVE_DELTA into a 
runtime tunable. It defaults to the stock value of 2, but a value of '5' 
should be equivalent to the other patch you tried (but is less hacky).  

Now, assuming you can confirm that doing:

  echo 5 > /proc/sys/kernel/INTERACTIVE_DELTA

fixes the problem (all other things should be back to the default, i.e.  
no renicing of anything), then it would be interesting to find the 
minimum value where the problem goes away. I.e. we know that 2 is bad, 
but how bad are values 3 and 4?

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -90,7 +90,7 @@
 #define EXIT_WEIGHT		  3
 #define PRIO_BONUS_RATIO	 25
 #define MAX_BONUS		(MAX_USER_PRIO * PRIO_BONUS_RATIO / 100)
-#define INTERACTIVE_DELTA	  2
+int INTERACTIVE_DELTA = 2;
 #define MAX_SLEEP_AVG		(DEF_TIMESLICE * MAX_BONUS)
 #define STARVATION_LIMIT	(MAX_SLEEP_AVG)
 #define NS_MAX_SLEEP_AVG	(JIFFIES_TO_NS(MAX_SLEEP_AVG))
--- linux/kernel/sysctl.c.orig
+++ linux/kernel/sysctl.c
@@ -51,6 +51,8 @@
 
 #if defined(CONFIG_SYSCTL)
 
+extern int INTERACTIVE_DELTA;
+
 /* External variables not in a header file. */
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
@@ -275,6 +277,14 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= KERN_PANIC,
+		.procname	= "INTERACTIVE_DELTA",
+		.data		= &INTERACTIVE_DELTA,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= KERN_CORE_USES_PID,
 		.procname	= "core_uses_pid",
 		.data		= &core_uses_pid,
