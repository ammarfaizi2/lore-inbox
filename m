Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWFBUOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWFBUOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWFBUOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:14:39 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:13266 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932174AbWFBUOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:14:38 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:13:03 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 11/18] ieee1394: extend lowlevel API for
 address range properties
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
Message-ID: <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.359) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Host adapter hardware imposes certain restrictions and features on
address ranges.  Instead of hard-wiring such ranges into the ieee1394
core or even into protocol drivers, let lowlevel drivers specify
these ranges via struct hpsb_host.

Patch "ohci1394: set address range properties" must be applied too,
else hpsb_allocate_and_register_addrspace() won't work properly.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/hosts.h	2006-06-01 20:55:43.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.h	2006-06-01 20:55:45.000000000 +0200
@@ -73,6 +73,8 @@ struct hpsb_host {
 	unsigned int config_roms;
 
 	struct list_head addr_space;
+	u64 low_addr_space;	/* upper bound of physical DMA area */
+	u64 middle_addr_space;	/* upper bound of posted write area */
 };
 
 
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/highlevel.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/highlevel.c	2006-06-01 20:55:04.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/highlevel.c	2006-06-01 20:55:45.000000000 +0200
@@ -312,8 +312,10 @@ u64 hpsb_allocate_and_register_addrspace
 		return retval;
 	}
 
+	/* default range,
+	 * avoids controller's posted write area (see OHCI 1.1 clause 1.5) */
 	if (start == ~0ULL && end == ~0ULL) {
-		start = CSR1212_ALL_SPACE_BASE + 0xffff00000000ULL;  /* ohci1394.c limit */
+		start = host->middle_addr_space;
 		end = CSR1212_ALL_SPACE_END;
 	}
 


