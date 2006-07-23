Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWGWOUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWGWOUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 10:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGWOUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 10:20:51 -0400
Received: from twin.jikos.cz ([213.151.79.26]:674 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751102AbWGWOUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 10:20:50 -0400
Date: Sun, 23 Jul 2006 16:20:44 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: "Brown, Len" <len.brown@intel.com>
cc: linux-acpi <linux-acpi@intel.com>, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for non-atomic
 allocation
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6010912DB@hdsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0607231615410.30557@twin.jikos.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6010912DB@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006, Brown, Len wrote:

> > drivers/acpi/pci_link.c::acpi_pci_link_set() sets the GFP_ATOMIC for
> > kmalloc() allocation for no first-sight obvious reason; as far as I
> > can see this is always called outside the atomic/interrupt context, so
> > GFP_KERNEL allocation should be used instead.
> this would oops on a resume from suspend -- when it is called with
> interrupts off.

But in such a case I guess the following callchain has a problem:

acpi_pci_link_resume -> acpi_pci_link_set -> acpi_set_current_resources ->
acpi_rs_set_srs_method_data -> acpi_ut_create_internal_object_dbg ->
acpi_ut_allocate_object_desc_dbg -> acpi_os_acquire_object ->
kmem_cache_alloc with GFP_KERNEL flag.

What about the following patch to handle both cases without oopsing? (I am 
not using the acpi_in_resume flag, as it is makred for removal)


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
