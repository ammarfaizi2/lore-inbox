Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbUJ0JYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUJ0JYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUJ0JXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:23:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:55694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262345AbUJ0JWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:22:38 -0400
Date: Wed, 27 Oct 2004 02:20:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.10-rc1-mm1
Message-Id: <20041027022031.1567fe98.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0410270409370.8390-100000@thoron.boston.redhat.com>
References: <20041026233307.53f37a6c.akpm@osdl.org>
	<Xine.LNX.4.44.0410270409370.8390-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> On Tue, 26 Oct 2004, Andrew Morton wrote:
> 
> > My guess would be that you died here:
> > 
> > 	list_add_tail(&driver->node, &acpi_bus_drivers);
> > 
> > in acpi_bus_register_driver().  Which means that some _other_ acpi driver
> > structure on that list is scrogged.  Perhaps it was marked __init or
> > something.
> > 
> > Can you debug it a bit?  Maybe print the addresses and names of the drivers
> > as they get registered in acpi_bus_register_driver() and also print out
> > acpi_bus_drivers.prev.  If we can get the name of the offending driver
> > we'll be able to find the bug.
> 
> Interestingly, the debug printks are not showing up in
> acpi_bus_register_driver() before the oops, and they should be if that's
> where it's happening.  Compiling with debug info makes the oops go away.
> 
> Here's some debugging of the last few drivers to be registered before the 
> oops is seen:
> 
> name=hpet node=c03ee9a0 acpi_bus_drivers.prev=c03ea6a0
> name=i8042 node=c03eeda0 acpi_bus_drivers.prev=c03ee9a0
> name=floppy node=c03f24c0 acpi_bus_drivers.prev=c03ee9a0
> 
> 
> Note acpi_bus_drivers.prev for floppy was not set to c03eeda0, which you 
> would normally expect?

Not too sure what I'm looking at there.

ah.  the acpi floppy scanning code seems to be misinterpreting the
acpi_bus_register_driver() return value, so if it returns zero we think
that the driver was registered, only it wasn't.  floppy_init() then
proceeds to unregister a not-registered driver.  I think.  Does this help?

--- 25/drivers/block/floppy.c~add-acpi-based-floppy-controller-enumeration-fix-fix	2004-10-27 02:14:33.567295256 -0700
+++ 25-akpm/drivers/block/floppy.c	2004-10-27 02:15:13.415237448 -0700
@@ -4379,7 +4379,7 @@ static int acpi_floppy_init(void)
 		return -ENODEV;
 	}
 	err = acpi_bus_register_driver(&acpi_floppy_driver);
-	if (err >= 0)
+	if (err > 0)
 		acpi_floppy_registered = 1;
 	return err;
 }
@@ -4401,7 +4401,7 @@ int __init floppy_init(void)
 	int i, unit, drive;
 	int err, dr;
 
-	if (acpi_floppy_init() == 0) {
+	if (acpi_floppy_init() <= 0) {
 		err = -ENODEV;
 		goto out_put_acpi;
 	}
_

If so, I wonder why acpi_bus_register_driver() is returning zero.

Bjorn, do I remember hearing that we can drop all that code anyway?  That
it'll be done in another way?

