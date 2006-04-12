Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWDLWKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWDLWKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 18:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWDLWK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 18:10:28 -0400
Received: from mga03.intel.com ([143.182.124.21]:7236 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932342AbWDLWKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 18:10:17 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="22497374:sNHT21045766"
Subject: [patch 3/3] acpiphp: prevent duplicate slot numbers when no _SUN
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com, greg@kroah.com
Cc: linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mochel@linux.intel.com,
       arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz,
       temnota@kmv.ru, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
References: <20060412221027.472109000@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Apr 2006 15:18:47 -0700
Message-Id: <1144880327.11215.46.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 12 Apr 2006 22:10:15.0856 (UTC) FILETIME=[E0971B00:01C65E7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dock bridges generally do not implement _SUN, yet show up as ejectable slots.
If you have more than one ejectable slot that does not implement SUN, with the
current code you will get duplicate slot numbers.  So, if there is no _SUN,
use the current count of the number of slots found instead.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/pci/hotplug/acpiphp_glue.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- 2.6-git-kca2.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ 2.6-git-kca2/drivers/pci/hotplug/acpiphp_glue.c
@@ -218,8 +218,13 @@ register_slot(acpi_handle handle, u32 lv
 		newfunc->flags |= FUNC_HAS_DCK;
 
 	status = acpi_evaluate_integer(handle, "_SUN", NULL, &sun);
-	if (ACPI_FAILURE(status))
-		sun = -1;
+	if (ACPI_FAILURE(status)) {
+		/*
+		 * use the count of the number of slots we've found
+		 * for the number of the slot
+		 */
+		sun = bridge->nr_slots+1;
+	}
 
 	/* search for objects that share the same slot */
 	for (slot = bridge->slots; slot; slot = slot->next)

--
