Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263908AbUCZCJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263906AbUCZCJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:09:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:24317 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263858AbUCZCJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:09:25 -0500
Date: Thu, 25 Mar 2004 18:09:16 -0800
From: Todd Poynor <tpoynor@mvista.com>
Message-Id: <200403260209.i2Q29Gwx013549@dhcp193.mvista.com>
To: akpm@osdl.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM subsystem idle behavior attribute
Cc: kenneth.w.chen@intel.com, tpoynor@mvista.com, zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As recently discussed in "add lowpower_idle sysctl", an addition to
the PM subsystem that allows a platform to register functions to show
and store attribute /sys/power/idle for idle mode behavior.  The patch
currently passes strings that are interpreted entirely by the platform
code, since I'm not sure there's a standard set of generic behaviors
that can be described.  If there's an expected need to specify idle
behavior in platform-independent manner then I'd appreciate hearing
more about what's needed.

-- 
Todd Poynor
MontaVista Software

--- linux-2.6.4-orig/kernel/power/main.c	2004-03-11 14:59:06.000000000 -0800
+++ linux-2.6.4-idle/kernel/power/main.c	2004-03-25 15:17:19.181176080 -0800
@@ -233,8 +233,40 @@
 
 power_attr(state);
 
+/**
+ *	idle - control idle mode behavior
+ */
+
+static ssize_t idle_show(struct subsystem * subsys, char * buf)
+{
+	ssize_t n;
+
+	if (pm_ops && pm_ops->show_idle_params)
+		n = pm_ops->show_idle_params(buf);
+	else
+		n = sprintf(buf,"[default]\n");
+	
+	return n;
+
+}
+
+static ssize_t idle_store(struct subsystem * subsys, const char * buf, size_t n)
+{
+	int error;
+
+	if (pm_ops && pm_ops->set_idle_params)
+		error = pm_ops->set_idle_params(buf, n);
+	else
+		error = -EINVAL;
+
+	return error ? error :n;
+}
+
+power_attr(idle);
+
 static struct attribute * g[] = {
 	&state_attr.attr,
+	&idle_attr.attr,
 	NULL,
 };
 
@@ -252,3 +284,4 @@
 }
 
 core_initcall(pm_init);
+
--- linux-2.6.4-orig/include/linux/pm.h	2004-03-11 14:58:50.000000000 -0800
+++ linux-2.6.4-idle/include/linux/pm.h	2004-03-25 15:17:30.032526424 -0800
@@ -215,6 +215,8 @@
 	int (*prepare)(u32 state);
 	int (*enter)(u32 state);
 	int (*finish)(u32 state);
+	ssize_t (*show_idle_params)(char *buf);
+	int (*set_idle_params)(const char *buf, size_t n);
 };
 
 extern void pm_set_ops(struct pm_ops *);
