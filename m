Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932756AbVITHRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbVITHRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbVITHRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:17:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:8320 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932756AbVITHRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:17:14 -0400
Date: Tue, 20 Sep 2005 09:10:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
Message-ID: <20050920071010.GA14285@elte.hu>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com> <1127168232.24044.265.camel@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509191521400.27238@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Lameter <clameter@engr.sgi.com> wrote:

> > We should rather ask glibc people why gettimeofday() / clock_getttime()
> > is called inside the library code all over the place for non obvious
> > reasons.
> 
> You can ask lots of application vendors the same question because its 
> all over lots of user space code. The fact is that gettimeofday() / 
> clock_gettime() efficiency is very critical to the performance of many 
> applications on Linux. That is why the addtion of one add instruction 
> may better be carefully considered. Many platforms can execute 
> gettimeofday without having to enter the kernel.

i think this line of argument got into a bit of a wrong direction: do we 
seriously consider a single 'add' as an argument to _not_ go to a much 
cleaner implementation? The answer is very simple: we dont. In the core 
kernel we frequently skip other, much worthier micro-optimizations in 
favor of cleanliness. The time subsystem has been limping along for 
many, many years, and to bring new life into it we need John's and 
Thomas's stuff. Simple as that. I'd give up much more than just a single 
cycle add overhead for that ...

it's probably not even worth keeping the timespec 'cached' in parallel 
to nsec_t - but in any case, speedups like that should be considered 
totally separately - cleanliness, the main problem of the whole time 
subsystem, comes first.  _Once_ cleanliness has been achieved, we can 
consider micro-optimizations anew, and judge them by how much they bring 
and how they affect cleanliness.

[ Even when not considering cleanliness at all, the best opportunities 
  for optimizations are elsewhere. E.g. we could speed up 
  sys_gettimeofday() much more by skipping a number of hardware bug 
  workarounds that affect the quality of e.g. the TSC, and other timer 
  hardware details that are simpler on modern hardware. So if someone is 
  after sys_gettimeofday() performance, dont look for a single add (or 
  even a single division), go for the bigger picture first.  E.g.  the 
  vsyscall people went for the bigger picture on modern platforms and 
  sped sys_time up by doing it in userspace most of the time and thus 
  skipping hundreds of cycles of syscall entry overhead - not a cycle 
  like an add is. ]

	Ingo
