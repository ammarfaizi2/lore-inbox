Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269649AbUINTEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269649AbUINTEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269466AbUINTEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:04:16 -0400
Received: from holomorphy.com ([207.189.100.168]:48533 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269439AbUINTAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:00:36 -0400
Date: Tue, 14 Sep 2004 12:00:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914190030.GZ9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914155103.GR9106@holomorphy.com> <20040914160531.GP4180@dualathlon.random> <200409140916.48786.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409140916.48786.jbarnes@engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 14, 2004 9:05 am, Andrea Arcangeli wrote:
>> Before dedicidng I'd suggest to have a look and see how the below patch
>> compares to your approch in performance terms.

On Tue, Sep 14, 2004 at 09:16:48AM -0700, Jesse Barnes wrote:
> It looks like the 512p we have here is pretty heavily reserved this week, so 
> I'm not sure if I'll be able to test this (someone else might, John?).  I 
> think the balance we're looking for is between simplicity and
> non-brokenness. Builtin profiling is *supposed* to be simple and dumb,
> and were it not for the readprofile times, I'd say per-cpu would be
> the way to go just because it retains the simplicity of the current
> approach while allowing it to work on large machines (as well as
> limiting the performance impact of builtin profiling in general).
> wli's approach seems like a reasonable tradeoff though, assuming what
> you suggest doesn't work.

Goddamn fscking short-format VHPT crap. Rusty, how the hell do I
hotplug-ize this?


-- wli

Atop the prior per-cpu hashtable patch. It turns out that ia64 has
limitations on the sizes of per-cpu areas to the size of an area
covered by a single TLB entry, and worse yet, as short format VHPT
is being used, this TLB entry is limited to the PAGE_SIZE of the
region used for kernel data.

In order to address this, the following patch dynamically allocates
the per-cpu hashtables at boot-time. It probably needs adjustments
for cpu hotplug.


Index: mm5-2.6.9-rc1/kernel/profile.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/profile.c	2004-09-14 01:27:49.675716672 -0700
+++ mm5-2.6.9-rc1/kernel/profile.c	2004-09-14 10:20:43.589942872 -0700
@@ -34,7 +34,7 @@
 static int prof_on;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
 #ifdef CONFIG_SMP
-static DEFINE_PER_CPU(struct profile_hit [2][NR_PROFILE_HIT], cpu_profile_hits);
+static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
 #endif /* CONFIG_SMP */
 
@@ -273,6 +273,10 @@
 	secondary = ~(pc << 1) & (NR_PROFILE_HIT - 1);
 	cpu = get_cpu();
 	hits = per_cpu(cpu_profile_hits, cpu)[per_cpu(cpu_profile_flip, cpu)];
+	if (!hits) {
+		put_cpu();
+		return;
+	}
 	local_irq_save(flags);
 	do {
 		if (hits[i].pc == pc) {
@@ -423,17 +427,58 @@
 	.write		= write_profile,
 };
 
+#ifdef CONFIG_SMP
+static void __init profile_nop(void *unused)
+{
+}
+#endif
+
 static int __init create_proc_profile(void)
 {
 	struct proc_dir_entry *entry;
+	int cpu;
 
+	(void)cpu;
 	if (!prof_on)
 		return 0;
+#ifdef CONFIG_SMP
+	for_each_online_cpu(cpu) {
+		per_cpu(cpu_profile_hits, cpu)[0]
+			= (struct profile_hit *)get_zeroed_page(GFP_KERNEL);
+		if (!per_cpu(cpu_profile_hits, cpu)[0])
+			goto out_cleanup;
+		per_cpu(cpu_profile_hits, cpu)[1]
+			= (struct profile_hit *)get_zeroed_page(GFP_KERNEL);
+		if (per_cpu(cpu_profile_hits, cpu)[1])
+			continue;
+		free_page((unsigned long)per_cpu(cpu_profile_hits, cpu)[0]);
+		goto out_cleanup;
+	}
+#endif /* CONFIG_SMP */
 	if (!(entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL)))
 		return 0;
 	entry->proc_fops = &proc_profile_operations;
 	entry->size = (1+prof_len) * sizeof(atomic_t);
 	return 0;
+#ifdef CONFIG_SMP
+out_cleanup:
+	prof_on = 0;
+	mb();
+	on_each_cpu(profile_nop, NULL, 0, 1);
+	for_each_online_cpu(cpu) {
+		unsigned long kvaddr
+			= (unsigned long)per_cpu(cpu_profile_hits, cpu)[0];
+
+		if (!kvaddr)
+			break;
+		per_cpu(cpu_profile_hits, cpu)[0] = NULL;
+		free_page(kvaddr);
+		kvaddr = (unsigned long)per_cpu(cpu_profile_hits, cpu)[1];
+		per_cpu(cpu_profile_hits, cpu)[1] = NULL;
+		free_page(kvaddr);
+	}
+	return -1;
+#endif /* CONFIG_SMP */
 }
 module_init(create_proc_profile);
 #endif /* CONFIG_PROC_FS */
