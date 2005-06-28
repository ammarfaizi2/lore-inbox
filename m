Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVF1FrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVF1FrG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVF1Fq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:46:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:13804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261645AbVF1Fdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:36 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi hotplug: clean up notify handlers on acpiphp unload
In-Reply-To: <11199367733440@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:53 -0700
Message-Id: <11199367732527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi hotplug: clean up notify handlers on acpiphp unload

A root bridge may not have directly attached hotpluggable slots under it.
Instead, it may have p2p bridges with slots under it.  In this case, we need
to clean up the p2p bridges and slots properly too.  Patch below applies on
top of the original patch, and fixes this problem.  Without this, acpiphp
leaves behind notify handlers on module unload, and subsequent module load
attempts don't work properly too.  Patch was tested on an ia64 Tiger4 box.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 364d5094a43ff2ceff3d19e40c4199771cb6cb8f
tree bc3c70c12895d22aaa96dc27632df22f4ff9ac9e
parent 42f49a6ae5dca90cd0594475502bf1c43ff1dc07
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:54 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:42 -0700

 drivers/pci/hotplug/acpiphp_glue.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -487,18 +487,12 @@ static struct acpiphp_bridge *acpiphp_ha
 	return NULL;
 }
 
-static void remove_bridge(acpi_handle handle)
+static void cleanup_bridge(struct acpiphp_bridge *bridge)
 {
 	struct list_head *list, *tmp;
-	struct acpiphp_bridge *bridge;
 	struct acpiphp_slot *slot;
 	acpi_status status;
-
-	bridge = acpiphp_handle_to_bridge(handle);
-	if (!bridge) {
-		err("Could not find bridge for handle %p\n", handle);
-		return;
-	}
+	acpi_handle handle = bridge->handle;
 
 	status = acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 					    handle_hotplug_event_bridge);
@@ -529,6 +523,30 @@ static void remove_bridge(acpi_handle ha
 	kfree(bridge);
 }
 
+static acpi_status
+cleanup_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	struct acpiphp_bridge *bridge;
+
+	if (!(bridge = acpiphp_handle_to_bridge(handle)))
+		return AE_OK;
+	cleanup_bridge(bridge);
+	return AE_OK;
+}
+
+static void remove_bridge(acpi_handle handle)
+{
+	struct acpiphp_bridge *bridge;
+
+	bridge = acpiphp_handle_to_bridge(handle);
+	if (bridge) {
+		cleanup_bridge(bridge);
+	} else {
+		/* clean-up p2p bridges under this host bridge */
+		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
+				(u32)1, cleanup_p2p_bridge, NULL, NULL);
+	}
+}
 
 static int power_on_slot(struct acpiphp_slot *slot)
 {

