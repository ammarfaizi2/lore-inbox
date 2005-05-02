Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVEBG1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVEBG1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 02:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVEBG1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 02:27:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:38048 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261792AbVEBG1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 02:27:15 -0400
Subject: [PATCH] cpufreq annoying warning fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Mon, 02 May 2005 16:25:10 +1000
Message-Id: <1115015110.6030.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The cpufreq core patch I sent earlier got only half-applied. I added a
flag to let the low level driver disable an annoying warning on
suspend/resume that is normal on ppc, but the "resume" part of it wasn't
applied. This patch just adds back that missing bit. The original patch
also reworked the resume() function to avoid nesting too many if ()
statements along the way I did the suspend() one, but I didn't include
that in the patch below.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-work.orig/drivers/cpufreq/cpufreq.c	2005-05-02 10:48:09.000000000 +1000
+++ linux-work/drivers/cpufreq/cpufreq.c	2005-05-02 16:21:23.000000000 +1000
@@ -1003,9 +1003,10 @@
 		if (unlikely(cur_freq != cpu_policy->cur)) {
 			struct cpufreq_freqs freqs;
 
-			printk(KERN_WARNING "Warning: CPU frequency is %u, "
-					"cpufreq assumed %u kHz.\n",
-					cur_freq, cpu_policy->cur);
+			if (!(cpufreq_driver->flags & CPUFREQ_PM_NO_WARN))
+				printk(KERN_WARNING "Warning: CPU frequency"
+				       "is %u, cpufreq assumed %u kHz.\n",
+				       cur_freq, cpu_policy->cur);
 
 			freqs.cpu = cpu;
 			freqs.old = cpu_policy->cur;


