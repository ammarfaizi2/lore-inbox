Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265187AbUELTLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265187AbUELTLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265183AbUELTIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:08:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50168 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S265177AbUELS4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:56:11 -0400
From: mporter@kernel.crashing.org
Message-Id: <200405121855.LAA13650@liberty.homelinux.org>
Subject: [PATCH 3/8] PPC32: PPC44x lib support
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Wed, 12 May 2004 11:55:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge PPC44x library support against new OCP.
Please apply.

diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	Wed May 12 09:24:25 2004
+++ b/arch/ppc/syslib/Makefile	Wed May 12 09:24:25 2004
@@ -14,8 +14,10 @@
 
 obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram.o
 obj-$(CONFIG_PPC_OCP)		+= ocp.o
+obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
+obj-$(CONFIG_440GX)		+= ibm440gx_common.o
 ifeq ($(CONFIG_4xx),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pic.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o
diff -Nru a/arch/ppc/syslib/ibm440gp_common.c b/arch/ppc/syslib/ibm440gp_common.c
--- a/arch/ppc/syslib/ibm440gp_common.c	Wed May 12 09:24:25 2004
+++ b/arch/ppc/syslib/ibm440gp_common.c	Wed May 12 09:24:25 2004
@@ -24,7 +24,7 @@
 /*
  * Calculate 440GP clocks
  */
-void __init ibm440gp_get_clocks(struct ibm440gp_clocks* p,
+void __init ibm440gp_get_clocks(struct ibm44x_clocks* p,
 				unsigned int sys_clk,
 				unsigned int ser_clk)
 {
@@ -68,11 +68,11 @@
 
 	if (cpc0_cr0 & 0x00400000){
 		/* External UART clock */
-		p->uart = ser_clk;
+		p->uart0 = p->uart1 = ser_clk;
 	}
 	else {
 		/* Internal UART clock */
     		u32 uart_div = ((cpc0_cr0 >> 16) & 0x1f) + 1;
-		p->uart = p->plb / uart_div;
+		p->uart0 = p->uart1 = p->plb / uart_div;
 	}
 }
diff -Nru a/arch/ppc/syslib/ibm440gp_common.h b/arch/ppc/syslib/ibm440gp_common.h
--- a/arch/ppc/syslib/ibm440gp_common.h	Wed May 12 09:24:25 2004
+++ b/arch/ppc/syslib/ibm440gp_common.h	Wed May 12 09:24:25 2004
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/syslib/ibm440gp_common.h
+ * arch/ppc/kernel/ibm440gp_common.h
  *
  * PPC440GP system library
  *
@@ -20,26 +20,16 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
-
-/*
- * All clocks are in Hz
- */
-struct ibm440gp_clocks {
-	unsigned int cpu;	/* CPUCoreClk */
-	unsigned int plb;	/* PLBClk */
-	unsigned int opb;	/* OPBClk */
-	unsigned int ebc;	/* PerClk */
-	unsigned int uart;
-};
+#include <syslib/ibm44x_common.h>
 
 /*
  * Please, refer to the Figure 13.1 in 440GP user manual
- *
+ * 
  * if internal UART clock is used, ser_clk is ignored
  */
-void ibm440gp_get_clocks(struct ibm440gp_clocks*, unsigned int sys_clk,
+void ibm440gp_get_clocks(struct ibm44x_clocks*, unsigned int sys_clk, 
 	unsigned int ser_clk) __init;
-
+ 
 #endif /* __ASSEMBLY__ */
 #endif /* __PPC_SYSLIB_IBM440GP_COMMON_H */
 #endif /* __KERNEL__ */
diff -Nru a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_common.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/syslib/ibm440gx_common.c	Wed May 12 09:24:25 2004
@@ -0,0 +1,212 @@
+/*
+ * arch/ppc/kernel/ibm440gx_common.c
+ *
+ * PPC440GX system library
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <asm/ibm44x.h>
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <syslib/ibm440gx_common.h>
+
+/*
+ * Calculate 440GX clocks
+ */
+static inline u32 __fix_zero(u32 v, u32 def){
+	return v ? v : def;
+}
+ 
+void __init ibm440gx_get_clocks(struct ibm44x_clocks* p, unsigned int sys_clk, 
+	unsigned int ser_clk)
+{
+	u32 pllc  = CPR_READ(DCRN_CPR_PLLC);
+	u32 plld  = CPR_READ(DCRN_CPR_PLLD);
+	u32 uart0 = SDR_READ(DCRN_SDR_UART0);
+	u32 uart1 = SDR_READ(DCRN_SDR_UART1);
+	
+	/* Dividers */
+	u32 fbdv   = __fix_zero((plld >> 24) & 0x1f, 32);
+	u32 fwdva  = __fix_zero((plld >> 16) & 0xf, 16);
+	u32 fwdvb  = __fix_zero((plld >> 8) & 7, 8);
+	u32 lfbdv  = __fix_zero(plld & 0x3f, 64);
+	u32 pradv0 = __fix_zero((CPR_READ(DCRN_CPR_PRIMAD) >> 24) & 7, 8);
+	u32 prbdv0 = __fix_zero((CPR_READ(DCRN_CPR_PRIMBD) >> 24) & 7, 8);
+	u32 opbdv0 = __fix_zero((CPR_READ(DCRN_CPR_OPBD) >> 24) & 3, 4);
+	u32 perdv0 = __fix_zero((CPR_READ(DCRN_CPR_PERD) >> 24) & 3, 4);
+
+	/* Input clocks for primary dividers */	
+	u32 clk_a, clk_b;
+
+	if (pllc & 0x40000000){
+		u32 m;
+	    
+		/* Feedback path */
+		switch ((pllc >> 24) & 7){
+		case 0:
+			/* PLLOUTx */
+			m = ((pllc & 0x20000000) ? fwdvb : fwdva) * lfbdv;
+			break;
+		case 1:
+			/* CPU */
+			m = fwdva * pradv0;
+			break;
+		case 5:
+			/* PERClk */
+			m = fwdvb * prbdv0 * opbdv0 * perdv0;
+			break;
+		default:
+			printk(KERN_EMERG "invalid PLL feedback source\n");
+			goto bypass;
+		}
+		m *= fbdv;
+		p->vco = sys_clk * m;
+		clk_a = p->vco / fwdva;
+		clk_b = p->vco / fwdvb;
+	}
+	else {
+bypass:	
+		/* Bypass system PLL */
+		p->vco = 0;
+		clk_a = clk_b = sys_clk;
+	}
+	
+	p->cpu = clk_a / pradv0;
+	p->plb = clk_b / prbdv0;
+	p->opb = p->plb / opbdv0;
+	p->ebc = p->opb / perdv0;
+	
+	/* UARTs clock */
+	if (uart0 & 0x00800000)
+		p->uart0 = ser_clk;
+	else
+		p->uart0 = p->plb / __fix_zero(uart0 & 0xff, 256);
+
+	if (uart1 & 0x00800000)
+		p->uart1 = ser_clk;
+	else
+		p->uart1 = p->plb / __fix_zero(uart1 & 0xff, 256);
+}
+
+/* Enable L2 cache (call with IRQs disabled) */
+void __init ibm440gx_l2c_enable(void){
+	u32 r;
+	
+	asm volatile ("sync" ::: "memory");
+
+	/* Disable SRAM */
+	mtdcr(DCRN_SRAM0_DPC,   mfdcr(DCRN_SRAM0_DPC)   & ~SRAM_DPC_ENABLE);
+	mtdcr(DCRN_SRAM0_SB0CR, mfdcr(DCRN_SRAM0_SB0CR) & ~SRAM_SBCR_BU_MASK);
+	mtdcr(DCRN_SRAM0_SB1CR, mfdcr(DCRN_SRAM0_SB1CR) & ~SRAM_SBCR_BU_MASK);
+	mtdcr(DCRN_SRAM0_SB2CR, mfdcr(DCRN_SRAM0_SB2CR) & ~SRAM_SBCR_BU_MASK);
+	mtdcr(DCRN_SRAM0_SB3CR, mfdcr(DCRN_SRAM0_SB3CR) & ~SRAM_SBCR_BU_MASK);
+	
+	/* Enable L2_MODE without ICU/DCU */
+	r = mfdcr(DCRN_L2C0_CFG) & ~(L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_SS_MASK);
+	r |= L2C_CFG_L2M | L2C_CFG_SS_256;
+	mtdcr(DCRN_L2C0_CFG, r);
+	
+	mtdcr(DCRN_L2C0_ADDR, 0);
+	
+	/* Hardware Clear Command */
+	mtdcr(DCRN_L2C0_CMD, L2C_CMD_HCC);
+	while (!(mfdcr(DCRN_L2C0_SR) & L2C_SR_CC)) ;
+	
+	/* Clear Cache Parity and Tag Errors */
+	mtdcr(DCRN_L2C0_CMD, L2C_CMD_CCP | L2C_CMD_CTE);
+	
+	/* Enable 64G snoop region starting at 0 */
+	r = mfdcr(DCRN_L2C0_SNP0) & ~(L2C_SNP_BA_MASK | L2C_SNP_SSR_MASK);
+	r |= L2C_SNP_SSR_32G | L2C_SNP_ESR;
+	mtdcr(DCRN_L2C0_SNP0, r);
+
+	r = mfdcr(DCRN_L2C0_SNP1) & ~(L2C_SNP_BA_MASK | L2C_SNP_SSR_MASK);
+	r |= 0x80000000 | L2C_SNP_SSR_32G | L2C_SNP_ESR;
+	mtdcr(DCRN_L2C0_SNP1, r);
+	
+	asm volatile ("sync" ::: "memory");
+	
+	/* Enable ICU/DCU ports */
+	r = mfdcr(DCRN_L2C0_CFG);
+	r &= ~(L2C_CFG_DCW_MASK | L2C_CFG_CPIM | L2C_CFG_TPIM | L2C_CFG_LIM 
+		| L2C_CFG_PMUX_MASK | L2C_CFG_PMIM | L2C_CFG_TPEI | L2C_CFG_CPEI
+		| L2C_CFG_NAM | L2C_CFG_NBRM);
+	r |= L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_TPC | L2C_CFG_CPC | L2C_CFG_FRAN 
+		| L2C_CFG_SMCM;
+	mtdcr(DCRN_L2C0_CFG, r);
+	
+	asm volatile ("sync; isync" ::: "memory");
+}
+
+/* Disable L2 cache (call with IRQs disabled) */
+void __init ibm440gx_l2c_disable(void){
+	u32 r;
+	
+	asm volatile ("sync" ::: "memory");
+
+	/* Disable L2C mode */
+	r = mfdcr(DCRN_L2C0_CFG) & ~(L2C_CFG_L2M | L2C_CFG_ICU | L2C_CFG_DCU);
+	mtdcr(DCRN_L2C0_CFG, r);
+
+	/* Enable SRAM */
+	mtdcr(DCRN_SRAM0_DPC, mfdcr(DCRN_SRAM0_DPC) | SRAM_DPC_ENABLE);
+	mtdcr(DCRN_SRAM0_SB0CR,
+	      SRAM_SBCR_BAS0 | SRAM_SBCR_BS_64KB | SRAM_SBCR_BU_RW);
+	mtdcr(DCRN_SRAM0_SB1CR,
+	      SRAM_SBCR_BAS1 | SRAM_SBCR_BS_64KB | SRAM_SBCR_BU_RW);
+	mtdcr(DCRN_SRAM0_SB2CR,
+	      SRAM_SBCR_BAS2 | SRAM_SBCR_BS_64KB | SRAM_SBCR_BU_RW);
+	mtdcr(DCRN_SRAM0_SB3CR,
+	      SRAM_SBCR_BAS3 | SRAM_SBCR_BS_64KB | SRAM_SBCR_BU_RW);
+	
+	asm volatile ("sync; isync" ::: "memory");
+}
+
+int __init ibm440gx_get_eth_grp(void)
+{
+	return (SDR_READ(DCRN_SDR_PFC1) & DCRN_SDR_PFC1_EPS) >> DCRN_SDR_PFC1_EPS_SHIFT;
+}
+
+void __init ibm440gx_set_eth_grp(int group)
+{
+	SDR_WRITE(DCRN_SDR_PFC1, (SDR_READ(DCRN_SDR_PFC1) & ~DCRN_SDR_PFC1_EPS) | (group << DCRN_SDR_PFC1_EPS_SHIFT));
+}
+
+void __init ibm440gx_tah_enable(void)
+{
+	/* Enable TAH0 and TAH1 */
+	SDR_WRITE(DCRN_SDR_MFR,SDR_READ(DCRN_SDR_MFR) &
+			~DCRN_SDR_MFR_TAH0);
+	SDR_WRITE(DCRN_SDR_MFR,SDR_READ(DCRN_SDR_MFR) &
+			~DCRN_SDR_MFR_TAH1);
+}
+
+int ibm440gx_show_cpuinfo(struct seq_file *m){
+
+	u32 l2c_cfg = mfdcr(DCRN_L2C0_CFG);
+	const char* s;
+	if (l2c_cfg & L2C_CFG_L2M){
+	    switch (l2c_cfg & (L2C_CFG_ICU | L2C_CFG_DCU)){
+		case L2C_CFG_ICU: s = "I-Cache only";    break;
+		case L2C_CFG_DCU: s = "D-Cache only";    break;
+		default:	  s = "I-Cache/D-Cache"; break;	
+	    }
+	}
+	else
+	    s = "disabled";
+
+	seq_printf(m, "L2-Cache\t: %s (0x%08x 0x%08x)\n", s, 
+	    l2c_cfg, mfdcr(DCRN_L2C0_SR));
+
+	return 0;
+}
+
diff -Nru a/arch/ppc/syslib/ibm440gx_common.h b/arch/ppc/syslib/ibm440gx_common.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/syslib/ibm440gx_common.h	Wed May 12 09:24:25 2004
@@ -0,0 +1,54 @@
+/*
+ * arch/ppc/kernel/ibm440gx_common.h
+ *
+ * PPC440GX system library
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifdef __KERNEL__
+#ifndef __PPC_SYSLIB_IBM440GX_COMMON_H
+#define __PPC_SYSLIB_IBM440GX_COMMON_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <syslib/ibm44x_common.h>
+
+/*
+ * Please, refer to the Figure 14.1 in 440GX user manual
+ * 
+ * if internal UART clock is used, ser_clk is ignored
+ */
+void ibm440gx_get_clocks(struct ibm44x_clocks*, unsigned int sys_clk, 
+	unsigned int ser_clk) __init;
+
+/* Enable L2 cache */
+void ibm440gx_l2c_enable(void) __init;
+
+/* Disable L2 cache */
+void ibm440gx_l2c_disable(void) __init;
+
+/* Get Ethernet Group */
+int ibm440gx_get_eth_grp(void) __init;
+
+/* Set Ethernet Group */
+void ibm440gx_set_eth_grp(int group) __init;
+
+/* Enable TAH devices */
+void ibm440gx_tah_enable(void) __init;
+
+/* Add L2C info to /proc/cpuinfo */
+int ibm440gx_show_cpuinfo(struct seq_file*);
+
+#endif /* __ASSEMBLY__ */
+#endif /* __PPC_SYSLIB_IBM440GX_COMMON_H */
+#endif /* __KERNEL__ */
diff -Nru a/arch/ppc/syslib/ibm44x_common.h b/arch/ppc/syslib/ibm44x_common.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/syslib/ibm44x_common.h	Wed May 12 09:24:25 2004
@@ -0,0 +1,36 @@
+/*
+ * arch/ppc/kernel/ibm44x_common.h
+ *
+ * PPC44x system library
+ *
+ * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ * Copyright (c) 2003 Zultys Technologies
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifdef __KERNEL__
+#ifndef __PPC_SYSLIB_IBM44x_COMMON_H
+#define __PPC_SYSLIB_IBM44x_COMMON_H
+
+#ifndef __ASSEMBLY__
+
+/*
+ * All clocks are in Hz
+ */
+struct ibm44x_clocks {
+	unsigned int vco;	/* VCO, 0 if system PLL is bypassed */
+	unsigned int cpu;	/* CPUCoreClk */
+	unsigned int plb;	/* PLBClk */
+	unsigned int opb;	/* OPBClk */
+	unsigned int ebc;	/* PerClk */
+	unsigned int uart0;
+	unsigned int uart1;
+};
+
+#endif /* __ASSEMBLY__ */
+#endif /* __PPC_SYSLIB_IBM44x_COMMON_H */
+#endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h	Wed May 12 09:24:25 2004
+++ b/include/asm-ppc/ibm44x.h	Wed May 12 09:24:25 2004
@@ -19,25 +19,6 @@
 
 #include <linux/config.h>
 
-#ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's "Ebony" evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- *
- * Ebony firmware stores MAC addresses in the F/W VPD area. The
- * firmware must store the other dynamic values in NVRAM like on
- * the previous 40x systems so they  should be accessible if we
- * really want them.
- */
-typedef struct board_info {
-	unsigned char	bi_enetaddr[2][6];	/* EMAC addresses */
-	unsigned int	bi_opb_busfreq;		/* OPB clock in Hz */
-	int		bi_iic_fast[2];		/* Use fast i2c mode */
-} bd_t;
-#endif /* __ASSEMBLY__ */
-
 #ifndef NR_BOARD_IRQS
 #define NR_BOARD_IRQS 0
 #endif
@@ -87,11 +68,35 @@
  */
 
 #ifdef CONFIG_440GX
+/* CPRs */
+#define DCRN_CPR_CONFIG_ADDR	0xc
+#define DCRN_CPR_CONFIG_DATA	0xd
+
+#define DCRN_CPR_CLKUPD		0x0020
+#define DCRN_CPR_PLLC		0x0040
+#define DCRN_CPR_PLLD		0x0060
+#define DCRN_CPR_PRIMAD		0x0080
+#define DCRN_CPR_PRIMBD		0x00a0
+#define DCRN_CPR_OPBD		0x00c0
+#define DCRN_CPR_PERD		0x00e0
+#define DCRN_CPR_MALD		0x0100
+
+/* CPRs read/write helper macros */
+#define CPR_READ(offset) ({\
+	mtdcr(DCRN_CPR_CONFIG_ADDR, offset); \
+	mfdcr(DCRN_CPR_CONFIG_DATA);})
+#define CPR_WRITE(offset, data) ({\
+	mtdcr(DCRN_CPR_CONFIG_ADDR, offset); \
+	mtdcr(DCRN_CPR_CONFIG_DATA, data);})
+
 /* SDRs */
-#define DCRN_SDR_CONFIG_ADDR 	0xe
+#define DCRN_SDR_CONFIG_ADDR 	0xe 
 #define DCRN_SDR_CONFIG_DATA	0xf
 #define DCRN_SDR_PFC0		0x4100
 #define DCRN_SDR_PFC1		0x4101
+#define DCRN_SDR_PFC1_EPS	0x1c000000
+#define DCRN_SDR_PFC1_EPS_SHIFT	26
+#define DCRN_SDR_PFC1_RMII	0x02000000
 #define DCRN_SDR_MFR		0x4300
 #define DCRN_SDR_MFR_TAH0 	0x80000000  	/* TAHOE0 Enable */
 #define DCRN_SDR_MFR_TAH1 	0x40000000  	/* TAHOE1 Enable */
@@ -107,7 +112,7 @@
 #define DCRN_SDR_MFR_E0RXFH	0x00001000
 #define DCRN_SDR_MFR_E1TXFL	0x00000800
 #define DCRN_SDR_MFR_E1TXFH	0x00000400
-#define DCRN_SDR_MFR_E1RXFL	0x00000200
+#define DCRN_SDR_MFR_E1RXFL	0x00000200 
 #define DCRN_SDR_MFR_E1RXFH	0x00000100
 #define DCRN_SDR_MFR_E2TXFL	0x00000080
 #define DCRN_SDR_MFR_E2TXFH	0x00000040
@@ -117,6 +122,8 @@
 #define DCRN_SDR_MFR_E3TXFH	0x00000004
 #define DCRN_SDR_MFR_E3RXFL	0x00000002
 #define DCRN_SDR_MFR_E3RXFH	0x00000001
+#define DCRN_SDR_UART0		0x0120
+#define DCRN_SDR_UART1		0x0121
 
 /* SDR read/write helper macros */
 #define SDR_READ(offset) ({\
@@ -139,8 +146,12 @@
 /* UIC */
 #define DCRN_UIC0_BASE	0xc0
 #define DCRN_UIC1_BASE	0xd0
+#define DCRN_UIC2_BASE	0x210
+#define DCRN_UICB_BASE	0x200
 #define UIC0		DCRN_UIC0_BASE
 #define UIC1		DCRN_UIC1_BASE
+#define UIC2		DCRN_UIC2_BASE
+#define UICB		DCRN_UICB_BASE
 
 #define DCRN_UIC_SR(base)       (base + 0x0)
 #define DCRN_UIC_ER(base)       (base + 0x2)
@@ -151,8 +162,12 @@
 #define DCRN_UIC_VR(base)       (base + 0x7)
 #define DCRN_UIC_VCR(base)      (base + 0x8)
 
-#define UIC0_UIC1NC      30	/* UIC1 non-critical interrupt */
-#define UIC0_UIC1CR      31	/* UIC1 critical interrupt */
+#define UIC0_UIC1NC		30	/* UIC1 non-critical interrupt */
+#define UIC0_UIC1CR      	31	/* UIC1 critical interrupt */
+
+#define UICB_UIC0NC		0x40000000
+#define UICB_UIC1NC		0x10000000
+#define UICB_UIC2NC		0x04000000
 
 /* 440GP MAL DCRs */
 #define DCRN_MALCR(base)		(base + 0x0)	/* Configuration */
@@ -327,6 +342,81 @@
 #define PPC44x_MEM_SIZE_256M		0x10000000
 #define PPC44x_MEM_SIZE_512M		0x20000000
 
+#ifdef CONFIG_440GX
+/* Internal SRAM Controller */
+#define DCRN_SRAM0_SB0CR	0x020
+#define DCRN_SRAM0_SB1CR	0x021
+#define DCRN_SRAM0_SB2CR	0x022
+#define DCRN_SRAM0_SB3CR	0x023
+#define  SRAM_SBCR_BAS0		0x80000000
+#define  SRAM_SBCR_BAS1		0x80010000
+#define  SRAM_SBCR_BAS2		0x80020000
+#define  SRAM_SBCR_BAS3		0x80030000
+#define  SRAM_SBCR_BU_MASK	0x00000180
+#define  SRAM_SBCR_BS_64KB	0x00000800
+#define  SRAM_SBCR_BU_RO	0x00000080
+#define  SRAM_SBCR_BU_RW	0x00000180
+#define DCRN_SRAM0_BEAR		0x024
+#define DCRN_SRAM0_BESR0	0x025
+#define DCRN_SRAM0_BESR1	0x026
+#define DCRN_SRAM0_PMEG		0x027
+#define DCRN_SRAM0_CID		0x028
+#define DCRN_SRAM0_REVID	0x029
+#define DCRN_SRAM0_DPC		0x02a
+#define  SRAM_DPC_ENABLE	0x80000000
+
+/* L2 Cache Controller */
+#define DCRN_L2C0_CFG		0x030
+#define  L2C_CFG_L2M		0x80000000
+#define  L2C_CFG_ICU		0x40000000
+#define  L2C_CFG_DCU		0x20000000
+#define  L2C_CFG_DCW_MASK	0x1e000000
+#define  L2C_CFG_TPC		0x01000000
+#define  L2C_CFG_CPC		0x00800000
+#define  L2C_CFG_FRAN		0x00200000
+#define  L2C_CFG_SS_MASK	0x00180000
+#define  L2C_CFG_SS_256		0x00000000
+#define  L2C_CFG_CPIM		0x00040000
+#define  L2C_CFG_TPIM		0x00020000
+#define  L2C_CFG_LIM		0x00010000
+#define  L2C_CFG_PMUX_MASK	0x00007000
+#define  L2C_CFG_PMUX_SNP	0x00000000
+#define  L2C_CFG_PMUX_IF	0x00001000
+#define  L2C_CFG_PMUX_DF	0x00002000
+#define  L2C_CFG_PMUX_DS	0x00003000
+#define  L2C_CFG_PMIM		0x00000800
+#define  L2C_CFG_TPEI		0x00000400
+#define  L2C_CFG_CPEI		0x00000200
+#define  L2C_CFG_NAM		0x00000100
+#define  L2C_CFG_SMCM		0x00000080
+#define  L2C_CFG_NBRM		0x00000040
+#define DCRN_L2C0_CMD		0x031
+#define  L2C_CMD_CLR		0x80000000
+#define  L2C_CMD_DIAG		0x40000000
+#define  L2C_CMD_INV		0x20000000
+#define  L2C_CMD_CCP		0x10000000
+#define  L2C_CMD_CTE		0x08000000
+#define  L2C_CMD_STRC		0x04000000
+#define  L2C_CMD_STPC		0x02000000
+#define  L2C_CMD_RPMC		0x01000000
+#define  L2C_CMD_HCC		0x00800000
+#define DCRN_L2C0_ADDR		0x032
+#define DCRN_L2C0_DATA		0x033
+#define DCRN_L2C0_SR		0x034
+#define  L2C_SR_CC		0x80000000
+#define  L2C_SR_CPE		0x40000000
+#define  L2C_SR_TPE		0x20000000
+#define  L2C_SR_LRU		0x10000000
+#define  L2C_SR_PCS		0x08000000
+#define DCRN_L2C0_REVID		0x035
+#define DCRN_L2C0_SNP0		0x036
+#define DCRN_L2C0_SNP1		0x037
+#define  L2C_SNP_BA_MASK	0xffff0000
+#define  L2C_SNP_SSR_MASK	0x0000f000
+#define  L2C_SNP_SSR_32G	0x0000f000
+#define  L2C_SNP_ESR		0x00000800
+#endif /* CONFIG_440GX */
+
 /*
  * PCI-X definitions
  */
@@ -423,7 +513,11 @@
 #define IIC_CLOCK		50
 
 #undef NR_UICS
+#ifdef CONFIG_440GX
+#define NR_UICS 3
+#else
 #define NR_UICS 2
+#endif
 #define UIC_CASCADE_MASK	0x0003		/* bits 30 & 31 */
 
 #define BD_EMAC_ADDR(e,i) bi_enetaddr[e][i]
diff -Nru a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
--- a/include/asm-ppc/ibm4xx.h	Wed May 12 09:24:25 2004
+++ b/include/asm-ppc/ibm4xx.h	Wed May 12 09:24:25 2004
@@ -15,6 +15,7 @@
 #define __ASM_IBM4XX_H__
 
 #include <linux/config.h>
+#include <asm/types.h>
 
 #ifdef CONFIG_40x
 
@@ -22,8 +23,8 @@
 #include <platforms/4xx/ash.h>
 #endif
 
-#if defined (CONFIG_CEDAR)
-#include <platforms/4xx/cedar.h>
+#if defined(CONFIG_BUBINGA)
+#include <platforms/4xx/bubinga.h>
 #endif
 
 #if defined(CONFIG_CPCI405)
@@ -46,17 +47,27 @@
 #include <platforms/4xx/redwood5.h>
 #endif
 
+#if defined(CONFIG_REDWOOD_6)
+#include <platforms/4xx/redwood6.h>
+#endif
+
+#if defined(CONFIG_SYCAMORE)
+#include <platforms/4xx/sycamore.h>
+#endif
+
 #if defined(CONFIG_WALNUT)
 #include <platforms/4xx/walnut.h>
 #endif
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_40x
 /*
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
 extern bd_t __res;
+#endif
 
 void ppc4xx_setup_arch(void);
 void ppc4xx_map_io(void);
@@ -91,11 +102,13 @@
 #endif
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_40x
 /*
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
 extern bd_t __res;
+#endif
 #endif
 #endif /* CONFIG_40x */
 
