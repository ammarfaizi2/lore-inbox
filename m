Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319454AbSIGIMc>; Sat, 7 Sep 2002 04:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319455AbSIGIMc>; Sat, 7 Sep 2002 04:12:32 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:20743 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319454AbSIGIMU>; Sat, 7 Sep 2002 04:12:20 -0400
Date: Sat, 7 Sep 2002 12:16:37 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.33] alpha: pci_ops update
Message-ID: <20020907121637.A17245@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on CIA (sparse config space) and Irongate (dense config space);
other platforms should work as they are similar to these two.

Access config space directly on rx164.

Ivan.

--- 2.5.33/arch/alpha/kernel/sys_rx164.c	Wed Apr 17 00:54:30 2002
+++ linux/arch/alpha/kernel/sys_rx164.c	Fri Sep  6 12:54:26 2002
@@ -35,16 +35,15 @@
 /* Note mask bit is true for ENABLED irqs.  */
 static unsigned long cached_irq_mask;
 
-/* Bus 0, Device 0.  Nothing else matters, since we invoke the
-   POLARIS routines directly.  */
-static struct pci_dev rx164_system;
-
 static inline void
 rx164_update_irq_hw(unsigned long mask)
 {
-	unsigned int temp;
-	polaris_write_config_dword(&rx164_system, 0x74, mask);
-	polaris_read_config_dword(&rx164_system, 0x74, &temp);
+	volatile unsigned int *irq_mask;
+
+	irq_mask = (void *)(POLARIS_DENSE_CONFIG_BASE + 0x74);
+	*irq_mask = mask;
+	mb();
+	*irq_mask;
 }
 
 static inline void
@@ -86,14 +85,14 @@ static struct hw_interrupt_type rx164_ir
 static void 
 rx164_device_interrupt(unsigned long vector, struct pt_regs *regs)
 {
-	unsigned int temp;
 	unsigned long pld;
+	volatile unsigned int *dirr;
 	long i;
 
 	/* Read the interrupt summary register.  On Polaris, this is
 	   the DIRR register in PCI config space (offset 0x84).  */
-	polaris_read_config_dword(&rx164_system, 0x84, &temp);
-	pld = temp;
+	dirr = (void *)(POLARIS_DENSE_CONFIG_BASE + 0x84);
+	pld = *dirr;
 
 	/*
 	 * Now for every possible bit set, work through them and call
--- 2.5.33/arch/alpha/kernel/core_t2.c	Tue Sep  3 01:12:18 2002
+++ linux/arch/alpha/kernel/core_t2.c	Fri Sep  6 12:23:45 2002
@@ -89,11 +89,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
 	     unsigned long *pci_addr, unsigned char *type1)
 {
 	unsigned long addr;
-	u8 bus = bus_dev->number;
+	u8 bus = pbus->number;
 
 	DBG(("mk_conf_addr(bus=%d, dfn=0x%x, where=0x%x,"
 	     " addr=0x%lx, type1=0x%x)\n",
@@ -248,20 +248,8 @@ t2_read_config(struct pci_bus *bus, unsi
 	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	switch (size) {
-	case 1:
-		mask = 0x00;
-		shift = (where & 3) * 8;
-		break;
-	case 2:
-		mask = 0x08;
-		shift = (where & 3) * 8;
-		break;
-	case 4:
-		mask = 0x18;
-		shift = 0;
-		break;
-	}
+	mask = (size - 1) * 8;
+	shift = (where & 3) * 8;
 	addr = (pci_addr << 5) + mask + T2_CONF;
 	*value = conf_read(addr, type1) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
@@ -275,20 +263,10 @@ t2_write_config(struct pci_bus *bus, uns
 	unsigned char type1;
 	long mask;
 
-	if (mk_conf_addr(dev, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	switch (size) {
-	case 1:
-		mask = 0x00;
-		break;
-	case 2:
-		mask = 0x08;
-		break;
-	case 4:
-		mask = 0x18;
-		break;
-	}
+	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + T2_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
 	return PCIBIOS_SUCCESSFUL;
--- 2.5.33/arch/alpha/kernel/core_polaris.c	Tue Sep  3 01:12:18 2002
+++ linux/arch/alpha/kernel/core_polaris.c	Fri Sep  6 12:23:45 2002
@@ -65,10 +65,10 @@
  */
 
 static int
-mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
 	     unsigned long *pci_addr, u8 *type1)
 {
-	u8 bus = bus_dev->number;
+	u8 bus = pbus->number;
 
 	*type1 = (bus == 0) ? 0 : 1;
 	*pci_addr = (bus << 16) | (device_fn << 8) | (where) |
@@ -85,13 +85,24 @@ static int
 polaris_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		    int size, u32 *value)
 {
-	unsigned long pci_addr;
+	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
                 return PCIBIOS_DEVICE_NOT_FOUND;
 
-	*value = __kernel_ldbu(*(vucp)pci_addr);
+	switch (size) {
+	case 1:
+		*value = __kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		*value = __kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*value = *(vuip)addr;
+		break;
+	}
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -100,15 +111,30 @@ static int 
 polaris_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		     int size, u32 value)
 {
-	unsigned long pci_addr;
+	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
                 return PCIBIOS_DEVICE_NOT_FOUND;
 
-        __kernel_stb(value, *(vucp)pci_addr);
-	mb();
-	__kernel_ldbu(*(vucp)pci_addr);
+	switch (size) {
+	case 1:
+		__kernel_stb(value, *(vucp)addr);
+		mb();
+		__kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		__kernel_stw(value, *(vusp)addr);
+		mb();
+		__kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*(vuip)addr = value;
+		mb();
+		*(vuip)addr;
+		break;
+	}
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
--- 2.5.33/arch/alpha/kernel/core_lca.c	Tue Sep  3 01:12:18 2002
+++ linux/arch/alpha/kernel/core_lca.c	Fri Sep  6 12:23:45 2002
@@ -99,11 +99,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
 	     unsigned long *pci_addr)
 {
 	unsigned long addr;
-	u8 bus = bus_dev->number;
+	u8 bus = pbus->number;
 
 	if (bus == 0) {
 		int device = device_fn >> 3;
@@ -204,32 +204,20 @@ lca_read_config(struct pci_bus *bus, uns
 {
 	unsigned long addr, pci_addr;
 	long mask;
-	int shift
+	int shift;
 
-	if (mk_conf_addr(bus, devfn, dev, where, &pci_addr))
+	if (mk_conf_addr(bus, devfn, where, &pci_addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	switch (size) {
-	case 1:
-		shift = (where & 3) * 8;
-		mask = 0x00;
-		break;
-	case 2:
-		shift = (where & 3) * 8;
-		mask = 0x08
-		break;
-	case 4:
-		shift = 0;
-		mask = 0x18
-		break;
-	}
+	shift = (where & 3) * 8;
+	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + LCA_CONF;
 	*value = conf_read(addr) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-lca_write_config(struct pci_bus *dev, unsigned int devfn, int where, int size,
+lca_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
 		 u32 value)
 {
 	unsigned long addr, pci_addr;
@@ -238,17 +226,7 @@ lca_write_config(struct pci_bus *dev, un
 	if (mk_conf_addr(bus, devfn, where, &pci_addr))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-		switch (size) {
-	case 1:
-		mask = 0x00;
-		break;
-	case 2:
-		mask = 0x08
-		break;
-	case 4:
-		mask = 0x18
-		break;
-	}
+	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + LCA_CONF;
 	conf_write(addr, value << ((where & 3) * 8));
 	return PCIBIOS_SUCCESSFUL;
--- 2.5.33/arch/alpha/kernel/core_irongate.c	Tue Sep  3 01:12:18 2002
+++ linux/arch/alpha/kernel/core_irongate.c	Fri Sep  6 12:23:45 2002
@@ -83,11 +83,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
 	     unsigned long *pci_addr, unsigned char *type1)
 {
 	unsigned long addr;
-	u8 bus = bus_dev->number;
+	u8 bus = pbus->number;
 
 	DBG_CFG(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x, "
 		 "pci_addr=0x%p, type1=0x%p)\n",
@@ -113,7 +113,18 @@ irongate_read_config(struct pci_bus *bus
 	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	*value = __kernel_ldbu(*(vucp)addr);
+	switch (size) {
+	case 1:
+		*value = __kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		*value = __kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*value = *(vuip)addr;
+		break;
+	}
+
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -127,12 +138,26 @@ irongate_write_config(struct pci_bus *bu
 	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	__kernel_stb(value, *(vucp)addr);
-	mb();
-	__kernel_ldbu(*(vucp)addr);
+	switch (size) {
+	case 1:
+		__kernel_stb(value, *(vucp)addr);
+		mb();
+		__kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		__kernel_stw(value, *(vusp)addr);
+		mb();
+		__kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*(vuip)addr = value;
+		mb();
+		*(vuip)addr;
+		break;
+	}
+
 	return PCIBIOS_SUCCESSFUL;
 }
-
 
 struct pci_ops irongate_pci_ops =
 {
--- 2.5.33/arch/alpha/kernel/core_cia.c	Tue Sep  3 01:12:18 2002
+++ linux/arch/alpha/kernel/core_cia.c	Fri Sep  6 12:23:45 2002
@@ -219,22 +219,9 @@ cia_read_config(struct pci_bus *bus, uns
 	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	switch (size) {
-	case 1:
-		mask = 0x00;
-		shift = (where & 3) * 8;
-		break;
-	case 2:
-		mask = 0x08;
-		shift = (where & 3) * 8;
-		break;
-	case 4:
-		mase = 0x18;
-		shift = 0;
-		break;
-	}
-
-	addr = (pci_addr << 5) + 0x18 + CIA_CONF;
+	mask = (size - 1) * 8;
+	shift = (where & 3) * 8;
+	addr = (pci_addr << 5) + mask + CIA_CONF;
 	*value = conf_read(addr, type1) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -250,18 +237,7 @@ cia_write_config(struct pci_bus *bus, un
 	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	switch (size) {
-	case 1:
-		mask = 0x00;
-		break;
-	case 2:
-		mask = 0x08;
-		break;
-	case 4:
-		mase = 0x18;
-		break;
-	}
-
+	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + CIA_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
 	return PCIBIOS_SUCCESSFUL;
--- 2.5.33/arch/alpha/kernel/core_apecs.c	Tue Sep  3 01:12:18 2002
+++ linux/arch/alpha/kernel/core_apecs.c	Fri Sep  6 12:23:45 2002
@@ -90,11 +90,11 @@
  */
 
 static int
-mk_conf_addr(struct pci_bus *bus_dev, unsigned int device_fn, int where,
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
 	     unsigned long *pci_addr, unsigned char *type1)
 {
 	unsigned long addr;
-	u8 bus = bus_dev->number;
+	u8 bus = pbus->number;
 
 	DBGC(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x,"
 	      " pci_addr=0x%p, type1=0x%p)\n",
@@ -272,8 +272,8 @@ conf_write(unsigned long addr, unsigned 
 }
 
 static int
-apecs_read_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
-		  u8 *value)
+apecs_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		  int size, u32 *value)
 {
 	unsigned long addr, pci_addr;
 	unsigned char type1;
@@ -283,27 +283,16 @@ apecs_read_config(struct pci_bus *bus, u
 	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-		switch (size) {
-	case 1:
-		mask = 0x00;
-		shift = (where & 3) * 8;
-		break;
-	case 2:
-		mask = 0x08;
-		shift = (where & 3) * 8;
-		break;
-	case 4:
-		mask = 0x18;
-		shift = 0;
-		break;
-	}
+	mask = (size - 1) * 8;
+	shift = (where & 3) * 8;
 	addr = (pci_addr << 5) + mask + APECS_CONF;
 	*value = conf_read(addr, type1) >> (shift);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int
-apecs_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
+apecs_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		   int size, u32 value)
 {
 	unsigned long addr, pci_addr;
 	unsigned char type1;
@@ -312,17 +301,7 @@ apecs_write_config(struct pci_bus *bus, 
 	if (mk_conf_addr(bus, devfn, where, &pci_addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	switch (size) {
-	case 1:
-		mask = 0x00;
-		break;
-	case 2:
-		mask = 0x08;
-		break;
-	case 4:
-		mask = 0x18;
-		break;
-	}
+	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + APECS_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
 	return PCIBIOS_SUCCESSFUL;
--- 2.5.33/arch/alpha/kernel/core_wildfire.c	Mon Mar 18 23:37:02 2002
+++ linux/arch/alpha/kernel/core_wildfire.c	Fri Sep  6 12:23:45 2002
@@ -357,19 +357,18 @@ wildfire_pci_tbi(struct pci_controller *
 }
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr,
-	     unsigned char *type1)
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, unsigned char *type1)
 {
-	struct pci_controller *hose = dev->sysdata;
+	struct pci_controller *hose = pbus->sysdata;
 	unsigned long addr;
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = pbus->number;
 
 	DBG_CFG(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x, "
 		 "pci_addr=0x%p, type1=0x%p)\n",
 		 bus, device_fn, where, pci_addr, type1));
 
-	if (hose->first_busno == dev->bus->number)
+	if (hose->first_busno == bus)
 		bus = 0;
 	*type1 = (bus != 0);
 
@@ -382,97 +381,65 @@ mk_conf_addr(struct pci_dev *dev, int wh
 }
 
 static int 
-wildfire_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+wildfire_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		     int size, u32 *value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	*value = __kernel_ldbu(*(vucp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-wildfire_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = __kernel_ldwu(*(vusp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
+	switch (size) {
+	case 1:
+		*value = __kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		*value = __kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*value = *(vuip)addr;
+		break;
+	}
 
-static int
-wildfire_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = *(vuip)addr;
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-wildfire_write_config_byte(struct pci_dev *dev, int where, u8 value)
+wildfire_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		      int size, u32 value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	__kernel_stb(value, *(vucp)addr);
-	mb();
-	__kernel_ldbu(*(vucp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-wildfire_write_config_word(struct pci_dev *dev, int where, u16 value)
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
-wildfire_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	switch (size) {
+	case 1:
+		__kernel_stb(value, *(vucp)addr);
+		mb();
+		__kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		__kernel_stw(value, *(vusp)addr);
+		mb();
+		__kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*(vuip)addr = value;
+		mb();
+		*(vuip)addr;
+		break;
+	}
 
-	*(vuip)addr = value;
-	mb();
-	*(vuip)addr;
 	return PCIBIOS_SUCCESSFUL;
 }
 
 struct pci_ops wildfire_pci_ops = 
 {
-	read_byte:	wildfire_read_config_byte,
-	read_word:	wildfire_read_config_word,
-	read_dword:	wildfire_read_config_dword,
-	write_byte:	wildfire_write_config_byte,
-	write_word:	wildfire_write_config_word,
-	write_dword:	wildfire_write_config_dword
+	.read =		wildfire_read_config,
+	.write =	wildfire_write_config,
 };
 
 #if DEBUG_DUMP_REGS
--- 2.5.33/arch/alpha/kernel/core_tsunami.c	Mon Mar 18 23:37:12 2002
+++ linux/arch/alpha/kernel/core_tsunami.c	Fri Sep  6 12:23:45 2002
@@ -89,19 +89,18 @@ static struct 
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr,
-	     unsigned char *type1)
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, unsigned char *type1)
 {
-	struct pci_controller *hose = dev->sysdata;
+	struct pci_controller *hose = pbus->sysdata;
 	unsigned long addr;
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = pbus->number;
 
 	DBG_CFG(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x, "
 		 "pci_addr=0x%p, type1=0x%p)\n",
 		 bus, device_fn, where, pci_addr, type1));
 
-	if (hose->first_busno == dev->bus->number)
+	if (hose->first_busno == bus)
 		bus = 0;
 	*type1 = (bus != 0);
 
@@ -114,97 +113,65 @@ mk_conf_addr(struct pci_dev *dev, int wh
 }
 
 static int 
-tsunami_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+tsunami_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		    int size, u32 *value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	*value = __kernel_ldbu(*(vucp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-tsunami_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = __kernel_ldwu(*(vusp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
+	switch (size) {
+	case 1:
+		*value = __kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		*value = __kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*value = *(vuip)addr;
+		break;
+	}
 
-static int
-tsunami_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = *(vuip)addr;
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-tsunami_write_config_byte(struct pci_dev *dev, int where, u8 value)
+tsunami_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		     int size, u32 value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	__kernel_stb(value, *(vucp)addr);
-	mb();
-	__kernel_ldbu(*(vucp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-tsunami_write_config_word(struct pci_dev *dev, int where, u16 value)
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
-tsunami_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	switch (size) {
+	case 1:
+		__kernel_stb(value, *(vucp)addr);
+		mb();
+		__kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		__kernel_stw(value, *(vusp)addr);
+		mb();
+		__kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*(vuip)addr = value;
+		mb();
+		*(vuip)addr;
+		break;
+	}
 
-	*(vuip)addr = value;
-	mb();
-	*(vuip)addr;
 	return PCIBIOS_SUCCESSFUL;
 }
 
 struct pci_ops tsunami_pci_ops = 
 {
-	read_byte:	tsunami_read_config_byte,
-	read_word:	tsunami_read_config_word,
-	read_dword:	tsunami_read_config_dword,
-	write_byte:	tsunami_write_config_byte,
-	write_word:	tsunami_write_config_word,
-	write_dword:	tsunami_write_config_dword
+	.read =		tsunami_read_config,
+	.write = 	tsunami_write_config,
 };
 
 void
--- 2.5.33/arch/alpha/kernel/core_titan.c	Mon Mar 18 23:37:09 2002
+++ linux/arch/alpha/kernel/core_titan.c	Fri Sep  6 12:23:45 2002
@@ -82,19 +82,18 @@ static struct
  */
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, unsigned long *pci_addr,
-	     unsigned char *type1)
+mk_conf_addr(struct pci_bus *pbus, unsigned int device_fn, int where,
+	     unsigned long *pci_addr, unsigned char *type1)
 {
-	struct pci_controller *hose = dev->sysdata;
+	struct pci_controller *hose = pbus->sysdata;
 	unsigned long addr;
-	u8 bus = dev->bus->number;
-	u8 device_fn = dev->devfn;
+	u8 bus = pbus->number;
 
 	DBG_CFG(("mk_conf_addr(bus=%d ,device_fn=0x%x, where=0x%x, "
 		 "pci_addr=0x%p, type1=0x%p)\n",
 		 bus, device_fn, where, pci_addr, type1));
 
-        if (hose->first_busno == dev->bus->number)
+        if (hose->first_busno == bus)
 		bus = 0;
         *type1 = (bus != 0);
 
@@ -106,98 +105,66 @@ mk_conf_addr(struct pci_dev *dev, int wh
 	return 0;
 }
 
-static int 
-titan_read_config_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = __kernel_ldbu(*(vucp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-titan_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*value = __kernel_ldwu(*(vusp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
 static int
-titan_read_config_dword(struct pci_dev *dev, int where, u32 *value)
+titan_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		  int size, u32 *value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	*value = *(vuip)addr;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int 
-titan_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	switch (size) {
+	case 1:
+		*value = __kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		*value = __kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*value = *(vuip)addr;
+		break;
+	}
 
-	__kernel_stb(value, *(vucp)addr);
-	mb();
-	__kernel_ldbu(*(vucp)addr);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-titan_write_config_word(struct pci_dev *dev, int where, u16 value)
+titan_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		   int size, u32 value)
 {
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	__kernel_stw(value, *(vusp)addr);
-	mb();
-	__kernel_ldwu(*(vusp)addr);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-titan_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	switch (size) {
+	case 1:
+		__kernel_stb(value, *(vucp)addr);
+		mb();
+		__kernel_ldbu(*(vucp)addr);
+		break;
+	case 2:
+		__kernel_stw(value, *(vusp)addr);
+		mb();
+		__kernel_ldwu(*(vusp)addr);
+		break;
+	case 4:
+		*(vuip)addr = value;
+		mb();
+		*(vuip)addr;
+		break;
+	}
 
-	*(vuip)addr = value;
-	mb();
-	*(vuip)addr;
 	return PCIBIOS_SUCCESSFUL;
 }
 
 struct pci_ops titan_pci_ops = 
 {
-	read_byte:	titan_read_config_byte,
-	read_word:	titan_read_config_word,
-	read_dword:	titan_read_config_dword,
-	write_byte:	titan_write_config_byte,
-	write_word:	titan_write_config_word,
-	write_dword:	titan_write_config_dword
+	.read =		titan_read_config,
+	.write =	titan_write_config,
 };
 
 
--- 2.5.33/arch/alpha/kernel/core_mcpcia.c	Mon Aug  5 00:56:40 2002
+++ linux/arch/alpha/kernel/core_mcpcia.c	Fri Sep  6 12:36:45 2002
@@ -171,11 +171,11 @@ conf_write(unsigned long addr, unsigned 
 }
 
 static int
-mk_conf_addr(struct pci_dev *dev, int where, struct pci_controller *hose,
-	     unsigned long *pci_addr, unsigned char *type1)
+mk_conf_addr(struct pci_bus *pbus, unsigned int devfn, int where,
+	     struct pci_controller *hose, unsigned long *pci_addr,
+	     unsigned char *type1)
 {
-	u8 bus = dev->bus->number;
-	u8 devfn = dev->devfn;
+	u8 bus = pbus->number;
 	unsigned long addr;
 
 	DBG_CFG(("mk_conf_addr(bus=%d,devfn=0x%x,hose=%d,where=0x%x,"
@@ -185,7 +185,7 @@ mk_conf_addr(struct pci_dev *dev, int wh
 	/* Type 1 configuration cycle for *ALL* busses.  */
 	*type1 = 1;
 
-	if (dev->bus->number == hose->first_busno)
+	if (bus == hose->first_busno)
 		bus = 0;
 	addr = (bus << 16) | (devfn << 8) | (where);
 	addr <<= 5; /* swizzle for SPARSE */
@@ -197,94 +197,53 @@ mk_conf_addr(struct pci_dev *dev, int wh
 }
 
 static int
-mcpcia_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+mcpcia_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		   int size, u32 *value)
 {
-	struct pci_controller *hose = dev->sysdata;
+	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr, w;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, hose, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, hose, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	addr |= 0x00;
+	addr |= (size - 1) * 8;
 	w = conf_read(addr, type1, hose);
-	*value = __kernel_extbl(w, where & 3);
+	switch (size) {
+	case 1:
+		*value = __kernel_extbl(w, where & 3);
+		break;
+	case 2:
+		*value = __kernel_extwl(w, where & 3);
+		break;
+	case 4:
+		*value = w;
+		break;
+	}
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int
-mcpcia_read_config_word(struct pci_dev *dev, int where, u16 *value)
+mcpcia_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		    int size, u32 value)
 {
-	struct pci_controller *hose = dev->sysdata;
-	unsigned long addr, w;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, hose, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr |= 0x08;
-	w = conf_read(addr, type1, hose);
-	*value = __kernel_extwl(w, where & 3);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-mcpcia_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	struct pci_controller *hose = dev->sysdata;
+	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr;
 	unsigned char type1;
 
-	if (mk_conf_addr(dev, where, hose, &addr, &type1))
+	if (mk_conf_addr(bus, devfn, where, hose, &addr, &type1))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	addr |= 0x18;
-	*value = conf_read(addr, type1, hose);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-mcpcia_write_config(struct pci_dev *dev, int where, u32 value, long mask)
-{
-	struct pci_controller *hose = dev->sysdata;
-	unsigned long addr;
-	unsigned char type1;
-
-	if (mk_conf_addr(dev, where, hose, &addr, &type1))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	addr |= mask;
+	addr |= (size - 1) * 8;
 	value = __kernel_insql(value, where & 3);
 	conf_write(addr, value, type1, hose);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int
-mcpcia_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	return mcpcia_write_config(dev, where, value, 0x00);
-}
-
-static int
-mcpcia_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	return mcpcia_write_config(dev, where, value, 0x08);
-}
-
-static int
-mcpcia_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	return mcpcia_write_config(dev, where, value, 0x18);
-}
-
 struct pci_ops mcpcia_pci_ops = 
 {
-	read_byte:	mcpcia_read_config_byte,
-	read_word:	mcpcia_read_config_word,
-	read_dword:	mcpcia_read_config_dword,
-	write_byte:	mcpcia_write_config_byte,
-	write_word:	mcpcia_write_config_word,
-	write_dword:	mcpcia_write_config_dword
+	.read =		mcpcia_read_config,
+	.write =	mcpcia_write_config,
 };
 
 void
