Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUFVPnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUFVPnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbUFVPbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:31:19 -0400
Received: from holomorphy.com ([207.189.100.168]:34435 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264648AbUFVPQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:16:45 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [2/23] ppc32 profiling cleanups
Message-ID: <0406220816.LbZaYa4aYaZaYa0a5aHb4a0a3aHb4aYaIbJb5aMbXa3a5a1aZaKbZa3aIb4aHb0a15250@holomorphy.com>
In-Reply-To: <0406220816.XaKbZa2a2aXa4a2aLbIb3aHbJbIbWaYa5a5aKb1a2aHbIb0aHb3a4aHb1a0aLbWa15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ppc32 to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/ppc/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/ppc/kernel/time.c	2004-06-15 22:19:44.000000000 -0700
+++ prof-2.6.7/arch/ppc/kernel/time.c	2004-06-22 07:25:44.334423312 -0700
@@ -56,6 +56,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/profile.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -108,14 +109,10 @@
 }
 
 extern unsigned long prof_cpu_mask;
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
-extern char _stext;
 
 static inline void ppc_do_profile (unsigned long nip)
 {
-	if (!prof_buffer)
+	if (!profiling_on())
 		return;
 
 	/*
@@ -124,17 +121,7 @@
 	 */
 	if (!((1<<smp_processor_id()) & prof_cpu_mask))
 		return;
-
-	nip -= (unsigned long) &_stext;
-	nip >>= prof_shift;
-	/*
-	 * Don't ignore out-of-bounds EIP values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (nip > prof_len-1)
-		nip = prof_len-1;
-	atomic_inc((atomic_t *)&prof_buffer[nip]);
+	profile_tick(nip);
 }
 
 /*
Index: prof-2.6.7/include/linux/profile.h
===================================================================
--- prof-2.6.7.orig/include/linux/profile.h	2004-06-22 07:25:43.260586560 -0700
+++ prof-2.6.7/include/linux/profile.h	2004-06-22 07:25:44.336423008 -0700
@@ -14,6 +14,8 @@
 /* init basic kernel profiler */
 void __init profile_init(void);
 void create_proc_profile(void);
+void profile_tick(unsigned long);
+int profiling_on(void);
 
 extern unsigned int * prof_buffer;
 extern unsigned long prof_len;
Index: prof-2.6.7/kernel/profile.c
===================================================================
--- prof-2.6.7.orig/kernel/profile.c	2004-06-22 07:25:43.258586864 -0700
+++ prof-2.6.7/kernel/profile.c	2004-06-22 07:25:44.339422552 -0700
@@ -42,6 +42,23 @@
 	prof_buffer = (unsigned int *) alloc_bootmem(size);
 }
 
+int profiling_on(void)
+{
+	return !!prof_on;
+}
+
+void profile_tick(unsigned long pc)
+{
+	atomic_t *count;
+	unsigned long idx;
+
+	if (!prof_on)
+		return;
+	idx = (pc - (unsigned long)_stext) >> prof_shift;
+	count = (atomic_t *)&prof_buffer[min(idx, prof_len - 1)];
+	atomic_inc(count);
+}
+
 /* Profile event notifications */
  
 #ifdef CONFIG_PROFILING
