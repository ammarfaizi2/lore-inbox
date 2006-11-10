Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932846AbWKJLtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846AbWKJLtt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbWKJLtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:49:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38853 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932846AbWKJLts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:49:48 -0500
Date: Fri, 10 Nov 2006 12:48:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-ID: <20061110114806.GA6780@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.569684000@cruncher.tec.linutronix.de> <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de> <1163146206.8335.183.camel@localhost.localdomain> <20061110005020.4538e095.akpm@osdl.org> <20061110085728.GA14620@elte.hu> <20061110111231.GB3291@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110111231.GB3291@elf.ucw.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > > If so, could that function use the PIT/pmtimer/etc for working out 
> > > if the TSC is bust, rather than directly using jiffies?
> > 
> > there's no realiable way to figure out the TSC is bust: some CPUs 
> > have a slight 'skew' between cores for example. On some systems the 
> > TSC might skew between sockets. A CPU might break its TSC only once 
> > some
> 
> But we could still do a whitelist?

we could, but it would have to be almost empty right now :-) Reason: 
even on systems that have (hardware-initialized) 'perfect' TSCs and 
which do not support any frequency scaling or power-saving mode, our 
current TSC initialization on SMP systems introduces a small (1-2 usecs) 
skew.

but even that limited set of systems is now mostly obsolete: no 
multi-core CPU based system i'm aware of would qualify. I have written 
user-space testcode for TSC and gettimeofday warps, see:

   http://redhat.com/~mingo/time-warp-test/time-warp-test.c

no SMP system i have passes at the moment, running 2.6.17/18:

 --------------------------------------
 jupiter:~> ./time-warp-test
 4 CPUs, running 4 parallel test-tasks.
 checking for time-warps via:
 - read time stamp counter (RDTSC) instruction (cycle resolution)
 - gettimeofday (TOD) syscall (usec resolution)

 [...]
 new TSC-warp maximum:     -6392 cycles, 0000294e1f3b6100 -> 0000294e1f3b4808
 | # of TSC-warps:183606 |

 --------------------------------------
 venus:~> ./time-warp-test
 4 CPUs, running 4 parallel test-tasks.
 [...]
 new TSC-warp maximum:     -1328 cycles, 00001d9549c6c738 -> 00001d9549c6c208
 | # of TSC-warps:332510 |

 --------------------------------------
 neptune:~> ./time-warp-test
 2 CPUs, running 2 parallel test-tasks.
 [...]
 new TSC-warp maximum:      -332 cycles, 0000005e00b1b89e -> 0000005e00b1b752
 | # of TSC-warps:340 |

 [and i'm lazy to turn on the 8-way now, but that has TSC warps too.]

so i'd love to see non-warping time, but after 10 years of trying i'm 
not holding my breath.

	Ingo
