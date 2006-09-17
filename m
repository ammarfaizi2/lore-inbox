Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWIQUVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWIQUVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 16:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWIQUVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 16:21:55 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:24574 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932394AbWIQUVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 16:21:54 -0400
Subject: Re: tracepoint maintainance models
From: Nicholas Miell <nmiell@comcast.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <20060917143623.GB15534@elte.hu>
References: <450D182B.9060300@opersys.com>
	 <20060917112128.GA3170@localhost.usen.ad.jp>
	 <20060917143623.GB15534@elte.hu>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 13:19:50 -0700
Message-Id: <1158524390.2471.49.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 16:36 +0200, Ingo Molnar wrote:
> * Paul Mundt <lethal@linux-sh.org> wrote:
> 
> > What exactly are you trying to prove with this? Yes, people aren't 
> > opposed to a lightweight marker facility. Ingo made some suggestions 
> > regarding that, and others (Andrew, Martin, etc.) have pointed out 
> > that this would also be beneficial for certain use cases. I don't see 
> > anyone violently opposed to lightweight markers, I see people 
> > violently opposed to the ltt-centric breed of static instrumentation 
> > (and yes, I'm one of them), let's not confuse the two.
> 
> yes. The way i see this whole issue (and what i've been trying argue for 
> a long time) is that with dynamic tracers we have a _continuum_ of 
> _tracepoint maintainance models_ that maintainers can choose from, each 
> of which model gives the same "end-user experience":

To inject some facts into this argument, I took a look at dtrace on a
Solaris LiveCD (Belenix 0.4.4, actually, and wow are their userspace
apps are as terrible as I've been lead to be believe.)

On my system, Solaris has 49 "real" static probes (with actual
documentation[1]). They are as follows:

io:::done                           proc:::lwp-start
io:::start                          proc:::signal-clear
io:::wait-done                      proc:::signal-discard
io:::wait-start                     proc:::signal-handle
lockstat:::adaptive-acquire         proc:::signal-send
lockstat:::adaptive-block           proc:::start
lockstat:::adaptive-release         sched:::change-pri
lockstat:::adaptive-spin            sched:::dequeue
lockstat:::rw-acquire               sched:::enqueue
lockstat:::rw-block                 sched:::off-cpu
lockstat:::rw-downgrade             sched:::on-cpu
lockstat:::rw-release               sched:::preempt
lockstat:::rw-upgrade               sched:::remain-cpu
lockstat:::spin-acquire             sched:::schedctl-nopreempt
lockstat:::spin-release             sched:::schedctl-preempt
lockstat:::spin-spin                sched:::schedctl-yield
lockstat:::thread-spin              sched:::sleep
proc:::create                       sched:::surrender
proc:::exec                         sched:::tick
proc:::exec-failure                 sched:::wakeup
proc:::exec-success                 sdt:::callout-end
proc:::exit                         sdt:::callout-start
proc:::fault                        sdt:::interrupt-complete
proc:::lwp-create                   sdt:::interrupt-start
proc:::lwp-exit

You'll note that these probes are all generic high-level concepts, some
of which occur at multiple places within the kernel (You can just trust
me on this, the dtrace -l output lists multiple function sites for the
provider:::name pair).

In addition to those 49 probes, there are 330 more documented probes
which fire whenever a statistical counter changes (most of them are SNMP
MIB counters, but there are also probes related to VM behavior,
filesystem activity, etc.). These are all hidden inside the pre-existing
counter update macros[2] and didn't increase the kernel maintenance
burden because the counters already had to be maintained (which is why I
don't consider them "real").

There are also 134 more undocumented driver-specific probes. Every probe
comes labeled with a stability indicator that looks like something like
this:

 8271        sdt               zfs         arc_evict_ghost arc-delete

        Probe Description Attributes
                Identifier Names: Private
                Data Semantics:   Private
                Dependency Class: Unknown

        Argument Attributes
                Identifier Names: Private
                Data Semantics:   Private
                Dependency Class: ISA

        Argument Types
                None

Which basically says that this undocumented probe is for private Sun use
and if you touch it and something breaks, you were warned and it's your
own damn fault[3]. (Obviously, the stable probes have different
labeling.) Also, given a D script, the dtrace command can spit out a
summary of that script's stability based on the probes it uses, which is
handy for judging the future compatibility of a script.

So, Solaris has a grand total of 513 statically defined probe points,
most of them hidden inside macros that were already there.

Then why is dtrace useful?

Because there's 48288 dynamically defined probes on function entry and
exit and another 454 dynamic syscall entry and exit probes.

This is the important part: In a dynamic tracing system, the number of
static probes necessary for the tracing system to be useful is
drastically, dramatically, absurdly lower than in a purely static
tracing system. Hell, you don't even need the static probes for it to be
useful, they're just a convenience for events which happen in multiple
places or a high-level name for a low-level implementation detail.

In order for the static tracing system to be as useful as the dynamic
system, all of those dynamically generated probe points would have to be
manually added to the kernel. The maintenance burden of this number of
probes is stupidly high. In reality, no static system would ever reach
that level of coverage.




[1] http://docs.sun.com/app/docs/doc/817-6223
[2] http://blogs.sun.com/tpenta/entry/dtrace_using_placing_sdt_probes
[3] http://docs.sun.com/app/docs/doc/817-6223/6mlkidlnp?a=view

-- 
Nicholas Miell <nmiell@comcast.net>

