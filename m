Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVA1Isu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVA1Isu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 03:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVA1Isu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 03:48:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:63969 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261224AbVA1Irz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 03:47:55 -0500
Date: Fri, 28 Jan 2005 09:47:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: George Anzinger <george@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
Subject: Re: High resolution timers and BH processing on -RT
Message-ID: <20050128084725.GB5004@elte.hu>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de> <20050128044301.GD29751@elte.hu> <1106900411.21196.181.camel@tglx.tec.linutronix.de> <20050128082439.GA3984@elte.hu> <1106901013.21196.194.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106901013.21196.194.camel@tglx.tec.linutronix.de>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > or is it that we have a 'group' of normal timers expiring, which, if
> > they happen to occur _just_ prior a HRT event will generate a larger
> > delay?
> 
> Yep. The timers expire at random times. So it's likely to have short
> sequences of timer interrupts going off. This needs reprogramming of
> the PIT and processing of the expired timers.

i dont really like the static splitup of 'normal' vs. 'HRT' timers -
there might in fact be separate priority requirements between HRT timers
too.

i think one possible solution would be to introduce some notion of
'timer priority', and to expire each timer priority level in a separate
timer expiry thread. Priority 0 (lowest) would be expired in ksoftirqd,
and there would be 3 separate threads for say priorities 1-3. Or
something like this. Potentially exposed to user-space as well, via new
APIs. Hm?

To push this even further: in theory timers could inherit the priority
of the task that starts them, and they would be expired in that priority
order - but this probably needs a pretty clever (and most likely
complex) data-structure ...

	Ingo
