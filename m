Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUHLAwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUHLAwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268365AbUHLA1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:27:41 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59300 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268363AbUHKXzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:55:08 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
In-Reply-To: <20040811124342.GA17017@elte.hu>
References: <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
	 <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu>
	 <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu>
	 <20040811141649.447f112f@mango.fruits.de>  <20040811124342.GA17017@elte.hu>
Content-Type: text/plain
Message-Id: <1092268536.1090.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 19:55:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 08:43, Ingo Molnar wrote:
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > > i'm currently running a loop of mlockall-test 100MB on a 466 MHz
> > > Celeron, and not a single blip on the radar with a 1000 usecs
> > > threshold, after 1 hour of runtime ...
> > 
> > I suppose you're not using jackd. As i have noticed that these
> > critical sections only get reported when jackd is running. It seems
> > jackd is producing a certain kind of load which exposes them..
> 
> so you can only trigger the latencies via mlockall-test if jackd is also 
> running? Or do the latencies only trigger in jackd (and related 
> programs)?
> 
> if the later, then i'm wondering whether any of the audio code turns off
> caching for specific pages or does DMA to user pages, or mmap()s device
> (PCI) memory?
> 

I believe that jackd may do all of these.  I am adding Paul Davis to the
cc: list as he would know better.

Whatever is going on, it only happens at jackd startup.  Jackd does not
report an xrun because the developers added code not to report an xrun
within the first 64 frames, so this message would not confuse users.

There is definitely some subtle bug in the preempt-timing patch, because
I am getting reports of long non-preemptible sections, which do not
correspond to an xrun in jackd - if these were real then even a 400usec
non-preemptible section would cause an xrun.  I do not seem to get many
xruns during normal jackd operation.

If, during initialization, jackd called some function that could sleep
*after* starting the PCM, for example if it tried to allocate memory in
the same thread as the audio, this would cause an xrun, because the
soundcard interrupt would occur, but jackd would not be woken up because
it is sleeping on some other resource, correct?  Then, when jackd
eventually woke up, it would see that a lot of time had passed, and
report an xrun.  This would look the same as if jackd had been ready to
run and had not been scheduled in time.

Lee

