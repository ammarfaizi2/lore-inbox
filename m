Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbUCZLsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUCZLsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:48:08 -0500
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:57096 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S264032AbUCZLsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:48:01 -0500
Date: Fri, 26 Mar 2004 12:47:39 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-fbdev-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Radeon 7000 problems with kernels after 2.6.3
Message-ID: <20040326114739.GA32596@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On recent kernel (2.6.4 and later) my Radeon 7000 doesn't display
anything. My Eizo monitor warns me of really incompatible frequencies
(fV 217.2 Hz, fH 271.5 kHz). fbset returns normal values, by the way.

I've found out that this chunk in patch-2.6.4, applying to
drivers/video/aty/radeon_base.c, causes my problems:

@@ -1329,6 +1320,16 @@
         * not sure which model starts having FP2_GEN_CNTL, I assume anything more
         * recent than an r(v)100...
         */
+#if 0
+       /* XXX I had reports of flicker happening with the cinema display
+        * on TMDS1 that seem to be fixed if I also forbit odd dividers in
+        * this case. This could just be a bandwidth calculation issue, I
+        * haven't implemented the bandwidth code yet, but in the meantime,
+        * forcing uses_dvo to 1 fixes it and shouln't have bad side effects,
+        * I haven't seen a case were were absolutely needed an odd PLL
+        * divider. I'll find a better fix once I have more infos on the
+        * real cause of the problem.
+        */
        while (rinfo->has_CRTC2) {
                u32 fp2_gen_cntl = INREG(FP2_GEN_CNTL);
                u32 disp_output_cntl;
@@ -1362,6 +1363,9 @@
                uses_dvo = 1;
                break;
        }
+#else
+       uses_dvo = 1;
+#endif
        if (freq > rinfo->pll.ppll_max)
                freq = rinfo->pll.ppll_max;
        if (freq*12 < rinfo->pll.ppll_min)

If I change that #if 0 to #if 1, I get a normal image. This is with the
following video-card:

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7200] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon 7000/Radeon
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 16
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at a000 [size=256]
        Memory at e5000000 (32-bit, non-prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2


I've seen other messages about problems with radeonfb. Can other people
confirm this problem, and confirm that removing this chunk fixes the
problem?


Kind regards,
Jurriaan
-- 
Don't like these taglines? Steal your own...
Debian (Unstable) GNU/Linux 2.6.5-rc2-mm3 3940 bogomips 0.18 0.28
