Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbUKBXiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUKBXiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUKBX22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:28:28 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:58037 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262883AbUKBXYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:24:18 -0500
Message-ID: <32932.192.168.1.8.1099437703.squirrel@192.168.1.8>
Date: Tue, 2 Nov 2004 23:21:43 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.9
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: mark_h_johnson@raytheon.com, "Thomas Gleixner" <tglx@linutronix.de>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Paul Davis" <paul@linuxaudiosystems.com>,
       "LKML" <linux-kernel@vger.kernel.org>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com>
       <20041102191858.GB1216@elte.hu> <20041102192709.GA1674@elte.hu>
In-Reply-To: <20041102192709.GA1674@elte.hu>
X-OriginalArrivalTime: 02 Nov 2004 23:24:14.0883 (UTC) FILETIME=[112C5F30:01C4C133]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> ah ... found it - a fair portion of spinlocks and rwlocks had deadlock
> detection turned off in -V0.6.6 - amongst them ptype_lock. I've uploaded
> -V0.6.9 that fixes this.
>

OK. Already tested RT-V0.6.9 and things are really good, so far. Got it
under the jackd-R + 9*fluidsynth workload test, and the comparison to
2.6.9 (vanilla) is getting kind of humiliating :)

                                   2.6.9   RT-V0.6.9
                                 --------- ---------
 XRUN Rate   . . . . . . . . . :    415         0    /hour
 Delay Rate (>spare time)  . . :    493         0    /hour
 Delay Rate (>1000 usecs)  . . :    913         1    /hour
 Delay Maximum . . . . . . . . :   6877       864    usecs
 Cycle Maximum . . . . . . . . :   1440      1552    usecs
 Average DSP Load. . . . . . . :     38.9      40.5  %
 Average Interrupt Rate  . . . :   1337      1338    /sec
 Average Context-Switch Rate . :   7488      9048    /sec

As before, these stats were taken by running jackd -v -dalsa -dhw:0
-r44100 -p128 -n2 -S -P, loaded with 9 (nine) fluidsynth instances, on a
P4@2.533Ghz laptop, against the onboard sound device (snd-ali5451).
The results were averaged for 12 consecutive runs of 5 minutes each.

On the RT kernel, the IRQ 5 handler thread, that serves the ali5451 sound
device, has been chrt'ed to SCHED_FIFO and to priority=60 (chrt -p -f 60
`pidof "IRQ 5"`). This time thought, I haven't touched the ksoftirqd/0
scheduling policy nor priority.

I am also rehearsing these same tests on my P4/SMT desktop. I'll post
those a bit later today.

As a personal comment, I've never, never seen so good figures in any other
kernel I've came across in the last couple of years. I hope this can only
go to the better ;)

See ya.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

