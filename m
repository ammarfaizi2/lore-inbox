Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270329AbTHORWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270082AbTHORVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:21:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:17598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270013AbTHORU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:20:58 -0400
Date: Fri, 15 Aug 2003 10:21:30 -0700
From: Dave Olien <dmo@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960 fix for NULL dereference in open()
Message-ID: <20030815172130.GA2325@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a problem that's been hidden for a while.  DAC960_open()
will try to dereference a NULL pointer if an application opens
(for example) /dev/rd/c0d12 when there has never been a logical device
created for that file.


diff -ur linux-2.6.0-test3_mm2_original/drivers/block/DAC960.c linux-2.6.0-test3_mm2_DAC/drivers/block/DAC960.c
--- linux-2.6.0-test3_mm2_original/drivers/block/DAC960.c	2003-08-14 14:38:49.000000000 -0700
+++ linux-2.6.0-test3_mm2_DAC/drivers/block/DAC960.c	2003-08-15 09:39:48.000000000 -0700
@@ -82,7 +82,7 @@
 	} else {
 		DAC960_V2_LogicalDeviceInfo_T *i =
 			p->V2.LogicalDeviceInformation[drive_nr];
-		if (i->LogicalDeviceState == DAC960_V2_LogicalDevice_Offline)
+		if (!i || i->LogicalDeviceState == DAC960_V2_LogicalDevice_Offline)
 			return -ENXIO;
 	}
 
