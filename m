Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbTANWLK>; Tue, 14 Jan 2003 17:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbTANWLK>; Tue, 14 Jan 2003 17:11:10 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18441 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265402AbTANWLG>;
	Tue, 14 Jan 2003 17:11:06 -0500
Date: Tue, 14 Jan 2003 14:19:44 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI hotplug changes for 2.5.58
Message-ID: <20030114221944.GD17226@kroah.com>
References: <20030114221839.GC17226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114221839.GC17226@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1025, 2003/01/14 11:30:32-08:00, willy@debian.org

[PATCH] acpi_bus_register_driver patch

The current ACPI code searches for a _HID of PNP0A03.  This is wrong,
it needs to check _CID too.  But we already have generic code for doing
that, so this patch converts the ACPI pcihp code to do this.


diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Tue Jan 14 14:11:54 2003
+++ b/drivers/hotplug/acpiphp_glue.c	Tue Jan 14 14:11:54 2003
@@ -712,8 +712,9 @@
 
 
 /* find hot-pluggable slots, and then find P2P bridge */
-static int add_bridges (acpi_handle *handle)
+static int add_bridges(struct acpi_device *device)
 {
+	acpi_handle *handle = device->handle;
 	acpi_status status;
 	unsigned long tmp;
 	int seg, bus;
@@ -767,36 +768,6 @@
 }
 
 
-/* callback routine to enumerate all the bridges in ACPI namespace */
-static acpi_status
-find_host_bridge (acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	acpi_status status;
-	struct acpi_device_info info;
-	char objname[5];
-	struct acpi_buffer buffer = { .length = sizeof(objname),
-				      .pointer = objname };
-
-	status = acpi_get_object_info(handle, &info);
-	if (ACPI_FAILURE(status)) {
-		dbg("%s: failed to get bridge information\n", __FUNCTION__);
-		return AE_OK;		/* continue */
-	}
-
-	info.hardware_id[sizeof(info.hardware_id)-1] = '\0';
-
-	/* TBD use acpi_get_devices() API */
-	if (info.current_status &&
-	    (info.valid & ACPI_VALID_HID) &&
-	    strcmp(info.hardware_id, ACPI_PCI_HOST_HID) == 0) {
-		acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
-		dbg("checking PCI-hotplug capable bridges under [%s]\n", objname);
-		add_bridges(handle);
-	}
-	return AE_OK;
-}
-
-
 static int power_on_slot (struct acpiphp_slot *slot)
 {
 	acpi_status status;
@@ -1157,6 +1128,14 @@
 	}
 }
 
+static struct acpi_driver acpi_pci_hp_driver = {
+	.name =		"pci_hp",
+	.class =	"",
+	.ids =		ACPI_PCI_HOST_HID,
+	.ops =	{
+		.add =	add_bridges,
+	}
+};
 
 /**
  * acpiphp_glue_init - initializes all PCI hotplug - ACPI glue data structures
@@ -1169,9 +1148,7 @@
 	if (list_empty(&pci_root_buses))
 		return -1;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX, find_host_bridge,
-				     NULL, NULL);
+	status = acpi_bus_register_driver(&acpi_pci_hp_driver);
 
 	if (ACPI_FAILURE(status)) {
 		err("%s: acpi_walk_namespace() failed\n", __FUNCTION__);
