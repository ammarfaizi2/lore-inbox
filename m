Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUDORcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUDORbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:31:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:18606 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263156AbUDORYL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:11 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10820498253445@kroah.com>
Date: Thu, 15 Apr 2004 10:23:45 -0700
Message-Id: <10820498253817@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.4, 2004/03/26 16:32:21-08:00, willy@debian.org

[PATCH] PCI Hotplug: Don't up() twice in acpiphp

On the error path, we currently try to up() a semaphore twice.
There was also a typo in an error message.


 drivers/pci/hotplug/acpiphp_glue.c |   38 +++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Thu Apr 15 10:05:56 2004
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Thu Apr 15 10:05:56 2004
@@ -1243,40 +1243,38 @@
 
 /**
  * acpiphp_check_bridge - re-enumerate devices
+ *
+ * Iterate over all slots under this bridge and make sure that if a
+ * card is present they are enabled, and if not they are disabled.
  */
 int acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 {
 	struct acpiphp_slot *slot;
-	unsigned int sta;
 	int retval = 0;
 	int enabled, disabled;
 
 	enabled = disabled = 0;
 
 	for (slot = bridge->slots; slot; slot = slot->next) {
-		sta = get_slot_status(slot);
+		unsigned int status = get_slot_status(slot);
 		if (slot->flags & SLOT_ENABLED) {
-			/* if enabled but not present, disable */
-			if (sta != ACPI_STA_ALL) {
-				retval = acpiphp_disable_slot(slot);
-				if (retval) {
-					err("Error occurred in enabling\n");
-					up(&slot->crit_sect);
-					goto err_exit;
-				}
-				disabled++;
+			if (status == ACPI_STA_ALL)
+				continue;
+			retval = acpiphp_disable_slot(slot);
+			if (retval) {
+				err("Error occurred in disabling\n");
+				goto err_exit;
 			}
+			disabled++;
 		} else {
-			/* if disabled but present, enable */
-			if (sta == ACPI_STA_ALL) {
-				retval = acpiphp_enable_slot(slot);
-				if (retval) {
-					err("Error occurred in enabling\n");
-					up(&slot->crit_sect);
-					goto err_exit;
-				}
-				enabled++;
+			if (status != ACPI_STA_ALL)
+				continue;
+			retval = acpiphp_enable_slot(slot);
+			if (retval) {
+				err("Error occurred in enabling\n");
+				goto err_exit;
 			}
+			enabled++;
 		}
 	}
 

