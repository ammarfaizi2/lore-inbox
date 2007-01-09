Return-Path: <linux-kernel-owner+w=401wt.eu-S932090AbXAITZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbXAITZ3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbXAITZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:25:29 -0500
Received: from mga07.intel.com ([143.182.124.22]:44657 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932090AbXAITZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:25:28 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="167027380:sNHT20832322"
Date: Tue, 9 Jan 2007 10:52:31 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] Handle 32 bit PerfMon Counter writes cleanly in oprofile
Message-ID: <20070109105230.C20238@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Handle these 32 bit perfmon counter MSR writes cleanly in oprofile.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.20-rc-mm/arch/i386/oprofile/op_model_ppro.c
===================================================================
--- linux-2.6.20-rc-mm.orig/arch/i386/oprofile/op_model_ppro.c
+++ linux-2.6.20-rc-mm/arch/i386/oprofile/op_model_ppro.c
@@ -24,7 +24,8 @@
 
 #define CTR_IS_RESERVED(msrs,c) (msrs->counters[(c)].addr ? 1 : 0)
 #define CTR_READ(l,h,msrs,c) do {rdmsr(msrs->counters[(c)].addr, (l), (h));} while (0)
-#define CTR_WRITE(l,msrs,c) do {wrmsr(msrs->counters[(c)].addr, -(u32)(l), -1);} while (0)
+#define CTR_32BIT_WRITE(l,msrs,c)	\
+	do {wrmsr(msrs->counters[(c)].addr, -(u32)(l), 0);} while (0)
 #define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
 
 #define CTRL_IS_RESERVED(msrs,c) (msrs->controls[(c)].addr ? 1 : 0)
@@ -79,7 +80,7 @@ static void ppro_setup_ctrs(struct op_ms
 	for (i = 0; i < NUM_COUNTERS; ++i) {
 		if (unlikely(!CTR_IS_RESERVED(msrs,i)))
 			continue;
-		CTR_WRITE(1, msrs, i);
+		CTR_32BIT_WRITE(1, msrs, i);
 	}
 
 	/* enable active counters */
@@ -87,7 +88,7 @@ static void ppro_setup_ctrs(struct op_ms
 		if ((counter_config[i].enabled) && (CTR_IS_RESERVED(msrs,i))) {
 			reset_value[i] = counter_config[i].count;
 
-			CTR_WRITE(counter_config[i].count, msrs, i);
+			CTR_32BIT_WRITE(counter_config[i].count, msrs, i);
 
 			CTRL_READ(low, high, msrs, i);
 			CTRL_CLEAR(low);
@@ -116,7 +117,7 @@ static int ppro_check_ctrs(struct pt_reg
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
 			oprofile_add_sample(regs, i);
-			CTR_WRITE(reset_value[i], msrs, i);
+			CTR_32BIT_WRITE(reset_value[i], msrs, i);
 		}
 	}
 
