Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWFTBGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWFTBGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 21:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWFTBGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 21:06:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965030AbWFTBGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 21:06:53 -0400
Date: Mon, 19 Jun 2006 18:10:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: bhlope@mweb.co.za, linux-kernel@vger.kernel.org, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Message-Id: <20060619181006.729dda76.akpm@osdl.org>
In-Reply-To: <44974430.8050807@oracle.com>
References: <44909A32.3010304@oracle.com>
	<200606150738.18724.bhlope@mweb.co.za>
	<20060619174006.647e02c7.akpm@osdl.org>
	<44974430.8050807@oracle.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
> Andrew Morton wrote:
> > Bongani Hlope <bhlope@mweb.co.za> wrote:
> >>> @@ -342,7 +341,10 @@ static int acpi_ec_poll_read(union acpi_
> >>>  			return_VALUE(-ENODEV);
> >>>  	}
> >>>
> >>> -	spin_lock_irqsave(&ec->poll.lock, flags);
> >>> +	if (down_interruptible(&ec->polling.sem)) {
> >>                                                      ^^^^
> >> isn't this suppose to be: &ec->poll.sem
> > 
> > Good question.   Did it get resolved?
> 
> I posted a corrected patch that does that.
> No responses from the ACPI people.
> 

OK.  It appears that this patch is already somewhat partially in the acpi
devel tree.

But it's using a semaphore and not a mutex, and those udelays are still in
there.

Here's what git-apci has for that file:

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index eee0864..18b3ea9 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -116,7 +116,7 @@ union acpi_ec {
 		struct acpi_generic_address command_addr;
 		struct acpi_generic_address data_addr;
 		unsigned long global_lock;
-		spinlock_t lock;
+		struct semaphore sem;
 	} poll;
 };
 
@@ -323,7 +323,6 @@ static int acpi_ec_poll_read(union acpi_
 {
 	acpi_status status = AE_OK;
 	int result = 0;
-	unsigned long flags = 0;
 	u32 glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
@@ -339,8 +338,11 @@ static int acpi_ec_poll_read(union acpi_
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
-
+	if (down_interruptible(&ec->poll.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
+	
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
 				&ec->common.command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -358,8 +360,8 @@ static int acpi_ec_poll_read(union acpi_
 			  *data, address));
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
-
+	up(&ec->poll.sem);
+end_nosem:
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
@@ -370,7 +372,6 @@ static int acpi_ec_poll_write(union acpi
 {
 	int result = 0;
 	acpi_status status = AE_OK;
-	unsigned long flags = 0;
 	u32 glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_write");
@@ -384,8 +385,11 @@ static int acpi_ec_poll_write(union acpi
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
-
+	if (down_interruptible(&ec->poll.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
+	
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
 				&ec->common.command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -406,8 +410,8 @@ static int acpi_ec_poll_write(union acpi
 			  data, address));
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
-
+	up(&ec->poll.sem);
+end_nosem:
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
@@ -568,7 +572,6 @@ static int acpi_ec_poll_query(union acpi
 {
 	int result = 0;
 	acpi_status status = AE_OK;
-	unsigned long flags = 0;
 	u32 glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_query");
@@ -589,8 +592,11 @@ static int acpi_ec_poll_query(union acpi
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->poll.lock, flags);
-
+	if (down_interruptible(&ec->poll.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
+	
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
 				&ec->common.command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
@@ -602,8 +608,8 @@ static int acpi_ec_poll_query(union acpi
 		result = -ENODATA;
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
-
+	up(&ec->poll.sem);
+end_nosem:
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
@@ -680,7 +686,6 @@ static void acpi_ec_gpe_poll_query(void 
 {
 	union acpi_ec *ec = (union acpi_ec *)ec_cxt;
 	u32 value = 0;
-	unsigned long flags = 0;
 	static char object_name[5] = { '_', 'Q', '0', '0', '\0' };
 	const char hex[] = { '0', '1', '2', '3', '4', '5', '6', '7',
 		'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
@@ -691,9 +696,11 @@ static void acpi_ec_gpe_poll_query(void 
 	if (!ec_cxt)
 		goto end;
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible (&ec->poll.sem)) {
+		return_VOID;
+	}
 	acpi_hw_low_level_read(8, &value, &ec->common.command_addr);
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->poll.sem);
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -763,8 +770,7 @@ static u32 acpi_ec_gpe_poll_handler(void
 
 	acpi_disable_gpe(NULL, ec->common.gpe_bit, ACPI_ISR);
 
-	status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
-					     acpi_ec_gpe_query, ec);
+	status = acpi_os_execute(OSL_EC_POLL_HANDLER, acpi_ec_gpe_query, ec);
 
 	if (status == AE_OK)
 		return ACPI_INTERRUPT_HANDLED;
@@ -799,7 +805,7 @@ static u32 acpi_ec_gpe_intr_handler(void
 
 	if (value & ACPI_EC_FLAG_SCI) {
 		atomic_add(1, &ec->intr.pending_gpe);
-		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
+		status = acpi_os_execute(OSL_EC_BURST_HANDLER,
 						     acpi_ec_gpe_query, ec);
 		return status == AE_OK ?
 		    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
@@ -991,7 +997,6 @@ static int acpi_ec_poll_add(struct acpi_
 	int result = 0;
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
-	unsigned long uid;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add");
 
@@ -1005,7 +1010,7 @@ static int acpi_ec_poll_add(struct acpi_
 
 	ec->common.handle = device->handle;
 	ec->common.uid = -1;
-	spin_lock_init(&ec->poll.lock);
+	init_MUTEX(&ec->poll.sem);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -1014,10 +1019,9 @@ static int acpi_ec_poll_add(struct acpi_
 	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
 			      &ec->common.global_lock);
 
-	/* If our UID matches the UID for the ECDT-enumerated EC,
-	   we now have the *real* EC info, so kill the makeshift one. */
-	acpi_evaluate_integer(ec->common.handle, "_UID", NULL, &uid);
-	if (ec_ecdt && ec_ecdt->common.uid == uid) {
+	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
+	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
+	if (ec_ecdt) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 						  ACPI_ADR_SPACE_EC,
 						  &acpi_ec_space_handler);
@@ -1062,7 +1066,6 @@ static int acpi_ec_intr_add(struct acpi_
 	int result = 0;
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
-	unsigned long uid;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add");
 
@@ -1088,10 +1091,9 @@ static int acpi_ec_intr_add(struct acpi_
 	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
 			      &ec->common.global_lock);
 
-	/* If our UID matches the UID for the ECDT-enumerated EC,
-	   we now have the *real* EC info, so kill the makeshift one. */
-	acpi_evaluate_integer(ec->common.handle, "_UID", NULL, &uid);
-	if (ec_ecdt && ec_ecdt->common.uid == uid) {
+	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
+	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
+	if (ec_ecdt) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 						  ACPI_ADR_SPACE_EC,
 						  &acpi_ec_space_handler);
@@ -1300,7 +1302,7 @@ acpi_fake_ecdt_poll_callback(acpi_handle
 				  &ec_ecdt->common.gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
-	spin_lock_init(&ec_ecdt->poll.lock);
+	init_MUTEX(&ec_ecdt->poll.sem);
 	ec_ecdt->common.global_lock = TRUE;
 	ec_ecdt->common.handle = handle;
 
@@ -1416,7 +1418,7 @@ static int __init acpi_ec_poll_get_real_
 	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->common.data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->common.gpe_bit = ecdt_ptr->gpe_bit;
-	spin_lock_init(&ec_ecdt->poll.lock);
+	init_MUTEX(&ec_ecdt->poll.sem);
 	/* use the GL just to be safe */
 	ec_ecdt->common.global_lock = TRUE;
 	ec_ecdt->common.uid = ecdt_ptr->uid;

