Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVCKXUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVCKXUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVCKXOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:14:44 -0500
Received: from fmr17.intel.com ([134.134.136.16]:32723 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261816AbVCKW4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:56:36 -0500
Date: Fri, 11 Mar 2005 16:16:54 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200503120016.j2C0Gs8D020323@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 5/6] PCI Express Advanced Error Reporting Driver
Cc: greg@kroah.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the source code of core component of PCI Express
Advanced Error Reporting driver.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_core.c patch-2.6.11-rc5-aerc3-split5/drivers/pci/pcie/aer/aerdrv_core.c
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_core.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split5/drivers/pci/pcie/aer/aerdrv_core.c	2005-03-10 10:31:09.000000000 -0500
@@ -0,0 +1,911 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/rtc.h>
+#include <linux/suspend.h>
+#include <linux/acpi.h>
+#include <linux/pci-acpi.h>
+#include "aerdrv.h"
+
+LIST_HEAD(rc_list);			/* Define Root Complex List */
+static int verbose = VERBOSE_LIMIT_DISPLAY;
+static int auto_mode = 1;
+static int aer_init_flag = 0;
+
+/**
+ * print_source_devices - print a list of AER devices in Root Port hierarchy
+ * @head: pointer to Root Port's children list
+ * @page: pointer to a buffer
+ *
+ * Invoked by user interface status. Caller must acquire Root semaphore prior
+ * to calling. 	
+ **/
+static int print_source_devices(struct list_head *head, char *page)
+{
+	struct list_head *entry;
+	struct aer_device *dev;
+	char *p = page;
+	char *error_name;
+
+	list_for_each(entry, head) {
+		dev = container_of(entry, struct aer_device, node);
+		p += sprintf(p, "  Bus %d, device %d, function %d:\n",
+			AER_DEVICE_BUS(dev->requestor_id),
+			AER_DEVICE_DEV(dev->requestor_id),
+			AER_DEVICE_FUNC(dev->requestor_id)); 
+		if (dev->handle) {
+			p += sprintf(p, "    Class %04x: PCI device %02x:%02x\n",
+				dev->class_code, dev->device, dev->vendor);
+			p += sprintf(p, "    COR_ERR %d, NONFATAL_ERR %d,"
+				" FATAL_ERR %d\n",
+				dev->correctables, 
+				dev->nonfatals,
+				dev->fatals);
+		} else
+			p += sprintf(p, "    COR_ERR %d, UNCOR_ERR %d\n",
+				dev->correctables, 
+				dev->uncorrectables);
+		error_name = aer_get_error_source_name(&dev->last_recorded_err);
+		if (error_name) {
+			p += sprintf(p, "    Last Error Detected @ "
+			"%d/%d/%d %d:%d:%d - %s\n", 
+			dev->time_stamp.month, dev->time_stamp.day, 
+			dev->time_stamp.year + 1900, dev->time_stamp.hours,
+			dev->time_stamp.minutes, dev->time_stamp.seconds,
+			error_name);
+		}
+		p += sprintf(p, "    Register Callbacks - %s\n",
+			(dev->handle != NULL) ? "Yes" : "No");
+		if (PCIE_PORT(dev->attribute.type)) 
+			p += print_source_devices(&dev->children, p);
+	}
+
+	return p-page;
+}
+
+/**
+ * search_node - search for a Root Port node associated with this
+ *		 downstream ID
+ * @requestor_id: endpoint source ID
+ *
+ * Invoked to search for an associated Root Port node.
+ * A rc_list list, initialized during driver init, contains physical
+ * Root Port devices in Root Complex, no semaphore access lock is 
+ * necessary prior to calling.
+ **/
+static struct aer_rpc* search_node(unsigned short requestor_id)
+{
+	struct list_head *entry;
+	struct aer_rpc *rpc = NULL;
+	int bus = AER_DEVICE_BUS(requestor_id);
+
+	if (!list_empty(&rc_list)) {
+		struct aer_rpc *tmp;
+
+		list_for_each(entry, &rc_list) {
+			tmp = container_of(entry, struct aer_rpc, node);
+			if ((bus >= tmp->secondary && bus <= tmp->subordinate)||
+				tmp->self_id == requestor_id) {
+				rpc = tmp;
+				break;	
+			}
+		}
+	}
+
+	return rpc; 
+}
+
+/**
+ * search_direct_parent - search for a direct PCIE Port for endpoint
+ * @head: pointer to a Root Port's children list
+ * @id: endpoint source ID
+ *
+ * Invoked to search for a direct one-to-one PCIE Port associated with
+ * endpoint. Caller must acquire Root semaphore "rpc_sema" prior to
+ * calling. 	
+ **/
+static struct aer_device* search_direct_parent(struct list_head *head, u16 id)
+{
+	struct list_head *entry;
+	struct aer_device *parent = NULL;
+
+	if (list_empty(head)) 
+		return NULL;
+
+	list_for_each(entry, head) {
+		struct aer_device *dev;
+		int secondary, subordinate, bus = AER_DEVICE_BUS(id);
+
+		dev = container_of(entry, struct aer_device, node);
+		if (!PCIE_PORT(dev->attribute.type)) 
+			continue;
+
+		secondary = dev->attribute.p2p.bus.secondary;		
+		subordinate = dev->attribute.p2p.bus.subordinate;	
+		if (!(bus >= secondary && bus <= subordinate))
+			continue;
+		
+		if (!(parent = search_direct_parent(&dev->children, id)))
+			parent = dev;
+		break;
+	}
+
+	return parent;
+}
+
+/**
+ * free_source_devices - free all children under Root Port
+ * @head: pointer to a Root Port's children list
+ *
+ * Invoked when AER Root service is unloaded.
+ * Caller must acquire Root semaphore "rpc_sema" prior to calling. 	
+ **/
+static void free_source_devices(struct list_head *head)
+{
+	struct list_head *tail = head->next;
+	struct aer_device *dev;
+
+	while (head != tail) {
+		dev = container_of(tail, struct aer_device, node);
+		if (PCIE_PORT(dev->attribute.type)) 
+			free_source_devices(&dev->children);
+		tail = tail->next;	
+		list_del(&dev->node);
+		kfree(dev);
+	}
+}
+
+/**
+ * search_source_device - search for an aer device which has id match
+ * @rpc: pointer to a Root Port hierarchy
+ * @id: an aer device ID to be searched 
+ *
+ * Invoked to find an aer device, in a Root Port hierarchy, with a match.
+ **/
+static struct aer_device* search_source_device(struct aer_rpc *rpc, u16 id)
+{
+	struct list_head *entry, *list = &rpc->children;
+	struct aer_device *parent, *device;
+
+	if (list_empty(list)) 
+		return NULL;
+	
+	/* Acquire Root semaphore access before searching for a device */
+	down(&rpc->rpc_sema);	
+	if ((parent = search_direct_parent(list, id)))
+		list = &parent->children;
+
+	list_for_each(entry, list) {
+		device = container_of(entry, struct aer_device, node);
+		if (device->requestor_id != id) 
+			continue;
+		
+		/* MATCH found */
+		up(&rpc->rpc_sema);	
+		return device;
+	}
+	up(&rpc->rpc_sema);	
+
+	return NULL; 
+}
+			
+/**
+ * reorganize_dependents - shuffle aer devices
+ * @parent: pointer to a parent aer device directly linked to a Switch.
+ * @sw: pointer to Switch aer device data structure
+ *
+ * Invoked when a PCIE Switch ARE driver registers its AER handle with
+ * AER Root driver. Reshuffle aer devices in a hierarchy associated with
+ * this Switch if applied. Caller must acquire Root semaphore "rpc_sema"
+ * prior to calling. 	
+ **/
+static void reorganize_dependents(struct aer_device *parent, 
+				struct aer_device *sw)
+{
+	struct list_head *head = &parent->children;
+	struct list_head *tail = head->next;
+	struct aer_device *dev;
+	int bus;
+
+	while (head != tail) {
+		dev = container_of(tail, struct aer_device, node);
+		tail = tail->next;
+		bus = AER_DEVICE_BUS(dev->requestor_id);
+		if (bus >= sw->attribute.p2p.bus.secondary && 
+			bus <= sw->attribute.p2p.bus.subordinate) {
+			dev->parent = sw;
+			list_del(&dev->node);
+			list_add_tail(&dev->node, &sw->children);	
+		}
+	}
+}	
+
+/**
+ * aer_device_detach - remove AER device from its associated Root Port list 
+ * @rpc: associated Root Port
+ * @device: AER device being removed
+ *
+ * Invoked when AER endpoint driver unregisters its AER handle.
+ **/
+static void aer_device_detach(struct aer_rpc *rpc, struct aer_device *device)
+{
+	struct list_head *head, *tail;
+
+	head = &device->children;
+	tail = head->next;
+
+	/* Acquire Root semaphore access before detaching a device */
+	down(&rpc->rpc_sema);	
+	while (head != tail) {
+		struct aer_device *tmp;
+
+		tmp = container_of(tail, struct aer_device, node);
+		tail = tail->next;	
+		list_del(&tmp->node);
+		tmp->parent = device->parent;
+		list_add_tail(&tmp->node, &device->parent->children);	
+	}
+	list_del(&device->node);
+	up(&rpc->rpc_sema);	
+	kfree(device);
+}
+ 
+/**
+ * add_child_to_rootport - add AER device into its associated Root Port list 
+ * @rpc: associated Root Port
+ * @child: AER device being added
+ *
+ * Invoked when AER endpoint driver registers its AER handle.
+ **/
+static void add_child_to_rootport(struct aer_rpc *rpc, struct aer_device *child)
+{
+	struct list_head *head = &rpc->children;
+	struct aer_device *parent;
+
+	/* Acquire Root sema access before adding a device into RPC hierarchy */
+	down(&rpc->rpc_sema);	
+	if (PCIE_ROOT_PORT(child->attribute.type))
+		list_add_tail(&child->node, head);
+	else {
+		if (!(parent = search_direct_parent(head, child->requestor_id)))
+			parent = container_of(head->next,struct aer_device,node);
+		if (PCIE_SWITCH_PORT(child->attribute.type)) 
+			reorganize_dependents(parent, child);	
+		child->parent = parent;
+		list_add_tail(&child->node, &parent->children);
+	}
+	up(&rpc->rpc_sema);	
+}
+
+/**
+ * prepare_recovery_link - prepare downstream drivers for link recovery
+ * @head: pointer to a children list of a Switch port device
+ *
+ * Invoked when a Switch port device, which supports a hot link reset, 
+ * detects a fatal error. Notify all downstream drivers under this 
+ * Switch port device to prepare for a link recovery.
+ *
+ * Caller must acquire Root semaphore "rpc_sema" prior to calling. 	
+ **/
+static void prepare_recovery_link(struct list_head *head)
+{
+	struct list_head *entry;
+	struct aer_device *dev;
+
+	list_for_each(entry, head) {
+		dev = container_of(entry, struct aer_device, node);
+		if (PCIE_PORT(dev->attribute.type)) 
+			prepare_recovery_link(&dev->children);
+		if (dev->handle)
+			dev->handle->link_rec_prepare(dev->requestor_id);
+	}
+}
+
+/**
+ * restart_recovery_link - restart downstream drivers after link recovery
+ * @head: pointer to a children list of a Switch port device
+ *
+ * Invoked after a switch port driver completes a link recovery. Notify
+ * downstream drivers under this link to restart their activities.
+ *
+ * Caller must acquire Root semaphore "rpc_sema" prior to calling. 	
+ **/
+static void restart_recovery_link(struct list_head *head)
+{
+	struct list_head *entry;
+	struct aer_device *dev;
+
+	list_for_each(entry, head) {
+		dev = container_of(entry, struct aer_device, node);
+		if (PCIE_PORT(dev->attribute.type)) 
+			restart_recovery_link(&dev->children);
+		if (dev->handle)
+			dev->handle->link_rec_restart(dev->requestor_id);
+	}
+}
+
+/**
+ * do_link_reset - request a Switch driver to perform a hot link reset.
+ * @device: pointer to a Switch aer device data structure
+ *
+ * Invoked when a Switch device, which supports a hot link reset, detects
+ * a fatal error (fatal error recovery).
+ **/
+static void do_link_reset(struct aer_device *device)
+{
+	struct aer_rpc *rpc = search_node(device->requestor_id);
+
+	/*
+	 * We need to prepare all downstream drivers associated in this
+	 * Switch port. Acquire Root Port semaphore is required.
+	 */
+	down(&rpc->rpc_sema);	
+	/* Notify downstream drivers for preparing link reset */
+	prepare_recovery_link(&device->children);
+
+	/* Call Switch Port driver to do link reset */
+	device->handle->link_reset(device->requestor_id);
+
+	/* Notify downstream drivers for restart their activities */
+	restart_recovery_link(&device->children);
+	up(&rpc->rpc_sema);	
+}
+
+/**
+ * alloc_aer_device - allocate an aer device data structure
+ * @requestor_id: a requestor ID
+ *
+ * Invoked when an AER service driver registers its AER handle with 
+ * PCIE AER service driver.
+ **/
+static struct aer_device* alloc_aer_device(unsigned short requestor_id)
+{
+	struct aer_device *device;
+
+	if (!(device = (struct aer_device *)kmalloc(sizeof(struct aer_device), 
+						GFP_KERNEL)))
+		return NULL;
+
+	memset(device, 0, sizeof(struct aer_device));
+	device->parent = NULL;
+	INIT_LIST_HEAD(&device->node);
+	INIT_LIST_HEAD(&device->children);
+	device->vendor = device->device = device->class_code = 0; 
+	device->requestor_id = requestor_id;	
+	device->attribute.type = 0;	
+	device->handle = NULL;
+	device->correctables = device->nonfatals = device->fatals = 0;
+	sema_init(&device->d_sema, 1);
+
+	return device;
+}
+
+/**
+ * handle_error_source - handle logging error into an event log
+ * @device: pointer to AER device data structure
+ * @type: an error type
+ * @multi: whether an error is first or multiple
+ *
+ * Invoked when an error being detected by Root Port.
+ **/
+static void handle_error_source(struct aer_device *device, int type, int multi)
+{
+	struct rtc_time rtc;
+	union aer_error error;
+
+	/* 
+	 * We must acquires a semaphore access into this device until
+	 * an error information associated with this device is stored
+ 	 * into an event log queue.
+	 */	
+	down(&device->d_sema);
+
+	/* Process error */			
+	*(unsigned short*)&device->flags = 0;
+	error.type = type;
+	error.source.status = 0;
+	if (device->handle) {
+		/* Notify AER service driver of an error detected on its hw */
+		if (device->handle->notify(device->requestor_id, &error)) {
+			if (device->attribute.type != PCIE_RC_PORT)
+				printk(KERN_DEBUG "AER glitch on device[%04x]\n",
+					device->requestor_id); 
+
+			/* Release device semaphore */
+			up(&device->d_sema);	
+			return;
+		}
+		if (error.type != AER_CORRECTABLE) {
+			if (!device->handle->get_header(device->requestor_id, 
+				&error, &device->tlp))
+				device->flags.tlp = 1;	
+			if (error.type == AER_NONFATAL)
+				device->nonfatals++;
+			else if (error.type == AER_FATAL) {
+				device->fatals++;
+				if (PCIE_PORT(device->attribute.type) && 
+					device->handle->link_reset) 
+					device->flags.reset = 1;	
+			}
+		}
+	}
+	if (error.type == AER_CORRECTABLE) 
+		device->correctables++;
+	else
+		device->uncorrectables++;
+	device->flags.multi = (multi) ? 1 : 0;	
+	device->last_recorded_err.type = error.type;
+	device->last_recorded_err.source.status = error.source.status;
+
+	/* Store time stamp */
+	rtc_get_rtc_time(&rtc);
+	device->time_stamp.seconds = rtc.tm_sec;
+	device->time_stamp.minutes = rtc.tm_min;
+	device->time_stamp.hours = rtc.tm_hour;
+	device->time_stamp.day = rtc.tm_mday;
+	device->time_stamp.month = rtc.tm_mon + 1;
+	device->time_stamp.year = rtc.tm_year; 
+	device->time_stamp.century = 20;
+
+	/* Record an error event log in raw format */
+	aer_log_event(device);
+	aer_send_alert(&error);
+
+	/* Do link recovery */
+	if (device->flags.reset)	
+		do_link_reset(device);
+
+	/* Release device semaphore */
+	up(&device->d_sema);
+}
+
+/**
+ * enable_root_aer - enable Root Port's interrupts when receiving messages
+ * @rpc: pointer to a Root Port data structure
+ *
+ * Invoked when PCIE bus loads AER service driver.
+ **/
+static void enable_root_aer(struct aer_rpc *rpc)
+{
+	struct pci_dev *pdev = rpc->rpd->port;
+	int pos;
+	u16 reg16;
+	u32 reg32;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+	/* Clear PCIE Capability's Device Status */
+	pci_read_config_word(pdev, pos+PCIE_CAP_DEVICE_STATUS_REG_OFF, &reg16);
+	pci_write_config_word(pdev, pos+PCIE_CAP_DEVICE_STATUS_REG_OFF, reg16);
+
+	/* Disable system error generation in response to error messages */
+	pci_read_config_word(pdev, pos + PCIE_CAP_ROOT_CONTROL_REG_OFF,	&reg16);
+	reg16 &= SYSTEM_ERROR_INTR_ON_MESG_DISABLED;
+	pci_write_config_word(pdev, pos + PCIE_CAP_ROOT_CONTROL_REG_OFF, reg16);
+
+	/* Clear error status */ 
+	pci_read_config_dword(pdev, ROOT_ERROR_STATUS_REG, &reg32);
+	pci_write_config_dword(pdev, ROOT_ERROR_STATUS_REG, reg32);
+
+	/* Init Correctable Masks */	
+	pci_read_config_dword(pdev, CORRECTABLE_ERROR_STATUS_REG, &reg32);
+	pci_write_config_dword(pdev, CORRECTABLE_ERROR_STATUS_REG, reg32);
+	reg32 = ROOT_CONFIG_COR_ERROR_MASKS;
+	pci_write_config_dword(pdev, CORRECTABLE_ERROR_MASK_REG, reg32);
+
+	/* Init Uncorrectable Severity */
+	pci_read_config_dword(pdev, UNCORRECTABLE_ERROR_STATUS_REG, &reg32);
+	pci_write_config_dword(pdev, UNCORRECTABLE_ERROR_STATUS_REG, reg32);
+	reg32 = ROOT_CONFIG_UNCOR_ERROR_MASKS;
+	pci_write_config_dword(pdev, UNCORRECTABLE_ERROR_MASK_REG, reg32);
+	reg32 = ROOT_CONFIG_UNCOR_ERROR_SEVERITY;
+	pci_write_config_dword(pdev, UNCORRECTABLE_ERROR_SEVERITY_REG, reg32);
+
+	/* Enable Root Port's interrupt in response to error messages */ 
+	pci_write_config_dword(pdev, ROOT_ERROR_COMMAND_REG,
+		ROOT_PORT_INTR_ON_MESG_ENABLED);
+		
+	/* Enable Root Port device reporting error itself */
+	pci_read_config_word(pdev, pos+PCIE_CAP_DEVICE_CONTROL_REG_OFF, &reg16);
+	pci_write_config_word(pdev, pos+PCIE_CAP_DEVICE_CONTROL_REG_OFF,
+		reg16 | ROOT_ERR_REPORT_ENABLE_BITS);
+}
+
+/**
+ * disable_root_aer - disable Root Port's interrupts when receiving messages
+ * @rpc: pointer to a Root Port data structure
+ *
+ * Invoked when PCIE bus unloads AER service driver.
+ **/
+static void disable_root_aer(struct aer_rpc *rpc)
+{
+	struct pci_dev *pdev = rpc->rpd->port;
+	u32 reg32;
+
+	/* Disable Root's interrupt in response to error messages */ 
+	pci_read_config_dword(pdev, ROOT_ERROR_STATUS_REG, &reg32);
+	pci_write_config_dword(pdev, ROOT_ERROR_STATUS_REG, reg32);
+	pci_write_config_dword(pdev, ROOT_ERROR_COMMAND_REG, 0);
+}
+
+/**
+ * aer_osc_setup - run ACPI _OSC method
+ *
+ * Return: 
+ *	Zero if success. Nonzero for otherwise.	
+ *
+ * Invoked when PCIE bus loads AER service driver. To avoid conflict with
+ * BIOS AER support requires BIOS to yield AER control to OS native driver.
+ **/
+static int aer_osc_setup(void)
+{
+	int retval = OSC_METHOD_RUN_SUCCESS;
+	acpi_status status;
+
+	pci_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
+	status = pci_osc_control_set(OSC_PCI_EXPRESS_AER_CONTROL |
+		OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_SUPPORT) 
+			retval = OSC_METHOD_NOT_SUPPORTED;
+	 	else
+			retval = OSC_METHOD_RUN_FAILURE;
+	}	
+
+	return retval;
+}
+
+/**
+ * aer_device_attach - attach AER device into its associated Root Port list 
+ * @rpc: associated Root Port
+ * @device: AER device being attached
+ *
+ * Invoked when AER endpoint driver registers its callbacks.
+ *
+ * Return:
+ *	Zero if success. -EINVAL if already registered.
+ **/
+static int aer_device_attach(struct aer_rpc *rpc, struct aer_device *device)
+{
+	struct aer_device *tmp;
+	int status = AER_SUCCESS;
+
+	if ((tmp = search_source_device(rpc, device->requestor_id))) {
+		if (!tmp->handle) {		
+			/* 
+			 * Exist but not registered. Update contents of a new
+			 * from old copy. Then remove old copy. 
+ 			 */
+			device->correctables = tmp->correctables;
+			device->last_recorded_err = tmp->last_recorded_err;
+			memcpy(&device->time_stamp, &tmp->time_stamp,
+				sizeof(struct aer_record_time_stamp));
+			down(&rpc->rpc_sema);	/* Acquire Root semaphore */
+			list_del(&tmp->node);
+			up(&rpc->rpc_sema);	
+			kfree(tmp);		
+		} else  /* Already has a registered handle */
+			status = -EINVAL;	
+	} 
+	if (!status)
+		add_child_to_rootport(rpc, device); 
+
+	return status;
+}
+
+/**
+ * get_e_source - retrieve an error source
+ * @rpc: pointer to the root port which holds an error
+ *
+ * Invoked by DPC handler to consume an error.
+ **/
+static struct err_source* get_e_source(struct aer_rpc *rpc)
+{
+	struct err_source *e_source;
+	unsigned long flags;
+
+	/* Lock access to Root error producer/consumer index */
+	spin_lock_irqsave(&rpc->e_lock, flags);
+	if (rpc->prod_idx == rpc->cons_idx) {
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return NULL;
+	}
+	e_source = &rpc->e_sources[rpc->cons_idx];
+	rpc->cons_idx++;
+	if (rpc->cons_idx == AER_ERROR_SOURCES_MAX)
+		rpc->cons_idx = 0;
+	spin_unlock_irqrestore(&rpc->e_lock, flags);
+	
+	return e_source;
+}
+
+struct pci_dev* get_root_pci_dev(unsigned short requestor_id)
+{
+	struct aer_rpc *rpc;
+
+	rpc = search_node(requestor_id);
+
+	return (rpc) ? rpc->rpd->port : NULL;
+}
+
+/**
+ * aer_isr - consume an error detected by root port
+ * @context: pointer to a private data of pcie device
+ *
+ * Invoked, as DPC, when root port records new detected error 
+ **/
+void aer_isr(void *context)
+{
+	struct pcie_device *pdev = (struct pcie_device *)context;
+	struct aer_rpc *rpc = get_service_data(pdev);
+	struct aer_device *device;
+	struct err_source *e_source;
+
+	if (!(e_source = get_e_source(rpc))) {
+		printk(KERN_DEBUG "%s->DPC fails to get an error source\n", 
+			__FUNCTION__);
+		return;
+	}
+
+	if (ROOT_ERR_STATUS_CORRECTABLE(e_source->status)) {
+		if (!(device = search_source_device(rpc, 
+			ERR_COR_ID(e_source->id)))) {
+			/* Detect agent's unregistered driver */
+			if (!(device = alloc_aer_device(
+				ERR_COR_ID(e_source->id))))
+				return;
+
+			add_child_to_rootport(rpc, device); 
+		}
+		handle_error_source(device, AER_CORRECTABLE, 
+			e_source->status & 0x2);
+	}
+	if (ROOT_ERR_STATUS_UNCORRECTABLE(e_source->status)) {
+		if (!(device = search_source_device(rpc, 
+			ERR_UNCOR_ID(e_source->id)))) {
+			/* Detect agent's unregistered driver */
+			if (!(device = alloc_aer_device(
+				ERR_UNCOR_ID(e_source->id))))
+				return;
+
+			add_child_to_rootport(rpc, device); 
+		}
+		handle_error_source(device, AER_UNCORRECTABLE,
+			e_source->status & 0x8);
+	}
+}
+
+/**
+ * aer_add_rootport - add a new root port into Root Complex's port hierarchy
+ * @rpc: pointer to a new root port device being added
+ *
+ * Invoked when AER service loaded on a new Root Port
+ **/
+int aer_add_rootport(struct aer_rpc *rpc)
+{
+	list_add_tail(&rpc->node, &rc_list);
+
+	/* Enable root port AER itself */
+	enable_root_aer(rpc);
+
+	/* Self registering */
+	return pcie_aer_register(rpc->rpd->port, &aer_root_handle);
+}
+
+/**
+ * aer_delete_rootport - delete a root port from Root Complex's port hierarchy
+ * @rpc: pointer to a root port device being deleted
+ *
+ * Invoked when AER service unloaded on a specific Root Port
+ **/
+void aer_delete_rootport(struct aer_rpc *rpc) 
+{
+	struct list_head *head = &rpc->children;
+
+	/* Disable root port AER itself */
+	disable_root_aer(rpc);
+
+	/* Acquire Root semaphore access before removing source devices */
+	down(&rpc->rpc_sema);
+	
+	/* Free all source nodes under this root port */
+	free_source_devices(head);
+	list_del(&rpc->node);	
+	up(&rpc->rpc_sema);	
+	kfree(rpc);
+}
+
+/**
+ * aer_fsprint_devices - display all registered devices
+ * @page: pointer to a buffer holding readable display format 
+ *
+ * Invoked by user interface status
+ **/
+int aer_fsprint_devices(char *page)
+{
+	struct list_head *entry;
+	struct aer_rpc *rpc;
+	char *p = page;
+	
+	if (!list_empty(&rc_list)) {
+		list_for_each(entry, &rc_list) {
+			rpc = container_of(entry, struct aer_rpc, node);
+			p += sprintf(p, "Root Port [%d.%d.%d] Device List:\n", 
+				rpc->primary, rpc->secondary, rpc->subordinate);
+			down(&rpc->rpc_sema);	/* Must acquire Root sema */	
+			p += print_source_devices(&rpc->children, p);
+			up(&rpc->rpc_sema);	
+		}
+	}
+
+	return p-page;
+}
+
+/**
+ * aer_set_verbose - set a verbose mode 
+ *
+ * Invoked by user interface verbose
+ **/
+void aer_set_verbose(int value)
+{
+	if (value & VERBOSE_MASK) 
+		verbose = value;
+}
+
+/**
+ * aer_get_verbose - return a verbose mode 
+ *
+ * Invoked by user interface verbose
+ **/
+int aer_get_verbose(void) {return verbose;}
+
+/**
+ * aer_fsprint_record - consume an error record
+ * @page: pointer to a buffer holding readable display format 
+ *
+ * Invoked by user interface consume
+ **/
+int aer_fsprint_record(char *page)
+{
+	char *p = page;
+
+	p += aer_get_record(p, verbose);
+
+	return p - page;
+}
+
+/**
+ * aer_set_auto_mode - set an auto consumption mode 
+ * @mode: zero for manual or nonzero automatic 
+ *
+ * Invoked by user interface auto
+ **/
+void aer_set_auto_mode(int mode)
+{
+	if ((auto_mode = mode))
+		aer_set_auto_consume();
+}
+
+/**
+ * aer_get_auto_mode - return an auto consumption mode 
+ *
+ * Invoked by user interface auto
+ **/
+int aer_get_auto_mode(void) {return auto_mode;}
+
+/**
+ * aer_init - provide AER initialization 
+ * @drv: pointer to AER service driver
+ *
+ * Invoked when AER service driver is loaded. 
+ **/
+int aer_init(struct pcie_port_service_driver *drv)
+{
+	int status;
+
+	if (aer_init_flag)
+		return AER_SUCCESS;
+
+	/* Run _OSC Method */
+	if (!(status = aer_osc_setup())) { 
+		/* Init AER */
+		if (!(status = aer_sysfs_init(&drv->driver))) {
+			if ((status = aer_event_log_init()))
+				aer_sysfs_cleanup(&drv->driver);
+		}
+	}
+	if (!status)
+		aer_init_flag = 1;	/* Set to indicate AER Init DONE */
+
+	return status;
+}
+
+/**
+ * aer_cleanup - provide a cleanup 
+ * @drv: pointer to AER service driver
+ *
+ * Invoked when AER service driver is unloaded from Root Ports. 
+ * Cleanup only when rc_list is empty.
+ **/
+void aer_cleanup(struct pcie_port_service_driver *drv)
+{
+	if (!aer_init_flag || !list_empty(&rc_list))
+		return;
+
+	aer_sysfs_cleanup(&drv->driver);
+	aer_event_log_cleanup();
+	aer_init_flag = 0;		/* Reset this flag */
+}
+
+/**
+ * pcie_aer_register - provide Root API for endpoint to register its AER 
+ * @dev: pointer to the pci_dev data structure
+ * @handle: pointer to the pcie_aer_handle data structure
+ *
+ * Invoked when AER endpoint driver registers its callbacks to Root AER driver.
+ **/
+int pcie_aer_register(struct pci_dev *dev, struct pcie_aer_handle *handle)
+{
+	struct aer_device *device = NULL;
+	struct aer_rpc *rpc = NULL;
+	int pos, status;
+	u32 bus;
+	u16 type, requestor_id;
+
+	if (!(dev && handle) || !(pos = pci_find_capability(dev,PCI_CAP_ID_EXP)))
+		return -EINVAL;		/* Invalid request */
+
+	requestor_id = (dev->bus->number << 8) | dev->devfn;	
+	if (!(rpc = search_node(requestor_id))) 
+		return -EINVAL;		/* No Root Port associated */
+			
+	if (!(device = alloc_aer_device(requestor_id)))
+		return -ENOMEM;
+
+	/* Initialize AER device corresponding to a requested handle */
+	device->vendor = dev->vendor;
+	device->device = dev->device;
+	device->class_code = dev->class;
+	device->handle = handle;
+	pci_read_config_word(dev, pos + 2, &type);
+	device->attribute.type = (type >> 4) & PCIE_PORT_TYPE_MASK;
+	if (PCIE_PORT(device->attribute.type)) {
+		pci_read_config_dword(dev, PCI_PRIMARY_BUS, &bus);
+		device->attribute.p2p.bus.primary = bus & 0xff;
+		device->attribute.p2p.bus.secondary = (bus >> 8) & 0xff;
+		device->attribute.p2p.bus.subordinate =	(bus >> 16) & 0xff;
+	}
+	if ((status = aer_device_attach(rpc, device))) {
+		printk(KERN_DEBUG "Req. AER handle is already exist. Ignore!\n");
+		kfree(device);
+	}
+
+	return status;
+} 
+
+/**
+ * pcie_aer_unregister - provide Root API for endpoint to unregister its AER 
+ * @requestor_id: endpoint source ID
+ *
+ * Invoked when AER endpoint driver unregisters its callbacks.
+ **/
+void pcie_aer_unregister(unsigned short requestor_id)
+{
+	struct aer_rpc *rpc;
+	struct aer_device *device;
+
+	if ((rpc = search_node(requestor_id))) {
+		if ((device = search_source_device(rpc, requestor_id)))
+			aer_device_detach(rpc, device);
+	}
+}
+
+EXPORT_SYMBOL(pcie_aer_register);
+EXPORT_SYMBOL(pcie_aer_unregister);
