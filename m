Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUKEVvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUKEVvh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUKEVvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:51:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21011 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261154AbUKEVuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:50:54 -0500
Date: Fri, 5 Nov 2004 22:50:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/acpi: remove unused exported functions
Message-ID: <20041105215021.GF1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below completely removes 7 functions that were 
EXPORT_SYMBOL'ed but had exactly zero users in the kernel and makes 
another one that was previously EXPORT_SYMBOL'ed static.

It also removes another unused global function to completely remove 
drivers/acpi/hardware/hwtimer.c which contained no function used 
anywhere in the kernel.

Please comment on whether this patch is correct or whether in-kernel 
users of these functions are pending.


diffstat output:
 drivers/acpi/acpi_ksyms.c        |    8 -
 drivers/acpi/events/evxfevnt.c   |  191 -----------------------------
 drivers/acpi/hardware/Makefile   |    2 
 drivers/acpi/hardware/hwtimer.c  |  200 -------------------------------
 drivers/acpi/resources/rsxface.c |   52 --------
 drivers/acpi/scan.c              |    6 
 drivers/acpi/utilities/utxface.c |   89 -------------
 include/acpi/achware.h           |   17 --
 include/acpi/acpi_bus.h          |    1 
 include/acpi/acpixf.h            |   24 ---
 10 files changed, 6 insertions(+), 584 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/acpi/acpixf.h.old	2004-11-05 21:52:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/acpi/acpixf.h	2004-11-05 22:21:16.000000000 +0100
@@ -82,10 +82,6 @@
 acpi_disable (
 	void);
 
-acpi_status
-acpi_get_system_info (
-	struct acpi_buffer              *ret_buffer);
-
 const char *
 acpi_format_exception (
 	acpi_status                     exception);
@@ -334,10 +330,6 @@
 	u32                             flags);
 
 acpi_status
-acpi_clear_event (
-	u32                             event);
-
-acpi_status
 acpi_get_event_status (
 	u32                             event,
 	acpi_event_status               *event_status);
@@ -373,17 +365,6 @@
 	u32                             flags,
 	acpi_event_status               *event_status);
 
-acpi_status
-acpi_install_gpe_block (
-	acpi_handle                     gpe_device,
-	struct acpi_generic_address     *gpe_block_address,
-	u32                             register_count,
-	u32                             interrupt_level);
-
-acpi_status
-acpi_remove_gpe_block (
-	acpi_handle                     gpe_device);
-
 
 /*
  * Resource interfaces
@@ -401,11 +382,6 @@
 	struct acpi_buffer              *ret_buffer);
 
 acpi_status
-acpi_get_possible_resources(
-	acpi_handle                     device_handle,
-	struct acpi_buffer              *ret_buffer);
-
-acpi_status
 acpi_walk_resources (
 	acpi_handle                             device_handle,
 	char                                    *path,
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/acpi_ksyms.c.old	2004-11-05 21:51:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/acpi_ksyms.c	2004-11-05 22:21:08.000000000 +0100
@@ -74,26 +74,19 @@
 EXPORT_SYMBOL(acpi_remove_fixed_event_handler);
 EXPORT_SYMBOL(acpi_acquire_global_lock);
 EXPORT_SYMBOL(acpi_release_global_lock);
-EXPORT_SYMBOL(acpi_install_gpe_block);
-EXPORT_SYMBOL(acpi_remove_gpe_block);
 EXPORT_SYMBOL(acpi_get_current_resources);
-EXPORT_SYMBOL(acpi_get_possible_resources);
 EXPORT_SYMBOL(acpi_walk_resources);
 EXPORT_SYMBOL(acpi_set_current_resources);
 EXPORT_SYMBOL(acpi_resource_to_address64);
 EXPORT_SYMBOL(acpi_enable_event);
 EXPORT_SYMBOL(acpi_disable_event);
-EXPORT_SYMBOL(acpi_clear_event);
 EXPORT_SYMBOL(acpi_set_gpe_type);
 EXPORT_SYMBOL(acpi_enable_gpe);
-EXPORT_SYMBOL(acpi_get_timer_duration);
-EXPORT_SYMBOL(acpi_get_timer);
 EXPORT_SYMBOL(acpi_get_sleep_type_data);
 EXPORT_SYMBOL(acpi_get_register);
 EXPORT_SYMBOL(acpi_set_register);
 EXPORT_SYMBOL(acpi_enter_sleep_state);
 EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
-EXPORT_SYMBOL(acpi_get_system_info);
 EXPORT_SYMBOL(acpi_get_devices);
 
 /* ACPI OS Services Layer (acpi_osl.c) */
@@ -139,7 +132,6 @@
 EXPORT_SYMBOL(acpi_bus_register_driver);
 EXPORT_SYMBOL(acpi_bus_unregister_driver);
 EXPORT_SYMBOL(acpi_bus_scan);
-EXPORT_SYMBOL(acpi_bus_trim);
 EXPORT_SYMBOL(acpi_bus_add);
 
 #endif /*CONFIG_ACPI_BUS*/
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxfevnt.c.old	2004-11-05 21:51:12.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/events/evxfevnt.c	2004-11-05 21:53:37.000000000 +0100
@@ -421,45 +421,6 @@
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_clear_event
- *
- * PARAMETERS:  Event           - The fixed event to be cleared
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Clear an ACPI event (fixed)
- *
- ******************************************************************************/
-
-acpi_status
-acpi_clear_event (
-	u32                             event)
-{
-	acpi_status                     status = AE_OK;
-
-
-	ACPI_FUNCTION_TRACE ("acpi_clear_event");
-
-
-	/* Decode the Fixed Event */
-
-	if (event > ACPI_EVENT_MAX) {
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-	}
-
-	/*
-	 * Clear the requested fixed event (By writing a one to the
-	 * status register bit)
-	 */
-	status = acpi_set_register (acpi_gbl_fixed_event_info[event].status_register_id,
-			1, ACPI_MTX_LOCK);
-
-	return_ACPI_STATUS (status);
-}
-
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_clear_gpe
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device
@@ -614,155 +575,3 @@
 	return_ACPI_STATUS (status);
 }
 
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_install_gpe_block
- *
- * PARAMETERS:  gpe_device          - Handle to the parent GPE Block Device
- *              gpe_block_address   - Address and space_iD
- *              register_count      - Number of GPE register pairs in the block
- *              interrupt_level     - H/W interrupt for the block
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Create and Install a block of GPE registers
- *
- ******************************************************************************/
-
-acpi_status
-acpi_install_gpe_block (
-	acpi_handle                     gpe_device,
-	struct acpi_generic_address     *gpe_block_address,
-	u32                             register_count,
-	u32                             interrupt_level)
-{
-	acpi_status                     status;
-	union acpi_operand_object       *obj_desc;
-	struct acpi_namespace_node      *node;
-	struct acpi_gpe_block_info      *gpe_block;
-
-
-	ACPI_FUNCTION_TRACE ("acpi_install_gpe_block");
-
-
-	if ((!gpe_device)      ||
-		(!gpe_block_address) ||
-		(!register_count)) {
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-	}
-
-	status = acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE (status)) {
-		return (status);
-	}
-
-	node = acpi_ns_map_handle_to_node (gpe_device);
-	if (!node) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	/*
-	 * For user-installed GPE Block Devices, the gpe_block_base_number
-	 * is always zero
-	 */
-	status = acpi_ev_create_gpe_block (node, gpe_block_address, register_count,
-			  0, interrupt_level, &gpe_block);
-	if (ACPI_FAILURE (status)) {
-		goto unlock_and_exit;
-	}
-
-	/* Get the device_object attached to the node */
-
-	obj_desc = acpi_ns_get_attached_object (node);
-	if (!obj_desc) {
-		/* No object, create a new one */
-
-		obj_desc = acpi_ut_create_internal_object (ACPI_TYPE_DEVICE);
-		if (!obj_desc) {
-			status = AE_NO_MEMORY;
-			goto unlock_and_exit;
-		}
-
-		status = acpi_ns_attach_object (node, obj_desc, ACPI_TYPE_DEVICE);
-
-		/* Remove local reference to the object */
-
-		acpi_ut_remove_reference (obj_desc);
-
-		if (ACPI_FAILURE (status)) {
-			goto unlock_and_exit;
-		}
-	}
-
-	/* Install the GPE block in the device_object */
-
-	obj_desc->device.gpe_block = gpe_block;
-
-
-unlock_and_exit:
-	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
-	return_ACPI_STATUS (status);
-}
-
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_remove_gpe_block
- *
- * PARAMETERS:  gpe_device          - Handle to the parent GPE Block Device
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Remove a previously installed block of GPE registers
- *
- ******************************************************************************/
-
-acpi_status
-acpi_remove_gpe_block (
-	acpi_handle                     gpe_device)
-{
-	union acpi_operand_object       *obj_desc;
-	acpi_status                     status;
-	struct acpi_namespace_node      *node;
-
-
-	ACPI_FUNCTION_TRACE ("acpi_remove_gpe_block");
-
-
-	if (!gpe_device) {
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-	}
-
-	status = acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE (status)) {
-		return (status);
-	}
-
-	node = acpi_ns_map_handle_to_node (gpe_device);
-	if (!node) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	/* Get the device_object attached to the node */
-
-	obj_desc = acpi_ns_get_attached_object (node);
-	if (!obj_desc ||
-		!obj_desc->device.gpe_block) {
-		return_ACPI_STATUS (AE_NULL_OBJECT);
-	}
-
-	/* Delete the GPE block (but not the device_object) */
-
-	status = acpi_ev_delete_gpe_block (obj_desc->device.gpe_block);
-	if (ACPI_SUCCESS (status)) {
-		obj_desc->device.gpe_block = NULL;
-	}
-
-unlock_and_exit:
-	(void) acpi_ut_release_mutex (ACPI_MTX_NAMESPACE);
-	return_ACPI_STATUS (status);
-}
-
--- linux-2.6.10-rc1-mm3-full/include/acpi/achware.h.old	2004-11-05 21:54:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/acpi/achware.h	2004-11-05 21:55:37.000000000 +0100
@@ -159,21 +159,4 @@
 	struct acpi_gpe_block_info      *gpe_block);
 
 
-/* ACPI Timer prototypes */
-
-acpi_status
-acpi_get_timer_resolution (
-	u32                             *resolution);
-
-acpi_status
-acpi_get_timer (
-	u32                             *ticks);
-
-acpi_status
-acpi_get_timer_duration (
-	u32                             start_ticks,
-	u32                             end_ticks,
-	u32                             *time_elapsed);
-
-
 #endif /* __ACHWARE_H__ */
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/Makefile.old	2004-11-05 21:56:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/Makefile	2004-11-05 21:56:51.000000000 +0100
@@ -2,6 +2,6 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-y := hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o  hwtimer.o
+obj-y := hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/resources/rsxface.c.old	2004-11-05 21:58:06.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/resources/rsxface.c	2004-11-05 21:58:21.000000000 +0100
@@ -160,58 +160,6 @@
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_get_possible_resources
- *
- * PARAMETERS:  device_handle   - a handle to the device object for the
- *                                device we are querying
- *              ret_buffer      - a pointer to a buffer to receive the
- *                                resources for the device
- *
- * RETURN:      Status
- *
- * DESCRIPTION: This function is called to get a list of the possible resources
- *              for a specific device.  The caller must first acquire a handle
- *              for the desired device.  The resource data is placed in the
- *              buffer pointed to by the ret_buffer variable.
- *
- *              If the function fails an appropriate status will be returned
- *              and the value of ret_buffer is undefined.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_get_possible_resources (
-	acpi_handle                     device_handle,
-	struct acpi_buffer              *ret_buffer)
-{
-	acpi_status                     status;
-
-
-	ACPI_FUNCTION_TRACE ("acpi_get_possible_resources");
-
-
-	/*
-	 * Must have a valid handle and buffer, So we have to have a handle
-	 * and a return buffer structure, and if there is a non-zero buffer length
-	 * we also need a valid pointer in the buffer. If it's a zero buffer length,
-	 * we'll be returning the needed buffer size, so keep going.
-	 */
-	if (!device_handle) {
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-	}
-
-	status = acpi_ut_validate_buffer (ret_buffer);
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
-	status = acpi_rs_get_prs_method_data (device_handle, ret_buffer);
-	return_ACPI_STATUS (status);
-}
-
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_walk_resources
  *
  * PARAMETERS:  device_handle   - a handle to the device object for the
--- linux-2.6.10-rc1-mm3-full/include/acpi/acpi_bus.h.old	2004-11-05 22:00:14.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/acpi/acpi_bus.h	2004-11-05 22:00:21.000000000 +0100
@@ -328,7 +328,6 @@
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 int acpi_bus_scan (struct acpi_device *start);
-int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_add (struct acpi_device **child, struct acpi_device *parent,
 		acpi_handle handle, int type);
 
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/scan.c.old	2004-11-05 21:58:55.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/scan.c	2004-11-05 21:59:48.000000000 +0100
@@ -44,6 +44,10 @@
 typedef void acpi_device_sysfs_files(struct kobject *,
 				const struct attribute *);
 
+static int
+acpi_bus_trim(struct acpi_device        *start,
+				int rmdevice);
+
 static void setup_sys_fs_device_files(struct acpi_device *dev,
 		acpi_device_sysfs_files *func);
 
@@ -1213,7 +1217,7 @@
 }
 
 
-int
+static int
 acpi_bus_trim(struct acpi_device	*start,
 		int rmdevice)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utxface.c.old	2004-11-05 22:20:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/acpi/utilities/utxface.c	2004-11-05 22:21:00.000000000 +0100
@@ -368,95 +368,6 @@
 }
 
 
-/******************************************************************************
- *
- * FUNCTION:    acpi_get_system_info
- *
- * PARAMETERS:  out_buffer      - a pointer to a buffer to receive the
- *                                resources for the device
- *              buffer_length   - the number of bytes available in the buffer
- *
- * RETURN:      Status          - the status of the call
- *
- * DESCRIPTION: This function is called to get information about the current
- *              state of the ACPI subsystem.  It will return system information
- *              in the out_buffer.
- *
- *              If the function fails an appropriate status will be returned
- *              and the value of out_buffer is undefined.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_get_system_info (
-	struct acpi_buffer              *out_buffer)
-{
-	struct acpi_system_info         *info_ptr;
-	u32                             i;
-	acpi_status                     status;
-
-
-	ACPI_FUNCTION_TRACE ("acpi_get_system_info");
-
-
-	/* Parameter validation */
-
-	status = acpi_ut_validate_buffer (out_buffer);
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
-	/* Validate/Allocate/Clear caller buffer */
-
-	status = acpi_ut_initialize_buffer (out_buffer, sizeof (struct acpi_system_info));
-	if (ACPI_FAILURE (status)) {
-		return_ACPI_STATUS (status);
-	}
-
-	/*
-	 * Populate the return buffer
-	 */
-	info_ptr = (struct acpi_system_info *) out_buffer->pointer;
-
-	info_ptr->acpi_ca_version   = ACPI_CA_VERSION;
-
-	/* System flags (ACPI capabilities) */
-
-	info_ptr->flags             = ACPI_SYS_MODE_ACPI;
-
-	/* Timer resolution - 24 or 32 bits  */
-
-	if (!acpi_gbl_FADT) {
-		info_ptr->timer_resolution = 0;
-	}
-	else if (acpi_gbl_FADT->tmr_val_ext == 0) {
-		info_ptr->timer_resolution = 24;
-	}
-	else {
-		info_ptr->timer_resolution = 32;
-	}
-
-	/* Clear the reserved fields */
-
-	info_ptr->reserved1         = 0;
-	info_ptr->reserved2         = 0;
-
-	/* Current debug levels */
-
-	info_ptr->debug_layer       = acpi_dbg_layer;
-	info_ptr->debug_level       = acpi_dbg_level;
-
-	/* Current status of the ACPI tables, per table type */
-
-	info_ptr->num_table_types = NUM_ACPI_TABLE_TYPES;
-	for (i = 0; i < NUM_ACPI_TABLE_TYPES; i++) {
-		info_ptr->table_info[i].count = acpi_gbl_table_lists[i].count;
-	}
-
-	return_ACPI_STATUS (AE_OK);
-}
-
-
 /*****************************************************************************
  *
  * FUNCTION:    acpi_install_initialization_handler
--- linux-2.6.10-rc1-mm3-full/drivers/acpi/hardware/hwtimer.c	2004-11-05 21:56:16.000000000 +0100
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,200 +0,0 @@
-
-/******************************************************************************
- *
- * Name: hwtimer.c - ACPI Power Management Timer Interface
- *
- *****************************************************************************/
-
-/*
- * Copyright (C) 2000 - 2004, R. Byron Moore
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce at minimum a disclaimer
- *    substantially similar to the "NO WARRANTY" disclaimer below
- *    ("Disclaimer") and any redistribution must be conditioned upon
- *    including a substantially similar Disclaimer requirement for further
- *    binary redistribution.
- * 3. Neither the names of the above-listed copyright holders nor the names
- *    of any contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * Alternatively, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2 as published by the Free
- * Software Foundation.
- *
- * NO WARRANTY
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
- * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
- * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
- * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGES.
- */
-
-#include <acpi/acpi.h>
-
-#define _COMPONENT          ACPI_HARDWARE
-	 ACPI_MODULE_NAME    ("hwtimer")
-
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_get_timer_resolution
- *
- * PARAMETERS:  Resolution          - Where the resolution is returned
- *
- * RETURN:      Status and timer resolution
- *
- * DESCRIPTION: Obtains resolution of the ACPI PM Timer (24 or 32 bits).
- *
- ******************************************************************************/
-
-acpi_status
-acpi_get_timer_resolution (
-	u32                             *resolution)
-{
-	ACPI_FUNCTION_TRACE ("acpi_get_timer_resolution");
-
-
-	if (!resolution) {
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-	}
-
-	if (0 == acpi_gbl_FADT->tmr_val_ext) {
-		*resolution = 24;
-	}
-	else {
-		*resolution = 32;
-	}
-
-	return_ACPI_STATUS (AE_OK);
-}
-
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_get_timer
- *
- * PARAMETERS:  Ticks               - Where the timer value is returned
- *
- * RETURN:      Status and current ticks
- *
- * DESCRIPTION: Obtains current value of ACPI PM Timer (in ticks).
- *
- ******************************************************************************/
-
-acpi_status
-acpi_get_timer (
-	u32                             *ticks)
-{
-	acpi_status                     status;
-
-
-	ACPI_FUNCTION_TRACE ("acpi_get_timer");
-
-
-	if (!ticks) {
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-	}
-
-	status = acpi_hw_low_level_read (32, ticks, &acpi_gbl_FADT->xpm_tmr_blk);
-
-	return_ACPI_STATUS (status);
-}
-
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_get_timer_duration
- *
- * PARAMETERS:  start_ticks         - Starting timestamp
- *              end_ticks           - End timestamp
- *              time_elapsed        - Where the elapsed time is returned
- *
- * RETURN:      Status and time_elapsed
- *
- * DESCRIPTION: Computes the time elapsed (in microseconds) between two
- *              PM Timer time stamps, taking into account the possibility of
- *              rollovers, the timer resolution, and timer frequency.
- *
- *              The PM Timer's clock ticks at roughly 3.6 times per
- *              _microsecond_, and its clock continues through Cx state
- *              transitions (unlike many CPU timestamp counters) -- making it
- *              a versatile and accurate timer.
- *
- *              Note that this function accommodates only a single timer
- *              rollover.  Thus for 24-bit timers, this function should only
- *              be used for calculating durations less than ~4.6 seconds
- *              (~20 minutes for 32-bit timers) -- calculations below:
- *
- *              2**24 Ticks / 3,600,000 Ticks/Sec = 4.66 sec
- *              2**32 Ticks / 3,600,000 Ticks/Sec = 1193 sec or 19.88 minutes
- *
- ******************************************************************************/
-
-acpi_status
-acpi_get_timer_duration (
-	u32                             start_ticks,
-	u32                             end_ticks,
-	u32                             *time_elapsed)
-{
-	acpi_status                     status;
-	u32                             delta_ticks;
-	acpi_integer                    quotient;
-
-
-	ACPI_FUNCTION_TRACE ("acpi_get_timer_duration");
-
-
-	if (!time_elapsed) {
-		return_ACPI_STATUS (AE_BAD_PARAMETER);
-	}
-
-	/*
-	 * Compute Tick Delta:
-	 * Handle (max one) timer rollovers on 24-bit versus 32-bit timers.
-	 */
-	if (start_ticks < end_ticks) {
-		delta_ticks = end_ticks - start_ticks;
-	}
-	else if (start_ticks > end_ticks) {
-		if (0 == acpi_gbl_FADT->tmr_val_ext) {
-			/* 24-bit Timer */
-
-			delta_ticks = (((0x00FFFFFF - start_ticks) + end_ticks) & 0x00FFFFFF);
-		}
-		else {
-			/* 32-bit Timer */
-
-			delta_ticks = (0xFFFFFFFF - start_ticks) + end_ticks;
-		}
-	}
-	else /* start_ticks == end_ticks */ {
-		*time_elapsed = 0;
-		return_ACPI_STATUS (AE_OK);
-	}
-
-	/*
-	 * Compute Duration (Requires a 64-bit multiply and divide):
-	 *
-	 * time_elapsed = (delta_ticks * 1000000) / PM_TIMER_FREQUENCY;
-	 */
-	status = acpi_ut_short_divide (((u64) delta_ticks) * 1000000,
-			 PM_TIMER_FREQUENCY, &quotient, NULL);
-
-	*time_elapsed = (u32) quotient;
-	return_ACPI_STATUS (status);
-}
-
-

