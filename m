Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVCBCDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVCBCDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 21:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVCBCDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 21:03:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11255 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262138AbVCBCDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 21:03:09 -0500
Date: Tue, 1 Mar 2005 18:03:06 -0800
From: Todd Poynor <tpoynor@mvista.com>
To: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: [PATCH] Custom power states for non-ACPI systems
Message-ID: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise custom sets of system power states for non-ACPI systems.
Currently, /sys/power/state shows and accepts a static set of choices
that are not necessarily meaningful on all platforms (for example,
suspend-to-disk is an option even on diskless embedded systems, and the
meaning of standby vs. suspend-to-mem is not well-defined on
non-ACPI-systems).  This patch allows the platform to register power
states with meaningful names that correspond to the platform's
conventions (for example, "big sleep" and "deep sleep" on TI OMAP), and
only those states that make sense for the platform.

For the time being, the canned set of PM_SUSPEND_STANDBY/MEM/DISK
etc. symbols are preserved, since knowledge of the meanings of those
values have crept into drivers.  There is a separate effort underway to
divorce driver suspend flags from the platform suspend state
identifiers.  Once that is accomplished, we can then replace the suspend
states available with an entirely custom set.  For example, various
embedded platforms have multiple power states that roughly correspond to
suspend-to-mem, and each could be advertised and requested via the PM
interfaces, once drivers no longer look for the one and only
PM_SUSPEND_MEM system suspend state.

If the platform does not register a custom set of power states then the
present-day set remains available as a default.  Will send separately a
patch for an embedded platform to show usage.  Comments appreciated.

Index: linux-2.6.10/include/linux/pm.h
===================================================================
--- linux-2.6.10.orig/include/linux/pm.h	2005-03-02 00:41:43.000000000 +0000
+++ linux-2.6.10/include/linux/pm.h	2005-03-02 01:12:14.000000000 +0000
@@ -216,8 +216,14 @@
 #define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
 #define	PM_DISK_MAX		((__force suspend_disk_method_t) 5)
 
+struct pm_suspend_method {
+	char *name;
+	suspend_state_t state;
+};
+
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
+	struct pm_suspend_method *pm_suspend_methods;
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
Index: linux-2.6.10/kernel/power/main.c
===================================================================
--- linux-2.6.10.orig/kernel/power/main.c	2005-03-02 00:41:41.000000000 +0000
+++ linux-2.6.10/kernel/power/main.c	2005-03-02 01:15:21.000000000 +0000
@@ -228,11 +228,22 @@
 
 
 
-char * pm_states[] = {
-	[PM_SUSPEND_STANDBY]	= "standby",
-	[PM_SUSPEND_MEM]	= "mem",
-	[PM_SUSPEND_DISK]	= "disk",
-	NULL,
+struct pm_suspend_method pm_default_suspend_methods[] = {
+	{
+		.name = "standby",
+		.state = PM_SUSPEND_STANDBY,
+	},
+	{
+		.name = "mem",
+		.state = PM_SUSPEND_MEM,
+	},
+	{
+		.name = "disk",
+		.state = PM_SUSPEND_DISK,
+	},
+	{
+		.name = NULL,
+	},
 };
 
 
@@ -324,19 +335,22 @@
 {
 	int i;
 	char * s = buf;
+	struct pm_suspend_method *methods = pm_ops->pm_suspend_methods;
+
+	if (! methods)
+		methods = pm_default_suspend_methods;
+
+	for (i=0; methods[i].name; i++)
+		s += sprintf(s,"%s ",methods[i].name);
 
-	for (i = 0; i < PM_SUSPEND_MAX; i++) {
-		if (pm_states[i])
-			s += sprintf(s,"%s ",pm_states[i]);
-	}
 	s += sprintf(s,"\n");
 	return (s - buf);
 }
 
 static ssize_t state_store(struct subsystem * subsys, const char * buf, size_t n)
 {
-	suspend_state_t state = PM_SUSPEND_STANDBY;
-	char ** s;
+	struct pm_suspend_method *methods = pm_ops->pm_suspend_methods;
+	int i;
 	char *p;
 	int error;
 	int len;
@@ -344,12 +358,15 @@
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
-		if (*s && !strncmp(buf, *s, len))
+	if (! methods)
+		methods = pm_default_suspend_methods;
+
+	for (i = 0; methods[i].name; i++) {
+		if (!strncmp(buf, methods[i].name, len))
 			break;
 	}
-	if (*s)
-		error = enter_state(state);
+	if (methods[i].name)
+		error = enter_state(methods[i].state);
 	else
 		error = -EINVAL;
 	return error ? error : n;

