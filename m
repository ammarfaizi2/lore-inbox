Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVIASRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVIASRi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVIASRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:17:37 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:48848 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1030278AbVIASRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:17:37 -0400
Date: Thu, 1 Sep 2005 20:17:23 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Consolidate dprintk and friends?
Message-ID: <20050901181722.GA4604@hansolo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A case-insensitive grep through the 2.6.13 tree for "define printk" 
yields 378 hits ("define dbg": 736, "define warn": 50, "define info": 
65).

Maybe it would be a good idea to create include/linux/debug.h as 
included inline below (or to add the content in include/linux/kernel.h 
where pr_debug is already located)? 

Then a module could simply do:

#include <linux/debug.h>
MODULE_DEBUG;

and then sprinkle debug() statements where appropriate.

It would also make the name and description of the debug variable in 
sysfs more consistent. 

I tried searching the lkml archives, but couldn't find any discussion on 
the topic...so is it a good idea?

Re,
David


--- /dev/null	2005-09-01 20:05:20.395616648 +0200
+++ linux-2.6.13/include/linux/debug.h	2005-09-01 20:01:56.000000000 +0200
@@ -0,0 +1,52 @@
+#ifndef _LINUX_DEBUG_H
+#define _LINUX_DEBUG_H
+
+/*
+ * unconditional messages 
+ */
+
+/* unc(onditional)_debug should not be used, but rather debug or pr_debug */
+#define unc_debug(fmt,arg...) printk(KERN_DEBUG fmt, ##arg)
+
+/* convenience macros */
+#define info(fmt,arg...) printk(KERN_INFO fmt, ##arg)
+#define warn(fmt,arg...) printk(KERN_WARN fmt, ##arg)
+#define err(fmt,arg...) printk(KERN_EMERG fmt, ##arg)
+
+
+
+/*
+ * debug messages (de)activated at runtime 
+ */
+
+/* the variable which (de)activates debugging messages */
+#ifndef DEBUG_VARIABLE
+#define DEBUG_VARIABLE debug
+#endif
+
+/* quick macro to add a debug parameter to a module */
+#define MODULE_DEBUG \
+do { \
+	static unsigned int DEBUG_VARIABLE = 0; \
+	module_param(DEBUG_VARIABLE, uint, 0644); \
+	MODULE_PARM_DESC(DEBUG_VARIABLE, "Enable debug messages"); \
+} while(0)
+
+/* regular debug messages */
+#define debug(fmt,arg...) do { if (DEBUG_VARIABLE) unc_debug(fmt, ##arg); } while (0)
+
+/* different levels of debug messages (only output if DEBUG_VARIABLE is large enough) */
+#define ldebug(level,fmt,arg...) do { if (DEBUG_VARIABLE >= level) unc_debug(fmt, ##arg); } while (0)
+
+
+
+/* 
+ * debug messages (de)activated by the preprocessor 
+ */
+#ifdef DEBUG
+#define pr_debug(fmt,arg...) unc_debug(fmt, ##arg)
+#else
+#define pr_debug(fmt,arg...) do { } while (0)
+#endif
+
+#endif /* _LINUX_DEBUG_H */
