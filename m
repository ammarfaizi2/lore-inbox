Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283428AbRK2WrA>; Thu, 29 Nov 2001 17:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283426AbRK2Wqn>; Thu, 29 Nov 2001 17:46:43 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18873 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283428AbRK2Wqh>; Thu, 29 Nov 2001 17:46:37 -0500
Date: Thu, 29 Nov 2001 14:46:12 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [RFC] Patch to enable PCI buses on all nodes of NUMA-Q
Message-ID: <2022825105.1007045172@mbligh.des.sequent.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments / review would be much appreciated. I intend to submit this
in a few days, if there are no objections.

Thanks,

Martin J. Bligh

---------------------


diff -urN virgin-2.4.16/arch/i386/kernel/mpparse.c linux-2.4.16-pci/arch/i386/kernel/mpparse.c
--- virgin-2.4.16/arch/i386/kernel/mpparse.c	Fri Nov  9 14:58:18 2001
+++ linux-2.4.16-pci/arch/i386/kernel/mpparse.c	Thu Nov 29 11:27:36 2001
@@ -37,6 +37,8 @@
 int apic_version [MAX_APICS];
 int mp_bus_id_to_type [MAX_MP_BUSSES];
 int mp_bus_id_to_node [MAX_MP_BUSSES];
+int mp_bus_id_to_local [MAX_MP_BUSSES];
+int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_current_pci_id;
 
@@ -241,13 +243,17 @@
 static void __init MP_bus_info (struct mpc_config_bus *m)
 {
 	char str[7];
+	int quad;
 
 	memcpy(str, m->mpc_bustype, 6);
 	str[6] = 0;
 	
 	if (clustered_apic_mode) {
-		mp_bus_id_to_node[m->mpc_busid] = translation_table[mpc_record]->trans_quad;
-		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, mp_bus_id_to_node[m->mpc_busid]);
+		quad = translation_table[mpc_record]->trans_quad;
+		mp_bus_id_to_node[m->mpc_busid] = quad;
+		mp_bus_id_to_local[m->mpc_busid] = translation_table[mpc_record]->trans_local;
+		quad_local_to_mp_bus_id[quad][translation_table[mpc_record]->trans_local] = m->mpc_busid;
+		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, quad);
 	} else {
 		Dprintk("Bus #%d is %s\n", m->mpc_busid, str);
 	}
@@ -324,13 +330,14 @@
 
 static void __init MP_translation_info (struct mpc_config_translation *m)
 {
-	printk("Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, 
-		m->trans_quad, m->trans_global, m->trans_local);
+	printk("Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
 
 	if (mpc_record >= MAX_MPC_ENTRY) 
 		printk("MAX_MPC_ENTRY exceeded!\n");
 	else
 		translation_table[mpc_record] = m; /* stash this for later */
+	if (m->trans_quad+1 > numnodes)
+		numnodes = m->trans_quad+1;
 }
 
 /*
@@ -494,10 +501,6 @@
 			}
 		}
 		++mpc_record;
-	}
-	if (clustered_apic_mode && nr_ioapics > 2) {
-		/* don't initialise IO apics on secondary quads */
-		nr_ioapics = 2;
 	}
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
diff -urN virgin-2.4.16/arch/i386/kernel/pci-pc.c linux-2.4.16-pci/arch/i386/kernel/pci-pc.c
--- virgin-2.4.16/arch/i386/kernel/pci-pc.c	Fri Nov  9 13:58:02 2001
+++ linux-2.4.16-pci/arch/i386/kernel/pci-pc.c	Thu Nov 29 12:30:10 2001
@@ -26,6 +26,16 @@
 int (*pci_config_read)(int seg, int bus, int dev, int fn, int reg, int len, u32 *value) = NULL;
 int (*pci_config_write)(int seg, int bus, int dev, int fn, int reg, int len, u32 value) = NULL;
 
+#ifdef CONFIG_MULTIQUAD
+#define BUS2QUAD(global) (mp_bus_id_to_node[global])
+#define BUS2LOCAL(global) (mp_bus_id_to_local[global])
+#define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
+#else
+#define BUS2QUAD(global) (0)
+#define BUS2LOCAL(global) (global)
+#define QUADLOCAL2BUS(quad,local) (local)
+#endif
+
 /*
  * This interrupt-safe spinlock protects all accesses to PCI
  * configuration space.
@@ -39,10 +49,71 @@
 
 #ifdef CONFIG_PCI_DIRECT
 
+#ifdef CONFIG_MULTIQUAD
+#define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
+	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+
+static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value) /* CONFIG_MULTIQUAD */
+{
+	unsigned long flags;
+
+	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+		return -EINVAL;
+
+	spin_lock_irqsave(&pci_config_lock, flags);
+
+	outl_quad(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+
+	switch (len) {
+	case 1:
+		*value = inb_quad(0xCFC + (reg & 3), BUS2QUAD(bus));
+		break;
+	case 2:
+		*value = inw_quad(0xCFC + (reg & 2), BUS2QUAD(bus));
+		break;
+	case 4:
+		*value = inl_quad(0xCFC, BUS2QUAD(bus));
+		break;
+	}
+
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	return 0;
+}
+
+static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value) /* CONFIG_MULTIQUAD */
+{
+	unsigned long flags;
+
+	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+		return -EINVAL;
+
+	spin_lock_irqsave(&pci_config_lock, flags);
+
+	outl_quad(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+
+	switch (len) {
+	case 1:
+		outb_quad((u8)value, 0xCFC + (reg & 3), BUS2QUAD(bus));
+		break;
+	case 2:
+		outw_quad((u16)value, 0xCFC + (reg & 2), BUS2QUAD(bus));
+		break;
+	case 4:
+		outl_quad((u32)value, 0xCFC, BUS2QUAD(bus));
+		break;
+	}
+
+	spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	return 0;
+}
+
+#else /* !CONFIG_MULTIQUAD */
 #define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value) /* !CONFIG_MULTIQUAD */
 {
 	unsigned long flags;
 
@@ -70,7 +141,7 @@
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value) /* !CONFIG_MULTIQUAD */
 {
 	unsigned long flags;
 
@@ -98,6 +169,8 @@
 	return 0;
 }
 
+#endif /* CONFIG_MULTIQUAD */
+
 #undef PCI_CONF1_ADDRESS
 
 static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
@@ -1017,6 +1090,8 @@
 	 */
 	int pxb, reg;
 	u8 busno, suba, subb;
+	int quad = BUS2QUAD(d->bus->number);
+
 	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
 	reg = 0xd0;
 	for(pxb=0; pxb<2; pxb++) {
@@ -1025,9 +1100,9 @@
 		pci_read_config_byte(d, reg++, &subb);
 		DBG("i450NX PXB %d: %02x/%02x/%02x\n", pxb, busno, suba, subb);
 		if (busno)
-			pci_scan_bus(busno, pci_root_ops, NULL);	/* Bus A */
+			pci_scan_bus(QUADLOCAL2BUS(quad,busno), pci_root_ops, NULL);	/* Bus A */
 		if (suba < subb)
-			pci_scan_bus(suba+1, pci_root_ops, NULL);	/* Bus B */
+			pci_scan_bus(QUADLOCAL2BUS(quad,suba+1), pci_root_ops, NULL);	/* Bus B */
 	}
 	pcibios_last_bus = -1;
 }
@@ -1189,6 +1264,8 @@
 
 void __init pcibios_init(void)
 {
+	int quad;
+
 	if (!pci_root_ops)
 		pcibios_config_init();
 	if (!pci_root_ops) {
@@ -1198,6 +1275,14 @@
 
 	printk("PCI: Probing PCI hardware\n");
 	pci_root_bus = pci_scan_bus(0, pci_root_ops, NULL);
+	if (clustered_apic_mode && (numnodes > 1)) {
+		for (quad = 1; quad < numnodes; ++quad) {
+			printk("Scanning PCI bus %d for quad %d\n", 
+				quad_local_to_mp_bus_id[quad][0], quad);
+			pci_scan_bus(quad_local_to_mp_bus_id[quad][0], 
+				pci_root_ops, NULL);
+		}
+	}
 
 	pcibios_irq_init();
 	pcibios_fixup_peer_bridges();
diff -urN virgin-2.4.16/arch/i386/kernel/smpboot.c linux-2.4.16-pci/arch/i386/kernel/smpboot.c
--- virgin-2.4.16/arch/i386/kernel/smpboot.c	Wed Nov 21 10:35:48 2001
+++ linux-2.4.16-pci/arch/i386/kernel/smpboot.c	Thu Nov 29 11:27:36 2001
@@ -975,11 +975,14 @@
 {
 	int apicid, cpu, bit;
 
-        if (clustered_apic_mode) {
-                /* remap the 1st quad's 256k range for cross-quad I/O */
-                xquad_portio = ioremap (XQUAD_PORTIO_BASE, XQUAD_PORTIO_LEN);
-                printk("Cross quad port I/O vaddr 0x%08lx, len %08lx\n",
-                        (u_long) xquad_portio, (u_long) XQUAD_PORTIO_LEN);
+        if (clustered_apic_mode && (numnodes > 1)) {
+                printk("Remapping cross-quad port I/O for %d quads\n",
+			numnodes);
+                printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
+                        (u_long) xquad_portio, 
+			(u_long) numnodes * XQUAD_PORTIO_LEN);
+                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
+			numnodes * XQUAD_PORTIO_LEN);
         }
 
 #ifdef CONFIG_MTRR
diff -urN virgin-2.4.16/include/asm-i386/io.h linux-2.4.16-pci/include/asm-i386/io.h
--- virgin-2.4.16/include/asm-i386/io.h	Thu Nov 22 11:46:27 2001
+++ linux-2.4.16-pci/include/asm-i386/io.h	Thu Nov 29 11:27:36 2001
@@ -39,7 +39,8 @@
 #define IO_SPACE_LIMIT 0xffff
 
 #define XQUAD_PORTIO_BASE 0xfe400000
-#define XQUAD_PORTIO_LEN  0x40000   /* 256k per quad. Only remapping 1st */
+#define XQUAD_PORTIO_QUAD 0x40000  /* 256k per quad. */
+#define XQUAD_PORTIO_LEN  0x80000  /* Only remapping first 2 quads */
 
 #ifdef __KERNEL__
 
@@ -247,52 +248,65 @@
 __asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
 
 #ifdef CONFIG_MULTIQUAD
-/* Make the default portio routines operate on quad 0 for now */
-#define __OUT(s,s1,x) \
-__OUT1(s##_local,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
-__OUT1(s##_p_local,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
-__OUTQ0(s,s,x) \
-__OUTQ0(s,s##_p,x) 
-#else
-#define __OUT(s,s1,x) \
-__OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
-__OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} 
-#endif /* CONFIG_MULTIQUAD */
-
-#ifdef CONFIG_MULTIQUAD
-#define __OUTQ0(s,ss,x)    /* Do the equivalent of the portio op on quad 0 */ \
+#define __OUTQ(s,ss,x)    /* Do the equivalent of the portio op on quads */ \
 static inline void out##ss(unsigned x value, unsigned short port) { \
 	if (xquad_portio) \
 		write##s(value, (unsigned long) xquad_portio + port); \
 	else               /* We're still in early boot, running on quad 0 */ \
 		out##ss##_local(value, port); \
-} 
+} \
+static inline void out##ss##_quad(unsigned x value, unsigned short port, int quad) { \
+	if (xquad_portio) \
+		write##s(value, (unsigned long) xquad_portio + (XQUAD_PORTIO_QUAD*quad)\
+			+ port); \
+}
 
-#define __INQ0(s,ss)       /* Do the equivalent of the portio op on quad 0 */ \
+#define __INQ(s,ss)       /* Do the equivalent of the portio op on quads */ \
 static inline RETURN_TYPE in##ss(unsigned short port) { \
 	if (xquad_portio) \
 		return read##s((unsigned long) xquad_portio + port); \
 	else               /* We're still in early boot, running on quad 0 */ \
 		return in##ss##_local(port); \
+} \
+static inline RETURN_TYPE in##ss##_quad(unsigned short port, int quad) { \
+	if (xquad_portio) \
+		return read##s((unsigned long) xquad_portio + (XQUAD_PORTIO_QUAD*quad)\
+			+ port); \
+	else\
+		return 0;\
 }
 #endif /* CONFIG_MULTIQUAD */
 
+#ifndef CONFIG_MULTIQUAD
+#define __OUT(s,s1,x) \
+__OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
+__OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} 
+#else
+/* Make the default portio routines operate on quad 0 */
+#define __OUT(s,s1,x) \
+__OUT1(s##_local,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
+__OUT1(s##_p_local,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
+__OUTQ(s,s,x) \
+__OUTQ(s,s##_p,x) 
+#endif /* CONFIG_MULTIQUAD */
+
 #define __IN1(s) \
 static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
 
 #define __IN2(s,s1,s2) \
 __asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
 
-#ifdef CONFIG_MULTIQUAD
-#define __IN(s,s1,i...) \
-__IN1(s##_local) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-__IN1(s##_p_local) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-__INQ0(s,s) \
-__INQ0(s,s##_p) 
-#else
+#ifndef CONFIG_MULTIQUAD
 #define __IN(s,s1,i...) \
 __IN1(s) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
 __IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } 
+#else
+/* Make the default portio routines operate on quad 0 */
+#define __IN(s,s1,i...) \
+__IN1(s##_local) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
+__IN1(s##_p_local) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
+__INQ(s,s) \
+__INQ(s,s##_p) 
 #endif /* CONFIG_MULTIQUAD */
 
 #define __INS(s) \
diff -urN virgin-2.4.16/include/asm-i386/mpspec.h linux-2.4.16-pci/include/asm-i386/mpspec.h
--- virgin-2.4.16/include/asm-i386/mpspec.h	Thu Nov 22 11:46:18 2001
+++ linux-2.4.16-pci/include/asm-i386/mpspec.h	Thu Nov 29 11:27:36 2001
@@ -198,6 +198,9 @@
 	MP_BUS_MCA
 };
 extern int mp_bus_id_to_type [MAX_MP_BUSSES];
+extern int mp_bus_id_to_node [MAX_MP_BUSSES];
+extern int mp_bus_id_to_local [MAX_MP_BUSSES];
+extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;

