Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263631AbUEHLMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbUEHLMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUEHLMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 07:12:55 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46901 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263692AbUEHLLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 07:11:50 -0400
Date: Sat, 8 May 2004 04:10:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: rusty@rustycorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mask 6/15] nonsmp-cpu-present-map
Message-Id: <20040508041049.037a8f77.pj@sgi.com>
In-Reply-To: <20040506190021.A17643@unix-os.sc.intel.com>
References: <936AF5883B4DD84F83C40185A810315001540E16@orsmsx404.jf.intel.com>
	<20040506190021.A17643@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty - the last bit of my shenanigans in linux/cpumask.h are below.
I welcome your comment - especially since you were the last one in here.
I think it looks a little better with this patch, but that could be a
matter of taste.

Ashok - I've put lkml on the Cc list.  If someone there finds issue
with this, better to see it sooner than later.

Ashok wrote:
> Not sure if this patch is necessary. especially all other maps are treated one way, and 
> just for one function fixup we have a differrent treatment for this.

Good questions.  What wasn't visible to you at the time you replied was
that I was experimenting with making all three maps (online, present and
possible) treated this 'new' way, removing the big ifdef CONFIG_SMP for
them from linux/cpumask.h, and defining all three of them in
kernel/sched.c in the case CONFIG_SMP is not defined.

This is not a very big change.  It's the last step of my planned cpumask
cleanup.  Whether you, Rusty or others will find it to be an improvement
or not I don't know.

> Also declaring just one map in sched.c seems like a hack, i moved it to cpu.c just
> to keep the functionality of cpu related masks in relevant files.

The other maps were already defined by my patch set, in the case CONFIG_SMP is
_not_ defined, in kernel/sched.c.  Putting cpu_present_map there as well is
consistent with that change.

> Maybe we can use some gcc intrincics to check if this is a constant, and then handle it
> appropriately in the macro definition?

Interesting idea.  I tried playing around with this avenue, but didn't come
up with any code that I preferred to what I ended up with, below.  If you
would like to offer up some code - I'd be interested to see it.

> I would prefer to keep the decl in cpu.c and ifdef the usage under CONFIG_SMP rather than
> special casing the cpu_present_map alone vs other related cpu maps.

You're quite right that the special casing is not so good.  With the
patch below, I went the other way - removing the big #ifdef CONFIG_SMP
from the other two as well.

> I will let Andrew and others decide how to handle it

Well - I suspect Andrew might not spend much of his time arbitrating this.
He usually has more serious stuff to work on.  Best if we can agree.

===

Consider the following patch - it goes on top of the sequence that I published
May 6 under the Subject: [PATCH mask 0/15] bitmap and cpumask cleanup.
I have built it for i386 (SMP and not), sparc and ia64 (sn2_defconfig),
and I have booted it on sn2.

To be clear, my 'quilt' series file contains, after the patches for
2.6.6-rc3-mm2, the lines:

    pj-fix-1-unifix.patch
    pj-fix-2-ashoks-updated-cpuhotplug-6-7.patch
    pj-fix-3-ashoks-updated-cpuhotplug-7-7.patch
    pj-fix-4-include-mempolicy.patch
    pj-fix-5-syscall-return-semicolon.patch
    nonsmp-cpu-present-map.patch
    mask1-bitmap-cleanup-prep
    mask2-bitmap-extensions
    mask3-unline-find-next-bit-ia64
    mask4-new-cpumask-h
    mask5-remove-old-cpumask-files
    mask6-cpumask-i386-fixup
    mask7-cpumask-etc-fixup
    mask8-rm-old-cpumask-emul
    mask9-post-cleanup-tweaks
    mask10-nuke-nonsmp-cpumask-ifdef


Patch name: mask10-nuke-nonsmp-cpumask-ifdef

Index: 2.6.6-rc3-mm2-bitmapv5/include/linux/cpumask.h
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/include/linux/cpumask.h	2004-05-07 23:57:03.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/include/linux/cpumask.h	2004-05-08 01:11:27.000000000 -0700
@@ -266,22 +266,58 @@
 	return bitmap_parse(buf, len, srcp->bits, nbits);
 }
 
+#if NR_CPUS > 1
+#define for_each_cpu_mask(cpu, mask)		\
+	for (cpu = first_cpu(mask);		\
+		cpu < NR_CPUS;			\
+		cpu = next_cpu(cpu, (mask)))
+#else /* NR_CPUS == 1 */
+#define for_each_cpu_mask(cpu, mask) for (cpu = 0; cpu < 1; cpu++)
+#endif /* NR_CPUS */
+
 /*
- * The following particular system cpumasks and operations
- * on them manage all (possible) and online cpus.
+ * The following particular system cpumasks and operations manage
+ * possible, present and online cpus.
+ *
+ * Subtleties:
+ * 1) UP arch's (NR_CPUS == 1, CONFIG_SMP not defined) hardcode
+ *    assumption that their single CPU is online.  There are no
+ *    actual cpu_{online,possible,present}_maps on UP.
+ * 2) Most SMP arch's #define some of these maps to be some
+ *    other map specific to that arch.
+ * 3) Due to (2), following must be #define macros, not inlines.
+ *    To see why, examine assembly code produced by following,
+ *    noting that set1() writes phys_x_map (good), but set2()
+ *    writes x_map (bad):
+ *        int x_map, phys_x_map;
+ *        #define set1(a) x_map = a
+ *        inline void set2(int a) { x_map = a; }
+ *        #define x_map phys_x_map
+ *        main(){ set1(3); set2(5); }
+ * 4) The cpu_{online,possible,present}_maps are available as
+ *    as actual defined variables even on UP arch's, though
+ *    due to (1), changing them will have no useful affect on
+ *    the following num_*_cpus(), cpu_*() and cpu_set_*line()
+ *    macros in the UP case.
  */
 
-extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_possible_map;
+extern cpumask_t cpu_online_map;
+extern cpumask_t cpu_present_map;
+
+/* Really only do call for SMP, short circuit UP */
+#define __SMP_ONLY__(x) (NR_CPUS == 1 ? 1 : (x))
 
-#ifdef CONFIG_SMP
+#define num_online_cpus()    __SMP_ONLY__(cpus_weight(cpu_online_map))
+#define num_possible_cpus()  __SMP_ONLY__(cpus_weight(cpu_possible_map))
+#define num_present_cpus()   __SMP_ONLY__(cpus_weight(cpu_present_map))
+
+#define cpu_online(cpu)      __SMP_ONLY__(cpu_isset((cpu), cpu_online_map))
+#define cpu_possible(cpu)    __SMP_ONLY__(cpu_isset((cpu), cpu_possible_map))
+#define cpu_present(cpu)     __SMP_ONLY__(cpu_isset((cpu), cpu_present_map))
 
-#define num_online_cpus()	     cpus_weight(cpu_online_map)
-#define num_possible_cpus()	     cpus_weight(cpu_possible_map)
-#define cpu_online(cpu)		     cpu_isset((cpu), cpu_online_map)
-#define cpu_possible(cpu)	     cpu_isset((cpu), cpu_possible_map)
-#define cpu_set_online(cpu)	     cpu_set((cpu), cpu_online_map)
-#define cpu_set_offline(cpu)	     cpu_clear((cpu), cpu_online_map)
+#define cpu_set_online(cpu)  __SMP_ONLY__(cpu_set((cpu), cpu_online_map))
+#define cpu_set_offline(cpu) __SMP_ONLY__(cpu_clear((cpu), cpu_online_map))
 
 #define any_online_cpu(mask)			\
 ({						\
@@ -290,34 +326,8 @@
 	first_cpu(m);				\
 })
 
-#define for_each_cpu_mask(cpu, mask)		\
-	for (cpu = first_cpu(mask);		\
-		cpu < NR_CPUS;			\
-		cpu = next_cpu(cpu, mask))
-
-#else /* !CONFIG_SMP */
-
-#define num_online_cpus()	     1
-#define num_possible_cpus()	     1
-#define cpu_online(cpu)		     ({ BUG_ON((cpu) != 0); 1; })
-#define cpu_possible(cpu)	     ({ BUG_ON((cpu) != 0); 1; })
-#define cpu_set_online(cpu)	     ({ BUG_ON((cpu) != 0); })
-#define cpu_set_offline(cpu)	     ({ BUG(); })
-
-#define any_online_cpu(mask)	     0
-
-#define for_each_cpu_mask(cpu, mask) for (cpu = 0; cpu < 1; cpu++)
-
-#endif /* CONFIG_SMP */
-
-#define for_each_cpu(cpu)	     \
-			for_each_cpu_mask(cpu, cpu_possible_map)
-#define for_each_online_cpu(cpu)     \
-			for_each_cpu_mask(cpu, cpu_online_map)
-
-extern cpumask_t cpu_present_map;
-#define num_present_cpus()              cpus_weight(cpu_present_map)
-#define cpu_present(cpu)                cpu_isset(cpu, cpu_present_map)
-#define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
+#define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
+#define for_each_online_cpu(cpu)  for_each_cpu_mask((cpu), cpu_online_map)
+#define for_each_present_cpu(cpu) for_each_cpu_mask((cpu), cpu_present_map)
 
 #endif /* __LINUX_CPUMASK_H */
Index: 2.6.6-rc3-mm2-bitmapv5/kernel/sched.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/kernel/sched.c	2004-05-07 23:57:03.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/kernel/sched.c	2004-05-08 00:18:01.000000000 -0700
@@ -3052,16 +3052,6 @@
 	return retval;
 }
 
-/*
- * Represents all cpu's present in the system
- * In systems capable of hotplug, this map could dynamically grow
- * as new cpu's are detected in the system via any platform specific
- * method, such as ACPI for e.g.
- */
-
-cpumask_t cpu_present_map;
-EXPORT_SYMBOL(cpu_present_map);
-
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process
@@ -3112,9 +3102,21 @@
 	return retval;
 }
 
+/*
+ * Represents all cpu's present in the system
+ * In systems capable of hotplug, this map could dynamically grow
+ * as new cpu's are detected in the system via any platform specific
+ * method, such as ACPI for e.g.
+ */
+
+cpumask_t cpu_present_map;
+EXPORT_SYMBOL(cpu_present_map);
+
 #ifndef CONFIG_SMP
 cpumask_t cpu_online_map = CPU_MASK_ALL;
+EXPORT_SYMBOL(cpu_online_map);
 cpumask_t cpu_possible_map = CPU_MASK_ALL;
+EXPORT_SYMBOL(cpu_possible_map);
 #endif
 
 /**


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
