Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWFNWV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWFNWV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFNWV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:21:58 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:35162 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932418AbWFNWV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:21:57 -0400
Message-ID: <44909A32.3010304@oracle.com>
Date: Wed, 14 Jun 2006 16:22:26 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, len.brown@intel.com
Subject: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Collins <bcollins@ubuntu.com>

[UBUNTU:acpi/ec] Use semaphore instead of spinlock to get rid of missed
interrupts on ACPI EC (embedded controller)

Reference: https://launchpad.net/bugs/39315
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=c484728a760fcfcbad2319ed5364414bc86c3d38

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -53,8 +53,8 @@ ACPI_MODULE_NAME("acpi_ec")
 #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
 #define ACPI_EC_DELAY		50	/* Wait 50ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
-#define ACPI_EC_UDELAY         100	/* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT   1000	/* Wait 10ms max. during EC ops */
+#define ACPI_EC_MSLEEP		1	/* Poll @ 1ms increments */
+#define ACPI_EC_MSLEEP_COUNT	10	/* Wait 10ms max. during EC ops */
 #define ACPI_EC_COMMAND_READ	0x80
 #define ACPI_EC_COMMAND_WRITE	0x81
 #define ACPI_EC_BURST_ENABLE	0x82
@@ -116,7 +116,7 @@ union acpi_ec {
 		struct acpi_generic_address command_addr;
 		struct acpi_generic_address data_addr;
 		unsigned long global_lock;
-		spinlock_t lock;
+		struct semaphore sem;
 	} poll;
 };
 
@@ -172,7 +172,7 @@ static int acpi_ec_wait(union acpi_ec *e
 static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event)
 {
 	u32 acpi_ec_status = 0;
-	u32 i = ACPI_EC_UDELAY_COUNT;
+	u32 i = ACPI_EC_MSLEEP_COUNT;
 
 	if (!ec)
 		return -EINVAL;
@@ -185,7 +185,7 @@ static int acpi_ec_poll_wait(union acpi_
 					       &ec->common.status_addr);
 			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(ACPI_EC_MSLEEP);
 		} while (--i > 0);
 		break;
 	case ACPI_EC_EVENT_IBE:
@@ -194,7 +194,7 @@ static int acpi_ec_poll_wait(union acpi_
 					       &ec->common.status_addr);
 			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(ACPI_EC_MSLEEP);
 		} while (--i > 0);
 		break;
 	default:
@@ -326,7 +326,6 @@ static int acpi_ec_poll_read(union acpi_
 {
 	acpi_status status = AE_OK;
 	int result = 0;
-	unsigned long flags = 0;
 	u32 glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
@@ -342,7 +341,10 @@ static int acpi_ec_poll_read(union acpi_
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible(&ec->polling.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
 				&ec->common.command_addr);
@@ -361,7 +363,8 @@ static int acpi_ec_poll_read(union acpi_
 			  *data, address));
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->polling.sem);
+end_nosem:
 
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
@@ -387,7 +390,10 @@ static int acpi_ec_poll_write(union acpi
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible(&ec->polling.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
 				&ec->common.command_addr);
@@ -409,7 +415,8 @@ static int acpi_ec_poll_write(union acpi
 			  data, address));
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->polling.sem);
+end_nosem:
 
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
@@ -592,7 +599,10 @@ static int acpi_ec_poll_query(union acpi
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible(&ec->polling.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
 				&ec->common.command_addr);
@@ -605,7 +615,8 @@ static int acpi_ec_poll_query(union acpi
 		result = -ENODATA;
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->polling.sem);
+end_nosem:
 
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
@@ -694,9 +705,10 @@ static void acpi_ec_gpe_poll_query(void 
 	if (!ec_cxt)
 		goto end;
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible (&ec->polling.sem))
+		return_VOID;
 	acpi_hw_low_level_read(8, &value, &ec->common.command_addr);
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->polling.sem);
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -1008,7 +1020,7 @@ static int acpi_ec_poll_add(struct acpi_
 
 	ec->common.handle = device->handle;
 	ec->common.uid = -1;
-	spin_lock_init(&ec->poll.lock);
+	init_MUTEX(&ec->polling.sem);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -1303,7 +1315,7 @@ acpi_fake_ecdt_poll_callback(acpi_handle
 				  &ec_ecdt->common.gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
-	spin_lock_init(&ec_ecdt->poll.lock);
+	init_MUTEX(&ec_ecdt->polling.sem);
 	ec_ecdt->common.global_lock = TRUE;
 	ec_ecdt->common.handle = handle;
 
@@ -1419,7 +1431,7 @@ static int __init acpi_ec_poll_get_real_
 	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->common.data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->common.gpe_bit = ecdt_ptr->gpe_bit;
-	spin_lock_init(&ec_ecdt->poll.lock);
+	init_MUTEX(&ec_ecdt->polling.sem);
 	/* use the GL just to be safe */
 	ec_ecdt->common.global_lock = TRUE;
 	ec_ecdt->common.uid = ecdt_ptr->uid;

