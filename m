Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWJEEmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWJEEmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWJEEmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:42:20 -0400
Received: from lixom.net ([66.141.50.11]:4505 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1750806AbWJEEmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:42:17 -0400
Date: Wed, 4 Oct 2006 23:41:41 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Enable DEEPNAP power savings mode on 970MP
Message-ID: <20061004234141.749b13fb@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Without this patch, on an idle system I get:

cpu-power-0:21.638
cpu-power-1:27.102
cpu-power-2:29.343
cpu-power-3:25.784
Total: 103.8W

With this patch:

cpu-power-0:11.730
cpu-power-1:17.185
cpu-power-2:18.547
cpu-power-3:17.528
Total: 65.0W

If I lower HZ to 100, I can get it as low as:

cpu-power-0:10.938
cpu-power-1:16.021
cpu-power-2:17.245
cpu-power-3:16.145
Total: 60.2W

Another (older) Quad G5 went from 54W to 39W at HZ=250.

Coming back out of Deep Nap takes 40-70 cycles longer than coming back
from just Nap (which already takes quite a while). I don't think it'll
be a performance issue (interrupt latency on an idle system), but in
case someone does measurements feel free to report them.


Signed-off-by: Olof Johansson <olof@lixom.net>



Index: linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_ppc970.S
+++ linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
@@ -83,6 +83,22 @@ _GLOBAL(__setup_cpu_ppc970)
 	rldimi	r0,r11,52,8		/* set NAP and DPM */
 	li	r11,0
 	rldimi	r0,r11,32,31		/* clear EN_ATTN */
+	b	load_hids		/* Jump to shared code */
+
+
+_GLOBAL(__setup_cpu_ppc970MP)
+	/* Do nothing if not running in HV mode */
+	mfmsr	r0
+	rldicl.	r0,r0,4,63
+	beqlr
+
+	mfspr	r0,SPRN_HID0
+	li	r11,0x15		/* clear DOZE and SLEEP */
+	rldimi	r0,r11,52,6		/* set DEEPNAP, NAP and DPM */
+	li	r11,0
+	rldimi	r0,r11,32,31		/* clear EN_ATTN */
+
+load_hids:
 	mtspr	SPRN_HID0,r0
 	mfspr	r0,SPRN_HID0
 	mfspr	r0,SPRN_HID0
Index: linux-2.6/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6/arch/powerpc/kernel/cputable.c
@@ -41,6 +41,7 @@ extern void __setup_cpu_745x(unsigned lo
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_PPC64
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_ppc970(void);
 #endif /* CONFIG_PPC64 */
 
@@ -221,7 +222,7 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_ppc970,
+		.cpu_setup		= __setup_cpu_ppc970MP,
 		.cpu_restore		= __restore_cpu_ppc970,
 		.oprofile_cpu_type	= "ppc64/970",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
