Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268991AbUJKONw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268991AbUJKONw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268979AbUJKONw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:13:52 -0400
Received: from smtp09.auna.com ([62.81.186.19]:11507 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269006AbUJKOMo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:12:44 -0400
Date: Mon, 11 Oct 2004 14:12:40 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc4-mm1
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Tim Cambrant <cambrant@acc.umu.se>, akpm@digeo.com
References: <2O5L3-5Jq-11@gated-at.bofh.it> <2O6Ho-6ra-51@gated-at.bofh.it>
	<m3zn2tv35o.fsf@averell.firstfloor.org> <200410111538.33299.rjw@sisk.pl>
In-Reply-To: <200410111538.33299.rjw@sisk.pl> (from rjw@sisk.pl on Mon Oct
	11 15:38:32 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097503960l.6177l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.11, Rafael J. Wysocki wrote:
> On Monday 11 of October 2004 14:40, Andi Kleen wrote:
> > Tim Cambrant <cambrant@acc.umu.se> writes:
> > 
> > > On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
> > >>
> > >> optimize-profile-path-slightly.patch
> > >>   Optimize profile path slightly
> > >>
> > >
> > > I'm still getting an oops at startup with this patch. After reversing
> > > it, everything is fine. Weren't you supposed to remove that from your
> > > tree until it was fixed?
> > 
> > There's a fixed version around. I thought Andrew had merged that one?
> [-- snip --]
> 
> This one does not apply to -mm.
> 

Use this:

diff -ruN linux-2.6.9-rc3-mm3/include/linux/profile.h linux-2.6.9-rc3-mm3-prof/include/linux/profile.h
--- linux-2.6.9-rc3-mm3/include/linux/profile.h	2004-09-30 09:46:41.000000000 +0200
+++ linux-2.6.9-rc3-mm3-prof/include/linux/profile.h	2004-10-07 19:41:36.254643765 +0200
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
diff -ruN linux-2.6.9-rc3-mm3/kernel/profile.c linux-2.6.9-rc3-mm3-prof/kernel/profile.c
--- linux-2.6.9-rc3-mm3/kernel/profile.c	2004-10-07 14:45:02.176576637 +0200
+++ linux-2.6.9-rc3-mm3-prof/kernel/profile.c	2004-10-07 19:41:36.253643976 +0200
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
@@ -381,25 +379,17 @@
 #define profile_flip_buffers()		do { } while (0)
 #define profile_discard_flip_buffers()	do { } while (0)
 
-inline void profile_hit(int type, void *__pc)
+void profile_hit(int type, void *__pc)
 {
 	unsigned long pc;
 
+	if (prof_on != type || !prof_buffer)
+		return;
 	pc = ((unsigned long)__pc - (unsigned long)_stext) >> prof_shift;
 	atomic_inc(&prof_buffer[min(pc, prof_len - 1)]);
 }
 #endif /* !CONFIG_SMP */
 
-void profile_tick(int type, struct pt_regs *regs)
-{
-	if (type == CPU_PROFILING)
-		profile_hook(regs);
-	if (prof_on != type || !prof_buffer)
-		return;
-	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
-		profile_hit(type, (void *)profile_pc(regs));
-}
-
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <asm/uaccess.h>


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


