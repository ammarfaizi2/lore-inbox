Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWFOAO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWFOAO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWFOAO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:14:28 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:8380 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965050AbWFOAO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:14:27 -0400
Message-ID: <4490B48E.5060304@oracle.com>
Date: Wed, 14 Jun 2006 18:14:54 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Voluspa <lista1@comhem.se>
CC: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>, len.brown@intel.com
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
References: <20060615010850.3d375fa9.lista1@comhem.se>
In-Reply-To: <20060615010850.3d375fa9.lista1@comhem.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updated version:

From: Ben Collins <bcollins@ubuntu.com>

[UBUNTU:acpi/ec] Use semaphore instead of spinlock to get rid of missed
interrupts on ACPI EC (embedded controller)

Reference: https://launchpad.net/bugs/39315
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=c484728a760fcfcbad2319ed5364414bc86c3d38

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

---
 drivers/acpi/ec.c |   48 ++++++++++++++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 18 deletions(-)

--- linux-2617-rc6g7.orig/drivers/acpi/ec.c
+++ linux-2617-rc6g7/drivers/acpi/ec.c
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
@@ -323,7 +323,6 @@ static int acpi_ec_poll_read(union acpi_
 {
 	acpi_status status = AE_OK;
 	int result = 0;
-	unsigned long flags = 0;
 	u32 glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
@@ -339,7 +338,10 @@ static int acpi_ec_poll_read(union acpi_
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible(&ec->poll.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
 				&ec->common.command_addr);
@@ -358,7 +360,8 @@ static int acpi_ec_poll_read(union acpi_
 			  *data, address));
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->poll.sem);
+end_nosem:
 
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
@@ -384,7 +387,10 @@ static int acpi_ec_poll_write(union acpi
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible(&ec->poll.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
 				&ec->common.command_addr);
@@ -406,7 +412,8 @@ static int acpi_ec_poll_write(union acpi
 			  data, address));
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->poll.sem);
+end_nosem:
 
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
@@ -589,7 +596,10 @@ static int acpi_ec_poll_query(union acpi
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible(&ec->poll.sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
 				&ec->common.command_addr);
@@ -602,7 +612,8 @@ static int acpi_ec_poll_query(union acpi
 		result = -ENODATA;
 
       end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->poll.sem);
+end_nosem:
 
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
@@ -691,9 +702,10 @@ static void acpi_ec_gpe_poll_query(void 
 	if (!ec_cxt)
 		goto end;
 
-	spin_lock_irqsave(&ec->poll.lock, flags);
+	if (down_interruptible (&ec->poll.sem))
+		return_VOID;
 	acpi_hw_low_level_read(8, &value, &ec->common.command_addr);
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	up(&ec->poll.sem);
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -1005,7 +1017,7 @@ static int acpi_ec_poll_add(struct acpi_
 
 	ec->common.handle = device->handle;
 	ec->common.uid = -1;
-	spin_lock_init(&ec->poll.lock);
+	init_MUTEX(&ec->poll.sem);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -1300,7 +1312,7 @@ acpi_fake_ecdt_poll_callback(acpi_handle
 				  &ec_ecdt->common.gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
-	spin_lock_init(&ec_ecdt->poll.lock);
+	init_MUTEX(&ec_ecdt->poll.sem);
 	ec_ecdt->common.global_lock = TRUE;
 	ec_ecdt->common.handle = handle;
 
@@ -1416,7 +1428,7 @@ static int __init acpi_ec_poll_get_real_
 	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->common.data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->common.gpe_bit = ecdt_ptr->gpe_bit;
-	spin_lock_init(&ec_ecdt->poll.lock);
+	init_MUTEX(&ec_ecdt->poll.sem);
 	/* use the GL just to be safe */
 	ec_ecdt->common.global_lock = TRUE;
 	ec_ecdt->common.uid = ecdt_ptr->uid;


