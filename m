Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318376AbSGRVNc>; Thu, 18 Jul 2002 17:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318377AbSGRVNc>; Thu, 18 Jul 2002 17:13:32 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:20357 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318376AbSGRVN2>; Thu, 18 Jul 2002 17:13:28 -0400
Date: Thu, 18 Jul 2002 23:15:09 +0200
From: Dominik Brodowski <devel@brodo.de>
To: davej@suse.de, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] resolve ACPI oops on boot
Message-ID: <20020718231509.A539@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An u8 was casted into an u32, then all 32 bits were set to zero, this
causing another variable - in my case, processor flags - to be corrupted. 

Dominik

--- linux/drivers/acpi-original/ec.c	Fri Jul 12 22:43:11 2002
+++ linux/drivers/acpi/ec.c	Fri Jul 12 23:28:14 2002
@@ -134,7 +134,7 @@
 acpi_ec_read (
 	struct acpi_ec		*ec,
 	u8			address,
-	u8			*data)
+	u32			*data)
 {
 	acpi_status		status = AE_OK;
 	int			result = 0;
@@ -167,7 +167,7 @@
 		goto end;
 
 
-	acpi_hw_low_level_read(8, (u32*) data, &ec->data_addr, 0);
+	acpi_hw_low_level_read(8, data, &ec->data_addr, 0);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
 		*data, address));
@@ -237,7 +237,7 @@
 static int
 acpi_ec_query (
 	struct acpi_ec		*ec,
-	u8			*data)
+	u32			*data)
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
@@ -269,7 +269,7 @@
 	if (result)
 		goto end;
 	
-	acpi_hw_low_level_read(8, (u32*) data, &ec->data_addr, 0);
+	acpi_hw_low_level_read(8, data, &ec->data_addr, 0);
 	if (!*data)
 		result = -ENODATA;
 
@@ -328,7 +328,7 @@
 {
 	acpi_status		status = AE_OK;
 	struct acpi_ec		*ec = (struct acpi_ec *) data;
-	u8			value = 0;
+	u32			value = 0;
 	unsigned long		flags = 0;
 	struct acpi_ec_query_data *query_data = NULL;
 
@@ -336,7 +336,7 @@
 		return;
 
 	spin_lock_irqsave(&ec->lock, flags);
-	acpi_hw_low_level_read(8, (u32*) &value, &ec->command_addr, 0);
+	acpi_hw_low_level_read(8, &value, &ec->command_addr, 0);
 	spin_unlock_irqrestore(&ec->lock, flags);
 
 	/* TBD: Implement asynch events!
@@ -398,6 +398,7 @@
 {
 	int			result = 0;
 	struct acpi_ec		*ec = NULL;
+	u32          		tmp = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_space_handler");
 
@@ -408,7 +409,8 @@
 
 	switch (function) {
 	case ACPI_READ:
-		result = acpi_ec_read(ec, (u8) address, (u8*) value);
+		result = acpi_ec_read(ec, (u8) address, &tmp);
+		*value = (acpi_integer) tmp;
 		break;
 	case ACPI_WRITE:
 		result = acpi_ec_write(ec, (u8) address, (u8) *value);

