Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161474AbWFWBLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161474AbWFWBLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 21:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161473AbWFWBLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:11:17 -0400
Received: from mga05.intel.com ([192.55.52.89]:59311 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030367AbWFWBLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:11:17 -0400
X-IronPort-AV: i="4.06,167,1149490800"; 
   d="scan'208"; a="57105418:sNHT3190969621"
Date: Thu, 22 Jun 2006 18:05:34 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org, ak@suse.de
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [Patch] apic: fix apic error on bootup
Message-ID: <20060622180534.A25240@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended patch fixes the "APIC error on CPUX: 00(40)" observed during bootup.

>From SDM Vol-3A "Valid Interrupt Vectors" section:
	"When an illegal vector value (0-15) is written to an LVT entry
	and the delivery mode is Fixed, the APIC may signal an illegal
	vector error, with out regard to whether the mask bit is set
	or whether an interrupt is actually seen on input."

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.17/arch/x86_64/kernel/apic.c~	2006-06-22 14:25:58.220025336 -0700
+++ linux-2.6.17/arch/x86_64/kernel/apic.c	2006-06-22 14:31:48.383792352 -0700
@@ -100,7 +100,7 @@ void clear_local_APIC(void)
 	maxlvt = get_maxlvt();
 
 	/*
-	 * Masking an LVT entry on a P6 can trigger a local APIC error
+	 * Masking an LVT entry can trigger a local APIC error
 	 * if the vector is zero. Mask LVTERR first to prevent this.
 	 */
 	if (maxlvt >= 3) {
@@ -850,7 +850,18 @@ void disable_APIC_timer(void)
 		unsigned long v;
 
 		v = apic_read(APIC_LVTT);
-		apic_write(APIC_LVTT, v | APIC_LVT_MASKED);
+		/*
+		 * When an illegal vector value (0-15) is written to an LVT
+		 * entry and delivery mode is Fixed, the APIC may signal an
+		 * illegal vector error, with out regard to whether the mask
+		 * bit is set or whether an interrupt is actually seen on input.
+		 *
+		 * Boot sequence might call this function when the LVTT has
+		 * '0' vector value. So make sure vector field is set to
+		 * valid value.
+		 */
+		v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
+		apic_write(APIC_LVTT, v);
 	}
 }
 
--- linux-2.6.17/arch/i386/kernel/apic.c~	2006-06-22 14:15:36.764500936 -0700
+++ linux-2.6.17/arch/i386/kernel/apic.c	2006-06-22 14:29:58.754458544 -0700
@@ -157,7 +157,7 @@ void clear_local_APIC(void)
 	maxlvt = get_maxlvt();
 
 	/*
-	 * Masking an LVT entry on a P6 can trigger a local APIC error
+	 * Masking an LVT entry can trigger a local APIC error
 	 * if the vector is zero. Mask LVTERR first to prevent this.
 	 */
 	if (maxlvt >= 3) {
@@ -1117,7 +1117,18 @@ void disable_APIC_timer(void)
 		unsigned long v;
 
 		v = apic_read(APIC_LVTT);
-		apic_write_around(APIC_LVTT, v | APIC_LVT_MASKED);
+		/*
+		 * When an illegal vector value (0-15) is written to an LVT
+		 * entry and delivery mode is Fixed, the APIC may signal an
+		 * illegal vector error, with out regard to whether the mask
+		 * bit is set or whether an interrupt is actually seen on input.
+		 *
+		 * Boot sequence might call this function when the LVTT has
+		 * '0' vector value. So make sure vector field is set to
+		 * valid value.
+		 */
+		v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
+		apic_write_around(APIC_LVTT, v);
 	}
 }
 
