Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWGLGkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWGLGkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWGLGkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:40:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:30783 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750924AbWGLGkH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:40:07 -0400
X-IronPort-AV: i="4.06,231,1149490800"; 
   d="scan'208"; a="96721904:sNHT15749545"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [PATCH -mm] acpi/scan: handle kset/kobject errors
Date: Wed, 12 Jul 2006 02:40:03 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F31867@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH -mm] acpi/scan: handle kset/kobject errors
Thread-Index: AcaleTxNZAiNRttgRUeHgUSiQR2H/AABJgTg
From: "Brown, Len" <len.brown@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>,
       "lkml" <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Cc: "akpm" <akpm@osdl.org>
X-OriginalArrivalTime: 12 Jul 2006 06:40:05.0817 (UTC) FILETIME=[02CE3A90:01C6A57E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied,
my only nitpick is that in the subject capital "ACPI:" is what we use --
as it is an acronym.

thanks,
-Len 

>-----Original Message-----
>From: Randy.Dunlap [mailto:rdunlap@xenotime.net] 
>Sent: Wednesday, July 12, 2006 2:08 AM
>To: lkml; linux-acpi@vger.kernel.org
>Cc: Brown, Len; akpm
>Subject: [PATCH -mm] acpi/scan: handle kset/kobject errors
>
>From: Randy Dunlap <rdunlap@xenotime.net>
>
>Check and handle kset_register() and kobject_register() init errors.
>
>Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>---
> drivers/acpi/scan.c |   12 ++++++++++--
> 1 files changed, 10 insertions(+), 2 deletions(-)
>
>--- linux-2618-rc1mm1.orig/drivers/acpi/scan.c
>+++ linux-2618-rc1mm1/drivers/acpi/scan.c
>@@ -4,6 +4,7 @@
> 
> #include <linux/module.h>
> #include <linux/init.h>
>+#include <linux/kernel.h>
> #include <linux/acpi.h>
> 
> #include <acpi/acpi_drivers.h>
>@@ -113,6 +114,8 @@ static struct kset acpi_namespace_kset =
> static void acpi_device_register(struct acpi_device *device,
> 				 struct acpi_device *parent)
> {
>+	int err;
>+
> 	/*
> 	 * Linkage
> 	 * -------
>@@ -138,7 +141,10 @@ static void acpi_device_register(struct 
> 		device->kobj.parent = &parent->kobj;
> 	device->kobj.ktype = &ktype_acpi_ns;
> 	device->kobj.kset = &acpi_namespace_kset;
>-	kobject_register(&device->kobj);
>+	err = kobject_register(&device->kobj);
>+	if (err < 0)
>+		printk(KERN_WARNING "%s: kobject_register error: %d\n",
>+			__FUNCTION__, err);
> 	create_sysfs_device_files(device);
> }
> 
>@@ -1450,7 +1456,9 @@ static int __init acpi_scan_init(void)
> 	if (acpi_disabled)
> 		return 0;
> 
>-	kset_register(&acpi_namespace_kset);
>+	result = kset_register(&acpi_namespace_kset);
>+	if (result < 0)
>+		printk(KERN_ERR PREFIX "kset_register error: 
>%d\n", result);
> 
> 	result = bus_register(&acpi_bus_type);
> 	if (result) {
>
>
>---
>
