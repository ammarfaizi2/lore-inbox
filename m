Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263241AbUJ2LNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbUJ2LNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUJ2LNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:13:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10121 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263241AbUJ2LNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:13:39 -0400
Date: Fri, 29 Oct 2004 13:14:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029111408.GA28259@elte.hu>
References: <20041029090957.GA1460@elte.hu> <200410291101.i9TB1uhp002490@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291101.i9TB1uhp002490@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> this is something i haven't mentioned. when running in RT mode, jackd
> also runs a higher prio RT thread called the watchdog. it wakes every
> 5 seconds to check that the "main" thread is not stalled (i.e. a
> client that is stuck in a loop) and kills everything if it is.
> however, this thread's loop is incredibly simple (it checks and resets
> a single int variable and goes back to sleep) that causing a 700usec
> delay would itself seem to me to be indicative of a problem. do you
> agree?

agreed, the watchdog thread should have no measurable impact - it should
have all of its work done well under 10 usecs on a fast box, and not
above 20 usecs even on a slow box. As long as it doesnt log to a file it
should have no impact. It's also easy to exclude this from the list of
things, Rui could perhaps chrt this particular jackd thread to below the
main jack thread's priority. (it shouldnt break the watchdog
functionality too much, unless the main jackd thread itself goes into a
loop which clearly isnt the problem currently.)

my main suspicion is that either the main jackd thread itself calls the
kernel where the kernel (unexpectedly for jackd) schedules away for
whatever reason, or that the chain of wakeup in the audio path somehow
gets violated (i.e. a kernel problem). There's one quick thing we could
try: could you send me an 'strace -p' log of a couple of interrupt
cycles of jackd handling an ordinary audio stream? There's so many ways
the kernel can schedule away, perhaps i can spot it by looking at the
syscalls called.

in fact, does the jackd high-prio thread (excluding the watchdog) call
any syscalls normally, besides the poll() and then the read()/write() on
the audio device fd? (perhaps it does an ioctl too?)

ahh ... the ioctls. All ioctls in Linux take the 'big kernel lock'. So
if jackd calls an ioctl() in the fastpath then that could easily get
delayed. Also, there are a couple of other syscalls too that touch the
BKL, so an strace of the 'jackd latency path' would be quite useful.

	Ingo
