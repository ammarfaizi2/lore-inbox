Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268391AbUHLADQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268391AbUHLADQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUHLADP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:03:15 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:63980 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268391AbUHKXhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:37:39 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112336.i7BNaPxI163752@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 21 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:36:24 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 17:56:43-05:00 pfg@sgi.com 
#   clean up
#   new defs for the new I/O code
# 
# include/asm-ia64/sn/pci/pic.h
#   2004/08/11 17:56:29-05:00 pfg@sgi.com +462 -263
#    
# 
diff -Nru a/include/asm-ia64/sn/pci/pic.h b/include/asm-ia64/sn/pci/pic.h
--- a/include/asm-ia64/sn/pci/pic.h	2004-08-11 17:57:11 -05:00
+++ b/include/asm-ia64/sn/pci/pic.h	2004-08-11 17:57:11 -05:00
@@ -55,36 +55,9 @@
  * ----------|---------------------------------------
  */
 
-
-#ifdef __KERNEL__
-#include <linux/types.h>
-#include <asm/sn/xtalk/xwidget.h>	/* generic widget header */
-#else
-#include <xtalk/xwidget.h>
-#endif
-
-#include <asm/sn/pci/pciio.h>
-
-
-/*
- *    bus provider function table
- *
- *	Normally, this table is only handed off explicitly
- *	during provider initialization, and the PCI generic
- *	layer will stash a pointer to it in the vertex; however,
- *	exporting it explicitly enables a performance hack in
- *	the generic PCI provider where if we know at compile
- *	time that the only possible PCI provider is a
- *	pcibr, we can go directly to this ops table.
- */
-
-extern pciio_provider_t pci_pic_provider;
-
-
-/*
- * misc defines
- *
- */
+/*****************************************************************************
+ *************************** PIC PART & REV DEFINES **************************
+ *****************************************************************************/
 
 #define PIC_WIDGET_PART_NUM_BUS0 0xd102
 #define PIC_WIDGET_PART_NUM_BUS1 0xd112
@@ -93,291 +66,145 @@
 #define PIC_WIDGET_REV_B  0x2
 #define PIC_WIDGET_REV_C  0x3
 
-#define PIC_XTALK_ADDR_MASK                     0x0000FFFFFFFFFFFF
-#define PIC_INTERNAL_ATES                       1024
-
-
 #define IS_PIC_PART_REV_A(rev) \
 	((rev == (PIC_WIDGET_PART_NUM_BUS0 << 4 | PIC_WIDGET_REV_A)) || \
 	(rev == (PIC_WIDGET_PART_NUM_BUS1 << 4 | PIC_WIDGET_REV_A)))
 #define IS_PIC_PART_REV_B(rev) \
-        ((rev == (PIC_WIDGET_PART_NUM_BUS0 << 4 | PIC_WIDGET_REV_B)) || \
-        (rev == (PIC_WIDGET_PART_NUM_BUS1 << 4 | PIC_WIDGET_REV_B)))
+	((rev == (PIC_WIDGET_PART_NUM_BUS0 << 4 | PIC_WIDGET_REV_B)) || \
+	(rev == (PIC_WIDGET_PART_NUM_BUS1 << 4 | PIC_WIDGET_REV_B)))
 #define IS_PIC_PART_REV_C(rev) \
-        ((rev == (PIC_WIDGET_PART_NUM_BUS0 << 4 | PIC_WIDGET_REV_C)) || \
-        (rev == (PIC_WIDGET_PART_NUM_BUS1 << 4 | PIC_WIDGET_REV_C)))
-
-
-/*
- * misc typedefs
- *
- */
-typedef uint64_t picreg_t;
-typedef uint64_t picate_t;
-
-/*
- * PIC Bridge MMR defines
- */
-
-/*
- * PIC STATUS register          offset 0x00000008
- */
-
-#define PIC_STAT_PCIX_ACTIVE_SHFT       33
-
-/*
- * PIC CONTROL register         offset 0x00000020
- */
-
-#define PIC_CTRL_PCI_SPEED_SHFT         4
-#define PIC_CTRL_PCI_SPEED              (0x3 << PIC_CTRL_PCI_SPEED_SHFT)
-#define PIC_CTRL_PAGE_SIZE_SHFT         21
-#define PIC_CTRL_PAGE_SIZE              (0x1 << PIC_CTRL_PAGE_SIZE_SHFT)
-
-
-/*
- * PIC Intr Destination Addr    offset 0x00000038
- */
-
-#define PIC_INTR_DEST_ADDR              0x0000FFFFFFFFFFFF
-#define PIC_INTR_DEST_TID_SHFT          48
-#define PIC_INTR_DEST_TID               (0xFull << PIC_INTR_DEST_TID_SHFT)
-
-/*
- * PIC PCI Responce Buffer      offset 0x00000068
- */
-#define PIC_RSP_BUF_ADDR                0x0000FFFFFFFFFFFF
-#define PIC_RSP_BUF_NUM_SHFT            48
-#define PIC_RSP_BUF_NUM                 (0xFull << PIC_RSP_BUF_NUM_SHFT)
-#define PIC_RSP_BUF_DEV_NUM_SHFT        52
-#define PIC_RSP_BUF_DEV_NUM             (0x3ull << PIC_RSP_BUF_DEV_NUM_SHFT)
-
-/*
- * PIC PCI DIRECT MAP register  offset 0x00000080
- */
-#define PIC_DIRMAP_DIROFF_SHFT          0
-#define PIC_DIRMAP_DIROFF               (0x1FFFF << PIC_DIRMAP_DIROFF_SHFT)
-#define PIC_DIRMAP_ADD512_SHFT          17
-#define PIC_DIRMAP_ADD512               (0x1 << PIC_DIRMAP_ADD512_SHFT)
-#define PIC_DIRMAP_WID_SHFT             20
-#define PIC_DIRMAP_WID                  (0xF << PIC_DIRMAP_WID_SHFT)
+	((rev == (PIC_WIDGET_PART_NUM_BUS0 << 4 | PIC_WIDGET_REV_C)) || \
+	(rev == (PIC_WIDGET_PART_NUM_BUS1 << 4 | PIC_WIDGET_REV_C)))
 
-#define PIC_DIRMAP_OFF_ADDRSHFT         31
 
-/*
- * Interrupt Status register            offset 0x00000100
- */
-#define PIC_ISR_PCIX_SPLIT_MSG_PE     (0x1ull << 45)
-#define PIC_ISR_PCIX_SPLIT_EMSG       (0x1ull << 44)
-#define PIC_ISR_PCIX_SPLIT_TO         (0x1ull << 43)
-#define PIC_ISR_PCIX_UNEX_COMP        (0x1ull << 42)
-#define PIC_ISR_INT_RAM_PERR          (0x1ull << 41)
-#define PIC_ISR_PCIX_ARB_ERR          (0x1ull << 40)
-#define PIC_ISR_PCIX_REQ_TOUT         (0x1ull << 39)
-#define PIC_ISR_PCIX_TABORT           (0x1ull << 38)
-#define PIC_ISR_PCIX_PERR             (0x1ull << 37)
-#define PIC_ISR_PCIX_SERR             (0x1ull << 36)
-#define PIC_ISR_PCIX_MRETRY           (0x1ull << 35)
-#define PIC_ISR_PCIX_MTOUT            (0x1ull << 34)
-#define PIC_ISR_PCIX_DA_PARITY        (0x1ull << 33)
-#define PIC_ISR_PCIX_AD_PARITY        (0x1ull << 32)
-#define PIC_ISR_PMU_PAGE_FAULT        (0x1ull << 30)
-#define PIC_ISR_UNEXP_RESP            (0x1ull << 29)
-#define PIC_ISR_BAD_XRESP_PKT         (0x1ull << 28)
-#define PIC_ISR_BAD_XREQ_PKT          (0x1ull << 27)
-#define PIC_ISR_RESP_XTLK_ERR         (0x1ull << 26)
-#define PIC_ISR_REQ_XTLK_ERR          (0x1ull << 25)
-#define PIC_ISR_INVLD_ADDR            (0x1ull << 24)
-#define PIC_ISR_UNSUPPORTED_XOP       (0x1ull << 23)
-#define PIC_ISR_XREQ_FIFO_OFLOW       (0x1ull << 22)
-#define PIC_ISR_LLP_REC_SNERR         (0x1ull << 21)
-#define PIC_ISR_LLP_REC_CBERR         (0x1ull << 20)
-#define PIC_ISR_LLP_RCTY              (0x1ull << 19)
-#define PIC_ISR_LLP_TX_RETRY          (0x1ull << 18)
-#define PIC_ISR_LLP_TCTY              (0x1ull << 17)
-#define PIC_ISR_PCI_ABORT             (0x1ull << 15)
-#define PIC_ISR_PCI_PARITY            (0x1ull << 14)
-#define PIC_ISR_PCI_SERR              (0x1ull << 13)
-#define PIC_ISR_PCI_PERR              (0x1ull << 12)
-#define PIC_ISR_PCI_MST_TIMEOUT       (0x1ull << 11)
-#define PIC_ISR_PCI_RETRY_CNT         (0x1ull << 10)
-#define PIC_ISR_XREAD_REQ_TIMEOUT     (0x1ull << 9)
-#define PIC_ISR_INT_MSK               (0xffull << 0)
-#define PIC_ISR_INT(x)                (0x1ull << (x))
-
-#define PIC_ISR_LINK_ERROR            \
-                (PIC_ISR_LLP_REC_SNERR|PIC_ISR_LLP_REC_CBERR|       \
-                 PIC_ISR_LLP_RCTY|PIC_ISR_LLP_TX_RETRY|             \
-                 PIC_ISR_LLP_TCTY)
-
-#define PIC_ISR_PCIBUS_PIOERR         \
-                (PIC_ISR_PCI_MST_TIMEOUT|PIC_ISR_PCI_ABORT|         \
-                 PIC_ISR_PCIX_MTOUT|PIC_ISR_PCIX_TABORT)
-
-#define PIC_ISR_PCIBUS_ERROR          \
-                (PIC_ISR_PCIBUS_PIOERR|PIC_ISR_PCI_PERR|            \
-                 PIC_ISR_PCI_SERR|PIC_ISR_PCI_RETRY_CNT|            \
-                 PIC_ISR_PCI_PARITY|PIC_ISR_PCIX_PERR|              \
-                 PIC_ISR_PCIX_SERR|PIC_ISR_PCIX_MRETRY|             \
-                 PIC_ISR_PCIX_AD_PARITY|PIC_ISR_PCIX_DA_PARITY|     \
-                 PIC_ISR_PCIX_REQ_TOUT|PIC_ISR_PCIX_UNEX_COMP|      \
-                 PIC_ISR_PCIX_SPLIT_TO|PIC_ISR_PCIX_SPLIT_EMSG|     \
-                 PIC_ISR_PCIX_SPLIT_MSG_PE)
-
-#define PIC_ISR_XTALK_ERROR           \
-                (PIC_ISR_XREAD_REQ_TIMEOUT|PIC_ISR_XREQ_FIFO_OFLOW| \
-                 PIC_ISR_UNSUPPORTED_XOP|PIC_ISR_INVLD_ADDR|        \
-                 PIC_ISR_REQ_XTLK_ERR|PIC_ISR_RESP_XTLK_ERR|        \
-                 PIC_ISR_BAD_XREQ_PKT|PIC_ISR_BAD_XRESP_PKT|        \
-                 PIC_ISR_UNEXP_RESP)
-
-#define PIC_ISR_ERRORS                \
-                (PIC_ISR_LINK_ERROR|PIC_ISR_PCIBUS_ERROR|           \
-                 PIC_ISR_XTALK_ERROR|                                 \
-                 PIC_ISR_PMU_PAGE_FAULT|PIC_ISR_INT_RAM_PERR)
-
-/*
- * PIC RESET INTR register      offset 0x00000110
- */
-
-#define PIC_IRR_ALL_CLR                 0xffffffffffffffff
-
-/*
- * PIC PCI Host Intr Addr       offset 0x00000130 - 0x00000168
- */
-#define PIC_HOST_INTR_ADDR              0x0000FFFFFFFFFFFF
-#define PIC_HOST_INTR_FLD_SHFT          48
-#define PIC_HOST_INTR_FLD               (0xFFull << PIC_HOST_INTR_FLD_SHFT)
-
-
-/*
- * PIC MMR structure mapping
- */
+/*****************************************************************************
+ *********************** PIC MMR structure mapping ***************************
+ *****************************************************************************/
 
 /* NOTE: PIC WAR. PV#854697.  PIC does not allow writes just to [31:0]
  * of a 64-bit register.  When writing PIC registers, always write the 
  * entire 64 bits.
  */
 
-typedef volatile struct pic_s {
+struct pic_s {
 
     /* 0x000000-0x00FFFF -- Local Registers */
 
     /* 0x000000-0x000057 -- Standard Widget Configuration */
-    picreg_t		p_wid_id;			/* 0x000000 */
-    picreg_t		p_wid_stat;			/* 0x000008 */
-    picreg_t		p_wid_err_upper;		/* 0x000010 */
-    picreg_t		p_wid_err_lower;		/* 0x000018 */
+    uint64_t		p_wid_id;			/* 0x000000 */
+    uint64_t		p_wid_stat;			/* 0x000008 */
+    uint64_t		p_wid_err_upper;		/* 0x000010 */
+    uint64_t		p_wid_err_lower;		/* 0x000018 */
     #define p_wid_err p_wid_err_lower
-    picreg_t		p_wid_control;			/* 0x000020 */
-    picreg_t		p_wid_req_timeout;		/* 0x000028 */
-    picreg_t		p_wid_int_upper;		/* 0x000030 */
-    picreg_t		p_wid_int_lower;		/* 0x000038 */
+    uint64_t		p_wid_control;			/* 0x000020 */
+    uint64_t		p_wid_req_timeout;		/* 0x000028 */
+    uint64_t		p_wid_int_upper;		/* 0x000030 */
+    uint64_t		p_wid_int_lower;		/* 0x000038 */
     #define p_wid_int p_wid_int_lower
-    picreg_t		p_wid_err_cmdword;		/* 0x000040 */
-    picreg_t		p_wid_llp;			/* 0x000048 */
-    picreg_t		p_wid_tflush;			/* 0x000050 */
+    uint64_t		p_wid_err_cmdword;		/* 0x000040 */
+    uint64_t		p_wid_llp;			/* 0x000048 */
+    uint64_t		p_wid_tflush;			/* 0x000050 */
 
     /* 0x000058-0x00007F -- Bridge-specific Widget Configuration */
-    picreg_t		p_wid_aux_err;			/* 0x000058 */
-    picreg_t		p_wid_resp_upper;		/* 0x000060 */
-    picreg_t		p_wid_resp_lower;		/* 0x000068 */
+    uint64_t		p_wid_aux_err;			/* 0x000058 */
+    uint64_t		p_wid_resp_upper;		/* 0x000060 */
+    uint64_t		p_wid_resp_lower;		/* 0x000068 */
     #define p_wid_resp p_wid_resp_lower
-    picreg_t		p_wid_tst_pin_ctrl;		/* 0x000070 */
-    picreg_t		p_wid_addr_lkerr;		/* 0x000078 */
+    uint64_t		p_wid_tst_pin_ctrl;		/* 0x000070 */
+    uint64_t		p_wid_addr_lkerr;		/* 0x000078 */
 
     /* 0x000080-0x00008F -- PMU & MAP */
-    picreg_t		p_dir_map;			/* 0x000080 */
-    picreg_t		_pad_000088;			/* 0x000088 */
+    uint64_t		p_dir_map;			/* 0x000080 */
+    uint64_t		_pad_000088;			/* 0x000088 */
 
     /* 0x000090-0x00009F -- SSRAM */
-    picreg_t		p_map_fault;			/* 0x000090 */
-    picreg_t		_pad_000098;			/* 0x000098 */
+    uint64_t		p_map_fault;			/* 0x000090 */
+    uint64_t		_pad_000098;			/* 0x000098 */
 
     /* 0x0000A0-0x0000AF -- Arbitration */
-    picreg_t		p_arb;				/* 0x0000A0 */
-    picreg_t		_pad_0000A8;			/* 0x0000A8 */
+    uint64_t		p_arb;				/* 0x0000A0 */
+    uint64_t		_pad_0000A8;			/* 0x0000A8 */
 
     /* 0x0000B0-0x0000BF -- Number In A Can or ATE Parity Error */
-    picreg_t		p_ate_parity_err;		/* 0x0000B0 */
-    picreg_t		_pad_0000B8;			/* 0x0000B8 */
+    uint64_t		p_ate_parity_err;		/* 0x0000B0 */
+    uint64_t		_pad_0000B8;			/* 0x0000B8 */
 
     /* 0x0000C0-0x0000FF -- PCI/GIO */
-    picreg_t		p_bus_timeout;			/* 0x0000C0 */
-    picreg_t		p_pci_cfg;			/* 0x0000C8 */
-    picreg_t		p_pci_err_upper;		/* 0x0000D0 */
-    picreg_t		p_pci_err_lower;		/* 0x0000D8 */
+    uint64_t		p_bus_timeout;			/* 0x0000C0 */
+    uint64_t		p_pci_cfg;			/* 0x0000C8 */
+    uint64_t		p_pci_err_upper;		/* 0x0000D0 */
+    uint64_t		p_pci_err_lower;		/* 0x0000D8 */
     #define p_pci_err p_pci_err_lower
-    picreg_t		_pad_0000E0[4];			/* 0x0000{E0..F8} */
+    uint64_t		_pad_0000E0[4];			/* 0x0000{E0..F8} */
 
     /* 0x000100-0x0001FF -- Interrupt */
-    picreg_t		p_int_status;			/* 0x000100 */
-    picreg_t		p_int_enable;			/* 0x000108 */
-    picreg_t		p_int_rst_stat;			/* 0x000110 */
-    picreg_t		p_int_mode;			/* 0x000118 */
-    picreg_t		p_int_device;			/* 0x000120 */
-    picreg_t		p_int_host_err;			/* 0x000128 */
-    picreg_t		p_int_addr[8];			/* 0x0001{30,,,68} */
-    picreg_t		p_err_int_view;			/* 0x000170 */
-    picreg_t		p_mult_int;			/* 0x000178 */
-    picreg_t		p_force_always[8];		/* 0x0001{80,,,B8} */
-    picreg_t		p_force_pin[8];			/* 0x0001{C0,,,F8} */
+    uint64_t		p_int_status;			/* 0x000100 */
+    uint64_t		p_int_enable;			/* 0x000108 */
+    uint64_t		p_int_rst_stat;			/* 0x000110 */
+    uint64_t		p_int_mode;			/* 0x000118 */
+    uint64_t		p_int_device;			/* 0x000120 */
+    uint64_t		p_int_host_err;			/* 0x000128 */
+    uint64_t		p_int_addr[8];			/* 0x0001{30,,,68} */
+    uint64_t		p_err_int_view;			/* 0x000170 */
+    uint64_t		p_mult_int;			/* 0x000178 */
+    uint64_t		p_force_always[8];		/* 0x0001{80,,,B8} */
+    uint64_t		p_force_pin[8];			/* 0x0001{C0,,,F8} */
 
     /* 0x000200-0x000298 -- Device */
-    picreg_t		p_device[4];			/* 0x0002{00,,,18} */
-    picreg_t		_pad_000220[4];			/* 0x0002{20,,,38} */
-    picreg_t		p_wr_req_buf[4];		/* 0x0002{40,,,58} */
-    picreg_t		_pad_000260[4];			/* 0x0002{60,,,78} */
-    picreg_t		p_rrb_map[2];			/* 0x0002{80,,,88} */
+    uint64_t		p_device[4];			/* 0x0002{00,,,18} */
+    uint64_t		_pad_000220[4];			/* 0x0002{20,,,38} */
+    uint64_t		p_wr_req_buf[4];		/* 0x0002{40,,,58} */
+    uint64_t		_pad_000260[4];			/* 0x0002{60,,,78} */
+    uint64_t		p_rrb_map[2];			/* 0x0002{80,,,88} */
     #define p_even_resp p_rrb_map[0]			/* 0x000280 */
     #define p_odd_resp  p_rrb_map[1]			/* 0x000288 */
-    picreg_t		p_resp_status;			/* 0x000290 */
-    picreg_t		p_resp_clear;			/* 0x000298 */
+    uint64_t		p_resp_status;			/* 0x000290 */
+    uint64_t		p_resp_clear;			/* 0x000298 */
 
-    picreg_t		_pad_0002A0[12];		/* 0x0002{A0..F8} */
+    uint64_t		_pad_0002A0[12];		/* 0x0002{A0..F8} */
 
     /* 0x000300-0x0003F8 -- Buffer Address Match Registers */
     struct {
-	picreg_t	upper;				/* 0x0003{00,,,F0} */
-	picreg_t	lower;				/* 0x0003{08,,,F8} */
+	uint64_t	upper;				/* 0x0003{00,,,F0} */
+	uint64_t	lower;				/* 0x0003{08,,,F8} */
     } p_buf_addr_match[16];
 
     /* 0x000400-0x0005FF -- Performance Monitor Registers (even only) */
     struct {
-	picreg_t	flush_w_touch;			/* 0x000{400,,,5C0} */
-	picreg_t	flush_wo_touch;			/* 0x000{408,,,5C8} */
-	picreg_t	inflight;			/* 0x000{410,,,5D0} */
-	picreg_t	prefetch;			/* 0x000{418,,,5D8} */
-	picreg_t	total_pci_retry;		/* 0x000{420,,,5E0} */
-	picreg_t	max_pci_retry;			/* 0x000{428,,,5E8} */
-	picreg_t	max_latency;			/* 0x000{430,,,5F0} */
-	picreg_t	clear_all;			/* 0x000{438,,,5F8} */
+	uint64_t	flush_w_touch;			/* 0x000{400,,,5C0} */
+	uint64_t	flush_wo_touch;			/* 0x000{408,,,5C8} */
+	uint64_t	inflight;			/* 0x000{410,,,5D0} */
+	uint64_t	prefetch;			/* 0x000{418,,,5D8} */
+	uint64_t	total_pci_retry;		/* 0x000{420,,,5E0} */
+	uint64_t	max_pci_retry;			/* 0x000{428,,,5E8} */
+	uint64_t	max_latency;			/* 0x000{430,,,5F0} */
+	uint64_t	clear_all;			/* 0x000{438,,,5F8} */
     } p_buf_count[8];
 
     
     /* 0x000600-0x0009FF -- PCI/X registers */
-    picreg_t		p_pcix_bus_err_addr;		/* 0x000600 */
-    picreg_t		p_pcix_bus_err_attr;		/* 0x000608 */
-    picreg_t		p_pcix_bus_err_data;		/* 0x000610 */
-    picreg_t		p_pcix_pio_split_addr;		/* 0x000618 */
-    picreg_t		p_pcix_pio_split_attr;		/* 0x000620 */
-    picreg_t		p_pcix_dma_req_err_attr;	/* 0x000628 */
-    picreg_t		p_pcix_dma_req_err_addr;	/* 0x000630 */
-    picreg_t		p_pcix_timeout;			/* 0x000638 */
+    uint64_t		p_pcix_bus_err_addr;		/* 0x000600 */
+    uint64_t		p_pcix_bus_err_attr;		/* 0x000608 */
+    uint64_t		p_pcix_bus_err_data;		/* 0x000610 */
+    uint64_t		p_pcix_pio_split_addr;		/* 0x000618 */
+    uint64_t		p_pcix_pio_split_attr;		/* 0x000620 */
+    uint64_t		p_pcix_dma_req_err_attr;	/* 0x000628 */
+    uint64_t		p_pcix_dma_req_err_addr;	/* 0x000630 */
+    uint64_t		p_pcix_timeout;			/* 0x000638 */
 
-    picreg_t		_pad_000640[120];		/* 0x000{640,,,9F8} */
+    uint64_t		_pad_000640[120];		/* 0x000{640,,,9F8} */
 
     /* 0x000A00-0x000BFF -- PCI/X Read&Write Buffer */
     struct {
-	picreg_t	p_buf_addr;			/* 0x000{A00,,,AF0} */
-	picreg_t	p_buf_attr;			/* 0X000{A08,,,AF8} */
+	uint64_t	p_buf_addr;			/* 0x000{A00,,,AF0} */
+	uint64_t	p_buf_attr;			/* 0X000{A08,,,AF8} */
     } p_pcix_read_buf_64[16];
 
     struct {
-	picreg_t	p_buf_addr;			/* 0x000{B00,,,BE0} */
-	picreg_t	p_buf_attr;			/* 0x000{B08,,,BE8} */
-	picreg_t	p_buf_valid;			/* 0x000{B10,,,BF0} */
-	picreg_t	__pad1;				/* 0x000{B18,,,BF8} */
+	uint64_t	p_buf_addr;			/* 0x000{B00,,,BE0} */
+	uint64_t	p_buf_attr;			/* 0x000{B08,,,BE8} */
+	uint64_t	p_buf_valid;			/* 0x000{B10,,,BF0} */
+	uint64_t	__pad1;				/* 0x000{B18,,,BF8} */
     } p_pcix_write_buf_64[8];
 
     /* End of Local Registers -- Start of Address Map space */
@@ -385,17 +212,17 @@
     char		_pad_000c00[0x010000 - 0x000c00];
 
     /* 0x010000-0x011fff -- Internal ATE RAM (Auto Parity Generation) */
-    picate_t		p_int_ate_ram[1024];		/* 0x010000-0x011fff */
+    uint64_t		p_int_ate_ram[1024];		/* 0x010000-0x011fff */
 
     /* 0x012000-0x013fff -- Internal ATE RAM (Manual Parity Generation) */
-    picate_t		p_int_ate_ram_mp[1024];		/* 0x012000-0x013fff */
+    uint64_t		p_int_ate_ram_mp[1024];		/* 0x012000-0x013fff */
 
     char		_pad_014000[0x18000 - 0x014000];
 
     /* 0x18000-0x197F8 -- PIC Write Request Ram */
-    picreg_t		p_wr_req_lower[256];		/* 0x18000 - 0x187F8 */
-    picreg_t		p_wr_req_upper[256];		/* 0x18800 - 0x18FF8 */
-    picreg_t		p_wr_req_parity[256];		/* 0x19000 - 0x197F8 */
+    uint64_t		p_wr_req_lower[256];		/* 0x18000 - 0x187F8 */
+    uint64_t		p_wr_req_upper[256];		/* 0x18800 - 0x18FF8 */
+    uint64_t		p_wr_req_parity[256];		/* 0x19000 - 0x197F8 */
 
     char		_pad_019800[0x20000 - 0x019800];
 
@@ -446,6 +273,378 @@
 	uint32_t	l[8 / 4];
 	uint64_t	d[8 / 8];
     } p_pcix_cycle;					/* 0x040000-0x040007 */
-} pic_t;
+};
+
+
+/*****************************************************************************
+ *************************** PIC BRIDGE MMR DEFINES **************************
+ *****************************************************************************/
+
+/*
+ * PIC STATUS register		offset 0x00000008
+ */
+#define PIC_STAT_TX_CREDIT_SHFT		PCIBR_STAT_TX_CREDIT_SHFT
+#define PIC_STAT_TX_CREDIT		PCIBR_STAT_TX_CREDIT
+#define PIC_STAT_RX_REQ_CNT_SHFT	PCIBR_STAT_RX_CREDIT_SHFT
+#define PIC_STAT_RX_REQ_CNT		PCIBR_STAT_RX_CREDIT
+#define PIC_STAT_LLP_TX_CNT_SHFT	PCIBR_STAT_LLP_TX_CNT_SHFT
+#define PIC_STAT_LLP_TX_CNT		PCIBR_STAT_LLP_TX_CNT
+#define PIC_STAT_LLP_RX_CNT_SHFT	PCIBR_STAT_LLP_RX_CNT_SHFT
+#define PIC_STAT_LLP_RX_CNT		PCIBR_STAT_LLP_RX_CNT
+#define PIC_STAT_PCIX_ACTIVE_SHFT	PCIBR_STAT_PCIX_ACTIVE_SHFT
+#define PIC_STAT_PCIX_ACTIVE		PCIBR_STAT_PCIX_ACTIVE
+#define PIC_STAT_PCIX_SPEED_SHFT	PCIBR_STAT_PCIX_SPEED_SHFT
+#define PIC_STAT_PCIX_SPEED		PCIBR_STAT_PCIX_SPEED
+
+/*
+ * PIC CONTROL register		offset 0x00000020
+ */
+#define PIC_CTRL_WIDGET_ID_SHFT		0
+#define PIC_CTRL_WIDGET_ID		(0xF << PIC_CTRL_WIDGET_ID_SHFT)
+#define PIC_CTRL_PCI_SPEED_SHFT		PCIBR_CTRL_PCI_SPEED_SHFT
+#define PIC_CTRL_PCI_SPEED		PCIBR_CTRL_PCI_SPEED
+#define PIC_CTRL_SYS_END_SHFT		PCIBR_CTRL_SYS_END_SHFT
+#define PIC_CTRL_SYS_END		PCIBR_CTRL_SYS_END
+#define PIC_CTRL_CLR_TLLP_SHFT		PCIBR_CTRL_CLR_TLLP_SHFT
+#define PIC_CTRL_CLR_TLLP		PCIBR_CTRL_CLR_TLLP
+#define PIC_CTRL_CLR_RLLP_SHFT		PCIBR_CTRL_CLR_RLLP_SHFT
+#define PIC_CTRL_CLR_RLLP		PCIBR_CTRL_CLR_RLLP
+#define PIC_CTRL_LLP_XBOW_CRD_SHFT	PCIBR_CTRL_LLP_XBOW_CRD_SHFT
+#define PIC_CTRL_CRED_LIM		PCIBR_CTRL_CRED_LIM
+#define PIC_CTRL_F_BAD_PKT_SHFT		PCIBR_CTRL_F_BAD_PKT_SHFT
+#define PIC_CTRL_F_BAD_PKT		PCIBR_CTRL_F_BAD_PKT
+#define PIC_CTRL_PAGE_SIZE_SHFT		PCIBR_CTRL_PAGE_SIZE_SHFT
+#define PIC_CTRL_PAGE_SIZE		PCIBR_CTRL_PAGE_SIZE
+#define PIC_CTRL_MEM_SWAP_SHFT		PCIBR_CTRL_MEM_SWAP_SHFT
+#define PIC_CTRL_MEM_SWAP		PCIBR_CTRL_MEM_SWAP
+#define PIC_CTRL_RST_SHFT		PCIBR_CTRL_RST_SHFT
+#define PIC_CTRL_RST_PIN(x)		PCIBR_CTRL_RST_PIN(x)
+#define PIC_CTRL_RST(n)			PCIBR_CTRL_RST(n)
+#define PIC_CTRL_RST_MASK		PCIBR_CTRL_RST_MASK
+#define PIC_CTRL_PAR_EN_REQ_SHFT	PCIBR_CTRL_PAR_EN_REQ_SHFT
+#define PIC_CTRL_PAR_EN_REQ		PCIBR_CTRL_PAR_EN_REQ
+#define PIC_CTRL_PAR_EN_RESP_SHFT	PCIBR_CTRL_PAR_EN_RESP_SHFT
+#define PIC_CTRL_PAR_EN_RESP		PCIBR_CTRL_PAR_EN_RESP
+#define PIC_CTRL_PAR_EN_ATE_SHFT	PCIBR_CTRL_PAR_EN_ATE_SHFT
+#define PIC_CTRL_PAR_EN_ATE		PCIBR_CTRL_PAR_EN_ATE
+#define PIC_CTRL_FUN_NUM_MASK		PCIBR_CTRL_FUN_NUM_MASK
+#define PIC_CTRL_FUN_NUM(x)		PCIBR_CTRL_FUN_NUM(x)
+#define PIC_CTRL_DEV_NUM_MASK		PCIBR_CTRL_BUS_NUM_MASK
+#define PIC_CTRL_DEV_NUM(x)		PCIBR_CTRL_DEV_NUM(x)
+#define PIC_CTRL_BUS_NUM_MASK		PCIBR_CTRL_BUS_NUM_MASK
+#define PIC_CTRL_BUS_NUM(x)		PCIBR_CTRL_BUS_NUM(x)
+#define PIC_CTRL_RELAX_ORDER_SHFT	PCIBR_CTRL_RELAX_ORDER_SHFT
+#define PIC_CTRL_RELAX_ORDER		PCIBR_CTRL_RELAX_ORDER
+#define PIC_CTRL_NO_SNOOP_SHFT		PCIBR_CTRL_NO_SNOOP_SHFT
+#define PIC_CTRL_NO_SNOOP		PCIBR_CTRL_NO_SNOOP
+
+/*
+ * PIC Intr Destination Addr	offset 0x00000038 
+ */
+#define PIC_INTR_DEST_ADDR		PIC_XTALK_ADDR_MASK
+#define PIC_INTR_DEST_TID_SHFT		48
+#define PIC_INTR_DEST_TID		(0xFull << PIC_INTR_DEST_TID_SHFT)
+
+/*
+ * PIC PCI Responce Buffer	offset 0x00000068
+ */
+#define PIC_RSP_BUF_ADDR		PIC_XTALK_ADDR_MASK
+#define PIC_RSP_BUF_NUM_SHFT		48
+#define PIC_RSP_BUF_NUM			(0xFull << PIC_RSP_BUF_NUM_SHFT)
+#define PIC_RSP_BUF_DEV_NUM_SHFT	52
+#define PIC_RSP_BUF_DEV_NUM		(0x3ull << PIC_RSP_BUF_DEV_NUM_SHFT)
+
+/*
+ * PIC PCI DIRECT MAP register	offset 0x00000080
+ */
+#define PIC_DIRMAP_DIROFF_SHFT		PCIBR_DIRMAP_DIROFF_SHFT
+#define PIC_DIRMAP_DIROFF		PCIBR_DIRMAP_DIROFF
+#define PIC_DIRMAP_ADD512_SHFT		PCIBR_DIRMAP_ADD512_SHFT
+#define PIC_DIRMAP_ADD512		PCIBR_DIRMAP_ADD512
+#define PIC_DIRMAP_WID_SHFT		20
+#define PIC_DIRMAP_WID			(0xF << PIC_DIRMAP_WID_SHFT)
+
+#define PIC_DIRMAP_OFF_ADDRSHFT		PCIBR_DIRMAP_OFF_ADDRSHFT
+
+/*
+ * PCI TIMEOUT			offset 0x000000C0
+ */
+#define PIC_TMO_RETRY_CNT_SHFT		PCIBR_TMO_RETRY_CNT_SHFT
+#define PIC_TMO_RETRY_CNT		PCIBR_TMO_RETRY_CNT
+#define PIC_TMO_RETRY_CNT_MAX		PCIBR_TMO_RETRY_CNT_MAX
+#define PIC_TMO_RETRY_HLD_SHFT		PCIBR_TMO_RETRY_HLD_SHFT
+#define PIC_TMO_RETRY_HLD		PCIBR_TMO_RETRY_HLD
+
+/* 
+ * PIC INTR STATUS register	offset 0x00000100
+ */
+#define PIC_ISR_PCIX_SPLIT_MSG_PE	PCIBR_ISR_PCIX_SPLIT_MSG_PE
+#define PIC_ISR_PCIX_SPLIT_EMSG		PCIBR_ISR_PCIX_SPLIT_EMSG
+#define PIC_ISR_PCIX_SPLIT_TO		PCIBR_ISR_PCIX_SPLIT_TO
+#define PIC_ISR_PCIX_UNEX_COMP		PCIBR_ISR_PCIX_UNEX_COMP
+#define PIC_ISR_INT_RAM_PERR		PCIBR_ISR_INT_RAM_PERR
+#define PIC_ISR_PCIX_ARB_ERR		PCIBR_ISR_PCIX_ARB_ERR
+#define PIC_ISR_PCIX_REQ_TOUT		PCIBR_ISR_PCIX_REQ_TOUT
+#define PIC_ISR_PCIX_TABORT		PCIBR_ISR_PCIX_TABORT
+#define PIC_ISR_PCIX_PERR		PCIBR_ISR_PCIX_PERR
+#define PIC_ISR_PCIX_SERR		PCIBR_ISR_PCIX_SERR
+#define PIC_ISR_PCIX_MRETRY		PCIBR_ISR_PCIX_MRETRY
+#define PIC_ISR_PCIX_MTOUT		PCIBR_ISR_PCIX_MTOUT
+#define PIC_ISR_PCIX_DA_PARITY		PCIBR_ISR_PCIX_DA_PARITY
+#define PIC_ISR_PCIX_AD_PARITY		PCIBR_ISR_PCIX_AD_PARITY
+#define PIC_ISR_PMU_PAGE_FAULT		PCIBR_ISR_PMU_PAGE_FAULT
+#define PIC_ISR_UNEXP_RESP		PCIBR_ISR_UNEXP_RESP
+#define PIC_ISR_BAD_XRESP_PKT		PCIBR_ISR_BAD_XRESP_PKT
+#define PIC_ISR_BAD_XREQ_PKT		PCIBR_ISR_BAD_XREQ_PKT
+#define PIC_ISR_RESP_XTLK_ERR		PCIBR_ISR_RESP_XTLK_ERR
+#define PIC_ISR_REQ_XTLK_ERR		PCIBR_ISR_REQ_XTLK_ERR
+#define PIC_ISR_INVLD_ADDR		PCIBR_ISR_INVLD_ADDR
+#define PIC_ISR_UNSUPPORTED_XOP		PCIBR_ISR_UNSUPPORTED_XOP
+#define PIC_ISR_XREQ_FIFO_OFLOW		PCIBR_ISR_XREQ_FIFO_OFLOW
+#define PIC_ISR_LLP_REC_SNERR		PCIBR_ISR_LLP_REC_SNERR
+#define PIC_ISR_LLP_REC_CBERR		PCIBR_ISR_LLP_REC_CBERR
+#define PIC_ISR_LLP_RCTY		PCIBR_ISR_LLP_RCTY
+#define PIC_ISR_LLP_TX_RETRY		PCIBR_ISR_LLP_TX_RETRY
+#define PIC_ISR_LLP_TCTY		PCIBR_ISR_LLP_TCTY
+#define PIC_ISR_PCI_ABORT		PCIBR_ISR_PCI_ABORT
+#define PIC_ISR_PCI_PARITY		PCIBR_ISR_PCI_PARITY
+#define PIC_ISR_PCI_SERR		PCIBR_ISR_PCI_SERR
+#define PIC_ISR_PCI_PERR		PCIBR_ISR_PCI_PERR
+#define PIC_ISR_PCI_MST_TIMEOUT		PCIBR_ISR_PCI_MST_TIMEOUT
+#define PIC_ISR_PCI_RETRY_CNT		PCIBR_ISR_PCI_RETRY_CNT
+#define PIC_ISR_XREAD_REQ_TIMEOUT	PCIBR_ISR_XREAD_REQ_TIMEOUT
+#define PIC_ISR_INT_MSK			PCIBR_ISR_INT_MSK
+#define PIC_ISR_INT(x)			PCIBR_ISR_INT(x)
+
+/*
+ * PIC ENABLE INTR register	offset 0x00000108
+ */
+#define PIC_IER_PCIX_SPLIT_MSG_PE	PCIBR_IER_PCIX_SPLIT_MSG_PE
+#define PIC_IER_PCIX_SPLIT_EMSG		PCIBR_IER_PCIX_SPLIT_EMSG
+#define PIC_IER_PCIX_SPLIT_TO		PCIBR_IER_PCIX_SPLIT_TO
+#define PIC_IER_PCIX_UNEX_COMP		PCIBR_IER_PCIX_UNEX_COMP
+#define PIC_IER_INT_RAM_PERR		PCIBR_IER_INT_RAM_PERR
+#define PIC_IER_PCIX_ARB_ERR		PCIBR_IER_PCIX_ARB_ERR
+#define PIC_IER_PCIX_REQ_TOUT		PCIBR_IER_PCIX_REQ_TOUT
+#define PIC_IER_PCIX_TABORT		PCIBR_IER_PCIX_TABORT
+#define PIC_IER_PCIX_PERR		PCIBR_IER_PCIX_PERR
+#define PIC_IER_PCIX_SERR		PCIBR_IER_PCIX_SERR
+#define PIC_IER_PCIX_MRETRY		PCIBR_IER_PCIX_MRETRY
+#define PIC_IER_PCIX_MTOUT		PCIBR_IER_PCIX_MTOUT
+#define PIC_IER_PCIX_DA_PARITY		PCIBR_IER_PCIX_DA_PARITY
+#define PIC_IER_PCIX_AD_PARITY		PCIBR_IER_PCIX_AD_PARITY
+#define PIC_IER_PMU_PAGE_FAULT		PCIBR_IER_PMU_PAGE_FAULT
+#define PIC_IER_UNEXP_RESP		PCIBR_IER_UNEXP_RESP
+#define PIC_IER_BAD_XRESP_PKT		PCIBR_IER_BAD_XRESP_PKT
+#define PIC_IER_BAD_XREQ_PKT		PCIBR_IER_BAD_XREQ_PKT
+#define PIC_IER_RESP_XTLK_ERR		PCIBR_IER_RESP_XTLK_ERR
+#define PIC_IER_REQ_XTLK_ERR		PCIBR_IER_REQ_XTLK_ERR
+#define PIC_IER_INVLD_ADDR		PCIBR_IER_INVLD_ADDR
+#define PIC_IER_UNSUPPORTED_XOP		PCIBR_IER_UNSUPPORTED_XOP
+#define PIC_IER_XREQ_FIFO_OFLOW		PCIBR_IER_XREQ_FIFO_OFLOW
+#define PIC_IER_LLP_REC_SNERR		PCIBR_IER_LLP_REC_SNERR
+#define PIC_IER_LLP_REC_CBERR		PCIBR_IER_LLP_REC_CBERR
+#define PIC_IER_LLP_RCTY		PCIBR_IER_LLP_RCTY
+#define PIC_IER_LLP_TX_RETRY		PCIBR_IER_LLP_TX_RETRY
+#define PIC_IER_LLP_TCTY		PCIBR_IER_LLP_TCTY
+#define PIC_IER_PCI_ABORT		PCIBR_IER_PCI_ABORT
+#define PIC_IER_PCI_PARITY		PCIBR_IER_PCI_PARITY
+#define PIC_IER_PCI_SERR		PCIBR_IER_PCI_SERR
+#define PIC_IER_PCI_PERR		PCIBR_IER_PCI_PERR
+#define PIC_IER_PCI_MST_TIMEOUT		PCIBR_IER_PCI_MST_TIMEOUT
+#define PIC_IER_PCI_RETRY_CNT		PCIBR_IER_PCI_RETRY_CNT
+#define PIC_IER_XREAD_REQ_TIMEOUT	PCIBR_IER_XREAD_REQ_TIMEOUT
+#define PIC_IER_INT_MSK			PCIBR_IER_INT_MSK
+#define PIC_IER_INT(x)			PCIBR_IER_INT(x)
+
+/*
+ * PIC RESET INTR register	offset 0x00000110
+ */
+#define PIC_IRR_PCIX_SPLIT_MSG_PE	PCIBR_IRR_PCIX_SPLIT_MSG_PE
+#define PIC_IRR_PCIX_SPLIT_EMSG		PCIBR_IRR_PCIX_SPLIT_EMSG
+#define PIC_IRR_PCIX_SPLIT_TO		PCIBR_IRR_PCIX_SPLIT_TO
+#define PIC_IRR_PCIX_UNEX_COMP		PCIBR_IRR_PCIX_UNEX_COMP
+#define PIC_IRR_INT_RAM_PERR		PCIBR_IRR_INT_RAM_PERR
+#define PIC_IRR_PCIX_ARB_ERR		PCIBR_IRR_PCIX_ARB_ERR
+#define PIC_IRR_PCIX_REQ_TOUT		PCIBR_IRR_PCIX_REQ_TOUT
+#define PIC_IRR_PCIX_TABORT		PCIBR_IRR_PCIX_TABORT
+#define PIC_IRR_PCIX_PERR		PCIBR_IRR_PCIX_PERR
+#define PIC_IRR_PCIX_SERR		PCIBR_IRR_PCIX_SERR
+#define PIC_IRR_PCIX_MRETRY		PCIBR_IRR_PCIX_MRETRY
+#define PIC_IRR_PCIX_MTOUT		PCIBR_IRR_PCIX_MTOUT
+#define PIC_IRR_PCIX_DA_PARITY		PCIBR_IRR_PCIX_DA_PARITY
+#define PIC_IRR_PCIX_AD_PARITY		PCIBR_IRR_PCIX_AD_PARITY
+#define PIC_IRR_PMU_PAGE_FAULT		PCIBR_IRR_PMU_PAGE_FAULT
+#define PIC_IRR_UNEXP_RESP		PCIBR_IRR_UNEXP_RESP
+#define PIC_IRR_BAD_XRESP_PKT		PCIBR_IRR_BAD_XRESP_PKT
+#define PIC_IRR_BAD_XREQ_PKT		PCIBR_IRR_BAD_XREQ_PKT
+#define PIC_IRR_RESP_XTLK_ERR		PCIBR_IRR_RESP_XTLK_ERR
+#define PIC_IRR_REQ_XTLK_ERR		PCIBR_IRR_REQ_XTLK_ERR
+#define PIC_IRR_INVLD_ADDR		PCIBR_IRR_INVLD_ADDR
+#define PIC_IRR_UNSUPPORTED_XOP		PCIBR_IRR_UNSUPPORTED_XOP
+#define PIC_IRR_XREQ_FIFO_OFLOW		PCIBR_IRR_XREQ_FIFO_OFLOW
+#define PIC_IRR_LLP_REC_SNERR		PCIBR_IRR_LLP_REC_SNERR
+#define PIC_IRR_LLP_REC_CBERR		PCIBR_IRR_LLP_REC_CBERR
+#define PIC_IRR_LLP_RCTY		PCIBR_IRR_LLP_RCTY
+#define PIC_IRR_LLP_TX_RETRY		PCIBR_IRR_LLP_TX_RETRY
+#define PIC_IRR_LLP_TCTY		PCIBR_IRR_LLP_TCTY
+#define PIC_IRR_PCI_ABORT		PCIBR_IRR_PCI_ABORT
+#define PIC_IRR_PCI_PARITY		PCIBR_IRR_PCI_PARITY
+#define PIC_IRR_PCI_SERR		PCIBR_IRR_PCI_SERR
+#define PIC_IRR_PCI_PERR		PCIBR_IRR_PCI_PERR
+#define PIC_IRR_PCI_MST_TIMEOUT		PCIBR_IRR_PCI_MST_TIMEOUT
+#define PIC_IRR_PCI_RETRY_CNT		PCIBR_IRR_PCI_RETRY_CNT
+#define PIC_IRR_XREAD_REQ_TIMEOUT	PCIBR_IRR_XREAD_REQ_TIMEOUT
+#define PIC_IRR_MULTI_CLR		PCIBR_IRR_MULTI_CLR
+#define PIC_IRR_CRP_GRP_CLR		PCIBR_IRR_CRP_GRP_CLR
+#define PIC_IRR_RESP_BUF_GRP_CLR	PCIBR_IRR_RESP_BUF_GRP_CLR
+#define PIC_IRR_REQ_DSP_GRP_CLR		PCIBR_IRR_REQ_DSP_GRP_CLR
+#define PIC_IRR_LLP_GRP_CLR		PCIBR_IRR_LLP_GRP_CLR
+#define PIC_IRR_SSRAM_GRP_CLR		PCIBR_IRR_SSRAM_GRP_CLR
+#define PIC_IRR_PCI_GRP_CLR		PCIBR_IRR_PCI_GRP_CLR
+#define PIC_IRR_GIO_GRP_CLR		PCIBR_IRR_GIO_GRP_CLR
+#define PIC_IRR_ALL_CLR			PCIBR_IRR_ALL_CLR
+
+/*
+ * PIC Intr Dev Select register	offset 0x00000120
+ */
+#define PIC_INT_DEV_SHFT(n)		PCIBR_INT_DEV_SHFT(n)
+#define PIC_INT_DEV_MASK(n)		PCIBR_INT_DEV_MASK(n)
+
+/*
+ * PIC PCI Host Intr Addr	offset 0x00000130 - 0x00000168
+ */
+#define PIC_HOST_INTR_ADDR		PIC_XTALK_ADDR_MASK
+#define PIC_HOST_INTR_FLD_SHFT		48	
+#define PIC_HOST_INTR_FLD		(0xFFull << PIC_HOST_INTR_FLD_SHFT)
+
+/*
+ * PIC DEVICE(x) register	offset 0x00000200
+ */
+#define PIC_DEV_OFF_ADDR_SHFT		PCIBR_DEV_OFF_ADDR_SHFT
+#define PIC_DEV_OFF_MASK		PCIBR_DEV_OFF_MASK
+#define PIC_DEV_DEV_IO_MEM		PCIBR_DEV_DEV_IO_MEM
+#define PIC_DEV_DEV_SWAP		PCIBR_DEV_DEV_SWAP
+#define PIC_DEV_GBR			PCIBR_DEV_GBR
+#define PIC_DEV_BARRIER			PCIBR_DEV_BARRIER
+#define PIC_DEV_COH			PCIBR_DEV_COH
+#define PIC_DEV_PRECISE			PCIBR_DEV_PRECISE
+#define PIC_DEV_PREF			PCIBR_DEV_PREF
+#define PIC_DEV_SWAP_DIR		PCIBR_DEV_SWAP_DIR
+#define PIC_DEV_RT			PCIBR_DEV_RT
+#define PIC_DEV_DEV_SIZE		PCIBR_DEV_DEV_SIZE
+#define PIC_DEV_DIR_WRGA_EN		PCIBR_DEV_DIR_WRGA_EN
+#define PIC_DEV_VIRTUAL_EN		PCIBR_DEV_VIRTUAL_EN
+#define PIC_DEV_FORCE_PCI_PAR		PCIBR_DEV_FORCE_PCI_PAR
+#define PIC_DEV_PAGE_CHK_DIS		PCIBR_DEV_PAGE_CHK_DIS
+#define PIC_DEV_ERR_LOCK_EN		PCIBR_DEV_ERR_LOCK_EN
+
+/*
+ * PIC Even & Odd RRB registers	offset 0x000000280 & 0x000000288
+ */
+/* Individual RRB masks after shifting down */
+#define PIC_RRB_EN			PCIBR_RRB_EN
+#define PIC_RRB_DEV			PCIBR_RRB_DEV
+#define PIC_RRB_VDEV			PCIBR_RRB_VDEV
+#define PIC_RRB_PDEV			PCIBR_RRB_PDEV
+
+/*
+ * PIC RRB status register 	offset 0x00000290
+ */
+#define PIC_RRB_VALID(r)		PCIBR_RRB_VALID(r)
+#define PIC_RRB_INUSE(r)		PCIBR_RRB_INUSE(r)
+
+/*
+ * PIC RRB clear register 	offset 0x00000298
+ */
+#define PIC_RRB_CLEAR(r)		PCIBR_RRB_CLEAR(r)
+
+
+/*****************************************************************************
+ ****************************** PIC DMA DEFINES ******************************
+ *****************************************************************************/
+
+/*
+ * PIC - PMU Address Transaltion Entry defines 
+ */
+#define PIC_ATE_V			PCIBR_ATE_V
+#define PIC_ATE_CO			PCIBR_ATE_CO
+#define PIC_ATE_PREC			PCIBR_ATE_PREC
+#define PIC_ATE_PREF			PCIBR_ATE_PREF
+#define PIC_ATE_BAR			PCIBR_ATE_BAR
+#define PIC_ATE_TARGETID_SHFT		8
+#define PIC_ATE_TARGETID		(0xF << PIC_ATE_TARGETID_SHFT)
+#define PIC_ATE_ADDR_SHFT		PCIBR_ATE_ADDR_SHFT
+#define PIC_ATE_ADDR_MASK		(0xFFFFFFFFF000)
+
+/* bit 29 of the pci address is the SWAP bit */
+#define PIC_ATE_SWAPSHIFT		ATE_SWAPSHIFT
+#define PIC_SWAP_ON(x)			ATE_SWAP_ON(x)
+#define PIC_SWAP_OFF(x)			ATE_SWAP_OFF(x)
+
+/*  
+ * Bridge 32bit Bus DMA addresses  
+ */
+#define PIC_LOCAL_BASE			PCIBR_LOCAL_BASE
+#define PIC_DMA_MAPPED_BASE		PCIBR_DMA_MAPPED_BASE
+#define PIC_DMA_MAPPED_SIZE		PCIBR_DMA_MAPPED_SIZE
+#define PIC_DMA_DIRECT_BASE		PCIBR_DMA_DIRECT_BASE
+#define PIC_DMA_DIRECT_SIZE		PCIBR_DMA_DIRECT_SIZE
+
+/*
+ * Bridge 64bit Direct Map Attributes
+ */
+#define PIC_PCI64_ATTR_TARG_MASK	0xf000000000000000
+#define PIC_PCI64_ATTR_TARG_SHFT	60
+#define PIC_PCI64_ATTR_PREF		PCI64_ATTR_PREF
+#define PIC_PCI64_ATTR_PREC		PCI64_ATTR_PREC
+#define PIC_PCI64_ATTR_VIRTUAL		PCI64_ATTR_VIRTUAL
+#define PIC_PCI64_ATTR_BAR		PCI64_ATTR_BAR
+#define PIC_PCI64_ATTR_SWAP		PCI64_ATTR_SWAP
+#define PIC_PCI64_ATTR_VIRTUAL1		PCI64_ATTR_VIRTUAL1
+
+
+/*****************************************************************************
+ ****************************** PIC PIO DEFINES ******************************
+ *****************************************************************************/
+
+/* NOTE: Bus one offset to PCI Widget Device Space. */
+#define PIC_BUS1_OFFSET				0x800000 
+
+/*
+ * Macros for Xtalk to Bridge bus (PCI) PIO.  Refer to section 5.2.1 figure
+ * 4 of the "PCI Interface Chip (PIC) Volume II Programmer's Reference" 
+ */
+/* XTALK addresses that map into PIC Bridge Bus addr space */
+#define PICBRIDGE0_PIO32_XTALK_ALIAS_BASE	0x000040000000L
+#define PICBRIDGE0_PIO32_XTALK_ALIAS_LIMIT	0x00007FFFFFFFL
+#define PICBRIDGE0_PIO64_XTALK_ALIAS_BASE	0x000080000000L
+#define PICBRIDGE0_PIO64_XTALK_ALIAS_LIMIT	0x0000BFFFFFFFL
+#define PICBRIDGE1_PIO32_XTALK_ALIAS_BASE	0x0000C0000000L
+#define PICBRIDGE1_PIO32_XTALK_ALIAS_LIMIT	0x0000FFFFFFFFL
+#define PICBRIDGE1_PIO64_XTALK_ALIAS_BASE	0x000100000000L
+#define PICBRIDGE1_PIO64_XTALK_ALIAS_LIMIT	0x00013FFFFFFFL
+
+/* XTALK addresses that map into PCI addresses */
+#define PICBRIDGE0_PCI_MEM32_BASE	PICBRIDGE0_PIO32_XTALK_ALIAS_BASE
+#define PICBRIDGE0_PCI_MEM32_LIMIT	PICBRIDGE0_PIO32_XTALK_ALIAS_LIMIT
+#define PICBRIDGE0_PCI_MEM64_BASE	PICBRIDGE0_PIO64_XTALK_ALIAS_BASE
+#define PICBRIDGE0_PCI_MEM64_LIMIT	PICBRIDGE0_PIO64_XTALK_ALIAS_LIMIT
+#define PICBRIDGE1_PCI_MEM32_BASE	PICBRIDGE1_PIO32_XTALK_ALIAS_BASE
+#define PICBRIDGE1_PCI_MEM32_LIMIT	PICBRIDGE1_PIO32_XTALK_ALIAS_LIMIT
+#define PICBRIDGE1_PCI_MEM64_BASE	PICBRIDGE1_PIO64_XTALK_ALIAS_BASE
+#define PICBRIDGE1_PCI_MEM64_LIMIT	PICBRIDGE1_PIO64_XTALK_ALIAS_LIMIT
+
+/*****************************************************************************
+ ****************************** PIC MISC DEFINES *****************************
+ *****************************************************************************/
+
+#define PIC_XTALK_ADDR_MASK			0x0000FFFFFFFFFFFF
+
+#define PIC_INTERNAL_ATES			1024 
+#define PIC_WR_REQ_BUFSIZE			256
+
+/* This should be written to the Xbow's Link(x) Control register */
+#define PIC_LLP_CREDITS				3
 
 #endif                          /* _ASM_IA64_SN_PCI_PIC_H */
