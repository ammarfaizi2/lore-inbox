Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSH3WNP>; Fri, 30 Aug 2002 18:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSH3WM0>; Fri, 30 Aug 2002 18:12:26 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:33811 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317648AbSH3WI5>;
	Fri, 30 Aug 2002 18:08:57 -0400
Date: Fri, 30 Aug 2002 15:12:20 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221220.GJ10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com> <20020830221017.GE10783@kroah.com> <20020830221044.GF10783@kroah.com> <20020830221107.GG10783@kroah.com> <20020830221127.GH10783@kroah.com> <20020830221157.GI10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830221157.GI10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.550   -> 1.551  
#	arch/i386/pci/numa.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	colpatch@us.ibm.com	1.551
# [PATCH] Fixed NUMA-Q PCI patch
# 
# This patch fixes a bug in NUMA-Q PCI code where the kernel can't find PCI
# devices on any node other than the first.
# --------------------------------------------
#
diff -Nru a/arch/i386/pci/numa.c b/arch/i386/pci/numa.c
--- a/arch/i386/pci/numa.c	Fri Aug 30 15:00:15 2002
+++ b/arch/i386/pci/numa.c	Fri Aug 30 15:00:15 2002
@@ -1,19 +1,19 @@
 /*
  * numa.c - Low-level PCI access for NUMA-Q machines
  */
+
 #include <linux/pci.h>
 #include <linux/init.h>
-
 #include "pci.h"
 
 #define BUS2QUAD(global) (mp_bus_id_to_node[global])
 #define BUS2LOCAL(global) (mp_bus_id_to_local[global])
 #define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
 
-#define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
+#define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
@@ -22,7 +22,7 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
@@ -41,7 +41,7 @@
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int __pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
@@ -50,7 +50,7 @@
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
@@ -69,6 +69,25 @@
 	return 0;
 }
 
+#undef PCI_CONF1_MQ_ADDRESS
+
+static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
+{
+	return __pci_conf1_mq_read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
+}
+
+static int pci_conf1_mq_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
+{
+	return __pci_conf1_mq_write(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
+}
+
+static struct pci_ops pci_direct_conf1_mq = {
+	read:	pci_conf1_mq_read,
+	write:	pci_conf1_mq_write
+};
+
 
 static void __devinit pci_fixup_i450nx(struct pci_dev *d)
 {
@@ -102,8 +121,7 @@
 {
 	int quad;
 
-	pci_config_read = pci_conf1_read;
-	pci_config_write = pci_conf1_write;
+	pci_root_ops = &pci_direct_conf1_mq;
 
 	if (pcibios_scanned++)
 		return 0;
