Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760812AbWLHS0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760812AbWLHS0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 13:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760815AbWLHS0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:26:13 -0500
Received: from mga05.intel.com ([192.55.52.89]:44328 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760812AbWLHS0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:26:11 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,515,1157353200"; 
   d="scan'208"; a="174954889:sNHT58881109"
Date: Fri, 8 Dec 2006 10:00:04 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, "Li, Shaohua" <shaohua.li@intel.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: What was in the x86 merge for .20
Message-ID: <20061208100004.D31153@unix-os.sc.intel.com>
References: <200612080401.25746.ak@suse.de> <20061208020804.c5e5e176.akpm@osdl.org> <20061208084124.C31153@unix-os.sc.intel.com> <200612081810.29792.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200612081810.29792.ak@suse.de>; from ak@suse.de on Fri, Dec 08, 2006 at 06:10:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 06:10:29PM +0100, Andi Kleen wrote:
> Yes please check the mainline git tree.

Ok. I think I am the culprit :(

Andi, Attached patch should fix the panic issue that Andrew encountered.
Andrew, please confirm.

Andi, if you are applying Ingo's genapic changes and reverting this quirk
changes in git, then there is no need to apply the appended patch.

Personally, I would like to go with Ingo's changes as it cleans up quite 
a bit of code.

thanks,
suresh
--

[patch] i386: Fix the verify_quirk_intel_irqbalance()

Fix the verify_quirk_intel_irqbalance(). genapic checks should really
happen only on affected versions of the E7520/E7320/E7525 based platforms.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

diff --git a/arch/i386/kernel/quirks.c b/arch/i386/kernel/quirks.c
index a01320a..34874c3 100644
--- a/arch/i386/kernel/quirks.c
+++ b/arch/i386/kernel/quirks.c
@@ -10,13 +10,38 @@ #include <asm/cpu.h>
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 static void __devinit verify_quirk_intel_irqbalance(struct pci_dev *dev)
 {
+	u8 config, rev;
+	u32 word;
+
+	/* BIOS may enable hardware IRQ balancing for
+	 * E7520/E7320/E7525(revision ID 0x9 and below)
+	 * based platforms.
+	 * For those platforms, make sure that the genapic is set to 'flat'
+	 */
+	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
+	if (rev > 0x9)
+		return;
+
+	/* enable access to config space*/
+	pci_read_config_byte(dev, 0xf4, &config);
+	pci_write_config_byte(dev, 0xf4, config|0x2);
+
+	/* read xTPR register */
+	raw_pci_ops->read(0, 0, 0x40, 0x4c, 2, &word);
+
+	if (!(word & (1 << 13))) {
 #ifdef CONFIG_X86_64
-	if (genapic !=  &apic_flat)
-		panic("APIC mode must be flat on this system\n");
+		if (genapic !=  &apic_flat)
+			panic("APIC mode must be flat on this system\n");
 #elif defined(CONFIG_X86_GENERICARCH)
-	if (genapic != &apic_default)
-		panic("APIC mode must be default(flat) on this system. Use apic=default\n");
+		if (genapic != &apic_default)
+			panic("APIC mode must be default(flat) on this system. Use apic=default\n");
 #endif
+	}
+
+	/* put back the original value for config space*/
+	if (!(config & 0x2))
+		pci_write_config_byte(dev, 0xf4, config);
 }
 
 void __init quirk_intel_irqbalance(void)
