Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVL3Hgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVL3Hgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVL3Hgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:36:52 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6614 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751203AbVL3Hgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:36:52 -0500
Date: Fri, 30 Dec 2005 08:36:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: kus Kusche Klaus <kus@keba.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Message-ID: <20051230073639.GA25637@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323307@MAILIT.keba.co.at> <1135927789.12146.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135927789.12146.1.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > However, traces 1, 2, 6 and 7 are completely mysterious to me.
> > Interrupts seem to be blocked for milliseconds, while nothing is going
> > on on the system? Moreover, there are console-related function names
> > in
> > traces 6 and 7, although I've unconfigured the framebuffer console for
> > these runs!
> 
> It seems that either some code path really is forgetting to re-enable 
> interrupts, or there's a bug in the latency tracer.

one question is, what do the kernel addresses visible in the first 
argument of asm_do_IRQ() correspond to:

 trace1:MyThread-153   0D..1 5977us+: asm_do_IRQ (c030c170 1a 0)
 trace1:MyThread-153   0D..1 15191us+: asm_do_IRQ (c030c1bc 1a 0)
 trace2:  <idle>-0     0D..2 8822us+: asm_do_IRQ (c021da24 1a 0)
 trace2:  <idle>-0     0Dn.2 8920us+: asm_do_IRQ (c021da24 b 0)
 trace3:     top-169   0D..1 8802us+: asm_do_IRQ (c024e5fc 1a 0)
 trace4:  insmod-185   0D..1 8794us+: asm_do_IRQ (c030c174 1a 0)
 trace5:      dd-197   0D..1 8812us+: asm_do_IRQ (c02e4938 1a 0)
 trace6: kthread-11    0d..3 2670us+: asm_do_IRQ (c02fe2d0 1a 0)
 trace7:MyThread-95    0D..1  542us+: asm_do_IRQ (c02fe2d0 1a 0)
 trace7:MyThread-95    0D..1 9755us+: asm_do_IRQ (c02fe2d0 1a 0)

i.e. what is c02fe2d0, c021da24, c02e4938, etc.?

but it seems most of the latencies are printk related: one possibility 
is that something is doing a costly printk with preemption disabled.

	Ingo
