Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbULHTEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbULHTEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbULHTEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:04:13 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:29346 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261310AbULHTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:03:58 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
References: <20041116130946.GA11053@elte.hu>
	 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
	 <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
	 <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
	 <20041207132927.GA4846@elte.hu>  <20041207141123.GA12025@elte.hu>
	 <1102526018.25841.308.camel@localhost.localdomain>
	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Wed, 08 Dec 2004 14:03:45 -0500
Message-Id: <1102532625.25841.327.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 18:14 +0000, Rui Nuno Capela wrote:
> Steven Rostedt wrote:
> >
> > I found a race condition in slab.c, but I'm still trying to figure out
> > exactly how it's playing out.  This has to do with dynamic loading and
> > unloading of caches. I have a small test case that simulates the problem
> > at http://home.stny.rr.com/rostedt/tests/sillycaches.tgz
> >
> > This was done on:
> >
> > # uname -r
> > 2.6.10-rc2-mm3-V0.7.32-9
> >

<snip>


Found the culprit!!! I did a diff of 2.6.10-rc2-mm3 to
2.6.10-rc2-mm3-V0.7.32-9 and found this in slab.c:
----------------------------
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * Executes in an IRQ context:
+ */
 static void do_drain(void *arg)
 {         kmem_cache_t *cachep = (kmem_cache_t*)arg;
        struct array_cache *ac;
+       int cpu = smp_processor_id();
         check_irq_off();
-       ac = ac_data(cachep);
+       ac = ac_data(cachep, cpu);
        spin_lock(&cachep->spinlock);
        free_block(cachep, &ac_entry(ac)[0], ac->avail);
        spin_unlock(&cachep->spinlock);
        ac->avail = 0;
 }
+#endif

 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
+#ifndef CONFIG_PREEMPT_RT
        smp_call_function_all_cpus(do_drain, cachep);
+#endif
        check_irq_on();

--------------------------------
(I have CONFIG_PREEMPT_RT defined :-)

I then put in 

 static void drain_cpu_caches(kmem_cache_t *cachep)
 {
 #ifndef CONFIG_PREEMPT_RT
        smp_call_function_all_cpus(do_drain, cachep);
 #endif
        check_irq_on();
        spin_lock_irq(&cachep->spinlock);
+       {
+               struct array_cache *ac;
+               ac = ac_data(cachep, smp_processor_id());
+               free_block(cachep, &ac_entry(ac)[0], ac->avail);
+               ac->avail = 0;
+       }

To see what would happen, and this indeed fixed the problem. At least
didn't cause the problem to appear after a few tests.

Obviously, this is not the right answer, and Ingo, since I don't know
exactly what you are accomplishing with the added cpu changes, I think
you are probably better at writing a patch than I.  

Which brings up another point.

In places like kmem_cache_create you have cpu = _smp_processor_id(); and
way down near the bottom, you use it.  Being a preemptable kernel, can't
that process jump cpus in the time being? So isn't that in itself a race
condition?

Thanks,

-- Steve

Rui,

Try adding the following in slab.c

--- slab.c      2004-12-08 09:27:10.000000000 -0500
+++ slab.c.new  2004-12-08 13:58:40.000000000 -0500
@@ -1533,6 +1533,12 @@
 #ifndef CONFIG_PREEMPT_RT
        smp_call_function_all_cpus(do_drain, cachep);
 #endif
+       {
+               struct array_cache *ac;
+               ac = ac_data(cachep, smp_processor_id());
+               free_block(cachep, &ac_entry(ac)[0], ac->avail);
+               ac->avail = 0;
+       }
        check_irq_on();
        spin_lock_irq(&cachep->spinlock);
        if (cachep->lists.shared)


and see if this fixes your usb problems.  I would say that this is not a
proper fix and especially for a SMP system. But if it fixes your problem
then you know this is the solution.

