Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUKVJqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUKVJqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUKVJqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:46:30 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:62734 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262006AbUKVJqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:46:24 -0500
Date: Mon, 22 Nov 2004 01:44:01 -0800
To: Christian Meder <chris@onestepahead.de>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041122094401.GA7271@nietzsche.lynx.com>
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <49222.195.245.190.94.1100789179.squirrel@195.245.190.94> <20041118210517.GA8703@elte.hu> <1100818448.3476.17.camel@localhost> <20041119095451.GC27642@elte.hu> <1101115860.4182.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101115860.4182.7.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:31:00AM +0100, Christian Meder wrote:
> Hi Ingo,
> 
> after two evenings of experimenting this is the current status
> (everything based on 0.7.29-0, will try 0.7.30-x during the day):
> 
> * the lockup can't be triggered from the console or using a remote
> session and I really tried to torture the box ;-)
> * the real trigger is mouse activity in X
> * the other important factor is running the jvm in profiling mode,
> running without jvm or with the jvm in non-profiling mode leaves the box
> stable
> * I couldn't yet figure out the pattern of java program which is
> triggering. Not every java program is triggering but at least I found
> several public available ones. I wrote some small test programs doing
> simple multithreading but they didn't trigger.
> 
> So the simplest setup I found til now is the following: 
> 
> chris@blue:~$ java -version
> java version "1.4.1"
> Java(TM) 2 Runtime Environment, Standard Edition (build Blackdown-1.4.1-01)
> Java HotSpot(TM) Client VM (build Blackdown-1.4.1-01, mixed mode)
> chris@blue:~$ JAVA_OPTIONS=-Xrunhprof:cpu=samples,file=crap.log,depth=3 jython 
> Jython 2.1 on java1.4.1 (JIT: null)
> Type "copyright", "credits" or "license" for more information.
> >>>
> 
> Now moving the mouse around in X will make the box lockup in less than
> 10 seconds.

HotSpot is pretty heavy on VM faulting as well as signal handling, SIGUSR1,
during per thread GC safepointing operations to get the current thread
ucontext for GC traversal roots. Debugging the HotSpot VM is nearly impossible
without heavy unit testing and even that isn't going to push through that
almost pure voodoo code easily. I'm a former HotSpot tweeker for the BSDs so
I know a thing or two about that particular VM.

Try a small Java app to see if this triggers the same lock ups. Are you 
pushing it using Swing ?

I'd try pushing an incremental load on it, maybe some rapid object creation
and destruction with increasing number of threads.

Also, CC the Sun/Blackdown folks about this. It could very well be some
kind of NPTL glue problem triggering.

bill

