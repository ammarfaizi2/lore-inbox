Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVCaJUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVCaJUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVCaJTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:19:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22919 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261241AbVCaJI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:08:29 -0500
Date: Thu, 31 Mar 2005 11:08:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc1-RT-V0.7.41-15: it_real_fn oops on boot in run_timer_softirq
Message-ID: <20050331090814.GB22232@elte.hu>
References: <1112228970.19975.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112228970.19975.7.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Since 2.6.12-rc1-RT something I get this Oops on boot about 50% of the 
> time.  It's clearly some kind of race because if I just reboot again 
> it works.  Seems to happen shortly after ksoftirqd startup (maybe the 
> first time we hit the timer softirq?).
> 
> This is (lazily) hand copied and incomplete, but hopefully is enough 
> info...

hm, does the patch below help?

If not then please try to capture the full oops via serial logging, or 
if it's not possible, here are some guidelines wrt. how to minimize work 
when writing down oopses by hand:

1)

write down the EIP of the crash, and do:

	objdump -d vmlinux > vmlinux.asm
	grep -C 100 c0xxxxxx vmlinux.asm > toingo.asm

c0xxxxxx is the EIP of the oops. This way i'll know precisely which 
instruction crashed, and can match it up in my kernel image, even if i 
have a different .config and different build environment.

2)

Or write down the 'EIP is at ...' line plus ~10 bytes of the 'Code: ' 
line of the oops too, starting at the byte that is enclosed by <>. This 
info is enough in most cases.

	Ingo

--- linux/kernel/itimer.c.orig
+++ linux/kernel/itimer.c
@@ -138,7 +138,8 @@ void it_real_fn(unsigned long __data)
 	 * here because do_setitimer makes sure we have finished running
 	 * before it touches anything.
 	 */
-	it_real_arm(p, p->signal->it_real_incr);
+	if (p->signal)
+		it_real_arm(p, p->signal->it_real_incr);
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
