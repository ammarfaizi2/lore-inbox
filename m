Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUFVPaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUFVPaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUFVP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:29:45 -0400
Received: from holomorphy.com ([207.189.100.168]:36995 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264864AbUFVPRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:17:10 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [7/23] superh profiling cleanups
Message-ID: <0406220816.4a1a5aIb4aLb1a2a2aHbMbXa3aIb5a0a3aMb2aLbLb0aYaWaZaIbIb4a1aMb2a2a15250@holomorphy.com>
In-Reply-To: <0406220816.5a1aMb2aJbIbJbZa0a5aLbMbIb0a3aXaKb1aYa2aLbJbWa0a3aYaJb3aXaWaLb3a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert SuperH to use profiling_on() and profile_tick().

Index: prof-2.6.7/arch/sh/kernel/time.c
===================================================================
--- prof-2.6.7.orig/arch/sh/kernel/time.c	2004-06-15 22:18:37.000000000 -0700
+++ prof-2.6.7/arch/sh/kernel/time.c	2004-06-22 07:25:48.921725936 -0700
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/profile.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -235,32 +236,16 @@
 
 /* Profiling definitions */
 extern unsigned long prof_cpu_mask;
-extern unsigned int * prof_buffer;
-extern unsigned long prof_len;
-extern unsigned long prof_shift;
-extern char _stext;
 
 static inline void sh_do_profile(unsigned long pc)
 {
 	/* Don't profile cpu_idle.. */
-	if (!prof_buffer || !current->pid)
+	if (!profiling_on() || !current->pid)
 		return;
 
 	if (pc >= 0xa0000000UL && pc < 0xc0000000UL)
 		pc -= 0x20000000;
-
-	pc -= (unsigned long)&_stext;
-	pc >>= prof_shift;
-
-	/*
-	 * Don't ignore out-of-bounds PC values silently,
-	 * put them into the last histogram slot, so if
-	 * present, they will show up as a sharp peak.
-	 */
-	if (pc > prof_len - 1)
-		pc = prof_len - 1;
-
-	atomic_inc((atomic_t *)&prof_buffer[pc]);
+	profile_tick(pc);
 }
 
 /*
