Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTJJWRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTJJWRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:17:37 -0400
Received: from heisenberg.ccac.RWTH-Aachen.DE ([134.130.220.226]:44305 "EHLO
	heisenberg.ccac.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S263126AbTJJWR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:17:27 -0400
Date: Sat, 11 Oct 2003 00:17:23 +0200
From: Carsten Jacobi <carsten@ccac.rwth-aachen.de>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] lne390 and Jensen Alphas
Message-ID: <20031010221723.GA12615@ccac.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there!

I am running a Jensen board with a lne390 network adapter for two years
with some private patches that I would like to have in the official
kernel releases.
About five years ago, I sent some patches to Alan Cox and to this mailing
list (http://lkml.org/lkml/1998/8/9/16) that didn't make it into the
kernel. This here is my second approach!
The patch is attached and provides activation support for the EISA
adapter. This is very helpful for the Jensen board since the EISA config
utility won't help for operating systems started on the SRM console (as
i.e. Linux). When you load the module with the argument "activation=1"
it will not only request interrupt number and iospace in the kernel API
but also configure the adapter accordingly.

A CNET 900E EISA Ethernet adapter is also here that I would like to use.
Can anyone give me some information or better datasheets about that
adapter. I would also write the driver. Last time I asked (also about
five years ago) they gave me Lan-Manager drivers and two useless
EISA-Config files (all configurations shared the same bit pattern) ...
still better than nothing. Is it easy to disassemble Lan-Manager drivers
and retrieve appropriate info from them to write a driver? The CNET 900E
also seems to use a National Semiconductor 8390-compatible Chip set and
it seems to have 16K of shared mem on board.

Anyways, I would be glad if I saw my patches in one of the next kernel
releases.

Regards,
	Carsten Jacobi

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lne390.c.patch"

--- lne390.c.orig	2003-09-21 18:49:55.000000000 +0200
+++ lne390.c	2003-10-10 23:38:48.000000000 +0200
@@ -94,6 +94,7 @@
 #define LNE390_DEBUG	0
 
 static unsigned char irq_map[] __initdata = {15, 12, 11, 10, 9, 7, 5, 3};
+static unsigned char irq_reverse_map[] __initdata = {0xff, 0xff, 0xff, 7, 0xff, 6, 0xff, 5, 0xff, 4, 3, 2, 1, 0xff, 0xff, 0};
 static unsigned int shmem_mapA[] __initdata = {0xff, 0xfe, 0xfd, 0xfff, 0xffe, 0xffc, 0x0d, 0x0};
 static unsigned int shmem_mapB[] __initdata = {0xff, 0xfe, 0x0e, 0xfff, 0xffe, 0xffc, 0x0d, 0x0};
 
@@ -221,6 +222,10 @@
 	printk("%dkB memory at physical address %#lx\n",
 			LNE390_STOP_PG/4, dev->mem_start);
 
+#ifdef CONFIG_ALPHA_JENSEN
+	/* On the Jensen board EISA cards will see their own address
+	 * space */
+#else
 	/*
 	   BEWARE!! Some dain-bramaged EISA SCUs will allow you to put
 	   the card mem within the region covered by `normal' RAM  !!!
@@ -246,6 +251,7 @@
 		printk("lne390.c: remapped %dkB card memory to virtual address %#lx\n",
 				LNE390_STOP_PG/4, dev->mem_start);
 	}
+#endif /* CONFIG_ALPHA_JENSEN */
 
 	dev->mem_end = dev->rmem_end = dev->mem_start
 		+ (LNE390_STOP_PG - LNE390_START_PG)*256;
@@ -352,7 +358,24 @@
 	unsigned long shmem = dev->mem_start + ((start_page - LNE390_START_PG)<<8);
 
 	count = (count + 3) & ~3;     /* Round up to doubleword */
+#ifndef CONFIG_ALPHA_JENSEN
 	isa_memcpy_toio(shmem, buf, count);
+#else
+	/* The mylex lne390 adapter requires 32bit access (see above) for every
+	 * operation to the shared mem buffer. Since the block buffer is hardly
+	 * aligned to a 32bit boundary isa_memcpy_toio() will use 16bit
+	 * operations to access the buffer ... we must use something else here. */
+
+	const void *from = buf;
+	count -= 4;
+	do {
+		__raw_writel(*(const u16 *)from | (*(const u16 *)(from+2))<<16, (unsigned long) shmem);
+		count -= 4;
+		(unsigned long) shmem += 4;
+		from += 4;
+	} while (count >= 0);
+#endif
+
 }
 
 static int lne390_open(struct net_device *dev)
@@ -377,19 +400,23 @@
 static int io[MAX_LNE_CARDS];
 static int irq[MAX_LNE_CARDS];
 static int mem[MAX_LNE_CARDS];
+static int activate[MAX_LNE_CARDS];
 
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_LNE_CARDS) "i");
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_LNE_CARDS) "i");
 MODULE_PARM(mem, "1-" __MODULE_STRING(MAX_LNE_CARDS) "i");
+MODULE_PARM(activate, "1-" __MODULE_STRING(MAX_LNE_CARDS) "i");
 MODULE_PARM_DESC(io, "I/O base address(es)");
 MODULE_PARM_DESC(irq, "IRQ number(s)");
 MODULE_PARM_DESC(mem, "memory base address(es)");
+MODULE_PARM_DESC(activate, "activate the board(s) to use indicated configuration(s)\n\tAttention: This overwrites the settings of your EISA Configuration!");
 MODULE_DESCRIPTION("Mylex LNE390A/B EISA Ethernet driver");
 MODULE_LICENSE("GPL");
 
 int init_module(void)
 {
-	int this_dev, found = 0;
+	int this_dev, index, found = 0;
+	unsigned char lne390_config;
 
 	for (this_dev = 0; this_dev < MAX_LNE_CARDS; this_dev++) {
 		struct net_device *dev = &dev_lne[this_dev];
@@ -397,6 +424,52 @@
 		dev->base_addr = io[this_dev];
 		dev->mem_start = mem[this_dev];
 		dev->init = lne390_probe;
+
+		/* Activate the adapter, this may overwrite the settings
+		 * done in the EISA Configuration Utility! */
+
+		if (activate[this_dev]) {
+
+			if (inb_p(dev->base_addr + LNE390_ID_PORT) == 0xff) return -ENODEV; 
+			if (dev->mem_start & 0xffff) {
+				printk (KERN_ERR "The lne390 shared mem buffer must be on a 16-bit boundary,\nwill try to initialize 0x%lx instead of 0x%lx\n", dev->mem_start & 0xffff0000, dev->mem_start);
+				dev->mem_start = dev->mem_start & 0xffff0000;
+			}
+			printk("Trying to activate LNE390 card in slot %d with irq %d and shared mem at 0x%lx\n", (int)dev->base_addr>>12, dev->irq, dev->mem_start);
+
+			/* Verify the irq number */
+			if ((dev->irq < 16) && (irq_reverse_map[dev->irq]!=0xff)) lne390_config = irq_reverse_map[dev->irq]<<3;
+			else {
+				printk(KERN_ERR "Sorry, the irq of lne390 cards can not be mapped to %d\n", dev->irq);
+				return -ENXIO;
+			}
+
+			/* Verify shared memory */
+			int revision = (inl(dev->base_addr + LNE390_ID_PORT) >> 24) & 0x01;
+			if (revision) {
+				for (index = 0; (index < 8) && (dev->mem_start >> 16 != shmem_mapB[index]); index++);
+				if (index > 7) {
+					printk (KERN_ERR "The lne390B adapter can not map shared mem at 0x%lx\n", dev->mem_start);
+					return -ENXIO;
+				}
+				else lne390_config = lne390_config | index;
+			}
+			else {
+				for (index = 0; (index < 8) && (dev->mem_start >> 16 != shmem_mapA[index]); index++);
+				if (index > 7) {
+					printk (KERN_ERR "The lne390A adapter can not map shared mem at 0x%lx\n", dev->mem_start);
+					return -ENXIO;
+				}
+				else lne390_config = lne390_config | index;
+			}
+
+			/* Now activate the adapter */
+			outb (0x0, dev->base_addr + LNE390_RESET_PORT);
+			outb (0x1, dev->base_addr + LNE390_RESET_PORT);
+			outb (lne390_config, dev->base_addr + LNE390_CFG2);
+			printk ("lne390 in slot %d has been activated\n", dev->base_addr>>12);
+		}
+
 		/* Default is to only install one card. */
 		if (io[this_dev] == 0 && this_dev != 0) break;
 		if (register_netdev(dev) != 0) {

--8t9RHnE3ZwKMSgU+--
