Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWJILsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWJILsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWJILsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:48:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40078 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932583AbWJILsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:48:45 -0400
Date: Mon, 9 Oct 2006 12:48:42 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARCH=ppc pt_regs fixes
Message-ID: <20061009114842.GO29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ppc/4xx_io/serial_sicc.c       |   10 +++++-----
 arch/ppc/8260_io/enet.c             |    4 ++--
 arch/ppc/8260_io/fcc_enet.c         |    6 +++---
 arch/ppc/8xx_io/commproc.c          |   19 +++++++++----------
 arch/ppc/8xx_io/cs4218_tdm.c        |    4 ++--
 arch/ppc/8xx_io/enet.c              |    4 ++--
 arch/ppc/8xx_io/fec.c               |    7 +++----
 arch/ppc/kernel/smp.c               |    4 ++--
 arch/ppc/platforms/apus_setup.c     |    2 +-
 arch/ppc/platforms/hdpu.c           |   22 ++++++++++------------
 arch/ppc/platforms/radstone_ppc7d.c |   10 +++++-----
 arch/ppc/platforms/sbc82xx.c        |    4 ++--
 arch/ppc/syslib/cpc700.h            |    2 +-
 arch/ppc/syslib/cpc700_pic.c        |    2 +-
 arch/ppc/syslib/cpm2_pic.c          |    2 +-
 arch/ppc/syslib/cpm2_pic.h          |    2 +-
 arch/ppc/syslib/gt64260_pic.c       |    9 +++------
 arch/ppc/syslib/ibm440gx_common.c   |    2 +-
 arch/ppc/syslib/ipic.c              |    2 +-
 arch/ppc/syslib/m82xx_pci.c         |    4 ++--
 arch/ppc/syslib/m8xx_setup.c        |    2 +-
 arch/ppc/syslib/m8xx_wdt.c          |    4 ++--
 arch/ppc/syslib/mpc52xx_pic.c       |    2 +-
 arch/ppc/syslib/mv64360_pic.c       |   18 +++++++-----------
 arch/ppc/syslib/open_pic2.c         |    2 +-
 arch/ppc/syslib/ppc403_pic.c        |    2 +-
 arch/ppc/syslib/ppc4xx_pic.c        |    8 ++++----
 arch/ppc/syslib/ppc85xx_rio.c       |    9 +++------
 arch/ppc/syslib/ppc8xx_pic.c        |    4 ++--
 arch/ppc/syslib/xilinx_pic.c        |    2 +-
 include/asm-ppc/commproc.h          |    3 +--
 include/asm-ppc/gt64260.h           |    2 +-
 include/asm-ppc/mpc52xx.h           |    2 +-
 include/asm-ppc/mv64x60.h           |    4 ++--
 34 files changed, 85 insertions(+), 100 deletions(-)

diff --git a/arch/ppc/4xx_io/serial_sicc.c b/arch/ppc/4xx_io/serial_sicc.c
index 87fe9a8..e354839 100644
--- a/arch/ppc/4xx_io/serial_sicc.c
+++ b/arch/ppc/4xx_io/serial_sicc.c
@@ -414,7 +414,7 @@ static void siccuart_event(struct SICC_i
 }
 
 static void
-siccuart_rx_chars(struct SICC_info *info, struct pt_regs *regs)
+siccuart_rx_chars(struct SICC_info *info)
 {
     struct tty_struct *tty = info->tty;
     unsigned int status, ch, rsr, flg, ignored = 0;
@@ -441,7 +441,7 @@ siccuart_rx_chars(struct SICC_info *info
 #ifdef SUPPORT_SYSRQ
         if (info->sysrq) {
             if (ch && time_before(jiffies, info->sysrq)) {
-                handle_sysrq(ch, regs, NULL);
+                handle_sysrq(ch, NULL);
                 info->sysrq = 0;
                 goto ignore_char;
             }
@@ -553,15 +553,15 @@ static void siccuart_tx_chars(struct SIC
 }
 
 
-static irqreturn_t siccuart_int_rx(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t siccuart_int_rx(int irq, void *dev_id)
 {
     struct SICC_info *info = dev_id;
-    siccuart_rx_chars(info, regs);
+    siccuart_rx_chars(info)
     return IRQ_HANDLED;
 }
 
 
-static irqreturn_t siccuart_int_tx(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t siccuart_int_tx(int irq, void *dev_id)
 {
     struct SICC_info *info = dev_id;
     siccuart_tx_chars(info);
diff --git a/arch/ppc/8260_io/enet.c b/arch/ppc/8260_io/enet.c
index ac6d55f..a6056c2 100644
--- a/arch/ppc/8260_io/enet.c
+++ b/arch/ppc/8260_io/enet.c
@@ -122,7 +122,7 @@ struct scc_enet_private {
 static int scc_enet_open(struct net_device *dev);
 static int scc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int scc_enet_rx(struct net_device *dev);
-static irqreturn_t scc_enet_interrupt(int irq, void *dev_id, struct pt_regs *);
+static irqreturn_t scc_enet_interrupt(int irq, void *dev_id);
 static int scc_enet_close(struct net_device *dev);
 static struct net_device_stats *scc_enet_get_stats(struct net_device *dev);
 static void set_multicast_list(struct net_device *dev);
@@ -273,7 +273,7 @@ #endif
  * This is called from the CPM handler, not the MPC core interrupt.
  */
 static irqreturn_t
-scc_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+scc_enet_interrupt(int irq, void * dev_id)
 {
 	struct	net_device *dev = dev_id;
 	volatile struct	scc_enet_private *cep;
diff --git a/arch/ppc/8260_io/fcc_enet.c b/arch/ppc/8260_io/fcc_enet.c
index e347fe8..2e1943e 100644
--- a/arch/ppc/8260_io/fcc_enet.c
+++ b/arch/ppc/8260_io/fcc_enet.c
@@ -140,7 +140,7 @@ #define PKT_MAXBLR_SIZE		1536
 static int fcc_enet_open(struct net_device *dev);
 static int fcc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int fcc_enet_rx(struct net_device *dev);
-static irqreturn_t fcc_enet_interrupt(int irq, void *dev_id, struct pt_regs *);
+static irqreturn_t fcc_enet_interrupt(int irq, void *dev_id);
 static int fcc_enet_close(struct net_device *dev);
 static struct net_device_stats *fcc_enet_get_stats(struct net_device *dev);
 /* static void set_multicast_list(struct net_device *dev); */
@@ -524,7 +524,7 @@ #endif
 
 /* The interrupt handler. */
 static irqreturn_t
-fcc_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+fcc_enet_interrupt(int irq, void * dev_id)
 {
 	struct	net_device *dev = dev_id;
 	volatile struct	fcc_enet_private *cep;
@@ -1563,7 +1563,7 @@ #endif	/* CONFIG_USE_MDIO */
 #ifdef PHY_INTERRUPT
 /* This interrupt occurs when the PHY detects a link change. */
 static irqreturn_t
-mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+mii_link_interrupt(int irq, void * dev_id)
 {
 	struct	net_device *dev = dev_id;
 	struct fcc_enet_private *fep = dev->priv;
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 9b3ace2..3b23bcb 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -47,12 +47,12 @@ cpm8xx_t	*cpmp;		/* Pointer to comm proc
 /* CPM interrupt vector functions.
 */
 struct	cpm_action {
-	void	(*handler)(void *, struct pt_regs * regs);
+	void	(*handler)(void *);
 	void	*dev_id;
 };
 static	struct	cpm_action cpm_vecs[CPMVEC_NR];
-static	irqreturn_t cpm_interrupt(int irq, void * dev, struct pt_regs * regs);
-static	irqreturn_t cpm_error_interrupt(int irq, void *dev, struct pt_regs * regs);
+static	irqreturn_t cpm_interrupt(int irq, void * dev);
+static	irqreturn_t cpm_error_interrupt(int irq, void *dev);
 static	void	alloc_host_memory(void);
 /* Define a table of names to identify CPM interrupt handlers in
  * /proc/interrupts.
@@ -205,7 +205,7 @@ cpm_interrupt_init(void)
  * Get the CPM interrupt vector.
  */
 int
-cpm_get_irq(struct pt_regs *regs)
+cpm_get_irq(void)
 {
 	int cpm_vec;
 
@@ -222,7 +222,7 @@ cpm_get_irq(struct pt_regs *regs)
 /* CPM interrupt controller cascade interrupt.
 */
 static	irqreturn_t
-cpm_interrupt(int irq, void * dev, struct pt_regs * regs)
+cpm_interrupt(int irq, void * dev)
 {
 	/* This interrupt handler never actually gets called.  It is
 	 * installed only to unmask the CPM cascade interrupt in the SIU
@@ -237,7 +237,7 @@ cpm_interrupt(int irq, void * dev, struc
  * tests in the interrupt handler.
  */
 static	irqreturn_t
-cpm_error_interrupt(int irq, void *dev, struct pt_regs *regs)
+cpm_error_interrupt(int irq, void *dev)
 {
 	return IRQ_HANDLED;
 }
@@ -246,11 +246,11 @@ cpm_error_interrupt(int irq, void *dev, 
  * request_irq() to the handler prototype required by cpm_install_handler().
  */
 static irqreturn_t
-cpm_handler_helper(int irq, void *dev_id, struct pt_regs *regs)
+cpm_handler_helper(int irq, void *dev_id)
 {
 	int cpm_vec = irq - CPM_IRQ_OFFSET;
 
-	(*cpm_vecs[cpm_vec].handler)(dev_id, regs);
+	(*cpm_vecs[cpm_vec].handler)(dev_id);
 
 	return IRQ_HANDLED;
 }
@@ -267,8 +267,7 @@ cpm_handler_helper(int irq, void *dev_id
  * request_irq() or cpm_install_handler().
  */
 void
-cpm_install_handler(int cpm_vec, void (*handler)(void *, struct pt_regs *regs),
-		    void *dev_id)
+cpm_install_handler(int cpm_vec, void (*handler)(void *), void *dev_id)
 {
 	int err;
 
diff --git a/arch/ppc/8xx_io/cs4218_tdm.c b/arch/ppc/8xx_io/cs4218_tdm.c
index f5f300f..959d31c 100644
--- a/arch/ppc/8xx_io/cs4218_tdm.c
+++ b/arch/ppc/8xx_io/cs4218_tdm.c
@@ -331,7 +331,7 @@ static int CS_SetFormat(int format);
 static int CS_SetVolume(int volume);
 static void cs4218_tdm_tx_intr(void *devid);
 static void cs4218_tdm_rx_intr(void *devid);
-static void cs4218_intr(void *devid, struct pt_regs *regs);
+static void cs4218_intr(void *devid);
 static int cs_get_volume(uint reg);
 static int cs_volume_setter(int volume, int mute);
 static int cs_get_gain(uint reg);
@@ -2646,7 +2646,7 @@ #endif
  * full duplex operation.
  */
 static void
-cs4218_intr(void *dev_id, struct pt_regs *regs)
+cs4218_intr(void *dev_id)
 {
 	volatile smc_t	*sp;
 	volatile cpm8xx_t	*cp;
diff --git a/arch/ppc/8xx_io/enet.c b/arch/ppc/8xx_io/enet.c
index a695375..b23c45b 100644
--- a/arch/ppc/8xx_io/enet.c
+++ b/arch/ppc/8xx_io/enet.c
@@ -149,7 +149,7 @@ struct scc_enet_private {
 static int scc_enet_open(struct net_device *dev);
 static int scc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int scc_enet_rx(struct net_device *dev);
-static void scc_enet_interrupt(void *dev_id, struct pt_regs *regs);
+static void scc_enet_interrupt(void *dev_id);
 static int scc_enet_close(struct net_device *dev);
 static struct net_device_stats *scc_enet_get_stats(struct net_device *dev);
 static void set_multicast_list(struct net_device *dev);
@@ -305,7 +305,7 @@ #endif
  * This is called from the CPM handler, not the MPC core interrupt.
  */
 static void
-scc_enet_interrupt(void *dev_id, struct pt_regs *regs)
+scc_enet_interrupt(void *dev_id)
 {
 	struct	net_device *dev = dev_id;
 	volatile struct	scc_enet_private *cep;
diff --git a/arch/ppc/8xx_io/fec.c b/arch/ppc/8xx_io/fec.c
index 8b6295b..2f9fa9e 100644
--- a/arch/ppc/8xx_io/fec.c
+++ b/arch/ppc/8xx_io/fec.c
@@ -198,8 +198,7 @@ static int fec_enet_start_xmit(struct sk
 #ifdef	CONFIG_USE_MDIO
 static void fec_enet_mii(struct net_device *dev);
 #endif	/* CONFIG_USE_MDIO */
-static irqreturn_t fec_enet_interrupt(int irq, void * dev_id,
-		       					struct pt_regs * regs);
+static irqreturn_t fec_enet_interrupt(int irq, void * dev_id);
 #ifdef CONFIG_FEC_PACKETHOOK
 static void  fec_enet_tx(struct net_device *dev, __u32 regval);
 static void  fec_enet_rx(struct net_device *dev, __u32 regval);
@@ -472,7 +471,7 @@ #endif
  * This is called from the MPC core interrupt.
  */
 static	irqreturn_t
-fec_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+fec_enet_interrupt(int irq, void * dev_id)
 {
 	struct	net_device *dev = dev_id;
 	volatile fec_t	*fecp;
@@ -1408,7 +1407,7 @@ static
 #ifdef CONFIG_RPXCLASSIC
 void mii_link_interrupt(void *dev_id)
 #else
-irqreturn_t mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+irqreturn_t mii_link_interrupt(int irq, void * dev_id)
 #endif
 {
 #ifdef	CONFIG_USE_MDIO
diff --git a/arch/ppc/kernel/smp.c b/arch/ppc/kernel/smp.c
index ca57e89..96a5597 100644
--- a/arch/ppc/kernel/smp.c
+++ b/arch/ppc/kernel/smp.c
@@ -84,7 +84,7 @@ smp_message_pass(int target, int msg)
 /*
  * Common functions
  */
-void smp_message_recv(int msg, struct pt_regs *regs)
+void smp_message_recv(int msg)
 {
 	atomic_inc(&ipi_recv);
 
@@ -100,7 +100,7 @@ void smp_message_recv(int msg, struct pt
 		break;
 #ifdef CONFIG_XMON
 	case PPC_MSG_XMON_BREAK:
-		xmon(regs);
+		xmon(get_irq_regs());
 		break;
 #endif /* CONFIG_XMON */
 	default:
diff --git a/arch/ppc/platforms/apus_setup.c b/arch/ppc/platforms/apus_setup.c
index 1d034ea..063274d 100644
--- a/arch/ppc/platforms/apus_setup.c
+++ b/arch/ppc/platforms/apus_setup.c
@@ -492,7 +492,7 @@ apus_halt(void)
 
 static unsigned char last_ipl[8];
 
-int apus_get_irq(struct pt_regs* regs)
+int apus_get_irq(void)
 {
 	unsigned char ipl_emu, mask;
 	unsigned int level;
diff --git a/arch/ppc/platforms/hdpu.c b/arch/ppc/platforms/hdpu.c
index e0f112a..d809e17 100644
--- a/arch/ppc/platforms/hdpu.c
+++ b/arch/ppc/platforms/hdpu.c
@@ -659,8 +659,7 @@ #ifdef CONFIG_SMP
 char hdpu_smp0[] = "SMP Cpu #0";
 char hdpu_smp1[] = "SMP Cpu #1";
 
-static irqreturn_t hdpu_smp_cpu0_int_handler(int irq, void *dev_id,
-					     struct pt_regs *regs)
+static irqreturn_t hdpu_smp_cpu0_int_handler(int irq, void *dev_id)
 {
 	volatile unsigned int doorbell;
 
@@ -670,22 +669,21 @@ static irqreturn_t hdpu_smp_cpu0_int_han
 	mv64x60_write(&bh, MV64360_CPU0_DOORBELL_CLR, doorbell);
 
 	if (doorbell & 1) {
-		smp_message_recv(0, regs);
+		smp_message_recv(0);
 	}
 	if (doorbell & 2) {
-		smp_message_recv(1, regs);
+		smp_message_recv(1);
 	}
 	if (doorbell & 4) {
-		smp_message_recv(2, regs);
+		smp_message_recv(2);
 	}
 	if (doorbell & 8) {
-		smp_message_recv(3, regs);
+		smp_message_recv(3);
 	}
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t hdpu_smp_cpu1_int_handler(int irq, void *dev_id,
-					     struct pt_regs *regs)
+static irqreturn_t hdpu_smp_cpu1_int_handler(int irq, void *dev_id)
 {
 	volatile unsigned int doorbell;
 
@@ -695,16 +693,16 @@ static irqreturn_t hdpu_smp_cpu1_int_han
 	mv64x60_write(&bh, MV64360_CPU1_DOORBELL_CLR, doorbell);
 
 	if (doorbell & 1) {
-		smp_message_recv(0, regs);
+		smp_message_recv(0);
 	}
 	if (doorbell & 2) {
-		smp_message_recv(1, regs);
+		smp_message_recv(1);
 	}
 	if (doorbell & 4) {
-		smp_message_recv(2, regs);
+		smp_message_recv(2);
 	}
 	if (doorbell & 8) {
-		smp_message_recv(3, regs);
+		smp_message_recv(3);
 	}
 	return IRQ_HANDLED;
 }
diff --git a/arch/ppc/platforms/radstone_ppc7d.c b/arch/ppc/platforms/radstone_ppc7d.c
index 3bb530a..13d70ab 100644
--- a/arch/ppc/platforms/radstone_ppc7d.c
+++ b/arch/ppc/platforms/radstone_ppc7d.c
@@ -451,11 +451,11 @@ static void __init ppc7d_calibrate_decr(
  * Interrupt stuff
  *****************************************************************************/
 
-static irqreturn_t ppc7d_i8259_intr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t ppc7d_i8259_intr(int irq, void *dev_id)
 {
 	u32 temp = mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
 	if (temp & (1 << 28)) {
-		i8259_irq(regs);
+		i8259_irq();
 		mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, temp & (~(1 << 28)));
 		return IRQ_HANDLED;
 	}
@@ -536,13 +536,13 @@ static u32 ppc7d_irq_canonicalize(u32 ir
 	return irq;
 }
 
-static int ppc7d_get_irq(struct pt_regs *regs)
+static int ppc7d_get_irq(void)
 {
 	int irq;
 
-	irq = mv64360_get_irq(regs);
+	irq = mv64360_get_irq();
 	if (irq == (mv64360_irq_base + MV64x60_IRQ_GPP28))
-		irq = i8259_irq(regs);
+		irq = i8259_irq();
 	return irq;
 }
 
diff --git a/arch/ppc/platforms/sbc82xx.c b/arch/ppc/platforms/sbc82xx.c
index 60b769c..cc0935c 100644
--- a/arch/ppc/platforms/sbc82xx.c
+++ b/arch/ppc/platforms/sbc82xx.c
@@ -121,7 +121,7 @@ struct hw_interrupt_type sbc82xx_i8259_i
 	.end = sbc82xx_i8259_end_irq,
 };
 
-static irqreturn_t sbc82xx_i8259_demux(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t sbc82xx_i8259_demux(int irq, void *dev_id)
 {
 	spin_lock(&sbc82xx_i8259_lock);
 
@@ -139,7 +139,7 @@ static irqreturn_t sbc82xx_i8259_demux(i
 			return IRQ_HANDLED;
 		}
 	}
-	__do_IRQ(NR_SIU_INTS + irq, regs);
+	__do_IRQ(NR_SIU_INTS + irq);
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/ppc/syslib/cpc700.h b/arch/ppc/syslib/cpc700.h
index 0a8a5d8..987e9aa 100644
--- a/arch/ppc/syslib/cpc700.h
+++ b/arch/ppc/syslib/cpc700.h
@@ -91,6 +91,6 @@ extern struct hw_interrupt_type cpc700_p
 extern unsigned int cpc700_irq_assigns[32][2];
 
 extern void __init cpc700_init_IRQ(void);
-extern int cpc700_get_irq(struct pt_regs *);
+extern int cpc700_get_irq(void);
 
 #endif	/* __PPC_SYSLIB_CPC700_H__ */
diff --git a/arch/ppc/syslib/cpc700_pic.c b/arch/ppc/syslib/cpc700_pic.c
index 172aa21..d48e8f4 100644
--- a/arch/ppc/syslib/cpc700_pic.c
+++ b/arch/ppc/syslib/cpc700_pic.c
@@ -158,7 +158,7 @@ cpc700_init_IRQ(void)
  * Find the highest IRQ that generating an interrupt, if any.
  */
 int
-cpc700_get_irq(struct pt_regs *regs)
+cpc700_get_irq(void)
 {
 	int irq = 0;
 	u_int irq_status, irq_test = 1;
diff --git a/arch/ppc/syslib/cpm2_pic.c b/arch/ppc/syslib/cpm2_pic.c
index c0fee0b..fb2d584 100644
--- a/arch/ppc/syslib/cpm2_pic.c
+++ b/arch/ppc/syslib/cpm2_pic.c
@@ -123,7 +123,7 @@ static struct hw_interrupt_type cpm2_pic
 	.end = cpm2_end_irq,
 };
 
-int cpm2_get_irq(struct pt_regs *regs)
+int cpm2_get_irq(void)
 {
 	int irq;
         unsigned long bits;
diff --git a/arch/ppc/syslib/cpm2_pic.h b/arch/ppc/syslib/cpm2_pic.h
index 97cab8f..4673393 100644
--- a/arch/ppc/syslib/cpm2_pic.h
+++ b/arch/ppc/syslib/cpm2_pic.h
@@ -1,7 +1,7 @@
 #ifndef _PPC_KERNEL_CPM2_H
 #define _PPC_KERNEL_CPM2_H
 
-extern int cpm2_get_irq(struct pt_regs *regs);
+extern int cpm2_get_irq(void);
 
 extern void cpm2_init_IRQ(void);
 
diff --git a/arch/ppc/syslib/gt64260_pic.c b/arch/ppc/syslib/gt64260_pic.c
index 7fd550a..e84d432 100644
--- a/arch/ppc/syslib/gt64260_pic.c
+++ b/arch/ppc/syslib/gt64260_pic.c
@@ -110,9 +110,6 @@ gt64260_init_irq(void)
  *  This function returns the lowest interrupt number of all interrupts that
  *  are currently asserted.
  *
- * Input Variable(s):
- *  struct pt_regs*	not used
- *
  * Output Variable(s):
  *  None.
  *
@@ -120,7 +117,7 @@ gt64260_init_irq(void)
  *  int	<interrupt number> or -2 (bogus interrupt)
  */
 int
-gt64260_get_irq(struct pt_regs *regs)
+gt64260_get_irq(void)
 {
 	int irq;
 	int irq_gpp;
@@ -229,7 +226,7 @@ gt64260_mask_irq(unsigned int irq)
 }
 
 static irqreturn_t
-gt64260_cpu_error_int_handler(int irq, void *dev_id, struct pt_regs *regs)
+gt64260_cpu_error_int_handler(int irq, void *dev_id)
 {
 	printk(KERN_ERR "gt64260_cpu_error_int_handler: %s 0x%08x\n",
 		"Error on CPU interface - Cause regiser",
@@ -250,7 +247,7 @@ gt64260_cpu_error_int_handler(int irq, v
 }
 
 static irqreturn_t
-gt64260_pci_error_int_handler(int irq, void *dev_id, struct pt_regs *regs)
+gt64260_pci_error_int_handler(int irq, void *dev_id)
 {
 	u32 val;
 	unsigned int pci_bus = (unsigned int)dev_id;
diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_common.c
index 4b77e6c..6ad52f4 100644
--- a/arch/ppc/syslib/ibm440gx_common.c
+++ b/arch/ppc/syslib/ibm440gx_common.c
@@ -119,7 +119,7 @@ static inline u32 l2c_diag(u32 addr)
 	return mfdcr(DCRN_L2C0_DATA);
 }
 
-static irqreturn_t l2c_error_handler(int irq, void* dev, struct pt_regs* regs)
+static irqreturn_t l2c_error_handler(int irq, void* dev)
 {
 	u32 sr = mfdcr(DCRN_L2C0_SR);
 	if (sr & L2C_SR_CPE){
diff --git a/arch/ppc/syslib/ipic.c b/arch/ppc/syslib/ipic.c
index 46801f5..10659c2 100644
--- a/arch/ppc/syslib/ipic.c
+++ b/arch/ppc/syslib/ipic.c
@@ -601,7 +601,7 @@ void ipic_clear_mcp_status(u32 mask)
 }
 
 /* Return an interrupt vector or -1 if no interrupt is pending. */
-int ipic_get_irq(struct pt_regs *regs)
+int ipic_get_irq(void)
 {
 	int irq;
 
diff --git a/arch/ppc/syslib/m82xx_pci.c b/arch/ppc/syslib/m82xx_pci.c
index d3fa264..e3b586b 100644
--- a/arch/ppc/syslib/m82xx_pci.c
+++ b/arch/ppc/syslib/m82xx_pci.c
@@ -117,7 +117,7 @@ struct hw_interrupt_type pq2pci_ic = {
 };
 
 static irqreturn_t
-pq2pci_irq_demux(int irq, void *dev_id, struct pt_regs *regs)
+pq2pci_irq_demux(int irq, void *dev_id)
 {
 	unsigned long stat, mask, pend;
 	int bit;
@@ -130,7 +130,7 @@ pq2pci_irq_demux(int irq, void *dev_id, 
 			break;
 		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
 			if (pend & 0x80000000)
-				__do_IRQ(NR_CPM_INTS + bit, regs);
+				__do_IRQ(NR_CPM_INTS + bit);
 		}
 	}
 
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
index 54303a7..d8d299b 100644
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -169,7 +169,7 @@ #endif
 }
 
 /* A place holder for time base interrupts, if they are ever enabled. */
-irqreturn_t timebase_interrupt(int irq, void * dev, struct pt_regs * regs)
+irqreturn_t timebase_interrupt(int irq, void * dev)
 {
 	printk ("timebase_interrupt()\n");
 
diff --git a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
index ac11d7b..fffac8c 100644
--- a/arch/ppc/syslib/m8xx_wdt.c
+++ b/arch/ppc/syslib/m8xx_wdt.c
@@ -21,7 +21,7 @@ #include <syslib/m8xx_wdt.h>
 static int wdt_timeout;
 int m8xx_has_internal_rtc = 0;
 
-static irqreturn_t m8xx_wdt_interrupt(int, void *, struct pt_regs *);
+static irqreturn_t m8xx_wdt_interrupt(int, void *);
 static struct irqaction m8xx_wdt_irqaction = {
 	.handler = m8xx_wdt_interrupt,
 	.name = "watchdog",
@@ -35,7 +35,7 @@ void m8xx_wdt_reset(void)
 	out_be16(&imap->im_siu_conf.sc_swsr, 0xaa39);	/* write magic2 */
 }
 
-static irqreturn_t m8xx_wdt_interrupt(int irq, void *dev, struct pt_regs *regs)
+static irqreturn_t m8xx_wdt_interrupt(int irq, void *dev)
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 
diff --git a/arch/ppc/syslib/mpc52xx_pic.c b/arch/ppc/syslib/mpc52xx_pic.c
index 6425b5c..af35a31 100644
--- a/arch/ppc/syslib/mpc52xx_pic.c
+++ b/arch/ppc/syslib/mpc52xx_pic.c
@@ -220,7 +220,7 @@ mpc52xx_init_irq(void)
 }
 
 int
-mpc52xx_get_irq(struct pt_regs *regs)
+mpc52xx_get_irq(void)
 {
 	u32 status;
 	int irq = -1;
diff --git a/arch/ppc/syslib/mv64360_pic.c b/arch/ppc/syslib/mv64360_pic.c
index 3f6d162..b57589e 100644
--- a/arch/ppc/syslib/mv64360_pic.c
+++ b/arch/ppc/syslib/mv64360_pic.c
@@ -55,10 +55,9 @@ #endif
 
 static void mv64360_unmask_irq(unsigned int);
 static void mv64360_mask_irq(unsigned int);
-static irqreturn_t mv64360_cpu_error_int_handler(int, void *, struct pt_regs *);
-static irqreturn_t mv64360_sram_error_int_handler(int, void *,
-						  struct pt_regs *);
-static irqreturn_t mv64360_pci_error_int_handler(int, void *, struct pt_regs *);
+static irqreturn_t mv64360_cpu_error_int_handler(int, void *);
+static irqreturn_t mv64360_sram_error_int_handler(int, void *);
+static irqreturn_t mv64360_pci_error_int_handler(int, void *);
 
 /* ========================== local declarations =========================== */
 
@@ -131,9 +130,6 @@ mv64360_init_irq(void)
  * This function returns the lowest interrupt number of all interrupts that
  * are currently asserted.
  *
- * Input Variable(s):
- *  struct pt_regs*	not used
- *
  * Output Variable(s):
  *  None.
  *
@@ -142,7 +138,7 @@ mv64360_init_irq(void)
  *
  */
 int
-mv64360_get_irq(struct pt_regs *regs)
+mv64360_get_irq(void)
 {
 	int irq;
 	int irq_gpp;
@@ -283,7 +279,7 @@ #endif
 }
 
 static irqreturn_t
-mv64360_cpu_error_int_handler(int irq, void *dev_id, struct pt_regs *regs)
+mv64360_cpu_error_int_handler(int irq, void *dev_id)
 {
 	printk(KERN_ERR "mv64360_cpu_error_int_handler: %s 0x%08x\n",
 		"Error on CPU interface - Cause regiser",
@@ -304,7 +300,7 @@ mv64360_cpu_error_int_handler(int irq, v
 }
 
 static irqreturn_t
-mv64360_sram_error_int_handler(int irq, void *dev_id, struct pt_regs *regs)
+mv64360_sram_error_int_handler(int irq, void *dev_id)
 {
 	printk(KERN_ERR "mv64360_sram_error_int_handler: %s 0x%08x\n",
 		"Error in internal SRAM - Cause register",
@@ -325,7 +321,7 @@ mv64360_sram_error_int_handler(int irq, 
 }
 
 static irqreturn_t
-mv64360_pci_error_int_handler(int irq, void *dev_id, struct pt_regs *regs)
+mv64360_pci_error_int_handler(int irq, void *dev_id)
 {
 	u32 val;
 	unsigned int pci_bus = (unsigned int)dev_id;
diff --git a/arch/ppc/syslib/open_pic2.c b/arch/ppc/syslib/open_pic2.c
index e1ff971..d585207 100644
--- a/arch/ppc/syslib/open_pic2.c
+++ b/arch/ppc/syslib/open_pic2.c
@@ -529,7 +529,7 @@ static void openpic2_end_irq(unsigned in
 }
 
 int
-openpic2_get_irq(struct pt_regs *regs)
+openpic2_get_irq(void)
 {
 	int irq = openpic2_irq();
 
diff --git a/arch/ppc/syslib/ppc403_pic.c b/arch/ppc/syslib/ppc403_pic.c
index 1584c8b..607ebd1 100644
--- a/arch/ppc/syslib/ppc403_pic.c
+++ b/arch/ppc/syslib/ppc403_pic.c
@@ -42,7 +42,7 @@ static struct hw_interrupt_type ppc403_a
 };
 
 int
-ppc403_pic_get_irq(struct pt_regs *regs)
+ppc403_pic_get_irq(void)
 {
 	int irq;
 	unsigned long bits;
diff --git a/arch/ppc/syslib/ppc4xx_pic.c b/arch/ppc/syslib/ppc4xx_pic.c
index 745685d..ee0da4b 100644
--- a/arch/ppc/syslib/ppc4xx_pic.c
+++ b/arch/ppc/syslib/ppc4xx_pic.c
@@ -96,7 +96,7 @@ UIC_HANDLERS(1);
 UIC_HANDLERS(2);
 UIC_HANDLERS(3);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
 	if (uic0 & UIC0_UIC1NC)
@@ -125,7 +125,7 @@ UIC_HANDLERS(0);
 UIC_HANDLERS(1);
 UIC_HANDLERS(2);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uicb = mfdcr(DCRN_UIC_MSR(UICB));
 	if (uicb & UICB_UIC0NC)
@@ -158,7 +158,7 @@ #define ACK_UIC1_PARENT	mtdcr(DCRN_UIC_S
 UIC_HANDLERS(0);
 UIC_HANDLERS(1);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
 	if (uic0 & UIC0_UIC1NC)
@@ -179,7 +179,7 @@ #elif NR_UICS == 1
 #define ACK_UIC0_PARENT
 UIC_HANDLERS(0);
 
-static int ppc4xx_pic_get_irq(struct pt_regs *regs)
+static int ppc4xx_pic_get_irq(void)
 {
 	u32 uic0 = mfdcr(DCRN_UIC_MSR(UIC0));
 	return uic0 ? 32 - ffs(uic0) : -1;
diff --git a/arch/ppc/syslib/ppc85xx_rio.c b/arch/ppc/syslib/ppc85xx_rio.c
index d9b471b..05b0e94 100644
--- a/arch/ppc/syslib/ppc85xx_rio.c
+++ b/arch/ppc/syslib/ppc85xx_rio.c
@@ -349,13 +349,12 @@ EXPORT_SYMBOL_GPL(rio_hw_add_outb_messag
  * mpc85xx_rio_tx_handler - MPC85xx outbound message interrupt handler
  * @irq: Linux interrupt number
  * @dev_instance: Pointer to interrupt-specific data
- * @regs: Register context
  *
  * Handles outbound message interrupts. Executes a register outbound
  * mailbox event handler and acks the interrupt occurence.
  */
 static irqreturn_t
-mpc85xx_rio_tx_handler(int irq, void *dev_instance, struct pt_regs *regs)
+mpc85xx_rio_tx_handler(int irq, void *dev_instance)
 {
 	int osr;
 	struct rio_mport *port = (struct rio_mport *)dev_instance;
@@ -517,13 +516,12 @@ void rio_close_outb_mbox(struct rio_mpor
  * mpc85xx_rio_rx_handler - MPC85xx inbound message interrupt handler
  * @irq: Linux interrupt number
  * @dev_instance: Pointer to interrupt-specific data
- * @regs: Register context
  *
  * Handles inbound message interrupts. Executes a registered inbound
  * mailbox event handler and acks the interrupt occurence.
  */
 static irqreturn_t
-mpc85xx_rio_rx_handler(int irq, void *dev_instance, struct pt_regs *regs)
+mpc85xx_rio_rx_handler(int irq, void *dev_instance)
 {
 	int isr;
 	struct rio_mport *port = (struct rio_mport *)dev_instance;
@@ -736,13 +734,12 @@ EXPORT_SYMBOL_GPL(rio_hw_get_inb_message
  * mpc85xx_rio_dbell_handler - MPC85xx doorbell interrupt handler
  * @irq: Linux interrupt number
  * @dev_instance: Pointer to interrupt-specific data
- * @regs: Register context
  *
  * Handles doorbell interrupts. Parses a list of registered
  * doorbell event handlers and executes a matching event handler.
  */
 static irqreturn_t
-mpc85xx_rio_dbell_handler(int irq, void *dev_instance, struct pt_regs *regs)
+mpc85xx_rio_dbell_handler(int irq, void *dev_instance)
 {
 	int dsr;
 	struct rio_mport *port = (struct rio_mport *)dev_instance;
diff --git a/arch/ppc/syslib/ppc8xx_pic.c b/arch/ppc/syslib/ppc8xx_pic.c
index d6c25fe..e8619c7 100644
--- a/arch/ppc/syslib/ppc8xx_pic.c
+++ b/arch/ppc/syslib/ppc8xx_pic.c
@@ -10,7 +10,7 @@ #include <asm/8xx_immap.h>
 #include <asm/mpc8xx.h>
 #include "ppc8xx_pic.h"
 
-extern int cpm_get_irq(struct pt_regs *regs);
+extern int cpm_get_irq(void);
 
 /* The 8xx internal interrupt controller.  It is usually
  * the only interrupt controller.  Some boards, like the MBX and
@@ -96,7 +96,7 @@ m8xx_get_irq(struct pt_regs *regs)
 	 * get back SIU_LEVEL7.  In this case, return -1
 	 */
         if (irq == CPM_INTERRUPT)
-        	irq = CPM_IRQ_OFFSET + cpm_get_irq(regs);
+        	irq = CPM_IRQ_OFFSET + cpm_get_irq();
 #if defined(CONFIG_PCI)
 	else if (irq == ISA_BRIDGE_INT) {
 		int isa_irq;
diff --git a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
index 39a93dc..6fd4cdb 100644
--- a/arch/ppc/syslib/xilinx_pic.c
+++ b/arch/ppc/syslib/xilinx_pic.c
@@ -86,7 +86,7 @@ static struct hw_interrupt_type xilinx_i
 };
 
 int
-xilinx_pic_get_irq(struct pt_regs *regs)
+xilinx_pic_get_irq(void)
 {
 	int irq;
 
diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
index 3247bea..7b06b4e 100644
--- a/include/asm-ppc/commproc.h
+++ b/include/asm-ppc/commproc.h
@@ -690,8 +690,7 @@ #define CICR_HP_MASK		((uint)0x00001f00)
 #define CICR_IEN		((uint)0x00000080)	/* Int. enable */
 #define CICR_SPS		((uint)0x00000001)	/* SCC Spread */
 
-extern void cpm_install_handler(int vec,
-		void (*handler)(void *, struct pt_regs *regs), void *dev_id);
+extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
 extern void cpm_free_handler(int vec);
 
 #endif /* __CPM_8XX__ */
diff --git a/include/asm-ppc/gt64260.h b/include/asm-ppc/gt64260.h
index cd0ef64..9e63b3c 100644
--- a/include/asm-ppc/gt64260.h
+++ b/include/asm-ppc/gt64260.h
@@ -315,7 +315,7 @@ int gt64260_get_base(u32 *base);
 int gt64260_pci_exclude_device(u8 bus, u8 devfn);
 
 void gt64260_init_irq(void);
-int gt64260_get_irq(struct pt_regs *regs);
+int gt64260_get_irq(void);
 
 void gt64260_mpsc_progress(char *s, unsigned short hex);
 
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index 7e98428..64c8874 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -415,7 +415,7 @@ #endif /* __ASSEMBLY__ */
 #ifndef __ASSEMBLY__
 
 extern void mpc52xx_init_irq(void);
-extern int mpc52xx_get_irq(struct pt_regs *regs);
+extern int mpc52xx_get_irq(void);
 
 extern unsigned long mpc52xx_find_end_of_memory(void);
 extern void mpc52xx_set_bat(void);
diff --git a/include/asm-ppc/mv64x60.h b/include/asm-ppc/mv64x60.h
index 663edbe..db3776f 100644
--- a/include/asm-ppc/mv64x60.h
+++ b/include/asm-ppc/mv64x60.h
@@ -336,9 +336,9 @@ int mv64x60_pci_exclude_device(u8 bus, u
 
 
 void gt64260_init_irq(void);
-int gt64260_get_irq(struct pt_regs *regs);
+int gt64260_get_irq(void);
 void mv64360_init_irq(void);
-int mv64360_get_irq(struct pt_regs *regs);
+int mv64360_get_irq(void);
 
 u32 mv64x60_mask(u32 val, u32 num_bits);
 u32 mv64x60_shift_left(u32 val, u32 num_bits);
-- 
1.4.2.GIT

