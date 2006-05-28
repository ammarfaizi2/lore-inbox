Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWE1Sdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWE1Sdc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 14:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWE1Sdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 14:33:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:55996 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750855AbWE1Sdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 14:33:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rzl86yXRpX7Li4XLM6ahYF1uzyok9B9nOChUG+a/NtruMC/PaOa7vDRvq+9vXLSiTTEzp6pk2fGlkDNuMz/lNYYVGfIPD9qFUnSthRvAyd5/UV4g6Ymw/QONfyQkAeyS/idynr1WnmZmyLbhwdr2/l0uVnVCyS4MY0B3bTexGe0=
Date: Sun, 28 May 2006 22:34:03 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] Remove acpi_os_create_lock(), acpi_os_delete_lock()
Message-ID: <20060528183403.GA7266@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minimally intrusive patch to remove some overdesign in ACPI code. Based
on hch rant.

The only purpose of functions in question is to dynamically allocate
one global spinlock -- acpi_gbl_gpe_lock. Instead, create it in .bss.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 It's tempting to shoot acpi_os_release_lock() et al too.

 drivers/acpi/osl.c               |   34 ----------------------------------
 drivers/acpi/utilities/utmutex.c |    6 ++++--
 include/acpi/acpiosxf.h          |    4 ----
 3 files changed, 4 insertions(+), 40 deletions(-)

--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -659,40 +659,6 @@ void acpi_os_wait_events_complete(void *
 
 EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
-/*
- * Allocate the memory for a spinlock and initialize it.
- */
-acpi_status acpi_os_create_lock(acpi_handle * out_handle)
-{
-	spinlock_t *lock_ptr;
-
-	ACPI_FUNCTION_TRACE("os_create_lock");
-
-	lock_ptr = acpi_os_allocate(sizeof(spinlock_t));
-
-	spin_lock_init(lock_ptr);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating spinlock[%p].\n", lock_ptr));
-
-	*out_handle = lock_ptr;
-
-	return_ACPI_STATUS(AE_OK);
-}
-
-/*
- * Deallocate the memory for a spinlock.
- */
-void acpi_os_delete_lock(acpi_handle handle)
-{
-	ACPI_FUNCTION_TRACE("os_create_lock");
-
-	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting spinlock[%p].\n", handle));
-
-	acpi_os_free(handle);
-
-	return_VOID;
-}
-
 acpi_status
 acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
 {
--- a/drivers/acpi/utilities/utmutex.c
+++ b/drivers/acpi/utilities/utmutex.c
@@ -51,6 +51,8 @@ static acpi_status acpi_ut_create_mutex(
 
 static acpi_status acpi_ut_delete_mutex(acpi_mutex_handle mutex_id);
 
+static spinlock_t __acpi_gbl_gpe_lock;
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_mutex_initialize
@@ -80,7 +82,8 @@ acpi_status acpi_ut_mutex_initialize(voi
 		}
 	}
 
-	status = acpi_os_create_lock(&acpi_gbl_gpe_lock);
+	spin_lock_init(&__acpi_gbl_gpe_lock);
+	acpi_gbl_gpe_lock = &__acpi_gbl_gpe_lock;
 	return_ACPI_STATUS(status);
 }
 
@@ -109,7 +112,6 @@ void acpi_ut_mutex_terminate(void)
 		(void)acpi_ut_delete_mutex(i);
 	}
 
-	acpi_os_delete_lock(acpi_gbl_gpe_lock);
 	return_VOID;
 }
 
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -104,10 +104,6 @@ acpi_status acpi_os_wait_semaphore(acpi_
 
 acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units);
 
-acpi_status acpi_os_create_lock(acpi_handle * out_handle);
-
-void acpi_os_delete_lock(acpi_handle handle);
-
 acpi_cpu_flags acpi_os_acquire_lock(acpi_handle handle);
 
 void acpi_os_release_lock(acpi_handle handle, acpi_cpu_flags flags);

