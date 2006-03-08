Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbWCHGRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWCHGRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 01:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWCHGRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 01:17:38 -0500
Received: from fmr18.intel.com ([134.134.136.17]:7623 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751440AbWCHGRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 01:17:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Wed, 8 Mar 2006 14:17:31 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B22AA1D@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
thread-index: AcZCAcwxCM1eKOXxTJivlv9ZVtqqkAAc5A8A
From: "Yu, Luming" <luming.yu@intel.com>
To: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2006 06:17:32.0313 (UTC) FILETIME=[FC016890:01C64277]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I just found this:
>>             Device (SVG)
>>                 Device (LCD)
>> It looks too simple to fit video.c.
>
>I'm sorry but I'm confused. Do you mean that I shouldn't try to
>support the brightness using the default video driver (ie: leave it as
>a board specific driver because the board's ACPI implementation for
>video support is insufficient) or did you mean that it will be easy
>and simple to fit in video.c?

I think video.c is NOT a right solution for your problem.

>
>> But it is quite easy to implement in hotkey.c.
>> Because it has dedicated device with HID and ,
>> well-known method name.
>>
>
>I'm confused by hotkey here. I'm not sure how hotkey is involved here.

hotkey.c provide a generic way to register well-known acpi device, and
well-known methods that are mostly related to hotkey. 

>The Atlas board has no  keys physically. It has buttons which are

No differences between buttons and keys to me.

>hooked up using the ASIM HID and that is what I am trying to support
>since those physically exist on the board. Can you help me understand
>how hotkey is involved in this?

You have dedicated ACPI device and method for brightness control.
So hotkey.c is the right place for support Device LCD.

As for Device ASIM, I don't understand this code in your patch,
Care to explain. It looks strange to me.

+static acpi_status acpi_atlas_button_handler(u32 function,
+		      acpi_physical_address address,
+		      u32 bit_width, acpi_integer * value,
+		      void *handler_context, void *region_context)
+{
+	acpi_status status;
+	struct acpi_device *dev;
+
+	dev = (struct acpi_device *) handler_context;
+	if (function == ACPI_WRITE)
+		status = acpi_bus_generate_event(dev, 0x80, address);
+	else {
+		printk(KERN_WARNING "atlas: shrugged on unexpected
function"
+			":function=%x,address=%x,value=%x\n",
+			function, (u32)address, (u32)*value);
+		status = -EINVAL;
+	}
+
+	return status ;
+}
+
+static int atlas_acpi_button_add(struct acpi_device *device)
+{
+
+	/* hookup button handler */
+	return acpi_install_address_space_handler(device->handle,
+				0x81, &acpi_atlas_button_handler,
+				&acpi_atlas_button_setup, device);
+}
+
