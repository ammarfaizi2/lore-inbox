Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUBZSer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUBZSer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:34:47 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:22711 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262876AbUBZSeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:34:46 -0500
Date: Thu, 26 Feb 2004 11:34:39 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: greg@kroah.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Fix dev_printk to work with unclaimed devices
Message-ID: <20040226183439.GA17722@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I need to do some fixup in platform_notify() and when trying to 
use the dev_* print functions for informational messages, they OOPs 
b/c the current code assumes that dev->driver exists. This is not the 
case since platform_notify() is called before a device has been attached
to any driver. 

--- linux-2.5-bk/include/linux/device.h	2004-02-10 14:51:49.000000000 -0700
+++ linux-2.6-ds/include/linux/device.h	2004-02-26 11:10:38.000000000 -0700
@@ -395,7 +395,13 @@
 
 /* debugging and troubleshooting/diagnostic helpers. */
 #define dev_printk(level, dev, format, arg...)	\
-	printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , ## arg)
+	do {					\
+		if ((dev)->driver) {		\
+			printk(level "%s %s: " format , (dev)->driver->name , (dev)->bus_id , ## arg);				\
+		} else {			\
+			printk(level "%s (Unclaimed %s bus device): " format , (dev)->bus_id, (dev)->bus->name , ## arg);					\
+		}				\
+	} while (0)
 
 #ifdef DEBUG
 #define dev_dbg(dev, format, arg...)		\

