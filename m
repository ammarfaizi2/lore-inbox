Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVD1CZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVD1CZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 22:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVD1CZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 22:25:23 -0400
Received: from fmr17.intel.com ([134.134.136.16]:49043 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261724AbVD1CZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 22:25:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH]fix warning in porting lockless mce from x86_64 to i386
Date: Thu, 28 Apr 2005 10:24:28 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750162F6E7@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]fix warning in porting lockless mce from x86_64 to i386
Thread-Index: AcVLWE2VYsn8ZbmCQRG0lTauO5tuugAPmJ3w
From: "Guo, Racing" <racing.guo@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>
Cc: "Yu, Luming" <luming.yu@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Apr 2005 02:24:29.0346 (UTC) FILETIME=[67CC7820:01C54B99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning in porting lockless mce from x86_64 to i386
1. fix warning in set_bit
2. declare mcheck_init function
3. change to "fastcall" before do_machine_check

Signed-off-by: Guo, Racing <racing.guo@intel.com>
---

mce.c |   14 +++++++-------
mce.h |    1 +
2 files changed, 8 insertions(+), 7 deletions(-)

diff -rNu
linux-2.6.11.6-move-files-mce/arch/i386/kernel/cpu/mcheck/mce.c
linux-2.6.11.6-move-files-mce-fix/arch/i386/kernel/cpu/mcheck/mce.c
--- linux-2.6.11.6-move-files-mce/arch/i386/kernel/cpu/mcheck/mce.c
2005-04-27 13:58:33.000000000 +0800
+++ linux-2.6.11.6-move-files-mce-fix/arch/i386/kernel/cpu/mcheck/mce.c
2005-04-28 10:02:09.386327560 +0800
@@ -56,7 +56,12 @@
 		/* When the buffer fills up discard new entries. Assume 
 		   that the earlier errors are the more interesting. */
 		if (entry >= MCE_LOG_LEN) {
-			set_bit(MCE_OVERFLOW, &mcelog.flags);
+			/* cast &mcelog.flags to (unsigned long *) in
order
+			   to prevent compiler warning. It is OK to cast
+			   (unsigned *) to (unsigned long *) in set_bit
on 
+			   little-endian machine
+			 */
+			set_bit(MCE_OVERFLOW, (unsigned long
*)&mcelog.flags);
 			return;
 		}
 		/* Old left over entry. Skip. */
@@ -131,12 +136,7 @@
 /* 
  * The actual machine check handler
  */
-#ifdef CONFIG_X86_64
-asmlinkage
-#else
-fastcall
-#endif
-void do_machine_check(struct pt_regs * regs, long error_code)
+fastcall void do_machine_check(struct pt_regs * regs, long error_code)
 {
 	struct mce m, panicm;
 	int nowayout = (tolerant < 1); 
diff -rNu
linux-2.6.11.6-move-files-mce/arch/i386/kernel/cpu/mcheck/mce.h
linux-2.6.11.6-move-files-mce-fix/arch/i386/kernel/cpu/mcheck/mce.h
--- linux-2.6.11.6-move-files-mce/arch/i386/kernel/cpu/mcheck/mce.h
2005-04-12 17:29:57.000000000 +0800
+++ linux-2.6.11.6-move-files-mce-fix/arch/i386/kernel/cpu/mcheck/mce.h
2005-04-28 10:02:09.386327560 +0800
@@ -68,6 +68,7 @@
 #define MCE_EXTENDED_BANK	128
 #define MCE_THERMAL_BANK	MCE_EXTENDED_BANK + 0
 
+void __init mcheck_init(struct cpuinfo_x86 *c);
 void mce_log(struct mce *m);
 #ifdef CONFIG_X86_MCE_INTEL
 void mce_intel_feature_init(struct cpuinfo_x86 *c);
