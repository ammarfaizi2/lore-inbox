Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUDEPuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUDEPuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 11:50:23 -0400
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:46492 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262870AbUDEPuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 11:50:17 -0400
Date: Mon, 5 Apr 2004 17:50:12 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: davej@codemonkey.org.uk, cpufreq@www.linux.org.uk, linux@brodo.de
Subject: [PATCH 2.6] cpufreq longrun driver fix
Message-ID: <20040405155012.GI2718@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk, cpufreq@www.linux.org.uk, linux@brodo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My TM5600 Crusoe processor, found inside a Sony Vaio C1VE laptop,
does not work with the longrun cpufreq driver.

Upon investigation, the reason is that trying to set the performance 
to 80% in longrun_determine_freqs leaves the performance to 100%.
The performance level, at least on this particular model, can be lowered
only in 33% steps. And in order to put the performance to 66%, the
code should try to set the barrier to 70%.

The following patch does even more, it tries every value from 80%
to 10% in 10% steps, until it succeeds in lowering the performance.
I'm not sure this is the best way to do it but in any case, 
it works for me (and should continue to work for everybody else).

Stelian.

===== arch/i386/kernel/cpu/cpufreq/longrun.c 1.18 vs edited =====
--- 1.18/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu Feb 19 03:48:38 2004
+++ edited/arch/i386/kernel/cpu/cpufreq/longrun.c	Mon Apr  5 17:06:12 2004
@@ -142,6 +142,7 @@
 	u32 msr_lo, msr_hi;
 	u32 save_lo, save_hi;
 	u32 eax, ebx, ecx, edx;
+	u32 try_hi;
 	struct cpuinfo_x86 *c = cpu_data;
 
 	if (!low_freq || !high_freq)
@@ -184,12 +185,14 @@
 	 * upper limit to make the calculation more accurate.
 	 */
 	cpuid(0x80860007, &eax, &ebx, &ecx, &edx);
-	if (ecx > 90) {
-		/* set to 0 to 80 perf_pctg */
+	/* try decreasing in 10% steps, some processors react only
+	 * on some barrier values */
+	for (try_hi = 80; try_hi > 0 && ecx > 90; try_hi -=10) {
+		/* set to 0 to try_hi perf_pctg */
 		msr_lo &= 0xFFFFFF80;
 		msr_hi &= 0xFFFFFF80;
 		msr_lo |= 0;
-		msr_hi |= 80;
+		msr_hi |= try_hi;
 		wrmsr(MSR_TMTA_LONGRUN_CTRL, msr_lo, msr_hi);
 
 		/* read out current core MHz and current perf_pctg */
-- 
Stelian Pop <stelian@popies.net>
