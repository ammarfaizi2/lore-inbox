Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267591AbUJOLnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267591AbUJOLnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUJOLnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:43:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22934 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267591AbUJOLnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:43:14 -0400
Date: Fri, 15 Oct 2004 13:44:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041015114405.GA22823@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041015132236.6b8bd16e@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015132236.6b8bd16e@mango.fruits.de>
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

> > i have released the -U1 PREEMPT_REALTIME patch:
> >  
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1
> 
> Ok, 
> 
> with the help of Paul Davis i think i have found what's causing  the jackd
> FP exception. It seems to be a bug in the kernel when PREEMPT_REALTIME is
> enabled:
> 
> ~$ cat /proc/cpuinfo|grep cpu
> cpu family      : 6
> cpu MHz         : 0.001
> cpuid level     : 1
> 
> Mhz == 0.001? Hrmm. No wonder jackd was freaking out in its timing code..
> The real cpu speed is 1.2ghz.
> 
> flo
> 
> P.S.: Will retry with U3, to see if this persists.

ah ... good eyes. Seems to be working fine here:

 saturn:~> cat /proc/cpuinfo | grep -i mhz
 cpu MHz         : 2051.126
 saturn:~> uname -a
 Linux saturn 2.6.9-rc4-mm1-VP-U4 #288 SMP Fri Oct 15 12:31:38 CEST 2004 

but it could easily be happening on some CPUs only. Let me know if that
problem persists. Fortunately i think it will be at most a detection
problem, not some FPU breakage that i initially suspected.

it could be the following thing: if you got an smp_processor_id()
warning _in the CPU detection code_ in earlier PREEMPT_REALTIME kernels
then the kernel could easily see that the CPU is extremely slow, because
it didnt manage to do much work (due to the long printout...). So i'd
say if this happens again it's most likely a debug printout in the
'calibrating delay loop' phase.

	Ingo
