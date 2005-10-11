Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVJKXxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVJKXxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVJKXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:53:17 -0400
Received: from fmr18.intel.com ([134.134.136.17]:35796 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932309AbVJKXxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:53:16 -0400
Subject: Re: [Pcihpd-discuss] [patch 1/2] acpiphp: allocate resources for
	adapters with bridges
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
In-Reply-To: <87mzlgkeil.wl%muneda.takahiro@jp.fujitsu.com>
References: <1128707147.11020.10.camel@whizzy>
	 <87mzlgkeil.wl%muneda.takahiro@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Oct 2005 16:53:02 -0700
Message-Id: <1129074782.15526.28.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 11 Oct 2005 23:53:04.0218 (UTC) FILETIME=[EBA033A0:01C5CEBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate resources for adapters with bridges on them.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
I changed the patch to not store the acpi_handle in the acpiphp_slot
structure, but grab it out of the device structure instead.  However, I
don't have an adapter that will really test to see if this works
properly, so if your adapter will work, then please give it a try and
let me know if it fails.

diff -uprN -X linux-2.6.14-rc3/Documentation/dontdiff linux-2.6.14-rc3.orig/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.14-rc3/drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.14-rc3.orig/drivers/pci/hotplug/acpiphp_glue.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc3/drivers/pci/hotplug/acpiphp_glue.c	2005-10-11 16:30:58.000000000 -0700
@@ -58,6 +58,9 @@ static LIST_HEAD(bridge_list);
 
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
 static void handle_hotplug_event_func (acpi_handle, u32, void *);
+static void acpiphp_sanitize_bus(struct pci_bus *bus);
+static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
+
 
 /*
  * initialization & terminatation routines
@@ -796,9 +799,14 @@ static int enable_device(struct acpiphp_
 		}
 	}
 
+	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
+	acpiphp_sanitize_bus(bus);
+	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
-
+	acpiphp_set_hpp_values(DEVICE_ACPI_HANDLE(&bus->self->dev), bus);
+	acpiphp_configure_ioapics(DEVICE_ACPI_HANDLE(&bus->self->dev));
+		
 	/* associate pci_dev to our representation */
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);

