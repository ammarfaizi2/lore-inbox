Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbWI1CvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbWI1CvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 22:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWI1CvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 22:51:09 -0400
Received: from twin.jikos.cz ([213.151.79.26]:1979 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S965235AbWI1CvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 22:51:07 -0400
Date: Thu, 28 Sep 2006 04:50:49 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Len Brown <len.brown@intel.com>
cc: linux-acpi@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] preserve correct battery state through suspend/resume cycles
Message-ID: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem in th following scenario(s):

boot -> suspend -> (un)plug battery -> resume

The problem arises in both cases - i.e. suspend with battery plugged in, 
and resume with battery unplugged, or vice versa.

After resume, when the battery status has changed (plugged in -> unplegged 
or unplugged -> plugged in) during the time when the system was sleeping, 
the /proc/acpi/battery/*/* is wrong (showing the state before suspend, not 
the current state).

The following patch adds ->resume method to the ACPI battery handler, which
has the only aim - to check whether the battery state has changed during sleep, 
and if so, update the ACPI internal data structures, so that information 
published through /proc/acpi/battery/*/* is correct even after suspend/resume
cycle, during which the battery was removed/inserted.

The patch is against current ACPI git tree, but applies cleanly also 
against -mm and probably other trees. Please apply.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

 drivers/acpi/battery.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9810e2a..82a0f5b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static int acpi_battery_resume(struct acpi_device *device, int status);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -71,6 +72,7 @@ static struct acpi_driver acpi_battery_d
 	.ids = ACPI_BATTERY_HID,
 	.ops = {
 		.add = acpi_battery_add,
+		.resume = acpi_battery_resume,
 		.remove = acpi_battery_remove,
 		},
 };
@@ -753,6 +755,19 @@ static int acpi_battery_remove(struct ac
 	return 0;
 }
 
+/* this is needed to learn about changes made in suspended state */
+static int acpi_battery_resume(struct acpi_device *device, int state)
+{
+	struct acpi_battery *battery;
+	
+	if (!device)
+		return -EINVAL;
+	
+	battery = (struct acpi_battery *)device->driver_data;
+	return acpi_battery_check(battery);
+	
+}
+
 static int __init acpi_battery_init(void)
 {
 	int result;

-- 
Jiri Kosina
