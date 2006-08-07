Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWHGObF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWHGObF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWHGObF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:31:05 -0400
Received: from twin.jikos.cz ([213.151.79.26]:59523 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750955AbWHGObE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:31:04 -0400
Date: Mon, 7 Aug 2006 16:30:43 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Len Brown <len.brown@intel.com>
cc: linux-acpi@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [RESEND] [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
Message-ID: <Pine.LNX.4.58.0608071602480.26318@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

acpi_pci_link_set() allocates with GFP_ATOMIC. On resume from suspend,
this is called with interrupts off, otherwise GFP_KERNEL is safe.

On the other hand, when resuming from suspend with interrupts off, the 
following callchain allocates with GFP_KERNEL, which is wrong:

acpi_pci_link_resume -> acpi_pci_link_set -> acpi_set_current_resources ->
acpi_rs_set_srs_method_data -> acpi_ut_create_internal_object_dbg ->
acpi_ut_allocate_object_desc_dbg -> acpi_os_acquire_object ->
kmem_cache_alloc(GFP_KERNEL) flag.

Resending patch, which didn't make it into -rc4, to fix both issues. The
patch is intentionally using irqs_disabled() and does not check in_resume
flag, as this is marked for removal (which is for example how
acpi_os_allocate() checks whether it should perform GFP_KERNEL or
GFP_ATOMIC allocation).

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- drivers/acpi/osl.c.orig	2006-07-15 21:00:43.000000000 +0200
+++ drivers/acpi/osl.c	2006-07-23 16:03:08.000000000 +0200
@@ -1141,7 +1141,13 @@ acpi_status acpi_os_release_object(acpi_
 
 void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
-	void *object = kmem_cache_alloc(cache, GFP_KERNEL);
+	void *object;
+
+	/* irqs could be disabled when resuming from suspend */
+	if (irqs_disabled())
+		object = kmem_cache_alloc(cache, GFP_ATOMIC);
+	else
+		object = kmem_cache_alloc(cache, GFP_KERNEL);
 	WARN_ON(!object);
 	return object;
 }
--- drivers/acpi/pci_link.c.orig	2006-07-15 21:00:43.000000000 +0200
+++ drivers/acpi/pci_link.c	2006-07-23 16:01:42.000000000 +0200
@@ -318,7 +318,12 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	/* irqs could be disabled when resuming from suspend */
+	if (irqs_disabled())
+		resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	else
+		resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
+	
 	if (!resource)
 		return_VALUE(-ENOMEM);
 

-- 
JiKos.
