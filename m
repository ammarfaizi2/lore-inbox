Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317642AbSH3WJ1>; Fri, 30 Aug 2002 18:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSH3WJK>; Fri, 30 Aug 2002 18:09:10 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:31763 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317606AbSH3WHV>;
	Fri, 30 Aug 2002 18:07:21 -0400
Date: Fri, 30 Aug 2002 15:10:44 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221044.GF10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com> <20020830221017.GE10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830221017.GE10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.546   -> 1.547  
#	arch/alpha/kernel/core_t2.c	1.3     -> 1.4    
#	arch/alpha/kernel/core_irongate.c	1.6     -> 1.7    
#	arch/alpha/kernel/core_polaris.c	1.2     -> 1.3    
#	arch/alpha/kernel/core_apecs.c	1.3     -> 1.4    
#	arch/alpha/kernel/core_lca.c	1.3     -> 1.4    
#	arch/alpha/kernel/core_cia.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	greg@kroah.com	1.547
# [PATCH] PCI: alpha pci_ops changes
# 
# pci_ops update for most of the alpha ports.
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/core_apecs.c b/arch/alpha/kernel/core_apecs.c
--- a/arch/alpha/kernel/core_apecs.c	Fri Aug 30 15:00:27 2002
+++ b/arch/alpha/kernel/core_apecs.c	Fri Aug 30 15:00:27 2002
@@ -90,12 +90,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr,
-	     unsigned char *type1)
+mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, unsigned char *type1)
 {
 	unsigned long addr;
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = bus_dev->number;
 
 	DBGC(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x,"
 	      " pci_addr=0x%p, type1=0x%p)\n",
@@ -273,87 +272,66 @@
 }
 
 static int
-apecs_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+apecs_read_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
+		  u8 *value)
 {
 	unsigned long addr, pci_addr;
 	unsigned char type1;
+	long mask;
+	int shift;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	addr = (pci_addr << 5) + 0x00 + APECS_CONF;
-	*value = conf_read(addr, type1) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-apecs_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr = (pci_addr << 5) + 0x08 + APECS_CONF;
-	*value = conf_read(addr, type1) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-apecs_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr = (pci_addr << 5) + 0x18 + APECS_CONF;
-	*value = conf_read(addr, type1);
+		switch (size) {
+	case 1:
+		mask = 0x00;
+		shift = (where & 3) * 8;
+		break;
+	case 2:
+		mask = 0x08;
+		shift = (where & 3) * 8;
+		break;
+	case 4:
+		mask = 0x18;
+		shift = 0;
+		break;
+	}
+	addr = (pci_addr << 5) + mask + APECS_CONF;
+	*value = conf_read(addr, type1) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int
-apecs_write_config(struct pci_dev *dev, int where, u32 value, long mask)
+apecs_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
 	unsigned long addr, pci_addr;
 	unsigned char type1;
+	long mask;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	switch (size) {
+	case 1:
+		mask = 0x00;
+		break;
+	case 2:
+		mask = 0x08;
+		break;
+	case 4:
+		mask = 0x18;
+		break;
+	}
 	addr = (pci_addr << 5) + mask + APECS_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-apecs_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return apecs_write_config(dev, where, value, 0x00);
-}
-
-static int
-apecs_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return apecs_write_config(dev, where, value, 0x08);
-}
-
-static int
-apecs_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return apecs_write_config(dev, where, value, 0x18);
-}
-
 struct pci_ops apecs_pci_ops = 
 {
-	read_byte:	apecs_read_config_byte,
-	read_word:	apecs_read_config_word,
-	read_dword:	apecs_read_config_dword,
-	write_byte:	apecs_write_config_byte,
-	write_word:	apecs_write_config_word,
-	write_dword:	apecs_write_config_dword
+	.read =		apecs_read_config,
+	.write =	apecs_write_config,
 };
 
 void
diff -Nru a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
--- a/arch/alpha/kernel/core_cia.c	Fri Aug 30 15:00:27 2002
+++ b/arch/alpha/kernel/core_cia.c	Fri Aug 30 15:00:27 2002
@@ -89,11 +89,10 @@
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr,
-	     unsigned char *type1)
+mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, unsigned char *type1)
 {
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = bus_dev->number;
 
 	*type1 = (bus != 0);
 	*pci_addr = (bus << 16) | (device_fn << 8) | where;
@@ -208,88 +207,70 @@
 	DBGC(("done\n"));
 }
 
-static int
-cia_read_config_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr = (pci_addr << 5) + 0x00 + CIA_CONF;
-	*value = conf_read(addr, type1) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
 static int 
-cia_read_config_word(struct pci_dev *dev, int where, u16 *value)
+cia_read_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
+		u32 *value)
 {
 	unsigned long addr, pci_addr;
+	long mask;
 	unsigned char type1;
+	int shift;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	addr = (pci_addr << 5) + 0x08 + CIA_CONF;
-	*value = conf_read(addr, type1) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-cia_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	switch (size) {
+	case 1:
+		mask = 0x00;
+		shift = (where & 3) * 8;
+		break;
+	case 2:
+		mask = 0x08;
+		shift = (where & 3) * 8;
+		break;
+	case 4:
+		mase = 0x18;
+		shift = 0;
+		break;
+	}
 
 	addr = (pci_addr << 5) + 0x18 + CIA_CONF;
-	*value = conf_read(addr, type1);
+	*value = conf_read(addr, type1) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-cia_write_config(struct pci_dev *dev, int where, u32 value, long mask)
+cia_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
+		 u32 value)
 {
 	unsigned long addr, pci_addr;
+	long mask;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	switch (size) {
+	case 1:
+		mask = 0x00;
+		break;
+	case 2:
+		mask = 0x08;
+		break;
+	case 4:
+		mase = 0x18;
+		break;
+	}
+
 	addr = (pci_addr << 5) + mask + CIA_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-cia_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return cia_write_config(dev, where, value, 0x00);
-}
-
-static int 
-cia_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return cia_write_config(dev, where, value, 0x08);
-}
-
-static int 
-cia_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return cia_write_config(dev, where, value, 0x18);
-}
-
 struct pci_ops cia_pci_ops = 
 {
-	read_byte:	cia_read_config_byte,
-	read_word:	cia_read_config_word,
-	read_dword:	cia_read_config_dword,
-	write_byte:	cia_write_config_byte,
-	write_word:	cia_write_config_word,
-	write_dword:	cia_write_config_dword
+	.read = 	cia_read_config,
+	.write =	cia_write_config,
 };
 
 /*
diff -Nru a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
--- a/arch/alpha/kernel/core_irongate.c	Fri Aug 30 15:00:27 2002
+++ b/arch/alpha/kernel/core_irongate.c	Fri Aug 30 15:00:27 2002
@@ -83,12 +83,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr,
-	     unsigned char *type1)
+mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, unsigned char *type1)
 {
 	unsigned long addr;
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = bus_dev->number;
 
 	DBG_CFG(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x, "
 		 "pci_addr=0x%p, type1=0x%p)\n",
@@ -105,12 +104,13 @@
 }
 
 static int
-irongate_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+irongate_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		     int size, u32 *value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	*value = __kernel_ldbu(*(vucp)addr);
@@ -118,38 +118,13 @@
 }
 
 static int
-irongate_read_config_word(struct pci_dev *dev, int where, u16 *value)
+irongate_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		      int size, u32 value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = __kernel_ldwu(*(vusp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-irongate_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = *(vuip)addr;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-irongate_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	__kernel_stb(value, *(vucp)addr);
@@ -158,45 +133,11 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-irongate_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	__kernel_stw(value, *(vusp)addr);
-	mb();
-	__kernel_ldwu(*(vusp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-irongate_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*(vuip)addr = value;
-	mb();
-	*(vuip)addr;
-	return PCIBIOS_SUCCESSFUL;
-}
-
 
 struct pci_ops irongate_pci_ops =
 {
-	read_byte:	irongate_read_config_byte,
-	read_word:	irongate_read_config_word,
-	read_dword:	irongate_read_config_dword,
-	write_byte:	irongate_write_config_byte,
-	write_word:	irongate_write_config_word,
-	write_dword:	irongate_write_config_dword
+	.read =		irongate_read_config,
+	.write =	irongate_write_config,
 };
 
 #ifdef DEBUG_IRONGATE
diff -Nru a/arch/alpha/kernel/core_lca.c b/arch/alpha/kernel/core_lca.c
--- a/arch/alpha/kernel/core_lca.c	Fri Aug 30 15:00:27 2002
+++ b/arch/alpha/kernel/core_lca.c	Fri Aug 30 15:00:27 2002
@@ -99,11 +99,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr)
+mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+	     unsigned long *pci_addr)
 {
 	unsigned long addr;
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = bus_dev->number;
 
 	if (bus == 0) {
 		int device = device_fn >> 3;
@@ -199,83 +199,65 @@
 }
 
 static int
-lca_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+lca_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		int size, u32 *value)
 {
 	unsigned long addr, pci_addr;
+	long mask;
+	int shift
 
-	if (mk_conf_addr(dev, where, &pci_addr))
+	if (mk_conf_addr(bus, devfn, dev, where, &pci_addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	addr = (pci_addr << 5) + 0x00 + LCA_CONF;
-	*value = conf_read(addr) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-lca_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long addr, pci_addr;
-
-	if (mk_conf_addr(dev, where, &pci_addr))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr = (pci_addr << 5) + 0x08 + LCA_CONF;
-	*value = conf_read(addr) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-lca_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr, pci_addr;
-
-	if (mk_conf_addr(dev, where, &pci_addr))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr = (pci_addr << 5) + 0x18 + LCA_CONF;
-	*value = conf_read(addr);
+	switch (size) {
+	case 1:
+		shift = (where & 3) * 8;
+		mask = 0x00;
+		break;
+	case 2:
+		shift = (where & 3) * 8;
+		mask = 0x08
+		break;
+	case 4:
+		shift = 0;
+		mask = 0x18
+		break;
+	}
+	addr = (pci_addr << 5) + mask + LCA_CONF;
+	*value = conf_read(addr) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-lca_write_config(struct pci_dev *dev, int where, u32 value, long mask)
+lca_write_config(struct pci_bus *dev, unsigned int devfn, int where, int size,
+		 u32 value)
 {
 	unsigned long addr, pci_addr;
+	long mask;
 
-	if (mk_conf_addr(dev, where, &pci_addr))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+		switch (size) {
+	case 1:
+		mask = 0x00;
+		break;
+	case 2:
+		mask = 0x08
+		break;
+	case 4:
+		mask = 0x18
+		break;
+	}
 	addr = (pci_addr << 5) + mask + LCA_CONF;
 	conf_write(addr, value << ((where & 3) * 8));
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-lca_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return lca_write_config(dev, where, value, 0x00);
-}
-
-static int
-lca_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return lca_write_config(dev, where, value, 0x08);
-}
-
-static int
-lca_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return lca_write_config(dev, where, value, 0x18);
-}
-
 struct pci_ops lca_pci_ops = 
 {
-	read_byte:	lca_read_config_byte,
-	read_word:	lca_read_config_word,
-	read_dword:	lca_read_config_dword,
-	write_byte:	lca_write_config_byte,
-	write_word:	lca_write_config_word,
-	write_dword:	lca_write_config_dword
+	.read =		lca_read_config,
+	.write =	lca_write_config,
 };
 
 void
diff -Nru a/arch/alpha/kernel/core_polaris.c b/arch/alpha/kernel/core_polaris.c
--- a/arch/alpha/kernel/core_polaris.c	Fri Aug 30 15:00:27 2002
+++ b/arch/alpha/kernel/core_polaris.c	Fri Aug 30 15:00:27 2002
@@ -65,10 +65,10 @@
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr, u8 *type1)
+mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, u8 *type1)
 {
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = bus_dev->number;
 
 	*type1 = (bus == 0) ? 0 : 1;
 	*pci_addr = (bus << 16) | (device_fn << 8) | (where) |
@@ -82,51 +82,28 @@
 }
 
 static int
-polaris_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+polaris_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		    int size, u32 *value)
 {
 	unsigned long pci_addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
                 return PCIBIOS_DEVICE_NOT_FOUND;
 
 	*value = __kernel_ldbu(*(vucp)pci_addr);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-polaris_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-                return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = __kernel_ldwu(*(vusp)pci_addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-int
-polaris_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-                return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = *(vuip)pci_addr;
-	return PCIBIOS_SUCCESSFUL;
-}
 
 static int 
-polaris_write_config_byte(struct pci_dev *dev, int where, u8 value)
+polaris_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		     int size, u32 value)
 {
 	unsigned long pci_addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
                 return PCIBIOS_DEVICE_NOT_FOUND;
 
         __kernel_stb(value, *(vucp)pci_addr);
@@ -135,44 +112,10 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int 
-polaris_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	unsigned long pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-                return PCIBIOS_DEVICE_NOT_FOUND;
-
-        __kernel_stw(value, *(vusp)pci_addr);
-	mb();
-	__kernel_ldwu(*(vusp)pci_addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-int 
-polaris_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	unsigned long pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-                return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*(vuip)pci_addr = value;
-	mb();
-	*(vuip)pci_addr;
-	return PCIBIOS_SUCCESSFUL;
-}
-
 struct pci_ops polaris_pci_ops = 
 {
-	read_byte:	polaris_read_config_byte,
-	read_word:	polaris_read_config_word,
-	read_dword:	polaris_read_config_dword,
-	write_byte:	polaris_write_config_byte,
-	write_word:	polaris_write_config_word,
-	write_dword:	polaris_write_config_dword
+	.read =		polaris_read_config,
+	.write =	polaris_write_config,
 };
 
 void __init
diff -Nru a/arch/alpha/kernel/core_t2.c b/arch/alpha/kernel/core_t2.c
--- a/arch/alpha/kernel/core_t2.c	Fri Aug 30 15:00:27 2002
+++ b/arch/alpha/kernel/core_t2.c	Fri Aug 30 15:00:27 2002
@@ -89,12 +89,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr,
-	     unsigned char *type1)
+mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, unsigned char *type1)
 {
 	unsigned long addr;
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = bus_dev->number;
 
 	DBG(("mk_conf_addr(bus=%d, dfn=0x%x, where=0x%x,"
 	     " addr=0x%lx, type1=0x%x)\n",
@@ -238,87 +237,67 @@
 }
 
 static int
-t2_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+t2_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+	       int size, u32 *value)
 {
 	unsigned long addr, pci_addr;
 	unsigned char type1;
+	int shift;
+	long mask;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr = (pci_addr << 5) + 0x00 + T2_CONF;
-	*value = conf_read(addr, type1) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-t2_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr = (pci_addr << 5) + 0x08 + T2_CONF;
-	*value = conf_read(addr, type1) >> ((where & 3) * 8);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-t2_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr, pci_addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	addr = (pci_addr << 5) + 0x18 + T2_CONF;
-	*value = conf_read(addr, type1);
+	switch (size) {
+	case 1:
+		mask = 0x00;
+		shift = (where & 3) * 8;
+		break;
+	case 2:
+		mask = 0x08;
+		shift = (where & 3) * 8;
+		break;
+	case 4:
+		mask = 0x18;
+		shift = 0;
+		break;
+	}
+	addr = (pci_addr << 5) + mask + T2_CONF;
+	*value = conf_read(addr, type1) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-t2_write_config(struct pci_dev *dev, int where, u32 value, long mask)
+t2_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
+		u32 value)
 {
 	unsigned long addr, pci_addr;
 	unsigned char type1;
+	long mask;
 
 	if (mk_conf_addr(dev, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	switch (size) {
+	case 1:
+		mask = 0x00;
+		break;
+	case 2:
+		mask = 0x08;
+		break;
+	case 4:
+		mask = 0x18;
+		break;
+	}
 	addr = (pci_addr << 5) + mask + T2_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int 
-t2_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return t2_write_config(dev, where, value, 0x00);
-}
-
-static int 
-t2_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return t2_write_config(dev, where, value, 0x08);
-}
-
-static int 
-t2_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return t2_write_config(dev, where, value, 0x18);
-}
-
 struct pci_ops t2_pci_ops = 
 {
-	read_byte:	t2_read_config_byte,
-	read_word:	t2_read_config_word,
-	read_dword:	t2_read_config_dword,
-	write_byte:	t2_write_config_byte,
-	write_word:	t2_write_config_word,
-	write_dword:	t2_write_config_dword
+	.read =		t2_read_config,
+	.write =	t2_write_config,
 };
 
 void __init
