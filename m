Return-Path: <linux-kernel-owner+willy=40w.ods.org-S282882AbUKAR41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S282882AbUKAR41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273016AbUKAR40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:56:26 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:51180 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S283713AbUKARzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:55:25 -0500
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
In-Reply-To: <1099324040.3337.32.camel@thomas>
References: <20041031120721.GA19450@elte.hu>
	 <20041031124828.GA22008@elte.hu>
	 <1099227269.1459.45.camel@krustophenia.net>
	 <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
	 <20041031162059.1a3dd9eb@mango.fruits.de>
	 <20041031165913.2d0ad21e@mango.fruits.de>
	 <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu>
	 <20041101135358.GA19718@elte.hu>  <20041101140630.GA20448@elte.hu>
	 <1099324040.3337.32.camel@thomas>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 12:55:23 -0500
Message-Id: <1099331723.3647.32.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 16:47 +0100, Thomas Gleixner wrote:
> The latencies are still there. I have the feeling it's worse than 0.6.2.
> 
> It's definitely irq-off. I have a card with a controller, which produces
> an 2ms interrupt. The controller busy loops until the second level ack
> is done. The time is measured from raising the irq to the 2nd level ack.

This was my conclusion as well.  I have a patch sitting around to add
this to the emu10k1 ALSA driver, it's quite useful.  It would be nice if
there were a facility in the kernel to easily identify missed interrupts
like this or (even better) unbalanced irq disable/enable - AFAICT
userspace alone cannot reliably distinguish lost interrupts from
scheduling problems (though you can get a lot of hints).  Paul mentioned
trying to debug the unbalanced irq disable in his talk at ZKM 2003, and
said it's hard because the hardware will enable/disable interrupts on
its own and he could not identify all those places.  Ingo, is there an
easy way to trace this like we do for unbalanced preempt count?

I think there might even be a _very_ rare errant irq disable in T3 even.
On my 2-day test runs with 100s of millions of samples, I got 2 or 3
outliers in each graph.  Jow Gwinn from LKML (thanks Joe) ran a
statistical analysis that showed these to be independent from the 4 or 5
underlying exponential distributions (each corresponding to a known or
suspected nonpreemptible section).  Our theory was that these were very
rare code paths or race conditions that left IRQs off.  Unfortunately
this seems impossible to debug unless you have a way to make the machine
crash dump immediately when it detects the situation.

Anyway, the clearest way to demonstrate the problem with the -V series
here is to run the version of Florian's tool that tells you how many
interrupts were missed.  If I spin my (USB, not sharing irq with
soundcard) trackball as fast as I can I can get it up to 54 or 55 in a
row.  If I move it just the right way I can see the humps appear - 2,
then 15, then 50 then 15 then 2 missed interrupts in a row.  This is at
1024Hz - at 2048 I can get it to miss several hundred IRQs, but this
inevitably locks the machine.

I suspect the lockups and the latencies are same bug.

Lee



