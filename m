Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSFFSdV>; Thu, 6 Jun 2002 14:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317049AbSFFSbV>; Thu, 6 Jun 2002 14:31:21 -0400
Received: from keen.esi.ac.at ([193.170.117.2]:31507 "EHLO keen.esi.ac.at")
	by vger.kernel.org with ESMTP id <S317066AbSFFSaa>;
	Thu, 6 Jun 2002 14:30:30 -0400
Date: Thu, 6 Jun 2002 20:30:28 +0200 (CEST)
From: Gerald Teschl <gerald@esi.ac.at>
To: linux-kernel@vger.kernel.org
cc: zwane@linux.realnet.co.sz, <linux-sound@vger.kernel.org>,
        <alan@redhat.com>, <perex@suse.cz>
Subject: [PATCH] isapnp_dma0.patch
Message-ID: <Pine.LNX.4.44.0206062024460.9347-100000@keen.esi.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to fix the isapnp activation problem of the OPL3Sa4 card Zwane 
Mwaikambo and I now agree
that the proper way to fix this is by changing isapnp.c and making the use 
of the dma channel 0
configurable. If a box works fine with dma 0 the user should be able to 
tell isapnp to use it.

The patch below makes the use of the dma channel 0 configurable via 
/proc/isapnp or via the
module option "isapnp_allow_dma0=0|1". The default behaviour is not to 
accept dma 0. It is
againts 2.4.19-pre10 and I have tested it on three different boxes.

Gerald


---------------------------------
--- linux.orig/drivers/pnp/isapnp.c	Thu Jun  6 18:04:43 2002
+++ linux/drivers/pnp/isapnp.c	Thu Jun  6 18:22:56 2002
@@ -28,6 +28,8 @@
  *  2001-11-07  Added isapnp_{,un}register_driver calls along the lines
  *              of the pci driver interface
  *              Kai Germaschewski <kai.germaschewski@gmx.de>
+ *  2002-06-06  Made the use of dma channel 0 configurable 
+ *              Gerald Teschl <gerald.teschl@univie.ac.at>
  */
 
 #include <linux/config.h>
@@ -59,6 +61,7 @@
 int isapnp_disable;			/* Disable ISA PnP */
 int isapnp_rdp;				/* Read Data Port */
 int isapnp_reset = 1;			/* reset all PnP cards (deactivate) */
+int isapnp_allow_dma0 = -1;		/* allow dma 0 during auto activation: -1=off (:default), 0=off (set by user), 1=on */
 int isapnp_skip_pci_scan;		/* skip PCI resource scanning */
 int isapnp_verbose = 1;			/* verbose mode */
 int isapnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
@@ -74,6 +77,8 @@
 MODULE_PARM_DESC(isapnp_rdp, "ISA Plug & Play read data port");
 MODULE_PARM(isapnp_reset, "i");
 MODULE_PARM_DESC(isapnp_reset, "ISA Plug & Play reset all cards");
+MODULE_PARM(isapnp_allow_dma0, "i");
+MODULE_PARM_DESC(isapnp_allow_dma0, "Allow dma value 0 during auto activation");
 MODULE_PARM(isapnp_skip_pci_scan, "i");
 MODULE_PARM_DESC(isapnp_skip_pci_scan, "ISA Plug & Play skip PCI resource scanning");
 MODULE_PARM(isapnp_verbose, "i");
@@ -1750,13 +1755,14 @@
 
 static int isapnp_check_dma(struct isapnp_cfgtmp *cfg, int dma, int idx)
 {
-	int i;
+	int i, mindma =1;
 	struct pci_dev *dev;
 
 	/* Some machines allow DMA 0, but others don't. In fact on some 
 	   boxes DMA 0 is the memory refresh. Play safe */
-	   
-	if (dma < 1 || dma == 4 || dma > 7)
+	if (isapnp_allow_dma0 == 1)
+		mindma = 0;
+	if (dma < mindma || dma == 4 || dma > 7)
 		return 1;
 	for (i = 0; i < 8; i++) {
 		if (isapnp_reserve_dma[i] == dma)
--- linux.orig/drivers/pnp/isapnp_proc.c	Wed Jan 17 22:29:14 2001
+++ linux/drivers/pnp/isapnp_proc.c	Thu Jun  6 18:07:20 2002
@@ -944,6 +944,22 @@
 	res->start = res->end = dma;
 	res->flags = IORESOURCE_DMA;
 }
+
+extern int isapnp_allow_dma0;
+static int isapnp_set_allow_dma0(char *line)
+{
+	int i;
+	char value[32];
+
+	isapnp_get_str(value, line, sizeof(value));
+	i = simple_strtoul(value, NULL, 0);
+	if (i < 0 || i > 1) {
+		printk("isapnp: wrong value %i for allow_dma0\n", i);
+		return 1;
+	}
+	isapnp_allow_dma0 = i;
+	return 0;
+}
  
 static int isapnp_set_dma(char *line)
 {
@@ -1030,6 +1046,8 @@
 	char cmd[32];
 
 	line = isapnp_get_str(cmd, line, sizeof(cmd));
+	if (!strcmp(cmd, "allow_dma0"))
+		return isapnp_set_allow_dma0(line);
 	if (!strcmp(cmd, "card"))
 		return isapnp_set_card(line);
 	if (!strcmp(cmd, "csn"))
--- linux.orig/Documentation/isapnp.txt	Wed Apr 18 20:49:11 2001
+++ linux/Documentation/isapnp.txt	Thu Jun  6 18:17:55 2002
@@ -29,6 +29,7 @@
 poke <reg> <value>	- poke configuration byte to selected register
 pokew <reg> <value>	- poke configuration word to selected register
 poked <reg> <value>	- poke configuration dword to selected register
+allow_dma0 <value>	- allow dma channel 0 during auto activation: 0=off, 1=on
 
 Explanation:
 	- variable <idx> begins with zero

