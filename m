Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbQKVLQQ>; Wed, 22 Nov 2000 06:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130987AbQKVLQH>; Wed, 22 Nov 2000 06:16:07 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:21750 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130607AbQKVLP5>;
	Wed, 22 Nov 2000 06:15:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A1AC075.4020506@cs.york.ac.uk> 
In-Reply-To: <3A1AC075.4020506@cs.york.ac.uk> 
To: Michel Salim <mas118@cs.york.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, dhinds@valinux.com
Subject: Re: i82365 PCI-PCMCIA bridge still not working in 2.4.0-test11 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 10:45:23 +0000
Message-ID: <4186.974889923@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mas118@cs.york.ac.uk said:
>  Installed kernel 2.4.0-test11 on my Debian Woody box today. Had no
> problem apart from getting PCMCIA to work. I have a PCI-PCMCIA adapter
>  on my desktop PC, using the Cirrus Logic CL6729 chipset;

Linus got a bit carried away when stripping out all the CardBus support 
from i82365, and took out the support for PCI-PCMCIA bridges too.

Try this snapshot of my development tree, or use lspci to find the IO 
address of the device and specify that to the existing module.

Index: drivers/pcmcia/cirrus.h
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/cirrus.h,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 cirrus.h
--- drivers/pcmcia/cirrus.h	2000/06/07 10:38:28	1.1.2.2
+++ drivers/pcmcia/cirrus.h	2000/11/22 10:37:31
@@ -48,6 +48,11 @@
 #define PD67_EXT_INDEX		0x2e	/* Extension index */
 #define PD67_EXT_DATA		0x2f	/* Extension data */
 
+#define pd67_ext_get(s, r) \
+    (i365_set(s, PD67_EXT_INDEX, r), i365_get(s, PD67_EXT_DATA))
+#define pd67_ext_set(s, r, v) \
+    (i365_set(s, PD67_EXT_INDEX, r), i365_set(s, PD67_EXT_DATA, v))
+
 /* PD6722 extension registers -- indexed in PD67_EXT_INDEX */
 #define PD67_DATA_MASK0		0x01	/* Data mask 0 */
 #define PD67_DATA_MASK1		0x02	/* Data mask 1 */
@@ -119,6 +124,10 @@
 #define PD67_EC1_INV_CARD_IRQ	0x08
 #define PD67_EC1_INV_MGMT_IRQ	0x10
 #define PD67_EC1_PULLUP_CTL	0x20
+
+/* Fields in PD67_EXTERN_DATA */
+#define PD67_EXD_VS1(s)         (0x01 << ((s)<<1))
+#define PD67_EXD_VS2(s)         (0x02 << ((s)<<1))
 
 /* Fields in PD67_MISC_CTL_3 */
 #define PD67_MC3_IRQ_MASK	0x03
Index: drivers/pcmcia/cs.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/cs.c,v
retrieving revision 1.1.2.28
diff -u -r1.1.2.28 cs.c
--- drivers/pcmcia/cs.c	2000/11/10 14:56:32	1.1.2.28
+++ drivers/pcmcia/cs.c	2000/11/22 10:37:33
@@ -416,12 +416,10 @@
 {
     int i;
 
-    for (i = 0; i < sockets; i++) {
+    for (i = sockets-1; i >= 0; i-- ) {
 	socket_info_t *socket = socket_table[i];
 	if (socket->ss_entry == ss_entry)
-	    pcmcia_unregister_socket (socket);
-	else
-	    i++;
+		pcmcia_unregister_socket (socket);
     }
 } /* unregister_ss_entry */
 
Index: drivers/pcmcia/i82365.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/i82365.c,v
retrieving revision 1.1.2.15
diff -u -r1.1.2.15 i82365.c
--- drivers/pcmcia/i82365.c	2000/11/17 09:35:49	1.1.2.15
+++ drivers/pcmcia/i82365.c	2000/11/22 10:37:36
@@ -142,6 +142,18 @@
 MODULE_PARM(wakeup, "i");
 #endif
 
+#ifdef CONFIG_PCI
+static int pci_irq_list[8] = { 0 };	/* PCI interrupt assignments */
+static int do_pci_probe = 1;		/* Scan for PCI bridges? */
+static int fast_pci = -1;
+static int irq_mode = -1;		/* Override BIOS routing? */
+
+MODULE_PARM(pci_irq_list, "1-8i");
+MODULE_PARM(do_pci_probe, "i");
+MODULE_PARM(fast_pci, "i");
+MODULE_PARM(irq_mode, "i");
+#endif
+
 MODULE_PARM(do_scan, "i");
 MODULE_PARM(poll_interval, "i");
 MODULE_PARM(cycle_time, "i");
@@ -153,11 +165,27 @@
 MODULE_PARM(setup_time, "i");
 MODULE_PARM(cmd_time, "i");
 MODULE_PARM(recov_time, "i");
+#if defined(CONFIG_ISA) && defined(CONFIG_PCI)
+int pci_csc = 1;		/* PCI card status irqs? */
+int pci_int = 1;		/* PCI IO card irqs? */
+MODULE_PARM(pci_csc, "i");
+MODULE_PARM(pci_int, "i");
+#elif defined(CONFIG_ISA) && !defined(CONFIG_PCI)
+#define pci_csc		0
+#define pci_int		0
+#elif !defined(CONFIG_ISA) && defined(CONFIG_PCI)
+#define pci_csc		0
+#define pci_int		1		/* We must use PCI irq's */
+#else
+#error "No bus architectures defined!"
+#endif
 
+
 /*====================================================================*/
 
 typedef struct cirrus_state_t {
     u_char		misc1, misc2;
+    u_char		ectl1;
     u_char		timer[6];
 } cirrus_state_t;
 
@@ -165,6 +193,17 @@
     u_char		ctl, ema;
 } vg46x_state_t;
 
+typedef struct o2micro_state_t {
+    u_char		mode_a;		/* O2_MODE_A */
+    u_char		mode_b;		/* O2_MODE_B */
+    u_char		mode_c;		/* O2_MODE_C */
+    u_char		mode_d;		/* O2_MODE_D */
+    u_char		mhpg;		/* O2_MHPG_DMA */
+    u_char		fifo;		/* O2_FIFO_ENA */
+    u_char		mode_e;		/* O2_MODE_E */
+} o2micro_state_t;
+
+
 typedef struct socket_info_t {
     u_short		type, flags;
     socket_cap_t	cap;
@@ -176,9 +215,15 @@
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry *proc;
 #endif
+    u_char		pci_irq_code;
+    u_char		revision;
+#ifdef CONFIG_PCI
+    struct pci_dev	*dev;
+#endif
     union {
 	cirrus_state_t		cirrus;
 	vg46x_state_t		vg46x;
+	o2micro_state_t		o2micro;
     } state;
 } socket_info_t;
 
@@ -216,6 +261,18 @@
     IS_IBM, IS_RF5Cx96, IS_VLSI, IS_VG468, IS_VG469,
     IS_PD6710, IS_PD672X, IS_VT83C469,
 #endif
+#ifdef CONFIG_PCI
+    /*
+     * There are many cards which were supported by the i82365 driver
+     * in the standalone package, but which are not listed here.
+     * This is because they are CardBus-capable and hence now supported
+     * by the Yenta driver.
+     */
+    IS_I82092AA, IS_OM82C092G, 			/* Intel 82092-based */
+    IS_PD6729, IS_PD6730, 			/* Cirrus */
+    IS_OZ6729, IS_OZ6730, 			/* O2Micro  */
+    IS_UNK_PCI
+#endif
 } pcic_id;
 
 /* Flags for classifying groups of controllers */
@@ -251,7 +308,86 @@
     { "Cirrus PD672x", IS_CIRRUS },
     { "VIA VT83C469", IS_CIRRUS|IS_VIA },
 #endif
+#ifdef CONFIG_PCI
+    { "Intel 82092AA", IS_PCI },
+    { "Omega Micro 82C092G", IS_PCI },
+    { "Cirrus PD6729", IS_CIRRUS|IS_PCI },
+    { "Cirrus PD6730", IS_CIRRUS|IS_PCI },
+    { "O2Micro OZ6729", IS_O2MICRO|IS_PCI|IS_VG_PWR },
+    { "O2Micro OZ6730", IS_O2MICRO|IS_PCI|IS_VG_PWR },
+    { "Unknown", IS_PCI|IS_UNKNOWN },
+#endif
+};
+
+#ifdef CONFIG_PCI
+static struct pci_device_id i82365_pci_ids[] = {
+	{	
+		vendor: PCI_VENDOR_ID_INTEL,
+		device: PCI_DEVICE_ID_INTEL_82092AA_0,
+		subvendor: PCI_ANY_ID,
+		subdevice: PCI_ANY_ID,
+		class: 0, class_mask: 0,
+		driver_data: IS_I82092AA
+	}, {
+		vendor: PCI_VENDOR_ID_OMEGA,
+		device: PCI_DEVICE_ID_OMEGA_82C092G,
+		subvendor: PCI_ANY_ID,
+		subdevice: PCI_ANY_ID,
+		class: 0, class_mask: 0,
+		driver_data: IS_OM82C092G
+	}, {
+		vendor: PCI_VENDOR_ID_CIRRUS,
+		device: PCI_DEVICE_ID_CIRRUS_6729,
+		subvendor: PCI_ANY_ID,
+		subdevice: PCI_ANY_ID,
+		class: 0, class_mask: 0,
+		driver_data: IS_PD6729
+	}, {
+		vendor: PCI_VENDOR_ID_CIRRUS,
+		device: PCI_ANY_ID,
+		subvendor: PCI_ANY_ID,
+		subdevice: PCI_ANY_ID,
+		class: PCI_CLASS_BRIDGE_PCMCIA,
+		class_mask: 0xffff,
+		driver_data: IS_PD6730
+	}, {
+		vendor: PCI_VENDOR_ID_O2,
+		device: PCI_DEVICE_ID_O2_6729,
+		subvendor: PCI_ANY_ID,
+		subdevice: PCI_ANY_ID,
+		class: 0, class_mask: 0,
+		driver_data: IS_OZ6729
+	}, {
+		vendor: PCI_VENDOR_ID_O2,
+		device: PCI_DEVICE_ID_O2_6730,
+		subvendor: PCI_ANY_ID,
+		subdevice: PCI_ANY_ID,
+		class: 0, class_mask: 0,
+		driver_data: IS_OZ6730
+	}, {
+		vendor: PCI_ANY_ID,
+		device: PCI_ANY_ID,
+		subvendor: PCI_ANY_ID,
+		subdevice: PCI_ANY_ID,
+		class: PCI_CLASS_BRIDGE_PCMCIA,
+		class_mask: 0xffff,
+		driver_data: IS_UNK_PCI
+	},
+	{ /* Terminating entry */ }
+};
+
+static int i82365_pci_probe(struct pci_dev *dev, const struct pci_device_id *id);
+static void i82365_pci_remove(struct pci_dev *dev);
+
+static struct pci_driver i82365_pci_drv = {
+	name:		"i82365",
+	id_table:	i82365_pci_ids,
+	probe:		i82365_pci_probe,
+	remove:		i82365_pci_remove,
+	suspend:	NULL,
+	resume:		NULL
 };
+#endif
 
 #define PCIC_COUNT	(sizeof(pcic)/sizeof(pcic_t))
 
@@ -315,6 +451,22 @@
     i365_set(sock, reg+1, data >> 8);
 }
 
+#ifdef CONFIG_PCI
+
+static int __init get_pci_irq(u_short s)
+{
+    socket_info_t *t = &socket[s];
+    u8 irq;
+
+    irq = t->dev->irq;
+    if ((irq == 0) && (pci_csc || pci_int))
+	irq = pci_irq_list[t - socket];
+    if (irq >= NR_IRQS) irq = 0;
+    t->cap.pci_irq = irq;
+    return irq;
+}
+
+#endif
 /*======================================================================
 
     Code to save and restore global state information for Cirrus
@@ -384,6 +536,23 @@
 	if (p->misc2 & PD67_MC2_FREQ_BYPASS)
 	    strcat(buf, " [freq bypass]");
 	}
+#ifdef CONFIG_PCI
+    } else {
+	p->misc1 &= ~PD67_MC1_MEDIA_ENA;
+	p->misc1 &= ~(PD67_MC1_PULSE_MGMT | PD67_MC1_PULSE_IRQ);
+	p->ectl1 &= ~(PD67_EC1_INV_MGMT_IRQ | PD67_EC1_INV_CARD_IRQ);
+	flip(p->misc2, PD67_MC2_FAST_PCI, fast_pci);
+	if (p->misc2 & PD67_MC2_IRQ15_RI)
+	    mask &= (t->type == IS_PD6730) ? ~0x0400 : ~0x8000;
+	if ((irq_mode == 1) && get_pci_irq(s)) {
+	    /* Configure PD6729 bridge for PCI interrupts */
+	    p->ectl1 |= PD67_EC1_INV_MGMT_IRQ | PD67_EC1_INV_CARD_IRQ;
+	    t->pci_irq_code = 3; /* PCI INTA = "irq 3" */
+	    buf += strlen(buf);
+	    sprintf(buf, " [pci irq %d]", t->cap.pci_irq);
+	    mask = 0;
+	}
+#endif
     }
     if (!(t->flags & IS_VIA)) {
 	if (setup_time >= 0)
@@ -459,7 +628,79 @@
 
 #endif
 
+/*======================================================================
+
+    Code to save and restore global state information for O2Micro
+    controllers, and to set and report global configuration options.
+    
+======================================================================*/
+
+#ifdef CONFIG_PCI
+
+static void __init o2micro_get_state(u_short s)
+{
+    o2micro_state_t *p = &socket[s].state.o2micro;
+
+    if (((socket[s].revision & 0xff) == 0x34) || 
+	((socket[s].revision & 0xff) == 0x62)) {
+	p->mode_a = i365_get(s, O2_MODE_A_2);
+	p->mode_b = i365_get(s, O2_MODE_B_2);
+    } else {
+	p->mode_a = i365_get(s, O2_MODE_A);
+	p->mode_b = i365_get(s, O2_MODE_B);
+    }
+    p->mode_c = i365_get(s, O2_MODE_C);
+    p->mode_d = i365_get(s, O2_MODE_D);
+}
+
+static void o2micro_set_state(u_short s)
+{
+    o2micro_state_t *p = &socket[s].state.o2micro;
+
+    if (((socket[s].revision & 0xff) == 0x34) || 
+	((socket[s].revision & 0xff) == 0x62)) {
+	i365_set(s, O2_MODE_A_2, p->mode_a);
+	i365_set(s, O2_MODE_B_2, p->mode_b);
+    } else {
+	i365_set(s, O2_MODE_A, p->mode_a);
+	i365_set(s, O2_MODE_B, p->mode_b);
+    }
+    i365_set(s, O2_MODE_C, p->mode_c);
+    i365_set(s, O2_MODE_D, p->mode_d);
+}
+
+static u_int __init o2micro_set_opts(u_short s, char *buf)
+{
+    o2micro_state_t *p = &socket[s].state.o2micro;
+    u_int mask = 0xffff;
 
+    p->mode_b = (p->mode_b & ~O2_MODE_B_IDENT) | O2_MODE_B_ID_CSTEP;
+    flip(p->mode_b, O2_MODE_B_IRQ15_RI, has_ring);
+    p->mode_c &= ~(O2_MODE_C_ZVIDEO | O2_MODE_C_DREQ_MASK);
+
+    if (p->mode_b & O2_MODE_B_IRQ15_RI) {
+	mask &= ~0x8000;
+	strcat(buf, " [ring]");
+    }
+    if (irq_mode != -1)
+	p->mode_d = irq_mode;
+    if (p->mode_d & O2_MODE_D_ISA_IRQ) {
+	strcat(buf, " [pci+isa]");
+    } else {
+	switch (p->mode_d & O2_MODE_D_IRQ_MODE) {
+	case O2_MODE_D_IRQ_PCPCI:
+	    strcat(buf, " [pc/pci]"); break;
+	case O2_MODE_D_IRQ_PCIWAY:
+	    strcat(buf, " [pci/way]"); break;
+	case O2_MODE_D_IRQ_PCI:
+	    strcat(buf, " [pci only]"); mask = 0; break;
+	}
+    }
+    return mask;
+}
+
+#endif
+
 /*======================================================================
 
     Generic routines to get and set controller options
@@ -475,6 +716,10 @@
     else if (t->flags & IS_VADEM)
 	vg46x_get_state(s);
 #endif
+#ifdef CONFIG_PCI
+    else if (t->flags & IS_O2MICRO)
+	o2micro_get_state(s);
+#endif
 }
 
 static void set_bridge_state(u_short s)
@@ -491,6 +736,10 @@
     if (t->flags & IS_VADEM)
 	vg46x_set_state(s);
 #endif
+#ifdef CONFIG_PCI
+    if (t->flags & IS_O2MICRO)
+	o2micro_set_state(s);
+#endif
 }
 
 static u_int __init set_bridge_opts(u_short s, u_short ns)
@@ -512,6 +761,10 @@
 	else if (socket[i].flags & IS_VADEM)
 	    m = vg46x_set_opts(i, buf);
 #endif
+#ifdef CONFIG_PCI
+	else if (socket[i].flags & IS_O2MICRO)
+	    m = o2micro_set_opts(s+i, buf);
+#endif
 	set_bridge_state(i);
 	printk(KERN_INFO "    host opts [%d]:%s\n", i,
 	       (*buf) ? buf : " none");
@@ -535,12 +788,15 @@
     DEBUG(2, "-> hit on irq %d\n", irq);
 }
 
-static u_int __init test_irq(u_short sock, int irq)
+static u_int __init test_irq(u_short sock, int irq, int pci)
 {
-    DEBUG(2, "  testing ISA irq %d\n", irq);
+    int csc = (pci) ? 0 : irq;
+
+    DEBUG(2, "  testing %s irq %d\n", pci?"PCI":"ISA", irq);
     if (request_irq(irq, irq_count, 0, "scan", irq_count) != 0)
 	return 1;
-    irq_hits = 0; irq_sock = sock;
+    irq_hits = 0;
+    irq_sock = sock;
     __set_current_state(TASK_UNINTERRUPTIBLE);
     schedule_timeout(HZ/100);
     if (irq_hits) {
@@ -550,7 +806,7 @@
     }
 
     /* Generate one interrupt */
-    i365_set(sock, I365_CSCINT, I365_CSC_DETECT | (irq << 4));
+    i365_set(sock, I365_CSCINT, I365_CSC_DETECT | (csc << 4));
     i365_bset(sock, I365_GENCTL, I365_CTL_SW_IRQ);
     udelay(1000);
 
@@ -560,7 +816,10 @@
     i365_set(sock, I365_CSCINT, 0);
     DEBUG(2, "    hits = %d\n", irq_hits);
     
-    return (irq_hits != 1);
+    if (pci)
+	    return (irq_hits == 0);
+    else
+	    return (irq_hits != 1);
 }
 
 #ifdef CONFIG_ISA
@@ -580,10 +839,10 @@
 	set_bridge_state(sock);
 	i365_set(sock, I365_CSCINT, 0);
 	for (i = 0; i < 16; i++)
-	    if ((mask0 & (1 << i)) && (test_irq(sock, i) == 0))
+	    if ((mask0 & (1 << i)) && (test_irq(sock, i, 0) == 0))
 		mask1 |= (1 << i);
 	for (i = 0; i < 16; i++)
-	    if ((mask1 & (1 << i)) && (test_irq(sock, i) != 0))
+	    if ((mask1 & (1 << i)) && (test_irq(sock, i, 0) != 0))
 		mask1 ^= (1 << i);
     }
     
@@ -611,6 +870,22 @@
 
 #endif /* CONFIG_ISA */
 
+#ifdef CONFIG_PCI
+static int __init pci_scan(u_short sock)
+{
+    socket_info_t *t = &socket[sock];
+
+    /* for PCI-to-PCMCIA bridges, just check for wedged irq */
+    irq_sock = sock; irq_hits = 0;
+    if (request_irq(t->cap.pci_irq, irq_count, 0, "scan", irq_count))
+	    return 1;
+    udelay(50);
+    free_irq(t->cap.pci_irq, irq_count);
+    DEBUG(2,"pci_scan: %d hits on IRQ %d\n", irq_hits, t->cap.pci_irq);
+    return (!irq_hits);
+}
+#endif /* CONFIG_PCI */
+
 /*====================================================================*/
 
 /* Time conversion functions */
@@ -629,7 +904,7 @@
 
 #ifdef CONFIG_ISA
 
-static int __init identify(u_short port, u_short sock)
+static int __init isa_identify(u_short port, u_short sock)
 {
     u_char val;
     int type = -1;
@@ -741,8 +1016,17 @@
     
     if (base == 0) printk("\n");
     printk(KERN_INFO "  %s", pcic[type].name);
-    printk(" ISA-to-PCMCIA at port %#x ofs 0x%02x",
-	       t->ioaddr, t->psock*0x40);
+#ifdef CONFIG_PCI
+    if (t->flags & IS_UNKNOWN)
+	    printk(" [%04x %04x]", t->dev->vendor, t->dev->device);
+    printk(" rev %02x", t->revision);
+    if (t->flags & IS_PCI)
+	    printk(" PCI-to-PCMCIA at slot %02x:%02x, port %#x",
+		   t->dev->bus->number, PCI_SLOT(t->dev->devfn), t->ioaddr);
+    else
+#endif
+	    printk(" ISA-to-PCMCIA at port %#x ofs 0x%02x",
+		   t->ioaddr, t->psock*0x40);
     printk(", %d socket%s\n", ns, ((ns > 1) ? "s" : ""));
 
 #ifdef CONFIG_ISA
@@ -754,13 +1038,27 @@
 	    mask |= (1<<irq_list[i]);
 #endif
     mask &= I365_MASK & set_bridge_opts(base, ns);
+#ifdef CONFIG_PCI
+    /* Can we use PCI interrupts for card status changes? */
+    if (pci_csc || pci_int) {
+	for (i = base; i < base + ns; i++)
+		if (!socket[i].cap.pci_irq || test_irq(i, socket[i].cap.pci_irq, 1)) break;
+	use_pci = (i==ns);
+    }
+#endif
 #ifdef CONFIG_ISA
     /* Scan for ISA interrupts */
     mask = isa_scan(base, mask);
-#else
-    printk(KERN_INFO "    PCI card interrupts,");
+#endif
+
+#ifdef CONFIG_PCI
+    if (!mask)
+	printk(KERN_INFO "    %s card interrupts,",
+	       (use_pci && pci_int) ? "PCI" : "*NO*");
+    if (use_pci && pci_csc)
+	printk(" PCI status changes\n");
 #endif
-        
+  
 #ifdef CONFIG_ISA
     /* Poll if only two interrupts available */
     if (!use_pci && !poll_interval) {
@@ -770,7 +1068,8 @@
 	    poll_interval = HZ;
     }
     /* Only try an ISA cs_irq if this is the first controller */
-    if (!use_pci && !grab_irq && (cs_irq || !poll_interval)) {
+    if (!(use_pci && pci_csc) && !grab_irq &&
+	(cs_irq || !poll_interval)) {
 	/* Avoid irq 12 unless it is explicitly requested */
 	u_int cs_mask = mask & ((cs_irq) ? (1<<cs_irq) : ~(1<<12));
 	for (cs_irq = 15; cs_irq > 0; cs_irq--)
@@ -785,7 +1084,7 @@
     }
 #endif
     
-    if (!use_pci && !isa_irq) {
+    if (!(use_pci && pci_csc) && !isa_irq) {
 	if (poll_interval == 0)
 	    poll_interval = HZ;
 	printk(" polling interval = %d ms\n",
@@ -798,6 +1097,8 @@
 	t[i].cap.features |= SS_CAP_PCCARD;
 	t[i].cap.map_size = 0x1000;
 	t[i].cap.irq_mask = mask;
+	if (!use_pci)
+	    t[i].cap.pci_irq = 0;
 	t[i].cs_irq = isa_irq;
     }
 
@@ -819,13 +1120,13 @@
 	return;
     }
 
-    id = identify(i365_base, 0);
-    if ((id == IS_I82365DF) && (identify(i365_base, 1) != id)) {
+    id = isa_identify(i365_base, 0);
+    if ((id == IS_I82365DF) && (isa_identify(i365_base, 1) != id)) {
 	for (i = 0; i < 4; i++) {
 	    if (i == ignore) continue;
 	    port = i365_base + ((i & 1) << 2) + ((i & 2) << 1);
 	    sock = (i & 1) << 1;
-	    if (identify(port, sock) == IS_I82365DF) {
+	    if (isa_identify(port, sock) == IS_I82365DF) {
 		add_socket(port, sock, IS_VLSI);
 		add_pcic(1, IS_VLSI);
 	    }
@@ -834,12 +1135,12 @@
 	for (i = 0; i < (extra_sockets ? 8 : 4); i += 2) {
 	    port = i365_base + 2*(i>>2);
 	    sock = (i & 3);
-	    id = identify(port, sock);
+	    id = isa_identify(port, sock);
 	    if (id < 0) continue;
 
 	    for (j = ns = 0; j < 2; j++) {
 		/* Does the socket exist? */
-		if ((ignore == i+j) || (identify(port, sock+j) < 0))
+		if ((ignore == i+j) || (isa_identify(port, sock+j) < 0))
 		    continue;
 		/* Check for bad socket decode */
 		for (k = 0; k <= sockets; k++)
@@ -857,6 +1158,47 @@
 
 #endif
 
+#ifdef CONFIG_PCI
+static void pcic_interrupt(int irq, void *dev,
+			   struct pt_regs *regs);
+
+static int i82365_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+    socket_info_t *s = &socket[sockets];
+    int type = id->driver_data;
+    unsigned long addr;
+    int ns;
+ 
+    dev->driver_data = (void *)sockets;
+    printk("i82365_pci_probe\n");
+
+    if (pci_enable_device(dev))
+	return -EIO;
+    
+    addr = dev->resource[0].start & ~1;
+    for (ns=0; ns < ((type == IS_I82092AA) ? 4 : 2); ns++) {
+	s[ns].dev = dev;
+	s[ns].cap.pci_irq = dev->irq;
+	pci_read_config_byte(dev, PCI_REVISION_ID, &s[ns].revision);
+	add_socket(addr, ns, type);
+    }
+
+    add_pcic(ns, type);
+    if (pci_csc && s[0].cap.pci_irq)
+	request_irq(dev->irq, pcic_interrupt, SA_SHIRQ, "i82365", pcic_interrupt);
+    return 0;
+
+}
+static void i82365_pci_remove(struct pci_dev *dev)
+{
+    u_short s = (u_short)dev->driver_data;
+    
+    if (pci_csc && socket[s].cap.pci_irq)
+	free_irq(dev->irq, pcic_interrupt);
+}
+
+#endif
+
 /*====================================================================*/
 
 static u_int pending_events[8];
@@ -980,6 +1322,20 @@
     *value |= (status & I365_CS_READY) ? SS_READY : 0;
     *value |= (status & I365_CS_POWERON) ? SS_POWERON : 0;
 
+#ifdef CONFIG_PCI
+    if (socket[sock].flags & IS_O2MICRO) {
+	status = i365_get(sock, O2_MODE_B);
+	*value |= (status & O2_MODE_B_VS1) ? 0 : SS_3VCARD;
+	*value |= (status & O2_MODE_B_VS2) ? 0 : SS_XVCARD;
+    } else if (socket[sock].type == IS_PD6729) {
+	status = pd67_ext_get(sock + (1-socket[sock].psock), PD67_EXTERN_DATA);
+	*value |= (status & PD67_EXD_VS1(socket[sock].psock)) ? 0 : SS_3VCARD;
+	*value |= (status & PD67_EXD_VS2(socket[sock].psock)) ? 0 : SS_XVCARD;
+    }
+    /* For now, ignore cards with unsupported voltage keys */
+    if (*value & SS_XVCARD)
+	*value &= ~(SS_DETECT|SS_3VCARD|SS_XVCARD);
+#endif
 #ifdef CONFIG_ISA
     if (socket[sock].type == IS_VG469) {
 	status = i365_get(sock, VG469_VSENSE);
@@ -1044,7 +1400,13 @@
     reg = i365_get(sock, I365_INTCTL);
     state->flags |= (reg & I365_PC_RESET) ? 0 : SS_RESET;
     if (reg & I365_PC_IOCARD) state->flags |= SS_IOCARD;
-    state->io_irq = reg & I365_IRQ_MASK;
+
+#ifdef CONFIG_PCI
+    if (socket[sock].cap.pci_irq)
+	    state->io_irq = socket[sock].cap.pci_irq;
+    else
+#endif
+	    state->io_irq = reg & I365_IRQ_MASK;
     
     /* speaker control */
     if (t->flags & IS_CIRRUS) {
@@ -1084,8 +1446,8 @@
     set_bridge_state(sock);
     
     /* IO card, RESET flag, IO interrupt */
-    reg = t->intr;
-    if (state->io_irq != t->cap.pci_irq) reg |= state->io_irq;
+    reg = t->intr | ((state->io_irq == t->cap.pci_irq) ?
+		     t->pci_irq_code : state->io_irq);
     reg |= (state->flags & SS_RESET) ? 0 : I365_PC_RESET;
     reg |= (state->flags & SS_IOCARD) ? I365_PC_IOCARD : 0;
     i365_set(sock, I365_INTCTL, reg);
@@ -1164,7 +1526,7 @@
     }
     
     /* Card status change interrupt mask */
-    reg = t->cs_irq << 4;
+    reg =  (t->cap.pci_irq ? t->pci_irq_code : t->cs_irq) << 4;
     if (state->csc_mask & SS_DETECT) reg |= I365_CSC_DETECT;
     if (state->flags & SS_IOCARD) {
 	if (state->csc_mask & SS_STSCHG) reg |= I365_CSC_STSCHG;
@@ -1261,6 +1623,13 @@
     mem->card_start = ((u_int)(i & 0x3fff) << 12) + mem->sys_start;
     mem->card_start &= 0x3ffffff;
     
+#ifdef CONFIG_PCI
+    /* Take care of high byte, for PCI controllers */
+    if (socket[sock].type == IS_PD6729) {
+	i365_set(sock, PD67_EXT_INDEX, PD67_MEM_PAGE(map));
+	addr = i365_get(sock, PD67_EXT_DATA) << 24;
+    }
+#endif
     DEBUG(1, "i82365: GetMemMap(%d, %d) = %#2.2x, %d ns, %#5.5lx-%#5."
 	  "5lx, %#5.5x\n", sock, mem->map, mem->flags, mem->speed,
 	  mem->sys_start, mem->sys_stop, mem->card_start);
@@ -1290,6 +1659,13 @@
     if (i365_get(sock, I365_ADDRWIN) & I365_ENA_MEM(map))
 	i365_bclr(sock, I365_ADDRWIN, I365_ENA_MEM(map));
     
+#ifdef CONFIG_PCI
+    /* Take care of high byte, for PCI controllers */
+    if (socket[sock].type == IS_PD6729) {
+	i365_set(sock, PD67_EXT_INDEX, PD67_MEM_PAGE(map));
+	i365_set(sock, PD67_EXT_DATA, (mem->sys_start >> 24));
+    }
+#endif
     base = I365_MEM(map);
     i = (mem->sys_start >> 12) & 0x0fff;
     if (mem->flags & MAP_16BIT) i |= I365_MEM_16BIT;
@@ -1332,6 +1708,12 @@
     char *p = buf;
     p += sprintf(p, "type:     %s\npsock:    %d\n",
 		 pcic[s->type].name, s->psock);
+#ifdef CONFIG_PCI
+    if (s->flags & (IS_PCI))
+	p += sprintf(p, "bus:      %02x\ndevfn:    %02x.%1x\n",
+		     s->dev->bus->number, PCI_SLOT(s->dev->devfn),
+		     PCI_FUNC(s->dev->devfn));
+#endif
     return (p - buf);
 }
 
@@ -1361,6 +1743,26 @@
     return (p - buf);
 }
 
+#ifdef CONFIG_PCI
+static int proc_read_pci(char *buf, char **start, off_t pos,
+			  int count, int *eof, void *data)
+{
+    struct pci_dev *dev = ((socket_info_t *)data)->dev;
+    char *p = buf;
+    u_int a, b, c, d;
+    int i;
+    
+    for (i = 0; i < 0xc0; i += 0x10) {
+	pci_read_config_dword(dev, i, &a);
+	pci_read_config_dword(dev, i+4, &b);
+	pci_read_config_dword(dev, i+8, &c);
+	pci_read_config_dword(dev, i+12, &d);
+	p += sprintf(p, "%08x %08x %08x %08x\n", a, b, c, d);
+    }
+    return (p - buf);
+}
+#endif
+
 static void pcic_proc_setup(unsigned int sock, struct proc_dir_entry *base)
 {
     socket_info_t *s = &socket[sock];
@@ -1370,15 +1772,26 @@
 
     create_proc_read_entry("info", 0, base, proc_read_info, s);
     create_proc_read_entry("exca", 0, base, proc_read_exca, s);
+#ifdef CONFIG_PCI
+    if (s->flags & IS_PCI)
+	create_proc_read_entry("pci", 0, base, proc_read_pci, s);
+#endif
     s->proc = base;
 }
 
 static void pcic_proc_remove(u_short sock)
 {
     struct proc_dir_entry *base = socket[sock].proc;
-    if (base == NULL) return;
+
+    if (base == NULL) 
+	return;
+
     remove_proc_entry("info", base);
     remove_proc_entry("exca", base);
+#ifdef CONFIG_PCI
+    if (socket[sock].flags & IS_PCI)
+	remove_proc_entry("pci", base);
+#endif
 }
 
 #else
@@ -1523,12 +1936,19 @@
     printk(KERN_INFO "Intel PCIC probe: ");
     sockets = 0;
 
+#ifdef CONFIG_PCI
+    if (do_pci_probe)
+	pci_register_driver (&i82365_pci_drv);
+#endif
 #ifdef CONFIG_ISA
     isa_probe();
 #endif
-
     if (sockets == 0) {
 	printk("not found.\n");
+#ifdef CONFIG_PCI
+	if (do_pci_probe)
+	    pci_unregister_driver (&i82365_pci_drv);
+#endif
 	return -ENODEV;
     }
 
@@ -1537,7 +1957,7 @@
     if (grab_irq != 0)
 	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
 #endif
-    
+
     if (register_ss_entry(sockets, &pcic_operations) != 0)
 	printk(KERN_NOTICE "i82365: register_ss_entry() failed\n");
 
@@ -1567,6 +1987,11 @@
     if (grab_irq != 0)
 	free_irq(cs_irq, pcic_interrupt);
 #endif
+#ifdef CONFIG_PCI
+    if (do_pci_probe)
+	pci_unregister_driver (&i82365_pci_drv);
+#endif
+
     for (i = 0; i < sockets; i++) {
 	/* Turn off all interrupt sources! */
 	i365_set(i, I365_CSCINT, 0);
Index: drivers/pcmcia/i82365.h
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/i82365.h,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 i82365.h
--- drivers/pcmcia/i82365.h	2000/06/07 10:38:28	1.1.2.2
+++ drivers/pcmcia/i82365.h	2000/11/22 10:37:36
@@ -132,4 +132,9 @@
 
 #define I365_REG(slot, reg)	(((slot) << 6) + reg)
 
+#define  O2_MODE_D_IRQ_MODE     0x03
+#define  O2_MODE_D_IRQ_PCPCI    0x00
+#define  O2_MODE_D_IRQ_PCIWAY   0x02
+#define  O2_MODE_D_IRQ_PCI      0x03
+
 #endif /* _LINUX_I82365_H */




--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
