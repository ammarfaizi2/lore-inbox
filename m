Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVCaFsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVCaFsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 00:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVCaFsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 00:48:17 -0500
Received: from digitalimplant.org ([64.62.235.95]:46828 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261800AbVCaFsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 00:48:01 -0500
Date: Wed, 30 Mar 2005 21:47:48 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <200503302201.53487.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.50.0503302146420.20992-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503291055560.1038-100000@ida.rowland.org>
 <Pine.LNX.4.50.0503301814090.20992-100000@monsoon.he.net>
 <200503302201.53487.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Mar 2005, Dmitry Torokhov wrote:

> Will the lock be exported (via helper functions)? I always felt dirty using
> subsys.rwsem because it I think it was supposed to be implementation detail.

Sure, why not? See the attached patch for helpers, exported GPL only of
course.

Thanks,


	Pat

===== drivers/base/core.c 1.97 vs edited =====
--- 1.97/drivers/base/core.c	2005-03-24 19:07:33 -08:00
+++ edited/drivers/base/core.c	2005-03-30 21:20:54 -08:00
@@ -196,6 +196,33 @@


 /**
+ *	device_lock - lock device by taking its semaphore
+ *	@dev:	Device to lock
+ */
+
+void device_lock(struct device * dev)
+{
+	if (dev)
+		down(&dev->sem);
+}
+
+EXPORT_SYMBOL_GPL(device_lock);
+
+
+/**
+ *	device_unlock - unlock device
+ *	@dev:	Device we're unlocking
+ */
+
+void device_unlock(struct device * dev)
+{
+	if (dev)
+		up(&dev->sem);
+}
+
+EXPORT_SYMBOL_GPL(device_unlock);
+
+/**
  *	device_initialize - init device structure.
  *	@dev:	device.
  *
===== include/linux/device.h 1.147 vs edited =====
--- 1.147/include/linux/device.h	2005-03-24 19:07:33 -08:00
+++ edited/include/linux/device.h	2005-03-30 21:17:28 -08:00
@@ -325,6 +325,9 @@
 extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));

+extern void device_lock(struct device * dev);
+extern void device_unlock(struct device * dev);
+
 /*
  * Manual binding of a device to driver. See drivers/base/bus.c
  * for information on use.
