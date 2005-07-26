Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVGZMAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVGZMAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVGZMAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:00:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4999 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261716AbVGZMAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:00:30 -0400
Date: Tue, 26 Jul 2005 14:00:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 PREEMPT_RT && PPC
Message-ID: <20050726120015.GB9224@elte.hu>
References: <200507200816.11386.kernel@kolivas.org> <20050719223216.GA4194@elte.hu> <1121819037.26927.75.camel@dhcp153.mvista.com> <200507201104.48249.kernel@kolivas.org> <1121822524.26927.85.camel@dhcp153.mvista.com> <42DF293A.4050702@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DF293A.4050702@timesys.com>
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


* john cooper <john.cooper@timesys.com> wrote:

> Ingo,
>     Attached is a patch for 51-28 which brings PPC up to date for 
> 2.6.12 PREEMPT_RT.  My goal was to get a more recent vintage of this 
> work building and minimally booting for PPC.  Yet this has been stable 
> even under our internal stress tests.  We now have this running on 
> 8560 and 8260 PPC targets with a few others in the pipe.

great. I've applied most of your patch and have released the -51-37 
kernel. A couple of generic bits i did not apply.

> In the process of producing the patch I stumbled across a change 
> introduced in 51-15 where in the case of PREEMPT_RT it appears 
> hw_irq_controller.end() is never being called at the end of 
> do_hardirq(). This appears to be an oversight in the code and the 
> existing PPC openpic code does register a end() handler which it 
> expects to be called in order to terminate the interrupt.  Otherwise 
> interrupts at the current level are effectively disabled.

this change was fully intentional. Basically on PREEMPT_HARDIRQS, the 
'redirected' interrupt path is special already. Right now when an IRQ is 
redirected, we do the following: ->ack() in the hardirq handler and no 
->end() (so we keep the interrupt masked), then the handling of the IRQ 
sometime later in its interrupt thread, and an ->enable(). It's a bit 
unclean, but this results in minimal per-arch changes to the IRQ code.  
Nevertheless i have applied your change, but we need to get rid of this.

> There is also what I suspect to be some "leaking" of the 
> __RAW_LOCAL_ILLEGAL_MASK bit out of the local_irq*() API primitives as 
> the *flags argument. This may subsequently be used by non-local_irq*() 
> primitives and wind up unintentionally setting the 
> __RAW_LOCAL_ILLEGAL_MASK bit in the machine control register with 
> unpredictable results.

i have not applied the generic bits for this, because it should be 
solved within the raw_local_irq*() code: check for the illegal bit if 
IRQ debugging is turned on. We very much want to know about mismatched 
IRQ flags.

> Lastly there is a problem I've yet to isolate in 
> kernel/printk.c:release_console_sem() where the expansion of 
> spin_unlock_irq(&logbuf_lock) generating a call to 
> __raw_local_irq_enable() will lockup console output on PPC.  In the 
> interim this has been reverted to a spin_unlock() call for the case of 
> PREEMPT_RT && PPC.

i have not applied this one either, please investigate it further, it 
ought to work.

Also, i have not applied the timer.c change yet either: what kind of bug 
are you trying to fix there?

	Ingo
