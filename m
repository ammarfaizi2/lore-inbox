Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTE0BFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTE0BFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:05:46 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16082
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262237AbTE0BEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:04:36 -0400
Date: Tue, 27 May 2003 03:17:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: davem@redhat.com, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527011750.GG3767@dualathlon.random>
References: <60830000.1053575867@[10.10.2.4]> <Pine.LNX.3.96.1030522130544.19863B-100000@gatekeeper.tmr.com> <20030522.154410.104047403.davem@redhat.com> <20030526222406.GU3767@dualathlon.random> <20030526162616.6ceacaba.akpm@digeo.com> <20030526233446.GZ3767@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526233446.GZ3767@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:34:46AM +0200, Andrea Arcangeli wrote:
> On Mon, May 26, 2003 at 04:26:16PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > >  	if (IRQ_ALLOWED(phys_id, allowed_mask) && idle_cpu(phys_id))
> > >  		return cpu;
> > 
> > How hard would it be to make this HT-aware?
> > 
> > 	idle_cpu(phys_id) && idle_cpu_siblings(phys_id)
> > 
> > or whatever.
> 
> yeah! that was the obvious next step. as fast path the additional && is
> sure good. Maybe that's enough after all, and we might search only for
> fully idle cpus, however I wouldn't dislike to search for a fallback
> (partially) logical idle cpu if none physical cpu is (fully) idle.

I'm going to try this (if it compiles ;). the ksoftirqd check is the one
for the NAPI workload brought to attention by Dave. the idea is that
statistically the softirq load will follow the hardirq load. Both wants
to go into an idle cpu. But we don't want to mistake the softirq load
for unrelated cpu load. So we don't want to separate a ksoftirqd load
from the irq load or we could keep bouncing over and over again.

For HT I take the trivial approch you mentioned above that is to switch
only if the physical cpu is completely idle.

--- ./arch/i386/kernel/io_apic.c.~1~	2003-05-27 02:45:34.000000000 +0200
+++ ./arch/i386/kernel/io_apic.c	2003-05-27 03:00:32.000000000 +0200
@@ -217,13 +217,18 @@ extern unsigned long irq_affinity [NR_IR
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1UL << cpu) & (allowed_mask))
 
+#define ksoftirqd_is_running(phys_id) (cpu_curr(phys_id) == ksoftirqd_task(phys_id))
+#define __irq_idle_cpu(phys_id) (idle_cpu(phys_id) || ksoftirqd_is_running(phys_id))
+#define irq_idle_cpu(phys_id) (__irq_idle_cpu(phys_id) &&
+			       (smp_num_siblings <= 1 || __irq_idle_cpu(cpu_sibling_map[phys_id])))
+
 static unsigned long move(unsigned int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
 {
 	unsigned int cpu = curr_cpu;
 	unsigned int phys_id;
 
 	phys_id = cpu_logical_map(cpu);
-	if (IRQ_ALLOWED(phys_id, allowed_mask) && idle_cpu(phys_id))
+	if (IRQ_ALLOWED(phys_id, allowed_mask) && irq_idle_cpu(phys_id))
 		return cpu;
 
 	goto inside;
@@ -243,7 +248,7 @@ inside:
 		}
 
 		phys_id = cpu_logical_map(cpu);
-	} while (!IRQ_ALLOWED(phys_id, allowed_mask) || !idle_cpu(phys_id));
+	} while (!IRQ_ALLOWED(phys_id, allowed_mask) || !irq_idle_cpu(phys_id));
 
 	return cpu;
 }

> 
> Andrea


Andrea
