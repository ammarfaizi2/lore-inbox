Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbTFWEV2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 00:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbTFWEV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 00:21:28 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:18058 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265405AbTFWEVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 00:21:24 -0400
Date: Mon, 23 Jun 2003 00:08:08 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030623000808.GA14945@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
	alsa-devel@alsa-project.org
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622234447.GB3710@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 01:44:47AM +0200, Adrian Bunk wrote:
> On Sun, Jun 22, 2003 at 11:53:14AM -0700, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.5.72 to v2.5.73
> > ============================================
> >...
> > Adam Belay:
> >   o [PNP] Resource Management Cleanups and Updates
> >...
> 
> This patch removed pnp_init_resource_table, but several drivers under 
> sound/isa/ still use it, resulting in compile errors like the following:
> 
> <--  snip  -->
> 
> ...
>   CC      sound/isa/ad1816a/ad1816a.o
> sound/isa/ad1816a/ad1816a.c: In function `snd_card_ad1816a_pnp':
> sound/isa/ad1816a/ad1816a.c:143: warning: implicit declaration of 
> function `pnp_init_resource_table'
> ...
>   LD      .tmp_vmlinux1
> sound/built-in.o(.text+0x349c7): In function `snd_card_ad1816a_pnp':
> : undefined reference to `pnp_init_resource_table'
> sound/built-in.o(.text+0x34ad3): In function `snd_card_ad1816a_pnp':
> : undefined reference to `pnp_init_resource_table'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> cu
> Adrian
> 

The patch below will correct this.

Thanks,
Adam

diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	2003-06-20 21:48:26.000000000 +0000
+++ b/drivers/pnp/interface.c	2003-06-22 23:17:04.000000000 +0000
@@ -275,7 +275,7 @@
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		if (pnp_irq_valid(dev, i)) {
 			pnp_printf(buffer,"irq");
-			pnp_printf(buffer," %ld \n", pnp_irq(dev, i));
+			pnp_printf(buffer," %lx \n", pnp_irq(dev, i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
@@ -323,14 +323,14 @@
 	if (!strnicmp(buf,"auto",4)) {
 		if (dev->active)
 			goto done;
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 		retval = pnp_auto_config_dev(dev);
 		goto done;
 	}
 	if (!strnicmp(buf,"clear",5)) {
 		if (dev->active)
 			goto done;
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 		goto done;
 	}
 	if (!strnicmp(buf,"get",3)) {
@@ -345,7 +345,7 @@
 		if (dev->active)
 			goto done;
 		buf += 3;
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 		down(&pnp_res_mutex);
 		while (1) {
 			while (isspace(*buf))
diff -urN a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	2003-06-20 21:48:26.000000000 +0000
+++ b/drivers/pnp/isapnp/core.c	2003-06-22 23:16:26.000000000 +0000
@@ -458,7 +458,7 @@
 	dev->capabilities |= PNP_READ;
 	dev->capabilities |= PNP_WRITE;
 	dev->capabilities |= PNP_DISABLE;
-	pnp_init_resources(&dev->res);
+	pnp_init_resource_table(&dev->res);
 	return dev;
 }
 
@@ -1020,7 +1020,7 @@
 static int isapnp_get_resources(struct pnp_dev *dev, struct pnp_resource_table * res)
 {
 	int ret;
-	pnp_init_resources(res);
+	pnp_init_resource_table(res);
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	ret = isapnp_read_resources(dev, res);
 	isapnp_cfg_end();
diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	2003-06-20 21:48:26.000000000 +0000
+++ b/drivers/pnp/manager.c	2003-06-22 23:05:52.000000000 +0000
@@ -190,7 +190,7 @@
  * @table: pointer to the desired resource table
  *
  */
-void pnp_init_resources(struct pnp_resource_table *table)
+void pnp_init_resource_table(struct pnp_resource_table *table)
 {
 	int idx;
 	down(&pnp_res_mutex);
@@ -226,7 +226,7 @@
  * @res - the resources to clean
  *
  */
-static void pnp_clean_resources(struct pnp_resource_table * res)
+static void pnp_clean_resource_table(struct pnp_resource_table * res)
 {
 	int idx;
 	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
@@ -278,7 +278,7 @@
 		return -ENODEV;
 
 	down(&pnp_res_mutex);
-	pnp_clean_resources(&dev->res); /* start with a fresh slate */
+	pnp_clean_resource_table(&dev->res); /* start with a fresh slate */
 	if (dev->independent) {
 		port = dev->independent->port;
 		mem = dev->independent->mem;
@@ -351,7 +351,7 @@
 	return 1;
 
 fail:
-	pnp_clean_resources(&dev->res);
+	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 	return 0;
 }
@@ -510,7 +510,7 @@
 
 	/* release the resources so that other devices can use them */
 	down(&pnp_res_mutex);
-	pnp_clean_resources(&dev->res);
+	pnp_clean_resource_table(&dev->res);
 	up(&pnp_res_mutex);
 
 	return 1;
@@ -539,4 +539,4 @@
 EXPORT_SYMBOL(pnp_activate_dev);
 EXPORT_SYMBOL(pnp_disable_dev);
 EXPORT_SYMBOL(pnp_resource_change);
-EXPORT_SYMBOL(pnp_init_resources);
+EXPORT_SYMBOL(pnp_init_resource_table);
diff -urN a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	2003-06-20 21:48:26.000000000 +0000
+++ b/drivers/pnp/pnpbios/core.c	2003-06-22 23:20:40.000000000 +0000
@@ -937,7 +937,7 @@
 
 	/* clear out the damaged flags */
 	if (!dev->active)
-		pnp_init_resources(&dev->res);
+		pnp_init_resource_table(&dev->res);
 
 	pnp_add_device(dev);
 	pnpbios_interface_attach_device(node);
diff -urN a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	2003-06-20 21:48:26.000000000 +0000
+++ b/drivers/pnp/support.c	2003-06-22 23:11:49.000000000 +0000
@@ -123,7 +123,7 @@
 		return NULL;
 
 	/* Blank the resource table values */
-	pnp_init_resources(res);
+	pnp_init_resource_table(res);
 
 	while ((char *)p < (char *)end) {
 
diff -urN a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	2003-06-20 21:48:28.000000000 +0000
+++ b/include/linux/pnp.h	2003-06-22 23:10:41.000000000 +0000
@@ -400,7 +400,7 @@
 int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data);
 int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data);
 int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data);
-void pnp_init_resources(struct pnp_resource_table *table);
+void pnp_init_resource_table(struct pnp_resource_table *table);
 int pnp_assign_resources(struct pnp_dev *dev, int depnum);
 int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
 int pnp_auto_config_dev(struct pnp_dev *dev);
@@ -448,7 +448,7 @@
 static inline int pnp_register_dma_resource(struct pnp_option *option, struct pnp_dma *data) { return -ENODEV; }
 static inline int pnp_register_port_resource(struct pnp_option *option, struct pnp_port *data) { return -ENODEV; }
 static inline int pnp_register_mem_resource(struct pnp_option *option, struct pnp_mem *data) { return -ENODEV; }
-static inline void pnp_init_resources(struct pnp_resource_table *table) { }
+static inline void pnp_init_resource_table(struct pnp_resource_table *table) { }
 static inline int pnp_assign_resources(struct pnp_dev *dev, int depnum) { return -ENODEV; }
 static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
 static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
