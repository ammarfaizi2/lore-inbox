Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbUKUQQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUKUQQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUKUPms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:42:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261660AbUKUPgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:36:33 -0500
Date: Sun, 21 Nov 2004 16:36:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some PNP cleanups
Message-ID: <20041121153629.GV2829@stusta.de>
References: <20041113030220.GW2249@stusta.de> <20041116045938.GB29574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116045938.GB29574@neo.rr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 11:59:38PM -0500, Adam Belay wrote:
> On Sat, Nov 13, 2004 at 04:02:20AM +0100, Adrian Bunk wrote:
> > The patch below does the following changes to the PNP code:
> > - remove some unused code
> > - make some needlessly global code static
> > 
> > Please review whether some of this might conflict with pending changes.
> > 
> 
> Hi Adrian,
> 
> I'm not sure about removing some of the stuff in card.c.  It may eventually be
> used with docking stations, and is currently there for completeness.

Will this be used in the forseeable future?
Otherwise, I'd suggest to #if 0 it.

> The reserve resource and pnpbios stuff looks ok.  "pnp_assign_resources" was
> there for some manual control.  It doesn't appear to have been used, so it
> may make sense to remove it.  The patch looks good, but I think I want to keep
> the card.c stuff and "pnp_device_is_pnpbios".

Thanks for your comments.

Below are the parts of my patch you agreed with.

> I appreciate the cleanup.
> 
> Thanks,
> Adam

cu
Adrian


<--  snip  -->



The patch below does the following changes to the PNP code:
- make some needlessly global code static
- remove the EXPORT_SYMBOL(pnp_assign_resources) since this function
  is only used in the file it is defined in


diffstat output:
 drivers/pnp/core.c         |    2 +-
 drivers/pnp/interface.c    |    2 +-
 drivers/pnp/manager.c      |    3 +--
 drivers/pnp/pnpbios/core.c |    4 ++--
 drivers/pnp/resource.c     |   11 +++++------
 include/linux/pnp.h        |    2 --
 6 files changed, 10 insertions(+), 14 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/include/linux/pnp.h.old	2004-11-13 03:19:21.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/pnp.h	2004-11-13 03:25:58.000000000 +0100
@@ -378,7 +369,6 @@
 int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data);
 int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
 void pnp_init_resource_table(struct pnp_resource_table *table);
-int pnp_assign_resources(struct pnp_dev *dev, int depnum);
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
 int pnp_validate_config(struct pnp_dev *dev);
@@ -423,7 +411,6 @@
 static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
 static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
 static inline void pnp_init_resource_table(struct pnp_resource_table *table) { }
-static inline int pnp_assign_resources(struct pnp_dev *dev, int depnum) { return -ENODEV; }
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_validate_config(struct pnp_dev *dev) { return -ENODEV; }
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/core.c.old	2004-11-13 03:20:42.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/core.c	2004-11-13 03:20:53.000000000 +0100
@@ -18,7 +18,7 @@
 #include "base.h"
 
 
-LIST_HEAD(pnp_protocols);
+static LIST_HEAD(pnp_protocols);
 LIST_HEAD(pnp_global);
 spinlock_t pnp_lock = SPIN_LOCK_UNLOCKED;
 
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/interface.c.old	2004-11-13 03:22:00.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/interface.c	2004-11-13 03:22:12.000000000 +0100
@@ -29,7 +29,7 @@
 
 typedef struct pnp_info_buffer pnp_info_buffer_t;
 
-int pnp_printf(pnp_info_buffer_t * buffer, char *fmt,...)
+static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt,...)
 {
 	va_list args;
 	int res;
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/manager.c.old	2004-11-13 03:23:11.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/manager.c	2004-11-13 03:23:27.000000000 +0100
@@ -296,7 +296,7 @@
  *
  * Only set depnum to 0 if the device does not have dependent options.
  */
-int pnp_assign_resources(struct pnp_dev *dev, int depnum)
+static int pnp_assign_resources(struct pnp_dev *dev, int depnum)
 {
 	struct pnp_port *port;
 	struct pnp_mem *mem;
@@ -558,7 +558,6 @@
 }
 
 
-EXPORT_SYMBOL(pnp_assign_resources);
 EXPORT_SYMBOL(pnp_manual_config_dev);
 EXPORT_SYMBOL(pnp_auto_config_dev);
 EXPORT_SYMBOL(pnp_activate_dev);
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/pnpbios/core.c.old	2004-11-13 03:24:47.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/pnpbios/core.c	2004-11-13 03:26:24.000000000 +0100
@@ -453,7 +453,7 @@
 /* PnP BIOS signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
-int __init pnpbios_probe_system(void)
+static int __init pnpbios_probe_system(void)
 {
 	union pnp_bios_install_struct *check;
 	u8 sum;
@@ -529,7 +529,7 @@
 	{ }
 };
 
-int __init pnpbios_init(void)
+static int __init pnpbios_init(void)
 {
 	int ret;
 
--- linux-2.6.10-rc1-mm5-full/drivers/pnp/resource.c.old	2004-11-13 03:27:15.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pnp/resource.c	2004-11-13 03:28:03.000000000 +0100
@@ -21,11 +21,11 @@
 #include <linux/pnp.h>
 #include "base.h"
 
-int pnp_skip_pci_scan;				/* skip PCI resource scanning */
-int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
-int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
-int pnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
-int pnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
+static int pnp_skip_pci_scan;				/* skip PCI resource scanning */
+static int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
+static int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
+static int pnp_reserve_io[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some I/O region */
+static int pnp_reserve_mem[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some memory region */
 
 
 /*

