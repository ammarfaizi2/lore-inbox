Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932823AbWFVHZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWFVHZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbWFVHZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:25:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5604 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932469AbWFVHZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:25:36 -0400
Date: Thu, 22 Jun 2006 09:20:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, michal.k.k.piotrowski@gmail.com,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, robert.moore@intel.com,
       Arjan van de Ven <arjan@infradead.org>
Subject: [patch] ACPI: reduce code size, clean up, fix validator message
Message-ID: <20060622072029.GA19228@elte.hu>
References: <CFF307C98FEABE47A452B27C06B85BB6CF0CF1@hdsmsx411.amr.corp.intel.com> <20060621215946.5d27e1f1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621215946.5d27e1f1.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > It complains about this only the 1st time, even though
> > this same code sequence runs for every (subsequent) ACPI interrupt.

that is because the lock validator turns itself off after the first 
complaint.

> Yes, lockdep uses the callsite of spin_lock_init() to detect the 
> "type" of a lock.
> 
> But the ACPI obfuscation layers use the same spin_lock_init() site to 
> initialise two not-the-same locks, so lockdep decides those two locks 
> are of the same "type" and gets confused.
> 
> We had earlier decided to remove that ACPI code which kmallocs a 
> single spinlock.  When that's done, lockdep will become unconfused.
> 
> AFACIT it's all used for just two statically allocated locks anwyay.

Ok, great! Find below the (tested) cleanup that also fixes the validator 
problem.

(if ACPI wants to turn this into platform-independent code it should be 
a build-time and type-correct translation layer that understands things 
like DEFINE_SPINLOCK as well.)

	Ingo

----------------------------
Subject: ACPI: reduce code size, clean up, fix validator message
From: Ingo Molnar <mingo@elte.hu>

this patch:

- reduces ACPI code size by 336 bytes:

   text            data    bss     dec           hex      filename
   21848901        6941178 4515464 33305543      1fc33c7  vmlinux-before
   21848565        6941270 4515464 33305299      1fc32d3  vmlinux-after

- cleans the code up by going from the opaque (void *) acpi_handle
  type to an explicit type-checked spinlock_t and by removing 70
  lines of code of unnecessary layering.

- fixes lock validator message by initializing the two static
  locks build-time instead of runtime.

- speeds up the code a bit by reducing extra runtime layering and 
  improving cache footprint.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/acpi/events/evgpe.c       |   11 ++++---
 drivers/acpi/events/evgpeblk.c    |   20 ++++++-------
 drivers/acpi/events/evxface.c     |    8 ++---
 drivers/acpi/hardware/hwregs.c    |   19 ++++++------
 drivers/acpi/osl.c                |   56 --------------------------------------
 drivers/acpi/utilities/utglobal.c |    3 ++
 drivers/acpi/utilities/utmutex.c  |   13 --------
 include/acpi/acglobal.h           |    4 +-
 include/acpi/acpiosxf.h           |    8 -----
 9 files changed, 35 insertions(+), 107 deletions(-)

Index: linux/drivers/acpi/events/evgpe.c
===================================================================
--- linux.orig/drivers/acpi/events/evgpe.c
+++ linux/drivers/acpi/events/evgpe.c
@@ -396,7 +396,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 
 	/* We need to hold the GPE lock now, hardware lock in the loop */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 
 	/* Examine all GPE blocks attached to this interrupt level */
 
@@ -413,7 +413,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 
 			gpe_register_info = &gpe_block->register_info[i];
 
-			hw_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
+			spin_lock_irqsave(&acpi_gbl_hardware_lock, hw_flags);
 
 			/* Read the Status Register */
 
@@ -423,7 +423,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 						   &gpe_register_info->
 						   status_address);
 			if (ACPI_FAILURE(status)) {
-				acpi_os_release_lock(acpi_gbl_hardware_lock,
+				spin_unlock_irqrestore(&acpi_gbl_hardware_lock,
 						     hw_flags);
 				goto unlock_and_exit;
 			}
@@ -435,7 +435,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 						   &enable_reg,
 						   &gpe_register_info->
 						   enable_address);
-			acpi_os_release_lock(acpi_gbl_hardware_lock, hw_flags);
+			spin_unlock_irqrestore(&acpi_gbl_hardware_lock,
+						hw_flags);
 
 			if (ACPI_FAILURE(status)) {
 				goto unlock_and_exit;
@@ -486,7 +487,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_x
 
       unlock_and_exit:
 
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 	return (int_status);
 }
 
Index: linux/drivers/acpi/events/evgpeblk.c
===================================================================
--- linux.orig/drivers/acpi/events/evgpeblk.c
+++ linux/drivers/acpi/events/evgpeblk.c
@@ -140,7 +140,7 @@ acpi_status acpi_ev_walk_gpe_list(acpi_g
 
 	ACPI_FUNCTION_TRACE(ev_walk_gpe_list);
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 
 	/* Walk the interrupt level descriptor list */
 
@@ -166,7 +166,7 @@ acpi_status acpi_ev_walk_gpe_list(acpi_g
 	}
 
       unlock_and_exit:
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
 
@@ -513,7 +513,7 @@ static struct acpi_gpe_xrupt_info *acpi_
 
 	/* Install new interrupt descriptor with spin lock */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 	if (acpi_gbl_gpe_xrupt_list_head) {
 		next_gpe_xrupt = acpi_gbl_gpe_xrupt_list_head;
 		while (next_gpe_xrupt->next) {
@@ -525,7 +525,7 @@ static struct acpi_gpe_xrupt_info *acpi_
 	} else {
 		acpi_gbl_gpe_xrupt_list_head = gpe_xrupt;
 	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 
 	/* Install new interrupt handler if not SCI_INT */
 
@@ -583,7 +583,7 @@ acpi_ev_delete_gpe_xrupt(struct acpi_gpe
 
 	/* Unlink the interrupt block with lock */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 	if (gpe_xrupt->previous) {
 		gpe_xrupt->previous->next = gpe_xrupt->next;
 	}
@@ -591,7 +591,7 @@ acpi_ev_delete_gpe_xrupt(struct acpi_gpe
 	if (gpe_xrupt->next) {
 		gpe_xrupt->next->previous = gpe_xrupt->previous;
 	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 
 	/* Free the block */
 
@@ -636,7 +636,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 
 	/* Install the new block at the end of the list with lock */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 	if (gpe_xrupt_block->gpe_block_list_head) {
 		next_gpe_block = gpe_xrupt_block->gpe_block_list_head;
 		while (next_gpe_block->next) {
@@ -650,7 +650,7 @@ acpi_ev_install_gpe_block(struct acpi_gp
 	}
 
 	gpe_block->xrupt_block = gpe_xrupt_block;
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 
       unlock_and_exit:
 	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
@@ -696,7 +696,7 @@ acpi_status acpi_ev_delete_gpe_block(str
 	} else {
 		/* Remove the block on this interrupt with lock */
 
-		flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+		spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 		if (gpe_block->previous) {
 			gpe_block->previous->next = gpe_block->next;
 		} else {
@@ -707,7 +707,7 @@ acpi_status acpi_ev_delete_gpe_block(str
 		if (gpe_block->next) {
 			gpe_block->next->previous = gpe_block->previous;
 		}
-		acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+		spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 	}
 
 	/* Free the gpe_block */
Index: linux/drivers/acpi/events/evxface.c
===================================================================
--- linux.orig/drivers/acpi/events/evxface.c
+++ linux/drivers/acpi/events/evxface.c
@@ -613,7 +613,7 @@ acpi_install_gpe_handler(acpi_handle gpe
 
 	/* Install the handler */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 	gpe_event_info->dispatch.handler = handler;
 
 	/* Setup up dispatch flags to indicate handler (vs. method) */
@@ -621,7 +621,7 @@ acpi_install_gpe_handler(acpi_handle gpe
 	gpe_event_info->flags &= ~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);	/* Clear bits */
 	gpe_event_info->flags |= (u8) (type | ACPI_GPE_DISPATCH_HANDLER);
 
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
@@ -707,7 +707,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 
 	/* Remove the handler */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	spin_lock_irqsave(&acpi_gbl_gpe_lock, flags);
 	handler = gpe_event_info->dispatch.handler;
 
 	/* Restore Method node (if any), set dispatch flags */
@@ -717,7 +717,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_
 	if (handler->method_node) {
 		gpe_event_info->flags |= ACPI_GPE_DISPATCH_METHOD;
 	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	spin_unlock_irqrestore(&acpi_gbl_gpe_lock, flags);
 
 	/* Now we can free the handler object */
 
Index: linux/drivers/acpi/hardware/hwregs.c
===================================================================
--- linux.orig/drivers/acpi/hardware/hwregs.c
+++ linux/drivers/acpi/hardware/hwregs.c
@@ -67,7 +67,7 @@ ACPI_MODULE_NAME("hwregs")
 acpi_status acpi_hw_clear_acpi_status(u32 flags)
 {
 	acpi_status status;
-	acpi_cpu_flags lock_flags = 0;
+	acpi_cpu_flags lock_flags;
 
 	ACPI_FUNCTION_TRACE(hw_clear_acpi_status);
 
@@ -75,7 +75,7 @@ acpi_status acpi_hw_clear_acpi_status(u3
 			  ACPI_BITMASK_ALL_FIXED_STATUS,
 			  (u16) acpi_gbl_FADT->xpm1a_evt_blk.address));
 
-	lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
+	spin_lock_irqsave(&acpi_gbl_hardware_lock, lock_flags);
 
 	status = acpi_hw_register_write(ACPI_MTX_DO_NOT_LOCK,
 					ACPI_REGISTER_PM1_STATUS,
@@ -100,7 +100,8 @@ acpi_status acpi_hw_clear_acpi_status(u3
 	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block);
 
       unlock_and_exit:
-	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
+	spin_unlock_irqrestore(&acpi_gbl_hardware_lock, lock_flags);
+
 	return_ACPI_STATUS(status);
 }
 
@@ -339,7 +340,7 @@ acpi_status acpi_set_register(u32 regist
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
+	spin_lock_irqsave(&acpi_gbl_hardware_lock, lock_flags);
 
 	/* Always do a register read first so we can insert the new bits  */
 
@@ -447,7 +448,7 @@ acpi_status acpi_set_register(u32 regist
 
       unlock_and_exit:
 
-	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
+	spin_unlock_irqrestore(&acpi_gbl_hardware_lock, lock_flags);
 
 	/* Normalize the value that was read */
 
@@ -488,7 +489,7 @@ acpi_hw_register_read(u8 use_lock, u32 r
 	ACPI_FUNCTION_TRACE(hw_register_read);
 
 	if (ACPI_MTX_LOCK == use_lock) {
-		lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
+		spin_lock_irqsave(&acpi_gbl_hardware_lock, lock_flags);
 	}
 
 	switch (register_id) {
@@ -566,7 +567,7 @@ acpi_hw_register_read(u8 use_lock, u32 r
 
       unlock_and_exit:
 	if (ACPI_MTX_LOCK == use_lock) {
-		acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
+		spin_unlock_irqrestore(&acpi_gbl_hardware_lock, lock_flags);
 	}
 
 	if (ACPI_SUCCESS(status)) {
@@ -599,7 +600,7 @@ acpi_status acpi_hw_register_write(u8 us
 	ACPI_FUNCTION_TRACE(hw_register_write);
 
 	if (ACPI_MTX_LOCK == use_lock) {
-		lock_flags = acpi_os_acquire_lock(acpi_gbl_hardware_lock);
+		spin_lock_irqsave(&acpi_gbl_hardware_lock, lock_flags);
 	}
 
 	switch (register_id) {
@@ -689,7 +690,7 @@ acpi_status acpi_hw_register_write(u8 us
 
       unlock_and_exit:
 	if (ACPI_MTX_LOCK == use_lock) {
-		acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
+		spin_unlock_irqrestore(&acpi_gbl_hardware_lock, lock_flags);
 	}
 
 	return_ACPI_STATUS(status);
Index: linux/drivers/acpi/osl.c
===================================================================
--- linux.orig/drivers/acpi/osl.c
+++ linux/drivers/acpi/osl.c
@@ -685,40 +685,6 @@ void acpi_os_wait_events_complete(void *
 
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
@@ -1037,28 +1003,6 @@ unsigned int max_cstate = ACPI_PROCESSOR
 
 EXPORT_SYMBOL(max_cstate);
 
-/*
- * Acquire a spinlock.
- *
- * handle is a pointer to the spinlock_t.
- */
-
-acpi_cpu_flags acpi_os_acquire_lock(acpi_handle handle)
-{
-	acpi_cpu_flags flags;
-	spin_lock_irqsave((spinlock_t *) handle, flags);
-	return flags;
-}
-
-/*
- * Release a spinlock. See above.
- */
-
-void acpi_os_release_lock(acpi_handle handle, acpi_cpu_flags flags)
-{
-	spin_unlock_irqrestore((spinlock_t *) handle, flags);
-}
-
 #ifndef ACPI_USE_LOCAL_CACHE
 
 /*******************************************************************************
Index: linux/drivers/acpi/utilities/utglobal.c
===================================================================
--- linux.orig/drivers/acpi/utilities/utglobal.c
+++ linux/drivers/acpi/utilities/utglobal.c
@@ -46,6 +46,9 @@
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
+DEFINE_SPINLOCK(acpi_gbl_gpe_lock);
+DEFINE_SPINLOCK(acpi_gbl_hardware_lock);
+
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utglobal")
 
Index: linux/drivers/acpi/utilities/utmutex.c
===================================================================
--- linux.orig/drivers/acpi/utilities/utmutex.c
+++ linux/drivers/acpi/utilities/utmutex.c
@@ -79,15 +79,6 @@ acpi_status acpi_ut_mutex_initialize(voi
 			return_ACPI_STATUS(status);
 		}
 	}
-
-	/* Create the spinlocks for use at interrupt level */
-
-	status = acpi_os_create_lock(&acpi_gbl_gpe_lock);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	status = acpi_os_create_lock(&acpi_gbl_hardware_lock);
 	return_ACPI_STATUS(status);
 }
 
@@ -116,10 +107,6 @@ void acpi_ut_mutex_terminate(void)
 		(void)acpi_ut_delete_mutex(i);
 	}
 
-	/* Delete the spinlocks */
-
-	acpi_os_delete_lock(acpi_gbl_gpe_lock);
-	acpi_os_delete_lock(acpi_gbl_hardware_lock);
 	return_VOID;
 }
 
Index: linux/include/acpi/acglobal.h
===================================================================
--- linux.orig/include/acpi/acglobal.h
+++ linux/include/acpi/acglobal.h
@@ -317,8 +317,8 @@ ACPI_EXTERN struct acpi_gpe_block_info
 
 /* Spinlocks */
 
-ACPI_EXTERN acpi_handle acpi_gbl_gpe_lock;
-ACPI_EXTERN acpi_handle acpi_gbl_hardware_lock;
+extern spinlock_t acpi_gbl_gpe_lock;
+extern spinlock_t acpi_gbl_hardware_lock;
 
 /*****************************************************************************
  *
Index: linux/include/acpi/acpiosxf.h
===================================================================
--- linux.orig/include/acpi/acpiosxf.h
+++ linux/include/acpi/acpiosxf.h
@@ -108,14 +108,6 @@ acpi_status acpi_os_wait_semaphore(acpi_
 
 acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units);
 
-acpi_status acpi_os_create_lock(acpi_handle * out_handle);
-
-void acpi_os_delete_lock(acpi_handle handle);
-
-acpi_cpu_flags acpi_os_acquire_lock(acpi_handle handle);
-
-void acpi_os_release_lock(acpi_handle handle, acpi_cpu_flags flags);
-
 /*
  * Memory allocation and mapping
  */
