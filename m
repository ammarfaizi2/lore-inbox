Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263604AbUDYVyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263604AbUDYVyF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 17:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUDYVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 17:54:05 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:29793 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263604AbUDYVx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 17:53:57 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Sun, 25 Apr 2004 16:53:53 -0500
User-Agent: KMail/1.6.1
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <1082751264.4294.1.camel@pegasus> <20040423213916.D2896@flint.arm.linux.org.uk>
In-Reply-To: <20040423213916.D2896@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404251653.55385.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 03:39 pm, Russell King wrote:
> On Fri, Apr 23, 2004 at 10:14:24PM +0200, Marcel Holtmann wrote:
> > should we apply the pcmcia_get_sys_device() patch from Dmitry for now to
> > fix the current drivers that need a device for loading the firmware?
> 
> I don't think so - it obtains the struct device for the bridge itself
> which has nothing to do with the card inserted in the slot.
> 

Yes, my bad... I wonder if something like the patch below could be useful
for now (although it created only one device entry even if card has multiple
functions so we really need another device for every function):

===== ss.h 1.27 vs edited =====
--- 1.27/include/pcmcia/ss.h	Sat Sep  6 16:32:55 2003
+++ edited/ss.h	Sun Apr 25 15:10:40 2004
@@ -196,7 +196,6 @@
  	/* deprecated */
 	unsigned int			sock;		/* socket number */
 
-
 	/* socket capabilities */
 	u_int				features;
 	u_int				irq_mask;
@@ -232,6 +231,7 @@
 
 	/* socket device */
 	struct class_device		dev;
+	struct device			*card_dev;
 	void				*driver_data;	/* data internal to the socket driver */
 
 };
===== cs.c 1.78 vs edited =====
--- 1.78/drivers/pcmcia/cs.c	Mon Apr 19 03:12:13 2004
+++ edited/cs.c	Sun Apr 25 15:14:36 2004
@@ -60,6 +60,7 @@
 #include <pcmcia/bulkmem.h>
 #include <pcmcia/cistpl.h>
 #include <pcmcia/cisreg.h>
+#include <pcmcia/ds.h>
 #include "cs_internal.h"
 
 #ifdef CONFIG_PCI
@@ -324,6 +325,40 @@
 }
 EXPORT_SYMBOL(pcmcia_get_socket_by_nr);
 
+static void release_card_device(struct device *dev)
+{
+	kfree(dev);
+}
+
+static void register_card_device(struct pcmcia_socket *skt)
+{
+	struct device *dev;
+
+	WARN_ON(skt->card_dev);
+
+	skt->card_dev = dev = kmalloc(sizeof(struct device), GFP_KERNEL);
+	if (dev) {
+
+		memset(dev, 0, sizeof(struct device));
+
+		dev->parent = skt->dev.dev;
+		dev->driver = NULL;
+		dev->bus = &pcmcia_bus_type;
+		dev->release = &release_card_device;
+
+		snprintf(dev->bus_id, sizeof(dev->bus_id), "pccard%d", skt->sock);
+
+		device_register(dev);
+	}
+}
+
+static void unregister_card_device(struct pcmcia_socket *skt)
+{
+	if (skt->card_dev) {
+		device_unregister(skt->card_dev);
+		skt->card_dev = NULL;
+	}
+}
 
 /*======================================================================
 
@@ -574,8 +609,11 @@
 #endif
 		cs_dbg(skt, 4, "insert done\n");
 
+		register_card_device(skt);
+
 		send_event(skt, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
 	} else {
+		unregister_card_device(skt);
 		socket_shutdown(skt);
 		cs_socket_put(skt);
 	}
@@ -596,6 +634,7 @@
 	return CS_SUCCESS;
 }
 
+
 /*
  * Resume a socket.  If a card is present, verify its CIS against
  * our cached copy.  If they are different, the card has been
@@ -620,11 +659,14 @@
 		if (verify_cis_cache(skt) != 0) {
 			socket_remove_drivers(skt);
 			destroy_cis_cache(skt);
+			unregister_card_device(skt);
+			register_card_device(skt);
 			send_event(skt, CS_EVENT_CARD_INSERTION, CS_EVENT_PRI_LOW);
 		} else {
 			send_event(skt, CS_EVENT_PM_RESUME, CS_EVENT_PRI_LOW);
 		}
 	} else {
+		unregister_card_device(skt);
 		socket_shutdown(skt);
 		cs_socket_put(skt);
 	}
@@ -636,6 +678,7 @@
 
 static void socket_remove(struct pcmcia_socket *skt)
 {
+	unregister_card_device(skt);
 	socket_shutdown(skt);
 	cs_socket_put(skt);
 }
