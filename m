Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269762AbUINUOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269762AbUINUOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUINUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:09:31 -0400
Received: from holomorphy.com ([207.189.100.168]:13206 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269038AbUINUFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:05:00 -0400
Date: Tue, 14 Sep 2004 13:04:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914200453.GI9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914155103.GR9106@holomorphy.com> <20040914160531.GP4180@dualathlon.random> <200409140916.48786.jbarnes@engr.sgi.com> <20040914190030.GZ9106@holomorphy.com> <20040914200220.GH9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914200220.GH9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 12:00:30PM -0700, William Lee Irwin III wrote:
>> Goddamn fscking short-format VHPT crap. Rusty, how the hell do I
>> hotplug-ize this?

On Tue, Sep 14, 2004 at 01:02:20PM -0700, William Lee Irwin III wrote:
> Okay, here's an attempt to hotplug-ize it. I have no clue whether this
> actually works, compiles, or follows whatever rules there are about
> dynamically allocated data referenced by per_cpu areas.

Take 2: actually register the notifier I wrote.


Index: mm5-2.6.9-rc1/kernel/profile.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/profile.c	2004-09-14 10:20:43.000000000 -0700
+++ mm5-2.6.9-rc1/kernel/profile.c	2004-09-14 12:56:33.871160032 -0700
@@ -20,6 +20,7 @@
 #include <linux/notifier.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/cpu.h>
 #include <linux/profile.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
@@ -297,6 +298,44 @@
 	local_irq_restore(flags);
 	put_cpu();
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+static int __devinit profile_cpu_callback(struct notifier_block *info,
+					unsigned long action, void *__cpu)
+{
+	int cpu = (unsigned long)__cpu;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		per_cpu(cpu_profile_flip, cpu) = 0;
+		if (!per_cpu(cpu_profile_hits, cpu)[1])
+			per_cpu(cpu_profile_hits, cpu)[1]
+				= (void *)get_zeroed_page(GFP_KERNEL);
+		if (!per_cpu(cpu_profile_hits, cpu)[1])
+			return NOTIFY_BAD;
+		if (!per_cpu(cpu_profile_hits, cpu)[0])
+			per_cpu(cpu_profile_hits, cpu)[0]
+				= (void *)get_zeroed_page(GFP_KERNEL);
+		if (per_cpu(cpu_profile_hits, cpu)[0])
+			break;
+		free_page((unsigned long)per_cpu(cpu_profile_hits, cpu)[1]);
+		return NOTIFY_BAD;
+		break;
+	case CPU_ONLINE:
+		cpu_set(cpu, prof_cpu_mask);
+		break;
+	case CPU_UP_CANCELED:
+	case CPU_DEAD:
+		cpu_clear(cpu, prof_cpu_mask);
+		free_page((unsigned long)per_cpu(cpu_profile_hits, cpu)[0]);
+		per_cpu(cpu_profile_hits, cpu)[0] = NULL;
+		free_page((unsigned long)per_cpu(cpu_profile_hits, cpu)[1]);
+		per_cpu(cpu_profile_hits, cpu)[1] = NULL;
+		break;
+	}
+	return NOTIFY_OK;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
 #else /* !CONFIG_SMP */
 #define profile_flip_buffers()		do { } while (0)
 
@@ -459,6 +498,7 @@
 		return 0;
 	entry->proc_fops = &proc_profile_operations;
 	entry->size = (1+prof_len) * sizeof(atomic_t);
+	hotcpu_notifier(profile_cpu_callback, 0);
 	return 0;
 #ifdef CONFIG_SMP
 out_cleanup:
