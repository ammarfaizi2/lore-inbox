Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUHITW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUHITW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266920AbUHITWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:22:20 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:47764 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S266903AbUHITUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:20:00 -0400
Subject: 2.4.x vs 2.6.x: denormal handling and audio performance
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jackit-devel <jackit-devel@lists.sourceforge.net>,
       Lee Revell <rlrevell@joe-job.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092079195.16794.257.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Aug 2004 12:19:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I've been trying to track weird behavior I'm experiencing when
trying to use 2.6.x for "pro audio" applications and I think I have
something to report (and some questions). 

First, the environment. I'm running the Jack low latency server on top
of two different software installs on the same hardware, one is FC1 +
2.4.26 + low latency and preemption patches, the other is FC2 + 2.6.7
rc2-mm2 + voluntary preemption O3. They are different hard disks swapped
into the same P4 laptop. Both are running the same source code versions
of all the audio programs that I use to test (but _not_ the same
binaries, each one is built in the environment it runs on). 

One example app that illustrates the problem well is Freqtweak, a
frequency domain sound processing application that includes controlled
feedback of the frequency domain bins. If I connect a source to it and
feed samples and then disconnect it (ie: feed silence), and let the
processed samples inside Freqtweak slowly decay to zero, at some point
the processing load of the app goes up _drastically_. It eventually
gobbles up all the cpu if left alone. If I feed samples to it again, the
load immediately goes back to normal. This only happens on the 2.6.x
based environment. It does not happen on the 2.4.x case. 

My guess is that the processing of denormals is different in my two
environments, in the 2.4.x case they are converted to zeros, in the
2.6.x case they stay as denormals. To check the load denormals create
Steve Harris wrote a small app and tested on several processors:

On Mon, 2004-08-09 at 03:03, Steve Harris wrote: 
> Source code + binary can be found at:
> http://www.ecs.soton.ac.uk/~swh/denormal-finder/
> 
> I tried on a few different machines:
> 	PIII running 2.6 (glibc 2.3.3)
> 	Pentium M (PIII derived) running 2.6 (glibc 2.3.3)
> 	Athlon XP running 2.4 (glibc 2.3.2)
> 	Xeon P4 running 2.4 (glibc 2.3.2)
> 	Opteron running 2.6 (glibc 2.3.2)
> 
> In all cases the denormal values are the same, apparently regardless of
> whether SSE or 387 instructions are used:
> 	lower bound on normals   = 1.17549e-38
> 	upper bound on denormals = 1.17549e-38
> 	lower bound on denormals = 7.00649e-46
> 	upper bound on zeros     = 7.00649e-46
> 
> tried with -march=i686 -msse and without, so I guess gcc doesn't disbale
> the denormal handling by default with SSE.
> 
> what does vary is the time taken to process denormals relative to normals:
> 	PIII      38x
> 	AthlonXP  63x
> 	Opteron   71x (32bit binary)
> 	PM        78x (SSE / i387)
> 	PM        95x (SSE2)
> 	Opteron  104x (64bit binary)
> 	Xeon     191x
> 
> So, this doesnt really shed any light on Fernando's problem, but its still
> interesting.

I added these two cases this morning:
On Mon, 2004-08-09 at 10:49, Fernando Pablo Lopez-Lezcano wrote: 
> Athlon64 3000+, 2.6 (glibc 2.3.3, FC2): 27.5x
> 
> P4 Mobile, 2.6 (glibc 2.3.3, FC2):      191x
> P4 Mobile, 2.4 (glibc 2.3.2, FC1):      315x
> 
> So, there is a difference in the runtime configuration of the FPU. Both
> P4 Mobile examples are exactly the same hardware :-)

And here is what I think is happening:

> But the problem, I think, is not the time it takes to process denormals
> but whether those denormals get converted to zeros by the FPU or not. 
> 
> Apparently there is a "denormals-are-zero" flag in the MXCSR register
> (introduced in the later P4 and Xeon processors)[*]. My guess is that is
> being initialized differently. In 2.4.x/FC1 denormals get zeroed and
> don't generate extra cpu load, in 2.6.x/FC2 denormals stay denormals and
> are recirculated in algorithms that have feedback (and that's why the
> load stays high in my tests). 
> 
> As far as I can tell this is being set in arch/i386/kernel/i387.c and
> the code for 2.4 and 2.6 _is_ different... I also don't know if
> something else is changing that setting later. 
> 
> A good test would be to be able to set and reset this setting
> globally...

So, is there a way to do this?  (toggle denormals-are-zero)

Is this setting indeed different on 2.4 and 2.6? (denormals-are-zero).

If the default setting is the same on both 2.4 and 2.6, where would this
be changed if the kernel is not responsible for the change in behavior
I observe?

-- Fernando

> [*] See this:
> http://gcc.gnu.org/ml/gcc/2001-07/msg02162.html
> http://lkml.org/lkml/2003/5/9/144


