Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbULAQNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbULAQNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULAQNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:13:20 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:24800 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261291AbULAQNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:13:15 -0500
Date: Wed, 1 Dec 2004 17:08:26 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2 
In-Reply-To: <200412011456.iB1EubBI004051@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10412011658320.8736-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Dec 2004, Paul Davis wrote:

> [...]
> >
> >> futexes are nearly lock-free. [and even those locks are short-held so
> >> combined with priority-inheritance they should be lockfree in
> >> essence.] Would futexes suit your purposes?
> >
> >to which suggestion i got no reply yet :-)
> 
> i am still trying to find the time to investigate futexes. they seem
> close to the desired object, but have a slightly more general semantic
> than i can fit into my head right now;)
>

I looked into them just to see if they could be used for user-space
priority inheritance. I saw that it takes (read-)lock on mmap_sem.
Isn't that potentially held for a long time? I don't know how the memory
subsystem works at all but my guess is that any changing of the process's
memory is done with mmpa_sem locked. The only way to prevent that is 1)
mlockall() and 2) stop increasing your heap.

I.e. you can't have one thread running real-time using a futex while
another runs non-real-time allocating memory in the same process.

Am I correct?

Another problem is the hashing of the futex. That inherently has a
non-deterministic timing behaviour. The more applications use futex'es
the slower this hashing gets :-( The slowdown might in practise be very
low because looking up in the global hash table can't take very many us!

Can't it just use a file-descriptor in the system call to look up the
futex instead of the hashing? That is RT-O(1), right? But, ofcourse, then
it is hard having a futex in shared mem.

 
> --p

Esben

