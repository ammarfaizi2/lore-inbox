Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVAYMyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVAYMyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVAYMyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:54:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261924AbVAYMxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:53:31 -0500
Date: Tue, 25 Jan 2005 12:53:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, johnpol@2ka.mipt.ru, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125125323.GA19055@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, johnpol@2ka.mipt.ru, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Review of the superio subsystem sneaked in through bk-i2c.patch:


diff -Nru a/drivers/superio/Kconfig b/drivers/superio/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/superio/Kconfig	2005-01-23 22:34:15 -08:00
@@ -0,0 +1,56 @@
+menu "SuperIO subsystem support"
+
+config SC_SUPERIO
+	tristate "SuperIO subsystem support"
+	depends on CONNECTOR
+	help
+	  SuperIO subsystem support.
+	
+	  This support is also available as a module.  If so, the module
+          will be called superio.ko.

This doesn't mention what "SuperIO" is at all.  Also please skip the .ko
postfix for the module name as the intree Kconfigs do.  The boilerplate has
changed to:

  To compile this driver as a module, choose M here: the
  module will be called <foo>.

diff -Nru a/drivers/superio/Makefile b/drivers/superio/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/superio/Makefile	2005-01-23 22:34:15 -08:00
@@ -0,0 +1,11 @@
+#
+# Makefile for the SuperIO subsystem.
+#

Superflous.

+
+obj-$(CONFIG_SC_SUPERIO)	+= superio.o
+obj-$(CONFIG_SC_GPIO)		+= sc_gpio.o
+obj-$(CONFIG_SC_ACB)		+= sc_acb.o
+obj-$(CONFIG_SC_PC8736X)	+= pc8736x.o
+obj-$(CONFIG_SC_SCX200)		+= scx200.o
+
+superio-objs		:= sc.o chain.o sc_conn.o

please use superio-y += so new conditional objects can be added more easily.

diff -Nru a/drivers/superio/chain.c b/drivers/superio/chain.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/superio/chain.c	2005-01-23 22:34:15 -08:00
@@ -0,0 +1,52 @@
+/*
+ * 	chain.c

superfluos, the file name is obvious.  (Dito for all other files)

+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+
+#include <linux/list.h>
+#include <linux/slab.h>

always include <asm/*> after <linux/*> headers.  Please use <linux/types.h>
istead of <asm/types.h> always.

(comment applies to later files aswell)

+#include "chain.h"
+
+struct dev_chain *chain_alloc(void *ptr)
+{
+	struct dev_chain *ch;
+
+	ch = kmalloc(sizeof(struct dev_chain), GFP_ATOMIC);
+	if (!ch) {
+		printk(KERN_ERR "Failed to allocate new chain for %p.\n", ptr);
+		return NULL;
+	}
+
+	memset(ch, 0, sizeof(struct dev_chain));
+
+	ch->ptr = ptr;
+
+	return ch;
+}
+
+void chain_free(struct dev_chain *ch)
+{
+	memset(ch, 0, sizeof(struct dev_chain));
+	kfree(ch);

The memset completely defeats slab redzoning to catch bugs, don't
do that.

Also what's the reason you can't simply put the list_head into struct
logical_dev?

+static void pc8736x_fini(void)
+{
+	sc_del_sc_dev(&pc8736x_dev);
+
+	while (atomic_read(&pc8736x_dev.refcnt)) {
+		printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
+				pc8736x_dev.name, atomic_read(&pc8736x_dev.refcnt));
+		
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+			
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+}

And who gurantess this won't deadlock?  Please use a dynamically allocated
driver model device and it's refcounting, thanks.

+int sc_add_sc_dev(struct sc_dev *__sdev)

btw, what's the reason you use those ugly __ names for local variables all over?

+	while (atomic_read(&__sdev->refcnt)) {
+		printk(KERN_INFO "Waiting SuperIO chip %s to become free: refcnt=%d.\n",
+		       __sdev->name, atomic_read(&__sdev->refcnt));
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ);
+			
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+}

Again as above.

+static void sc_deactivate_logical(struct sc_dev *dev, struct logical_dev *ldev)
+{
+	printk(KERN_INFO "Deactivating logical device %s in SuperIO chip %s... ",
+	       ldev->name, dev->name);
+	
+	if (ldev->irq)
+	{
+		free_irq(ldev->irq, ldev);
+		ldev->irq = 0;
+	}

CodingStyle: if (ldev->irq) {  (also in various other places)

+static int __devinit sc_init(void)
+{
+	printk(KERN_INFO "SuperIO driver is starting...\n");
+
+	return sc_register_callback();
+}
+
+static void __devexit sc_fini(void)
+{
+	sc_unregister_callback();
+	printk(KERN_INFO "SuperIO driver finished.\n");
+}

quite noise.  Please only print messages when you find an actual
device and not on unloading at all.

+	INIT_LIST_HEAD(&ldev_acb.ldev_entry);
+	spin_lock_init(&ldev_acb.lock);

these two can be initialized at compile time.

+#include "../superio/sc.h"
+#include "../superio/sc_gpio.h"

just include them normalluy, ok?

+static int scx200_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	private_base = pci_resource_start(pdev, 0);
+	printk(KERN_INFO "%s: GPIO base 0x%lx.\n", pci_name(pdev), private_base);
+
+	if (!request_region
+	    (private_base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO")) {
+		printk(KERN_ERR "%s: failed to request %d bytes I/O region for GPIOs.\n",
+		       pci_name(pdev), SCx200_GPIO_SIZE);
+		return -EBUSY;
+	}
+
+	pci_set_drvdata(pdev, &private_base);
+	pci_enable_device(pdev);

pci_enable_device needs to be done first, and it returns and error that
should be handled.

+	pci_unregister_driver(&scx200_pci_driver);
+	if (private_base)
+		release_region(private_base, SCx200_GPIO_SIZE);

this must happen in the ->remove callback.

diff -Nru a/drivers/superio/scx200.h b/drivers/superio/scx200.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/superio/scx200.h	2005-01-23 22:34:15 -08:00
@@ -0,0 +1,28 @@
+/*
+ * 	scx200.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __SCX200_H
+#define __SCX200_H
+
+#define SCx200_GPIO_SIZE 	0x2c
+
+#endif /* __SCX200_H */

Yeah, right - a 30 line header for a single define that's used in a
single source file..

Also your locking is broken.  sdev_lock sometimes nests outside
sdev->lock and sometimes inside.  Similarly dev->chain_lock nests
inside dev->lock sometimes and sometimes outside.  You really need
a locking hiearchy document and the lockign should probably be
simplified a lot.
