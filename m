Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbUJ3O42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUJ3O42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUJ3Ozk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:55:40 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:41145 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261217AbUJ3OlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:41:23 -0400
Message-ID: <4183A803.6030406@kolivas.org>
Date: Sun, 31 Oct 2004 00:41:07 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 24/28] Make public parts of sched_domains
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig38BF959E4EE0F96383E154AE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38BF959E4EE0F96383E154AE
Content-Type: multipart/mixed;
 boundary="------------080709040805080805090504"

This is a multi-part message in MIME format.
--------------080709040805080805090504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make public parts of sched_domains


--------------080709040805080805090504
Content-Type: text/x-patch;
 name="publicise_domains.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_domains.diff"

Put common scheduler domains code into scheduler.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-30 00:19:32.642969636 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-30 00:20:11.034827926 +1000
@@ -456,13 +456,11 @@ struct sched_domain {
 #endif
 };
 
-extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
-#ifdef ARCH_HAS_SCHED_DOMAIN
 /* Useful helpers that arch setup code may use. Defined in kernel/sched.c */
-extern cpumask_t cpu_isolated_map;
+extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
 extern void init_sched_build_groups(struct sched_group groups[],
 	                        cpumask_t span, int (*group_fn)(int cpu));
-#endif /* ARCH_HAS_SCHED_DOMAIN */
+extern cpumask_t cpu_isolated_map;
 #endif /* CONFIG_SMP */
 
 
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-30 00:19:32.640969956 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-30 00:20:11.036827607 +1000
@@ -3561,9 +3561,6 @@ static void __devinit ingo_cpu_attach_do
 	}
 }
 
-/* cpus with isolated domains */
-cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
-
 /* Setup the mask of cpus configured for isolated domains */
 static int __init isolated_cpu_setup(char *str)
 {
@@ -3578,52 +3575,6 @@ static int __init isolated_cpu_setup(cha
 
 __setup ("isolcpus=", isolated_cpu_setup);
 
-/*
- * init_sched_build_groups takes an array of groups, the cpumask we wish
- * to span, and a pointer to a function which identifies what group a CPU
- * belongs to. The return value of group_fn must be a valid index into the
- * groups[] array, and must be >= 0 and < NR_CPUS (due to the fact that we
- * keep track of groups covered with a cpumask_t).
- *
- * init_sched_build_groups will build a circular linked list of the groups
- * covered by the given span, and will set each group's ->cpumask correctly,
- * and ->cpu_power to 0.
- */
-void __devinit init_sched_build_groups(struct sched_group groups[],
-			cpumask_t span, int (*group_fn)(int cpu))
-{
-	struct sched_group *first = NULL, *last = NULL;
-	cpumask_t covered = CPU_MASK_NONE;
-	int i;
-
-	for_each_cpu_mask(i, span) {
-		int group = group_fn(i);
-		struct sched_group *sg = &groups[group];
-		int j;
-
-		if (cpu_isset(i, covered))
-			continue;
-
-		sg->cpumask = CPU_MASK_NONE;
-		sg->cpu_power = 0;
-
-		for_each_cpu_mask(j, span) {
-			if (group_fn(j) != group)
-				continue;
-
-			cpu_set(j, covered);
-			cpu_set(j, sg->cpumask);
-		}
-		if (!first)
-			first = sg;
-		if (last)
-			last->next = sg;
-		last = sg;
-	}
-	last->next = first;
-}
-
-
 #ifdef ARCH_HAS_SCHED_DOMAIN
 extern void __devinit arch_init_sched_domains(void);
 extern void __devinit arch_destroy_sched_domains(void);
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-30 00:20:06.213599204 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-30 00:20:11.037827447 +1000
@@ -878,6 +878,56 @@ void fastcall complete_all(struct comple
 }
 EXPORT_SYMBOL(complete_all);
 
+#ifdef CONFIG_SMP
+/* cpus with isolated domains */
+cpumask_t __devinitdata cpu_isolated_map = CPU_MASK_NONE;
+
+/*
+ * init_sched_build_groups takes an array of groups, the cpumask we wish
+ * to span, and a pointer to a function which identifies what group a CPU
+ * belongs to. The return value of group_fn must be a valid index into the
+ * groups[] array, and must be >= 0 and < NR_CPUS (due to the fact that we
+ * keep track of groups covered with a cpumask_t).
+ *
+ * init_sched_build_groups will build a circular linked list of the groups
+ * covered by the given span, and will set each group's ->cpumask correctly,
+ * and ->cpu_power to 0.
+ */
+void __devinit init_sched_build_groups(struct sched_group groups[],
+			cpumask_t span, int (*group_fn)(int cpu))
+{
+	struct sched_group *first = NULL, *last = NULL;
+	cpumask_t covered = CPU_MASK_NONE;
+	int i;
+
+	for_each_cpu_mask(i, span) {
+		int group = group_fn(i);
+		struct sched_group *sg = &groups[group];
+		int j;
+
+		if (cpu_isset(i, covered))
+			continue;
+
+		sg->cpumask = CPU_MASK_NONE;
+		sg->cpu_power = 0;
+
+		for_each_cpu_mask(j, span) {
+			if (group_fn(j) != group)
+				continue;
+
+			cpu_set(j, covered);
+			cpu_set(j, sg->cpumask);
+		}
+		if (!first)
+			first = sg;
+		if (last)
+			last->next = sg;
+		last = sg;
+	}
+	last->next = first;
+}
+#endif
+
 extern struct sched_drv ingo_sched_drv;
 
 struct sched_drv *scheduler =


--------------080709040805080805090504--

--------------enig38BF959E4EE0F96383E154AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6gDZUg7+tp6mRURAoV0AJ9mn1lkaHHk+API7JI6lVR/Huu0rACfX9Y2
4FlUulXduq6ORlcdKKttpOk=
=3YU8
-----END PGP SIGNATURE-----

--------------enig38BF959E4EE0F96383E154AE--
