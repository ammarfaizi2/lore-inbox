Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937389AbWLEI0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937389AbWLEI0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 03:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937486AbWLEI0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 03:26:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44524 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937389AbWLEI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 03:26:30 -0500
Date: Tue, 5 Dec 2006 09:25:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2.6.19-rt1, yum/rpm
Message-ID: <20061205082553.GA13000@elte.hu>
References: <20061130083358.GA351@elte.hu> <200612050119.59113.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612050119.59113.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> I tweaked latency_trace.c to make freerunning work. Will post later.

ok, please do.

i'm trying to understand your trace:

> Below the trace shows i_usX2Y_usbpcm_urb_complete() running under an 
> alien context, and this is where jackd starts stalling:

by 'alien context' do you mean softirq--4? That is the following kernel 
thread:

    4 ?        S      0:00 [softirq-high/0]

handling HI_SOFTIRQ softirqs, which are the 'highprio' tasklets.

>   IRQ_17-308   0D..2 3411063us : deactivate_task <IRQ_17-308> (180 2)
> softirq--4     0D..2 3411064us+: __schedule <IRQ_17-308> (180 101)
> softirq--4     0.... 3411072us+: i_usX2Y_usbpcm_urb_complete (8 0 dd134)
> softirq--4     0.... 3411078us : try_to_wake_up (c011b4ab 0 0)
> softirq--4     0D..1 3411079us : __activate_task <jackd-2667> (173 1)
> softirq--4     0Dn.1 3411079us : try_to_wake_up <jackd-2667> (173 101)
> softirq--4     0Dn.1 3411080us : __schedule (c032a862 0 0)
>    jackd-2667  0D..2 3411081us+: __schedule <softirq--4> (101 173)

it's running at SCHED_FIFO prio 80.

it's probably this use in sound/usb/usbmidi.c:

                tasklet_hi_schedule(&port->ep->tasklet);

so what is your observation - if i_usX2Y_usbpcm_urb_complete() is 
executed in this tasklet then you are seeing xruns/delays?

	Ingo
