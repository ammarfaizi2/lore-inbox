Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbVJGSBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbVJGSBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 14:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVJGSBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 14:01:23 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:64959 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030536AbVJGSBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 14:01:22 -0400
Date: Fri, 7 Oct 2005 11:01:19 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux ia64 kernel <linux-ia64@vger.kernel.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Fix 2.6 kernel for the new ia64 assembler
Message-ID: <20051007180119.GA11645@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The new ia64 assembler uses slot 1 for the offset of a long (2-slot)
instruction and the old assembler uses slot 2. The 2.6 kernel assumes
slot 2 and won't boot when the new assembler is used:

http://sources.redhat.com/bugzilla/show_bug.cgi?id=1433

This patch will work with either slot 1 or 2.


H.J.

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6-ia64-slo1-1.patch"

--- linux/arch/ia64/kernel/patch.c.slot	2004-10-18 14:54:39.000000000 -0700
+++ linux/arch/ia64/kernel/patch.c	2005-10-07 09:23:04.000000000 -0700
@@ -64,22 +64,30 @@ ia64_patch (u64 insn_addr, u64 mask, u64
 void
 ia64_patch_imm64 (u64 insn_addr, u64 val)
 {
-	ia64_patch(insn_addr,
+	/* The assembler may generate offset pointing to either slot 1
+	   or slot 2 for a long (2-slot) instruction, occupying slots 1
+	   and 2.  */
+  	insn_addr &= -16UL;
+	ia64_patch(insn_addr + 2,
 		   0x01fffefe000UL, (  ((val & 0x8000000000000000UL) >> 27) /* bit 63 -> 36 */
 				     | ((val & 0x0000000000200000UL) <<  0) /* bit 21 -> 21 */
 				     | ((val & 0x00000000001f0000UL) <<  6) /* bit 16 -> 22 */
 				     | ((val & 0x000000000000ff80UL) << 20) /* bit  7 -> 27 */
 				     | ((val & 0x000000000000007fUL) << 13) /* bit  0 -> 13 */));
-	ia64_patch(insn_addr - 1, 0x1ffffffffffUL, val >> 22);
+	ia64_patch(insn_addr + 1, 0x1ffffffffffUL, val >> 22);
 }
 
 void
 ia64_patch_imm60 (u64 insn_addr, u64 val)
 {
-	ia64_patch(insn_addr,
+	/* The assembler may generate offset pointing to either slot 1
+	   or slot 2 for a long (2-slot) instruction, occupying slots 1
+	   and 2.  */
+  	insn_addr &= -16UL;
+	ia64_patch(insn_addr + 2,
 		   0x011ffffe000UL, (  ((val & 0x0800000000000000UL) >> 23) /* bit 59 -> 36 */
 				     | ((val & 0x00000000000fffffUL) << 13) /* bit  0 -> 13 */));
-	ia64_patch(insn_addr - 1, 0x1fffffffffcUL, val >> 18);
+	ia64_patch(insn_addr + 1, 0x1fffffffffcUL, val >> 18);
 }
 
 /*

--82I3+IH0IqGh5yIs--
