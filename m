Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTGFSGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 14:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTGFSGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 14:06:54 -0400
Received: from lidskialf.net ([62.3.233.115]:34725 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S263176AbTGFSGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 14:06:49 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvnet for kernel 2.5
Date: Sun, 6 Jul 2003 19:21:21 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307061921.21923.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, heres a patch against the Nvidia Nforce 1.0-0248 source to get onboard ethernet working under 2.5. 
Tested against 2.5.74.


---CUT HERE---
diff -Naurb nforce-1.0-0248-2.4/nvnet/Makefile nforce-1.0-0248-2.5/nvnet/Makefile
--- nforce-1.0-0248-2.4/nvnet/Makefile	2002-11-26 14:08:38.000000000 +0000
+++ nforce-1.0-0248-2.5/nvnet/Makefile	2003-07-06 19:01:01.000000000 +0100
@@ -21,7 +21,7 @@
 #
 # Target
 #
-TARGET = $(MODULE_NAME).o
+TARGET = $(MODULE_NAME).ko
 
 #
 # Networking library
@@ -59,10 +59,11 @@
 #
 # CFlags
 #
-CFLAGS = -c -DLINUX -DMODULE -DEXPORT_SYMTAB -D__KERNEL__ -O \
-	-Wstrict-prototypes -DCONFIG_PM  -fno-strict-aliasing \
+CFLAGS = -c -DLINUX -DMODULE -DEXPORT_SYMTAB -DKBUILD_MODNAME=nvnet \
+        -D__KERNEL__ -O \
+	-Wstrict-prototypes -DCONFIG_PM  -fno-strict-aliasing -fno-common \
         -mpreferred-stack-boundary=2 -march=i686 -falign-functions=4 \
-        -DMODULE -I$(SYSINCLUDE) $(ARCHDEFS)
+        -DMODULE -I$(SYSINCLUDE) -I$(KERNSRC)/include/asm/mach-default $(ARCHDEFS)
 
 #
 # Kernel version
@@ -89,10 +90,17 @@
 
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
 
@@ -125,4 +133,4 @@
 # Delete generated files
 #
 clean:
-	rm -f $(TARGET)
+	rm -f $(TARGET) nvnet.o *.mod.c *.mod.o 
diff -Naurb nforce-1.0-0248-2.4/nvnet/nvnet.c nforce-1.0-0248-2.5/nvnet/nvnet.c
--- nforce-1.0-0248-2.4/nvnet/nvnet.c	2002-11-26 14:08:38.000000000 +0000
+++ nforce-1.0-0248-2.5/nvnet/nvnet.c	2003-07-06 19:01:51.000000000 +0100
@@ -26,6 +26,9 @@
 char *common_hdO_version_string = HDO_VERSION_STRING;
 char *common_hdP_version_string = HDP_VERSION_STRING;
 
+// fix for common symbol exported by nvnetlib.o
+char* aPhyAddrAndId[256];
+
 /*
  * Driver information
  */ 
@@ -673,7 +676,7 @@
     PRINTK(DEBUG_OPEN, "nvnet_open: In\n");
     priv = (struct nvnet_private *)dev->priv;
 
-    MOD_INC_USE_COUNT;
+    try_module_get(THIS_MODULE);
 
     /*
      * Initialize hardware
@@ -688,7 +691,7 @@
 
     if(status != ADAPTERERR_NONE) 
     {
-	MOD_DEC_USE_COUNT;
+        module_put(THIS_MODULE);
 	free_irq(dev->irq, dev); 
         PRINTK_ERROR("nvnet_init - ADAPTER_Open failed\n");
         PRINTK(DEBUG_INIT, "nvnet_init -  Out\n");
@@ -704,7 +707,7 @@
 
         PRINTK_ERROR("nvnet_open - request_irq failed\n");
         PRINTK(DEBUG_OPEN, "nvnet_open -  Out\n");
-        MOD_DEC_USE_COUNT;
+        module_put(THIS_MODULE);
         return -EAGAIN;
     }
 
@@ -721,7 +724,7 @@
 }
 
 
-static void
+static irqreturn_t
 nvnet_interrupt(int irq, void *dev_instance, struct pt_regs *regs)
 {
     struct net_device *dev;
@@ -734,7 +737,7 @@
                  irq, dev_instance, regs);
 
     if(!dev)
-        return;
+        return IRQ_NONE;
 
     if(priv->hwapi->pfnQueryInterrupt(priv->hwapi->pADCX)) 
     {   
@@ -744,6 +747,7 @@
 
     PRINTK(DEBUG_INTR, "nvnet_interrupt -  Out\n");
 
+    return IRQ_HANDLED;
 }
 
 static int
@@ -766,7 +770,7 @@
 
     free_irq(dev->irq, dev); 
 
-    MOD_DEC_USE_COUNT;
+    module_put(THIS_MODULE);
     PRINTK(DEBUG_OPEN, "nvnet_close - OUT\n");
     return 0;
 }
@@ -1074,6 +1078,7 @@
     priv->pdev     = pdev; 
 
     SET_MODULE_OWNER(dev);
+    SET_NETDEV_DEV(dev, &(pdev->dev));
     priv->regs = (char *)memptr;
     pci_set_master(pdev);
 
@@ -1156,7 +1161,6 @@
         speed = DEFAULT_SPEED_SETTING;
     }
      
-
     PRINTK(DEBUG_PROBE, "nvnet_probe: Out\n");
     return 0;
 
@@ -1169,7 +1173,7 @@
 static void __devexit
 nvnet_remove(struct pci_dev *pdev)
 {
-    struct net_device *dev = pdev->driver_data;
+    struct net_device *dev = pci_get_drvdata(pdev);
     struct nvnet_private *priv = dev->priv;
     int i;
 
diff -Naurb nforce-1.0-0248-2.4/nvnet/nvnet.h nforce-1.0-0248-2.5/nvnet/nvnet.h
--- nforce-1.0-0248-2.4/nvnet/nvnet.h	2002-11-26 14:08:38.000000000 +0000
+++ nforce-1.0-0248-2.5/nvnet/nvnet.h	2003-07-06 19:01:53.000000000 +0100
@@ -42,7 +42,6 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
-#include <asm/irq.h>			/* For NR_IRQS only. */
 #include <linux/spinlock.h>
 #include <linux/proc_fs.h>
 
@@ -104,7 +103,7 @@
 static struct net_device_stats *nvnet_stats(struct net_device *dev);
 static int nvnet_config(struct net_device *dev, struct ifmap *map);
 static int nvnet_init(struct net_device *dev);
-static void nvnet_interrupt(int irq, void *dev_instance, 
+static irqreturn_t nvnet_interrupt(int irq, void *dev_instance, 
                              struct pt_regs *regs);
 static void nvnet_multicast(struct net_device *dev);
 ---CUT HERE---

