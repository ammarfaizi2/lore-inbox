Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVCCTsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVCCTsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVCCTqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:46:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:25306 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261599AbVCCTmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:42:42 -0500
Date: Thu, 3 Mar 2005 13:36:30 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: akpm@osdl.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] offb remapped address
Message-Id: <20050303133630.618614df.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The offb code did not take into account a remapped pci address.  Adding
in the pci_mem_offset fixed a DSI in offb.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN drivers/video/offb.c~offb_dsi drivers/video/offb.c
--- linux-2.6.11/drivers/video/offb.c~offb_dsi	Wed Mar  2 15:03:49 2005
+++ linux-2.6.11-moilanen/drivers/video/offb.c	Wed Mar  2 15:40:41 2005
@@ -29,6 +29,10 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 
+#ifdef CONFIG_PPC64
+#include <asm/pci-bridge.h>
+#endif
+
 #ifdef CONFIG_PPC32
 #include <asm/bootx.h>
 #endif
@@ -322,7 +326,8 @@ static void __init offb_init_nodriver(st
 	int *pp, i;
 	unsigned int len;
 	int width = 640, height = 480, depth = 8, pitch;
-	unsigned *up, address;
+	unsigned *up;
+	unsigned long address;
 
 	if ((pp = (int *) get_property(dp, "depth", &len)) != NULL
 	    && len == sizeof(int))
@@ -357,6 +362,10 @@ static void __init offb_init_nodriver(st
 
 		address = (u_long) dp->addrs[i].address;
 
+#ifdef CONFIG_PPC64
+		address += dp->phb->pci_mem_offset;
+#endif
+		
 		/* kludge for valkyrie */
 		if (strcmp(dp->name, "valkyrie") == 0)
 			address += 0x1000;

_
