Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUIWCKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUIWCKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 22:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUIWCKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 22:10:24 -0400
Received: from holomorphy.com ([207.189.100.168]:5331 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268144AbUIWCIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 22:08:31 -0400
Date: Wed, 22 Sep 2004 19:08:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hawkes@sgi.com, raybry@sgi.com, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] fix timer interrupt livelock on 512x Altix
Message-ID: <20040923020819.GU9106@holomorphy.com>
References: <20040920213020.GX9106@holomorphy.com> <20040920221554.7f72f0eb.akpm@osdl.org> <20040921084232.GE9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921084232.GE9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>>  What this patch does is to create a pair of per-cpu open-addressed
>>>  hashtables indexed by profile buffer slot holding values representing
>>>  the number of pending profile buffer hits for the profile buffer slot.

On Mon, Sep 20, 2004 at 10:15:54PM -0700, Andrew Morton wrote:
>> Needs a compile fix (see below).
>> Also, goes oops on x86:

On Tue, Sep 21, 2004 at 01:42:32AM -0700, William Lee Irwin III wrote:
> Okay, I'll resend after dealing with that. It looks obvious, but just
> to cut down on noise and/or false starts I'll get it through a clean
> ia32 boot before following up. It was runtime tested on x86-64, sparc64,
> ia64, alpha, and ppc64 prior to posting, so it boggles my mind that a
> bogon this obvious could have run that gauntlet undetected...

With the following fix (I took the liberty of cleaning up the ifdef'd
code in create_proc_profile() into a conditionally-defined function)
this compiles and boots successfully on an 8x Pentium4 (ia32) HP
Proliant with 32GB RAM. The trivial bug was forgetting to zero out the
hashtables prior to their initial use.


Index: mm1-2.6.9-rc2/kernel/profile.c
===================================================================
--- mm1-2.6.9-rc2.orig/kernel/profile.c	2004-09-20 14:45:10.041602384 -0700
+++ mm1-2.6.9-rc2/kernel/profile.c	2004-09-21 01:39:13.956620472 -0700
@@ -22,6 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/profile.h>
+#include <linux/highmem.h>
 #include <asm/sections.h>
 #include <asm/semaphore.h>
 
@@ -511,17 +512,11 @@
 static void __init profile_nop(void *unused)
 {
 }
-#endif
 
-static int __init create_proc_profile(void)
+static int __init create_hash_tables(void)
 {
-	struct proc_dir_entry *entry;
 	int cpu;
 
-	(void)cpu;
-	if (!prof_on)
-		return 0;
-#ifdef CONFIG_SMP
 	for_each_online_cpu(cpu) {
 		int node = cpu_to_node(cpu);
 		struct page *page;
@@ -529,22 +524,17 @@
 		page = alloc_pages_node(node, GFP_KERNEL, 0);
 		if (!page)
 			goto out_cleanup;
+		clear_highpage(page);
 		per_cpu(cpu_profile_hits, cpu)[1]
 				= (struct profile_hit *)page_address(page);
 		page = alloc_pages_node(node, GFP_KERNEL, 0);
 		if (!page)
 			goto out_cleanup;
+		clear_highpage(page);
 		per_cpu(cpu_profile_hits, cpu)[0]
 				= (struct profile_hit *)page_address(page);
 	}
-#endif /* CONFIG_SMP */
-	if (!(entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL)))
-		return 0;
-	entry->proc_fops = &proc_profile_operations;
-	entry->size = (1+prof_len) * sizeof(atomic_t);
-	hotcpu_notifier(profile_cpu_callback, 0);
 	return 0;
-#ifdef CONFIG_SMP
 out_cleanup:
 	prof_on = 0;
 	mb();
@@ -564,7 +554,25 @@
 		}
 	}
 	return -1;
-#endif /* CONFIG_SMP */
+}
+#else
+#define create_hash_tables()			({ 0; })
+#endif
+
+static int __init create_proc_profile(void)
+{
+	struct proc_dir_entry *entry;
+
+	if (!prof_on)
+		return 0;
+	if (create_hash_tables())
+		return -1;
+	if (!(entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL)))
+		return 0;
+	entry->proc_fops = &proc_profile_operations;
+	entry->size = (1+prof_len) * sizeof(atomic_t);
+	hotcpu_notifier(profile_cpu_callback, 0);
+	return 0;
 }
 module_init(create_proc_profile);
 #endif /* CONFIG_PROC_FS */
