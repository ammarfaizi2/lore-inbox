Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUIPHnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUIPHnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIPHnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:43:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30603 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267823AbUIPHnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:43:08 -0400
Date: Thu, 16 Sep 2004 09:44:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@fsmlabs.com>,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916074431.GA13713@elte.hu>
References: <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu> <20040916065342.GE12915@wotan.suse.de> <20040916065805.GA12244@elte.hu> <20040916070902.GF12915@wotan.suse.de> <20040916071931.GA12876@elte.hu> <20040916072959.GH12915@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916072959.GH12915@wotan.suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> Something is mixed up here:
> 
> The whole problem only happens on kernels using frame pointer. I never
> saw it, simply because I don't use frame pointers.
>
> On a frame pointer less kernel profiling works just fine, and with
> this fix it should work the same on a FP kernel.

it only works on pointer less kernels because the spinlock profile 
unwinding is _conditional_ on an FP kernel right now:

 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 unsigned long profile_pc(struct pt_regs *regs)
 {
 ...

on non-FP kernels you'll see all the overhead in the single spin_lock()
function, agreed?

> > in this respect - it might work if you can detect for sure at build time
> > whether there's any local variable. Tricks like this really tend to
> > haunt us later.
> 
> There are already lots of such assumptions in the kernel (e.g. WCHAN
> and others).  I don't think adding one more is a big issue.

wchan has only one assumption: that that all __sched section functions
have a valid frame pointer. This is not unrobust at all. (it is
nonperformant though on register-starved platforms and having proper
unwind would fix wchan too.) In fact ->real_pc could be used by __sched
functions as well, it would likely be cheaper (on x86) than having to
compile with -fno-omit-frame-pointers.

	Ingo
