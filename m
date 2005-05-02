Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVEBCY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEBCY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVEBCYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:24:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20752 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261621AbVEBBqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:21 -0400
Date: Mon, 2 May 2005 03:46:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ambx1@neo.rr.com
Cc: perex@suse.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pnp/: possible cleanups
Message-ID: <20050502014620.GJ3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global function:
  - core.c: pnp_remove_device
- remove the following unneeded EXPORT_SYMBOL's:
  - card.c: pnp_add_card
  - card.c: pnp_remove_card
  - card.c: pnp_add_card_device
  - card.c: pnp_remove_card_device
  - card.c: pnp_add_card_id
  - core.c: pnp_register_protocol
  - core.c: pnp_unregister_protocol
  - core.c: pnp_add_device
  - core.c: pnp_remove_device
  - pnpacpi/core.c: pnpacpi_protocol
  - driver.c: pnp_add_id
  - isapnp/core.c: isapnp_read_byte
  - manager.c: pnp_auto_config_dev
  - resource.c: pnp_register_dependent_option
  - resource.c: pnp_register_independent_option
  - resource.c: pnp_register_irq_resource
  - resource.c: pnp_register_dma_resource
  - resource.c: pnp_register_port_resource
  - resource.c: pnp_register_mem_resource

Note that this patch #if 0's exactly one functions and removes no
functions. Most it does is the removal of EXPORT_SYMBOL's, so if any
modular code will use any of them, re-adding will be trivial.

Modular ISAPnP might be interesting in some cases, but this is more
legacy code. If someone would work on it to sort all the issues out
(starting with the point that most users of __ISAPNP__ will have to be
fixed) re-adding the required EXPORT_SYMBOL's won't be hard for him.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Mar 2005
- 27 Feb 2005

 drivers/pnp/card.c         |    7 +------
 drivers/pnp/core.c         |    7 ++-----
 drivers/pnp/driver.c       |    1 -
 drivers/pnp/isapnp/core.c  |    1 -
 drivers/pnp/manager.c      |    1 -
 drivers/pnp/pnpacpi/core.c |    5 ++---
 drivers/pnp/resource.c     |    8 --------
 include/linux/pnp.h        |    2 --
 8 files changed, 5 insertions(+), 27 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/pnp/card.c.old	2005-02-26 15:54:16.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pnp/card.c	2005-02-26 16:16:07.000000000 +0100
@@ -19,7 +19,7 @@
 #include "base.h"
 
 LIST_HEAD(pnp_cards);
-LIST_HEAD(pnp_card_drivers);
+static LIST_HEAD(pnp_card_drivers);
 
 
 static const struct pnp_card_device_id * match_card(struct pnp_card_driver * drv, struct pnp_card * card)
@@ -380,11 +380,6 @@
 	pnp_unregister_driver(&drv->link);
 }
 
-EXPORT_SYMBOL(pnp_add_card);
-EXPORT_SYMBOL(pnp_remove_card);
-EXPORT_SYMBOL(pnp_add_card_device);
-EXPORT_SYMBOL(pnp_remove_card_device);
-EXPORT_SYMBOL(pnp_add_card_id);
 EXPORT_SYMBOL(pnp_request_card_device);
 EXPORT_SYMBOL(pnp_release_card_device);
 EXPORT_SYMBOL(pnp_register_card_driver);
--- linux-2.6.11-rc4-mm1-full/include/linux/pnp.h.old	2005-02-26 15:54:39.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/linux/pnp.h	2005-02-26 15:54:59.000000000 +0100
@@ -353,7 +353,6 @@
 int pnp_register_protocol(struct pnp_protocol *protocol);
 void pnp_unregister_protocol(struct pnp_protocol *protocol);
 int pnp_add_device(struct pnp_dev *dev);
-void pnp_remove_device(struct pnp_dev *dev);
 int pnp_device_attach(struct pnp_dev *pnp_dev);
 void pnp_device_detach(struct pnp_dev *pnp_dev);
 extern struct list_head pnp_global;
@@ -399,7 +398,6 @@
 static inline void pnp_unregister_protocol(struct pnp_protocol *protocol) { }
 static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
-static inline void pnp_remove_device(struct pnp_dev *dev) { }
 static inline int pnp_device_attach(struct pnp_dev *pnp_dev) { return -ENODEV; }
 static inline void pnp_device_detach(struct pnp_dev *pnp_dev) { ; }
 
--- linux-2.6.11-rc4-mm1-full/drivers/pnp/core.c.old	2005-02-26 15:55:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pnp/core.c	2005-02-26 16:48:31.000000000 +0100
@@ -158,13 +158,14 @@
  *
  * this function will free all mem used by dev
  */
-
+#if 0
 void pnp_remove_device(struct pnp_dev *dev)
 {
 	if (!dev || dev->card)
 		return;
 	__pnp_remove_device(dev);
 }
+#endif  /*  0  */
 
 static int __init pnp_init(void)
 {
@@ -174,7 +175,3 @@
 
 subsys_initcall(pnp_init);
 
-EXPORT_SYMBOL(pnp_register_protocol);
-EXPORT_SYMBOL(pnp_unregister_protocol);
-EXPORT_SYMBOL(pnp_add_device);
-EXPORT_SYMBOL(pnp_remove_device);
--- linux-2.6.11-rc4-mm1-full/drivers/pnp/pnpacpi/core.c.old	2005-02-26 15:57:01.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pnp/pnpacpi/core.c	2005-02-26 15:57:26.000000000 +0100
@@ -124,7 +124,7 @@
 	return ACPI_FAILURE(status) ? -ENODEV : 0;
 }
 
-struct pnp_protocol pnpacpi_protocol = {
+static struct pnp_protocol pnpacpi_protocol = {
 	.name	= "Plug and Play ACPI",
 	.get	= pnpacpi_get_resources,
 	.set	= pnpacpi_set_resources,
@@ -242,7 +242,7 @@
 }
 
 int pnpacpi_disabled __initdata;
-int __init pnpacpi_init(void)
+static int __init pnpacpi_init(void)
 {
 	if (acpi_disabled || pnpacpi_disabled) {
 		pnp_info("PnP ACPI: disabled");
@@ -266,4 +266,3 @@
 }
 __setup("pnpacpi=", pnpacpi_setup);
 
-EXPORT_SYMBOL(pnpacpi_protocol);
--- linux-2.6.11-rc4-mm1-full/drivers/pnp/driver.c.old	2005-02-26 16:09:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pnp/driver.c	2005-02-26 16:09:52.000000000 +0100
@@ -217,6 +217,5 @@
 
 EXPORT_SYMBOL(pnp_register_driver);
 EXPORT_SYMBOL(pnp_unregister_driver);
-EXPORT_SYMBOL(pnp_add_id);
 EXPORT_SYMBOL(pnp_device_attach);
 EXPORT_SYMBOL(pnp_device_detach);
--- linux-2.6.11-rc4-mm1-full/drivers/pnp/isapnp/core.c.old	2005-02-26 16:11:16.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pnp/isapnp/core.c	2005-02-26 16:11:39.000000000 +0100
@@ -952,7 +952,6 @@
 EXPORT_SYMBOL(isapnp_present);
 EXPORT_SYMBOL(isapnp_cfg_begin);
 EXPORT_SYMBOL(isapnp_cfg_end);
-EXPORT_SYMBOL(isapnp_read_byte);
 EXPORT_SYMBOL(isapnp_write_byte);
 
 static int isapnp_read_resources(struct pnp_dev *dev, struct pnp_resource_table *res)
--- linux-2.6.11-rc4-mm1-full/drivers/pnp/manager.c.old	2005-02-26 16:11:47.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pnp/manager.c	2005-02-26 16:12:11.000000000 +0100
@@ -563,7 +563,6 @@
 
 
 EXPORT_SYMBOL(pnp_manual_config_dev);
-EXPORT_SYMBOL(pnp_auto_config_dev);
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
 EXPORT_SYMBOL(pnp_resource_change);
--- linux-2.6.11-rc4-mm1-full/drivers/pnp/resource.c.old	2005-02-26 16:12:19.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pnp/resource.c	2005-02-26 16:13:37.000000000 +0100
@@ -478,14 +478,6 @@
 }
 
 
-EXPORT_SYMBOL(pnp_register_dependent_option);
-EXPORT_SYMBOL(pnp_register_independent_option);
-EXPORT_SYMBOL(pnp_register_irq_resource);
-EXPORT_SYMBOL(pnp_register_dma_resource);
-EXPORT_SYMBOL(pnp_register_port_resource);
-EXPORT_SYMBOL(pnp_register_mem_resource);
-
-
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
 
 static int __init pnp_setup_reserve_irq(char *str)

