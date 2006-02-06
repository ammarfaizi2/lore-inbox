Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWBFUaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWBFUaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWBFU3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:29:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:26301 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964789AbWBFU3f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:35 -0500
Cc: pavel@suse.cz
Subject: [PATCH] Fix Userspace interface breakage in power/state
In-Reply-To: <20060206202830.GA5202@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:17 -0800
Message-Id: <11392577577@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix Userspace interface breakage in power/state

Prevent passing invalid values down to the drivers.

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 022f7b07bf2b384ece7fbd7edb90e54cd78db252
tree 7eae52ca103253babb194b8bae92c15340d82c0b
parent 68f5f996347dc2724a0dd511683643a2b6912380
author Pavel Machek <pavel@suse.cz> Sun, 22 Jan 2006 22:38:52 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 drivers/base/power/sysfs.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index f3a0c56..40d7242 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -27,22 +27,30 @@
 
 static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state.event);
+	if (dev->power.power_state.event)
+		return sprintf(buf, "2\n");
+	else
+		return sprintf(buf, "0\n");
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
+	state.event = PM_EVENT_SUSPEND;
+	/* Older apps expected to write "3" here - confused with PCI D3 */
+	if ((n == 1) && !strcmp(buf, "3"))
 		error = dpm_runtime_suspend(dev, state);
-	else
+
+	if ((n == 1) && !strcmp(buf, "2"))
+		error = dpm_runtime_suspend(dev, state);
+
+	if ((n == 1) && !strcmp(buf, "0")) {
 		dpm_runtime_resume(dev);
+		error = 0;
+	}
+
 	return error ? error : n;
 }
 

