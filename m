Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUI1HTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUI1HTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 03:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUI1HTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 03:19:51 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:5591 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267614AbUI1HTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 03:19:46 -0400
Date: Tue, 28 Sep 2004 09:21:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, tytso@mit.edu
Subject: Re: Stack traces in 2.6.9-rc2-mm4
Message-ID: <20040928072123.GA15177@elte.hu>
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net> <20040927085744.GA32407@elte.hu> <1096326753l.5222l.2l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096326753l.5222l.2l@werewolf.able.es>
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


* J.A. Magallon <jamagallon@able.es> wrote:

> I got the same on another place...
> 
> Sep 28 00:48:51 werewolf kernel: using smp_processor_id() in preemptible 
> code: X/4012
> Sep 28 00:48:51 werewolf kernel:  [smp_processor_id+135/141] 
> smp_processor_id+0x87/0x8d
> Sep 28 00:48:51 werewolf kernel:  [add_timer_randomness+314/365] 
> add_timer_randomness+0x13a/0x16d
> Sep 28 00:48:51 werewolf kernel:  [<b0206733>] 
> add_timer_randomness+0x13a/0x16d
> Sep 28 00:48:51 werewolf kernel:  [input_event+85/999] 
> input_event+0x55/0x3e7

the one below should fix this: a certain codepath in the random driver
relied on vt_ioctl() being under the BKL and implicitly disabling
preemption. The code wasnt buggy upstream but it's slighly unrobust so i
think we want the fix upstream too, independently of the remove-bkl
patch. This change has been in the -VP patchset for some time so it
should work fine.

	Ingo

--- linux/drivers/char/random.c.orig	
+++ linux/drivers/char/random.c	
@@ -807,10 +807,11 @@ static void add_timer_randomness(struct 
 	long		delta, delta2, delta3;
 	int		entropy = 0;
 
+	preempt_disable();
 	/* if over the trickle threshold, use only 1 in 4096 samples */
 	if ( random_state->entropy_count > trickle_thresh &&
 	     (__get_cpu_var(trickle_count)++ & 0xfff))
-		return;
+		goto out;
 
 	/*
 	 * Use get_cycles() if implemented, otherwise fall back to
@@ -861,6 +862,8 @@ static void add_timer_randomness(struct 
 		entropy = int_ln_12bits(delta);
 	}
 	batch_entropy_store(num, time, entropy);
+out:
+	preempt_enable();
 }
 
 void add_keyboard_randomness(unsigned char scancode)
