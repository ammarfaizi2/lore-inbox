Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWGDGli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWGDGli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWGDGlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:41:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbWGDGlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:41:37 -0400
Date: Mon, 3 Jul 2006 23:41:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: jes@sgi.com, torvalds@osdl.org, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
Message-Id: <20060703234134.786944f1.akpm@osdl.org>
In-Reply-To: <21169.1151991139@kao2.melbourne.sgi.com>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>
	<21169.1151991139@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jul 2006 15:32:19 +1000
Keith Owens <kaos@sgi.com> wrote:

> Jes Sorensen (on 03 Jul 2006 11:33:54 -0400) wrote:
> >Anyway, this patch reduces the IPI noise by keeping a cpumask of CPUs
> >which have items in the bh lru and only flushing on the relevant
> >CPUs. On systems with larger CPU counts it's quite normal that only a
> >few CPUs are actively doing block IO, so spewing IPIs everywhere to
> >flush this is unnecessary.
> >
> >Index: linux-2.6/fs/buffer.c
> >===================================================================
> >--- linux-2.6.orig/fs/buffer.c
> >+++ linux-2.6/fs/buffer.c
> >@@ -1323,6 +1323,7 @@ struct bh_lru {
> > };
> > 
> > static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
> >+static cpumask_t lru_in_use;
> > 
> > #ifdef CONFIG_SMP
> > #define bh_lru_lock()	local_irq_disable()
> >@@ -1352,9 +1353,14 @@ static void bh_lru_install(struct buffer
> > 	lru = &__get_cpu_var(bh_lrus);
> > 	if (lru->bhs[0] != bh) {
> > 		struct buffer_head *bhs[BH_LRU_SIZE];
> >-		int in;
> >-		int out = 0;
> >+		int in, out, cpu;
> > 
> >+		cpu = raw_smp_processor_id();
> 
> Why raw_smp_processor_id?  That normally indicates code that wants a
> lazy cpu number, but this code requires the exact cpu number, IMHO
> using raw_smp_processor_id is confusing.  smp_processor_id can safely
> be used here, bh_lru_lock has disabled irq or preempt.

I expect raw_smp_processor_id() is used here as a a microoptimisation -
avoid a might_sleep() which obviously will never trigger.

But I think it'd be better to do just a single raw_smp_processor_id() for
this entire function:

  static void bh_lru_install(struct buffer_head *bh)
  {
	struct buffer_head *evictee = NULL;
	struct bh_lru *lru;
+	int cpu;

	check_irqs_on();
	bh_lru_lock();
+	cpu = raw_smp_processor_id();
-	lru = &__get_cpu_var(bh_lrus);
+	lru = per_cpu(bh_lrus, cpu);

etcetera.

> > 	
> > static void invalidate_bh_lrus(void)
> > {
> >-	on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
> >+	/*
> >+	 * Need to hand down a copy of the mask or we wouldn't be run
> >+	 * anywhere due to the original mask being cleared
> >+	 */
> >+	cpumask_t mask = lru_in_use;
> >+	cpus_clear(lru_in_use);
> >+	schedule_on_each_cpu_mask(invalidate_bh_lru, NULL, mask);
> > }
> 
> Racy?  Start with an empty lru_in_use.
> 
> Cpu A                         Cpu B
> invalidate_bh_lrus()
> mask = lru_in_use;
> preempted
>                               block I/O
> 			      bh_lru_install()
> 			      cpu_set(cpu, lru_in_use);
> resume
> cpus_clear(lru_in_use);
> schedule_on_each_cpu_mask() - does not send IPI to cpu B

Yup.  I think we can fix that by doing a single cpu_clear() on each CPU
just prior to that CPU clearing out its array, in invalidate_bh_lru().

There's a possibility of course that new bh's will get installed somewhere,
but higher-level code must ensure that those bh's do not belong to the
device which we're trying to clean up.
