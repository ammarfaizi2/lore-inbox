Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131092AbRBHLnB>; Thu, 8 Feb 2001 06:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRBHLml>; Thu, 8 Feb 2001 06:42:41 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:9989 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S131074AbRBHLmj>; Thu, 8 Feb 2001 06:42:39 -0500
Date: Thu, 8 Feb 2001 14:41:19 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Richard Henderson <rth@twiddle.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [patch] ruffian IRQs, OSF syscalls dedugging fixes
Message-ID: <20010208144119.A2998@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

- Don't trust IRQs assigned by ARC console on ruffian any more;
  use interrupt routing table provided by <kelvin@qantel.com> instead.
  This fixes cards reporting bogus interrupt pin (ES1969).
- Disable debugging messages for OSF syscalls as potential source of
  DoS attack. Besides, the same info can be obtained with `strace'.

Patches for 2.2 and 2.4 attached.

Ivan.


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ruffian-2.2.patch"

--- 2.2.18/arch/alpha/kernel/osf_sys.c	Thu May  4 04:16:30 2000
+++ linux/arch/alpha/kernel/osf_sys.c	Mon Feb  5 13:57:18 2001
@@ -78,8 +78,10 @@ asmlinkage int osf_set_program_attribute
 	mm = current->mm;
 	mm->end_code = bss_start + bss_len;
 	mm->brk = bss_start + bss_len;
+#if 0
 	printk("set_program_attributes(%lx %lx %lx %lx)\n",
 		text_start, text_len, bss_start, bss_len);
+#endif
 	unlock_kernel();
 	return 0;
 }
--- 2.2.18/arch/alpha/kernel/traps.c	Thu Jun  8 01:26:42 2000
+++ linux/arch/alpha/kernel/traps.c	Mon Feb  5 13:59:10 2001
@@ -1086,7 +1086,9 @@ alpha_ni_syscall(unsigned long a0, unsig
 {
 	/* We only get here for OSF system calls, minus #112;
 	   the rest go to sys_ni_syscall.  */
+#if 0
 	printk("<sc %ld(%lx,%lx,%lx)>", regs.r0, a0, a1, a2);
+#endif
 	return -ENOSYS;
 }
 
--- 2.2.18/arch/alpha/kernel/sys_ruffian.c	Sun Jan 10 06:08:27 1999
+++ linux/arch/alpha/kernel/sys_ruffian.c	Mon Feb  5 14:25:10 2001
@@ -163,16 +163,91 @@ ruffian_init_irq(void)
 	enable_irq(2);		/* enable 2nd PIC cascade */
 }
 
+/*
+ *  Interrupt routing:
+ *
+ *		Primary bus
+ *	  IdSel		INTA	INTB	INTC	INTD
+ * 21052   13		  -	  -	  -	  -
+ * SIO	   14		 23	  -	  -	  -
+ * 21143   15		 44	  -	  -	  -
+ * Slot 0  17		 43	 42	 41	 40
+ *
+ *		Secondary bus
+ *	  IdSel		INTA	INTB	INTC	INTD
+ * Slot 0   8 (18)	 19	 18	 17	 16
+ * Slot 1   9 (19)	 31	 30	 29	 28
+ * Slot 2  10 (20)	 27	 26	 25	 24
+ * Slot 3  11 (21)	 39	 38	 37	 36
+ * Slot 4  12 (22)	 35	 34	 33	 32
+ * 53c875  13 (23)	 20	  -	  -	  -
+ *
+ */
+
+static int __init
+ruffian_map_irq(struct pci_dev *dev, int slot, int pin)
+{
+        static char irq_tab[11][5] __initdata = {
+	      /*INT  INTA INTB INTC INTD */
+		{-1,  -1,  -1,  -1,  -1},  /* IdSel 13,  21052	     */
+		{-1,  -1,  -1,  -1,  -1},  /* IdSel 14,  SIO	     */
+		{44,  44,  44,  44,  44},  /* IdSel 15,  21143	     */
+		{-1,  -1,  -1,  -1,  -1},  /* IdSel 16,  none	     */
+		{43,  43,  42,  41,  40},  /* IdSel 17,  64-bit slot */
+		/* the next 6 are actually on PCI bus 1, across the bridge */
+		{19,  19,  18,  17,  16},  /* IdSel  8,  slot 0	     */
+		{31,  31,  30,  29,  28},  /* IdSel  9,  slot 1	     */
+		{27,  27,  26,  25,  24},  /* IdSel 10,  slot 2	     */
+		{39,  39,  38,  37,  36},  /* IdSel 11,  slot 3	     */
+		{35,  35,  34,  33,  32},  /* IdSel 12,  slot 4	     */
+		{20,  20,  20,  20,  20},  /* IdSel 13,  53c875	     */
+        };
+	const long min_idsel = 13, max_idsel = 23, irqs_per_slot = 5;
+	return COMMON_TABLE_LOOKUP;
+}
+
+static int __init
+ruffian_swizzle(struct pci_dev *dev, int *pinp)
+{
+	int slot, pin = *pinp;
+
+	if (dev->bus->number == 0) {
+		slot = PCI_SLOT(dev->devfn);
+	}		
+	/* Check for the built-in bridge.  */
+	else if (PCI_SLOT(dev->bus->self->devfn) == 13) {
+		slot = PCI_SLOT(dev->devfn) + 10;
+	}
+	else 
+	{
+		/* Must be a card-based bridge.  */
+		do {
+			if (PCI_SLOT(dev->bus->self->devfn) == 13) {
+				slot = PCI_SLOT(dev->devfn) + 10;
+				break;
+			}
+			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+
+			/* Move up the chain of bridges.  */
+			dev = dev->bus->self;
+			/* Slot of the next bridge.  */
+			slot = PCI_SLOT(dev->devfn);
+		} while (dev->bus->self);
+	}
+	*pinp = pin;
+	return slot;
+}
 
 /*
  * For RUFFIAN, we do not want to make any modifications to the PCI
- * setup.  But we may need to do some kind of init.
+ * setup, except IRQ assignment.  But we may need to do some kind of init.
  */
 
 static void __init
 ruffian_pci_fixup(void)
 {
 	/* layout_all_busses(DEFAULT_IO_BASE, DEFAULT_MEM_BASE); */
+	common_pci_fixup(ruffian_map_irq, ruffian_swizzle);
 }
 
 

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ruffian-2.4.patch"

diff -ur 2.4.1/arch/alpha/kernel/osf_sys.c linux/arch/alpha/kernel/osf_sys.c
--- 2.4.1/arch/alpha/kernel/osf_sys.c	Thu Jul  6 17:51:26 2000
+++ linux/arch/alpha/kernel/osf_sys.c	Thu Jul  6 11:58:55 2000
@@ -74,8 +74,10 @@
 	mm = current->mm;
 	mm->end_code = bss_start + bss_len;
 	mm->brk = bss_start + bss_len;
+#if 0
 	printk("set_program_attributes(%lx %lx %lx %lx)\n",
 		text_start, text_len, bss_start, bss_len);
+#endif
 	unlock_kernel();
 	return 0;
 }
diff -ur 2.4.1/arch/alpha/kernel/traps.c linux/arch/alpha/kernel/traps.c
--- 2.4.1/arch/alpha/kernel/traps.c	Tue Jun 20 04:59:33 2000
+++ linux/arch/alpha/kernel/traps.c	Thu Jul  6 11:58:55 2000
@@ -1093,7 +1093,9 @@
 {
 	/* We only get here for OSF system calls, minus #112;
 	   the rest go to sys_ni_syscall.  */
+#if 0
 	printk("<sc %ld(%lx,%lx,%lx)>", regs.r0, a0, a1, a2);
+#endif
 	return -ENOSYS;
 }
 
diff -ur 2.4.1/arch/alpha/kernel/sys_ruffian.c linux/arch/alpha/kernel/sys_ruffian.c
--- 2.4.1/arch/alpha/kernel/sys_ruffian.c	Tue Nov 28 04:50:12 2000
+++ linux/arch/alpha/kernel/sys_ruffian.c	Mon Feb  5 13:43:37 2001
@@ -92,14 +92,80 @@
 #endif
 }
 
+/*
+ *  Interrupt routing:
+ *
+ *		Primary bus
+ *	  IdSel		INTA	INTB	INTC	INTD
+ * 21052   13		  -	  -	  -	  -
+ * SIO	   14		 23	  -	  -	  -
+ * 21143   15		 44	  -	  -	  -
+ * Slot 0  17		 43	 42	 41	 40
+ *
+ *		Secondary bus
+ *	  IdSel		INTA	INTB	INTC	INTD
+ * Slot 0   8 (18)	 19	 18	 17	 16
+ * Slot 1   9 (19)	 31	 30	 29	 28
+ * Slot 2  10 (20)	 27	 26	 25	 24
+ * Slot 3  11 (21)	 39	 38	 37	 36
+ * Slot 4  12 (22)	 35	 34	 33	 32
+ * 53c875  13 (23)	 20	  -	  -	  -
+ *
+ */
+
 static int __init
 ruffian_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	/* We don't know anything about the PCI routing, so leave
-	   the IRQ unchanged.  */
-	return dev->irq;
+        static char irq_tab[11][5] __initdata = {
+	      /*INT  INTA INTB INTC INTD */
+		{-1,  -1,  -1,  -1,  -1},  /* IdSel 13,  21052	     */
+		{-1,  -1,  -1,  -1,  -1},  /* IdSel 14,  SIO	     */
+		{44,  44,  44,  44,  44},  /* IdSel 15,  21143	     */
+		{-1,  -1,  -1,  -1,  -1},  /* IdSel 16,  none	     */
+		{43,  43,  42,  41,  40},  /* IdSel 17,  64-bit slot */
+		/* the next 6 are actually on PCI bus 1, across the bridge */
+		{19,  19,  18,  17,  16},  /* IdSel  8,  slot 0	     */
+		{31,  31,  30,  29,  28},  /* IdSel  9,  slot 1	     */
+		{27,  27,  26,  25,  24},  /* IdSel 10,  slot 2	     */
+		{39,  39,  38,  37,  36},  /* IdSel 11,  slot 3	     */
+		{35,  35,  34,  33,  32},  /* IdSel 12,  slot 4	     */
+		{20,  20,  20,  20,  20},  /* IdSel 13,  53c875	     */
+        };
+	const long min_idsel = 13, max_idsel = 23, irqs_per_slot = 5;
+	return COMMON_TABLE_LOOKUP;
 }
 
+static u8 __init
+ruffian_swizzle(struct pci_dev *dev, u8 *pinp)
+{
+	int slot, pin = *pinp;
+
+	if (dev->bus->number == 0) {
+		slot = PCI_SLOT(dev->devfn);
+	}		
+	/* Check for the built-in bridge.  */
+	else if (PCI_SLOT(dev->bus->self->devfn) == 13) {
+		slot = PCI_SLOT(dev->devfn) + 10;
+	}
+	else 
+	{
+		/* Must be a card-based bridge.  */
+		do {
+			if (PCI_SLOT(dev->bus->self->devfn) == 13) {
+				slot = PCI_SLOT(dev->devfn) + 10;
+				break;
+			}
+			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+
+			/* Move up the chain of bridges.  */
+			dev = dev->bus->self;
+			/* Slot of the next bridge.  */
+			slot = PCI_SLOT(dev->devfn);
+		} while (dev->bus->self);
+	}
+	*pinp = pin;
+	return slot;
+}
 
 #ifdef BUILDING_FOR_MILO
 /*
@@ -164,6 +230,6 @@
 	init_pci:		cia_init_pci,
 	kill_arch:		ruffian_kill_arch,
 	pci_map_irq:		ruffian_map_irq,
-	pci_swizzle:		common_swizzle,
+	pci_swizzle:		ruffian_swizzle,
 };
 ALIAS_MV(ruffian)

--YiEDa0DAkWCtVeE4--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
