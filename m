Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbTAQJ6k>; Fri, 17 Jan 2003 04:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTAQJ6k>; Fri, 17 Jan 2003 04:58:40 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:43280
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267469AbTAQJ6j>; Fri, 17 Jan 2003 04:58:39 -0500
Date: Fri, 17 Jan 2003 05:08:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <rml@tech9.net>, <mingo@elte.hu>
Subject: Re: [PATCH][2.5] per-CPU task runqueues
In-Reply-To: <20030117014711.6ba112e9.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301170451230.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@holomorphy.com> wrote:
> >
> > This patch simply switches over to per-CPU runqueues as defined by the new 
> > per cpu api.
> > ...
> > +static DEFINE_PER_CPU(struct runqueue, runqueues);
> 
> These must be initialised to something.  gcc-2.91/92 bug.  There is a
> build-time check for this, but it only detects the mistake if you're using a
> compiler which has the bug.

Thanks i can work around that.

> Your patch works here, but I was never able to get this working when the
> per-cpu areas were allocated as the CPU's come online, which is something we
> kinda should work towards.  This patch would need to be reverted if we try to
> do that again.  Which is a shame, because appreciable amounts of memory would
> be saved if nr_cpus < NR_CPUS.   scheduler startup is fragile..

I think i'll have a stab at that.

> I don't think it buys us a lot, really.  These structures are so humongous
> that we don't get much per-cpuness in accessing them.

Point.

Index: linux-2.5.59/kernel/sched.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/kernel/sched.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 sched.c
--- linux-2.5.59/kernel/sched.c	17 Jan 2003 02:46:29 -0000	1.1.1.1
+++ linux-2.5.59/kernel/sched.c	17 Jan 2003 10:03:31 -0000
@@ -160,9 +160,9 @@
 	atomic_t nr_iowait;
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU(struct runqueue, runqueues) = {{ 0 }};
 
-#define cpu_rq(cpu)		(runqueues + (cpu))
+#define cpu_rq(cpu)		(&per_cpu(runqueues, cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)

-- 
function.linuxpower.ca


