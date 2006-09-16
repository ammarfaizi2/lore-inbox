Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWIPRYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWIPRYX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWIPRYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:24:23 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:25055 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964849AbWIPRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:24:22 -0400
Date: Sat, 16 Sep 2006 13:24:19 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jes Sorensen <jes@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060916172419.GA15427@Krystal>
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <450BCAF1.2030205@sgi.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:11:53 up 24 days, 14:20,  2 users,  load average: 0.32, 0.18, 0.37
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jes Sorensen (jes@sgi.com) wrote:
> Mathieu Desnoyers wrote:
> >Please Ingo, stop repeating false argument without taking in account 
> >people's
> >corrections :
> >
> >* Ingo Molnar (mingo@elte.hu) wrote:
> >>sorry, but i disagree. There _is_ a solution that is superior in every 
> >>aspect: kprobes + SystemTap. (or any other equivalent dynamic tracer)
> >>
> >I am sorry to have to repeat myself, but this is not true for heavy loads.
> 
> Alan pointed out earlier in the thread that the actual kprobe is noise
> in this context, and I have seen similar issues on real workloads. Yes
> kprobes are probably a little higher overhead in real life, but you have
> to way that up against the rest of the system load.
> 
> If you want to prove people wrong, I suggest you do some real life
> implementation and measure some real workloads with a predefined set of
> tracepoints implemented using kprobes and LTT and show us that the
> benchmark of the user application suffers in a way that can actually be
> measured. Argueing that a syscall takes an extra 50 instructions
> because it's traced using kprobes rather than LTT doesn't mean it
> actually has any real impact.
> 
> "The 'kprobes' are too high overhead that makes them unusable" is one of
> these classic myths that the static tracepoint advocates so far have
> only been backing up with rhetoric. Give us some hard evidence or stop
> repeating this argument please. Just because something is repeated
> constantly doesn't transform it into truth.
> 

Hi,

Here we go. I made a test that we can consider a lower bound for kprobes impact.
Two tests per run.

Simulation of high speed network traffic :

time ping -f localhost

First run : without any tracing activated, LTTng probes compiled in :

39457 packets received in 2.021 seconds : 19523.50 packets/s
142672 packets received in 7.237 seconds : 19714.24 packets/s

Second run : LTTng tracing activated (traces system calls, interrupts and
packet in/out...) :

93051 packets received in 7.395 seconds : 12582.96 packets/s
121585 packets received in 9.703 seconds : 12530.66 packets/s


Third run : same LTTng instrumentation, with a kprobe handler triggered by each
event traced.

56643 packets received in 11.152 seconds : 5079.17 packets/s
50150 packets received in 9.593 seconds : 5227.77 packets/s


The bottom line is :

LTTng impact on the studied phenomenon : 35% slower

LTTng+kprobes impact on the studied phenomenon : 73% slower

Therefore, I conclude that on this type of high event rate workload, kprobes
doubles the tracer impact on the system.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
