Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVCNSg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVCNSg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVCNSgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:36:24 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:64145 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261679AbVCNSfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:35:34 -0500
Date: Mon, 14 Mar 2005 13:35:33 -0500
From: Jason Davis <jason@righTThere.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Natalie Protasevich <natalie.protasevich@unisys.com>,
       Jason Davis <jason.davis@unisys.com>
Subject: [PATCH] ES7000 Legacy Mappings Update
Message-ID: <20050314183533.GA28889@righTThere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

This update only affects Unisys' ES7000 machines. The patch reflects a change needed to determine which generation of ES7000 is currently running. The next generation of ES7000s will have conventional legacy support so the patch accommodates for this. This patch has been tested and verified on both an authentic 5xx ES7000 box and the next generation ES7000 box.

Thanks,
Jason Davis


diff -Naurp linux-2.6.11.3/arch/i386/kernel/mpparse.c linux-2.6.11.3-legacy/arch/i386/kernel/mpparse.c
--- linux-2.6.11.3/arch/i386/kernel/mpparse.c	2005-03-13 01:44:19.000000000 -0500
+++ linux-2.6.11.3-legacy/arch/i386/kernel/mpparse.c	2005-03-14 11:52:44.000000000 -0500
@@ -996,9 +996,9 @@ void __init mp_config_acpi_legacy_irqs (
 	Dprintk("Bus #%d is ISA\n", MP_ISA_BUS);
 
 	/*
-	 * ES7000 has no legacy identity mappings
+	 * Older generations of ES7000 have no legacy identity mappings
 	 */
-	if (es7000_plat)
+	if (es7000_plat && es7000_plat < 2) 
 		return;
 
 	/* 
diff -Naurp linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c	2005-03-13 01:44:41.000000000 -0500
+++ linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c	2005-03-14 11:52:44.000000000 -0500
@@ -138,7 +138,14 @@ parse_unisys_oem (char *oemptr, int oem_
 		es7000_plat = 0;
 	} else {
 		printk("\nEnabling ES7000 specific features...\n");
-		es7000_plat = 1;
+		/*
+		 * Check to see if this is a x86_64 ES7000 machine.
+		 */
+		if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
+			es7000_plat = 2;
+		else
+			es7000_plat = 1;
+
 		ioapic_renumber_irq = es7000_rename_gsi;
 	}
 	return es7000_plat;
