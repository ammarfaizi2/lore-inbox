Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWGDFcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWGDFcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 01:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWGDFcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 01:32:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49590 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751061AbWGDFcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 01:32:35 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Jes Sorensen <jes@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close 
In-reply-to: Your message of "03 Jul 2006 11:33:54 -0400."
             <yq0mzbqhfdp.fsf@jaguar.mkp.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Jul 2006 15:32:19 +1000
Message-ID: <21169.1151991139@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen (on 03 Jul 2006 11:33:54 -0400) wrote:
>Anyway, this patch reduces the IPI noise by keeping a cpumask of CPUs
>which have items in the bh lru and only flushing on the relevant
>CPUs. On systems with larger CPU counts it's quite normal that only a
>few CPUs are actively doing block IO, so spewing IPIs everywhere to
>flush this is unnecessary.
>
>Index: linux-2.6/fs/buffer.c
>===================================================================
>--- linux-2.6.orig/fs/buffer.c
>+++ linux-2.6/fs/buffer.c
>@@ -1323,6 +1323,7 @@ struct bh_lru {
> };
> 
> static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
>+static cpumask_t lru_in_use;
> 
> #ifdef CONFIG_SMP
> #define bh_lru_lock()	local_irq_disable()
>@@ -1352,9 +1353,14 @@ static void bh_lru_install(struct buffer
> 	lru = &__get_cpu_var(bh_lrus);
> 	if (lru->bhs[0] != bh) {
> 		struct buffer_head *bhs[BH_LRU_SIZE];
>-		int in;
>-		int out = 0;
>+		int in, out, cpu;
> 
>+		cpu = raw_smp_processor_id();

Why raw_smp_processor_id?  That normally indicates code that wants a
lazy cpu number, but this code requires the exact cpu number, IMHO
using raw_smp_processor_id is confusing.  smp_processor_id can safely
be used here, bh_lru_lock has disabled irq or preempt.

>+		/* Test first to avoid cache lines bouncing around */
>+		if (!cpu_isset(cpu, lru_in_use))
>+			cpu_set(cpu, lru_in_use);
>+
>+		out = 0;
> 		get_bh(bh);
> 		bhs[out++] = bh;
> 		for (in = 0; in < BH_LRU_SIZE; in++) {
>@@ -1500,19 +1506,28 @@ EXPORT_SYMBOL(__bread);
>  */
> static void invalidate_bh_lru(void *arg)
> {
>-	struct bh_lru *b = &get_cpu_var(bh_lrus);
>+	struct bh_lru *b;
> 	int i;
> 
>+	local_irq_disable();
>+	b = &get_cpu_var(bh_lrus);
> 	for (i = 0; i < BH_LRU_SIZE; i++) {
> 		brelse(b->bhs[i]);
> 		b->bhs[i] = NULL;
> 	}
> 	put_cpu_var(bh_lrus);
>+	local_irq_enable();
> }
> 	
> static void invalidate_bh_lrus(void)
> {
>-	on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
>+	/*
>+	 * Need to hand down a copy of the mask or we wouldn't be run
>+	 * anywhere due to the original mask being cleared
>+	 */
>+	cpumask_t mask = lru_in_use;
>+	cpus_clear(lru_in_use);
>+	schedule_on_each_cpu_mask(invalidate_bh_lru, NULL, mask);
> }

Racy?  Start with an empty lru_in_use.

Cpu A                         Cpu B
invalidate_bh_lrus()
mask = lru_in_use;
preempted
                              block I/O
			      bh_lru_install()
			      cpu_set(cpu, lru_in_use);
resume
cpus_clear(lru_in_use);
schedule_on_each_cpu_mask() - does not send IPI to cpu B

