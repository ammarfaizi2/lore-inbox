Return-Path: <linux-kernel-owner+w=401wt.eu-S932531AbWLZMmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWLZMmt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 07:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWLZMmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 07:42:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41289 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531AbWLZMms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 07:42:48 -0500
Date: Tue, 26 Dec 2006 13:40:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Florin Iucha <florin@iucha.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
Message-ID: <20061226124019.GA3701@elte.hu>
References: <20061225224047.GB6087@iucha.net> <20061225225616.GA22307@iucha.net> <20061226022538.13ea8b3f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061226022538.13ea8b3f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > [ 2844.871895] BUG: scheduling while atomic: cp/0x20000000/2965

> This is the second report we've had where bit 29 of ->preempt_count is 
> getting set.  I don't think there's any legitimate way in which that 
> bit can get set.  (Ingo?)

It's not legitimate (the highest legitimate bit is PREEMPT_ACTIVE, bit 
28). Nor can i think of any bug scenario barring outright memory 
corruption (either hardware or kernel induced) that could cause this. 
It's quite hard to trigger bit 29 there via any of the scheduling 
mechanisms: either the preempt count would have to underflow massively 
/and/ avoid detection during that undflow (sheer impossible) or the 
HARDIRQ_COUNT would have to overflow to more than 4096 (again near 
impossible to trigger), and simultaneously the softirq and preempt count 
would have to overflow by 256 /at once/, or underflow by 1 at once. The 
likelyhood of that makes the likelyhood of GPL-ed Windows a sure bet in 
comparison.

So my guess would still be memory corruption of some sort, or some 
really weird compiler bug. We just recently mandated REGPARM on i386 for 
example, it would be interesting to know whether an older (say 2.6.18 or 
19) config had CONFIG_REGPARM enabled or not? Regparm can also tax the 
hardware (the CPU in particular) a bit more.

	Ingo
