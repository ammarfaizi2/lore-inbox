Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbUJ0XHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbUJ0XHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUJ0XEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:04:54 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:33509 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262726AbUJ0XCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 19:02:30 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: Fw: Re: 2.6.10-rc1-mm1
Date: Wed, 27 Oct 2004 17:02:17 -0600
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
References: <20041027022059.0341cc3e.akpm@osdl.org>
In-Reply-To: <20041027022059.0341cc3e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5jCgBURT1WICB+i"
Message-Id: <200410271702.17086.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5jCgBURT1WICB+i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > name=hpet node=c03ee9a0 acpi_bus_drivers.prev=c03ea6a0
> > name=i8042 node=c03eeda0 acpi_bus_drivers.prev=c03ee9a0
> > name=floppy node=c03f24c0 acpi_bus_drivers.prev=c03ee9a0
> > 
> > Note acpi_bus_drivers.prev for floppy was not set to c03eeda0, which you 
> > would normally expect?

The i8042 driver unregisters if it doesn't fine hardware, so the
above looks OK to me.  You might add similar debug to the
acpi_bus_unregister_driver() path just to be sure.

The problem is definitely something to do with the acpi driver
list maintenance, so I'm interested in all your debug output.

I did find a couple places that unregister the driver even when
acpi_bus_register_driver() fails, which could cause this.  But I
really doubt that this is the problem, because the only error
returns there are for "acpi_disabled" and "!driver".  Patch is
attached anyway if you want to try it.

> ah.  the acpi floppy scanning code seems to be misinterpreting the
> acpi_bus_register_driver() return value, so if it returns zero we think
> that the driver was registered, only it wasn't.  floppy_init() then
> proceeds to unregister a not-registered driver.  I think.  Does this help?

I don't think so.  acpi_bus_register_driver() returns <0 for error
(driver not registered), or >=0 if it was registered.  The count is
the number of devices found.  So I think the floppy code is OK.

> Bjorn, do I remember hearing that we can drop all that code anyway?  That
> it'll be done in another way?

There's talk about making PNP smart enough to use info from ACPI.
But that doesn't seem to be cooked yet, and floppy doesn't use PNP
yet in any case.

--Boundary-00=_5jCgBURT1WICB+i
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diffs"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diffs"

--- 2.6.10-rc1-mm1/drivers/acpi/asus_acpi.c.orig	2004-10-27 12:41:07.642080571 -0600
+++ 2.6.10-rc1-mm1/drivers/acpi/asus_acpi.c	2004-10-27 12:41:48.714345693 -0600
@@ -1213,7 +1213,8 @@
 
 	result = acpi_bus_register_driver(&asus_hotk_driver);
 	if (result < 1) {
-		acpi_bus_unregister_driver(&asus_hotk_driver);
+		if (result >= 0)
+			acpi_bus_unregister_driver(&asus_hotk_driver);
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
 		return -ENODEV;
 	}
--- 2.6.10-rc1-mm1/drivers/acpi/thinkpad_acpi.c.orig	2004-10-27 12:42:14.422353190 -0600
+++ 2.6.10-rc1-mm1/drivers/acpi/thinkpad_acpi.c	2004-10-27 12:43:40.715320883 -0600
@@ -247,8 +247,11 @@
 		return -ENODEV;
 
 	result = acpi_bus_register_driver(&acpi_thinkpad_driver);
-	if (result != 1)
+	if (result != 1) {
+		if (result >= 0)
+			acpi_bus_unregister_driver(&acpi_thinkpad_driver);
 		return -ENODEV;
+	}
 
 	printk(KERN_INFO LOGPREFIX "ACPI IBM Thinkpad Fn+Fx key driver version %s\n", DRIVER_VERSION);
 

--Boundary-00=_5jCgBURT1WICB+i--
