Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWHNPZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWHNPZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWHNPZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:25:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:45368 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750803AbWHNPZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:25:47 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,122,1154934000"; 
   d="scan'208"; a="108067942:sNHT774783926"
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/2] acpi,backlight: MSI S270 laptop support - ec_transaction()
Date: Mon, 14 Aug 2006 23:25:00 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1120727@pdsmsx411.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] acpi,backlight: MSI S270 laptop support - ec_transaction()
Thread-Index: Aca8GRdThf0gEVRrT8q5JL7hBu+cPwDloxwQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Lennart Poettering" <mzxreary@0pointer.de>,
       "Brown, Len" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 14 Aug 2006 15:25:10.0493 (UTC) FILETIME=[D4B008D0:01C6BFB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First of all, thanks for your patch.
 
>+static int acpi_ec_transaction(union acpi_ec *ec, u8 command,
>+                               const u8 *wdata, unsigned wdata_len,
>+                               u8 *rdata, unsigned rdata_len)

I agree the name: transaction sounds better than read/write, and
can reduce redundant code from separate read, write function.
But, I guess using argument : u8 address will make the patch
looks better.

>+{
>+        if (acpi_ec_poll_mode)
>+                return acpi_ec_poll_transaction(ec, command, 
>wdata, wdata_len, rdata, rdata_len);
>+        else
>+                return acpi_ec_intr_transaction(ec, command, 
>wdata, wdata_len, rdata, rdata_len);
>+}
>+

It would be better to use a function pointer instead of
using if-lese statement which looks not so neat.

> static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
> {
>-	if (acpi_ec_poll_mode)
>-		return acpi_ec_poll_read(ec, address, data);
>-	else
>-		return acpi_ec_intr_read(ec, address, data);
>+        int result;
>+        u8 d;
>+        result = acpi_ec_transaction(ec, 
>ACPI_EC_COMMAND_READ, &address, 1, &d, 1);
>+        *data = d;
>+        return result;
> }

Due to missing argument: address, you have to pass address in
argument: wdata. This kind of code style is prone to error.


> static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
> {
>-	if (acpi_ec_poll_mode)
>-		return acpi_ec_poll_write(ec, address, data);
>-	else
>-		return acpi_ec_intr_write(ec, address, data);
>+        u8 wdata[2] = { address, data };
>+        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, 
>wdata, 2, NULL, 0);
> }

It would be more clear if there is argument : address.

>-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, 
>u32 * data)
>+
>+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
>+                                    const u8 *wdata, unsigned 
>wdata_len,
>+                                    u8 *rdata, unsigned rdata_len)
> {
> 	acpi_status status = AE_OK;
> 	int result = 0;
> 	unsigned long flags = 0;
> 	u32 glk = 0;
> 
>-	ACPI_FUNCTION_TRACE("acpi_ec_read");
>+	ACPI_FUNCTION_TRACE("acpi_ec_poll_transaction");
> 
>-	if (!ec || !data)
>+	if (!ec || !wdata || !wdata_len || (rdata_len && !rdata))
> 		return_VALUE(-EINVAL);


why return -EINVAL if wdata_len == 0?

Thanks
Luming
