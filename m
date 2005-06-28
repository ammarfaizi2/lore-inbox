Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVF1F6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVF1F6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVF1FlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:41:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:8940 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261625AbVF1Fde convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:34 -0400
Cc: kaneshige.kenji@jp.fujitsu.com
Subject: [PATCH] ACPI based I/O APIC hot-plug: acpiphp support
In-Reply-To: <11199367741201@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:54 -0700
Message-Id: <11199367742637@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ACPI based I/O APIC hot-plug: acpiphp support

This patch adds PCI based I/O xAPIC hot-add support to ACPIPHP
driver. When PCI root bridge is hot-added, all PCI based I/O xAPICs
under the root bridge are hot-added by this patch. Hot-remove support
is TBD.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a0d399a808916d22c1c222c6b5ca4e8edd6d91a9
tree 4c4f41d86652c7783cd5900605f36344253d3ef1
parent 0e888adc41ffc02b700ade715c182a17e766af84
author Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> Thu, 28 Apr 2005 00:25:59 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:45 -0700

 drivers/pci/hotplug/acpiphp_glue.c |  127 ++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h            |    2 +
 2 files changed, 129 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -552,6 +552,132 @@ static void remove_bridge(acpi_handle ha
 	}
 }
 
+static struct pci_dev * get_apic_pci_info(acpi_handle handle)
+{
+	struct acpi_pci_id id;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+
+	if (ACPI_FAILURE(acpi_get_pci_id(handle, &id)))
+		return NULL;
+
+	bus = pci_find_bus(id.segment, id.bus);
+	if (!bus)
+		return NULL;
+
+	dev = pci_get_slot(bus, PCI_DEVFN(id.device, id.function));
+	if (!dev)
+		return NULL;
+
+	if ((dev->class != PCI_CLASS_SYSTEM_PIC_IOAPIC) &&
+	    (dev->class != PCI_CLASS_SYSTEM_PIC_IOXAPIC))
+	{
+		pci_dev_put(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+
+static int get_gsi_base(acpi_handle handle, u32 *gsi_base)
+{
+	acpi_status status;
+	int result = -1;
+	unsigned long gsb;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *obj;
+	void *table;
+
+	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gsb);
+	if (ACPI_SUCCESS(status)) {
+		*gsi_base = (u32)gsb;
+		return 0;
+	}
+
+	status = acpi_evaluate_object(handle, "_MAT", NULL, &buffer);
+	if (ACPI_FAILURE(status) || !buffer.length || !buffer.pointer)
+		return -1;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER)
+		goto out;
+
+	table = obj->buffer.pointer;
+	switch (((acpi_table_entry_header *)table)->type) {
+	case ACPI_MADT_IOSAPIC:
+		*gsi_base = ((struct acpi_table_iosapic *)table)->global_irq_base;
+		result = 0;
+		break;
+	case ACPI_MADT_IOAPIC:
+		*gsi_base = ((struct acpi_table_ioapic *)table)->global_irq_base;
+		result = 0;
+		break;
+	default:
+		break;
+	}
+ out:
+	acpi_os_free(buffer.pointer);
+	return result;
+}
+
+static acpi_status
+ioapic_add(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	acpi_status status;
+	unsigned long sta;
+	acpi_handle tmp;
+	struct pci_dev *pdev;
+	u32 gsi_base;
+	u64 phys_addr;
+
+	/* Evaluate _STA if present */
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+	if (ACPI_SUCCESS(status) && sta != ACPI_STA_ALL)
+		return AE_CTRL_DEPTH;
+
+	/* Scan only PCI bus scope */
+	status = acpi_get_handle(handle, "_HID", &tmp);
+	if (ACPI_SUCCESS(status))
+		return AE_CTRL_DEPTH;
+
+	if (get_gsi_base(handle, &gsi_base))
+		return AE_OK;
+
+	pdev = get_apic_pci_info(handle);
+	if (!pdev)
+		return AE_OK;
+
+	if (pci_enable_device(pdev)) {
+		pci_dev_put(pdev);
+		return AE_OK;
+	}
+
+	pci_set_master(pdev);
+
+	if (pci_request_region(pdev, 0, "I/O APIC(acpiphp)")) {
+		pci_disable_device(pdev);
+		pci_dev_put(pdev);
+		return AE_OK;
+	}
+
+	phys_addr = pci_resource_start(pdev, 0);
+	if (acpi_register_ioapic(handle, phys_addr, gsi_base)) {
+		pci_release_region(pdev, 0);
+		pci_disable_device(pdev);
+		pci_dev_put(pdev);
+		return AE_OK;
+	}
+
+	return AE_OK;
+}
+
+static int acpiphp_configure_ioapics(acpi_handle handle)
+{
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
+			    ACPI_UINT32_MAX, ioapic_add, NULL, NULL);
+	return 0;
+}
+
 static int power_on_slot(struct acpiphp_slot *slot)
 {
 	acpi_status status;
@@ -942,6 +1068,7 @@ static int acpiphp_configure_bridge (acp
 	acpiphp_sanitize_bus(bus);
 	acpiphp_set_hpp_values(handle, bus);
 	pci_enable_bridges(bus);
+	acpiphp_configure_ioapics(handle);
 	return 0;
 }
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -62,6 +62,8 @@
 
 #define PCI_BASE_CLASS_SYSTEM		0x08
 #define PCI_CLASS_SYSTEM_PIC		0x0800
+#define PCI_CLASS_SYSTEM_PIC_IOAPIC	0x080010
+#define PCI_CLASS_SYSTEM_PIC_IOXAPIC	0x080020
 #define PCI_CLASS_SYSTEM_DMA		0x0801
 #define PCI_CLASS_SYSTEM_TIMER		0x0802
 #define PCI_CLASS_SYSTEM_RTC		0x0803

