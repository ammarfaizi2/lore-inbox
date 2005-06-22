Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVFVSSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVFVSSr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFVSSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:18:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13502 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261814AbVFVSPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:15:19 -0400
Date: Wed, 22 Jun 2005 20:14:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, paulmck@us.ibm.com,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622181449.GC28597@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622173449.GA22474@elte.hu> <20050622174009.GA26059@elte.hu> <42B9AA00.7050301@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9AA00.7050301@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> 
> Ingo Molnar wrote:
> >>you could try the LPPTEST kernel driver and testlpp utility i 
> >>integrated into the -RT patchset. It avoids target-side latencies 
> >>almost completely. Especially since you had problems with parallel 
> >>interrupts you should give it a go and compare the results.
> > 
> > 
> > correction: logger-side latencies are avoided.
> 
> Sorry, I don't see this. I've just looked at lpptest.c and it does
> practically the same thing  LRTBF is doing, have a look for yourself
> at the code in LRTBF.

you should take another look. The crutial difference is that AFAICS 
lrtbf is using interrupts on _both_ the logger and the target side.  
lpptest only uses interrupts on the target side (that is what we are 
measuring), but uses polling _with all interrupts disabled_ on the 
logger side. This makes things much more reliable, as it's not some 
complex mix of two worst-case latencies, but a small constant overhead 
on the logger side and the worst-case latency on the target side. This 
also means i can run whatever lpptest version on the logger side, i dont 
have to worry about its latencies because there are none that are 
variable.

> In fact lpptest.c is probably running at a higher cost on the logger 
> since it executes a copy_to_user() for every single data point 
> collected. [...]

logger-side overhead does not matter at all, and the 8 bytes copy is not 
measured in the overhead. (it is also insignificant.)

> [...] In the case of the LRTBF, we just buffer the results in a 
> preallocated buffer and then read them all at once after the testrun.
> 
> Unless I'm missing something, there is nothing done in lpptest that we 
> aren't already doing on either side, logger-side latencies included.
>
> As for the interrupt problems, they were pilot error. They disappeared 
> once the APIC was enabled. That's therefore a non-issue.

well, LPPTEST works just fine with the i8259A PIC too. (which is much 
more common in embedded setups than IO-APICs)

	Ingo
