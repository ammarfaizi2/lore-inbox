Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268041AbUHXPxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268041AbUHXPxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUHXPx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:53:29 -0400
Received: from mail.timesys.com ([65.117.135.102]:48538 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S268053AbUHXPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:49:37 -0400
Message-ID: <412B638E.80500@timesys.com>
Date: Tue, 24 Aug 2004 11:49:34 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: [patch] ppc ep8260 support under 2.6.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2004 15:47:43.0500 (UTC) FILETIME=[B1B884C0:01C489F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is basic support for the Embedded Planet's ep8260 board. It doesn't 
include MTD support. This patch unfortunatly doesn't apply to 2.6.8 just 
to 2.6.6. The code isn't mine, though it was developed here at Timesys. 
I just needed it running under 2.6.6.

Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0057

--- linux-orig/arch/ppc/8260_io/enet.c
+++ linux/arch/ppc/8260_io/enet.c
@@ -223,7 +223,7 @@
     else
         bdp++;
 
-    if (bdp->cbd_sc & BD_ENET_TX_READY) {
+    if (bdp == cbd->dirty_tx) {
         netif_stop_queue(dev);
         cep->tx_full = 1;
     }
@@ -622,6 +622,7 @@
     volatile    scc_enet_t    *ep;
     volatile    immap_t        *immap;
     volatile    iop8260_t    *io;
+    int err;
 
     cp = cpmp;    /* Get pointer to Communication Processor */
 
--- linux-orig/arch/ppc/8260_io/fcc_enet.c
+++ linux/arch/ppc/8260_io/fcc_enet.c
@@ -198,7 +198,11 @@
 #define PB3_TXEN    ((uint)0x00020000)
 #define PB3_COL        ((uint)0x00040000)
 #define PB3_CRS        ((uint)0x00080000)
+#ifndef CONFIG_EP8260
 #define PB3_TXDAT    ((uint)0x0f000000)
+#else
+#define PB3_TXDAT    ((uint)0x0e000000)
+#endif /* CONFIG_EP8260 */
 #define PB3_RXDAT    ((uint)0x00f00000)
 #define PB3_PSORB0    (PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
                 PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
@@ -206,7 +210,15 @@
 #define PB3_DIRB0    (PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
 #define PB3_DIRB1    (PB3_TXDAT | PB3_TXEN | PB3_TXER)
 
-/* CLK15 is receive, CLK16 is transmit.  These are board dependent.
+#ifdef CONFIG_EP8260
+#define PC3_TXDAT   ((uint)0x00000010)
+#define PC3_PSORC0  (PC3_TXDAT)
+#define PC3_PSORC1  (0)
+#define PC3_DIRC0   (0)
+#define PC3_DIRC1   (PC3_TXDAT)
+#endif /* CONFIG_EP8260 */
+
+/* CLK15 is receive, CLK16 is transmit.     These are board dependent.
 */
 #define PC_F3RXCLK    ((uint)0x00004000)
 #define PC_F3TXCLK    ((uint)0x00008000)
@@ -219,14 +231,17 @@
 /* TQM8260 has MDIO and MDCK on PC30 and PC31 respectively */
 #define PC_MDIO        ((uint)0x00000002)
 #define PC_MDCK        ((uint)0x00000001)
+#elif defined (CONFIG_EP8260)
+#define PC_MDIO        ((uint)0x00400000)
+#define PC_MDCK        ((uint)0x00200000)
 #else
 #define PC_MDIO        ((uint)0x00000004)
 #define PC_MDCK        ((uint)0x00000020)
 #endif
 
-/* A table of information for supporting FCCs.  This does two things.
+/* A table of information for supporting FCCs.    This does two things.
  * First, we know how many FCCs we have and they are always externally
- * numbered from zero.  Second, it holds control register and I/O
+ * numbered from zero.    Second, it holds control register and I/O
  * information that could be different among board designs.
  */
 typedef struct fcc_info {
@@ -266,7 +281,7 @@
 #ifdef CONFIG_FCC3_ENET
     { 2, CPM_CR_FCC3_SBLOCK, CPM_CR_FCC3_PAGE, PROFF_FCC3, SIU_INT_FCC3,
         (PC_F3RXCLK | PC_F3TXCLK), CMX3_CLK_ROUTE, CMX3_CLK_MASK,
-# if defined(CONFIG_TQM8260)
+# if defined(CONFIG_TQM8260) || defined (CONFIG_EP8260)
         PC_MDIO, PC_MDCK },
 # else
         0x00000001, 0x00000040 },
@@ -305,7 +320,7 @@
     uint    phy_id_done;
     uint    phy_status;
     phy_info_t    *phy;
-    struct tq_struct phy_task;
+    struct work_struct phy_task;
 
     uint    sequence_done;
 
@@ -431,15 +446,20 @@
         printk(" Ring data dump: cur_tx %p%s cur_rx %p.\n",
                cep->cur_tx, cep->tx_full ? " (full)" : "",
                cep->cur_rx);
+        printk("GFMR %x TSTATE %x TBASE %x TBPTR %x\n",
+               cep->fccp->fcc_gfmr,
+               cep->ep->fen_genfcc.fcc_tstate,
+               cep->ep->fen_genfcc.fcc_tbase,
+               cep->ep->fen_genfcc.fcc_tbptr);
         bdp = cep->tx_bd_base;
-        printk(" Tx @base %p :\n", bdp);
+        printk(" Tx @base %p, dirty %p:\n", bdp, cep->dirty_tx);
         for (i = 0 ; i < TX_RING_SIZE; i++, bdp++)
             printk("%04x %04x %08x\n",
                    bdp->cbd_sc,
                    bdp->cbd_datlen,
                    bdp->cbd_bufaddr);
         bdp = cep->rx_bd_base;
-        printk(" Rx @base %p :\n", bdp);
+        printk(" Rx @base %p:\n", bdp);
         for (i = 0 ; i < RX_RING_SIZE; i++, bdp++)
             printk("%04x %04x %08x\n",
                    bdp->cbd_sc,
@@ -770,6 +790,18 @@
     volatile struct fcc_enet_private *fep = dev->priv;
     uint s = fep->phy_status;
 
+#ifdef CONFIG_EP8260
+    /*
+     * Force the ANAR to negotiate half-duplex.     The EP8260 doesn't use
+     * PHY interrupts, and uses its own CPLD to poll the damn thing.  This
+     * ends up taking 128ms to poll reliably.  Instead, we'll just 
force the
+     * PHY to advertise half-duplex, and miss link status changes.
+     */
+    mii_reg &= ~(0x0140);
+    mii_send_receive (fep->fip, mk_mii_write (MII_REG_ANAR, mii_reg));
+    printk("%s: Forced PHY to half-duplex.\n", dev->name);
+#endif /* CONFIG_EP8260 */
+
     s &= ~(PHY_CONF_SPMASK);
 
     if (mii_reg & 0x0020)
@@ -1073,8 +1105,9 @@
     printk(".\n");
 }
 
-static void mii_display_config(struct net_device *dev)
+static void mii_display_config(void *vdev)
 {
+    struct net_device *dev = (struct net_device *) vdev;
     volatile struct fcc_enet_private *fep = dev->priv;
     uint s = fep->phy_status;
 
@@ -1104,8 +1137,9 @@
     fep->sequence_done = 1;
 }
 
-static void mii_relink(struct net_device *dev)
+static void mii_relink(void *vdev)
 {
+    struct net_device *dev = (struct net_device *) vdev;
     struct fcc_enet_private *fep = dev->priv;
     int duplex;
 
@@ -1128,18 +1162,16 @@
 {
     struct fcc_enet_private *fep = dev->priv;
 
-    fep->phy_task.routine = (void *)mii_relink;
-    fep->phy_task.data = dev;
-    schedule_task(&fep->phy_task);
+    INIT_WORK (&fep->phy_task, mii_relink, dev);
+    schedule_work(&fep->phy_task);
 }
 
 static void mii_queue_config(uint mii_reg, struct net_device *dev)
 {
     struct fcc_enet_private *fep = dev->priv;
 
-    fep->phy_task.routine = (void *)mii_display_config;
-    fep->phy_task.data = dev;
-    schedule_task(&fep->phy_task);
+    INIT_WORK (&fep->phy_task, mii_display_config, dev);
+    schedule_work(&fep->phy_task);
 }
 
 
@@ -1202,6 +1234,7 @@
     }
 }
 
+#if (PHY_INTERRUPT != -1)
 /* This interrupt occurs when the PHY detects a link change. */
 static irqreturn_t
 mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)
@@ -1213,6 +1246,7 @@
     mii_do_cmd(dev, phy_cmd_relink);  /* restart and display status */
     return IRQ_HANDLED;
 }
+#endif /* (PHY_INTERRUPT != -1) */
 
 #endif    /* CONFIG_USE_MDIO */
 
@@ -1242,7 +1276,7 @@
     ep = (fcc_enet_t *)dev->base_addr;
 
     if (dev->flags&IFF_PROMISC) {
-   
+
         /* Log any net taps. */
         printk("%s: Promiscuous mode enabled.\n", dev->name);
         cep->fccp->fcc_fpsmr |= FCC_PSMR_PRO;
@@ -1454,6 +1488,16 @@
         io->iop_psorb &= ~PB3_PSORB0;
         io->iop_psorb |= PB3_PSORB1;
         io->iop_pparb |= (PB3_DIRB0 | PB3_DIRB1);
+#ifdef CONFIG_EP8260
+        /*
+         * The EP8260 uses Port C pins as well...
+         */
+        io->iop_pdirc &= ~PC3_DIRC0;
+        io->iop_pdirc |= PC3_DIRC1;
+        io->iop_psorc &= ~PC3_PSORC0;
+        io->iop_psorc |= PC3_PSORC1;
+        io->iop_pparc |= (PC3_DIRC0 | PC3_DIRC1);
+#endif /* CONFIG_EP8260 */
     }
 
     /* Port C has clocks......
@@ -1710,11 +1754,11 @@
                             "fenet", dev) < 0)
         printk("Can't get FCC IRQ %d\n", fip->fc_interrupt);
 
-#ifdef    CONFIG_USE_MDIO
+#if defined (CONFIG_USE_MDIO) && (PHY_INTERRUPT != -1)
     if (request_irq(PHY_INTERRUPT, mii_link_interrupt, 0,
                             "mii", dev) < 0)
         printk("Can't get MII IRQ %d\n", fip->fc_interrupt);
-#endif    /* CONFIG_USE_MDIO */
+#endif    /* CONFIG_USE_MDIO && (PHY_INTERRUPT != -1) */
 
     /* Set GFMR to enable Ethernet operating mode.
      */
@@ -1749,6 +1793,7 @@
 }
 
 #ifdef    CONFIG_USE_MDIO
+#ifndef CONFIG_EP8260 /* EP8260 uses wierd CPLD setup to communicate 
with PHY */
 /* MII command/status interface.
  * I'm not going to describe all of the details.  You can find the
  * protocol definition in many other places, including the data sheet
@@ -1845,6 +1890,133 @@
 
     return retval;
 }
+#else /* CONFIG_EP8260 */
+
+#define SET_WRITE_OP(reg)   (*(reg) &= ~0x04)
+#define SET_READ_OP(reg)    (*(reg) |=    0x05)
+#define SET_CLOCK_HIGH(reg) (*(reg) |=    0x02)
+#define SET_CLOCK_LOW(reg)  (*(reg) &= ~0x02)
+#define SET_DATA_ON(reg)    (*(reg) |=    0x01)
+#define SET_DATA_OFF(reg)   (*(reg) &= ~0x01)
+#define GET_DATA_BIT(reg)   (*(reg) &    0x01)
+
+/* MII command/status interface.
+ * I'm not going to describe all of the details.  You can find the
+ * protocol definition in many other places, including the data sheet
+ * of most PHY parts.
+ *
+ * The MDCLK and MDIO bits are accessed through a board control register
+ * on the EP8260...
+ */
+static uint
+mii_send_receive(fcc_info_t *fip, uint cmd)
+{
+#define LCL_DELAY 1000
+    uint        retval;
+    int            read_op, i;
+    static spinlock_t    mii_lock = SPIN_LOCK_UNLOCKED;
+    static volatile unsigned char *phyControl = NULL;
+
+    spin_lock (&mii_lock);
+
+    if (phyControl == NULL)
+    phyControl = ioremap (0xFA000004, 1);
+
+    if ((*phyControl & 0xc0) != 0xc0) {
+    *phyControl |= 0xc0;
+    udelay (500);
+    }
+
+    /* When we get here, both clock and data are high, outputs.
+     * Output is open drain.
+     * Data transitions on high->low clock, is valid on low->high clock.
+     * Spec says edge transitions no closer than 160 nSec, minimum clock
+     * cycle 400 nSec.    I could only manage about 500 nSec edges with
+     * an XOR loop, so I won't worry about delays yet.
+     * I disable interrupts during bit flipping to ensure atomic
+     * updates of the registers.  I do lots of interrupt disable/enable
+     * to ensure we don't hang out too long with interrupts disabled.
+     */
+
+    /*
+     * First, crank out 32 1-bits as preamble.
+     * This is 64 transitions to clock the bits, with clock/data
+     * left high.
+     */
+    SET_WRITE_OP (phyControl);
+    SET_DATA_ON (phyControl);
+    for (i=0; i<32; i++) {
+    SET_CLOCK_LOW (phyControl);
+    udelay(LCL_DELAY);
+    SET_CLOCK_HIGH (phyControl);
+    udelay(LCL_DELAY);
+    }
+
+    read_op = ((cmd & 0xf0000000) == 0x60000000);
+
+    /* We return the command word on a write op, or the command portion
+     * plus the new data on a read op.    This is what the 8xx FEC does,
+     * and it allows the functions to simply look at the returned value
+     * and know the PHY/register as well.
+     */
+    if (read_op)
+    retval = (cmd >> 16);
+    else
+    retval = cmd;
+
+    /* Clock out the first 16 MS bits of the command.
+    */
+    SET_WRITE_OP (phyControl);
+    for (i=0; i<16; i++) {
+    SET_CLOCK_LOW (phyControl);
+    udelay(LCL_DELAY);
+    if (cmd & 0x80000000)
+        SET_DATA_ON (phyControl);
+    else
+        SET_DATA_OFF (phyControl);
+    cmd <<= 1;
+    SET_CLOCK_HIGH (phyControl);
+    udelay(LCL_DELAY);
+    }
+
+    /* For read, clock in 16 bits.  For write, clock out
+     * rest of command.
+     */
+    if (read_op) {
+    for (i=0; i<16; i++) {
+        SET_READ_OP (phyControl);
+        udelay(LCL_DELAY);
+
+        SET_CLOCK_LOW (phyControl);
+        udelay(LCL_DELAY);
+        retval <<= 1;
+        retval |= GET_DATA_BIT (phyControl);
+        SET_CLOCK_HIGH (phyControl);
+        udelay(LCL_DELAY);
+    }
+    }
+    else {
+    for (i=0; i<16; i++) {
+        SET_CLOCK_LOW (phyControl);
+        if (cmd & 0x80000000)
+        SET_DATA_ON (phyControl);
+        else
+        SET_DATA_OFF (phyControl);
+        cmd <<= 1;
+        SET_CLOCK_HIGH (phyControl);
+        udelay(LCL_DELAY);
+    }
+    }
+
+    spin_unlock (&mii_lock);
+
+    /* We exit with the same conditions as entry.
+    */
+    return(retval);
+#undef LCL_DELAY
+}
+
+#endif /* CONFIG_EP8260 */
 
 static void
 fcc_stop(struct net_device *dev)
@@ -1895,6 +2067,9 @@
             schedule();
 
         mii_do_cmd(dev, fep->phy->startup);
+#ifdef CONFIG_EP8260
+        fep->link = 1;
+#endif
         netif_start_queue(dev);
         return 0;        /* Success */
     }
@@ -1905,4 +2080,3 @@
     return 0;                    /* Always succeed */
 #endif    /* CONFIG_USE_MDIO */
 }
-
--- linux-orig/arch/ppc/8260_io/uart.c
+++ linux/arch/ppc/8260_io/uart.c
@@ -475,7 +475,7 @@
             if (break_pressed && info->line == sercons.index) {
                 if (ch != 0 && time_before(jiffies,
                             break_pressed + HZ*5)) {
-                    handle_sysrq(ch, regs, NULL, NULL);
+                    handle_sysrq(ch, regs, tty);
                     break_pressed = 0;
                     goto ignore_char;
                 } else
@@ -1867,6 +1867,9 @@
     DECLARE_WAITQUEUE(wait, current);
     struct serial_state *state = info->state;
 #endif
+#ifdef SERIAL_DEBUG_OPEN
+      struct serial_state *state = info->state;
+#endif
     int        retval;
     int        do_clocal = 0;
 
@@ -2519,6 +2522,10 @@
     volatile    smc_uart_t    *up;
     volatile    scc_t        *scp;
     volatile    scc_uart_t    *sup;
+#ifdef SCC_CONSOLE
+      volatile    scc_t        *scp;
+      volatile    scc_uart_t    *sup;
+#endif
     volatile    immap_t        *immap;
     volatile    iop8260_t    *io;
 
--- linux-orig/arch/ppc/Kconfig
+++ linux/arch/ppc/Kconfig
@@ -493,6 +493,9 @@
 config SPRUCE
     bool "IBM-Spruce"
 
+config EP8260
+    bool "Embedded Planet EP8260"
+
 config LOPEC
     bool "Motorola-LoPEC"
 
@@ -502,6 +505,9 @@
 config MVME5100
     bool "Motorola-MVME5100"
 
+config MVME5500
+    bool "Motorola-MVME5500"
+
 config PPLUS
     bool "Motorola-PowerPlus"
 
@@ -573,9 +579,9 @@
     default y
 
 config 8260
-    bool "MPC8260 CPM Support" if WILLOW
+    bool "MPC8260 CPM Support" if WILLOW || EP8260
     depends on 6xx
-    default y if TQM8260 || RPXSUPER || EST8260 || SBS8260
+    default y if TQM8260 || RPXSUPER || EST8260 || SBS8260 || EP8260
     help
       The MPC8260 CPM (Communications Processor Module) is a typical
       embedded CPU made by Motorola.  Selecting this option means that
--- linux-orig/arch/ppc/boot/common/util.S
+++ linux/arch/ppc/boot/common/util.S
@@ -226,7 +226,7 @@
     blt    2b
 3:    blr
 
-    .section ".relocate_code","xa"
+    .section "._relocate_code","xa"
 /*
  * Flush and enable instruction cache
  * First, flush the data cache in case it was enabled and may be
--- linux-orig/arch/ppc/boot/ld.script
+++ linux/arch/ppc/boot/ld.script
@@ -29,7 +29,7 @@
     *(.text)
     *(.fixup)
     __relocate_start = .;
-    *(.relocate_code)
+    *(._relocate_code)
     __relocate_end = .;
   }
   _etext = .;
--- linux-orig/arch/ppc/boot/simple/Makefile
+++ linux/arch/ppc/boot/simple/Makefile
@@ -22,6 +22,7 @@
 # misc-$(CONFIG_MACHINE) variable.
 
 boot                := arch/ppc/boot
+sboot                := $(TOPDIR)/arch/ppc/boot
 common                := $(boot)/common
 utils                := $(boot)/utils
 bootlib                := $(boot)/lib
@@ -55,6 +56,13 @@
          end-$(CONFIG_EMBEDDEDBOOT)    := embedded
         misc-$(CONFIG_EMBEDDEDBOOT)    := misc-embedded.o
 
+      zimage-$(CONFIG_EP8260)        := zImage-IMAGE
+zimageinitrd-$(CONFIG_EP8260)        := zImage.initrd-IMAGE
+    znetboot-$(CONFIG_EP8260)        := zImage.bin
+  znetbootrd-$(CONFIG_EP8260)        := zImage.initrd.bin
+   tftpimage-$(CONFIG_EP8260)        := /tftpboot/zImage.initrd.$(end-y)
+        misc-$(CONFIG_EP8260)        := misc-embedded.o
+
       zimage-$(CONFIG_EBONY)        := zImage-TREE
 zimageinitrd-$(CONFIG_EBONY)        := zImage.initrd-TREE
          end-$(CONFIG_EBONY)        := ebony
@@ -79,8 +87,7 @@
 
 # kconfig 'feature', only one of these will ever be 'y' at a time.
 # The rest will be unset.
-motorola := $(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750) \
-$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
+motorola := 
$(CONFIG_MCPN765)$(CONFIG_MVME5100)$(CONFIG_PRPMC750)$(CONFIG_PRPMC800)$(CONFIG_LOPEC)$(CONFIG_PPLUS)
 motorola := $(strip $(motorola))
 pcore := $(CONFIG_PCORE)$(CONFIG_POWERPMC250)
 
@@ -125,7 +132,7 @@
 AFLAGS_head.o                += $(cacheflag-y)
 
 # Linker args.  This specifies where the image will be run at.
-LD_ARGS                := -T $(boot)/ld.script \
+LD_ARGS                := -T $(sboot)/ld.script \
                    -Ttext $(CONFIG_BOOT_LOAD) -Bstatic
 OBJCOPY_ARGS            := -O elf32-powerpc
 
@@ -160,7 +167,7 @@
 
 targets := dummy.o
 
-$(obj)/zvmlinux: $(OBJS) $(LIBS) $(boot)/ld.script $(images)/vmlinux.gz \
+$(obj)/zvmlinux: $(OBJS) $(LIBS) $(sboot)/ld.script $(images)/vmlinux.gz \
         $(obj)/dummy.o
     $(OBJCOPY) $(OBJCOPY_ARGS) \
         --add-section=.image=$(images)/vmlinux.gz \
@@ -170,7 +177,7 @@
     $(OBJCOPY) $(OBJCOPY_ARGS) $@ $@ -R .comment -R .stab \
         -R .stabstr -R .ramdisk -R .sysmap
 
-$(obj)/zvmlinux.initrd: $(OBJS) $(LIBS) $(boot)/ld.script \
+$(obj)/zvmlinux.initrd: $(OBJS) $(LIBS) $(sboot)/ld.script \
         $(images)/vmlinux.gz $(obj)/dummy.o
     $(OBJCOPY) $(OBJCOPY_ARGS) \
         --add-section=.ramdisk=$(images)/ramdisk.image.gz \
@@ -219,6 +226,12 @@
     $(MKPREP) -pbp $(obj)/zvmlinux.initrd $(images)/zImage.initrd.$(end-y)
     $(MKBUGBOOT) $(obj)/zvmlinux.initrd $(images)/zImage.initrd.bugboot
 
+$(images)/zImage-IMAGE: $(obj)/zvmlinux
+    $(OBJCOPY) -O binary $(obj)/zvmlinux $(images)/zImage.bin
+
+$(images)/zImage.initrd-IMAGE: $(obj)/zvmlinux.initrd
+    $(OBJCOPY) -O binary $(obj)/zvmlinux.initrd $(images)/zImage.initrd.bin
+
 $(images)/zImage-UBOOT: $(images)/vmlinux.gz $(MKIMAGE)
     $(MKIMAGE) -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
         -n 'Linux-$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)' \
--- linux-orig/arch/ppc/boot/simple/embed_config.c
+++ linux/arch/ppc/boot/simple/embed_config.c
@@ -16,6 +16,7 @@
 #ifdef CONFIG_8260
 #include <asm/mpc8260.h>
 #include <asm/immap_8260.h>
+static void clk_8260(bd_t *bd);
 #endif
 #ifdef CONFIG_40x
 #include <asm/io.h>
@@ -96,7 +97,7 @@
 #endif /* CONFIG_MBX */
 
 #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || \
-    defined(CONFIG_RPX6) || defined(CONFIG_EP405)
+    defined(CONFIG_RPX6) || defined(CONFIG_EP405) || defined 
(CONFIG_EP8260)
 /* Helper functions for Embedded Planet boards.
 */
 /* Because I didn't find anything that would do this.......
@@ -146,7 +147,7 @@
     }
 }
 
-#ifdef CONFIG_RPX6
+#if defined (CONFIG_RPX6) || defined (CONFIG_EP8260)
 static uint
 rpx_baseten(u_char *cp)
 {
@@ -216,7 +217,7 @@
 }
 #endif
 
-#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || 
defined(CONFIG_EP405)
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || 
defined(CONFIG_EP405) || defined (CONFIG_EP8260)
 static void
 rpx_memsize(bd_t *bd, u_char *cp)
 {
@@ -333,6 +334,84 @@
 }
 #endif /* RPXLITE || RPXCLASSIC */
 
+#ifdef CONFIG_EP8260
+void
+embed_config(bd_t **bdp)
+{
+    u_char  *cp;
+    u_char  eebuf[256];
+    bd_t    *bd;
+
+    memcpy (eebuf, (void *) *bdp, 256);
+
+    bd = &bdinfo;
+    *bdp = bd;
+
+    /* We look for two things, the Ethernet address and the
+     * serial baud rate.  The records are separated by
+     * newlines.
+     */
+    cp = eebuf + 1;
+    while (*cp != 0x0A)
+        {
+        if (*cp == 'E') {
+            cp++;
+            if (*cp == 'A') {
+                cp += 2;
+                rpx_eth(bd, cp);
+            }
+        }
+        if (*cp == 'S') {
+            cp++;
+            if (*cp == 'B') {
+                cp += 2;
+                bd->bi_baudrate = rpx_baseten(cp);
+            }
+        }
+        if (*cp == 'D') {
+            cp++;
+            if (*cp == '1') {
+                cp += 2;
+                rpx_memsize(bd, cp);
+            }
+        }
+        if (*cp == 'X') {
+            cp++;
+            if (*cp == 'T') {
+                cp += 2;
+                bd->bi_busfreq = rpx_baseten(cp);
+                clk_8260 (bd);
+            }
+        }
+        if (*cp == 'N') {
+            cp++;
+            if (*cp == 'V') {
+                cp += 2;
+                bd->bi_nvram_size = rpx_baseten(cp) * 1024;
+            }
+        }
+        /*
+         * Scan to the end of the record.
+         */
+        while (*cp != 0x0A)
+            cp++;
+
+        /*
+         * If the next character is a 0x0A, we are done.
+         */
+        cp++;
+        }
+
+    bd->bi_memstart = 0;
+    bd->bi_immr = 0xF0000000;
+
+    if (bd->bi_memsize == 0)
+        bd->bi_memsize = 64 * (1024 * 1024);
+
+    bd->bi_intfreq = 165000000;
+}
+#endif /* CONFIG_EP8260 */
+
 #ifdef CONFIG_BSEIP
 /* Build a board information structure for the BSE ip-Engine.
  * There is more to come since we will add some environment
--- linux-orig/arch/ppc/boot/simple/head.S
+++ linux/arch/ppc/boot/simple/head.S
@@ -57,7 +57,7 @@
     isync
 #endif
 
-#if defined(CONFIG_MBX) || defined(CONFIG_RPX6) || defined(CONFIG_PPC_PREP)
+#if defined(CONFIG_MBX) || defined(CONFIG_RPX6) || 
defined(CONFIG_PPC_PREP) || defined (CONFIG_EP8260)
     mr    r29,r3    /* On the MBX860, r3 is the board info pointer.
              * On the RPXSUPER, r3 points to the NVRAM
              * configuration keys.
@@ -129,7 +129,7 @@
     mr    r3, r29
 #endif
 
-#if defined(CONFIG_MBX) || defined(CONFIG_RPX6) || defined(CONFIG_PPC_PREP)
+#if defined(CONFIG_MBX) || defined(CONFIG_RPX6) || 
defined(CONFIG_PPC_PREP) || defined (CONFIG_EP8260)
     mr    r4,r29    /* put the board info pointer where the relocate
              * routine will find it
              */
--- linux-orig/arch/ppc/boot/simple/relocate.S
+++ linux/arch/ppc/boot/simple/relocate.S
@@ -108,7 +108,7 @@
     mtlr    r6
     b    flush_instruction_cache
 
-    .section ".relocate_code","xa"
+    .section "._relocate_code","xa"
    
 do_relocate:
     /* We have 2 cases --- start < load, or start > load
--- /dev/null
+++ linux/arch/ppc/configs/ts_ep8260
@@ -0,0 +1,800 @@
+#
+# Automatically generated make config: don't edit
+#
+CONFIG_MMU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+CONFIG_STANDALONE=y
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_HOTPLUG=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_EMBEDDEDBOOT=y
+CONFIG_PPC_STD_MMU=y
+
+#
+# Platform options
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_APUS is not set
+# CONFIG_WILLOW is not set
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_EV64260 is not set
+# CONFIG_SPRUCE is not set
+CONFIG_EP8260=y
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_MVME5500 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_ADIR is not set
+# CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX6 is not set
+# CONFIG_TQM8260 is not set
+CONFIG_8260=y
+# CONFIG_PC_KEYBOARD is not set
+CONFIG_SERIAL_CONSOLE=y
+# CONFIG_SMP is not set
+CONFIG_PREEMPT=y
+# CONFIG_HIGHMEM is not set
+CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=m
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,9600 root=/dev/ram0 rw init=linuxrc"
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCI_LEGACY_PROC is not set
+CONFIG_PCI_NAMES=y
+
+#
+# PCMCIA/CardBus support
+#
+CONFIG_PCMCIA=m
+# CONFIG_PCMCIA_DEBUG is not set
+# CONFIG_YENTA is not set
+CONFIG_I82092=m
+CONFIG_TCIC=m
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_CFI_B1 is not set
+# CONFIG_MTD_CFI_B2 is not set
+# CONFIG_MTD_CFI_B4 is not set
+CONFIG_MTD_CFI_B8=y
+# CONFIG_MTD_CFI_I1 is not set
+# CONFIG_MTD_CFI_I2 is not set
+CONFIG_MTD_CFI_I4=y
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+# CONFIG_MTD_OBSOLETE_CHIPS is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLKMTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+
+#
+# NAND Flash Device Drivers
+#
+# CONFIG_MTD_NAND is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=m
+# CONFIG_BLK_DEV_CARMEL is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_LBD is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_NETLINK_DEV=y
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_FWMARK=y
+CONFIG_IP_ROUTE_NAT=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_TOS=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+CONFIG_NET_IPIP=y
+CONFIG_NET_IPGRE=y
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_IP_NF_CONNTRACK=m
+CONFIG_IP_NF_FTP=m
+CONFIG_IP_NF_IRC=m
+CONFIG_IP_NF_TFTP=m
+CONFIG_IP_NF_AMANDA=m
+CONFIG_IP_NF_QUEUE=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_LIMIT=m
+# CONFIG_IP_NF_MATCH_IPRANGE is not set
+CONFIG_IP_NF_MATCH_MAC=m
+CONFIG_IP_NF_MATCH_PKTTYPE=m
+CONFIG_IP_NF_MATCH_MARK=m
+CONFIG_IP_NF_MATCH_MULTIPORT=m
+CONFIG_IP_NF_MATCH_TOS=m
+# CONFIG_IP_NF_MATCH_RECENT is not set
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_DSCP=m
+CONFIG_IP_NF_MATCH_AH_ESP=m
+CONFIG_IP_NF_MATCH_LENGTH=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_MATCH_TCPMSS=m
+CONFIG_IP_NF_MATCH_HELPER=m
+CONFIG_IP_NF_MATCH_STATE=m
+CONFIG_IP_NF_MATCH_CONNTRACK=m
+CONFIG_IP_NF_MATCH_OWNER=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+# CONFIG_IP_NF_TARGET_NETMAP is not set
+# CONFIG_IP_NF_TARGET_SAME is not set
+# CONFIG_IP_NF_NAT_LOCAL is not set
+CONFIG_IP_NF_NAT_SNMP_BASIC=m
+CONFIG_IP_NF_NAT_IRC=m
+CONFIG_IP_NF_NAT_FTP=m
+CONFIG_IP_NF_NAT_TFTP=m
+CONFIG_IP_NF_NAT_AMANDA=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_TOS=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_DSCP=m
+CONFIG_IP_NF_TARGET_MARK=m
+# CONFIG_IP_NF_TARGET_CLASSIFY is not set
+CONFIG_IP_NF_TARGET_LOG=m
+CONFIG_IP_NF_TARGET_ULOG=m
+CONFIG_IP_NF_TARGET_TCPMSS=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+# CONFIG_IP_NF_ARP_MANGLE is not set
+CONFIG_IP_NF_COMPAT_IPCHAINS=m
+CONFIG_IP_NF_COMPAT_IPFWADM=m
+# CONFIG_IP_NF_RAW is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_FASTROUTE is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CBQ=m
+CONFIG_NET_SCH_HTB=m
+# CONFIG_NET_SCH_HFSC is not set
+CONFIG_NET_SCH_CSZ=m
+CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TEQL=m
+CONFIG_NET_SCH_TBF=m
+CONFIG_NET_SCH_GRED=m
+CONFIG_NET_SCH_DSMARK=m
+# CONFIG_NET_SCH_DELAY is not set
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_QOS=y
+CONFIG_NET_ESTIMATOR=y
+CONFIG_NET_CLS=y
+CONFIG_NET_CLS_TCINDEX=m
+CONFIG_NET_CLS_ROUTE4=m
+CONFIG_NET_CLS_ROUTE=y
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_CLS_U32=m
+CONFIG_NET_CLS_RSVP=m
+CONFIG_NET_CLS_RSVP6=m
+CONFIG_NET_CLS_POLICE=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_ETHERTAP is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_OAKNET is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_RCPCI is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_QIC02_TAPE is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_MDA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_FAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_DEVFS_FS=y
+# CONFIG_DEVFS_MOUNT is not set
+# CONFIG_DEVFS_DEBUG is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+# CONFIG_JFFS2_FS_NAND is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V4 is not set
+CONFIG_NFS_DIRECTIO=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+# CONFIG_NFSD_V4 is not set
+# CONFIG_NFSD_TCP is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+# CONFIG_SCC_ENET is not set
+CONFIG_FEC_ENET=y
+CONFIG_USE_MDIO=y
+
+#
+# MPC8260 CPM Options
+#
+# CONFIG_SCC_CONSOLE is not set
+# CONFIG_FCC1_ENET is not set
+# CONFIG_FCC2_ENET is not set
+CONFIG_FCC3_ENET=y
+# CONFIG_FCC_LXT970 is not set
+CONFIG_FCC_LXT971=y
+# CONFIG_FCC_QS6612 is not set
+
+#
+# Library routines
+#
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+
+#
+# Kernel hacking
+#
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SLAB is not set
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_KGDB is not set
+# CONFIG_KGDB_CONSOLE is not set
+# CONFIG_XMON is not set
+# CONFIG_BDI_SWITCH is not set
+CONFIG_DEBUG_INFO=y
+
+#
+# Security options
+#
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set

--- linux-orig/arch/ppc/kernel/head.S
+++ linux/arch/ppc/kernel/head.S
@@ -1085,9 +1085,13 @@
     lwzx    r0,r6,r4
     stwx    r0,r6,r3
     bdnz    3b
+#ifndef CONFIG_PPC_NO_DCACHE
     dcbst    r6,r3            /* write it to memory */
+#endif /* CONFIG_PPC_NO_DCACHE */
     sync
+#ifndef CONFIG_PPC_NO_ICACHE
     icbi    r6,r3            /* flush the icache line */
+#endif /* CONFIG_PPC_NO_ICACHE */
     cmplw    0,r6,r5
     blt    4b
     sync                /* additional sync needed on g4 */
@@ -1124,9 +1128,13 @@
     lwz     r15,0(r14)               /* instruction, now insert top */
     rlwimi  r15,r10,16,16,31         /* half of vp const in low half */
     stw    r15,0(r14)               /* of instruction and restore. */
+#ifndef CONFIG_PPC_NO_DCACHE
     dcbst    r0,r14             /* write it to memory */
+#endif /* CONFIG_PPC_NO_DCACHE */
     sync
+#ifndef CONFIG_PPC_NO_ICACHE
     icbi    r0,r14             /* flush the icache line */
+#endif /* CONFIG_PPC_NO_ICACHE */
     cmpw    r12,r13
     bne     1b
     sync                /* additional sync needed on g4 */
@@ -1158,9 +1166,13 @@
     lwz     r15,0(r14)               /* instruction, now insert top */
     rlwimi  r15,r11,16,16,31         /* half of pv const in low half*/
     stw    r15,0(r14)               /* of instruction and restore. */
+#ifndef CONFIG_PPC_NO_DCACHE
     dcbst    r0,r14             /* write it to memory */
+#endif /* CONFIG_PPC_NO_DCACHE */
     sync
+#ifndef CONFIG_PPC_NO_ICACHE
     icbi    r0,r14             /* flush the icache line */
+#endif /* CONFIG_PPC_NO_ICACHE */
     cmpw    r12,r13
     bne     1b
 
@@ -1655,7 +1667,7 @@
     andc    r11, r11, r10
     mtspr    HID0, r11
     isync
-    li    r5, MSR_ME|MSR_RI
+    li    r5, MSR_ME|MSR_IP|MSR_RI
     lis    r6,2f@h
     addis    r6,r6,-KERNELBASE@h
     ori    r6,r6,2f@l
--- linux-orig/arch/ppc/platforms/Makefile
+++ linux/arch/ppc/platforms/Makefile
@@ -30,6 +30,7 @@
 obj-$(CONFIG_PREP_RESIDUAL)    += residual.o
 obj-$(CONFIG_ADIR)        += adir_setup.o adir_pic.o adir_pci.o
 obj-$(CONFIG_EST8260)        += est8260_setup.o
+obj-$(CONFIG_EP8260)        += ep8260_setup.o
 obj-$(CONFIG_TQM8260)        += tqm8260_setup.o
 obj-$(CONFIG_EV64260)        += ev64260_setup.o
 obj-$(CONFIG_GEMINI)        += gemini_pci.o gemini_setup.o gemini_prom.o
--- /dev/null
+++ linux/arch/ppc/platforms/ep8260.h
@@ -0,0 +1,83 @@
+/* Board information for the EP8260, which should be generic for
+ * all 8260 boards.  The IMMR is now given to us so the hard define
+ * will soon be removed.  All of the clock values are computed from
+ * the configuration SCMR and the Power-On-Reset word.
+ */
+
+#define IMAP_ADDR    ((uint)0xf0000000)
+
+#define OFFSET_MEM      0x08000000     /* For 64MB Mb window */
+#define OFFSET_IO       0x04000000
+#define OFFSET_ATTRIB   0x00000000
+
+//#define _IO_BASE        0xE4000000     /* For PCMCIA  i/o window of 
64 Mb */
+//#define _IO_BASE_SIZE   0x0FFFFFFF     /* 256 MB for PCMCIA 64*4 MB */
+
+#define PCMCIA_MEM_WIN_BASE 0xE0000000 /* base address for PCMCIA 
memory window */
+#define PCMCIA_MEM_WIN_SIZE 0x04000000 /* memory window is 64 MByte */
+#define PCMCIA_IO_WIN_BASE  _IO_BASE   /* base address for io window */
+
+#define PCMCIA_INTERRUPT   24          /* IRQ6 */
+#define PHY_INTERRUPT      -1
+
+#ifdef CONFIG_IDE
+#undef MAX_HWIFS
+#define MAX_HWIFS 1
+#undef ide_request_irq
+#define ide_request_irq(irq,hand,flg,dev,id)    
request_8xxirq((irq),(hand),(flg),(dev),(id))
+#endif
+
+/* A Board Information structure that is given to a program when
+ * prom starts it up.
+ */
+typedef struct bd_info {
+    unsigned int    bi_memstart;    /* Memory start address */
+    unsigned int    bi_memsize;    /* Memory (end) size in bytes */
+    unsigned int    bi_intfreq;    /* Internal Freq, in Hz */
+    unsigned int    bi_busfreq;    /* Bus Freq, in MHz */
+    unsigned int    bi_cpmfreq;    /* CPM Freq, in MHz */
+    unsigned int    bi_brgfreq;    /* BRG Freq, in MHz */
+    unsigned int    bi_vco;        /* VCO Out from PLL */
+    unsigned int    bi_baudrate;    /* Default console baud rate */
+    unsigned int    bi_immr;    /* IMMR when called from boot rom */
+    unsigned int    bi_nvram_size;    /* Size of NVRAM in bytes */
+    unsigned int    bi_ip_address;    /* IP Address used by bootloader */
+    unsigned char    bi_enetaddr[6];
+} bd_t;
+
+extern bd_t m8260_board_info;
+
+#define EP8260_BCSR0_ADDR    0xFA000000
+#define EP8260_BCSR1_ADDR    0xFA000001
+#define EP8260_BCSR2_ADDR    0xFA000002
+#define EP8260_BCSR3_ADDR    0xFA000003
+#define EP8260_BCSR4_ADDR    0xFA000004
+#define EP8260_BCSR5_ADDR    0xFA000005
+#define EP8260_BCSR6_ADDR    0xFA000006
+#define EP8260_BCSR7_ADDR    0xFA000007
+#define EP8260_BCSR8_ADDR    0xFA000008
+#define EP8260_BCSR9_ADDR    0xFA000009
+#define EP8260_BCSR10_ADDR    0xFA00000A
+#define EP8260_BCSR11_ADDR    0xFA00000B
+#define EP8260_BCSR12_ADDR    0xFA00000C
+#define EP8260_BCSR13_ADDR    0xFA00000D
+#define EP8260_BCSR14_ADDR    0xFA00000E
+#define EP8260_BCSR15_ADDR    0xFA00000F
+#define EP8260_NVRAM_ADDR    0xFA080000
+
+#define BCSR1_SMC_SEL0        0x80
+#define BCSR1_SMC_SEL1        0x40
+#define BCSR1_SMC_RTS        0x20
+#define BCSR1_SMC_CTS        0x10
+#define BCSR1_SSON        0x08
+#define BCSR1_MODWIDTH        0x04
+#define BCSR1_RSTCONF        0x02
+
+#define BCSR2_CS0L_CS0X        0x80
+#define BCSR2_ENCS7FLSH        0x40
+#define BCSR2_GFWP        0x20
+#define BCSR2_ENNVRAM        0x10
+#define BCSR2_ALTIRQ2        0x08
+#define BCSR2_ALTIRQ3        0x04
+#define BCSR2_PRST        0x02
+#define BCSR2_ENPRST        0x01

--- /dev/null
+++ linux/arch/ppc/platforms/ep8260_setup.c
@@ -0,0 +1,131 @@
+/*
+ * arch/ppc/platforms/ep8260_setup.c
+ *
+ * EP8260 platform support
+ *
+ * Author: John Whitney <john.whitney@timesys.com>
+ * Derived from: est8260_setup.c
+ *
+ * Copyright 2003 TimeSys Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/seq_file.h>
+
+#include <asm/mpc8260.h>
+#include <asm/immap_8260.h>
+#include <asm/machdep.h>
+#include <asm/todc.h>
+#include <asm/io.h>
+
+extern void m8260_init(unsigned long r3, unsigned long r4,
+                       unsigned long r5, unsigned long r6, unsigned 
long r7);
+static void (*extra_setup_arch) (void);
+static volatile unsigned char *bcsr = NULL;
+
+TODC_ALLOC ();
+
+static int
+ep8260_show_cpuinfo(struct seq_file *m)
+{
+    bd_t    *binfo = (bd_t *)__res;
+
+    seq_printf(m, "vendor\t\t: Embedded Planet\n"
+              "machine\t\t: MPC8260\n"
+              "\n"
+              "mem size\t\t: 0x%08x\n"
+              "console baud\t\t: %d\n"
+              "\n",
+              binfo->bi_memsize,
+              binfo->bi_baudrate);
+    return 0;
+}
+
+static void
+ep8260_restart (char *cmd)
+{
+    /*
+     * Hit the reset (and reset enable) bit in BCSR2.
+     */
+    bcsr[2] |= (BCSR2_PRST | BCSR2_ENPRST);
+
+    /*
+     * Never to return...
+     */
+}
+
+static void __init
+ep8260_setup_arch(void)
+{
+    unsigned char *nvram_base;
+    bd_t          *bd = (bd_t *) __res;
+
+    printk("Embedded Planet EP8260\n");
+
+    /*
+     * Check for the 8260A processor, and work around SUI18 errata if
+     * detected.  This is done by clearing the PLDP bit of the BCR 
register,
+     * setting the pipeline depth to one.
+     */
+    if (PVR_VER(mfspr(PVR)) == 0x8081)
+        ((volatile immap_t *) IMAP_ADDR)->im_siu_conf.sc_bcr &= 
~(0x00800000);
+
+    bcsr = (volatile unsigned char *) ioremap (EP8260_BCSR0_ADDR, 16);
+    if (bcsr == NULL)
+    {
+        printk ("ep8260_setup_arch(): Unable to remap BCSR memory 
area.\n");
+    }
+
+    else if (bd->bi_nvram_size > 0)
+    {
+        /*
+         * Enable NVRAM access via the BCSR2 register.
+         */
+        bcsr[2] |= BCSR2_ENNVRAM;
+
+        nvram_base = ioremap (EP8260_NVRAM_ADDR, bd->bi_nvram_size);
+        if (nvram_base != NULL)
+        {
+            TODC_INIT (TODC_TYPE_DS1556, 0, 0, nvram_base, 0);
+            todc_info->nvdata_start = 0;
+            todc_info->nvdata_stop  = TODC_TYPE_DS1556_FLAGS;
+
+            ppc_md.time_init = todc_time_init;
+            ppc_md.set_rtc_time = todc_set_rtc_time;
+            ppc_md.get_rtc_time = todc_get_rtc_time;
+//            ppc_md.calibrate_decr = todc_calibrate_decr;
+            ppc_md.nvram_read_val  = todc_direct_read_val;
+            ppc_md.nvram_write_val = todc_direct_write_val;
+        }
+        else
+        {
+            printk ("ep8260_setup_arch(): Unable to map NVRAM into 
address map.\n");
+        }
+    }
+
+    extra_setup_arch ();
+
+    return;
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+          unsigned long r6, unsigned long r7)
+{
+    immr = (immap_t *) IMAP_ADDR;
+
+    /* Generic 8260 platform initialization */
+    m8260_init(r3, r4, r5, r6, r7);
+
+    /* Anything special for this platform */
+    ppc_md.show_cpuinfo    = ep8260_show_cpuinfo;
+
+    extra_setup_arch  = ppc_md.setup_arch;
+    ppc_md.setup_arch = ep8260_setup_arch;
+    ppc_md.restart    = ep8260_restart;
+}

--- linux-orig/arch/ppc/syslib/Makefile
+++ linux/arch/ppc/syslib/Makefile
@@ -34,11 +34,11 @@
 obj-$(CONFIG_POWER4)        += open_pic2.o
 obj-$(CONFIG_PPC_CHRP)        += open_pic.o indirect_pci.o i8259.o
 obj-$(CONFIG_PPC_PREP)        += open_pic.o indirect_pci.o i8259.o 
todc_time.o
+obj-$(CONFIG_GT64260)        += gt64260_common.o gt64260_pic.o
 obj-$(CONFIG_ADIR)        += i8259.o indirect_pci.o pci_auto.o \
                     todc_time.o
 obj-$(CONFIG_EBONY)        += indirect_pci.o pci_auto.o todc_time.o
-obj-$(CONFIG_EV64260)        += gt64260_common.o gt64260_pic.o \
-                    indirect_pci.o todc_time.o pci_auto.o
+obj-$(CONFIG_EV64260)        += indirect_pci.o todc_time.o pci_auto.o
 obj-$(CONFIG_GEMINI)        += open_pic.o indirect_pci.o
 obj-$(CONFIG_K2)        += i8259.o indirect_pci.o todc_time.o \
                     pci_auto.o
@@ -63,6 +63,7 @@
 obj-$(CONFIG_SPRUCE)        += cpc700_pic.o indirect_pci.o pci_auto.o \
                    todc_time.o
 obj-$(CONFIG_8260)        += m8260_setup.o ppc8260_pic.o
+obj-$(CONFIG_EP8260)    += todc_time.o todc_nvram.o
 ifeq ($(CONFIG_PPC_GEN550),y)
 obj-$(CONFIG_KGDB)        += gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)    += gen550_dbg.o
--- /dev/null
+++ linux/arch/ppc/syslib/todc_nvram.c
@@ -0,0 +1,282 @@
+/*
+ * arch/ppc/kernel/todc_time.c
+ *
+ * NVRAM support for the M48T35, M48T37, M48T59, and MC146818
+ *
+ */
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/todc.h>
+
+#define TODC_NVRAM_VERSION "1.0"
+
+static int nvram_open_count;
+static int nvram_open_mode;
+
+typedef struct
+    {
+    unsigned long magic_number;
+    unsigned long file_length;
+    }
+    nvram_trailer_t;
+
+enum
+    {
+    NVRAM_WRITE        = 1,
+    NVRAM_EXCLUSIVE = 2
+    };
+
+#define NVRAM_MAGIC_NUMBER   0x6e766d6e
+#define NVRAM_SIZE           (todc_info->nvdata_stop - 
todc_info->nvdata_start)
+#define NVRAM_TRAILER_OFFSET (todc_info->nvdata_stop - sizeof 
(nvram_trailer_t))
+static nvram_trailer_t       todc_nvram_trailer;
+
+/*
+ * Forward prototypes
+ */
+static long long todc_nvram_llseek (struct file    *file,
+                                    loff_t    offset,
+                                    int        origin);
+static ssize_t todc_nvram_read (struct file    *file,
+                                char        *buffer,
+                                size_t        count,
+                                loff_t        *ppos);
+static ssize_t todc_nvram_write (struct file    *file,
+                                 const char    *buffer,
+                                 size_t        count,
+                                 loff_t        *ppos);
+static int todc_nvram_ioctl (struct inode    *inode,
+                             struct file    *file,
+                             unsigned int    cmd,
+                             unsigned long    arg);
+static int todc_nvram_open (struct inode *inode, struct file *file);
+static int todc_nvram_release (struct inode *inode, struct file *file);
+
+static struct file_operations todc_nvram_fops =
+    {
+    owner:   THIS_MODULE,
+    llseek:  todc_nvram_llseek,
+    read:    todc_nvram_read,
+    write:   todc_nvram_write,
+    ioctl:   todc_nvram_ioctl,
+    open:    todc_nvram_open,
+    release: todc_nvram_release,
+    };
+
+static struct miscdevice todc_nvram_device =
+    {
+    NVRAM_MINOR,
+    "nvram",
+    &todc_nvram_fops
+    };
+
+static void todc_nvram_read_trailer (nvram_trailer_t *trailer)
+{
+    char *p = (char *) trailer;
+    int  index;
+
+    for (index = 0; index < sizeof (nvram_trailer_t); index++)
+    *p++ = ppc_md.nvram_read_val (NVRAM_TRAILER_OFFSET + index);
+
+    return;
+}
+
+static void todc_nvram_write_trailer (nvram_trailer_t *trailer)
+{
+    char    *p = (char *) trailer;
+    int        index;
+
+    for (index = 0; index < sizeof (nvram_trailer_t); index++)
+    {
+        ppc_md.nvram_write_val (NVRAM_TRAILER_OFFSET + index, *p++);
+    }
+
+    return;
+}
+
+
+int __init todc_nvram_init (void)
+{
+    int index;
+
+    if ((todc_info == NULL) ||
+        (todc_info->nvdata_start == todc_info->nvdata_stop) ||
+        (ppc_md.nvram_read_val == NULL) ||
+        (ppc_md.nvram_write_val == NULL))
+        return -ENODEV;
+
+    /*
+     * Tell the user that the driver is loaded.
+     */
+    printk (KERN_INFO "TODC non-volatile memory driver v"
+            TODC_NVRAM_VERSION "\n");
+
+    if (misc_register (&todc_nvram_device) != 0)
+    {
+        printk (KERN_ERR "Unable to register misc/nvram device.\n");
+        return -EINVAL;
+    }
+
+    todc_nvram_read_trailer (&todc_nvram_trailer);
+    if (todc_nvram_trailer.magic_number != NVRAM_MAGIC_NUMBER)
+    {
+        printk ("  Invalid NVRAM image... clearing.\n");
+        for (index = todc_info->nvdata_start;
+             index < todc_info->nvdata_stop;
+             index++)
+        {
+            ppc_md.nvram_write_val (index, 0);
+        }
+
+        todc_nvram_trailer.file_length = 0;
+        todc_nvram_trailer.magic_number = NVRAM_MAGIC_NUMBER;
+        todc_nvram_write_trailer (&todc_nvram_trailer);
+    }
+
+    return 0;
+}
+
+static void __exit todc_nvram_exit (void)
+{
+    misc_deregister (&todc_nvram_device);
+
+    return;
+}
+
+module_init (todc_nvram_init);
+module_exit (todc_nvram_exit);
+
+static long long todc_nvram_llseek (struct file    *file,
+                                    loff_t    offset,
+                                    int        origin)
+{
+    switch (origin)
+    {
+        case 0: /* SEEK_SET */
+            break;
+
+        case 1: /* SEEK_CUR */
+            offset += file->f_pos;
+            break;
+
+        case 2: /* SEEK_END */
+            offset += todc_nvram_trailer.file_length;
+            break;
+    }
+
+    return (offset >= 0) ? (file->f_pos = offset) : -EINVAL;
+}
+
+static ssize_t todc_nvram_read (struct file    *file,
+                                char        *buffer,
+                                size_t        count,
+                                loff_t        *ppos)
+{
+    loff_t    index = *ppos;
+    char    *p = buffer;
+
+    if (verify_area (VERIFY_WRITE, buffer, count))
+        return -EFAULT;
+
+    if (*ppos >= todc_nvram_trailer.file_length)
+        return 0;
+
+    for (index = *ppos;
+         (count > 0) && (index < todc_nvram_trailer.file_length);
+         index++, p++, count--)
+    {
+        if (__put_user (ppc_md.nvram_read_val (todc_info->nvdata_start 
+ index),
+                        p))
+            return -EFAULT;
+    }
+
+    *ppos = index;
+    return (p - buffer);
+}
+
+static ssize_t todc_nvram_write (struct file    *file,
+                                 const char    *buffer,
+                                 size_t        count,
+                                 loff_t        *ppos)
+{
+    loff_t    index = *ppos;
+    const char    *p = buffer;
+    char    c;
+
+    if (verify_area (VERIFY_READ, buffer, count))
+        return -EFAULT;
+
+    if (*ppos >= NVRAM_TRAILER_OFFSET)
+        return 0;
+
+    for (index = *ppos;
+         (count > 0) && (index < NVRAM_TRAILER_OFFSET);
+         index++, p++, count--)
+    {
+        if (__get_user (c, p))
+            return -EFAULT;
+        ppc_md.nvram_write_val (todc_info->nvdata_start + index, c);
+    }
+
+    *ppos = index;
+    if (index > todc_nvram_trailer.file_length)
+        todc_nvram_trailer.file_length = index;
+
+    return (p - buffer);
+}
+
+static int todc_nvram_ioctl (struct inode    *inode,
+                             struct file    *file,
+                             unsigned int    cmd,
+                             unsigned long    arg)
+{
+    switch (cmd)
+    {
+        default:
+            return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int todc_nvram_open (struct inode *inode, struct file *file)
+{
+    if ((nvram_open_count && (file->f_flags & O_EXCL)) ||
+        (nvram_open_mode & NVRAM_EXCLUSIVE) ||
+        ((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE)))
+        return -EBUSY;
+
+    if (file->f_flags & O_EXCL)
+        nvram_open_mode |= NVRAM_EXCLUSIVE;
+
+    if (file->f_mode & 2)
+    {
+        nvram_open_mode |= NVRAM_WRITE;
+        if ((file->f_mode & 1) == 0)
+            todc_nvram_trailer.file_length = 0;
+    }
+
+    nvram_open_count += 1;
+    return 0;
+}
+
+static int todc_nvram_release (struct inode *inode, struct file *file)
+{
+    nvram_open_count -= 1;
+
+    if (file->f_flags & O_EXCL)
+        nvram_open_mode &= ~NVRAM_EXCLUSIVE;
+
+    if (file->f_mode & 2)
+        nvram_open_mode &= ~NVRAM_WRITE;
+
+    todc_nvram_write_trailer (&todc_nvram_trailer);
+    return 0;
+}

--- linux-orig/include/asm-ppc/io.h
+++ linux/include/asm-ppc/io.h
@@ -70,6 +70,70 @@
 #define __raw_writel(v, addr)    (*(volatile unsigned int *)(addr) = (v))
 
 /*
+ * For reading and writing 64-bit values, we need to use the floating point
+ * registers.  The code will enable MSR_FP in the MSR register, use FPR1 to
+ * read from and write to memory, and then restore everything to the
+ * previous values.
+ */
+static inline unsigned long long __raw_readll (int addr)
+{
+    unsigned long flags;
+    unsigned long msr;
+    unsigned long msr_save;
+    unsigned long long result;
+    unsigned long long fp_save;
+
+    local_irq_save (flags);
+    asm volatile ("sync\n"
+                  "mfmsr    %0\n"
+                  "ori        %1,%0,0x2000\n"
+                  "mtmsr    %1\n"
+                  "isync\n"
+                  "stfdx    1,0,%2\n"
+                  "lfdx        1,0,%4\n"
+                  "stfdx    1,0,%3\n"
+                  "sync\n"
+                  "lfdx        1,0,%2\n"
+                  "mtmsr    %0\n"
+                  "sync\n"
+                  "isync\n"
+                  : "=&r" (msr_save), "=&r" (msr)
+                  : "r" (&fp_save), "r" (&result), "r" (addr)
+                  : "memory" );
+    local_irq_restore (flags);
+
+    return result;
+}
+
+static inline void __raw_writell (unsigned long long value, int addr)
+{
+    unsigned long flags;
+    unsigned long msr;
+    unsigned long msr_save;
+    unsigned long long fp_save;
+
+    local_irq_save (flags);
+    asm volatile ("sync\n"
+                  "mfmsr    %0\n"
+                  "ori        %1,%0,0x2000\n"
+                  "mtmsr    %1\n"
+                  "isync\n"
+                  "stfdx    1,0,%2\n"
+                  "lfdx        1,0,%3\n"
+                  "stfdx    1,0,%4\n"
+                  "sync\n"
+                  "lfdx        1,0,%2\n"
+                  "mtmsr    %0\n"
+                  "sync\n"
+                  "isync\n"
+                  : "=&r" (msr_save), "=&r" (msr)
+                  : "r" (&fp_save), "r" (&value), "r" (addr)
+                  : "memory" );
+    local_irq_restore (flags);
+    return;
+}
+
+/*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.
  * They are only used in practice for transferring buffers which
  * are arrays of bytes, and byte-swapping is not appropriate in
--- linux-orig/include/asm-ppc/mpc8260.h
+++ linux/include/asm-ppc/mpc8260.h
@@ -16,6 +16,10 @@
 #include <platforms/est8260.h>
 #endif
 
+#ifdef CONFIG_EP8260
+#include <platforms/ep8260.h>
+#endif
+
 #ifdef CONFIG_SBS8260
 #include <platforms/sbs8260.h>
 #endif
--- linux-orig/include/asm-ppc/todc.h
+++ linux/include/asm-ppc/todc.h
@@ -34,6 +34,13 @@
     unsigned int nvram_data;
 
     /*
+     * Following are start and stop indexes for valid NVRAM data access.
+     * These are used by todc_nvram.c.
+     */
+    unsigned int nvdata_start;
+    unsigned int nvdata_stop;
+
+    /*
      * Define bits to stop external set of regs from changing so
      * the chip can be read/written reliably.
      */
@@ -98,6 +105,7 @@
 #define TODC_TYPE_PC97307        10    /* PC97307 internal RTC */
 #define TODC_TYPE_DS1557        11    /* Dallas DS1557 RTC */
 #define TODC_TYPE_DS17285        12    /* Dallas DS17285 RTC */
+#define TODC_TYPE_DS1556        13    /* Dallas DS1556 RTC */
 #define    TODC_TYPE_MC146818        100    /* Leave room for m48txx's */
 
 /*
@@ -208,6 +216,28 @@
 #define    TODC_TYPE_DS1501_NVRAM_ADDR_REG    0x10
 #define    TODC_TYPE_DS1501_NVRAM_DATA_REG    0x13
 
+#define    TODC_TYPE_DS1556_NVRAM_SIZE        0x7fff0
+#define    TODC_TYPE_DS1556_SW_FLAGS        0
+#define    TODC_TYPE_DS1556_YEAR            0x1ffff
+#define    TODC_TYPE_DS1556_MONTH            0x1fffe
+#define    TODC_TYPE_DS1556_DOM            0x1fffd    /* Day of Month */
+#define    TODC_TYPE_DS1556_DOW            0x1fffc    /* Day of Week */
+#define    TODC_TYPE_DS1556_HOURS            0x1fffb
+#define    TODC_TYPE_DS1556_MINUTES        0x1fffa
+#define    TODC_TYPE_DS1556_SECONDS        0x1fff9
+#define    TODC_TYPE_DS1556_CNTL_B            0x1fff9
+#define    TODC_TYPE_DS1556_CNTL_A            0x1fff8    /* control_a 
R/W regs */
+#define    TODC_TYPE_DS1556_WATCHDOG        0x1fff7
+#define    TODC_TYPE_DS1556_INTERRUPTS        0x1fff6
+#define    TODC_TYPE_DS1556_ALARM_DATE        0x1fff5
+#define    TODC_TYPE_DS1556_ALARM_HOUR        0x1fff4
+#define    TODC_TYPE_DS1556_ALARM_MINUTES        0x1fff3
+#define    TODC_TYPE_DS1556_ALARM_SECONDS        0x1fff2
+#define    TODC_TYPE_DS1556_CENTURY        0x1fff8
+#define    TODC_TYPE_DS1556_FLAGS            0x1fff0
+#define    TODC_TYPE_DS1556_NVRAM_ADDR_REG        0
+#define    TODC_TYPE_DS1556_NVRAM_DATA_REG        0
+
 #define    TODC_TYPE_DS1557_NVRAM_SIZE        0x7fff0
 #define    TODC_TYPE_DS1557_SW_FLAGS        0
 #define    TODC_TYPE_DS1557_YEAR            0x7ffff
@@ -448,6 +478,8 @@
                                     \
     todc_info->nvram_addr_reg = clock_type ##_NVRAM_ADDR_REG;    \
     todc_info->nvram_data_reg = clock_type ##_NVRAM_DATA_REG;    \
+    todc_info->nvdata_start  = 0;                     \
+    todc_info->nvdata_stop   = 0;                     \
 }
 
 extern todc_info_t *todc_info;

