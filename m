Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVCKXLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVCKXLB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVCKXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:04:29 -0500
Received: from fmr20.intel.com ([134.134.136.19]:33453 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261815AbVCKWyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:54:33 -0500
Date: Fri, 11 Mar 2005 16:14:40 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200503120014.j2C0Ee4B020311@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 3/6] PCI Express Advanced Error Reporting Driver
Cc: greg@kroah.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the source code of event-logged component of PCI
Express Advanced Error Reporting driver.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_event.c patch-2.6.11-rc5-aerc3-split3/drivers/pci/pcie/aer/aerdrv_event.c
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_event.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split3/drivers/pci/pcie/aer/aerdrv_event.c	2005-03-09 13:26:28.000000000 -0500
@@ -0,0 +1,752 @@
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
+#include <linux/suspend.h>
+
+#include "aerdrv.h"
+
+LIST_HEAD(evt_queue);			/* Define Event Queue List */
+static struct semaphore evt_sema;	/* Sema access for evt consume/store */
+
+static int records = 0;
+static int eventlog_size = EVENT_LOG_SIZE_MAX;
+static DECLARE_WAIT_QUEUE_HEAD(kevtd_wait);
+static DECLARE_COMPLETION(kevtd_exit);
+static pid_t kevtd_pid = 0;
+
+static char* aer_error_severity_string[] = {
+	"Uncorrected (Non-Fatal)", 
+	"Uncorrected (Fatal)",
+	"Corrected", 
+	"UnCorrected"
+};
+
+static char* aer_correctable_error_string[] = {
+	"Receiver Error        ",	/* Bit Position 0 	*/
+	"Unknown Error Bit 1   ", 	/* Bit Position 1	*/
+	"Unknown Error Bit 2   ",	/* Bit Position 2	*/
+	"Unknown Error Bit 3   ", 	/* Bit Position 3	*/
+	"Unknown Error Bit 4   ", 	/* Bit Position 4 	*/
+	"Unknown Error Bit 5   ",	/* Bit Position 5	*/
+	"Bad TLP               ",	/* Bit Position 6 	*/
+	"Bad DLLP              ",	/* Bit Position 7 	*/
+	"RELAY_NUM Rollover    ",	/* Bit Position 8 	*/
+	"Unknown Error Bit 9   ", 	/* Bit Position 9	*/
+	"Unknown Error Bit 10  ",	/* Bit Position 10	*/
+	"Unknown Error Bit 11  ", 	/* Bit Position 11	*/
+	"Replay Timer Timeout  "	/* Bit Position 12 	*/
+	"Unknown Error Bit 13  ", 	/* Bit Position 13	*/
+	"Unknown Error Bit 14  ",	/* Bit Position 14	*/
+	"Unknown Error Bit 15  ", 	/* Bit Position 15	*/
+	"Unknown Error Bit 16  ", 	/* Bit Position 16 	*/
+	"Unknown Error Bit 17  ",	/* Bit Position 17	*/
+	"Unknown Error Bit 18  ", 	/* Bit Position 18	*/
+	"Unknown Error Bit 19  ",	/* Bit Position 19	*/
+	"Unknown Error Bit 20  ", 	/* Bit Position 20	*/
+	"Unknown Error Bit 21  ", 	/* Bit Position 21 	*/
+	"Unknown Error Bit 22  ",	/* Bit Position 22	*/
+	"Unknown Error Bit 23  ", 	/* Bit Position 23	*/
+	"Unknown Error Bit 24  ",	/* Bit Position 24	*/
+	"Unknown Error Bit 25  ", 	/* Bit Position 25	*/
+	"Unknown Error Bit 26  ", 	/* Bit Position 26 	*/
+	"Unknown Error Bit 27  ",	/* Bit Position 27	*/
+	"Unknown Error Bit 28  ",	/* Bit Position 28	*/
+	"Unknown Error Bit 29  ", 	/* Bit Position 29	*/
+	"Unknown Error Bit 30  ", 	/* Bit Position 30 	*/
+	"Unknown Error Bit 31  "	/* Bit Position 31	*/
+};
+
+static char* aer_uncorrectable_error_string[] = {
+	"Training Severity     ",	/* Bit Position 0 	*/
+	"Unknown Error Bit 1   ", 	/* Bit Position 1	*/
+	"Unknown Error Bit 2   ",	/* Bit Position 2	*/
+	"Unknown Error Bit 3   ", 	/* Bit Position 3	*/
+	"Data Link Protocol    ",	/* Bit Position 4	*/
+	"Unknown Error Bit 5   ", 	/* Bit Position 5	*/
+	"Unknown Error Bit 6   ", 	/* Bit Position 6	*/
+	"Unknown Error Bit 7   ",	/* Bit Position 7	*/
+	"Unknown Error Bit 8   ", 	/* Bit Position 8	*/
+	"Unknown Error Bit 9   ", 	/* Bit Position 9	*/
+	"Unknown Error Bit 10  ",	/* Bit Position 10	*/
+	"Unknown Error Bit 11  ", 	/* Bit Position 11	*/
+	"Poisoned TLP          ",	/* Bit Position 12 	*/
+	"Flow Control Protocol ",	/* Bit Position 13	*/
+	"Completion Timeout    ",	/* Bit Position 14 	*/
+	"Completer Abort       ",	/* Bit Position 15 	*/
+	"Unexpected Completion ",	/* Bit Position 16	*/
+	"Receiver Overflow     ",	/* Bit Position 17	*/
+	"Malformed TLP         ",	/* Bit Position 18	*/
+	"ECRC                  ",	/* Bit Position 19	*/
+	"Unsupported Request   "	/* Bit Position 20	*/
+	"Unknown Error Bit 21  ", 	/* Bit Position 21 	*/
+	"Unknown Error Bit 22  ",	/* Bit Position 22	*/
+	"Unknown Error Bit 23  ", 	/* Bit Position 23	*/
+	"Unknown Error Bit 24  ",	/* Bit Position 24	*/
+	"Unknown Error Bit 25  ", 	/* Bit Position 25	*/
+	"Unknown Error Bit 26  ", 	/* Bit Position 26 	*/
+	"Unknown Error Bit 27  ",	/* Bit Position 27	*/
+	"Unknown Error Bit 28  ",	/* Bit Position 28	*/
+	"Unknown Error Bit 29  ", 	/* Bit Position 29	*/
+	"Unknown Error Bit 30  ", 	/* Bit Position 30 	*/
+	"Unknown Error Bit 31  "	/* Bit Position 31	*/
+};
+
+static char* aer_agent_string[] = {
+	"Receiver ID           ", 
+	"Requester ID          ", 
+	"Completer ID          ", 
+	"Transmitter ID        " 
+};
+
+/**
+ * free_node - free an event log node 
+ * @node: pointer to an event log node
+ *
+ * Invoked when after a successful consumption of event log
+ **/
+static void free_node(struct event_node *node)
+{
+	if (node->e_data)
+		kfree(node->e_data);
+	kfree(node);
+}
+
+/**
+ * alloc_evt_node - create an event log node 
+ * @tlp: pointer to an TLP header
+ *
+ * Invoked when a new error being recorded
+ **/
+static struct event_node* alloc_evt_node(struct header_log_regs *tlp) 
+{
+	struct event_node *evt_node;
+	unsigned char *data;
+	int size = ERROR_RECORD_SIZE;
+
+	if ((evt_node = (struct event_node*)kmalloc(sizeof(struct event_node), 
+						GFP_KERNEL))) {
+		memset(evt_node, 0, sizeof(struct event_node));
+		if (tlp)
+			size += VARIABLE_LENGTH_SIZE;
+		if ((data = (unsigned char*)kmalloc(size, GFP_KERNEL))) {
+			memset(data, 0, size);
+			INIT_LIST_HEAD(&evt_node->e_node);
+			evt_node->e_data = data;
+		} else {
+			free_node(evt_node);
+			evt_node = NULL;
+		}
+	}
+
+	return evt_node;	
+}
+
+/**
+ * evt_queue_push - store an event node into an event log list 
+ * @node: pointer to an event log node
+ *
+ * Invoked when a new error being recorded
+ **/
+static void evt_queue_push(struct event_node *node)
+{
+	struct list_head *head = &evt_queue;
+	struct event_node *tmp = NULL;
+
+	/* Lock access into an error event queue */
+	down(&evt_sema);	
+	if (records > eventlog_size) {
+		/* Exceed event log buffer size. Delete oldest one. */
+		tmp = container_of(head->next, struct event_node, e_node);
+		list_del(&tmp->e_node);
+	} else
+		records++;
+	list_add_tail(&node->e_node, head);	
+	up(&evt_sema);	
+	if (tmp) 
+		free_node(tmp);
+
+	/* Wake up event parsing thread */
+	if (aer_get_auto_mode())
+		wake_up(&kevtd_wait);
+}
+
+/**
+ * evt_queue_pop - restore an event node from an event log list 
+ * @where: either from top or bottom of a list
+ *
+ * Invoked when an error being consumed
+ **/
+static struct event_node* evt_queue_pop(int where)
+{
+	struct list_head *head = &evt_queue;
+	struct event_node *evt_node = NULL;
+
+	if (!list_empty(head)) {
+		head = ((where == GET_ERR_RECORD_TOP) ? head->prev : head->next);
+		evt_node = container_of(head, struct event_node, e_node);
+		list_del(&evt_node->e_node);
+		records--;
+	}
+
+	return evt_node;
+}
+
+/**
+ * consume_record - consume an event log if any 
+ * @where: either from top or bottom of a list
+ * @buffer: pointer to buffer used to hold an event data
+ *
+ * Invoked when an event log is consumed either manually or automatically
+ **/
+static int consume_record(int where, unsigned char *buffer)
+{
+	struct event_node *evt_node;
+	int status = -EACCES;
+
+	/* Acquire event semaphore while access into an error event queue */
+	down(&evt_sema);	
+	if ((evt_node = evt_queue_pop(where))) {
+		struct aer_record_header *header; 
+
+		header = (struct aer_record_header*)evt_node->e_data;
+		memcpy(buffer, evt_node->e_data, header->record_len);
+		status = AER_SUCCESS;
+		free_node(evt_node);	
+	}
+	up(&evt_sema);	
+
+	return status;
+}
+
+/**
+ * set_record_header - format an error record header
+ * @dev: pointer to AER device data structure
+ * @node: pointer to an event node 
+ * @error: pointer to an error detected and recorded
+ * @len: length of a whole record
+ *
+ * Invoked to format record header of an event node
+ **/
+static void set_record_header(struct aer_device *dev, struct event_node *node, 
+				int len)
+{
+	struct aer_record_header *header;
+
+	header =(struct aer_record_header*)node->e_data;
+	memset(header, 0, sizeof(struct aer_record_header));
+	header->revision.major = RECORD_HEADER_MAJOR;
+	header->revision.minor = RECORD_HEADER_MINOR;
+	header->record_len = len;
+
+	/* Record time stamp */
+	header->time_stamp.seconds = dev->time_stamp.seconds;
+	header->time_stamp.minutes = dev->time_stamp.minutes;
+	header->time_stamp.hours = dev->time_stamp.hours;
+	header->time_stamp.day = dev->time_stamp.day;
+	header->time_stamp.month = dev->time_stamp.month;
+	header->time_stamp.year = dev->time_stamp.year;
+	header->time_stamp.century = dev->time_stamp.century = 20;
+}
+
+/**
+ * set_comp_info - format a component section of an event record
+ * @dev: pointer to AER device data structure
+ * @node: pointer to an event node 
+ * @error: pointer to an error detected and recorded
+ * @tlp_header: pointer to TLP header
+ * @reset: whether a hot link reset is involved while handling an error
+ *
+ * Invoked to format a component section of an event node
+ **/
+static void set_comp_info(struct aer_device *dev, struct event_node *node,
+	union aer_error *error, struct header_log_regs *tlp_header, int reset)
+{
+	struct aer_log_comp_err_info *component;
+	unsigned char *data;
+	int offset = 	sizeof(struct aer_record_header) +
+			sizeof(struct aer_log_bus_err_info); 
+
+	data = (unsigned char *)(node->e_data + offset);
+	component = (struct aer_log_comp_err_info*)data;
+	memset(component, 0, sizeof(struct aer_log_comp_err_info));
+
+	/* Component Section Header */
+	component->header.revision.major = SECTION_HEADER_MAJOR;
+	component->header.revision.minor = SECTION_HEADER_MINOR;
+	if (error->type == AER_CORRECTABLE) 
+		component->header.error_recovery_info = ERR_REC_INFO_COR;
+	if (error->source.status) {
+		if ((error->source.type == AER_FATAL) & reset) 
+			component->header.error_recovery_info = ERR_REC_INFO_RESET;
+	} else 
+		component->header.error_recovery_info |= ERR_REC_INFO_UNACCES;
+	component->header.section_len = sizeof(struct aer_log_comp_err_info); 
+
+	/* Component Section Body */
+	component->comp_info.vendor_id = dev->vendor;
+	component->comp_info.device_id = dev->device;
+	memcpy(&component->comp_info.class_code, &dev->class_code, 3);
+	component->comp_info.bus_num = AER_DEVICE_BUS(dev->requestor_id);
+	component->comp_info.dev_num = AER_DEVICE_DEV(dev->requestor_id);
+	component->comp_info.func_num = AER_DEVICE_FUNC(dev->requestor_id);
+	if (tlp_header) {
+		struct variable_length_info *comp_data;
+		
+		data = (unsigned char *)component + 
+			sizeof(struct aer_log_comp_err_info);
+		comp_data = (struct variable_length_info *)data;
+		comp_data->length = TLP_HEADER_SIZE;
+		memcpy(comp_data->variable_info, tlp_header, 
+			sizeof(struct header_log_regs));
+		component->header.section_len += VARIABLE_LENGTH_SIZE;
+	}
+}
+
+/**
+ * set_bus_info - format a bus section of an event record
+ * @dev: pointer to AER device data structure
+ * @node: pointer to an event node 
+ * @error: pointer to an error detected and recorded
+ * @multi: whether multiple errors detected by Root Port
+ * @reset: whether a hot link reset is involved while handling an error
+ *
+ * Invoked to format a bus section of an event node
+ **/
+static void set_bus_info(struct aer_device *dev, struct event_node *node,
+			   union aer_error *error, int multi, int reset)
+{
+	struct aer_log_bus_err_info *bus_info;
+	unsigned char *tmp;
+
+	tmp = (unsigned char *)(node->e_data + sizeof(struct aer_record_header));
+	bus_info = (struct aer_log_bus_err_info*)tmp;
+	memset(bus_info, 0, sizeof(struct aer_log_bus_err_info));
+
+	/* Bus Info Section Header & Section Body */
+	bus_info->header.revision.major = SECTION_HEADER_MAJOR;
+	bus_info->header.revision.minor = SECTION_HEADER_MINOR;
+	bus_info->header.section_len = sizeof(struct aer_log_bus_err_info); 
+
+	*(unsigned int*)&bus_info->lbe_status = (dev->requestor_id >> 8) |
+		(multi << 13); 
+	if (error->source.status) {
+		*(unsigned int*)&bus_info->lbe_status |=  
+		(AER_GET_LAYER_ERROR(error->type, error->source.status) << 8) |
+		(AER_GET_AGENT(error->type, error->source.status) << 11) | 
+		(1 << (error->type + 14));
+		bus_info->bus_err_type = error->source.status;
+		if (error->type == AER_CORRECTABLE) 
+			bus_info->header.error_recovery_info = ERR_REC_INFO_COR;
+		else if (reset)
+			bus_info->header.error_recovery_info = ERR_REC_INFO_RESET;
+	} else {
+		bus_info->header.error_recovery_info = ERR_REC_INFO_UNACCES;
+		if (error->type == AER_CORRECTABLE) 
+			bus_info->header.error_recovery_info |= ERR_REC_INFO_COR;
+	}
+	bus_info->agent_id = dev->requestor_id;
+}
+
+/**
+ * parse_record_header - parse record header into a readable format
+ * @page: pointer to buffer used to store a readable format
+ * @data: pointer to a raw binary format of an event log
+ * @v: a verbose indicator
+ *
+ * Invoked to display a record header
+ **/
+static int parse_record_header(char *page, unsigned char *data, int v)
+{
+	struct aer_record_header *header = (struct aer_record_header*)data;
+	struct aer_log_bus_err_info *bus_info = (struct aer_log_bus_err_info*)(
+		data + sizeof(struct aer_record_header));
+	char *p = page;
+
+	if (v == VERBOSE_FULL_DISPLAY) {
+		p += sprintf(p, "+------ RECORD HEADER -----+\n");
+		p += sprintf(p, "Revision              : %02x.%02x\n",	
+			header->revision.major, header->revision.minor);
+	}
+	p += sprintf(p, "Error Severity        : %s\n",
+		aer_error_severity_string[
+		 *(unsigned int*)&bus_info->lbe_status >> 15]);
+	if (v == VERBOSE_FULL_DISPLAY) 
+		p += sprintf(p, "Record Length (bytes) : 0x%x\n", 
+			header->record_len);
+	p += sprintf(p, "Time Stamp            : %d/%d/%d %d:%d:%d\n",
+		header->time_stamp.month, header->time_stamp.day, 
+		header->time_stamp.year + 1900, header->time_stamp.hours,
+		header->time_stamp.minutes, header->time_stamp.seconds);
+
+	return p - page;
+}
+
+/**
+ * parse_section_header - parse section header into a readable format
+ * @page: pointer to buffer used to store a readable format
+ * @header: pointer to a section of a raw binary format of an event log
+ * @num: a section number indicator
+ *
+ * Invoked to display a section header
+ **/
+static int parse_section_header(char *page, struct aer_section_header *header, 
+				int num)
+{
+	char *p = page;
+
+	p += sprintf(p, "+--------------------------+\n");
+	p += sprintf(p, "+    SECTION #%d HEADER     +\n", num);
+	p += sprintf(p, "+--------------------------+\n");
+	p += sprintf(p, "Revision              : %02x.%02x\n",	
+		header->revision.major,	header->revision.minor);
+	p += sprintf(p, "Error Recovery Info   :%s%s%s\n",
+		(header->error_recovery_info & ERR_REC_INFO_UNACCES) ?
+		" Unaccessible" : "",
+		(header->error_recovery_info & ERR_REC_INFO_COR) ?
+		" Corrected" : " UnCorrected",
+		(header->error_recovery_info & ERR_REC_INFO_RESET) ?
+		" Link Reset" : "");
+
+	return p - page;
+}
+
+/**
+ * parse_bus_info - parse a bus section into a readable format
+ * @page: pointer to buffer used to store a readable format
+ * @data: pointer to a section of a raw binary format of an event log
+ * @section: a section number indicator
+ * @v: a verbose indicator
+ *
+ * Invoked to display a bus section
+ **/
+static int parse_bus_info(char *page, unsigned char *data, int section, int v)
+{
+	struct aer_log_bus_err_info *bus_info;
+	union aer_error error;
+	char *error_name;
+	char *p = page;
+
+	bus_info = (struct aer_log_bus_err_info*)data;
+	if (v == VERBOSE_FULL_DISPLAY) 
+		p += parse_section_header(p, &bus_info->header, section);
+	p += sprintf(p, "PCIE Bus Error type   : "); 
+	if (bus_info->header.error_recovery_info & ERR_REC_INFO_UNACCES) {
+		p += sprintf(p, "%s\n", "Unaccessible");
+		p += sprintf(p, "Unaccessible Received : %s\n",
+			(bus_info->lbe_status.multiple) ? "Multiple" : "First");
+		p += sprintf(p, "Unregistered Agent ID : %04x\n", 
+			bus_info->agent_id);
+	} else {
+		p += sprintf(p, "%s%s\n", 
+			(bus_info->lbe_status.physical) ? "Physical Layer" : 
+			(bus_info->lbe_status.data) ? "Data Link Layer" :
+			"Transaction Layer", 
+			(bus_info->header.error_recovery_info & 
+			ERR_REC_INFO_RESET) ? " => Hot Link Reset" : "");
+		error.type = (*(unsigned int*)&bus_info->lbe_status & 
+				AER_ERROR_TYPE_MASK);
+		error.source.status = bus_info->bus_err_type;
+		error_name = aer_get_error_source_name(&error);
+		p += sprintf(p, "%s: %s\n", error_name, 
+			(bus_info->lbe_status.multiple) ? "Multiple" : "First");
+		p += sprintf(p, "%s: %04x\n", 
+			aer_agent_string[bus_info->lbe_status.agent], 
+			*(unsigned short*)&bus_info->agent_id);
+	}
+
+	return p - page;
+}
+
+/**
+ * parse_comp_info - parse a component section into a readable format
+ * @page: pointer to buffer used to store a readable format
+ * @data: pointer to a section of a raw binary format of an event log
+ * @section: a section number indicator
+ * @v: a verbose indicator
+ *
+ * Invoked to display a component section
+ **/
+static int parse_comp_info(char *page, unsigned char *data, int section, int v)
+{
+	struct aer_log_comp_err_info *component;
+	char *p = page;
+	
+	component = (struct aer_log_comp_err_info*)data;
+	if (v == VERBOSE_FULL_DISPLAY) 
+		p += parse_section_header(p, &component->header, section);
+	if (component->comp_info.device_id)
+		p += sprintf(p, "VendorID=%04xh, DeviceID=%04xh,",
+			component->comp_info.vendor_id, 
+			component->comp_info.device_id);
+	else
+		p += sprintf(p, "VendorID=xxxxh, DeviceID=xxxxh,");
+	p += sprintf(p, " Bus=%02xh, Device=%02xh, Function=%02xh\n",
+		component->comp_info.bus_num, component->comp_info.dev_num,
+		component->comp_info.func_num);
+	
+	if (v == VERBOSE_FULL_DISPLAY && (component->header.section_len == 
+		sizeof(struct aer_log_comp_err_info) + VARIABLE_LENGTH_SIZE)) {
+		struct variable_length_info *comp_data;
+		unsigned char *tlp;
+
+		comp_data = (struct variable_length_info *)(data + 
+			sizeof(struct aer_log_comp_err_info));
+		tlp = (unsigned char *)comp_data->variable_info;
+		p += sprintf(p, "TLB Header:\n");
+		p += sprintf(p, "%02x%02x%02x%02x %02x%02x%02x%02x"
+			" %02x%02x%02x%02x %02x%02x%02x%02x\n",
+			*(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
+			*(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
+			*(tlp + 11), *(tlp + 10), *(tlp + 9), *(tlp + 8),
+			*(tlp + 15), *(tlp + 14), *(tlp + 13), *(tlp + 12));
+	}
+
+	return p - page;
+}
+
+/**
+ * dump_log - dump a raw binary format of an event log
+ * @page: pointer to buffer used to store a readable format
+ * @buffer: pointer to a raw binary format of an event log
+ * @length: length of an event log
+ *
+ * Invoked to display a whole event log in a raw binary format
+ **/
+static int dump_log(char *page, unsigned char *buffer, int length)
+{
+	int i = 0;
+	char *p = page;
+
+	for (; i < length; i++) {
+		if (i && !(i % 16)) 
+			p += sprintf(p, "\n");
+		p += sprintf(p, "%02x ", *(buffer + i));
+	}
+	p += sprintf(p, "\n");
+
+	return p - page;
+}
+
+/**
+ * parse_event - consume an event log in a readable format
+ * @page: pointer to buffer used to store a readable format
+ * @buffer: pointer to a raw binary format of an event log
+ * @v: a verbose indicator
+ *
+ * Invoked to display an event log (manual consumption)
+ **/
+static int parse_event(char *page, unsigned char *buffer, int verbose)
+{
+	struct aer_record_header *record_header; 
+	struct aer_section_header *section_header;
+	unsigned char *data = buffer;
+	char *p = page;
+	int total_len;
+
+	record_header = (struct aer_record_header*)data;
+	total_len = record_header->record_len; 
+	data += sizeof(struct aer_record_header); 
+	total_len -= sizeof(struct aer_record_header);
+	section_header = (struct aer_section_header*)data;
+	total_len -= section_header->section_len;
+	section_header = (struct aer_section_header*)(data + 
+			section_header->section_len);
+	if (total_len != section_header->section_len) 
+		printk(KERN_INFO "Invalid Record Size\n");
+	else {
+		data = buffer;
+		if (verbose != VERBOSE_RAW_DISPLAY) {
+			p += parse_record_header(p, data, verbose);
+			data += sizeof(struct aer_record_header); 
+			p += parse_bus_info(p, data, 0, verbose);
+			section_header = (struct aer_section_header*)data;
+			data += section_header->section_len; 
+			p += parse_comp_info(p, data, 1, verbose);
+		} else 
+			p += dump_log(p, data, record_header->record_len); 
+	}
+
+	return p - page;
+}
+
+/**
+ * print_event - consume an event log in a readable format
+ *
+ * Invoked to display an event log (automatic consumption)
+ **/
+static void print_event(void)
+{
+	unsigned char buffer[ERROR_RECORD_BUFFER];
+	char page[PAGE_SIZE];
+	int size = 0;
+
+	if (!consume_record(GET_ERR_RECORD_BOTTOM, buffer)) {
+		if ((size = parse_event(page, buffer, aer_get_verbose()))) {
+			page[size + 1] = '\0';
+			printk(KERN_INFO "%s", page);
+		}
+	}
+}
+
+/**
+ * event_thread - an error consumption thread
+ *
+ * Invoked during AER initialization
+ **/
+static int event_thread(void *context)
+{
+	daemonize("evtdaemon");
+	allow_signal(SIGKILL);
+	do {
+		print_event();
+		wait_event_interruptible(
+			kevtd_wait,
+			!list_empty(&evt_queue));
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+	} while (!signal_pending(current));
+	complete_and_exit(&kevtd_exit, 0);
+}
+
+/**
+ * aer_log_event - log an detected error into an event log format
+ * @dev: pointer to AER device data structure
+ *
+ * Invoked when an error being detected by Root Port
+ **/
+void aer_log_event(struct aer_device *dev)
+{
+	struct event_node *evt_node; 
+   	struct header_log_regs *tlp = NULL;
+	union aer_error *error = &dev->last_recorded_err;
+	int record_len = ERROR_RECORD_SIZE; 
+
+	if (dev->flags.tlp) {
+		tlp = &dev->tlp;
+		record_len += VARIABLE_LENGTH_SIZE;
+	}
+	if ((evt_node = alloc_evt_node(tlp))) {
+		/* Init raw error log */
+		set_record_header(dev, evt_node, record_len); 
+		set_bus_info(dev, evt_node, error, dev->flags.multi, 
+			dev->flags.reset);
+		set_comp_info(dev, evt_node, error, tlp, dev->flags.reset);
+
+		/* Push new raw error log into event queue */
+		evt_queue_push(evt_node);
+	}
+}
+ 
+/**
+ * aer_send_alert - alert user that an error detected by Root Port
+ * @error: pointer to an error detected
+ *
+ * Invoked when an error being detected by Root Port
+ **/
+void aer_send_alert(union aer_error *error)
+{
+	char *error_name = aer_get_error_source_name(error);
+
+	printk(KERN_ALERT "ALERT! Detect %s\n",
+		(error_name != NULL) ? error_name :
+		(error->type == AER_CORRECTABLE) ? "UNACCESSIBLE COR" : 
+			"UNACCESSIBLE UNCOR");
+}
+
+/**
+ * aer_event_log_init - setup a kernel thread for consuming errors
+ *
+ * Invoked when an error being recorded into a event log list
+ **/
+int aer_event_log_init(void)
+{
+	pid_t pid;
+	
+	/* Init kernel thread to process error automatically */
+	if ((pid = kernel_thread(event_thread, NULL, CLONE_KERNEL)) >= 0) {
+		kevtd_pid = pid;
+
+		/* Init semaphore lock access into an error event queue */
+		sema_init(&evt_sema, 1);
+		return AER_SUCCESS;
+	}	
+	printk(KERN_DEBUG "%s: can't start kevtd\n", __FUNCTION__);
+	
+	return AER_UNSUCCESS;
+}
+
+/**
+ * aer_event_log_cleanup - destroy a kernel thread created for event consumption
+ *
+ * Invoked when AER driver being unloaded
+ **/
+void aer_event_log_cleanup(void)
+{
+	int status;
+	
+	while(!list_empty(&evt_queue))
+		print_event();
+
+	status = kill_proc(kevtd_pid, SIGKILL, 1);
+	wait_for_completion(&kevtd_exit);
+}
+
+/**
+ * aer_get_record - consume an event log 
+ * @page: pointer to buffer used to store a readable format of an event log
+ * @verbose: a verbose indicator
+ *
+ * Invoked by user through user interface consume
+ **/
+int aer_get_record(char *page, int verbose)
+{
+	unsigned char buffer[ERROR_RECORD_BUFFER];
+	char *p = page;
+ 
+	if (!consume_record(GET_ERR_RECORD_TOP, buffer)) 
+		p += parse_event(page, buffer, verbose);
+
+	return p - page;	
+}
+
+/**
+ * aer_set_auto_consume - set a consumption mode to either automatic or manual 
+ *
+ * Invoked by user through user interface auto
+ **/
+void aer_set_auto_consume(void)
+{
+	if (aer_get_auto_mode())
+		wake_up(&kevtd_wait);
+}
+
+/**
+ * aer_get_error_source_name - get a particular error name string  
+ * @error: pointer to an error detected by Root Port
+ *
+ * Invoked to a particular error name associated with an error bit position
+ **/
+char* aer_get_error_source_name(union aer_error *error)
+{
+	int i;
+		
+	for (i = 0; i < 32; i++) {				
+		if (!(error->source.status & (1 << i)))			
+			continue;
+		
+		if (error->type == AER_CORRECTABLE)
+			return aer_correctable_error_string[i];
+		else 
+			return aer_uncorrectable_error_string[i];
+	}
+
+	return NULL;
+}									
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_event.h patch-2.6.11-rc5-aerc3-split3/drivers/pci/pcie/aer/aerdrv_event.h
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv_event.h	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split3/drivers/pci/pcie/aer/aerdrv_event.h	2005-03-10 10:31:29.000000000 -0500
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+
+#ifndef _AER_LOG_H_
+#define _AER_LOG_H_
+
+#define RECORD_HEADER_MAJOR		0
+#define RECORD_HEADER_MINOR		3
+#define SECTION_HEADER_MAJOR		0
+#define SECTION_HEADER_MINOR		2
+
+#define AER_AGENT_RECEIVER		0
+#define AER_AGENT_REQUESTER		1
+#define AER_AGENT_COMPLETER		2
+#define AER_AGENT_TRANSMITTER		3		
+
+#define AER_AGENT_REQUESTER_MASK	(ERR_COMPLETION_TIMEOUT	|	\
+				 	ERR_UNSUPPORTED_REQUEST)
+
+#define AER_AGENT_COMPLETER_MASK	ERR_COMPLETION_ABORT
+
+#define AER_AGENT_TRANSMITTER_MASK(t, e) (e & (ERR_RELAY_NUM_ROLLOVER | \
+((t == AER_CORRECTABLE) ? ERR_RELAY_TIMEOUT : 0))) 
+
+#define AER_GET_AGENT(t, e)						\
+((e & AER_AGENT_COMPLETER_MASK) ? AER_AGENT_COMPLETER :			\
+(e & AER_AGENT_REQUESTER_MASK) ? AER_AGENT_REQUESTER :			\
+(AER_AGENT_TRANSMITTER_MASK(t, e)) ? AER_AGENT_TRANSMITTER : 		\
+AER_AGENT_RECEIVER)
+
+#define AER_PHYSICAL_LAYER_ERROR_MASK	ERR_TRAINING
+#define AER_DATA_LINK_LAYER_ERROR_MASK(t, e)				\
+					(ERR_DATA_LINK_PROTOCOL |	\
+					ERR_BAD_TLP | 			\
+					ERR_BAD_DLLP |			\
+					ERR_RELAY_NUM_ROLLOVER | 	\
+					((t == AER_CORRECTABLE) ?	\
+					ERR_RELAY_TIMEOUT : 0))
+
+#define AER_PHYSICAL_LAYER_ERROR	1
+#define AER_DATA_LINK_LAYER_ERROR	2
+#define AER_TRANSACTION_LAYER_ERROR	4
+
+#define AER_GET_LAYER_ERROR(t, e)					\
+((e & AER_PHYSICAL_LAYER_ERROR_MASK) ? AER_PHYSICAL_LAYER_ERROR :	\
+(e & AER_DATA_LINK_LAYER_ERROR_MASK(t, e)) ? AER_DATA_LINK_LAYER_ERROR : \
+AER_TRANSACTION_LAYER_ERROR)
+
+#define AER_ERROR_TYPE_MASK 	(AER_CORRECTABLE | AER_FATAL | AER_NONFATAL)
+
+struct aer_log_revision {
+	u8 minor;		/* BCD (0..99) */
+	u8 major;		/* BCD (0..99) */
+};
+
+struct aer_record_time_stamp {
+	unsigned char seconds;
+	unsigned char minutes;
+	unsigned char hours;
+	unsigned char reserved;
+	unsigned char day;
+	unsigned char month;
+	unsigned char year;
+	unsigned char century;
+} __attribute__ ((packed));
+
+struct aer_record_header {
+	u64 record_id;
+	struct aer_log_revision revision;
+	unsigned int record_len;
+	struct aer_record_time_stamp time_stamp;
+} __attribute__ ((packed));
+
+#define ERR_REC_INFO_COR		1
+#define ERR_REC_INFO_RESET		2
+#define ERR_REC_INFO_UNACCES		4		
+struct aer_section_header {
+	struct aer_log_revision 	revision;
+	unsigned int 			error_recovery_info;
+	unsigned int 			section_len;
+} __attribute__ ((packed));
+
+/* 
+ * BUS ERROR SECTION
+ */
+
+/* Define Internal Error Bus Status Data Structure */
+struct pcie_bus_err_status {	
+	unsigned int bus_id		: 8;  /* Bus ID Where Error Occurs */
+	unsigned int physical		: 1;  /* Physical Layer Error */
+	unsigned int data		: 1;  /* Data Link Layer Error */
+	unsigned int transaction	: 1;  /* Transaction Layer Error */
+	unsigned int agent		: 2;  /* 00:Receiver, 01: Requester,
+					         10:Completer, 11: Transmitter*/
+	unsigned int multiple		: 1;  /* Multiple Error */
+	unsigned int nonfatal		: 1;
+	unsigned int fatal		: 1; 
+	unsigned int corrected		: 1;
+	unsigned int reserved		: 15;
+} __attribute__ ((packed));
+
+struct aer_log_bus_err_info {
+	struct aer_section_header header;
+	struct pcie_bus_err_status lbe_status;	/* Internal Error Bus Status */
+	u32 bus_err_type;			/* Agent COR/UNCOR Status Reg */
+	u16 agent_id;				/* Agent which sent message */
+} __attribute__ ((packed));
+
+/* 
+ * COMPONENT ERROR SECTION
+ */
+struct variable_length_info {
+	u16	length;
+	u8	variable_info[1];	/* variable size data */
+} __attribute__ ((packed));
+#define VARIABLE_LENGTH_SIZE	18
+#define TLP_HEADER_SIZE		16
+
+struct aer_log_comp_err_info {
+	struct aer_section_header header;
+	struct {
+		u16 vendor_id;
+		u16 device_id;
+		u8 class_code[3];
+		u8 func_num;
+		u8 dev_num;
+		u8 bus_num;
+		u8 seg_num;
+	}comp_info;
+} __attribute__ ((packed));
+
+#define ERROR_RECORD_SIZE 					\
+			(sizeof(struct aer_record_header) +	\
+			sizeof(struct aer_log_bus_err_info) +	\
+			sizeof(struct aer_log_comp_err_info))
+
+#define ERROR_RECORD_BUFFER	(ERROR_RECORD_SIZE + TLP_HEADER_SIZE)
+
+#define EVENT_LOG_SIZE_MAX			100
+#define GET_ERR_RECORD_TOP			1
+#define GET_ERR_RECORD_BOTTOM			!GET_ERR_RECORD_TOP
+struct event_node {
+	struct list_head e_node;
+	void *e_data;
+};
+
+#endif //_AER_LOG_H_
