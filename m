Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWEZRb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWEZRb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWEZRb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:31:26 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:2769 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751188AbWEZRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:31:25 -0400
Date: Fri, 26 May 2006 12:31:22 -0500
From: Corey Minyard <minyard@acm.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Jordan_Hargrave@dell.com,
       Matt_Domsch@dell.com, openipmi-developer@lists.sourceforge.net
Subject: [PATCH] IPMI: reserve I/O ports separately
Message-ID: <20060526173122.GA30891@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is pretty important to get in for IPMI, new systems have
been changing the way ACPI and IPMI interact, and this works around
the problems for now.  This is a temporary fix until we get proper
ACPI handling in IPMI.

Fixed releasing already-allocated regions when a later request fails,
and forward-ported it to HEAD.

Some BIOSes reserve disjoint I/O regions in their ACPI tables for the
IPMI controller.  This causes problems when trying to register the
entire I/O region.  Therefore we must register each I/O port
separately.

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index b36eef0..96a9e24 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1184,20 +1184,20 @@ static void port_outl(struct si_sm_io *i
 static void port_cleanup(struct smi_info *info)
 {
 	unsigned int addr = info->io.addr_data;
-	int          mapsize;
+	int          idx;
 
 	if (addr) {
-		mapsize = ((info->io_size * info->io.regspacing)
-			   - (info->io.regspacing - info->io.regsize));
-
-		release_region (addr, mapsize);
+	  	for (idx = 0; idx < info->io_size; idx++) {
+			release_region(addr + idx * info->io.regspacing,
+				       info->io.regsize);
+		}
 	}
 }
 
 static int port_setup(struct smi_info *info)
 {
 	unsigned int addr = info->io.addr_data;
-	int          mapsize;
+	int          idx;
 
 	if (!addr)
 		return -ENODEV;
@@ -1225,16 +1225,23 @@ static int port_setup(struct smi_info *i
 		return -EINVAL;
 	}
 
-	/* Calculate the total amount of memory to claim.  This is an
-	 * unusual looking calculation, but it avoids claiming any
-	 * more memory than it has to.  It will claim everything
-	 * between the first address to the end of the last full
-	 * register. */
-	mapsize = ((info->io_size * info->io.regspacing)
-		   - (info->io.regspacing - info->io.regsize));
-
-	if (request_region(addr, mapsize, DEVICE_NAME) == NULL)
-		return -EIO;
+	/* Some BIOSes reserve disjoint I/O regions in their ACPI
+	 * tables.  This causes problems when trying to register the
+	 * entire I/O region.  Therefore we must register each I/O
+	 * port separately.
+	 */
+  	for (idx = 0; idx < info->io_size; idx++) {
+		if (request_region(addr + idx * info->io.regspacing,
+				   info->io.regsize, DEVICE_NAME) == NULL)
+		{
+			/* Undo allocations */
+			while (idx--) {
+				release_region(addr + idx * info->io.regspacing,
+					       info->io.regsize);
+			}
+			return -EIO;
+		}
+	}
 	return 0;
 }
 
