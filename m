Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUDSRbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUDSRbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:31:45 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:12039 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S261528AbUDSRbm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:31:42 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] 2.6.5- es7000 subarch update
Date: Mon, 19 Apr 2004 12:30:23 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04C551F0@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.5- es7000 subarch update
thread-index: AcQboKLug29YRjVkT9O6a1N/TXiS8QJ6/0gA
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andrew Morton" <akpm@osdl.org>, "Len Brown" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Zwane Mwaikambo" <zwane@linuxpower.ca>
X-OriginalArrivalTime: 19 Apr 2004 17:30:24.0005 (UTC) FILETIME=[FF34BB50:01C42633]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I am re-submitting the patch for ES7000. It only contains changes that ES7000 subarch-specific and allow the system to boot.
The IRQ override portion has transformed into a separate patch by Len Brown which corrects the problem properly. Thanks to Len and also to Zwane, and Andrew who helped resolve this issue for systems like ES7000 that rely on this code.

Regards,
--Natalie

-------------------------------------------------------------------------------------------------------------------

diff -Naur linux6.5/arch/i386/mach-es7000/es7000.c linux265/arch/i386/mach-es7000/es7000.c
--- linux6.5/arch/i386/mach-es7000/es7000.c	2004-04-04 18:22:39.000000000 -0400
+++ linux265/arch/i386/mach-es7000/es7000.c	2004-04-14 23:08:42.000000000 -0400
@@ -83,6 +83,7 @@
 			host = (struct mip_reg *)val;
 			host_reg = __va(host);
 			val = MIP_RD_LO(mi->mip_reg);
+			mip_port = MIP_PORT(mi->mip_info);
 			mip_addr = val;
 			mip = (struct mip_reg *)val;
 			mip_reg = __va(mip);
diff -Naur linux6.5/arch/i386/mach-es7000/es7000.h linux265/arch/i386/mach-es7000/es7000.h
--- linux6.5/arch/i386/mach-es7000/es7000.h	2004-04-04 18:22:39.000000000 -0400
+++ linux265/arch/i386/mach-es7000/es7000.h	2004-04-14 23:10:51.000000000 -0400
@@ -30,6 +30,7 @@
 #define	MIP_BUSY		1
 #define	MIP_SPIN		0xf0000
 #define	MIP_VALID		0x0100000000000000
+#define	MIP_PORT(VALUE)	((VALUE >> 32) & 0xffff)
 
 #define	MIP_RD_LO(VALUE)	(VALUE & 0xffffffff)   
 
diff -Naur linux6.5/include/asm-i386/mach-es7000/mach_apic.h linux265/include/asm-i386/mach-es7000/mach_apic.h
--- linux6.5/include/asm-i386/mach-es7000/mach_apic.h	2004-04-04 18:22:46.000000000 -0400
+++ linux265/include/asm-i386/mach-es7000/mach_apic.h	2004-04-14 23:05:24.000000000 -0400
@@ -39,7 +39,7 @@
 #endif
 
 #define APIC_BROADCAST_ID	(0xff)
-#define NO_IOAPIC_CHECK (0)
+#define NO_IOAPIC_CHECK (1)
 
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 { 
@@ -169,7 +169,11 @@
 	num_bits_set = cpus_weight_const(cpumask);
 	/* Return id to all */
 	if (num_bits_set == NR_CPUS)
+#if defined CONFIG_ES7000_CLUSTERED_APIC
 		return 0xFF;
+#else
+		return cpu_to_logical_apicid(0);
+#endif
 	/* 
 	 * The cpus in the mask must all be on the apic cluster.  If are not 
 	 * on the same apicid cluster return default value of TARGET_CPUS. 
@@ -182,7 +186,11 @@
 			if (apicid_cluster(apicid) != 
 					apicid_cluster(new_apicid)){
 				printk ("%s: Not a valid mask!\n",__FUNCTION__);
+#if defined CONFIG_ES7000_CLUSTERED_APIC
 				return 0xFF;
+#else
+				return cpu_to_logical_apicid(0);
+#endif
 			}
 			apicid = new_apicid;
 			cpus_found++;

----------------------------------------------------------------------------------------------------------------
