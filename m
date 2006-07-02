Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWGBW7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWGBW7t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWGBW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:59:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35797 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751357AbWGBW7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:59:47 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 00:59:26 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 04/19] ieee1394: skip dummy loop in build_speed_map
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.d55652338cfc5eb2@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.341) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last loop in ieee1394 core's speed calculation is not required
unless ieee1394.h::IEEE1394_SPEED_MAX is changed from its current value
of 3.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ieee1394.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394.h	2006-07-02 12:02:06.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394.h	2006-07-02 12:11:23.000000000 +0200
@@ -77,6 +77,8 @@ extern const char *hpsb_speedto_str[];
 #define SELFID_PORT_NCONN        0x1
 #define SELFID_PORT_NONE         0x0
 
+#define SELFID_SPEED_UNKNOWN		0x3	/* 1394b PHY */
+
 #define PHYPACKET_LINKON			0x40000000
 #define PHYPACKET_PHYCONFIG_R			0x00800000
 #define PHYPACKET_PHYCONFIG_T			0x00400000
Index: linux/drivers/ieee1394/ieee1394_core.c
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_core.c	2006-07-02 12:02:04.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_core.c	2006-07-02 12:11:23.000000000 +0200
@@ -355,10 +355,12 @@ static void build_speed_map(struct hpsb_
 		}
 	}
 
+#if SELFID_SPEED_UNKNOWN != IEEE1394_SPEED_MAX
 	/* assume maximum speed for 1394b PHYs, nodemgr will correct it */
 	for (n = 0; n < nodecount; n++)
-		if (speedcap[n] == 3)
+		if (speedcap[n] == SELFID_SPEED_UNKNOWN)
 			speedcap[n] = IEEE1394_SPEED_MAX;
+#endif
 }
 
 


