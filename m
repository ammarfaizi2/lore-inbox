Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVEAM5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVEAM5O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 08:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVEAM5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 08:57:14 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:2772 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261604AbVEAM4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 08:56:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm2: ACPI problems
Date: Sun, 1 May 2005 14:56:38 +0200
User-Agent: KMail/1.7.1
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, "Yu, Luming" <luming.yu@intel.com>
References: <20050430164303.6538f47c.akpm@osdl.org>
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GINdC8X4GRJvc0d"
Message-Id: <200505011456.38744.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GINdC8X4GRJvc0d
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Sunday, 1 of May 2005 01:43, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/

I have two ACPI-related problems with this kernel (they have also been present
in the previous -mm, so please treat this report as a "the issue is still there" kind
of thing):

1) The box hangs solid during suspend/resume (in the PIC mode) due to problems
with handling PCI ACPI links (the details are available from bugzilla:
http://bugzilla.kernel.org/show_bug.cgi?id=4416).

2) The ACPI battery module does not seem to work, eg. this is the output of
"time cat /proc/acpi/battery/BAT0/state":

present:                 yes
capacity state:          ok
charging state:          charged
present rate:            unknown
remaining capacity:      unknown
present voltage:         unknown

real    0m44.875s
user    0m0.001s
sys     0m0.020s

To make it work, I needed to apply the attached patch.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_GINdC8X4GRJvc0d
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="2.6.12-rc3-mm2-acpi-ec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.12-rc3-mm2-acpi-ec.patch"

--- 2.6.12-rc3-mm2-old/drivers/acpi/ec.c	2005-05-01 13:13:43.000000000 +0200
+++ linux-2.6.12-rc3-mm2/drivers/acpi/ec.c	2005-05-01 14:08:12.000000000 +0200
@@ -31,7 +31,6 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
-#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -50,19 +49,17 @@ ACPI_MODULE_NAME		("acpi_ec")
 
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
-#define ACPI_EC_FLAG_BURST	0x10	/* burst mode */
 #define ACPI_EC_FLAG_SCI	0x20	/* EC-SCI occurred */
 
 #define ACPI_EC_EVENT_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
 
-#define ACPI_EC_DELAY		50	/* Wait 50ms max. during EC ops */
+#define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
+#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 
 #define ACPI_EC_COMMAND_READ	0x80
 #define ACPI_EC_COMMAND_WRITE	0x81
-#define ACPI_EC_BURST_ENABLE	0x82
-#define ACPI_EC_BURST_DISABLE	0x83
 #define ACPI_EC_COMMAND_QUERY	0x84
 
 static int acpi_ec_add (struct acpi_device *device);
@@ -90,11 +87,7 @@ struct acpi_ec {
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
 	unsigned long			global_lock;
-	unsigned int			expect_event;
-	atomic_t			leaving_burst; /* 0 : No, 1 : Yes, 2: abort*/
-	atomic_t			pending_gpe;
-	struct semaphore		sem;
-	wait_queue_head_t		wait;
+	spinlock_t			lock;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -107,138 +100,59 @@ static struct acpi_device *first_ec;
                              Transaction Management
    -------------------------------------------------------------------------- */
 
-static inline u32 acpi_ec_read_status(struct acpi_ec *ec)
-{
-	u32	status = 0;
-
-	acpi_hw_low_level_read(8, &status, &ec->status_addr);
-	return status;
-}
-
-static int acpi_ec_wait(struct acpi_ec *ec, unsigned int event)
+static int
+acpi_ec_wait (
+	struct acpi_ec		*ec,
+	u8			event)
 {
-	int	result = 0;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_wait");
+	u32			acpi_ec_status = 0;
+	u32			i = ACPI_EC_UDELAY_COUNT;
 
-	ec->expect_event = event;
-	smp_mb();
-
-	result = wait_event_interruptible_timeout(ec->wait,
-					!ec->expect_event,
-					msecs_to_jiffies(ACPI_EC_DELAY));
-	
-	ec->expect_event = 0;
-	smp_mb();
-
-	if (result < 0){
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR," result  = %d ", result));
-		return_VALUE(result);
-	}
+	if (!ec)
+		return -EINVAL;
 
-	/*
-	 * Verify that the event in question has actually happened by
-	 * querying EC status. Do the check even if operation timed-out
-	 * to make sure that we did not miss interrupt.
-	 */
+	/* Poll the EC status register waiting for the event to occur. */
 	switch (event) {
 	case ACPI_EC_EVENT_OBF:
-		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
-			return_VALUE(0);
+		do {
+			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
+			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
+				return 0;
+			udelay(ACPI_EC_UDELAY);
+		} while (--i>0);
 		break;
-
 	case ACPI_EC_EVENT_IBE:
-		if (~acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
-			return_VALUE(0);
+		do {
+			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
+			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
+				return 0;
+			udelay(ACPI_EC_UDELAY);
+		} while (--i>0);
 		break;
+	default:
+		return -EINVAL;
 	}
 
-	return_VALUE(-ETIME);
+	return -ETIME;
 }
 
 
-
-static int
-acpi_ec_enter_burst_mode (
-	struct acpi_ec		*ec)
-{
-	u32			tmp = 0;
-	int			status = 0;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_enter_burst_mode");
-
-	status = acpi_ec_read_status(ec);
-	if (status != -EINVAL &&
-		!(status & ACPI_EC_FLAG_BURST)){
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"entering burst mode \n"));
-		acpi_hw_low_level_write(8, ACPI_EC_BURST_ENABLE, &ec->command_addr);
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-		if (status){
-			acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR," status = %d\n", status));
-			return_VALUE(-EINVAL);
-		}
-		acpi_hw_low_level_read(8, &tmp, &ec->data_addr);
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-		if(tmp != 0x90 ) {/* Burst ACK byte*/
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,"Ack failed \n"));
-			return_VALUE(-EINVAL);
-		}
-	} else
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"already be in burst mode \n"));
-	atomic_set(&ec->leaving_burst , 0);
-	return_VALUE(0);
-}
-
-static int
-acpi_ec_leave_burst_mode (
-	struct acpi_ec		*ec)
-{
-	int			status =0;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_leave_burst_mode");
-
-	atomic_set(&ec->leaving_burst , 1);
-	status = acpi_ec_read_status(ec);
-	if (status != -EINVAL &&
-		(status & ACPI_EC_FLAG_BURST)){
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"leaving burst mode\n"));
-		acpi_hw_low_level_write(8, ACPI_EC_BURST_DISABLE, &ec->command_addr);
-		status = acpi_ec_wait(ec, ACPI_EC_FLAG_IBF);
-		if (status){
-			acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,"------->wait fail\n"));
-			return_VALUE(-EINVAL);
-		}
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-		status = acpi_ec_read_status(ec);
-		if (status != -EINVAL &&
-			(status & ACPI_EC_FLAG_BURST)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,"------->status fail\n"));
-			return_VALUE(-EINVAL);
-		}
-	}else
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"already be in Non-burst mode \n"));
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,"leaving burst mode\n"));
-
-	return_VALUE(0);
-}
-
 static int
 acpi_ec_read (
 	struct acpi_ec		*ec,
 	u8			address,
 	u32			*data)
 {
-	int			status = 0;
-	u32			glk;
+	acpi_status		status = AE_OK;
+	int			result = 0;
+	unsigned long		flags = 0;
+	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
 
 	if (!ec || !data)
 		return_VALUE(-EINVAL);
 
-retry:
 	*data = 0;
 
 	if (ec->global_lock) {
@@ -247,49 +161,30 @@ retry:
 			return_VALUE(-ENODEV);
 	}
 
-	WARN_ON(in_interrupt());
-	down(&ec->sem);
-
-	if(acpi_ec_enter_burst_mode(ec))
-		goto end;
+	spin_lock_irqsave(&ec->lock, flags);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-	if (status) {
+	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	if (result)
 		goto end;
-	}
 
 	acpi_hw_low_level_write(8, address, &ec->data_addr);
-	status= acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status){
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
+	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+	if (result)
 		goto end;
-	}
 
 	acpi_hw_low_level_read(8, data, &ec->data_addr);
-	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
 		*data, address));
 	
 end:
-	acpi_ec_leave_burst_mode(ec);
-	up(&ec->sem);
+	spin_unlock_irqrestore(&ec->lock, flags);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
-	if(atomic_read(&ec->leaving_burst) == 2){
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"aborted, retry ...\n"));
-		while(atomic_read(&ec->pending_gpe)){
-			msleep(1);	
-		}
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-		goto retry;
-	}
-
-	return_VALUE(status);
+	return_VALUE(result);
 }
 
 
@@ -299,80 +194,49 @@ acpi_ec_write (
 	u8			address,
 	u8			data)
 {
-	int			status = 0;
-	u32			glk;
-	u32			tmp;
+	int			result = 0;
+	acpi_status		status = AE_OK;
+	unsigned long		flags = 0;
+	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_write");
 
 	if (!ec)
 		return_VALUE(-EINVAL);
-retry:
+
 	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
 			return_VALUE(-ENODEV);
 	}
 
-	WARN_ON(in_interrupt());
-	down(&ec->sem);
-
-	if(acpi_ec_enter_burst_mode(ec))
-		goto end;
-
-	status = acpi_ec_read_status(ec);
-	if (status != -EINVAL &&
-		!(status & ACPI_EC_FLAG_BURST)){
-		acpi_hw_low_level_write(8, ACPI_EC_BURST_ENABLE, &ec->command_addr);
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-		if (status)
-			goto end;
-		acpi_hw_low_level_read(8, &tmp, &ec->data_addr);
-		if(tmp != 0x90 ) /* Burst ACK byte*/
-			goto end;
-	}
-	/*Now we are in burst mode*/
+	spin_lock_irqsave(&ec->lock, flags);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-	if (status){
+	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	if (result)
 		goto end;
-	}
 
 	acpi_hw_low_level_write(8, address, &ec->data_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status){
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
+	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	if (result)
 		goto end;
-	}
 
 	acpi_hw_low_level_write(8, data, &ec->data_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-	if (status)
+	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	if (result)
 		goto end;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
 		data, address));
 
 end:
-	acpi_ec_leave_burst_mode(ec);
-	up(&ec->sem);
+	spin_unlock_irqrestore(&ec->lock, flags);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
-	if(atomic_read(&ec->leaving_burst) == 2){
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"aborted, retry ...\n"));
-		while(atomic_read(&ec->pending_gpe)){
-			msleep(1);	
-		}
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-		goto retry;
-	}
-
-	return_VALUE(status);
+	return_VALUE(result);
 }
 
 /*
@@ -424,13 +288,16 @@ acpi_ec_query (
 	struct acpi_ec		*ec,
 	u32			*data)
 {
-	int			status = 0;
-	u32			glk;
+	int			result = 0;
+	acpi_status		status = AE_OK;
+	unsigned long		flags = 0;
+	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_query");
 
 	if (!ec || !data)
 		return_VALUE(-EINVAL);
+
 	*data = 0;
 
 	if (ec->global_lock) {
@@ -439,39 +306,29 @@ acpi_ec_query (
 			return_VALUE(-ENODEV);
 	}
 
-	down(&ec->sem);
-	if(acpi_ec_enter_burst_mode(ec))
-		goto end;
 	/*
 	 * Query the EC to find out which _Qxx method we need to evaluate.
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
+	spin_lock_irqsave(&ec->lock, flags);
+
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status){
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
+	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+	if (result)
 		goto end;
-	}
 
 	acpi_hw_low_level_read(8, data, &ec->data_addr);
-	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
 	if (!*data)
-		status = -ENODATA;
+		result = -ENODATA;
 
 end:
-	acpi_ec_leave_burst_mode(ec);
-	up(&ec->sem);
+	spin_unlock_irqrestore(&ec->lock, flags);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
-	if(atomic_read(&ec->leaving_burst) == 2){
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,"aborted, retry ...\n"));
-		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
-		status = -ENODATA;
-	}
-	return_VALUE(status);
+	return_VALUE(result);
 }
 
 
@@ -489,18 +346,31 @@ acpi_ec_gpe_query (
 	void			*ec_cxt)
 {
 	struct acpi_ec		*ec = (struct acpi_ec *) ec_cxt;
-	u32			value;
-	int			result = -ENODATA;
+	u32			value = 0;
+	unsigned long		flags = 0;
 	static char		object_name[5] = {'_','Q','0','0','\0'};
 	const char		hex[] = {'0','1','2','3','4','5','6','7',
 				         '8','9','A','B','C','D','E','F'};
 
 	ACPI_FUNCTION_TRACE("acpi_ec_gpe_query");
 
-	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI)
-		result = acpi_ec_query(ec, &value);
+	if (!ec_cxt)
+		goto end;
+
+	spin_lock_irqsave(&ec->lock, flags);
+	acpi_hw_low_level_read(8, &value, &ec->command_addr);
+	spin_unlock_irqrestore(&ec->lock, flags);
+
+	/* TBD: Implement asynch events!
+	 * NOTE: All we care about are EC-SCI's.  Other EC events are
+	 * handled via polling (yuck!).  This is because some systems
+	 * treat EC-SCIs as level (versus EDGE!) triggered, preventing
+	 *  a purely interrupt-driven approach (grumble, grumble).
+	 */
+	if (!(value & ACPI_EC_FLAG_SCI))
+		goto end;
 
-	if (result)
+	if (acpi_ec_query(ec, &value))
 		goto end;
 
 	object_name[2] = hex[((value >> 4) & 0x0F)];
@@ -509,9 +379,9 @@ acpi_ec_gpe_query (
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s\n", object_name));
 
 	acpi_evaluate_object(ec->handle, object_name, NULL, NULL);
+
 end:	
-	atomic_dec(&ec->pending_gpe);
-	return;
+	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
 }
 
 static u32
@@ -519,7 +389,6 @@ acpi_ec_gpe_handler (
 	void			*data)
 {
 	acpi_status		status = AE_OK;
-	u32			value;
 	struct acpi_ec		*ec = (struct acpi_ec *) data;
 
 	if (!ec)
@@ -527,41 +396,13 @@ acpi_ec_gpe_handler (
 
 	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 
-	value = acpi_ec_read_status(ec);
+	status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
+		acpi_ec_gpe_query, ec);
 
-	if((value & ACPI_EC_FLAG_IBF) &&
-		!(value & ACPI_EC_FLAG_BURST) &&
-			(atomic_read(&ec->leaving_burst) == 0)) { 
-	/*
-	 * the embedded controller disables 
-	 * burst mode for any reason other 
-	 * than the burst disable command
-	 * to process critical event.
-	 */
-		atomic_set(&ec->leaving_burst , 2); /* block current pending transaction
-					and retry */
-		wake_up(&ec->wait);
-	}else {
-		if ((ec->expect_event == ACPI_EC_EVENT_OBF &&
-				(value & ACPI_EC_FLAG_OBF)) ||
-	    			(ec->expect_event == ACPI_EC_EVENT_IBE &&
-				!(value & ACPI_EC_FLAG_IBF))) {
-			ec->expect_event = 0;
-			wake_up(&ec->wait);
-			return ACPI_INTERRUPT_HANDLED;
-		}
-	}
-
-	if (value & ACPI_EC_FLAG_SCI){
-		atomic_add(1, &ec->pending_gpe) ;
-		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
-						acpi_ec_gpe_query, ec);
-		return status == AE_OK ?
-		ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
-	} 
-	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
-	return status == AE_OK ?
-		ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
+	if (status == AE_OK)
+		return ACPI_INTERRUPT_HANDLED;
+	else
+		return ACPI_INTERRUPT_NOT_HANDLED;
 }
 
 /* --------------------------------------------------------------------------
@@ -579,8 +420,10 @@ acpi_ec_space_setup (
 	 * The EC object is in the handler context and is needed
 	 * when calling the acpi_ec_space_handler.
 	 */
-	*return_context  = (function != ACPI_REGION_DEACTIVATE) ?
-						handler_context : NULL;
+	if(function == ACPI_REGION_DEACTIVATE) 
+		*return_context = NULL;
+	else 
+		*return_context = handler_context;
 
 	return AE_OK;
 }
@@ -708,7 +551,7 @@ static int
 acpi_ec_add_fs (
 	struct acpi_device	*device)
 {
-	struct proc_dir_entry	*entry;
+	struct proc_dir_entry	*entry = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add_fs");
 
@@ -759,9 +602,9 @@ static int
 acpi_ec_add (
 	struct acpi_device	*device)
 {
-	int			result;
-	acpi_status		status;
-	struct acpi_ec		*ec;
+	int			result = 0;
+	acpi_status		status = AE_OK;
+	struct acpi_ec		*ec = NULL;
 	unsigned long		uid;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add");
@@ -776,10 +619,7 @@ acpi_ec_add (
 
 	ec->handle = device->handle;
 	ec->uid = -1;
- 	atomic_set(&ec->pending_gpe, 0);
- 	atomic_set(&ec->leaving_burst , 1);
- 	init_MUTEX(&ec->sem);
- 	init_waitqueue_head(&ec->wait);
+	spin_lock_init(&ec->lock);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -793,7 +633,7 @@ acpi_ec_add (
 	if (ec_ecdt && ec_ecdt->uid == uid) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
-
+	
 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
 
 		kfree(ec_ecdt);
@@ -833,7 +673,7 @@ acpi_ec_remove (
 	struct acpi_device	*device,
 	int			type)
 {
-	struct acpi_ec		*ec;
+	struct acpi_ec		*ec = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_remove");
 
@@ -888,8 +728,8 @@ static int
 acpi_ec_start (
 	struct acpi_device	*device)
 {
-	acpi_status		status;
-	struct acpi_ec		*ec;
+	acpi_status		status = AE_OK;
+	struct acpi_ec		*ec = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_start");
 
@@ -945,8 +785,8 @@ acpi_ec_stop (
 	struct acpi_device	*device,
 	int			type)
 {
-	acpi_status		status;
-	struct acpi_ec		*ec;
+	acpi_status		status = AE_OK;
+	struct acpi_ec		*ec = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_stop");
 
@@ -988,6 +828,7 @@ acpi_fake_ecdt_callback (
 	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt->gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
+	spin_lock_init(&ec_ecdt->lock);
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->handle = handle;
 
@@ -1045,7 +886,7 @@ acpi_ec_get_real_ecdt(void)
 	acpi_status		status;
 	struct acpi_table_ecdt 	*ecdt_ptr;
 
-	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
+	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
 		(struct acpi_table_header **) &ecdt_ptr);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -1060,12 +901,11 @@ acpi_ec_get_real_ecdt(void)
 		return -ENOMEM;
 	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
 
- 	init_MUTEX(&ec_ecdt->sem);
- 	init_waitqueue_head(&ec_ecdt->wait);
 	ec_ecdt->command_addr = ecdt_ptr->ec_control;
 	ec_ecdt->status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
+	spin_lock_init(&ec_ecdt->lock);
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;
@@ -1134,7 +974,7 @@ error:
 
 static int __init acpi_ec_init (void)
 {
-	int			result;
+	int			result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_init");
 

--Boundary-00=_GINdC8X4GRJvc0d--
