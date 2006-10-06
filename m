Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWJFCRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWJFCRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 22:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWJFCRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 22:17:49 -0400
Received: from lixom.net ([66.141.50.11]:59099 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751643AbWJFCRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 22:17:48 -0400
Date: Thu, 5 Oct 2006 21:16:48 -0500
From: Olof Johansson <olof@lixom.net>
To: galak@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       vbordug@ru.mvista.com
Subject: [PATCH] powerpc: fix fsl_soc build breaks
Message-ID: <20061005211648.0d550152@pb15>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.20; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm, there's no way this ever built at time of merge. There's a missing } and
the wrong type on phy_irq.

Also, another const for get_property().


  CC      arch/powerpc/sysdev/fsl_soc.o
arch/powerpc/sysdev/fsl_soc.c: In function 'fs_enet_of_init':
arch/powerpc/sysdev/fsl_soc.c:625: error: assignment of read-only variable 'phy_irq'
arch/powerpc/sysdev/fsl_soc.c:625: warning: assignment makes integer from pointer without a cast
arch/powerpc/sysdev/fsl_soc.c:661: warning: assignment discards qualifiers from pointer target type
arch/powerpc/sysdev/fsl_soc.c:684: error: subscripted value is neither array nor pointer
arch/powerpc/sysdev/fsl_soc.c:687: error: subscripted value is neither array nor pointer
arch/powerpc/sysdev/fsl_soc.c:722: warning: ISO C90 forbids mixed declarations and code
arch/powerpc/sysdev/fsl_soc.c:728: error: invalid storage class for function 'cpm_uart_of_init'
arch/powerpc/sysdev/fsl_soc.c:798: error: initializer element is not constant
arch/powerpc/sysdev/fsl_soc.c:798: error: expected declaration or statement at end of input
make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1


Signed-off-by: Olof Johansson <olof@lixom.net>


---

There are more issues with this file. Whitespace, if () {}; and other
things. I'm just fixing the build breaks.

These were all introduced by patches fed upstream via git trees instead
of list posts, as far as I can tell. Maybe posting patches is a better
idea, more eyes on the code.


Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c
+++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c
@@ -567,7 +567,7 @@ static int __init fs_enet_of_init(void)
 		struct resource r[4];
 		struct device_node *phy, *mdio;
 		struct fs_platform_info fs_enet_data;
-		const unsigned int *id, *phy_addr, phy_irq;
+		const unsigned int *id, *phy_addr, *phy_irq;
 		const void *mac_addr;
 		const phandle *ph;
 		const char *model;
@@ -641,7 +641,7 @@ static int __init fs_enet_of_init(void)
 
 		if (strstr(model, "FCC")) {
 			int fcc_index = *id - 1;
-			unsigned char* mdio_bb_prop;
+			const unsigned char *mdio_bb_prop;
 
 			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
 			fs_enet_data.rx_ring = 32;
@@ -708,8 +708,9 @@ static int __init fs_enet_of_init(void)
 			ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
 						     sizeof(struct
 							    fs_platform_info));
-		if (ret)
-			goto unreg;
+			if (ret)
+				goto unreg;
+		}
 	}
 	return 0;
 
