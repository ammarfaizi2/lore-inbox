Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTBKV4B>; Tue, 11 Feb 2003 16:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTBKV4B>; Tue, 11 Feb 2003 16:56:01 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:31392 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id <S266308AbTBKVzx>;
	Tue, 11 Feb 2003 16:55:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Subject: [PATCH] 3/3 ACPI resource handling
Date: Tue, 11 Feb 2003 15:00:42 -0700
User-Agent: KMail/1.4.3
Cc: t-kochi@bq.jp.nec.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302111500.42641.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u -ur acpi-3/drivers/acpi/ec.c acpi-4/drivers/acpi/ec.c
--- acpi-3/drivers/acpi/ec.c	2003-02-06 14:48:20.000000000 -0700
+++ acpi-4/drivers/acpi/ec.c	2003-02-09 22:13:53.000000000 -0700
@@ -644,15 +644,46 @@
 }
 
 
+static acpi_status
+acpi_ec_io_ports (
+	struct acpi_resource	*resource,
+	void			*context)
+{
+	struct acpi_ec		*ec = (struct acpi_ec *) context;
+	struct acpi_generic_address *addr;
+
+	if (resource->id != ACPI_RSTYPE_IO) {
+		return AE_OK;
+	}
+
+	/*
+	 * The first address region returned is the data port, and
+	 * the second address region returned is the status/command
+	 * port.
+	 */
+	if (ec->data_addr.register_bit_width == 0) {
+		addr = &ec->data_addr;
+	} else if (ec->command_addr.register_bit_width == 0) {
+		addr = &ec->command_addr;
+	} else {
+		return AE_CTRL_TERMINATE;
+	}
+
+	addr->address_space_id = ACPI_ADR_SPACE_SYSTEM_IO;
+	addr->register_bit_width = 8;
+	addr->register_bit_offset = 0;
+	addr->address = resource->data.io.min_base_address;
+
+	return AE_OK;
+}
+
+
 static int
 acpi_ec_start (
 	struct acpi_device	*device)
 {
-	int			result = 0;
 	acpi_status		status = AE_OK;
 	struct acpi_ec		*ec = NULL;
-	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct acpi_resource	*resource = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_start");
 
@@ -667,33 +698,13 @@
 	/*
 	 * Get I/O port addresses. Convert to GAS format.
 	 */
-	status = acpi_get_current_resources(ec->handle, &buffer);
-	if (ACPI_FAILURE(status)) {
+	status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
+		acpi_ec_io_ports, ec);
+	if (ACPI_FAILURE(status) || ec->command_addr.register_bit_width == 0) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error getting I/O port addresses"));
 		return_VALUE(-ENODEV);
 	}
 
-	resource = (struct acpi_resource *) buffer.pointer;
-	if (!resource || (resource->id != ACPI_RSTYPE_IO)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid or missing resource\n"));
-		result = -ENODEV;
-		goto end;
-	}
-	ec->data_addr.address_space_id = ACPI_ADR_SPACE_SYSTEM_IO;
-	ec->data_addr.register_bit_width = 8;
-	ec->data_addr.register_bit_offset = 0;
-	ec->data_addr.address = resource->data.io.min_base_address;
-
-	resource = ACPI_NEXT_RESOURCE(resource);
-	if (!resource || (resource->id != ACPI_RSTYPE_IO)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid or missing resource\n"));
-		result = -ENODEV;
-		goto end;
-	}
-	ec->command_addr.address_space_id = ACPI_ADR_SPACE_SYSTEM_IO;
-	ec->command_addr.register_bit_width = 8;
-	ec->command_addr.register_bit_offset = 0;
-	ec->command_addr.address = resource->data.io.min_base_address;
 	ec->status_addr = ec->command_addr;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02x, ports=0x%2x,0x%2x\n",
@@ -706,8 +717,7 @@
 	status = acpi_install_gpe_handler(ec->gpe_bit,
 		ACPI_EVENT_EDGE_TRIGGERED, &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto end;
+		return_VALUE(-ENODEV);
 	}
 
 	status = acpi_install_address_space_handler (ec->handle,
@@ -715,13 +725,10 @@
 			&acpi_ec_space_setup, ec);
 	if (ACPI_FAILURE(status)) {
 		acpi_remove_gpe_handler(ec->gpe_bit, &acpi_ec_gpe_handler);
-		result = -ENODEV;
-		goto end;
+		return_VALUE(-ENODEV);
 	}
-end:
-	acpi_os_free(buffer.pointer);
 
-	return_VALUE(result);
+	return_VALUE(AE_OK);
 }
 
 
diff -u -ur acpi-3/drivers/acpi/pci_link.c acpi-4/drivers/acpi/pci_link.c
--- acpi-3/drivers/acpi/pci_link.c	2003-01-16 19:21:38.000000000 -0700
+++ acpi-4/drivers/acpi/pci_link.c	2003-02-09 22:13:53.000000000 -0700
@@ -90,42 +90,25 @@
                             PCI Link Device Management
    -------------------------------------------------------------------------- */
 
-static int
-acpi_pci_link_get_possible (
-	struct acpi_pci_link	*link)
+static acpi_status
+acpi_pci_link_check_possible (
+	struct acpi_resource	*resource,
+	void			*context)
 {
-	int                     result = 0;
-	acpi_status		status = AE_OK;
-	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct acpi_resource	*resource = NULL;
+	struct acpi_pci_link	*link = (struct acpi_pci_link *) context;
 	int			i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_get_possible");
-
-	if (!link)
-		return_VALUE(-EINVAL);
-
-	status = acpi_get_possible_resources(link->handle, &buffer);
-	if (ACPI_FAILURE(status) || !buffer.pointer) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRS\n"));
-		result = -ENODEV;
-		goto end;
-	}
-
-	resource = (struct acpi_resource *) buffer.pointer;
-
-	/* skip past dependent function resource (if present) */
-	if (resource->id == ACPI_RSTYPE_START_DPF)
-		resource = ACPI_NEXT_RESOURCE(resource);
+	ACPI_FUNCTION_TRACE("acpi_pci_link_check_possible");
 
 	switch (resource->id) {
+	case ACPI_RSTYPE_START_DPF:
+		return AE_OK;
 	case ACPI_RSTYPE_IRQ:
 	{
 		struct acpi_resource_irq *p = &resource->data.irq;
 		if (!p || !p->number_of_interrupts) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Blank IRQ resource\n"));
-			result = -ENODEV;
-			goto end;
+			return AE_OK;
 		}
 		for (i = 0; (i<p->number_of_interrupts && i<ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 			if (!p->interrupts[i]) {
@@ -143,8 +126,7 @@
 		if (!p || !p->number_of_interrupts) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, 
 				"Blank IRQ resource\n"));
-			result = -ENODEV;
-			goto end;
+			return AE_OK;
 		}
 		for (i = 0; (i<p->number_of_interrupts && i<ACPI_PCI_LINK_MAX_POSSIBLE); i++) {
 			if (!p->interrupts[i]) {
@@ -159,18 +141,76 @@
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
 			"Resource is not an IRQ entry\n"));
-		result = -ENODEV;
-		goto end;
-		break;
+		return AE_OK;
 	}
-	
+
+	return AE_CTRL_TERMINATE;
+}
+
+
+static int
+acpi_pci_link_get_possible (
+	struct acpi_pci_link	*link)
+{
+	acpi_status		status;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_get_possible");
+
+	if (!link)
+		return_VALUE(-EINVAL);
+
+	status = acpi_walk_resources(link->handle, METHOD_NAME__PRS,
+			acpi_pci_link_check_possible, link);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _PRS\n"));
+		return_VALUE(-ENODEV);
+	}
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
 		"Found %d possible IRQs\n", link->irq.possible_count));
 
-end:
-	acpi_os_free(buffer.pointer);
+	return_VALUE(0);
+}
 
-	return_VALUE(result);
+
+static acpi_status
+acpi_pci_link_check_current (
+	struct acpi_resource	*resource,
+	void			*context)
+{
+	int			*irq = (int *) context;
+
+	ACPI_FUNCTION_TRACE("acpi_pci_link_check_current");
+
+	switch (resource->id) {
+	case ACPI_RSTYPE_IRQ:
+	{
+		struct acpi_resource_irq *p = &resource->data.irq;
+		if (!p || !p->number_of_interrupts) {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Blank IRQ resource\n"));
+			return AE_OK;
+		}
+		*irq = p->interrupts[0];
+		break;
+	}
+	case ACPI_RSTYPE_EXT_IRQ:
+	{
+		struct acpi_resource_ext_irq *p = &resource->data.extended_irq;
+		if (!p || !p->number_of_interrupts) {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Blank IRQ resource\n"));
+			return AE_OK;
+		}
+		*irq = p->interrupts[0];
+		break;
+	}
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Resource isn't an IRQ\n"));
+		return AE_OK;
+	}
+	return AE_CTRL_TERMINATE;
 }
 
 
@@ -180,8 +220,6 @@
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
-	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct acpi_resource	*resource = NULL;
 	int			irq = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_get_current");
@@ -206,47 +244,16 @@
 	 * Query and parse _CRS to get the current IRQ assignment. 
 	 */
 
-	status = acpi_get_current_resources(link->handle, &buffer);
+	status = acpi_walk_resources(link->handle, METHOD_NAME__CRS,
+			acpi_pci_link_check_current, &irq);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _CRS\n"));
 		result = -ENODEV;
 		goto end;
 	}
-	resource = (struct acpi_resource *) buffer.pointer;
-
-	switch (resource->id) {
-	case ACPI_RSTYPE_IRQ:
-	{
-		struct acpi_resource_irq *p = &resource->data.irq;
-		if (!p || !p->number_of_interrupts) {
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN, 
-				"Blank IRQ resource\n"));
-			result = -ENODEV;
-			goto end;
-		}
-		irq = p->interrupts[0];
-		break;
-	}
-	case ACPI_RSTYPE_EXT_IRQ:
-	{
-		struct acpi_resource_ext_irq *p = &resource->data.extended_irq;
-		if (!p || !p->number_of_interrupts) {
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				"Blank IRQ resource\n"));
-			result = -ENODEV;
-			goto end;
-		}
-		irq = p->interrupts[0];
-		break;
-	}
-	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Resource isn't an IRQ\n"));
-		result = -ENODEV;
-		goto end;
-	}
 
 	if (!irq) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid use of IRQ 0\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No IRQ resource found\n"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -263,8 +270,6 @@
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
 
 end:
-	acpi_os_free(buffer.pointer);
-
 	return_VALUE(result);
 }
 
diff -u -ur acpi-3/drivers/hotplug/acpiphp_glue.c acpi-4/drivers/hotplug/acpiphp_glue.c
--- acpi-3/drivers/hotplug/acpiphp_glue.c	2003-01-16 19:22:00.000000000 -0700
+++ acpi-4/drivers/hotplug/acpiphp_glue.c	2003-02-09 22:26:20.000000000 -0700
@@ -229,136 +229,55 @@
 /* decode ACPI _CRS data and convert into our internal resource list
  * TBD: _TRA, etc.
  */
-static void
-decode_acpi_resource (struct acpi_resource *resource, struct acpiphp_bridge *bridge)
+static acpi_status
+decode_acpi_resource (struct acpi_resource *resource, void *context)
 {
-	struct acpi_resource_address16 *address16_data;
-	struct acpi_resource_address32 *address32_data;
-	struct acpi_resource_address64 *address64_data;
+	struct acpiphp_bridge *bridge = (struct acpiphp_bridge *) context;
+	struct acpi_resource_address64 address;
 	struct pci_resource *res;
 
-	u32 resource_type, producer_consumer, address_length;
-	u64 min_address_range, max_address_range;
-	u16 cache_attribute = 0;
-
-	int done = 0, found;
-
-	/* shut up gcc */
-	resource_type = producer_consumer = address_length = 0;
-	min_address_range = max_address_range = 0;
-
-	while (!done) {
-		found = 0;
-
-		switch (resource->id) {
-		case ACPI_RSTYPE_ADDRESS16:
-			address16_data = (struct acpi_resource_address16 *)&resource->data;
-			resource_type = address16_data->resource_type;
-			producer_consumer = address16_data->producer_consumer;
-			min_address_range = address16_data->min_address_range;
-			max_address_range = address16_data->max_address_range;
-			address_length = address16_data->address_length;
-			if (resource_type == ACPI_MEMORY_RANGE)
-				cache_attribute = address16_data->attribute.memory.cache_attribute;
-			found = 1;
-			break;
+	if (resource->id != ACPI_RSTYPE_ADDRESS16 &&
+	    resource->id != ACPI_RSTYPE_ADDRESS32 &&
+	    resource->id != ACPI_RSTYPE_ADDRESS64)
+		return AE_OK;
 
-		case ACPI_RSTYPE_ADDRESS32:
-			address32_data = (struct acpi_resource_address32 *)&resource->data;
-			resource_type = address32_data->resource_type;
-			producer_consumer = address32_data->producer_consumer;
-			min_address_range = address32_data->min_address_range;
-			max_address_range = address32_data->max_address_range;
-			address_length = address32_data->address_length;
-			if (resource_type == ACPI_MEMORY_RANGE)
-				cache_attribute = address32_data->attribute.memory.cache_attribute;
-			found = 1;
-			break;
+	acpi_resource_to_address64(resource, &address);
 
-		case ACPI_RSTYPE_ADDRESS64:
-			address64_data = (struct acpi_resource_address64 *)&resource->data;
-			resource_type = address64_data->resource_type;
-			producer_consumer = address64_data->producer_consumer;
-			min_address_range = address64_data->min_address_range;
-			max_address_range = address64_data->max_address_range;
-			address_length = address64_data->address_length;
-			if (resource_type == ACPI_MEMORY_RANGE)
-				cache_attribute = address64_data->attribute.memory.cache_attribute;
-			found = 1;
-			break;
+	if (address.producer_consumer == ACPI_PRODUCER && address.address_length > 0) {
+		dbg("resource type: %d: 0x%lx - 0x%lx\n", address.resource_type, address.min_address_range, address.max_address_range);
+		res = acpiphp_make_resource(address.min_address_range,
+				    address.address_length);
+		if (!res) {
+			err("out of memory\n");
+			return AE_OK;
+		}
 
-		case ACPI_RSTYPE_END_TAG:
-			done = 1;
+		switch (address.resource_type) {
+		case ACPI_MEMORY_RANGE:
+			if (address.attribute.memory.cache_attribute == ACPI_PREFETCHABLE_MEMORY) {
+				res->next = bridge->p_mem_head;
+				bridge->p_mem_head = res;
+			} else {
+				res->next = bridge->mem_head;
+				bridge->mem_head = res;
+			}
+			break;
+		case ACPI_IO_RANGE:
+			res->next = bridge->io_head;
+			bridge->io_head = res;
+			break;
+		case ACPI_BUS_NUMBER_RANGE:
+			res->next = bridge->bus_head;
+			bridge->bus_head = res;
 			break;
-
 		default:
-			/* ignore */
+			/* invalid type */
+			kfree(res);
 			break;
 		}
-
-		resource = (struct acpi_resource *)((char*)resource + resource->length);
-
-		if (found && producer_consumer == ACPI_PRODUCER && address_length > 0) {
-			switch (resource_type) {
-			case ACPI_MEMORY_RANGE:
-				if (cache_attribute == ACPI_PREFETCHABLE_MEMORY) {
-					dbg("resource type: prefetchable memory 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
-					res = acpiphp_make_resource(min_address_range,
-							    address_length);
-					if (!res) {
-						err("out of memory\n");
-						return;
-					}
-					res->next = bridge->p_mem_head;
-					bridge->p_mem_head = res;
-				} else {
-					dbg("resource type: memory 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
-					res = acpiphp_make_resource(min_address_range,
-							    address_length);
-					if (!res) {
-						err("out of memory\n");
-						return;
-					}
-					res->next = bridge->mem_head;
-					bridge->mem_head = res;
-				}
-				break;
-			case ACPI_IO_RANGE:
-				dbg("resource type: io 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
-				res = acpiphp_make_resource(min_address_range,
-						    address_length);
-				if (!res) {
-					err("out of memory\n");
-					return;
-				}
-				res->next = bridge->io_head;
-				bridge->io_head = res;
-				break;
-			case ACPI_BUS_NUMBER_RANGE:
-				dbg("resource type: bus number %d - %d\n", (u32)min_address_range, (u32)max_address_range);
-				res = acpiphp_make_resource(min_address_range,
-						    address_length);
-				if (!res) {
-					err("out of memory\n");
-					return;
-				}
-				res->next = bridge->bus_head;
-				bridge->bus_head = res;
-				break;
-			default:
-				/* invalid type */
-				break;
-			}
-		}
 	}
 
-	acpiphp_resource_sort_and_combine(&bridge->io_head);
-	acpiphp_resource_sort_and_combine(&bridge->mem_head);
-	acpiphp_resource_sort_and_combine(&bridge->p_mem_head);
-	acpiphp_resource_sort_and_combine(&bridge->bus_head);
-
-	dbg("ACPI _CRS resource:\n");
-	acpiphp_dump_resource(bridge);
+	return AE_OK;
 }
 
 
@@ -476,9 +395,6 @@
 static void add_host_bridge (acpi_handle *handle, int seg, int bus)
 {
 	acpi_status status;
-	struct acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
-				      .pointer = NULL};
-
 	struct acpiphp_bridge *bridge;
 
 	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
@@ -501,7 +417,8 @@
 
 	/* decode resources */
 
-	status = acpi_get_current_resources(handle, &buffer);
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+		decode_acpi_resource, bridge);
 
 	if (ACPI_FAILURE(status)) {
 		err("failed to decode bridge resources\n");
@@ -509,8 +426,13 @@
 		return;
 	}
 
-	decode_acpi_resource(buffer.pointer, bridge);
-	kfree(buffer.pointer);
+	acpiphp_resource_sort_and_combine(&bridge->io_head);
+	acpiphp_resource_sort_and_combine(&bridge->mem_head);
+	acpiphp_resource_sort_and_combine(&bridge->p_mem_head);
+	acpiphp_resource_sort_and_combine(&bridge->bus_head);
+
+	dbg("ACPI _CRS resource:\n");
+	acpiphp_dump_resource(bridge);
 
 	if (bridge->bus_head) {
 		bridge->bus = bridge->bus_head->base;

