Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUCCXgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUCCXgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:36:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:22982 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261255AbUCCXgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:36:03 -0500
Subject: [PATCH] radeonfb: some more PLL problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078356251.15324.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 10:24:11 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've had reports of flicker that appear with large (23") flat panels
and radeonfb. From experiments, it appears that forbiding the "odd"
PLL divider values fix it (like it fixes the blur problem on TMDS2).
There should not be anything special with TMDS1 and "odd" PLL values
though, so the problem may be subtely different (a bandwidth problem),
but until I have proper bandwidth calculation and access to this
monitor, the following patch is an acceptable workaround
(Odd PLL values aren't that useful anyway)

===== drivers/video/aty/radeon_base.c 1.8 vs edited =====
--- 1.8/drivers/video/aty/radeon_base.c	Wed Feb 18 17:02:05 2004
+++ edited/drivers/video/aty/radeon_base.c	Thu Mar  4 10:16:41 2004
@@ -1329,6 +1329,16 @@
 	 * not sure which model starts having FP2_GEN_CNTL, I assume anything more
 	 * recent than an r(v)100...
 	 */
+#if 0
+	/* XXX I had reports of flicker happening with the cinema display
+	 * on TMDS1 that seem to be fixed if I also forbit odd dividers in
+	 * this case. This could just be a bandwidth calculation issue, I
+	 * haven't implemented the bandwidth code yet, but in the meantime,
+	 * forcing uses_dvo to 1 fixes it and shouln't have bad side effects,
+	 * I haven't seen a case were were absolutely needed an odd PLL
+	 * divider. I'll find a better fix once I have more infos on the
+	 * real cause of the problem.
+	 */
 	while (rinfo->has_CRTC2) {
 		u32 fp2_gen_cntl = INREG(FP2_GEN_CNTL);
 		u32 disp_output_cntl;
@@ -1362,6 +1372,9 @@
 		uses_dvo = 1;
 		break;
 	}
+#else
+	use_dvo = 1;
+#endif
 	if (freq > rinfo->pll.ppll_max)
 		freq = rinfo->pll.ppll_max;
 	if (freq*12 < rinfo->pll.ppll_min)


