Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbTGLQGn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbTGLQGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:06:42 -0400
Received: from fmr03.intel.com ([143.183.121.5]:8173 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S266092AbTGLQAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:00:52 -0400
Date: Sat, 12 Jul 2003 09:15:35 -0700
From: Dely Sy <dlsy@unix-os.sc.intel.com>
Message-Id: <200307121615.h6CGFZ128368@unix-os.sc.intel.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] 4/4 PCI Hot-plug driver patch for 2.5.74 kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4 of 4 PCI Hot-plug driver patch for 2.5.74 kernel

diff -Nru a/drivers/pci/hotplug/phprm_acpi.c b/drivers/pci/hotplug/phprm_acpi.c
--- a/drivers/pci/hotplug/phprm_acpi.c	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/pci/hotplug/phprm_acpi.c	2003-07-07 09:32:26.000000000 -0700
@@ -0,0 +1,1724 @@
+/*
+ * PHPRM ACPI: PHP Resource Manager for ACPI platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to (dely.l.sy@intel.com)
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/efi.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#ifdef	CONFIG_IA64
+#include <asm/iosapic.h>
+#endif
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/actypes.h>
+#include "cpqphp.h"
+#include "phprm.h"
+
+#define	PCI_MAX_BUS			0x100
+#define	ACPI_STA_DEVICE_PRESENT		0x01
+
+#define	METHOD_NAME__SUN		"_SUN"
+#define	METHOD_NAME__HPP		"_HPP"
+
+#define	PHP_RES_BUS		0xA0
+#define	PHP_RES_IO		0xA1
+#define	PHP_RES_MEM		0xA2
+#define	PHP_RES_PMEM		0xA3
+
+#define	BRIDGE_TYPE_P2P		0x00
+#define	BRIDGE_TYPE_HOST	0x01
+
+/* this should go to drivers/acpi/include/ */
+struct acpi__hpp {
+	u8	cache_line_size;
+	u8	latency_timer;
+	u8	enable_serr;
+	u8	enable_perr;
+};
+
+struct acpi_php_slot {
+	struct acpi_php_slot	*next;
+	struct acpi_bridge	*bridge;
+	acpi_handle	handle;
+	int	seg;
+	int	bus;
+	int	dev;
+	int	fun;
+	u32	sun;
+	struct pci_resource *mem_head;
+	struct pci_resource *p_mem_head;
+	struct pci_resource *io_head;
+	struct pci_resource *bus_head;
+	void	*slot_ops;	/* _STA, _EJx, etc */
+	struct slot *slot;
+};		/* per func */
+
+struct acpi_bridge {
+	struct acpi_bridge	*parent;
+	struct acpi_bridge	*next;
+	struct acpi_bridge	*child;
+	acpi_handle	handle;
+	int seg;
+	int pbus;			/* pdev->bus->number	*/
+	int pdevice;			/* PCI_SLOT(pdev->devfn)	*/
+	int pfunction;			/* PCI_DEVFN(pdev->devfn)	*/
+	int bus;			/* pdev->subordinate->number	*/
+	struct acpi__hpp		*_hpp;
+	struct acpi_php_slot	*slots;
+	struct pci_resource 	*tmem_head;	/* total from crs	*/
+	struct pci_resource 	*tp_mem_head;	/* total from crs	*/
+	struct pci_resource 	*tio_head;	/* total from crs	*/
+	struct pci_resource 	*tbus_head;	/* total from crs	*/
+	struct pci_resource 	*mem_head;	/* available	*/
+	struct pci_resource 	*p_mem_head;	/* available	*/
+	struct pci_resource 	*io_head;	/* available	*/
+	struct pci_resource 	*bus_head;	/* available	*/
+	int scanned;
+	int type;
+};
+
+struct acpi_bridge *acpi_bridges_head;
+
+static u8 * acpi_path_name( acpi_handle	handle)
+{
+	acpi_status		status;
+	static u8	path_name[ACPI_PATHNAME_MAX];
+	struct acpi_buffer		ret_buf = { ACPI_PATHNAME_MAX, path_name };
+
+	memset(path_name, 0, sizeof (path_name));
+	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &ret_buf);
+
+	if (ACPI_FAILURE(status))
+		return NULL;
+	else
+		return path_name;	
+}
+
+static void acpi_get__hpp ( struct acpi_bridge	*ab);
+
+static int acpi_add_slot_to_php_slots(
+	struct acpi_bridge	*ab,
+	int			bus_num,
+	acpi_handle		handle,
+	u32			adr,
+	u32			sun
+	)
+{
+	struct acpi_php_slot	*aps;
+	static long	samesun = -1;
+
+	aps = (struct acpi_php_slot *) kmalloc (sizeof(struct acpi_php_slot), GFP_KERNEL);
+	if (!aps) {
+		err ("acpi_phprm: alloc for aps fail\n");
+		return -1;
+	}
+	memset(aps, 0, sizeof(struct acpi_php_slot));
+
+	aps->handle = handle;
+	aps->bus = bus_num;
+	aps->dev = (adr >> 16) & 0xffff;
+	aps->fun = adr & 0xffff;
+	aps->sun = sun;
+
+	aps->next = ab->slots;	/* cling to the bridge */
+	aps->bridge = ab;
+	ab->slots = aps;
+
+	ab->scanned += 1;
+	if (!ab->_hpp)
+		acpi_get__hpp(ab);
+
+	if (sun != samesun) {
+		info("acpi_phprm:   Slot sun(%x) at s:b:d:f=0x%02x:%02x:%02x:%02x\n", aps->sun, ab->seg, aps->bus, aps->dev, aps->fun);
+		samesun = sun;
+	}
+	return 0;
+}
+
+static void acpi_get__hpp ( struct acpi_bridge	*ab)
+{
+	acpi_status	status;
+	u8		nui[4];
+	struct acpi_buffer	ret_buf = { 0, NULL};
+	union acpi_object	*ext_obj, *package;
+	u8			*path_name = acpi_path_name(ab->handle);
+	int			i, len = 0;
+
+	/* get _hpp */
+	status = acpi_evaluate_object(ab->handle, METHOD_NAME__HPP, NULL, &ret_buf);
+	switch (status) {
+	case AE_BUFFER_OVERFLOW:
+		ret_buf.pointer = kmalloc (ret_buf.length, GFP_KERNEL);
+		if (!ret_buf.pointer) {
+			err ("acpi_phprm:%s alloc for _HPP fail\n", path_name);
+			return;
+		}
+		status = acpi_evaluate_object(ab->handle, METHOD_NAME__HPP, NULL, &ret_buf);
+		if (ACPI_SUCCESS(status))
+			break;
+	default:
+		if (ACPI_FAILURE(status)) {
+			err("acpi_phprm:%s _HPP fail=0x%x\n", path_name, status);
+			return;
+		}
+	}
+
+	ext_obj = (union acpi_object *) ret_buf.pointer;
+	if (ext_obj->type != ACPI_TYPE_PACKAGE) {
+		err ("acpi_phprm:%s _HPP obj not a package\n", path_name);
+		goto free_and_return;
+	}
+
+	len = ext_obj->package.count;
+	package = (union acpi_object *) ret_buf.pointer;
+	for ( i = 0; (i < len) || (i < 4); i++) {
+		ext_obj = (union acpi_object *) &package->package.elements[i];
+		switch (ext_obj->type) {
+		case ACPI_TYPE_INTEGER:
+			nui[i] = (u8)ext_obj->integer.value;
+			break;
+		default:
+			err ("acpi_phprm:%s _HPP obj type incorrect\n", path_name);
+			goto free_and_return;
+		}
+	}
+
+	ab->_hpp = kmalloc (sizeof (struct acpi__hpp), GFP_KERNEL);
+	memset(ab->_hpp, 0, sizeof(struct acpi__hpp));
+
+	ab->_hpp->cache_line_size	= nui[0];
+	ab->_hpp->latency_timer		= nui[1];
+	ab->_hpp->enable_serr		= nui[2];
+	ab->_hpp->enable_perr		= nui[3];
+
+	dbg("  _HPP: cache_line_size=0x%x\n", ab->_hpp->cache_line_size);
+	dbg("  _HPP: latency timer  =0x%x\n", ab->_hpp->latency_timer);
+	dbg("  _HPP: enable SERR    =0x%x\n", ab->_hpp->enable_serr);
+	dbg("  _HPP: enable PERR    =0x%x\n", ab->_hpp->enable_perr);
+
+free_and_return:
+	kfree(ret_buf.pointer);
+}
+
+static acpi_status acpi_evaluate_crs(
+	acpi_handle		handle,
+	struct acpi_resource	**retbuf
+	)
+{
+	acpi_status		status;
+	struct acpi_buffer	crsbuf;
+	u8			*path_name = acpi_path_name(handle);
+
+	crsbuf.length  = 0;
+	crsbuf.pointer = NULL;
+
+	status = acpi_get_current_resources (handle, &crsbuf);
+
+	switch (status) {
+	case AE_BUFFER_OVERFLOW:
+		break;		/* found */
+	case AE_NOT_FOUND:
+		dbg("acpi_phprm:%s _CRS not found\n", path_name);
+		return status;
+	default:
+		err ("acpi_phprm:%s _CRS fail=0x%x\n", path_name, status);
+		return status;
+	}
+
+	crsbuf.pointer = kmalloc (crsbuf.length, GFP_KERNEL);
+	if (!crsbuf.pointer) {
+		err ("acpi_phprm: alloc %ld bytes for %s _CRS fail\n", (ulong)crsbuf.length, path_name);
+		return AE_NO_MEMORY;
+	}
+
+	status = acpi_get_current_resources (handle, &crsbuf);
+	if (ACPI_FAILURE(status)) {
+		err("acpi_phprm: %s _CRS fail=0x%x.\n", path_name, status);
+		kfree(crsbuf.pointer);
+		return status;
+	}
+
+	*retbuf = crsbuf.pointer;
+
+	return status;
+}
+
+static void free_pci_resource ( struct pci_resource	*aprh)
+{
+	struct pci_resource	*res, *next;
+
+	for (res = aprh; res; res = next) {
+		next = res->next;
+		kfree(res);
+	}
+}
+
+static void print_pci_resource ( struct pci_resource	*aprh)
+{
+	struct pci_resource	*res;
+
+	for (res = aprh; res; res = res->next)
+		dbg("        base= 0x%x length= 0x%x\n", res->base, res->length);
+}
+
+static void print_slot_resources( struct acpi_php_slot	*aps)
+{
+	if (aps->bus_head) {
+		dbg("    BUS Resources:\n");
+		print_pci_resource (aps->bus_head);
+	}
+
+	if (aps->io_head) {
+		dbg("    IO Resources:\n");
+		print_pci_resource (aps->io_head);
+	}
+
+	if (aps->mem_head) {
+		dbg("    MEM Resources:\n");
+		print_pci_resource (aps->mem_head);
+	}
+
+	if (aps->p_mem_head) {
+		dbg("    PMEM Resources:\n");
+		print_pci_resource (aps->p_mem_head);
+	}
+}
+
+static void print_pci_resources( struct acpi_bridge	*ab)
+{
+	if (ab->tbus_head) {
+		dbg("    Total BUS Resources:\n");
+		print_pci_resource (ab->tbus_head);
+	}
+	if (ab->bus_head) {
+		dbg("    BUS Resources:\n");
+		print_pci_resource (ab->bus_head);
+	}
+
+	if (ab->tio_head) {
+		dbg("    Total IO Resources:\n");
+		print_pci_resource (ab->tio_head);
+	}
+	if (ab->io_head) {
+		dbg("    IO Resources:\n");
+		print_pci_resource (ab->io_head);
+	}
+
+	if (ab->tmem_head) {
+		dbg("    Total MEM Resources:\n");
+		print_pci_resource (ab->tmem_head);
+	}
+	if (ab->mem_head) {
+		dbg("    MEM Resources:\n");
+		print_pci_resource (ab->mem_head);
+	}
+
+	if (ab->tp_mem_head) {
+		dbg("    Total PMEM Resources:\n");
+		print_pci_resource (ab->tp_mem_head);
+	}
+	if (ab->p_mem_head) {
+		dbg("    PMEM Resources:\n");
+		print_pci_resource (ab->p_mem_head);
+	}
+	if (ab->_hpp) {
+		dbg("    _HPP: cache_line_size=0x%x\n", ab->_hpp->cache_line_size);
+		dbg("    _HPP: latency timer  =0x%x\n", ab->_hpp->latency_timer);
+		dbg("    _HPP: enable SERR    =0x%x\n", ab->_hpp->enable_serr);
+		dbg("    _HPP: enable PERR    =0x%x\n", ab->_hpp->enable_perr);
+	}
+}
+
+static int phprm_delete_resource(
+	struct pci_resource **aprh,
+	ulong base,
+	ulong size)
+{
+	struct pci_resource *res;
+	struct pci_resource *prevnode;
+	struct pci_resource *split_node;
+	ulong tbase;
+
+	cpqhp_resource_sort_and_combine(aprh);
+
+	for (res = *aprh; res; res = res->next) {
+		if (res->base > base)
+			continue;
+
+		if ((res->base + res->length) < (base + size))
+			continue;
+
+		if (res->base < base) {
+			tbase = base;
+
+			if ((res->length - (tbase - res->base)) < size)
+				continue;
+
+			split_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+			if (!split_node)
+				return -ENOMEM;
+
+			split_node->base = res->base;
+			split_node->length = tbase - res->base;
+			res->base = tbase;
+			res->length -= split_node->length;
+
+			split_node->next = res->next;
+			res->next = split_node;
+		}
+
+		if (res->length >= size) {
+			split_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+			if (!split_node)
+				return -ENOMEM;
+
+			split_node->base = res->base + size;
+			split_node->length = res->length - size;
+			res->length = size;
+
+			split_node->next = res->next;
+			res->next = split_node;
+		}
+
+		if (*aprh == res) {
+			*aprh = res->next;
+		} else {
+			prevnode = *aprh;
+			while (prevnode->next != res)
+				prevnode = prevnode->next;
+
+			prevnode->next = res->next;
+		}
+		res->next = NULL;
+		kfree(res);
+		break;
+	}
+
+	return 0;
+}
+
+static int phprm_delete_resources(
+	struct pci_resource **aprh,
+	struct pci_resource *this
+	)
+{
+	struct pci_resource *res;
+
+	for (res = this; res; res = res->next)
+		phprm_delete_resource(aprh, res->base, res->length);
+
+	return 0;
+}
+
+static int phprm_add_resource(
+	struct pci_resource **aprh,
+	ulong base,
+	ulong size)
+{
+	struct pci_resource *res;
+
+	for (res = *aprh; res; res = res->next) {
+		if ((res->base + res->length) == base) {
+			res->length += size;
+			size = 0L;
+			break;
+		}
+		if (res->next == *aprh)
+			break;
+	}
+
+	if (size) {
+		res = kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+		if (!res) {
+			err ("acpi_phprm: alloc for res fail\n");
+			return -ENOMEM;
+		}
+		memset(res, 0, sizeof (struct pci_resource));
+
+		res->base = base;
+		res->length = size;
+		res->next = *aprh;
+		*aprh = res;
+	}
+
+	return 0;
+}
+
+static int phprm_add_resources(
+	struct pci_resource **aprh,
+	struct pci_resource *this
+	)
+{
+	struct pci_resource *res;
+	int	rc = 0;
+
+	for (res = this; res && !rc; res = res->next)
+		rc = phprm_add_resource(aprh, res->base, res->length);
+
+	return rc;
+}
+
+static void acpi_parse_io (
+	struct acpi_bridge	*ab,
+	union acpi_resource_data	*data
+	)
+{
+	struct acpi_resource_io	*dataio;
+	dataio = (struct acpi_resource_io *) data;
+
+	dbg("Io Resource\n");
+	dbg("  %d bit decode\n", ACPI_DECODE_16 == dataio->io_decode ? 16:10);
+	dbg("  Range minimum base: %08X\n", dataio->min_base_address);
+	dbg("  Range maximum base: %08X\n", dataio->max_base_address);
+	dbg("  Alignment: %08X\n", dataio->alignment);
+	dbg("  Range Length: %08X\n", dataio->range_length);
+}
+
+static void acpi_parse_fixed_io (
+	struct acpi_bridge	*ab,
+	union acpi_resource_data	*data
+	)
+{
+	struct acpi_resource_fixed_io  *datafio;
+	datafio = (struct acpi_resource_fixed_io *) data;
+
+	dbg("Fixed Io Resource\n");
+	dbg("  Range base address: %08X", datafio->base_address);
+	dbg("  Range length: %08X", datafio->range_length);
+}
+
+static void acpi_parse_address16_32 (
+	struct acpi_bridge	*ab,
+	union acpi_resource_data	*data,
+	acpi_resource_type	id
+	)
+{
+	/* 
+	 * acpi_resource_address16 == acpi_resource_address32
+	 * acpi_resource_address16 *data16 = (acpi_resource_address16 *) data;
+	 */
+	struct acpi_resource_address32 *data32 = (struct acpi_resource_address32 *) data;
+	struct pci_resource **aprh, **tprh;
+
+	if (id == ACPI_RSTYPE_ADDRESS16)
+		dbg("acpi_phprm:16-Bit Address Space Resource\n");
+	else
+		dbg("acpi_phprm:32-Bit Address Space Resource\n");
+
+	switch (data32->resource_type) {
+	case ACPI_MEMORY_RANGE: 
+		dbg("  Resource Type: Memory Range\n");
+		aprh = &ab->mem_head;
+		tprh = &ab->tmem_head;
+
+		switch (data32->attribute.memory.cache_attribute) {
+		case ACPI_NON_CACHEABLE_MEMORY:
+			dbg("  Type Specific: Noncacheable memory\n");
+			break; 
+		case ACPI_CACHABLE_MEMORY:
+			dbg("  Type Specific: Cacheable memory\n");
+			break; 
+		case ACPI_WRITE_COMBINING_MEMORY:
+			dbg("  Type Specific: Write-combining memory\n");
+			break; 
+		case ACPI_PREFETCHABLE_MEMORY:
+			aprh = &ab->p_mem_head;
+			dbg("  Type Specific: Prefetchable memory\n");
+			break; 
+		default:
+			dbg("  Type Specific: Invalid cache attribute\n");
+			break;
+		}
+
+		dbg("  Type Specific: Read%s\n", ACPI_READ_WRITE_MEMORY == data32->attribute.memory.read_write_attribute ? "/Write":" Only");
+		break;
+
+	case ACPI_IO_RANGE: 
+		dbg("  Resource Type: I/O Range\n");
+		aprh = &ab->io_head;
+		tprh = &ab->tio_head;
+
+		switch (data32->attribute.io.range_attribute) {
+		case ACPI_NON_ISA_ONLY_RANGES:
+			dbg("  Type Specific: Non-ISA Io Addresses\n");
+			break; 
+		case ACPI_ISA_ONLY_RANGES:
+			dbg("  Type Specific: ISA Io Addresses\n");
+			break; 
+		case ACPI_ENTIRE_RANGE:
+			dbg("  Type Specific: ISA and non-ISA Io Addresses\n");
+			break; 
+		default:
+			dbg("  Type Specific: Invalid range attribute\n");
+			break;
+		}
+		break;
+
+	case ACPI_BUS_NUMBER_RANGE: 
+		dbg("  Resource Type: Bus Number Range(fixed)\n");
+		/* fixup to be compatible with the rest of php driver */
+		data32->min_address_range++;
+		data32->address_length--;
+		aprh = &ab->bus_head;
+		tprh = &ab->tbus_head;
+		break; 
+	default: 
+		dbg("  Resource Type: Invalid resource type. Exiting.\n");
+		return;
+	}
+
+	dbg("  Resource %s\n", ACPI_CONSUMER == data32->producer_consumer ? "Consumer":"Producer");
+	dbg("  %s decode\n", ACPI_SUB_DECODE == data32->decode ? "Subtractive":"Positive");
+	dbg("  Min address is %s fixed\n", ACPI_ADDRESS_FIXED == data32->min_address_fixed ? "":"not");
+	dbg("  Max address is %s fixed\n", ACPI_ADDRESS_FIXED == data32->max_address_fixed ? "":"not");
+	dbg("  Granularity: %08X\n", data32->granularity);
+	dbg("  Address range min: %08X\n", data32->min_address_range);
+	dbg("  Address range max: %08X\n", data32->max_address_range);
+	dbg("  Address translation offset: %08X\n", data32->address_translation_offset);
+	dbg("  Address Length: %08X\n", data32->address_length);
+
+	if (0xFF != data32->resource_source.index) {
+		dbg("  Resource Source Index: %X\n", data32->resource_source.index);
+		/* dbg("  Resource Source: %s\n", data32->resource_source.string_ptr); */
+	}
+
+	phprm_add_resource(aprh, data32->min_address_range, data32->address_length);
+}
+
+static acpi_status acpi_parse_crs(
+	struct acpi_bridge	*ab,
+	struct acpi_resource	*crsbuf
+	)
+{
+	acpi_status		status = AE_OK;
+	struct acpi_resource	*resource = crsbuf;
+	u8				count = 0;
+	u8				done = 0;
+
+	while (!done) {
+		dbg("acpi_phprm: PCI bus 0x%x Resource structure %x.\n", ab->bus, count++);
+		switch (resource->id) {
+		case ACPI_RSTYPE_IRQ:
+			dbg("Irq -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_DMA:
+			dbg("DMA -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_START_DPF:
+			dbg("Start DPF -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_END_DPF:
+			dbg("End DPF -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_IO:
+			acpi_parse_io (ab, &resource->data);
+			break; 
+		case ACPI_RSTYPE_FIXED_IO:
+			acpi_parse_fixed_io (ab, &resource->data);
+			break; 
+		case ACPI_RSTYPE_VENDOR:
+			dbg("Vendor -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_END_TAG:
+			dbg("End_tag -------- Resource\n");
+			done = 1;
+			break; 
+		case ACPI_RSTYPE_MEM24:
+			dbg("Mem24 -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_MEM32:
+			dbg("Mem32 -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_FIXED_MEM32:
+			dbg("Fixed Mem32 -------- Resource\n");
+			break; 
+		case ACPI_RSTYPE_ADDRESS16:
+			acpi_parse_address16_32(ab, &resource->data, ACPI_RSTYPE_ADDRESS16);
+			break; 
+		case ACPI_RSTYPE_ADDRESS32:
+			acpi_parse_address16_32(ab, &resource->data, ACPI_RSTYPE_ADDRESS32);
+			break; 
+		case ACPI_RSTYPE_ADDRESS64:
+			info("Address64 -------- Resource unparsed\n");
+			break; 
+		case ACPI_RSTYPE_EXT_IRQ:
+			dbg("Ext Irq -------- Resource\n");
+			break; 
+		default:
+			dbg("Invalid -------- resource type 0x%x\n", resource->id);
+			break;
+		}
+
+		resource = (struct acpi_resource *) ((char *)resource + resource->length);
+	}
+
+	return status;
+}
+
+static acpi_status acpi_get_crs( struct acpi_bridge	*ab)
+{
+	acpi_status		status;
+	struct acpi_resource	*crsbuf;
+
+	status = acpi_evaluate_crs(ab->handle, &crsbuf);
+	if (ACPI_SUCCESS(status)) {
+		status = acpi_parse_crs(ab, crsbuf);
+		kfree(crsbuf);
+
+		cpqhp_resource_sort_and_combine(&ab->bus_head);
+		cpqhp_resource_sort_and_combine(&ab->io_head);
+		cpqhp_resource_sort_and_combine(&ab->mem_head);
+		cpqhp_resource_sort_and_combine(&ab->p_mem_head);
+
+		phprm_add_resources (&ab->tbus_head, ab->bus_head);
+		phprm_add_resources (&ab->tio_head, ab->io_head);
+		phprm_add_resources (&ab->tmem_head, ab->mem_head);
+		phprm_add_resources (&ab->tp_mem_head, ab->p_mem_head);
+	}
+
+	return status;
+}
+
+/* find acpi_bridge downword from ab.  */
+static struct acpi_bridge *
+find_acpi_bridge_by_bus(
+	struct acpi_bridge *ab,
+	int seg,
+	int bus		/* pdev->subordinate->number */
+	)
+{
+	struct acpi_bridge	*lab = NULL;
+
+	if (!ab)
+		return NULL;
+
+	if ((ab->bus == bus) && (ab->seg == seg))
+		return ab;
+
+	if (ab->child)
+		lab = find_acpi_bridge_by_bus(ab->child, seg, bus);
+
+	if (!lab)
+	if (ab->next)
+		lab = find_acpi_bridge_by_bus(ab->next, seg, bus);
+
+	return lab;
+}
+
+/*
+ * Build a device tree of ACPI PCI Bridges
+ */
+static void phprm_acpi_register_a_bridge (
+	struct acpi_bridge	**head,
+	struct acpi_bridge	*pab,	/* parent bridge to which child bridge is added */
+	struct acpi_bridge	*cab	/* child bridge to add */
+	)
+{
+	struct acpi_bridge	*lpab;
+	struct acpi_bridge	*lcab;
+
+	lpab = find_acpi_bridge_by_bus(*head, pab->seg, pab->bus);
+	if (!lpab) {
+		if (!(pab->type & BRIDGE_TYPE_HOST))
+			warn("PCI parent bridge s:b(%x:%x) not in list.\n", pab->seg, pab->bus);
+		pab->next = *head;
+		*head = pab;
+		lpab = pab;
+	}
+
+	if ((cab->type & BRIDGE_TYPE_HOST) && (pab == cab))
+		return;
+
+	lcab = find_acpi_bridge_by_bus(*head, cab->seg, cab->bus);
+	if (lcab) {
+		if ((pab->bus != lcab->parent->bus) || (lcab->bus != cab->bus))
+			err("PCI child bridge s:b(%x:%x) in list with diff parent.\n", cab->seg, cab->bus);
+		return;
+	} else
+		lcab = cab;
+
+	lcab->parent = lpab;
+	lcab->next = lpab->child;
+	lpab->child = lcab;
+}
+
+
+static acpi_status phprm_acpi_build_php_slots_callback(
+	acpi_handle	handle,
+	u32		Level,
+	void		*context,
+	void		**retval
+	)
+{
+	ulong		bus_num;
+	ulong		seg_num;
+	ulong		sun, adr;
+	ulong		padr = 0;
+	acpi_handle		phandle = NULL;
+	struct acpi_bridge	*pab = (struct acpi_bridge *)context;
+	struct acpi_bridge	*lab;
+	acpi_status		status;
+	u8			*path_name = acpi_path_name(handle);
+
+	/* get _SUN */
+	status = acpi_evaluate_integer(handle, METHOD_NAME__SUN, NULL, &sun);
+	switch(status) {
+	case AE_NOT_FOUND:
+		return AE_OK;
+	default:
+		if (ACPI_FAILURE(status)) {
+			err("acpi_phprm:%s _SUN fail=0x%x\n", path_name, status);
+			return status;
+		}
+	}
+
+	/* get _ADR. _ADR must exist if _SUN exists */
+	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
+	if (ACPI_FAILURE(status)) {
+		err("acpi_phprm:%s _ADR fail=0x%x\n", path_name, status);
+		return status;
+	}
+
+	dbg("acpi_phprm:%s sun=0x%08x adr=0x%08x\n", path_name, (u32)sun, (u32)adr);
+
+	status = acpi_get_parent(handle, &phandle);
+	if (ACPI_FAILURE(status)) {
+		err("acpi_phprm:%s get_parent fail=0x%x\n", path_name, status);
+		return (status);
+	}
+
+	bus_num = pab->bus;
+	seg_num = pab->seg;
+
+	if (pab->bus == bus_num) {
+		lab = pab;
+	} else {
+		dbg("WARN: pab is not parent\n");
+		lab = find_acpi_bridge_by_bus(pab, seg_num, bus_num);
+		if (!lab) {
+			dbg("acpi_phprm: alloc new P2P bridge(%x) for sun(%08x)\n", (u32)bus_num, (u32)sun);
+			lab = (struct acpi_bridge *)kmalloc(sizeof(struct acpi_bridge), GFP_KERNEL);
+			if (!lab) {
+				err("acpi_phprm: alloc for ab fail\n");
+				return AE_NO_MEMORY;
+			}
+			memset(lab, 0, sizeof(struct acpi_bridge));
+
+			lab->handle = phandle;
+			lab->pbus = pab->bus;
+			lab->pdevice = (int)(padr >> 16) & 0xffff;
+			lab->pfunction = (int)(padr & 0xffff);
+			lab->bus = (int)bus_num;
+			lab->scanned = 0;
+			lab->type = BRIDGE_TYPE_P2P;
+
+			phprm_acpi_register_a_bridge (&acpi_bridges_head, pab, lab);
+		} else
+			dbg("acpi_phprm: found P2P bridge(%x) for sun(%08x)\n", (u32)bus_num, (u32)sun);
+	}
+
+	acpi_add_slot_to_php_slots(lab, (int)bus_num, handle, (u32)adr, (u32)sun);
+
+	return (status);
+}
+
+static int phprm_acpi_build_php_slots(
+	struct acpi_bridge	*ab,
+	u32			depth
+	)
+{
+	acpi_status	status;
+	u8		*path_name = acpi_path_name(ab->handle);
+
+	/* Walk down this pci bridge to get _SUNs if any behind P2P */
+	status = acpi_walk_namespace ( ACPI_TYPE_DEVICE,
+				ab->handle,
+				depth,
+				phprm_acpi_build_php_slots_callback,
+				ab,
+				NULL );
+	if (ACPI_FAILURE(status)) {
+		dbg("acpi_phprm:%s walk for _SUN on pci bridge seg:bus(%x:%x) fail=0x%x\n", path_name, ab->seg, ab->bus, status);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void build_a_bridge(
+	struct acpi_bridge	*pab,
+	struct acpi_bridge	*ab
+	)
+{
+	u8		*path_name = acpi_path_name(ab->handle);
+
+	phprm_acpi_register_a_bridge (&acpi_bridges_head, pab, ab);
+
+	switch (ab->type) {
+	case BRIDGE_TYPE_HOST:
+		dbg("acpi_phprm: Registered PCI HOST Bridge(%02x)    on s:b:d:f(%02x:%02x:%02x:%02x) [%s]\n",
+			ab->bus, ab->seg, ab->pbus, ab->pdevice, ab->pfunction, path_name);
+		break;
+	case BRIDGE_TYPE_P2P:
+		dbg("acpi_phprm: Registered PCI  P2P Bridge(%02x-%02x) on s:b:d:f(%02x:%02x:%02x:%02x) [%s]\n",
+			ab->pbus, ab->bus, ab->seg, ab->pbus, ab->pdevice, ab->pfunction, path_name);
+		break;
+	};
+
+	/* build any immediate PHP slots under this pci bridge */
+	phprm_acpi_build_php_slots(ab, 1);
+}
+
+struct acpi_bridge * add_p2p_bridge(
+	acpi_handle 		handle,
+	struct acpi_bridge	*pab,	/* parent */
+	ulong			adr
+	)
+{
+	struct acpi_bridge	*ab;
+	struct pci_dev		*pdev;
+	ulong			devnum, funcnum;
+	u8			*path_name = acpi_path_name(handle);
+
+	ab = (struct acpi_bridge *) kmalloc (sizeof(struct acpi_bridge), GFP_KERNEL);
+	if (!ab) {
+		err("acpi_phprm: alloc for ab fail\n");
+		return NULL;
+	}
+	memset(ab, 0, sizeof(struct acpi_bridge));
+
+	devnum = (adr >> 16) & 0xffff;
+	funcnum = adr & 0xffff;
+
+	pdev = pci_find_slot(pab->bus, PCI_DEVFN(devnum, funcnum));
+	if (!pdev || !pdev->subordinate) {
+		err("acpi_phprm:%s is not a P2P Bridge\n", path_name);
+		kfree(ab);
+		return NULL;
+	}
+
+	ab->handle = handle;
+	ab->seg = pab->seg;
+	ab->pbus = pab->bus;		/* or pdev->bus->number */
+	ab->pdevice = devnum;		/* or PCI_SLOT(pdev->devfn) */
+	ab->pfunction = funcnum;	/* or PCI_FUNC(pdev->devfn) */
+	ab->bus = pdev->subordinate->number;
+	ab->scanned = 0;
+	ab->type = BRIDGE_TYPE_P2P;
+
+	dbg("acpi_phprm: P2P(%x-%x) on pci=b:d:f(%x:%x:%x) acpi=b:d:f(%x:%x:%x) [%s]\n",
+		pab->bus, ab->bus, pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
+		pab->bus, (u32)devnum, (u32)funcnum, path_name);
+
+	build_a_bridge(pab, ab);
+
+	return ab;
+}
+
+static acpi_status scan_p2p_bridge(
+	acpi_handle		handle,
+	u32			Level,
+	void			*context,
+	void			**retval
+	)
+{
+	struct acpi_bridge	*pab = (struct acpi_bridge *)context;
+	struct acpi_bridge	*ab;
+	acpi_status		status;
+	ulong		adr = 0;
+	u8			*path_name = acpi_path_name(handle);
+	ulong		devnum, funcnum;
+	struct pci_dev	*pdev;
+
+	/* get device, function */
+	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND)
+			err("acpi_phprm:%s _ADR fail=0x%x\n", path_name, status);
+		return AE_OK;
+	}
+
+	devnum = (adr >> 16) & 0xffff;
+	funcnum = adr & 0xffff;
+
+	pdev = pci_find_slot(pab->bus, PCI_DEVFN(devnum, funcnum));
+	if (!pdev)
+		return AE_OK;
+	if (!pdev->subordinate)
+		return AE_OK;
+
+	ab = add_p2p_bridge(handle, pab, adr);
+	if (ab) {
+		status = acpi_walk_namespace ( ACPI_TYPE_DEVICE,
+					handle,
+					(u32)1,
+					scan_p2p_bridge,
+					ab,
+					NULL);
+		if (ACPI_FAILURE(status))
+			dbg("acpi_phprm:%s find_p2p fail=0x%x\n", path_name, status);
+	}
+
+	return AE_OK;
+}
+
+struct acpi_bridge * add_host_bridge(
+	acpi_handle handle,
+	ulong	segnum,
+	ulong	busnum
+	)
+{
+	ulong			adr = 0;
+	acpi_status		status;
+	struct acpi_bridge	*ab;
+	u8			*path_name = acpi_path_name(handle);
+
+	/* get device, function: host br adr is always 0000 though.  */
+	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
+	if (ACPI_FAILURE(status)) {
+		err("acpi_phprm:%s _ADR fail=0x%x\n", path_name, status);
+		return NULL;
+	}
+	dbg("acpi_phprm: ROOT PCI seg(0x%x)bus(0x%x)dev(0x%x)func(0x%x) [%s]\n", (u32)segnum, (u32)busnum, (u32)(adr >> 16) & 0xffff, (u32)adr & 0xffff, path_name);
+
+	ab = (struct acpi_bridge *) kmalloc (sizeof(struct acpi_bridge), GFP_KERNEL);
+	if (!ab) {
+		err("acpi_phprm: alloc for ab fail\n");
+		return NULL;
+	}
+	memset(ab, 0, sizeof(struct acpi_bridge));
+
+	ab->handle = handle;
+	ab->seg = (int)segnum;
+	ab->bus = ab->pbus = (int)busnum;
+	ab->pdevice = (int)(adr >> 16) & 0xffff;
+	ab->pfunction = (int)(adr & 0xffff);
+	ab->scanned = 0;
+	ab->type = BRIDGE_TYPE_HOST;
+
+	/* get root pci bridge's current resources */
+	status = acpi_get_crs(ab);
+	if (ACPI_FAILURE(status)) {
+		err("acpi_phprm:%s evaluate _CRS fail=0x%x\n", path_name, status);
+		kfree(ab);
+		return NULL;
+	}
+	build_a_bridge(ab, ab);
+
+	return ab;
+}
+
+static acpi_status acpi_scan_from_root_pci_callback (
+	acpi_handle	handle,
+	u32		Level,
+	void		*context,
+	void		**retval
+	)
+{
+	ulong		segnum = 0;
+	ulong		busnum = 0;
+	acpi_status		status;
+	struct acpi_bridge	*ab;
+	u8			*path_name = acpi_path_name(handle);
+
+	/* get bus number of this pci root bridge */
+	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL, &segnum);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			err("acpi_phprm:%s evaluate _SEG fail=0x%x\n", path_name, status);
+			return status;
+		}
+		segnum = 0;
+	}
+
+	/* get bus number of this pci root bridge */
+	status = acpi_evaluate_integer(handle, METHOD_NAME__BBN, NULL, &busnum);
+	if (ACPI_FAILURE(status)) {
+		err("acpi_phprm:%s evaluate _BBN fail=0x%x\n", path_name, status);
+		return (status);
+	}
+
+	ab = add_host_bridge(handle, segnum, busnum);
+	if (ab) {
+		status = acpi_walk_namespace ( ACPI_TYPE_DEVICE,
+					handle,
+					1,
+					scan_p2p_bridge,
+					ab,
+					NULL);
+		if (ACPI_FAILURE(status))
+			dbg("acpi_phprm:%s find_p2p fail=0x%x\n", path_name, status);
+	}
+
+	return AE_OK;
+}
+
+static int phprm_acpi_scan_pci (void)
+{
+	acpi_status	status;
+
+	status = acpi_get_devices ( PCI_ROOT_HID_STRING,
+				acpi_scan_from_root_pci_callback,
+				NULL,
+				NULL );
+	if (ACPI_FAILURE(status)) {
+		err("acpi_phprm:get_device PCI ROOT HID fail=0x%x\n", status);
+		return -1;
+	}
+
+	return 0;
+}
+
+int phprm_init(enum php_ctlr_type ctlr_type)
+{
+	int	rc;
+
+	if (ctlr_type != PCI)
+		return -ENODEV;
+
+	dbg("PHPRM ACPI init <enter>\n");
+	acpi_bridges_head = NULL;
+
+	/* construct PCI bus:device tree of acpi_handles */
+	rc = phprm_acpi_scan_pci();
+	if (rc)
+		return rc;
+
+	dbg("PHPRM ACPI init %s\n", (rc)?"fail":"success");
+	return rc;
+}
+
+static void free_a_slot(struct acpi_php_slot *aps)
+{
+	dbg("        free a php func of slot(0x%02x) on PCI b:d:f=0x%02x:%02x:%02x\n", aps->sun, aps->bus, aps->dev, aps->fun);
+
+	free_pci_resource (aps->io_head);
+	free_pci_resource (aps->bus_head);
+	free_pci_resource (aps->mem_head);
+	free_pci_resource (aps->p_mem_head);
+
+	kfree(aps);
+}
+
+static void free_a_bridge( struct acpi_bridge	*ab)
+{
+	struct acpi_php_slot	*aps, *next;
+
+	switch (ab->type) {
+	case BRIDGE_TYPE_HOST:
+		dbg("Free ACPI PCI HOST Bridge(%x) [%s] on s:b:d:f(%x:%x:%x:%x)\n",
+			ab->bus, acpi_path_name(ab->handle), ab->seg, ab->pbus, ab->pdevice, ab->pfunction);
+		break;
+	case BRIDGE_TYPE_P2P:
+		dbg("Free ACPI PCI P2P Bridge(%x-%x) [%s] on s:b:d:f(%x:%x:%x:%x)\n",
+			ab->pbus, ab->bus, acpi_path_name(ab->handle), ab->seg, ab->pbus, ab->pdevice, ab->pfunction);
+		break;
+	};
+
+	/* free slots first */
+	for (aps = ab->slots; aps; aps = next) {
+		next = aps->next;
+		free_a_slot(aps);
+	}
+
+	free_pci_resource (ab->io_head);
+	free_pci_resource (ab->tio_head);
+	free_pci_resource (ab->bus_head);
+	free_pci_resource (ab->tbus_head);
+	free_pci_resource (ab->mem_head);
+	free_pci_resource (ab->tmem_head);
+	free_pci_resource (ab->p_mem_head);
+	free_pci_resource (ab->tp_mem_head);
+
+	kfree(ab);
+}
+
+static void phprm_free_bridges ( struct acpi_bridge	*ab)
+{
+	if (ab->child)
+		phprm_free_bridges (ab->child);
+
+	if (ab->next)
+		phprm_free_bridges (ab->next);
+
+	free_a_bridge(ab);
+}
+
+void phprm_cleanup(void)
+{
+	phprm_free_bridges (acpi_bridges_head);
+}
+
+static int get_number_of_slots (
+	struct acpi_bridge	*ab,
+	int			selfonly
+	)
+{
+	struct acpi_php_slot	*aps;
+	int	prev_slot = -1;
+	int	slot_num = 0;
+
+	for ( aps = ab->slots; aps; aps = aps->next)
+		if (aps->dev != prev_slot) {
+			prev_slot = aps->dev;
+			slot_num++;
+		}
+
+	if (ab->child)
+		slot_num += get_number_of_slots (ab->child, 0);
+
+	if (selfonly)
+		return slot_num;
+
+	if (ab->next)
+		slot_num += get_number_of_slots (ab->next, 0);
+
+	return slot_num;
+}
+
+static int print_acpi_resources (struct acpi_bridge	*ab)
+{
+	struct acpi_php_slot		*aps;
+	int	i;
+
+	switch (ab->type) {
+	case BRIDGE_TYPE_HOST:
+		dbg("PCI HOST Bridge (%x) [%s]\n", ab->bus, acpi_path_name(ab->handle));
+		break;
+	case BRIDGE_TYPE_P2P:
+		dbg("PCI P2P Bridge (%x-%x) [%s]\n", ab->pbus, ab->bus, acpi_path_name(ab->handle));
+		break;
+	};
+
+	print_pci_resources (ab);
+
+	for ( i = -1, aps = ab->slots; aps; aps = aps->next) {
+		if (aps->dev == i)
+			continue;
+		dbg("  Slot sun(%x) s:b:d:f(%02x:%02x:%02x:%02x)\n", aps->sun, aps->seg, aps->bus, aps->dev, aps->fun);
+		print_slot_resources(aps);
+		i = aps->dev;
+	}
+
+	if (ab->child)
+		print_acpi_resources (ab->child);
+
+	if (ab->next)
+		print_acpi_resources (ab->next);
+
+	return 0;
+}
+
+int phprm_print_pirt(void)
+{
+	dbg("PHPRM ACPI Slots\n");
+	print_acpi_resources (acpi_bridges_head);
+	
+	return 0;
+}
+
+static struct acpi_php_slot * get_acpi_slot (
+	struct acpi_bridge *ab,
+	u32 sun
+	)
+{
+	struct acpi_php_slot	*aps = NULL;
+
+	for ( aps = ab->slots; aps; aps = aps->next)
+		if (aps->sun == sun)
+			return aps;
+
+	if (!aps && ab->child) {
+		aps = (struct acpi_php_slot *)get_acpi_slot (ab->child, sun);
+		if (aps)
+			return aps;
+	}
+
+	if (!aps && ab->next) {
+		aps = (struct acpi_php_slot *)get_acpi_slot (ab->next, sun);
+		if (aps)
+			return aps;
+	}
+
+	return aps;
+
+}
+
+void * phprm_get_slot(struct slot *slot)
+{
+	struct acpi_bridge	*ab = acpi_bridges_head;
+	struct acpi_php_slot	*aps = get_acpi_slot (ab, slot->number);
+
+	aps->slot = slot;
+
+	dbg("Got acpi slot sun(%x): s:b:d:f(%x:%x:%x:%x)\n", aps->sun, aps->seg, aps->bus, aps->dev, aps->fun);
+
+	return (void *)aps;
+}
+
+static int get_physical_slot_number (
+	struct acpi_bridge	*ab,
+	u32 *sun,
+	u8 bus_num,
+	u8 dev_num
+	)
+{
+	struct acpi_php_slot	*aps;
+	int	rc = 0;
+
+	for ( aps = ab->slots; aps; aps = aps->next) {
+		if (aps->bus == bus_num && aps->dev == dev_num) {
+			*sun = aps->sun;
+			return 0;
+		}
+	}
+
+	if (ab->child) {
+		rc = get_physical_slot_number (ab->child, sun, bus_num, dev_num);
+		if (!rc)
+			return 0;
+	}
+
+	if (ab->next) {
+		rc = get_physical_slot_number (ab->next, sun, bus_num, dev_num);
+		if (!rc)
+			return 0;
+	}
+
+	return -1;
+}
+
+int phprm_get_physical_slot_number(
+	struct controller *ctrl,
+	u32 *sun,
+	u8 bus_num,
+	u8 dev_num
+	)
+{
+	struct acpi_bridge	*ab = acpi_bridges_head;
+
+	return get_physical_slot_number (ab, sun, bus_num, dev_num);
+}
+
+int phprm_get_slot_mapping(
+	struct controller *ctrl,
+	u8 bus_num,
+	u8 dev_num,
+	u32 * slot_num
+	)
+{
+	return phprm_get_physical_slot_number(ctrl, slot_num, bus_num, dev_num);
+}
+
+static void phprm_dump_func_res( struct pci_func *fun)
+{
+	struct pci_func *func = fun;
+
+	if (func->bus_head) {
+		dbg(":    BUS Resources:\n");
+		print_pci_resource (func->bus_head);
+	}
+	if (func->io_head) {
+		dbg(":    IO Resources:\n");
+		print_pci_resource (func->io_head);
+	}
+	if (func->mem_head) {
+		dbg(":    MEM Resources:\n");
+		print_pci_resource (func->mem_head);
+	}
+	if (func->p_mem_head) {
+		dbg(":    PMEM Resources:\n");
+		print_pci_resource (func->p_mem_head);
+	}
+}
+
+static void phprm_dump_ctrl_res( struct controller *ctlr)
+{
+	struct controller *ctrl = ctlr;
+
+	if (ctrl->bus_head) {
+		dbg(":    BUS Resources:\n");
+		print_pci_resource (ctrl->bus_head);
+	}
+	if (ctrl->io_head) {
+		dbg(":    IO Resources:\n");
+		print_pci_resource (ctrl->io_head);
+	}
+	if (ctrl->mem_head) {
+		dbg(":    MEM Resources:\n");
+		print_pci_resource (ctrl->mem_head);
+	}
+	if (ctrl->p_mem_head) {
+		dbg(":    PMEM Resources:\n");
+		print_pci_resource (ctrl->p_mem_head);
+	}
+}
+
+static int phprm_get_used_resources (
+	struct controller *ctrl,
+	struct pci_func *func
+	)
+{
+	return cpqhp_save_used_resources (ctrl, func, !DISABLE_CARD);
+}
+
+static int configure_existing_function(
+	struct controller *ctrl,
+	struct pci_func *func
+	)
+{
+	int rc;
+
+	/* see how much resources the func has used. */
+	rc = phprm_get_used_resources (ctrl, func);
+
+	if (!rc) {
+		/* subtract the resources used by the func from ctrl resources */
+		rc  = phprm_delete_resources (&ctrl->bus_head, func->bus_head);
+		rc |= phprm_delete_resources (&ctrl->io_head, func->io_head);
+		rc |= phprm_delete_resources (&ctrl->mem_head, func->mem_head);
+		rc |= phprm_delete_resources (&ctrl->p_mem_head, func->p_mem_head);
+		if (rc)
+			warn("aCEF: cannot del used resources\n");
+	} else
+		err("aCEF: cannot get used resources\n");
+
+	return rc;
+}
+
+static int bind_pci_resources_to_slots ( struct controller *ctrl)
+{
+	struct pci_func *func;
+	int busn = ctrl->bus;
+	int devn, funn;
+	u32	vid;
+
+	for (devn = 0; devn < 32; devn++) {
+		for (funn = 0; funn < 8; funn++) {
+			if (devn == ctrl->device && funn == ctrl->function)
+				continue;
+			/* find out if this entry is for an occupied slot */
+			vid = 0xFFFFFFFF;
+			pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(devn, funn), PCI_VENDOR_ID, &vid);
+
+			if (vid != 0xFFFFFFFF) {
+				func = cpqhp_slot_find(busn, devn, funn);
+				if (!func)
+					continue;
+				configure_existing_function(ctrl, func);
+				dbg("aCCF:existing PCI 0x%x Func ResourceDump\n", ctrl->bus);
+				phprm_dump_func_res(func);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int bind_pci_resources(
+	struct controller 	*ctrl,
+	struct acpi_bridge	*ab
+	)
+{
+	int		status = 0;
+
+	if (ab->bus_head) {
+		dbg("bapr:  BUS Resources add on PCI 0x%x\n", ab->bus);
+		status = phprm_add_resources (&ctrl->bus_head, ab->bus_head);
+		if (phprm_delete_resources (&ab->bus_head, ctrl->bus_head))
+			warn("bapr:  cannot sub BUS Resource on PCI 0x%x\n", ab->bus);
+		if (status) {
+			err("bapr:  BUS Resource add on PCI 0x%x: fail=0x%x\n", ab->bus, status);
+			return status;
+		}
+	} else
+		info("bapr:  No BUS Resource on PCI 0x%x.\n", ab->bus);
+
+	if (ab->io_head) {
+		dbg("bapr:  IO Resources add on PCI 0x%x\n", ab->bus);
+		status = phprm_add_resources (&ctrl->io_head, ab->io_head);
+		if (phprm_delete_resources (&ab->io_head, ctrl->io_head))
+			warn("bapr:  cannot sub IO Resource on PCI 0x%x\n", ab->bus);
+		if (status) {
+			err("bapr:  IO Resource add on PCI 0x%x: fail=0x%x\n", ab->bus, status);
+			return status;
+		}
+	} else
+		info("bapr:  No  IO Resource on PCI 0x%x.\n", ab->bus);
+
+	if (ab->mem_head) {
+		dbg("bapr:  MEM Resources add on PCI 0x%x\n", ab->bus);
+		status = phprm_add_resources (&ctrl->mem_head, ab->mem_head);
+		if (phprm_delete_resources (&ab->mem_head, ctrl->mem_head))
+			warn("bapr:  cannot sub MEM Resource on PCI 0x%x\n", ab->bus);
+		if (status) {
+			err("bapr:  MEM Resource add on PCI 0x%x: fail=0x%x\n", ab->bus, status);
+			return status;
+		}
+	} else
+		info("bapr:  No MEM Resource on PCI 0x%x.\n", ab->bus);
+
+	if (ab->p_mem_head) {
+		dbg("bapr:  PMEM Resources add on PCI 0x%x\n", ab->bus);
+		status = phprm_add_resources (&ctrl->p_mem_head, ab->p_mem_head);
+		if (phprm_delete_resources (&ab->p_mem_head, ctrl->p_mem_head))
+			warn("bapr:  cannot sub PMEM Resource on PCI 0x%x\n", ab->bus);
+		if (status) {
+			err("bapr:  PMEM Resource add on PCI 0x%x: fail=0x%x\n", ab->bus, status);
+			return status;
+		}
+	} else
+		info("bapr:  No PMEM Resource on PCI 0x%x.\n", ab->bus);
+
+	return status;
+}
+
+static int no_pci_resources( struct acpi_bridge *ab)
+{
+	return !(ab->p_mem_head || ab->mem_head || ab->io_head || ab->bus_head);
+}
+
+static int find_pci_bridge_resources (
+	struct controller *ctrl,
+	struct acpi_bridge *ab
+	)
+{
+	int	rc = 0;
+	struct pci_func func;
+
+	memset(&func, 0, sizeof(struct pci_func));
+
+	func.bus = ab->pbus;
+	func.device = ab->pdevice;
+	func.function = ab->pfunction;
+	func.is_a_board = 1;
+
+	/* Get used resources for this PCI bridge */
+	rc = cpqhp_save_used_resources (ctrl, &func, !DISABLE_CARD);
+
+	ab->io_head = func.io_head;
+	ab->mem_head = func.mem_head;
+	ab->p_mem_head = func.p_mem_head;
+	ab->bus_head = func.bus_head;
+	if (ab->bus_head)
+		phprm_delete_resource(&ab->bus_head, ctrl->bus, 1);
+
+	return rc;
+}
+
+static int get_pci_resources_from_bridge(
+	struct controller *ctrl,
+	struct acpi_bridge *ab
+	)
+{
+	int	rc = 0;
+
+	dbg("grfb:  Get Resources for PCI 0x%x from actual PCI bridge 0x%x.\n", ctrl->bus, ab->bus);
+
+	rc = find_pci_bridge_resources (ctrl, ab);
+
+	cpqhp_resource_sort_and_combine(&ab->bus_head);
+	cpqhp_resource_sort_and_combine(&ab->io_head);
+	cpqhp_resource_sort_and_combine(&ab->mem_head);
+	cpqhp_resource_sort_and_combine(&ab->p_mem_head);
+
+	phprm_add_resources (&ab->tbus_head, ab->bus_head);
+	phprm_add_resources (&ab->tio_head, ab->io_head);
+	phprm_add_resources (&ab->tmem_head, ab->mem_head);
+	phprm_add_resources (&ab->tp_mem_head, ab->p_mem_head);
+
+	return rc;
+}
+
+static int get_pci_resources(
+	struct controller	*ctrl,
+	struct acpi_bridge	*ab
+	)
+{
+	int	rc = 0;
+
+	if (no_pci_resources(ab)) {
+		dbg("spbr:PCI 0x%x has no resources. Get parent resources.\n", ab->bus);
+		rc = get_pci_resources_from_bridge(ctrl, ab);
+	}
+
+	return rc;
+}
+
+/*
+ * Get resources for this ctrl.
+ *  1. get total resources from ACPI _CRS or bridge (this ctrl)
+ *  2. find used resources of existing adapters
+ *	3. subtract used resources from total resources
+ */
+int phprm_find_available_resources( struct controller *ctrl)
+{
+	int rc = 0;
+	struct acpi_bridge	*ab;
+
+	ab = find_acpi_bridge_by_bus(acpi_bridges_head, ctrl->seg, ctrl->bus);
+	if (!ab) {
+		err("pfar:cannot locate acpi bridge of PCI 0x%x.\n", ctrl->bus);
+		return -1;
+	}
+	if (no_pci_resources(ab)) {
+		rc = get_pci_resources(ctrl, ab);
+		if (rc) {
+			err("pfar:cannot get pci resources of PCI 0x%x.\n", ctrl->bus);
+			return -1;
+		}
+	}
+
+	rc = bind_pci_resources(ctrl, ab);
+	dbg("pfar:pre-Bind PCI 0x%x Ctrl Resource Dump\n", ctrl->bus);
+	phprm_dump_ctrl_res(ctrl);
+
+	bind_pci_resources_to_slots (ctrl);
+
+	dbg("pfar:post-Bind PCI 0x%x Ctrl Resource Dump\n", ctrl->bus);
+	phprm_dump_ctrl_res(ctrl);
+
+	return rc;
+}
+
+void phprm_get_slot_capability(
+	struct controller *ctrl,
+	struct slot *new_slot
+	)
+{
+	/* tbd; */
+}
+
+int phprm_set_hpp(
+	struct controller *ctrl,
+	struct pci_func *func,
+	u8	card_type
+	)
+{
+	struct acpi_bridge	*ab;
+	struct pci_bus lpci_bus, *pci_bus;
+	int			rc = 0;
+	unsigned int	devfn;
+	u8		cls= 0x08;	/* default cache line size	*/
+	u8		lt = 0x40;	/* default latency timer	*/
+	u8		ep = 0;
+	u8		es = 0;
+
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	pci_bus->number = func->bus;
+	devfn = PCI_DEVFN(func->device, func->function);
+
+	ab = find_acpi_bridge_by_bus(acpi_bridges_head, ctrl->seg, ctrl->bus);
+
+	if (ab) {
+		if (ab->_hpp) {
+			lt  = (u8)ab->_hpp->latency_timer;
+			cls = (u8)ab->_hpp->cache_line_size;
+			ep  = (u8)ab->_hpp->enable_perr;
+			es  = (u8)ab->_hpp->enable_serr;
+		} else
+			dbg("_hpp: no _hpp for B/D/F=%#x/%#x/%#x. use default value\n", func->bus, func->device, func->function);
+	} else
+		dbg("_hpp: no acpi bridge for B/D/F = %#x/%#x/%#x. use default value\n", func->bus, func->device, func->function);
+
+
+	if (card_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* set subordinate Latency Timer */
+		rc |= pci_bus_write_config_byte(pci_bus, devfn, PCI_SEC_LATENCY_TIMER, lt);
+	}
+
+	/* set base Latency Timer */
+	rc |= pci_bus_write_config_byte(pci_bus, devfn, PCI_LATENCY_TIMER, lt);
+	dbg("  set latency timer  =0x%02x: %x\n", lt, rc);
+
+	rc |= pci_bus_write_config_byte(pci_bus, devfn, PCI_CACHE_LINE_SIZE, cls);
+	dbg("  set cache_line_size=0x%02x: %x\n", cls, rc);
+
+	return rc;
+}
+
+void phprm_enable_card(
+	struct controller *ctrl,
+	struct pci_func *func,
+	u8 card_type)
+{
+	u16 command, cmd, bcommand, bcmd;
+	struct pci_bus lpci_bus, *pci_bus;
+	struct acpi_bridge	*ab;
+	unsigned int devfn;
+	int rc;
+
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	pci_bus->number = func->bus;
+	devfn = PCI_DEVFN(func->device, func->function);
+
+	rc = pci_bus_read_config_word(pci_bus, devfn, PCI_COMMAND, &command);
+
+	if (card_type == PCI_HEADER_TYPE_BRIDGE) {
+		rc = pci_bus_read_config_word(pci_bus, devfn, PCI_BRIDGE_CONTROL, &bcommand);
+	}
+
+	cmd = command  = command | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE
+		| PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+	bcmd = bcommand  = bcommand | PCI_BRIDGE_CTL_NO_ISA;
+
+	ab = find_acpi_bridge_by_bus(acpi_bridges_head, ctrl->seg, ctrl->bus);
+	if (ab) {
+		if (ab->_hpp) {
+			if (ab->_hpp->enable_perr) {
+				command |= PCI_COMMAND_PARITY;
+				bcommand |= PCI_BRIDGE_CTL_PARITY;
+			} else {
+				command &= ~PCI_COMMAND_PARITY;
+				bcommand &= ~PCI_BRIDGE_CTL_PARITY;
+			}
+			if (ab->_hpp->enable_serr) {
+				command |= PCI_COMMAND_SERR;
+				bcommand |= PCI_BRIDGE_CTL_SERR;
+			} else {
+				command &= ~PCI_COMMAND_SERR;
+				bcommand &= ~PCI_BRIDGE_CTL_SERR;
+			}
+		} else
+			dbg("no _hpp for B/D/F = %#x/%#x/%#x.\n", func->bus, func->device, func->function);
+	} else
+		dbg("no acpi bridge for B/D/F = %#x/%#x/%#x.\n", func->bus, func->device, func->function);
+
+	if (command != cmd) {
+		rc = pci_bus_write_config_word(pci_bus, devfn, PCI_COMMAND, command);
+	}
+	if ((card_type == PCI_HEADER_TYPE_BRIDGE) && (bcommand != bcmd)) {
+		rc = pci_bus_write_config_word(pci_bus, devfn, PCI_BRIDGE_CONTROL, bcommand);
+	}
+}
+
+
+
+
diff -Nru a/drivers/pci/hotplug/phprm.h b/drivers/pci/hotplug/phprm.h
--- a/drivers/pci/hotplug/phprm.h	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/pci/hotplug/phprm.h	2003-07-07 09:32:26.000000000 -0700
@@ -0,0 +1,50 @@
+/*
+ * PHPRM : PHP Resource Manager for ACPI/non-ACPI platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to (dely.l.sy@intel.com)
+ *
+ */
+
+#ifndef _PHPRM_H_
+#define _PHPRM_H_
+
+#ifdef	CONFIG_HOTPLUG_PCI_COMPAQ_INTEL_PHPRM_LEGACY
+#include "phprm_legacy.h"
+#endif
+
+int phprm_init(enum php_ctlr_type ct);
+void phprm_cleanup(void);
+int phprm_print_pirt(void);
+struct irq_routing_table *phprm_get_irq_routing_table(void);
+int phprm_get_physical_slot_number( struct controller *ctrl, u32 *sun, u8 bus_num, u8 dev_num);
+void *phprm_get_slot(struct slot *slot);
+int phprm_get_slot_mapping(struct controller *controller, u8 bus_num, u8 dev_num, u32 * slot);
+int phprm_find_available_resources(struct controller *ctrl);
+void phprm_get_slot_capability( struct controller *ctrl, struct slot *new_slot);
+int phprm_set_hpp(struct controller *ctrl, struct pci_func *func, u8 card_type);
+void phprm_enable_card(struct controller *ctrl, struct pci_func *func, u8 card_type);
+
+#ifdef	DEBUG
+#define RES_CHECK(this, bits)	\
+	{ if (((this) & (bits - 1))) \
+		printk("%s:%d ERR: potential res loss!\n", __FUNCTION__, __LINE__); }
+#else
+#define RES_CHECK(this, bits)
+#endif
+
+#endif				/* _PHPRM_H_ */
diff -Nru a/drivers/pci/hotplug/phprm_legacy.c b/drivers/pci/hotplug/phprm_legacy.c
--- a/drivers/pci/hotplug/phprm_legacy.c	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/pci/hotplug/phprm_legacy.c	2003-07-07 09:32:27.000000000 -0700
@@ -0,0 +1,840 @@
+/*
+ * PHPRM LEGACY: PHP Resource Manager for Non-ACPI/Legacy platform
+ *
+ * Copyright (c) 1995,2001 Compaq Computer Corporation
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001 IBM
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <greg@kroah.com>
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#ifdef CONFIG_IA64
+#include <asm/iosapic.h>
+#endif
+#include "cpqphp.h"
+#include "phprm.h"
+#include "phprm_legacy.h"
+#include "cpqphp_nvram.h"
+
+static int nvram_loaded = 0;
+static void *cpqhp_rom_start;
+static void *smbios_start;
+static void *smbios_table;
+
+void phprm_cleanup()
+{
+	if (nvram_loaded)
+		compaq_nvram_store(cpqhp_rom_start);
+
+	if (cpqhp_rom_start)
+		iounmap(cpqhp_rom_start);
+	if (smbios_start)
+		iounmap(smbios_start);
+}
+
+#ifdef CONFIG_IA64
+void ia64_log_hexdump(unsigned char *p, unsigned long n_ch)
+{
+#ifdef DEBUG
+	int i, j;
+
+	if (!p)
+		return;
+
+	for (i = 0; i < n_ch;) {
+		info("%p ", (void *) p);
+		for (j = 0; (j < 16) && (i < n_ch); i++, j++, p++)
+			info("%02x ", *p);
+		info("\n");
+	}
+#endif
+}
+
+ /*
+  *     This is a replacement for a function no longer supported in the IA64
+  *     architecture specific subtree.  It gets the PCI IRQ Routing Table
+  *     and modifies the IA64 format to the IA32 format the rest of the
+  *     driver is written to interface with.
+  *     ! caller should not free the table !
+  * Return Value:
+  *     p_IRT           Ptr to the PCI IRQ Routing Table
+  */
+struct irq_routing_table *phprm_get_irq_routing_table(void)
+{
+	static struct irq_routing_table *p_irt_s = 0;
+	u8 *p_mapped_bios, *p;
+	u16 irt_size = 0;
+	int i;
+	union {
+		char array[4];
+		u32 dword;
+	} irt_sig = {
+	      array:{
+		'$', 'I', 'R', 'T'}
+	};
+
+	if (p_irt_s)
+		return p_irt_s;
+
+	/* Map BIOS to our memory space. */
+	if (!(p_mapped_bios = (u8 *) ioremap(ROM_PHY_ADDR, ROM_PHY_LEN)))
+		return NULL;
+
+	/*  String scan mapped memory for table signature. */
+	for (i = 0, p = p_mapped_bios; i < ROM_PHY_LEN; i += 16, p += 16) {
+		if (*(u32 *) p == irt_sig.dword) {
+			int j = i;
+			u8 *pe;
+			union {
+				char array[4];
+				u32 dword;
+			} ire_sig = {
+			      array:{
+				'$', 'I', 'R', 'E'}
+			};
+
+			/*
+			 * $IRT header is not reliable, so have to calculate table size
+			 * by finding table end ($IRE) and subtracting.
+			 */
+			for (j = i, pe = p; j < ROM_PHY_LEN; j += 16, pe += 16) {
+				if (*(u32 *) pe == ire_sig.dword) {
+					irt_size = (u16) (pe - p);
+					break;
+				}
+			}
+			if (j >= ROM_PHY_LEN) {
+				err("%s: can't find end of $IRT\n", __FUNCTION__);
+				goto err_unmap;
+			}
+
+			dbg("Found $IRT at %p length = %d\n", (void *) p, irt_size);
+			ia64_log_hexdump(p, (unsigned long) irt_size);
+
+			/* allocate +16 to reformat IA64 $IRT table to IA32 $PIR table. */
+			if (!(p_irt_s = kmalloc(irt_size + 16, GFP_KERNEL))) {
+				err("%s: can't allocate memory\n", __FUNCTION__);
+				goto err_unmap;
+			}
+			/*
+			 * copy IRT to buffer and extend header from 16 to 32 bytes to
+			 * approximate IA32 $PIR table.  Update table size
+			 */
+			memcpy((void *) p_irt_s + 16, p, irt_size);
+			memcpy((void *) p_irt_s, p, 16);
+			memset((void *) p_irt_s + 16, 0, 16);	/* clear extra 16 header pad bytes */
+			p_irt_s->size = irt_size + 16;
+
+#ifdef DEBUG
+			/* Calculate the number of entries in the table.  This will be the number of slots. */
+			slot_count = (irt_size - 16) / sizeof(struct irq_info);
+			dbg("$IRT contains %d slot entries\n", slot_count);
+#endif
+			break;
+		}
+	}
+
+err_unmap:
+	/* Unmap the BIOS */
+	iounmap(p_mapped_bios);
+
+	if (i >= ROM_PHY_LEN)
+		err("%s: $IRT not found\n", __FUNCTION__);
+
+	return (p_irt_s);
+}
+#else
+struct irq_routing_table *phprm_get_irq_routing_table(void)
+{
+	return (struct irq_routing_table *) pcibios_get_irq_routing_table();
+}
+#endif				/*  CONFIG_IA64 */
+
+int phprm_print_pirt()
+{
+	struct irq_routing_table *routing_table;
+	int len;
+	int loop;
+
+	u8 tbus, tdevice, tslot;
+	u8 tirq0lnk, tirq1lnk, tirq2lnk, tirq3lnk, trfu;
+	u16 tirq0bmp, tirq1bmp, tirq2bmp, tirq3bmp;
+
+	routing_table = phprm_get_irq_routing_table();
+	if (routing_table == NULL) {
+		err("No BIOS Routing Table??? Not good\n");
+		return -ENOMEM;
+	}
+
+	len = (routing_table->size - sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
+	/* Make sure I got at least one entry */
+	if (len == 0) {
+		return -1;
+	}
+
+	dbg("  bus dev func irq0.l irq0.b irq1.l irq1.b irq2.l irq2.b irq3.l irq3.b slot rfu\n");
+
+	for (loop = 0; loop < len; ++loop) {
+		tbus = routing_table->slots[loop].bus;
+		tdevice = routing_table->slots[loop].devfn;
+		tslot = routing_table->slots[loop].slot;
+		trfu = routing_table->slots[loop].rfu;
+		tirq0lnk = routing_table->slots[loop].irq[0].link;
+		tirq0bmp = routing_table->slots[loop].irq[0].bitmap;
+		tirq1lnk = routing_table->slots[loop].irq[1].link;
+		tirq1bmp = routing_table->slots[loop].irq[1].bitmap;
+		tirq2lnk = routing_table->slots[loop].irq[2].link;
+		tirq2bmp = routing_table->slots[loop].irq[2].bitmap;
+		tirq3lnk = routing_table->slots[loop].irq[3].link;
+		tirq3bmp = routing_table->slots[loop].irq[3].bitmap;
+		dbg("0x%3x %3x %4x %6x %6x %6x %6x %6x %6x %6x %6x %4x %3x\n", tbus, tdevice >> 3, tdevice & 0x7, tirq0lnk, tirq0bmp, tirq1lnk, tirq1bmp, tirq2lnk, tirq2bmp, tirq3lnk, tirq3bmp, tslot, trfu);
+	}
+
+	return 0;
+}
+
+/**
+ * find the system Management BIOS Table in the specified region of memory.
+ *
+ * @begin: begin pointer for region to be scanned.
+ * @end: end pointer for region to be scanned.
+ *
+ * Returns pointer to the head of the SMBIOS tables (or NULL)
+ */
+static void *detect_SMBIOS_pointer(void *begin, void *end)
+{
+	void *fp;
+	void *endp;
+	u8 temp1, temp2, temp3, temp4;
+	int status = 0;
+
+	endp = (end - sizeof(u32) + 1);
+
+	for (fp = begin; fp <= endp; fp += 16) {
+		temp1 = readb(fp);
+		temp2 = readb(fp + 1);
+		temp3 = readb(fp + 2);
+		temp4 = readb(fp + 3);
+		if (temp1 == '_' && temp2 == 'S' && temp3 == 'M' && temp4 == '_') {
+			status = 1;
+			break;
+		}
+	}
+
+	if (!status)
+		fp = NULL;
+
+	dbg("Discovered SMBIOS Entry point at %p\n", fp);
+
+	return fp;
+}
+
+/*
+ * Gets the first entry if previous == NULL
+ * Otherwise, returns the next entry
+ * Uses global SMBIOS Table pointer
+ *
+ * @curr: %NULL or pointer to previously returned structure
+ *
+ * returns a pointer to an SMBIOS structure or NULL if none found
+ */
+static void *get_subsequent_smbios_entry(void *smbios_start, void *smbios_table, void *curr)
+{
+	u8 bail = 0;
+	u8 previous_byte = 1;
+	void *p_temp;
+	void *p_max;
+
+	if (!smbios_table || !curr)
+		return (NULL);
+
+	/* set p_max to the end of the table */
+	p_max = smbios_start + readw(smbios_table + ST_LENGTH);
+
+	p_temp = curr;
+	p_temp += readb(curr + SMBIOS_GENERIC_LENGTH);
+
+	while ((p_temp < p_max) && !bail) {
+		/*
+		 * Look for the double NULL terminator
+		 * The first condition is the previous byte and the second is the curr
+		 */
+		if (!previous_byte && !(readb(p_temp)))
+			bail = 1;
+
+		previous_byte = readb(p_temp);
+		p_temp++;
+	}
+
+	if (p_temp < p_max)
+		return p_temp;
+	else
+		return NULL;
+}
+
+/**
+ * @type:SMBIOS structure type to be returned
+ * @previous: %NULL or pointer to previously returned structure
+ *
+ * Gets the first entry of the specified type if previous == NULL
+ * Otherwise, returns the next entry of the given type.
+ * Uses global SMBIOS Table pointer
+ * Uses get_subsequent_smbios_entry
+ *
+ * returns a pointer to an SMBIOS structure or %NULL if none found
+ */
+static void *get_SMBIOS_entry(void *smbios_start, void *smbios_table, u8 type, void *previous)
+{
+	if (!smbios_table)
+		return NULL;
+
+	if (!previous)
+		previous = smbios_start;
+	else {
+		previous = get_subsequent_smbios_entry(smbios_start, smbios_table, previous);
+	}
+
+	while (previous) {
+		if (readb(previous + SMBIOS_GENERIC_TYPE) != type) {
+			previous = get_subsequent_smbios_entry(smbios_start, smbios_table, previous);
+		} else
+			break;
+	}
+
+	return previous;
+}
+
+void * phprm_get_slot(struct slot *slot)
+{
+	return NULL;
+}
+
+int phprm_get_physical_slot_number(struct controller *ctrl, u32 *sun, u8 busnum, u8 devnum)
+{
+	int	offset = devnum - ctrl->first_device_num;
+
+	*sun = (u8) (ctrl->first_slot + ctrl->slot_num_inc * offset);
+	return 0;
+}
+
+/*
+ * Description: Attempts to determine a logical slot mapping for a PCI
+ *      device.  Won't work for more than one PCI-PCI bridge
+ *      in a slot.
+ *
+ * Input:   u8 bus_num - bus number of PCI device
+ *      u8 dev_num - device number of PCI device
+ *      u8 *slot - Pointer to u8 where slot number will
+ *          be returned
+ *
+ * Output:  SUCCESS or FAILURE
+ */
+int phprm_get_slot_mapping(
+	struct controller *ctrl, u8 bus_num, u8 dev_num, u32 * slot)
+{
+	struct irq_routing_table *PCIIRQRoutingInfoLength;
+	struct pci_bus lpci_bus, *pci_bus;
+	u32 work;
+	long len;
+	long loop;
+
+	u8 tbus, tdevice, tslot, bridgeSlot;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+
+	dbg("%s: %p, %d, %d, %p\n", __FUNCTION__, ctrl, bus_num, dev_num, slot);
+
+	bridgeSlot = 0xFF;
+
+	PCIIRQRoutingInfoLength = phprm_get_irq_routing_table();
+	if (!PCIIRQRoutingInfoLength) {
+		err("NULL irq_routing_table\n");
+		return -1;
+	}
+
+	len = (PCIIRQRoutingInfoLength->size - sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
+	/* Make sure I got at least one entry */
+	if (len == 0) {
+		kfree(PCIIRQRoutingInfoLength);
+		err("zero len irq_routing_table\n");
+		return -1;
+	}
+
+	for (loop = 0; loop < len; ++loop) {
+		tbus = PCIIRQRoutingInfoLength->slots[loop].bus;
+		tdevice = PCIIRQRoutingInfoLength->slots[loop].devfn >> 3;
+		tslot = PCIIRQRoutingInfoLength->slots[loop].slot;
+
+		if ((tbus == bus_num) && (tdevice == dev_num)) {
+			*slot = tslot;
+			kfree(PCIIRQRoutingInfoLength);
+			return 0;
+		} else {
+			/*
+			 * Didn't get a match on the target PCI device. Check if the
+			 * current IRQ table entry is a PCI-to-PCI bridge device.  If so,
+			 * and it's secondary bus matches the bus number for the target
+			 * device, I need to save the bridge's slot number.  If I can't
+			 * find an entry for the target device, I will have to assume it's
+			 * on the other side of the bridge, and assign it the bridge's slot.
+			 */
+			pci_bus->number = tbus;
+			pci_bus_read_config_dword(pci_bus, PCI_DEVFN(tdevice, 0), PCI_REVISION_ID, &work);
+
+			if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
+				pci_bus_read_config_dword(pci_bus, PCI_DEVFN(tdevice, 0), PCI_PRIMARY_BUS, &work);
+
+				/* See if bridge's secondary bus matches target bus. */
+				if (((work >> 8) & 0x000000FF) == (long) bus_num) {
+					bridgeSlot = tslot;
+				}
+			}
+		}
+
+	}
+
+	/*
+	 * If we got here, we didn't find an entry in the IRQ mapping table
+	 * for the target PCI device.  If we did determine that the target
+	 * device is on the other side of a PCI-to-PCI bridge, return the
+	 * slot number for the bridge.
+	 */
+	if (bridgeSlot != 0xFF) {
+		warn("irq_routing_table entry for bridge\n");
+		*slot = bridgeSlot;
+		kfree(PCIIRQRoutingInfoLength);
+		return 0;
+	}
+	/* Couldn't find an entry in the routing table for this PCI device */
+	err("no irq_routing_table entry\n");
+	kfree(PCIIRQRoutingInfoLength);
+	return -1;
+}
+
+void phprm_get_slot_capability(struct controller *ctrl, struct slot *new_slot)
+{
+	void *slot_entry = NULL;
+
+	slot_entry = get_SMBIOS_entry(smbios_start, smbios_table, 9, slot_entry);
+#ifdef CONFIG_IA64
+	while (slot_entry) {
+		/*  IA64 unaligned access workaround */
+		u8 slot_entry_slot_number = *(u8 *) &(((struct smbios_system_slot *) slot_entry)->slot_number);
+		if (slot_entry_slot_number == new_slot->number)
+			break;
+		slot_entry = get_SMBIOS_entry(smbios_start, smbios_table, 9, (struct smbios_generic *) slot_entry);
+	}
+#else
+	while (slot_entry && (((struct smbios_system_slot *) slot_entry)->slot_number != new_slot->number)) {
+		slot_entry = get_SMBIOS_entry(smbios_start, smbios_table, 9, slot_entry);
+	}
+#endif				/*  CONFIG_IA64 */
+	new_slot->p_sm_slot = slot_entry;
+}
+
+/* find the Hot Plug Resource Table in the specified region of memory */
+static void *detect_HRT_floating_pointer(void *begin, void *end)
+{
+	void *fp;
+	void *endp;
+	u8 temp1, temp2, temp3, temp4;
+	int status = 0;
+
+	endp = (end - sizeof(struct hrt) + 1);
+
+	for (fp = begin; fp <= endp; fp += 16) {
+		temp1 = readb(fp + SIG0);
+		temp2 = readb(fp + SIG1);
+		temp3 = readb(fp + SIG2);
+		temp4 = readb(fp + SIG3);
+		if (temp1 == '$' && temp2 == 'H' && temp3 == 'R' && temp4 == 'T') {
+			status = 1;
+			break;
+		}
+	}
+
+	if (!status)
+		fp = NULL;
+
+	dbg("Discovered Hotplug Resource Table at %p\n", fp);
+	return fp;
+}
+
+#if link_available
+/*
+ *  Links available memory, IO, and IRQ resources for programming
+ *  devices which may be added to the system
+ *
+ *  Returns 0 if success
+ */
+static int
+link_available_resources (
+	struct controller *ctrl,
+	struct pci_func *func,
+	int index )
+{
+	return cpqhp_save_used_resources (ctrl, func, !DISABLE_CARD);
+}
+#endif
+
+/*
+ * phprm_find_available_resources
+ *
+ *  Finds available memory, IO, and IRQ resources for programming
+ *  devices which may be added to the system
+ *  this function is for hot plug ADD!
+ *
+ * returns 0 if success
+ */
+int phprm_find_available_resources(struct controller *ctrl)
+{
+	u8 populated_slot;
+	u8 bridged_slot;
+	void *one_slot;
+	struct pci_func *func = NULL;
+	int i = 10, index = 0;
+	u32 temp_dword, rc;
+	ulong temp_ulong;
+	struct pci_resource *mem_node;
+	struct pci_resource *p_mem_node;
+	struct pci_resource *io_node;
+	struct pci_resource *bus_node;
+	void *rom_resource_table;
+	struct pci_bus lpci_bus, *pci_bus;
+
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	rom_resource_table = detect_HRT_floating_pointer(cpqhp_rom_start, cpqhp_rom_start + 0xffff);
+	dbg("rom_resource_table = %p\n", rom_resource_table);
+	if (rom_resource_table == NULL)
+		return -ENODEV;
+
+	rc = compaq_nvram_load(cpqhp_rom_start, ctrl);
+	if (rc)
+		return rc;
+	nvram_loaded = 1;
+
+	one_slot = rom_resource_table + sizeof(struct hrt);
+
+	i = readb(rom_resource_table + NUMBER_OF_ENTRIES);
+	dbg("number_of_entries = %d\n", i);
+
+	if (!readb(one_slot + SECONDARY_BUS))
+		return (1);
+
+	dbg("dev|IO base|length|MEMbase|length|PM base|length|PB SB MB\n");
+
+	while (i && readb(one_slot + SECONDARY_BUS)) {
+		u8 dev_func = readb(one_slot + DEV_FUNC);
+		u8 primary_bus = readb(one_slot + PRIMARY_BUS);
+		u8 secondary_bus = readb(one_slot + SECONDARY_BUS);
+		u8 max_bus = readb(one_slot + MAX_BUS);
+		u16 io_base = readw(one_slot + IO_BASE);
+		u16 io_length = readw(one_slot + IO_LENGTH);
+		u16 mem_base = readw(one_slot + MEM_BASE);
+		u16 mem_length = readw(one_slot + MEM_LENGTH);
+		u16 pre_mem_base = readw(one_slot + PRE_MEM_BASE);
+		u16 pre_mem_length = readw(one_slot + PRE_MEM_LENGTH);
+
+		dbg("%2.2x |  %4.4x | %4.4x |  %4.4x | %4.4x |  %4.4x | %4.4x |%2.2x %2.2x %2.2x\n",
+				dev_func, io_base, io_length, mem_base, mem_length, pre_mem_base, pre_mem_length,
+				primary_bus, secondary_bus, max_bus);
+
+		/* If this entry isn't for our controller's bus, ignore it */
+		if (primary_bus != ctrl->bus) {
+			i--;
+			one_slot += sizeof(struct slot_rt);
+			continue;
+		}
+		/* find out if this entry is for an occupied slot */
+		temp_dword = 0xFFFFFFFF;
+		pci_bus->number = primary_bus;
+
+		pci_bus_read_config_dword(pci_bus, dev_func, PCI_VENDOR_ID, &temp_dword);
+
+		dbg("temp_D_word = %x\n", temp_dword);
+
+		if (temp_dword != 0xFFFFFFFF) {
+			index = 0;
+			func = cpqhp_slot_find(primary_bus, dev_func >> 3, 0);
+
+			while (func && (func->function != (dev_func & 0x07))) {
+				dbg("func = %p b:d:f(%x:%x:%x)\n", func, primary_bus, dev_func >> 3, index);
+				func = cpqhp_slot_find(primary_bus, dev_func >> 3, index++);
+			}
+
+			/* If we can't find a match, skip this table entry */
+			if (!func) {
+				i--;
+				one_slot += sizeof(struct slot_rt);
+				continue;
+			}
+			/* this may not work and shouldn't be used */
+			if (secondary_bus != primary_bus)
+				bridged_slot = 1;
+			else
+				bridged_slot = 0;
+
+			populated_slot = 1;
+		} else {
+			populated_slot = 0;
+			bridged_slot = 0;
+		}
+		dbg("slot populated =%s \n", populated_slot?"yes":"no");
+
+		/* If we've got a valid IO base, use it */
+
+		temp_ulong = io_base + io_length;
+
+		if ((io_base) && (temp_ulong <= 0x10000)) {
+			io_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+			if (!io_node)
+				return -ENOMEM;
+
+			io_node->base = (ulong)io_base;
+			io_node->length = (ulong)io_length;
+			dbg("found io_node(base, length) = %x, %x\n", io_node->base, io_node->length);
+
+			if (!populated_slot) {
+				io_node->next = ctrl->io_head;
+				ctrl->io_head = io_node;
+			} else {
+				io_node->next = func->io_head;
+				func->io_head = io_node;
+			}
+		}
+
+		/* If we've got a valid memory base, use it */
+		temp_ulong = mem_base + mem_length;
+		if ((mem_base) && (temp_ulong <= 0x10000)) {
+			mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+			if (!mem_node)
+				return -ENOMEM;
+
+			mem_node->base = (ulong)mem_base << 16;
+			mem_node->length = (ulong)(mem_length << 16);
+			dbg("found mem_node(base, length) = %x, %x\n", mem_node->base, mem_node->length);
+
+			if (!populated_slot) {
+				mem_node->next = ctrl->mem_head;
+				ctrl->mem_head = mem_node;
+			} else {
+				mem_node->next = func->mem_head;
+				func->mem_head = mem_node;
+			}
+		}
+
+		/*
+		 * If we've got a valid prefetchable memory base, and
+		 * the base + length isn't greater than 0xFFFF
+		 */
+		temp_ulong = pre_mem_base + pre_mem_length;
+		if ((pre_mem_base) && (temp_ulong <= 0x10000)) {
+			p_mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+			if (!p_mem_node)
+				return -ENOMEM;
+
+			p_mem_node->base = (ulong)pre_mem_base << 16;
+			p_mem_node->length = (ulong)pre_mem_length << 16;
+			dbg("found p_mem_node(base, length) = %x, %x\n", p_mem_node->base, p_mem_node->length);
+
+			if (!populated_slot) {
+				p_mem_node->next = ctrl->p_mem_head;
+				ctrl->p_mem_head = p_mem_node;
+			} else {
+				p_mem_node->next = func->p_mem_head;
+				func->p_mem_head = p_mem_node;
+			}
+		}
+
+		/*
+		 * If we've got a valid bus number, use it
+		 * The second condition is to ignore bus numbers on
+		 * populated slots that don't have PCI-PCI bridges
+		 */
+		if (secondary_bus && (secondary_bus != primary_bus)) {
+			bus_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
+			if (!bus_node)
+				return -ENOMEM;
+
+			bus_node->base = (ulong)secondary_bus;
+			bus_node->length = (ulong)(max_bus - secondary_bus + 1);
+			dbg("found bus_node(base, length) = %x, %x\n", bus_node->base, bus_node->length);
+
+			if (!populated_slot) {
+				bus_node->next = ctrl->bus_head;
+				ctrl->bus_head = bus_node;
+			} else {
+				bus_node->next = func->bus_head;
+				func->bus_head = bus_node;
+			}
+		}
+
+#if link_available
+		++index;
+
+		while (index < 8) {
+			if (((func = cpqhp_slot_find(primary_bus, dev_func >> 3, index)) != NULL) && populated_slot)
+				rc = link_available_resources(ctrl, func, index);
+			
+			if (rc)
+				break;
+
+			++index;
+		}
+#endif
+		i--;
+		one_slot += sizeof(struct slot_rt);
+	}
+
+	dbg("rc = %d\n", rc);
+
+	/* If all of the following fail, we don't have any resources for hot plug add */
+	rc = 1;
+	rc &= cpqhp_resource_sort_and_combine(&(ctrl->mem_head));
+	rc &= cpqhp_resource_sort_and_combine(&(ctrl->p_mem_head));
+	rc &= cpqhp_resource_sort_and_combine(&(ctrl->io_head));
+	rc &= cpqhp_resource_sort_and_combine(&(ctrl->bus_head));
+
+	return (rc);
+}
+
+int phprm_set_hpp(
+	struct controller *ctrl,
+	struct pci_func *func,
+	u8	card_type)
+{
+	u32 rc;
+	u8 temp_byte;
+	struct pci_bus lpci_bus, *pci_bus;
+	unsigned int	devfn;
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	pci_bus->number = func->bus;
+	devfn = PCI_DEVFN(func->device, func->function);
+
+	temp_byte = 0x40;	/* hard coded value for LT */
+	if (card_type == PCI_HEADER_TYPE_BRIDGE) {
+		/* set subordinate Latency Timer */
+		rc = pci_bus_write_config_byte(pci_bus, devfn, PCI_SEC_LATENCY_TIMER, temp_byte);
+		if (rc) {
+			dbg("%s: set secondary LT error. b:d:f(%02x:%02x:%02x)\n", __FUNCTION__, func->bus, func->device, func->function);
+			return rc;
+		}
+	}
+
+	/* set base Latency Timer */
+	rc = pci_bus_write_config_byte(pci_bus, devfn, PCI_LATENCY_TIMER, temp_byte);
+	if (rc) {
+		dbg("%s: set LT error. b:d:f(%02x:%02x:%02x)\n", __FUNCTION__, func->bus, func->device, func->function);
+		return rc;
+	}
+
+	/* set Cache Line size */
+	temp_byte = 0x08;	/* hard coded value for CLS */
+	rc = pci_bus_write_config_byte(pci_bus, devfn, PCI_CACHE_LINE_SIZE, temp_byte);
+	if (rc) {
+		dbg("%s: set CLS error. b:d:f(%02x:%02x:%02x)\n", __FUNCTION__, func->bus, func->device, func->function);
+	}
+
+	/* set enable_perr */
+	/* set enable_serr */
+
+	return rc;
+}
+
+void phprm_enable_card(
+	struct controller *ctrl,
+	struct pci_func *func,
+	u8 card_type)
+{
+	u16 command, bcommand;
+	struct pci_bus lpci_bus, *pci_bus;
+	unsigned int devfn;
+	int rc;
+
+	memcpy(&lpci_bus, ctrl->pci_bus, sizeof(lpci_bus));
+	pci_bus = &lpci_bus;
+	pci_bus->number = func->bus;
+	devfn = PCI_DEVFN(func->device, func->function);
+
+	rc = pci_bus_read_config_word(pci_bus, devfn, PCI_COMMAND, &command);
+	command |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR
+		| PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE
+		| PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+	rc = pci_bus_write_config_word(pci_bus, devfn, PCI_COMMAND, command);
+
+	if (card_type == PCI_HEADER_TYPE_BRIDGE) {
+		rc = pci_bus_read_config_word(pci_bus, devfn, PCI_BRIDGE_CONTROL, &bcommand);
+		bcommand |= PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR
+			| PCI_BRIDGE_CTL_NO_ISA;
+		rc = pci_bus_write_config_word(pci_bus, devfn, PCI_BRIDGE_CONTROL, bcommand);
+	}
+}
+
+
+static int legacy_phprm_init_pci(void)
+{
+	cpqhp_rom_start = (u8 *) ioremap(ROM_PHY_ADDR, ROM_PHY_LEN);
+	if (!cpqhp_rom_start) {
+		err("Could not ioremap memory region for ROM\n");
+		return -EIO;
+	}
+
+	compaq_nvram_init(cpqhp_rom_start);
+
+	smbios_table = detect_SMBIOS_pointer(cpqhp_rom_start, (void *) (cpqhp_rom_start + ROM_PHY_LEN));
+	if (!smbios_table) {
+		err("Could not find the SMBIOS pointer in memory\n");
+		return -EIO;
+	}
+
+	smbios_start = ioremap(readl(smbios_table + ST_ADDRESS), readw(smbios_table + ST_LENGTH));
+	if (!smbios_start) {
+		err("Could not ioremap memory region taken from SMBIOS values\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int phprm_init(enum php_ctlr_type ctrl_type)
+{
+	int retval;
+
+	switch (ctrl_type) {
+	case PCI:
+		retval = legacy_phprm_init_pci();
+		break;
+	default:
+		retval = -ENODEV;
+		break;
+	}
+
+	return retval;
+}
diff -Nru a/drivers/pci/hotplug/phprm_legacy.h b/drivers/pci/hotplug/phprm_legacy.h
--- a/drivers/pci/hotplug/phprm_legacy.h	1969-12-31 16:00:00.000000000 -0800
+++ b/drivers/pci/hotplug/phprm_legacy.h	2003-07-07 09:32:27.000000000 -0700
@@ -0,0 +1,187 @@
+/*
+ * PHPRM ACPI: PHP Resource Manager for Non-ACPI/Legacy platform
+ *
+ * Copyright (c) 1995,2001 Compaq Computer Corporation
+ * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (c) 2001 IBM
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <greg@kroah.com>
+ *
+ */
+
+#ifndef _PHPRM_LEGACY_H_
+#define _PHPRM_LEGACY_H_
+
+struct smbios_system_slot {
+	u8 type;
+	u8 length;
+	u16 handle;
+	u8 name_string_num;
+	u8 slot_type;
+	u8 slot_width;
+	u8 slot_current_usage;
+	u8 slot_length;
+	u16 slot_number;
+	u8 properties1;
+	u8 properties2;
+} __attribute__ ((packed));
+
+/* offsets to the smbios generic type based on the above structure layout */
+enum smbios_system_slot_offsets {
+	SMBIOS_SLOT_GENERIC_TYPE = offsetof(struct smbios_system_slot, type),
+	SMBIOS_SLOT_GENERIC_LENGTH = offsetof(struct smbios_system_slot, length),
+	SMBIOS_SLOT_GENERIC_HANDLE = offsetof(struct smbios_system_slot, handle),
+	SMBIOS_SLOT_NAME_STRING_NUM =
+	    offsetof(struct smbios_system_slot, name_string_num),
+	SMBIOS_SLOT_TYPE = offsetof(struct smbios_system_slot, slot_type),
+	SMBIOS_SLOT_WIDTH = offsetof(struct smbios_system_slot, slot_width),
+	SMBIOS_SLOT_CURRENT_USAGE =
+	    offsetof(struct smbios_system_slot, slot_current_usage),
+	SMBIOS_SLOT_LENGTH = offsetof(struct smbios_system_slot, slot_length),
+	SMBIOS_SLOT_NUMBER = offsetof(struct smbios_system_slot, slot_number),
+	SMBIOS_SLOT_PROPERTIES1 = offsetof(struct smbios_system_slot, properties1),
+	SMBIOS_SLOT_PROPERTIES2 = offsetof(struct smbios_system_slot, properties2),
+};
+
+struct smbios_generic {
+	u8 type;
+	u8 length;
+	u16 handle;
+} __attribute__ ((packed));
+
+/* offsets to the smbios generic type based on the above structure layout */
+enum smbios_generic_offsets {
+	SMBIOS_GENERIC_TYPE = offsetof(struct smbios_generic, type),
+	SMBIOS_GENERIC_LENGTH = offsetof(struct smbios_generic, length),
+	SMBIOS_GENERIC_HANDLE = offsetof(struct smbios_generic, handle),
+};
+
+struct smbios_entry_point {
+	char anchor[4];
+	u8 ep_checksum;
+	u8 ep_length;
+	u8 major_version;
+	u8 minor_version;
+	u16 max_size_entry;
+	u8 ep_rev;
+	u8 reserved[5];
+	char int_anchor[5];
+	u8 int_checksum;
+	u16 st_length;
+	u32 st_address;
+	u16 number_of_entrys;
+	u8 bcd_rev;
+} __attribute__ ((packed));
+
+/* offsets to the smbios entry point based on the above structure layout */
+enum smbios_entry_point_offsets {
+	ANCHOR = offsetof(struct smbios_entry_point, anchor[0]),
+	EP_CHECKSUM = offsetof(struct smbios_entry_point, ep_checksum),
+	EP_LENGTH = offsetof(struct smbios_entry_point, ep_length),
+	MAJOR_VERSION = offsetof(struct smbios_entry_point, major_version),
+	MINOR_VERSION = offsetof(struct smbios_entry_point, minor_version),
+	MAX_SIZE_ENTRY = offsetof(struct smbios_entry_point, max_size_entry),
+	EP_REV = offsetof(struct smbios_entry_point, ep_rev),
+	INT_ANCHOR = offsetof(struct smbios_entry_point, int_anchor[0]),
+	INT_CHECKSUM = offsetof(struct smbios_entry_point, int_checksum),
+	ST_LENGTH = offsetof(struct smbios_entry_point, st_length),
+	ST_ADDRESS = offsetof(struct smbios_entry_point, st_address),
+	NUMBER_OF_ENTRYS = offsetof(struct smbios_entry_point, number_of_entrys),
+	BCD_REV = offsetof(struct smbios_entry_point, bcd_rev),
+};
+
+struct slot_rt {
+	u8 dev_func;
+	u8 primary_bus;
+	u8 secondary_bus;
+	u8 max_bus;
+	u16 io_base;
+	u16 io_length;
+	u16 mem_base;
+	u16 mem_length;
+	u16 pre_mem_base;
+	u16 pre_mem_length;
+} __attribute__ ((packed));
+
+/* offsets to the hotplug slot resource table registers based on the above structure layout */
+enum slot_rt_offsets {
+	DEV_FUNC = offsetof(struct slot_rt, dev_func),
+	PRIMARY_BUS = offsetof(struct slot_rt, primary_bus),
+	SECONDARY_BUS = offsetof(struct slot_rt, secondary_bus),
+	MAX_BUS = offsetof(struct slot_rt, max_bus),
+	IO_BASE = offsetof(struct slot_rt, io_base),
+	IO_LENGTH = offsetof(struct slot_rt, io_length),
+	MEM_BASE = offsetof(struct slot_rt, mem_base),
+	MEM_LENGTH = offsetof(struct slot_rt, mem_length),
+	PRE_MEM_BASE = offsetof(struct slot_rt, pre_mem_base),
+	PRE_MEM_LENGTH = offsetof(struct slot_rt, pre_mem_length),
+};
+
+struct hrt {
+	char sig0;
+	char sig1;
+	char sig2;
+	char sig3;
+	u16 unused_IRQ;
+	u16 PCIIRQ;
+	u8 number_of_entries;
+	u8 revision;
+	u16 reserved1;
+	u32 reserved2;
+} __attribute__ ((packed));
+
+/* offsets to the hotplug resource table registers based on the above structure layout */
+enum hrt_offsets {
+	SIG0 = offsetof(struct hrt, sig0),
+	SIG1 = offsetof(struct hrt, sig1),
+	SIG2 = offsetof(struct hrt, sig2),
+	SIG3 = offsetof(struct hrt, sig3),
+	UNUSED_IRQ = offsetof(struct hrt, unused_IRQ),
+	PCIIRQ = offsetof(struct hrt, PCIIRQ),
+	NUMBER_OF_ENTRIES = offsetof(struct hrt, number_of_entries),
+	REVISION = offsetof(struct hrt, revision),
+	HRT_RESERVED1 = offsetof(struct hrt, reserved1),
+	HRT_RESERVED2 = offsetof(struct hrt, reserved2),
+};
+
+struct irq_info {
+	u8 bus, devfn;		/* bus, device and function */
+	struct {
+		u8 link;	/* IRQ line ID, chipset dependent, 0=not routed */
+		u16 bitmap;	/* Available IRQs */
+	} __attribute__ ((packed)) irq[4];
+	u8 slot;		/* slot number, 0=onboard */
+	u8 rfu;
+} __attribute__ ((packed));
+
+struct irq_routing_table {
+	u32 signature;		/* PIRQ_SIGNATURE should be here */
+	u16 version;		/* PIRQ_VERSION */
+	u16 size;			/* Table size in bytes */
+	u8 rtr_bus, rtr_devfn;	/* Where the interrupt router lies */
+	u16 exclusive_irqs;	/* IRQs devoted exclusively to PCI usage */
+	u16 rtr_vendor, rtr_device;	/* Vendor and device ID of interrupt router */
+	u32 miniport_data;	/* Crap */
+	u8 rfu[11];
+	u8 checksum;		/* Modulo 256 checksum must give zero */
+	struct irq_info slots[0];
+} __attribute__ ((packed));
+
+#endif				/* _PHPRM_LEGACY_H_ */

