Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSGUBL3>; Sat, 20 Jul 2002 21:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSGUBL3>; Sat, 20 Jul 2002 21:11:29 -0400
Received: from pcp748332pcs.manass01.va.comcast.net ([68.49.120.123]:28610
	"EHLO pcp748332pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S317619AbSGUBL2>; Sat, 20 Jul 2002 21:11:28 -0400
Date: Sat, 20 Jul 2002 21:14:28 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2[6-7] ACPI oops
Message-ID: <20020721011427.GA27150@bittwiddlers.com>
References: <20020721004530.GA26285@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20020721004530.GA26285@bittwiddlers.com>
User-Agent: Mutt/1.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.58
Reply-To: Matthew Harrell 
	  <mharrell-dated-1027646068.f0de7a@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

: 
: I think its related to ACPI since it comes right after the line
: 
:   ACPI: Embedded Controller [EC0] (gpe 1)
: 
: Everything works fine in 2.5.25 but this started occuring right as I try
: to boot up with 26 and 27.  I had to hand type this so it may have some typos
: in there but hopefully there's enough info to be useful.  Let me know if
: there's anything else I can provide
: 

Okay, I saw a patch on the list (don't remember who) that didn't specify
which kernel version it was for but it was specifically for an ACPI crash.
That fixed it fine so far.  Patch is attached below and sorry I forgot who
it was from

-- 
  Matthew Harrell                          Never underestimate the power of
  Bit Twiddlers, Inc.                       very stupid people in large groups.
  mharrell@bittwiddlers.com     

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi.patch"

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


--opJtzjQTFsWo+cga--
