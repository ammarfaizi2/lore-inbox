Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269797AbUJGLlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269797AbUJGLlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbUJGLlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:41:04 -0400
Received: from holomorphy.com ([207.189.100.168]:27854 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269797AbUJGLk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:40:56 -0400
Date: Thu, 7 Oct 2004 04:40:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Sanders <sandersn@btinternet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041007114040.GV9106@holomorphy.com>
References: <20041007015139.6f5b833b.akpm@osdl.org> <200410071041.20723.sandersn@btinternet.com> <20041007025007.77ec1a44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007025007.77ec1a44.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Sanders <sandersn@btinternet.com> wrote:
>> I get the following oops when booting and it also stops kde
>> (artswrapper) from starting with the same call trace. USB seems to
>> be working which is good.

On Thu, Oct 07, 2004 at 02:50:07AM -0700, Andrew Morton wrote:
> Could you please do
> cd /usr/src/linux
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
> patch -R -p1 < optimize-profile-path-slightly.patch
> and retest?

Here is a more likely correct patch for what that was trying to do,
however misguided that may be. Untested, uncompiled, vs. 2.6.9-rc3-mm3
without the bad patch:

Expose some variables from kernel/profile.c to the world to short-
circuit some checks in some inline wrappers for the purportedly
``heavier'' profiling functions. I took the liberty of declaring
some variables extern in the bodies of the inlines, which is rare
in the kernel, but protects against the use of the now-exposed
variables by things that shouldn't touch them.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: mm3-2.6.9-rc3/kernel/profile.c
===================================================================
--- mm3-2.6.9-rc3.orig/kernel/profile.c	2004-10-07 04:07:13.019223245 -0700
+++ mm3-2.6.9-rc3/kernel/profile.c	2004-10-07 04:38:08.299177821 -0700
@@ -34,10 +34,10 @@
 #define NR_PROFILE_HIT		(PAGE_SIZE/sizeof(struct profile_hit))
 #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
-static atomic_t *prof_buffer;
+atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
-static int prof_on;
-static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
+int prof_on;
+cpumask_t prof_cpu_mask = CPU_MASK_ALL;
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
 static DEFINE_PER_CPU(int, cpu_profile_flip);
@@ -284,14 +284,12 @@
 	up(&profile_flip_mutex);
 }
 
-void profile_hit(int type, void *__pc)
+void fastcall __profile_hit(void *__pc)
 {
 	unsigned long primary, secondary, flags, pc = (unsigned long)__pc;
 	int i, j, cpu;
 	struct profile_hit *hits;
 
-	if (prof_on != type || !prof_buffer)
-		return;
 	pc = min((pc - (unsigned long)_stext) >> prof_shift, prof_len - 1);
 	i = primary = (pc & (NR_PROFILE_GRP - 1)) << PROFILE_GRPSHIFT;
 	secondary = (~(pc << 1) & (NR_PROFILE_GRP - 1)) << PROFILE_GRPSHIFT;
@@ -392,14 +390,6 @@
 }
 #endif /* !CONFIG_SMP */
 
-void profile_tick(int type, struct pt_regs *regs)
-{
-	if (type == CPU_PROFILING)
-		profile_hook(regs);
-	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
-		profile_hit(type, (void *)profile_pc(regs));
-}
-
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <asm/uaccess.h>
Index: mm3-2.6.9-rc3/include/linux/profile.h
===================================================================
--- mm3-2.6.9-rc3.orig/include/linux/profile.h	2004-10-07 04:03:39.960613077 -0700
+++ mm3-2.6.9-rc3/include/linux/profile.h	2004-10-07 04:28:46.333609573 -0700
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/cpumask.h>
 #include <asm/errno.h>
+#include <asm/atomic.h>
 
 #define CPU_PROFILING	1
 #define SCHED_PROFILING	2
@@ -17,8 +18,8 @@
 
 /* init basic kernel profiler */
 void __init profile_init(void);
-void profile_tick(int, struct pt_regs *);
-void profile_hit(int, void *);
+void FASTCALL(__profile_hit(void *));
+
 #ifdef CONFIG_PROC_FS
 void create_prof_cpu_mask(struct proc_dir_entry *);
 #else
@@ -101,6 +102,26 @@
 
 #endif /* CONFIG_PROFILING */
 
+static inline void profile_hit(int type, void *pc)
+{
+	extern int prof_on;
+	extern atomic_t *prof_buffer;
+
+	if (prof_on == type && prof_buffer)
+		__profile_hit(pc);
+}
+
+static inline void profile_tick(int type, struct pt_regs *regs)
+{
+	extern cpumask_t prof_cpu_mask;
+
+	if (type != CPU_PROFILING)
+		return;
+	profile_hook(regs);
+	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
+		profile_hit(type, (void *)profile_pc(regs));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PROFILE_H */
