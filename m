Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUIUHR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUIUHR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 03:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUIUHR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 03:17:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27546 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267497AbUIUHRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 03:17:12 -0400
Date: Tue, 21 Sep 2004 09:18:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: BKL backtraces - was: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040921071854.GA7604@elte.hu>
References: <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <414F8CFB.3030901@cybsft.com>
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


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* K.R. Foley <kr@cybsft.com> wrote:

> All of these were generated while booting:
> 
> Sep 20 19:45:10 porky kernel: using smp_processor_id() in preemptible 
> code: modprobe/1019
> Sep 20 19:45:10 porky kernel:  [<c011c58e>] smp_processor_id+0x8e/0xa0
> Sep 20 19:45:10 porky kernel:  [<c013ace6>] module_unload_init+0x46/0x70
> Sep 20 19:45:10 porky kernel:  [<c013ce58>] load_module+0x598/0xb10
> Sep 20 19:45:10 porky kernel:  [<c013d438>] sys_init_module+0x68/0x280
> Sep 20 19:45:10 porky kernel:  [<c01066b9>] sysenter_past_esp+0x52/0x71
> 
> The above one of course repeats on each module load.

ok, this is a harmless false positive - the attached patch fixes it.

> Sep 20 19:45:10 porky kernel: using smp_processor_id() in preemptible 
> code: X/1017
> Sep 20 19:45:10 porky kernel:  [<c011c58e>] smp_processor_id+0x8e/0xa0
> Sep 20 19:45:10 porky kernel:  [<c01d6c15>] add_timer_randomness+0x125/0x150
> Sep 20 19:45:10 porky kernel:  [<c01d6c9e>] add_mouse_randomness+0x1e/0x30
> Sep 20 19:45:10 porky kernel:  [<c022b835>] input_event+0x55/0x3f0

> Sep 20 19:45:10 porky kernel:  [<c01e1390>] vt_ioctl+0x0/0x1ad0
> Sep 20 19:45:10 porky kernel:  [<c01dc08b>] tty_ioctl+0x37b/0x4d0
> Sep 20 19:45:10 porky kernel:  [<c0175034>] sys_ioctl+0xe4/0x240
> Sep 20 19:45:10 porky kernel:  [<c01066b9>] sysenter_past_esp+0x52/0x71
> 
> The X one above repeats once also.

aha! This is a real one, fixed by the second patch. This piece of code
relied on add_timer_randomness() always being called with preemption
disabled.

these fixes will show up in -S2.

	Ingo

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=1

--- linux/kernel/module.c.orig	
+++ linux/kernel/module.c	
@@ -394,7 +394,7 @@ static void module_unload_init(struct mo
 	for (i = 0; i < NR_CPUS; i++)
 		local_set(&mod->ref[i].count, 0);
 	/* Hold reference count during initialization. */
-	local_set(&mod->ref[smp_processor_id()].count, 1);
+	local_set(&mod->ref[_smp_processor_id()].count, 1);
 	/* Backwards compatibility macros put refcount during init. */
 	mod->waiter = current;
 }

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=2

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

--YZ5djTAD1cGYuMQK--
