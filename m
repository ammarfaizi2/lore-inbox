Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbULBNi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbULBNi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULBNi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:38:27 -0500
Received: from pop.gmx.net ([213.165.64.20]:55433 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261613AbULBNiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:38:22 -0500
X-Authenticated: #4399952
Date: Thu, 2 Dec 2004 14:40:37 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202144037.5c9da188@mango.fruits.de>
In-Reply-To: <20041202131002.GA30503@elte.hu>
References: <33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
	<20041201212925.GA23410@elte.hu>
	<20041201213023.GA23470@elte.hu>
	<32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
	<20041201220916.GA24992@elte.hu>
	<20041201234355.0dac74cf@mango.fruits.de>
	<20041202084040.GC7585@elte.hu>
	<20041202132218.02ea2c48@mango.fruits.de>
	<20041202122931.GA25357@elte.hu>
	<20041202140612.4c07bca8@mango.fruits.de>
	<20041202131002.GA30503@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 14:10:02 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Hmm, i wonder if there's a way to detect non RT behaviour in jackd
> > clients. I mean AFAIK the only thing allowed for the process callback
> > of on is the FIFO it waits on to be woken, right? Every other sleeping
> > is to be considered a bug. 
> 
> there's such a feature in -RT kernels. If a user process calls:
> 
> 	gettimeofday(1,1);
> 
> then the kernel turns 'atomic mode' on. To turn it off, call:
> 
> 	gettimeofday(1,0);
> 
> while in atomic-mode, any non-atomic activity (scheduling) will produce
> a kernel message and a SIGUSR2 sent to the offending process (once,
> atomic mode has to be re-enabled again for the next message). Preemption
> by a higher-prio task does not trigger a message/signal.
> 
> If you run the client under gdb you should be able to catch the SIGUSR2
> signal and then you can see the offending code's backtrace via 'bt'.

Ok, so if i want to find out whether a client violates the RT
constraints for its process callback i would have to add a call to
gettimeofday(1,1) at the start of the process callback and
gettimeofday(1,0) at the end.

Everything which causes a reschedule inbetween will then cause SIGUSR2
to be sent to the client for which i could either add a signal handler
in the client or just use gdb to get notified of it. 

Cool!

Flo
