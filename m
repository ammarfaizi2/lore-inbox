Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVAOAZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVAOAZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVAOAZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:25:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:7130 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262052AbVAOAYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:24:24 -0500
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: [PATCH] fixup debug warnings during ACPI S3  resume from ram
Date: Sat, 15 Jan 2005 01:24:16 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501150124.16589.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the wakeup from suspend-to-ram I get several warnings (see below).
This patch fixes the warnings for me, but I am not an expert in ACPI. Please 
read the patch and consider to apply it. 

Signed-off-by: Christian Borntraeger <linux-kernel@borntraeger.net>

--- a/drivers/acpi/osl.c	2004-12-23 14:09:11 +01:00
+++ b/drivers/acpi/osl.c	2005-01-15 01:06:35 +01:00
@@ -145,7 +145,7 @@
 void *
 acpi_os_allocate(acpi_size size)
 {
-	return kmalloc(size, GFP_KERNEL);
+	return kmalloc(size, GFP_ATOMIC);
 }
 
 void
@@ -905,7 +905,7 @@
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n", 
handle, units, timeout));
 
-	if (in_atomic())
+	if (in_atomic() || irqs_disabled())
 		timeout = 0;
 
 	switch (timeout)
--- a/drivers/acpi/pci_link.c	2004-12-22 04:08:55 +01:00
+++ b/drivers/acpi/pci_link.c	2005-01-15 00:50:06 +01:00
@@ -315,7 +315,7 @@
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc( sizeof(*resource)+1, GFP_KERNEL);
+	resource = kmalloc( sizeof(*resource)+1, GFP_ATOMIC);
 	if(!resource)
 		return_VALUE(-ENOMEM);
 
-------------------

Warning messages: 

Debug: sleeping function called from invalid context 
at /usr/src/bk/linux-bk/mm/slab.c:2085
in_atomic():0, irqs_disabled():1
 [<c0103ef7>] dump_stack+0x17/0x20
 [<c01176b6>] __might_sleep+0xa6/0xb0
 [<c01400f2>] kmem_cache_alloc+0x82/0x90
 [<c0220ad1>] acpi_pci_link_set+0x7a/0x24e
 [<c022116a>] acpi_pci_link_resume+0x47/0x7d
 [<c02211e5>] irqrouter_resume+0x45/0x6d
 [<c0252d47>] sysdev_resume+0xe7/0xec
 [<c0256a68>] device_power_up+0x8/0xe
 [<c01331c3>] suspend_enter+0x33/0x50
 [<c013324f>] enter_state+0x3f/0x70
 [<c01333b3>] state_store+0xa3/0xaa
 [<c0187ee5>] subsys_attr_store+0x35/0x40
 [<c018813e>] flush_write_buffer+0x2e/0x40
 [<c01881b7>] sysfs_write_file+0x67/0x80
 [<c015515f>] vfs_write+0xbf/0x140
 [<c0155291>] sys_write+0x41/0x70
 [<c01030fb>] syscall_call+0x7/0xb



Debug: sleeping function called from invalid context 
at /usr/src/bk/linux-bk/mm/slab.c:2085
in_atomic():0, irqs_disabled():1
 [<c0103ef7>] dump_stack+0x17/0x20
 [<c01176b6>] __might_sleep+0xa6/0xb0
 [<c0140203>] __kmalloc+0xb3/0xc0
 [<c01f3350>] acpi_os_allocate+0xd/0xf
 [<c021437e>] acpi_ut_callocate+0x6b/0xd4
 [<c0214460>] acpi_ut_callocate_and_track+0x1c/0x7d
 [<c021421f>] acpi_ut_initialize_buffer+0x4e/0x98
 [<c020f704>] acpi_rs_create_byte_stream+0x93/0xfb
 [<c02114a4>] acpi_rs_set_srs_method_data+0x44/0xf4
 [<c02105b5>] acpi_set_current_resources+0x67/0x81
 [<c0220bbc>] acpi_pci_link_set+0x165/0x24e
 [<c022116a>] acpi_pci_link_resume+0x47/0x7d
 [<c02211e5>] irqrouter_resume+0x45/0x6d
 [<c0252d47>] sysdev_resume+0xe7/0xec
 [<c0256a68>] device_power_up+0x8/0xe
 [<c01331c3>] suspend_enter+0x33/0x50
 [<c013324f>] enter_state+0x3f/0x70
 [<c01333b3>] state_store+0xa3/0xaa
 [<c0187ee5>] subsys_attr_store+0x35/0x40
 [<c018813e>] flush_write_buffer+0x2e/0x40
 [<c01881b7>] sysfs_write_file+0x67/0x80
 [<c015515f>] vfs_write+0xbf/0x140
 [<c0155291>] sys_write+0x41/0x70
 [<c01030fb>] syscall_call+0x7/0xb



Debug: sleeping function called from invalid context at 
include2/asm/semaphore.h:107
in_atomic():0, irqs_disabled():1
 [<c0103ef7>] dump_stack+0x17/0x20
 [<c01176b6>] __might_sleep+0xa6/0xb0
 [<c01f3eaa>] acpi_os_wait_semaphore+0xef/0x1b7
 [<c0215fdf>] acpi_ut_acquire_mutex+0xc3/0x159
 [<c0214641>] acpi_ut_track_allocation+0x6c/0x14a
 [<c0214495>] acpi_ut_callocate_and_track+0x51/0x7d
 [<c021421f>] acpi_ut_initialize_buffer+0x4e/0x98
 [<c020f704>] acpi_rs_create_byte_stream+0x93/0xfb
 [<c02114a4>] acpi_rs_set_srs_method_data+0x44/0xf4
 [<c02105b5>] acpi_set_current_resources+0x67/0x81
 [<c0220bbc>] acpi_pci_link_set+0x165/0x24e
 [<c022116a>] acpi_pci_link_resume+0x47/0x7d
 [<c02211e5>] irqrouter_resume+0x45/0x6d
 [<c0252d47>] sysdev_resume+0xe7/0xec
 [<c0256a68>] device_power_up+0x8/0xe
 [<c01331c3>] suspend_enter+0x33/0x50
 [<c013324f>] enter_state+0x3f/0x70
 [<c01333b3>] state_store+0xa3/0xaa
 [<c0187ee5>] subsys_attr_store+0x35/0x40
 [<c018813e>] flush_write_buffer+0x2e/0x40
 [<c01881b7>] sysfs_write_file+0x67/0x80
 [<c015515f>] vfs_write+0xbf/0x140
 [<c0155291>] sys_write+0x41/0x70
 [<c01030fb>] syscall_call+0x7/0xb

