Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUJWKhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUJWKhL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUJWKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:34:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20102 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267283AbUJWK16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:27:58 -0400
Date: Sat, 23 Oct 2004 12:29:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041023102909.GD30270@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <32871.192.168.1.5.1098491242.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32871.192.168.1.5.1098491242.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Regarding the jackd -R issue, I was trying to capture some debug data
> via netconsole on my laptop (P4/UP) running RT-U10.2, and when the
> system freezes as reported before, I was able to kick the SysRq+T.
> But, instead of a task trace list, I get the following:
> 
> SysRq : <3>BUG: sleeping function called from invalid context IRQ 1(776)
> at kernel/mutex.c:37
> in_atomic():1 [00000001], irqs_disabled():1
>  [<c0104ee4>] dump_stack+0x1e/0x20 (20)
>  [<c0114a23>] __might_sleep+0xb2/0xc7 (36)
>  [<c012c0f2>] _mutex_lock+0x39/0x5e (28)

> preempt count: 00000002
> . 2-level deep critical section nesting:
> .. entry 1: __sysrq_lock_table+0x12/0x14 [<c01f482b>] /
> (__handle_sysrq+0x1a/0xed [<c01f482b>])
> .. entry 2: print_traces+0x16/0x48 [<c0104ee4>] / (dump_stack+0x1e/0x20

does the patch below help?

	Ingo

--- linux/drivers/char/sysrq.c.orig
+++ linux/drivers/char/sysrq.c
@@ -252,7 +252,7 @@ static struct sysrq_key_op sysrq_kill_op
 
 
 /* Key Operations table and lock */
-static DECLARE_RAW_SPINLOCK(sysrq_key_table_lock);
+static DECLARE_SPINLOCK(sysrq_key_table_lock);
 #define SYSRQ_KEY_TABLE_LENGTH 36
 static struct sysrq_key_op *sysrq_key_table[SYSRQ_KEY_TABLE_LENGTH] = {
 /* 0 */	&sysrq_loglevel_op,
