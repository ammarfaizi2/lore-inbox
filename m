Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWA0WvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWA0WvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWA0WvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:51:07 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:53899 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422650AbWA0Wuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:50:54 -0500
Date: Sat, 28 Jan 2006 00:50:53 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/11] sh: Make peripheral clock frequency setting mandatory.
Message-ID: <20060127225053.GC30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty much every subtype does this now anyways, and as we depend
on it in a few places being set to something sensible quite early
on, it's better for a new subtype to simply set a sensible default.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/Kconfig            |    6 ------
 arch/sh/kernel/cpu/clock.c |   13 +------------
 2 files changed, 1 insertions(+), 18 deletions(-)

e3efa1355438864fd56f850604722dc62d2aaa1b
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 01bc7d5..504d56f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -396,14 +396,8 @@ source "arch/sh/boards/renesas/hs7751rvo
 
 source "arch/sh/boards/renesas/rts7751r2d/Kconfig"
 
-config SH_PCLK_FREQ_BOOL
-	bool "Set default pclk frequency"
-	default y if !SH_RTC
-	default n
-
 config SH_PCLK_FREQ
 	int "Peripheral clock frequency (in Hz)"
-	depends on SH_PCLK_FREQ_BOOL
 	default "50000000" if CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7780
 	default "60000000" if CPU_SUBTYPE_SH7751
 	default "33333333" if CPU_SUBTYPE_SH7300 || CPU_SUBTYPE_SH7770 || CPU_SUBTYPE_SH7760
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 989e7fd..97fa37f 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -38,9 +38,7 @@ static DECLARE_MUTEX(clock_list_sem);
 static struct clk master_clk = {
 	.name		= "master_clk",
 	.flags		= CLK_ALWAYS_ENABLED | CLK_RATE_PROPAGATES,
-#ifdef CONFIG_SH_PCLK_FREQ_BOOL
 	.rate		= CONFIG_SH_PCLK_FREQ,
-#endif
 };
 
 static struct clk module_clk = {
@@ -227,16 +225,7 @@ int __init clk_init(void)
 {
 	int i, ret = 0;
 
-	if (unlikely(!master_clk.rate))
-		/*
-		 * NOTE: This will break if the default divisor has been
-		 * changed.
-		 *
-		 * No one should be changing the default on us however,
-		 * expect that a sane value for CONFIG_SH_PCLK_FREQ will
-		 * be defined in the event of a different divisor.
-		 */
-		master_clk.rate = get_timer_frequency() * 4;
+	BUG_ON(unlikely(!master_clk.rate));
 
 	for (i = 0; i < ARRAY_SIZE(onchip_clocks); i++) {
 		struct clk *clk = onchip_clocks[i];
