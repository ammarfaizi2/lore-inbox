Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVJYPpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVJYPpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVJYPpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:45:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:11395 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932189AbVJYPpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:45:10 -0400
Date: Tue, 25 Oct 2005 17:44:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051025154440.GA12149@elte.hu>
References: <20051019111943.GA31410@elte.hu> <1129835571.14374.11.camel@cmn3.stanford.edu> <20051020191620.GA21367@elte.hu> <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu> <20051022035851.GC12751@elte.hu> <1130182121.4983.7.camel@cmn3.stanford.edu> <1130182717.4637.2.camel@cmn3.stanford.edu> <1130183199.27168.296.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130183199.27168.296.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John

i found one source of timekeeping bugs on SMP boxes, it's the 
non-monotonicity of the TSC:

... time warped from 1270809453 to 1270808096.
... MTSC warped from 0000000a731a8c3c [0] to 0000000a731a899c [2].
... MTSC warped from 0000000a7c93baec [0] to 0000000a7c93b7a8 [3].
... MTSC warped from 0000000a881d6afc [0] to 0000000a881d67d0 [2].
... MTSC warped from 0000000a924217a0 [0] to 0000000a924216ac [3].
... MTSC warped from 0000000a9c592788 [0] to 0000000a9c59232c [2].
... MTSC warped from 0000000aa7aa95c8 [0] to 0000000aa7aa9338 [3].
... MTSC warped from 0000000b33206d60 [0] to 0000000b33206a48 [3].
... time warped from 26699635824 to 26699633144.
... MTSC warped from 00000013f379cb88 [0] to 00000013f379c7e0 [3].
... MTSC warped from 0000001413df8660 [0] to 0000001413df8200 [3].
... MTSC warped from 00000014194f5360 [1] to 00000014194f51b0 [2].
... time warped from 60775269225 to 60775266727.

the number in square brackets is the CPU#. I.e. CPUs on this 4-CPU box 
have small TSC differences, which ends up leaking into the generic TOD 
code, causing real time warps, which causes ktimer weirdnesses (timers 
failed to expire, etc.).

(the above output tracks TSC results globally, under a spinlock. It also 
detects time-warps that propagate into the monotonic clock output.)

unfortunately, there's no easy solution for this. We could make 
cycle_last per-CPU, but that again brings up the question of how to set 
up the per-CPU 'TSC offset' values - those would need similar technique 
that the current clear-all-TSCs-on-all-CPUs code does - which as we can 
see failed ...

	Ingo
