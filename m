Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVCRRVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVCRRVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVCRRVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:21:01 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:14759 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261997AbVCRRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:20:38 -0500
Date: Fri, 18 Mar 2005 12:20:35 -0500
From: Jason Davis <jason@rightthere.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, natalie.protasevich@unisys.com,
       jason.davis@unisys.com
Subject: Re: [PATCH] ES7000 Legacy Mappings Update
Message-ID: <20050318172035.GA23140@righTThere.net>
References: <20050314183533.GA28889@righTThere.net> <20050314180554.10455185.akpm@osdl.org> <20050315152756.GA28799@righTThere.net> <20050315113746.2484c773.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20050315113746.2484c773.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is an update to the ES7000 Legacy Mappings patch.

---------------------------------------------------------------------

This update only affects Unisys' ES7000 machines. The patch reflects a change needed to determine which generation of ES7000 is currently running. The next generation of ES7000s will have conventional legacy support so the patch accommodates for this. This patch has been tested and verified on both an authentic 5xx ES7000 box and the next generation ES7000 box.

Signed-off-by: Natalie Protasevich <natalie.protasevich@unisys.com>
Signed-off-by: Jason Davis <jason.davis@unisys.com>

diff -Nuarp linux-2.6.11.3/arch/i386/kernel/mpparse.c linux-2.6.11.3-legacy/arch/i386/kernel/mpparse.c
--- linux-2.6.11.3/arch/i386/kernel/mpparse.c	2005-03-13 01:44:19.000000000 -0500
+++ linux-2.6.11.3-legacy/arch/i386/kernel/mpparse.c	2005-03-18 11:19:10.000000000 -0500
@@ -996,9 +996,9 @@ void __init mp_config_acpi_legacy_irqs (
 	Dprintk("Bus #%d is ISA\n", MP_ISA_BUS);
 
 	/*
-	 * ES7000 has no legacy identity mappings
+	 * Older generations of ES7000 have no legacy identity mappings
 	 */
-	if (es7000_plat)
+	if (es7000_plat == 1) 
 		return;
 
 	/* 
diff -Nuarp linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c	2005-03-13 01:44:41.000000000 -0500
+++ linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c	2005-03-18 11:00:03.000000000 -0500
@@ -138,7 +138,19 @@ parse_unisys_oem (char *oemptr, int oem_
 		es7000_plat = 0;
 	} else {
 		printk("\nEnabling ES7000 specific features...\n");
-		es7000_plat = 1;
+		/*
+		 * Determine the generation of the ES7000 currently running.
+		 * 
+		 * es7000_plat = 0 if the machine is NOT a Unisys ES7000 box
+		 * es7000_plat = 1 if the machine is a 5xx ES7000 box
+		 * es7000_plat = 2 if the machine is a x86_64 ES7000 box
+		 *
+		 */
+		if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
+			es7000_plat = 2;
+		else
+			es7000_plat = 1;
+
 		ioapic_renumber_irq = es7000_rename_gsi;
 	}
 	return es7000_plat;
