Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751719AbWHTW2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719AbWHTW2G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWHTW2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:28:06 -0400
Received: from tango.0pointer.de ([217.160.223.3]:9490 "EHLO tango.0pointer.de")
	by vger.kernel.org with ESMTP id S1751667AbWHTW2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:28:04 -0400
Date: Mon, 21 Aug 2006 00:27:59 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: ec_transaction(), second try
Message-ID: <20060820222759.GA5369@curacao>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lennart Poettering <mzxreary@0pointer.de>

This is the second version of my patch which unifies the logic of
ec_read() and ec_write() into ec_transaction(). Most things I wrote
about the first version are still true:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115517205307700&w=2

The changes are:

- Updated for Kernel 2.6.18pre (Linus' GIT tree as of today)

- Fix a bad argument validity check in acpi_ec_poll_transaction() as
  pointed out by Yu Luming.

- I unified the code in acpi_ec_poll_transaction() and
  acpi_ec_intr_transaction() a little more. Both functions are now just
  wrappers around the new acpi_ec_transaction_unlocked() function. The
  latter contains the EC access logic, the two original
  function now just do their special way of locking and call the the
  new function for the actual work.

This patch is required for my MSI laptop support patch.

Based on Linus' GIT tree and should also apply to the current ACPI
tree. 

Please merge!

Lennart

Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
---
 drivers/acpi/ec.c    |  331 +++++++++++++++-----------------------------------
 include/linux/acpi.h |    3 
 2 files changed, 101 insertions(+), 233 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e5d7963..fb750fb 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -122,12 +122,12 @@ union acpi_ec {
 
 static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event);
 static int acpi_ec_intr_wait(union acpi_ec *ec, unsigned int event);
-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data);
-static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, u32 * data);
-static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data);
-static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data);
-static int acpi_ec_poll_query(union acpi_ec *ec, u32 * data);
-static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data);
+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len);
+static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len);
 static void acpi_ec_gpe_poll_query(void *ec_cxt);
 static void acpi_ec_gpe_intr_query(void *ec_cxt);
 static u32 acpi_ec_gpe_poll_handler(void *data);
@@ -302,127 +302,114 @@ end:
 }
 #endif /* ACPI_FUTURE_USAGE */
 
-static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_transaction(union acpi_ec *ec, u8 command,
+                               const u8 *wdata, unsigned wdata_len,
+                               u8 *rdata, unsigned rdata_len)
 {
 	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_read(ec, address, data);
+		return acpi_ec_poll_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 	else
-		return acpi_ec_intr_read(ec, address, data);
+		return acpi_ec_intr_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 }
-static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
+static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
 {
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_write(ec, address, data);
-	else
-		return acpi_ec_intr_write(ec, address, data);
+        int result;
+        u8 d;
+        result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_READ, &address, 1, &d, 1);
+        *data = d;
+        return result;
 }
-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
 {
-	acpi_status status = AE_OK;
-	int result = 0;
-	u32 glk = 0;
+        u8 wdata[2] = { address, data };
+        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, wdata, 2, NULL, 0);
+}
 
+static int acpi_ec_transaction_unlocked(union acpi_ec *ec, u8 command,
+                                             const u8 *wdata, unsigned wdata_len,
+                                             u8 *rdata, unsigned rdata_len)
+{
+	int result;
+        
+	acpi_hw_low_level_write(8, command, &ec->common.command_addr);
 
-	if (!ec || !data)
-		return -EINVAL;
+        result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	if (result)
+		return result;
 
-	*data = 0;
+        for (; wdata_len > 0; wdata_len --) {
 
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
+                acpi_hw_low_level_write(8, *(wdata++), &ec->common.data_addr);
 
-	if (down_interruptible(&ec->poll.sem)) {
-		result = -ERESTARTSYS;
-		goto end_nosem;
-	}
-	
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+                if (result)
+                        return result;
+        }
 
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
-		goto end;
 
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
+        for (; rdata_len > 0; rdata_len --) {
+                u32 d;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
-			  *data, address));
+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+                if (result)
+                        return result;
 
-      end:
-	up(&ec->poll.sem);
-end_nosem:
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
+                acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
+                *(rdata++) = (u8) d;
+        }
 
-	return result;
+        return 0;
 }
 
-static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data)
+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len)
 {
-	int result = 0;
 	acpi_status status = AE_OK;
+	int result;
 	u32 glk = 0;
 
-
-	if (!ec)
+	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
 		return -EINVAL;
 
+        if (rdata)
+                memset(rdata, 0, rdata_len);
+
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
 			return -ENODEV;
-	}
+        }
 
 	if (down_interruptible(&ec->poll.sem)) {
 		result = -ERESTARTSYS;
 		goto end_nosem;
 	}
-	
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
-
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
-
-	acpi_hw_low_level_write(8, data, &ec->common.data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
-			  data, address));
-
-      end:
+        result = acpi_ec_transaction_unlocked(ec, command,
+                                              wdata, wdata_len,
+                                              rdata, rdata_len);
 	up(&ec->poll.sem);
+        
 end_nosem:
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
-	return result;
+	return result;        
 }
 
-static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len)
 {
-	int status = 0;
+	int status;
 	u32 glk;
 
-
-	if (!ec || !data)
+	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
 		return -EINVAL;
 
-	*data = 0;
+        if (rdata)
+                memset(rdata, 0, rdata_len);
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
@@ -438,72 +425,12 @@ static int acpi_ec_intr_read(union acpi_
 		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
 		goto end;
 	}
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
-				&ec->common.command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
-	}
-
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "read EC, OB not full\n");
-		goto end;
-	}
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
-			  *data, address));
-
-      end:
-	up(&ec->intr.sem);
-
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
-
-	return status;
-}
-
-static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data)
-{
-	int status = 0;
-	u32 glk;
-
-
-	if (!ec)
-		return -EINVAL;
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
-
-	WARN_ON(in_interrupt());
-	down(&ec->intr.sem);
-
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
-	}
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
-				&ec->common.command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
-	}
-
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
-	}
 
-	acpi_hw_low_level_write(8, data, &ec->common.data_addr);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
-			  data, address));
+        status = acpi_ec_transaction_unlocked(ec, command,
+                                              wdata, wdata_len,
+                                              rdata, rdata_len);
 
+end:
 	up(&ec->intr.sem);
 
 	if (ec->common.global_lock)
@@ -554,106 +481,44 @@ int ec_write(u8 addr, u8 val)
 
 EXPORT_SYMBOL(ec_write);
 
-static int acpi_ec_query(union acpi_ec *ec, u32 * data)
-{
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_query(ec, data);
-	else
-		return acpi_ec_intr_query(ec, data);
-}
-static int acpi_ec_poll_query(union acpi_ec *ec, u32 * data)
+extern int ec_transaction(u8 command,
+                          const u8 *wdata, unsigned wdata_len,
+                          u8 *rdata, unsigned rdata_len)
 {
-	int result = 0;
-	acpi_status status = AE_OK;
-	u32 glk = 0;
-
-
-	if (!ec || !data)
-		return -EINVAL;
-
-	*data = 0;
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
-
-	/*
-	 * Query the EC to find out which _Qxx method we need to evaluate.
-	 * Note that successful completion of the query causes the ACPI_EC_SCI
-	 * bit to be cleared (and thus clearing the interrupt source).
-	 */
-	if (down_interruptible(&ec->poll.sem)) {
-		result = -ERESTARTSYS;
-		goto end_nosem;
-	}
-	
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
-		goto end;
+	union acpi_ec *ec;
 
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	if (!*data)
-		result = -ENODATA;
+	if (!first_ec)
+		return -ENODEV;
 
-      end:
-	up(&ec->poll.sem);
-end_nosem:
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
+	ec = acpi_driver_data(first_ec);
 
-	return result;
+	return acpi_ec_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 }
-static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data)
-{
-	int status = 0;
-	u32 glk;
-
-
-	if (!ec || !data)
-		return -EINVAL;
-	*data = 0;
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
 
-	down(&ec->intr.sem);
+EXPORT_SYMBOL(ec_transaction);
 
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "query EC, IB not empty\n");
-		goto end;
-	}
-	/*
-	 * Query the EC to find out which _Qxx method we need to evaluate.
-	 * Note that successful completion of the query causes the ACPI_EC_SCI
-	 * bit to be cleared (and thus clearing the interrupt source).
-	 */
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
-				&ec->common.command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "query EC, OB not full\n");
-		goto end;
-	}
+static int acpi_ec_query(union acpi_ec *ec, u32 * data) {
+        int result;
+        u8 d;
 
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	if (!*data)
-		status = -ENODATA;
+        if (!ec || !data)
+                return -EINVAL;
+        
+        /*
+         * Query the EC to find out which _Qxx method we need to evaluate.
+         * Note that successful completion of the query causes the ACPI_EC_SCI
+         * bit to be cleared (and thus clearing the interrupt source).
+         */
 
-      end:
-	up(&ec->intr.sem);
+        result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1);
+        if (result)
+                return result;
 
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
+        if (!d)
+                return -ENODATA;
 
-	return status;
+        *data = d;
+        return 0;
 }
 
 /* --------------------------------------------------------------------------
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 88b5dfd..2b0c955 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -494,6 +494,9 @@ #ifdef CONFIG_ACPI_EC
 
 extern int ec_read(u8 addr, u8 *val);
 extern int ec_write(u8 addr, u8 val);
+extern int ec_transaction(u8 command,
+                          const u8 *wdata, unsigned wdata_len,
+                          u8 *rdata, unsigned rdata_len);
 
 #endif /*CONFIG_ACPI_EC*/
 
-- 
1.4.1

