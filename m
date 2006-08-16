Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWHPQVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWHPQVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWHPQVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:21:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33429 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932094AbWHPQVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:21:34 -0400
Subject: PATCH: Multiprobe sanitizer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:42:18 +0100
Message-Id: <1155746538.24077.371.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are numerous drivers that can use multithreaded probing but having
some kind of global flag as the way to control this makes migration to
threaded probing hard and since it enables it everywhere and is almost
as likely to cause serious pain as holding a clog dance in a minefield.

If we have a pci_driver multithread_probe flag to inherit you can turn
it on for one driver at a time. 

>From playing so far however I think we need a different model at the
device layer which serializes until the called probe function says "ok
you can start another one now". That would need some kind of flag and
semaphore plus a helper function.

Anyway in the absence of that this is a starting point to usefully play
with this stuff

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/drivers/pci/pci-driver.c linux-2.6.18-rc4-mm1/drivers/pci/pci-driver.c
--- linux.vanilla-2.6.18-rc4-mm1/drivers/pci/pci-driver.c	2006-08-15 15:40:17.000000000 +0100
+++ linux-2.6.18-rc4-mm1/drivers/pci/pci-driver.c	2006-08-15 17:24:44.000000000 +0100
@@ -432,7 +432,11 @@
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.owner = owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
-	drv->driver.multithread_probe = pci_multithread_probe;
+	
+	if(pci_multithread_probe)
+		drv->driver.multithread_probe = pci_multithread_probe;
+	else
+		drv->driver.multithread_probe = drv->multithread_probe;
 
 	spin_lock_init(&drv->dynids.lock);
 	INIT_LIST_HEAD(&drv->dynids.list);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/include/linux/pci.h linux-2.6.18-rc4-mm1/include/linux/pci.h
--- linux.vanilla-2.6.18-rc4-mm1/include/linux/pci.h	2006-08-15 15:40:19.000000000 +0100
+++ linux-2.6.18-rc4-mm1/include/linux/pci.h	2006-08-15 16:37:21.000000000 +0100
@@ -351,6 +351,8 @@
 	struct pci_error_handlers *err_handler;
 	struct device_driver	driver;
 	struct pci_dynids dynids;
+	
+	int multithread_probe;
 };
 
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)

