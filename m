Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVL0VfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVL0VfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 16:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVL0VfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 16:35:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63117 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932290AbVL0VfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 16:35:00 -0500
Date: Tue, 27 Dec 2005 22:34:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20051227213439.GA1884@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/devices/..../power interface is currently very broken. It takes
integer from user, and passes it to drivers as pm_message_t.event
... without even checking it. This changes the interface to pass
strings, and introduces checks.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -27,22 +27,25 @@
 
 static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state.event);
+	if (dev->power.power_state.event)
+		return sprintf(buf, "suspend\n");
+	else
+		return sprintf(buf, "on\n");
 }
 
 static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
 {
 	pm_message_t state;
-	char * rest;
-	int error = 0;
+	int error = -EINVAL;
 
-	state.event = simple_strtoul(buf, &rest, 10);
-	if (*rest)
-		return -EINVAL;
-	if (state.event)
-		error = dpm_runtime_suspend(dev, state);
-	else
+	state.event = PM_EVENT_SUSPEND;
+	if ((n == 2) && !strncmp(buf, "on", 2)) {
 		dpm_runtime_resume(dev);
+		error = 0;
+	}
+	if ((n == 7) && !strncmp(buf, "suspend", 7))
+		error = dpm_runtime_suspend(dev, state);
+
 	return error ? error : n;
 }
 

-- 
Thanks, Sharp!
