Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270413AbTGZVyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTGZVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:54:12 -0400
Received: from lidskialf.net ([62.3.233.115]:5056 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270413AbTGZVyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:54:07 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sat, 26 Jul 2003 23:09:20 +0100
User-Agent: KMail/1.5.2
Cc: Laurens <masterpe@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307262309.20074.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch for the latest nvidia nforce 1.0-261 nvnet drivers with kernel 2.5.

--- CUT HERE ---
diff -Naurb nforce-1.0-0261-2.4/nvnet/Makefile nforce-1.0-0261-2.5/nvnet/Makefile
--- nforce-1.0-0261-2.4/nvnet/Makefile	2003-05-06 20:39:38.000000000 +0100
+++ nforce-1.0-0261-2.5/nvnet/Makefile	2003-07-26 22:53:27.000000000 +0100
@@ -21,7 +21,7 @@
 #
 # Target
 #
-TARGET = $(MODULE_NAME).o
+TARGET = $(MODULE_NAME).ko
 
 #
 # Networking library
@@ -76,7 +76,8 @@
 CFLAGS = -c -Wall -DLINUX -DMODULE -DEXPORT_SYMTAB -D__KERNEL__ -O \
 	-Wstrict-prototypes -DCONFIG_PM  -fno-strict-aliasing \
         -mpreferred-stack-boundary=2 -march=i686 $(ALIGN) \
-        -DMODULE -I$(SYSINCLUDE) $(ARCHDEFS)
+        -DMODULE -I$(SYSINCLUDE) $(ARCHDEFS) \
+        -I$(KERNSRC)/include/asm/mach-default -DKBUILD_MODNAME=nvnet
 
 #
 # Kernel version
@@ -103,10 +104,17 @@
 
 all: $(TARGET) 
 
-$(TARGET): $(SRC) $(NVNETLIB) $(MCPINCLUDE)
+nvnet.o: $(SRC)
 	$(CC) $(CFLAGS) $(SRC)
-	ld -r -o $(TEMP) $(OBJ) $(NVNETLIB)
-	$(OBJCOPY) --strip-symbol="gcc2_compiled." $(TEMP)
+
+nvnet.mod.c: nvnet.o
+	$(KERNSRC)/scripts/modpost nvnet.o
+
+nvnet.mod.o: nvnet.mod.c
+	$(CC) $(CFLAGS) nvnet.mod.c
+
+$(TARGET): nvnet.o nvnet.mod.o $(NVNETLIB)
+	ld -r -o $(TEMP) nvnet.o nvnet.mod.o $(NVNETLIB)
 	cp $(TEMP) $(TARGET)
 	rm $(TEMP)
 
@@ -139,4 +147,4 @@
 # Delete generated files
 #
 clean:
-	rm -f $(TARGET)
+	rm -f $(TARGET) nvnet.o *.mod.c *.mod.o
diff -Naurb nforce-1.0-0261-2.4/nvnet/nvnet.c nforce-1.0-0261-2.5/nvnet/nvnet.c
--- nforce-1.0-0261-2.4/nvnet/nvnet.c	2003-05-06 20:39:38.000000000 +0100
+++ nforce-1.0-0261-2.5/nvnet/nvnet.c	2003-07-26 23:03:55.000000000 +0100
@@ -26,6 +26,10 @@
 char *common_hdO_version_string = HDO_VERSION_STRING;
 char *common_hdP_version_string = HDP_VERSION_STRING;
 
+// fix for common symbol exported by nvnetlib.o
+char* aPhyAddrAndId[256] = {};
+
+
 /*
  * Driver information
  */ 
@@ -753,7 +757,7 @@
 }
 
 
-static void nvnet_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
+static irqreturn_t nvnet_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
     struct net_device *dev;
     struct nvnet_private *priv;
@@ -765,7 +769,7 @@
                  irq, dev_instance, regs);
 
     if(!dev)
-        return;
+        return IRQ_NONE;
 
     if(priv->hwapi->pfnQueryInterrupt(priv->hwapi->pADCX)) 
     {   
@@ -776,6 +780,7 @@
 
     PRINTK(DEBUG_INTR, "nvnet_interrupt -  Out\n");
 
+    return IRQ_HANDLED;
 }
 
 static int nvnet_close(struct net_device *dev)
@@ -1245,7 +1250,7 @@
  */
 static void __devexit nvnet_remove(struct pci_dev *pdev)
 {
-    struct net_device *dev = pdev->driver_data;
+    struct net_device *dev = pci_get_drvdata(pdev);
     struct nvnet_private *priv = dev->priv;
     int i;
 
diff -Naurb nforce-1.0-0261-2.4/nvnet/nvnet.h nforce-1.0-0261-2.5/nvnet/nvnet.h
--- nforce-1.0-0261-2.4/nvnet/nvnet.h	2003-05-06 20:39:38.000000000 +0100
+++ nforce-1.0-0261-2.5/nvnet/nvnet.h	2003-07-26 22:55:49.000000000 +0100
@@ -42,7 +42,6 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/irq.h>            /* For NR_IRQS only. */
 #include <linux/spinlock.h>
 #include <linux/proc_fs.h>
 
@@ -104,7 +103,7 @@
 static struct net_device_stats *nvnet_stats(struct net_device *dev);
 static int nvnet_config(struct net_device *dev, struct ifmap *map);
 static int nvnet_init(struct net_device *dev);
-static void nvnet_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
+static irqreturn_t nvnet_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static void nvnet_multicast(struct net_device *dev);
 
 typedef enum {fail, pass} result; /* Boolean pass/fail results */
--- CUT HERE ---

