Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbTGKSJK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264842AbTGKSJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:09:00 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5252
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264683AbTGKRxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:53:48 -0400
Date: Fri, 11 Jul 2003 19:07:35 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111807.h6BI7Zul017260@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Fix remaining g_NCR5380 use of check_region
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/scsi/g_NCR5380.c linux-2.5.75-ac1/drivers/scsi/g_NCR5380.c
--- linux-2.5.75/drivers/scsi/g_NCR5380.c	2003-07-10 21:05:35.000000000 +0100
+++ linux-2.5.75-ac1/drivers/scsi/g_NCR5380.c	2003-07-11 15:44:06.000000000 +0100
@@ -386,14 +386,21 @@
 
 			if (overrides[current_override].NCR5380_map_name != PORT_AUTO)
 				for (i = 0; ports[i]; i++) {
+					if (!request_region(ports[i],  16, "ncr53c80"))
+						continue;
 					if (overrides[current_override].NCR5380_map_name == ports[i])
 						break;
+					release_region(ports[i], 16);
 			} else
 				for (i = 0; ports[i]; i++) {
-					if ((!check_region(ports[i], 16)) && (inb(ports[i]) == 0xff))
+					if (!request_region(ports[i],  16, "ncr53c80"))
+						continue;
+					if (inb(ports[i]) == 0xff)
 						break;
+					release_region(ports[i], 16);
 				}
 			if (ports[i]) {
+				/* At this point we have our region reserved */
 				outb(0x59, 0x779);
 				outb(0xb9, 0x379);
 				outb(0xc5, 0x379);
@@ -408,12 +415,15 @@
 			} else
 				continue;
 		}
-
-		request_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size, "ncr5380");
+		else
+		{
+			/* Not a 53C400A style setup - just grab */
+			if(!(request_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size, "ncr5380")))
+				continue;
+		}
 #else
-		if (check_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size))
+		if(!request_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size, "ncr5380"))
 			continue;
-		request_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size, "ncr5380");
 #endif
 		instance = scsi_register(tpnt, sizeof(struct NCR5380_hostdata));
 		if (instance == NULL) {
