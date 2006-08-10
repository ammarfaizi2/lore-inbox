Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWHJBFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWHJBFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWHJBFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:05:22 -0400
Received: from tango.0pointer.de ([217.160.223.3]:41994 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S932495AbWHJBFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:05:20 -0400
Date: Thu, 10 Aug 2006 03:05:12 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] acpi,backlight: MSI S270 laptop support - ec_transaction()
Message-ID: <20060810010512.GA20571@curacao>
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

The attached patch unifies a few functions in ec.c:

    acpi_ec_poll_read()
    acpi_ec_poll_write()
    acpi_ec_poll_query()
    acpi_ec_intr_read()
    acpi_ec_intr_write()
    acpi_ec_intr_query()

They consist of very similar code which I unified as:

    acpi_ec_poll_transaction()
    acpi_ec_intr_transaction()

These new functions take as arguments an ACPI EC command, a few bytes
to write to the EC data register and a buffer for a few bytes to read
from the EC data register. The old _read(), _write(), _query() are
just special cases of these functions.

This saves a lot of very similar code. The primary reason for doing
this, however, is that my driver for MSI 270 laptops needs to issue
some non-standard EC commands in a safe way. Due to this I added a new
exported function similar to ec_write()/ec_write() which is called
ec_transaction() and is essentially just a wrapper around
acpi_ec_{poll,intr}_transaction().

Based on 2.6.17.

Please comment and/or apply!

Lennart

Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
---
--- linux-source-2.6.17/drivers/acpi/ec.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17.lennart/drivers/acpi/ec.c	2006-08-10 01:28:22.000000000 +0200
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
@@ -305,78 +305,46 @@ end:
 }
 #endif /* ACPI_FUTURE_USAGE */
 
+static int acpi_ec_transaction(union acpi_ec *ec, u8 command,
+                               const u8 *wdata, unsigned wdata_len,
+                               u8 *rdata, unsigned rdata_len)
+{
+        if (acpi_ec_poll_mode)
+                return acpi_ec_poll_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
+        else
+                return acpi_ec_intr_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
+}
+
 static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
 {
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_read(ec, address, data);
-	else
-		return acpi_ec_intr_read(ec, address, data);
+        int result;
+        u8 d;
+        result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_READ, &address, 1, &d, 1);
+        *data = d;
+        return result;
 }
 static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
 {
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_write(ec, address, data);
-	else
-		return acpi_ec_intr_write(ec, address, data);
+        u8 wdata[2] = { address, data };
+        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, wdata, 2, NULL, 0);
 }
-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data)
+
+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len)
 {
 	acpi_status status = AE_OK;
 	int result = 0;
 	unsigned long flags = 0;
 	u32 glk = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_read");
+	ACPI_FUNCTION_TRACE("acpi_ec_poll_transaction");
 
-	if (!ec || !data)
+	if (!ec || !wdata || !wdata_len || (rdata_len && !rdata))
 		return_VALUE(-EINVAL);
 
-	*data = 0;
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
-	}
-
-	spin_lock_irqsave(&ec->poll.lock, flags);
-
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
-
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
-		goto end;
-
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
-			  *data, address));
-
-      end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
-
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
-
-	return_VALUE(result);
-}
-
-static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data)
-{
-	int result = 0;
-	acpi_status status = AE_OK;
-	unsigned long flags = 0;
-	u32 glk = 0;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_write");
-
-	if (!ec)
-		return_VALUE(-EINVAL);
+        if (rdata)
+                memset(rdata, 0, rdata_len);
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
@@ -386,25 +354,35 @@ static int acpi_ec_poll_write(union acpi
 
 	spin_lock_irqsave(&ec->poll.lock, flags);
 
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
+	acpi_hw_low_level_write(8, command, &ec->common.command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
 	if (result)
 		goto end;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
-			  data, address));
+        while (wdata_len > 0) {
 
+                acpi_hw_low_level_write(8, *(wdata++), &ec->common.data_addr);
+                
+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+                if (result)
+                        goto end;
+                
+                wdata_len--;
+        }
+
+        while (rdata_len > 0) {
+                u32 d;
+                
+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+                if (result)
+                        goto end;
+
+                acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
+                *(rdata++) = (u8) d;
+                
+                rdata_len--;
+        }
+        
       end:
 	spin_unlock_irqrestore(&ec->poll.lock, flags);
 
@@ -414,17 +392,20 @@ static int acpi_ec_poll_write(union acpi
 	return_VALUE(result);
 }
 
-static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len)
 {
 	int status = 0;
 	u32 glk;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_read");
+	ACPI_FUNCTION_TRACE("acpi_ec_intr_transaction");
 
-	if (!ec || !data)
+	if (!ec || !wdata || !wdata_len || (rdata_len && !rdata))
 		return_VALUE(-EINVAL);
 
-	*data = 0;
+        if (rdata)
+                memset(rdata, 0, rdata_len);
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
@@ -440,22 +421,39 @@ static int acpi_ec_intr_read(union acpi_
 		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
 		goto end;
 	}
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
-				&ec->common.command_addr);
+        
+	acpi_hw_low_level_write(8, command, &ec->common.command_addr);
 	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
 	if (status) {
 		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
+                goto end;
 	}
 
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "read EC, OB not full\n");
-		goto end;
-	}
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
-			  *data, address));
+        while (wdata_len > 0) {
+                
+                acpi_hw_low_level_write(8, *(wdata++), &ec->common.data_addr);
+
+                status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+                if (status) {
+                        printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
+                        goto end;
+                }
+                
+                wdata_len--;
+        }
+
+        while (rdata_len > 0) {
+                u32 d;
+                
+                status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+                if (status) {
+                        printk(KERN_DEBUG PREFIX "read EC, OB not full\n");
+                        goto end;
+                }
+                acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
+                *(rdata++) = (u8) d;
+                rdata_len--;
+        }
 
       end:
 	up(&ec->intr.sem);
@@ -466,55 +464,6 @@ static int acpi_ec_intr_read(union acpi_
 	return_VALUE(status);
 }
 
-static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data)
-{
-	int status = 0;
-	u32 glk;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_write");
-
-	if (!ec)
-		return_VALUE(-EINVAL);
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
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
-
-	acpi_hw_low_level_write(8, data, &ec->common.data_addr);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
-			  data, address));
-
-	up(&ec->intr.sem);
-
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
-
-	return_VALUE(status);
-}
-
 /*
  * Externally callable EC access functions. For now, assume 1 EC only
  */
@@ -557,106 +506,41 @@ int ec_write(u8 addr, u8 val)
 
 EXPORT_SYMBOL(ec_write);
 
-static int acpi_ec_query(union acpi_ec *ec, u32 * data)
-{
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_query(ec, data);
-	else
-		return acpi_ec_intr_query(ec, data);
-}
-static int acpi_ec_poll_query(union acpi_ec *ec, u32 * data)
+int ec_transaction(u8 command,
+                   const u8 *wdata, unsigned wdata_len,
+                   u8 *rdata, unsigned rdata_len)
 {
-	int result = 0;
-	acpi_status status = AE_OK;
-	unsigned long flags = 0;
-	u32 glk = 0;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_query");
-
-	if (!ec || !data)
-		return_VALUE(-EINVAL);
-
-	*data = 0;
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
-	}
-
-	/*
-	 * Query the EC to find out which _Qxx method we need to evaluate.
-	 * Note that successful completion of the query causes the ACPI_EC_SCI
-	 * bit to be cleared (and thus clearing the interrupt source).
-	 */
-	spin_lock_irqsave(&ec->poll.lock, flags);
-
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
-		goto end;
-
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	if (!*data)
-		result = -ENODATA;
+	union acpi_ec *ec;
 
-      end:
-	spin_unlock_irqrestore(&ec->poll.lock, flags);
+	if (!first_ec)
+		return -ENODEV;
 
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
+	ec = acpi_driver_data(first_ec);
 
-	return_VALUE(result);
+	return acpi_ec_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 }
-static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data)
-{
-	int status = 0;
-	u32 glk;
-
-	ACPI_FUNCTION_TRACE("acpi_ec_query");
 
-	if (!ec || !data)
-		return_VALUE(-EINVAL);
-	*data = 0;
+EXPORT_SYMBOL(ec_transaction);
 
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
-	}
-
-	down(&ec->intr.sem);
-
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "query EC, IB not empty\n");
-		goto end;
-	}
+static int acpi_ec_query(union acpi_ec *ec, u32 * data)
+{
+        int result;
+        u8 d;
+        
 	/*
 	 * Query the EC to find out which _Qxx method we need to evaluate.
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
-				&ec->common.command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "query EC, OB not full\n");
-		goto end;
-	}
 
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	if (!*data)
-		status = -ENODATA;
+        if ((result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1)))
+                return_VALUE(result);
 
-      end:
-	up(&ec->intr.sem);
+        if (!d)
+		return_VALUE(-ENODATA);
 
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
-
-	return_VALUE(status);
+        *data = d;
+        return_VALUE(0);
 }
 
 /* --------------------------------------------------------------------------
--- linux-source-2.6.17/include/linux/acpi.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17.lennart/include/linux/acpi.h	2006-08-08 17:45:24.000000000 +0200
@@ -486,6 +486,9 @@ void acpi_pci_unregister_driver(struct a
 
 extern int ec_read(u8 addr, u8 *val);
 extern int ec_write(u8 addr, u8 val);
+extern int ec_transaction(u8 command,
+                          const u8 *wdata, unsigned wdata_len,
+                          u8 *rdata, unsigned rdata_len);
 
 #endif /*CONFIG_ACPI_EC*/
 
