Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270655AbUJUNwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270655AbUJUNwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUJUNtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:49:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34256 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268733AbUJUNrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:47:22 -0400
Date: Thu, 21 Oct 2004 15:41:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021134156.GA30791@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <21840.195.245.190.94.1098363807.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21840.195.245.190.94.1098363807.squirrel@195.245.190.94>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> The fact is jackd -R (realtime mode; SCHED_FIFO) hosing the system,
> and thats exposed as soon as some jack audio client application enters
> into the chain.
> 
> Running jackd non-realtime (SCHED_OTHER) does not expose this problem,
> so I think it's a scheduling related one.

i tried to pole jackd a little bit (just using things like
jack_freewheel and jack_impulse_grabber - i dont even know what they 
do), and got jackd into some sort of userspace loop:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2558 root      16   0 27900 1852 2152 S 97.8  0.8   2:36.38 jackd

attaching gdb to it shows:

 Loaded symbols for /usr/local/lib/jack/jack_oss.so
 0xffffe410 in ?? ()
 (gdb) bt
 #0  0xffffe410 in ?? ()
 #1  0xbffff7f8 in ?? ()
 #2  0x00000a67 in ?? ()
 #3  0x00000000 in ?? ()
 #4  0x4db8adf8 in pthread_join () from /lib/tls/libpthread.so.0
 #5  0xb77d6e66 in oss_driver_stop (driver=0x8055938) at  oss_driver.c:696
 #6  0x0804ba03 in jack_engine_delete (engine=0x805c308) at  engine.c:2466
 #7  0x0804ade7 in main (argc=3, argv=0xbffffb44) at jackd.c:207
 (gdb)

it's looping somewhere in the pthread code, and it does no system-calls
at all and thus no scheduling as well.

i dont know much about jackit, and it could easily be that something in
this kernel broke its interaction with pthread, but it seems to me that
this loop is in userspace and is only 'fatal' if the looping thread runs
at SCHED_FIFO priority. Could someone with more jackit experience try to
figure out what's going on here?

	Ingo
