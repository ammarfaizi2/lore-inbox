Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUHMKHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUHMKHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHMKHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:07:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37816 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265237AbUHMKGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:06:12 -0400
Date: Fri, 13 Aug 2004 12:07:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040813100736.GA8135@elte.hu>
References: <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu> <20040811141649.447f112f@mango.fruits.de> <20040811124342.GA17017@elte.hu> <1092268536.1090.7.camel@mindpipe> <20040812072127.GA20386@elte.hu> <1092347654.11134.10.camel@mindpipe> <1092355488.1304.52.camel@mindpipe> <1092356877.1304.58.camel@mindpipe> <20040813025546.1372fbc6@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813025546.1372fbc6@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> i think that the mlockall and client/jackd startup xruns often do not
> seem to correspond to a critical timing report.. Try the following:
> turn off xrun_debug but leave the preempt-timing stuff on. On my
> system, the mlockall_test provokes an xrun in jackd's output but i do
> not get a preempt-timing report (thresh = 500). 
> 
> OTOH when the xrun_debug is on, the xrun_debug report actually seems
> to trigger the preempt-timing report.

this later phenomenon is expected and unrelated: printk-ing to the
console (as the ALSA xrun kernel message does) is quite expensive,
especially with a full stack dump included. So this fact alone doesnt
tell us much about why the xrun itself happened.

if there is no preempt-timing report when the ALSA xrun debugging is
disabled it strongly suggests that whatever causes the xrun, it's not
due to the length of a non-preemptible critical section, but some other
phenomenon (either in userspace or in kernelspace) that causes an xrun.

irqs being left disabled by accident is one such possibility - the
preempt-timing patch does not (yet) track irqs-off sections.

> I think many of the jackd xruns are really jacks business. But maybe i
> misinterpret the symptom.

either jack's or the kernel's - but it's less likely to be the classical
non-preemptible sections we were focused on so far. (it could still be a
bug in the preempt-timing patch producing a false negative - but the
likelyhood is low i'd say.)

	Ingo
