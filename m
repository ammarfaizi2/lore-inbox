Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbUKHInV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUKHInV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 03:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUKHInV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 03:43:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:58268 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261785AbUKHInN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 03:43:13 -0500
Date: Mon, 8 Nov 2004 10:45:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
Message-ID: <20041108094504.GA10531@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <418F255D.80409@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418F255D.80409@mrv.com>
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


* Eran Mann <emann@mrv.com> wrote:

> Ingo Molnar wrote:
> >i have released the -V0.7.18 Real-Time Preemption patch, which can be
> >downloaded from:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
> 
> I got the attached oops on 2.6.10-rc1-mm3-RT-V0.7.18 (probably during the
> daily cron job). Later in the morning when I tried to access some 
> filesystems
> I got the attached deadlock report.

> Nov  8 04:19:32 eran kernel: BUG at include/linux/spinlock.h:767!
> Nov  8 04:19:32 eran kernel: ------------[ cut here ]------------
> Nov  8 04:19:32 eran kernel: kernel BUG at include/linux/spinlock.h:767!

ok, your bugreport pinpointed the bug: an RT-patch merging mistake when
i merged -RT to the spinlock-checker changes in recent BK.

the fix is below, but i've also put it into -V0.7.20 (which i released a
couple of minutes ago). Does this patch (or -V0.7.20) fix the kjournald
crash for you?

	Ingo

--- linux/include/linux/spinlock.h.orig
+++ linux/include/linux/spinlock.h
@@ -750,7 +750,7 @@ static inline void bit_spin_lock(int bit
  */
 static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
 	if (test_and_set_bit(bitnum, addr))
 		return 0;
 #endif
