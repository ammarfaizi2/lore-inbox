Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268393AbUHKXhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268393AbUHKXhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268388AbUHKXge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:36:34 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:9442 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268332AbUHKXZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:25:55 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112324.i7BNOZul163539@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 3 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:24:35 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 15:02:38-05:00 pfg@sgi.com 
#   kill more unused files
# 
# BitKeeper/deleted/.del-sgi_io_init.c~397f7f16fdcad9db
#   2004/08/11 15:01:51-05:00 pfg@sgi.com +0 -0
#   Delete: arch/ia64/sn/io/platform_init/sgi_io_init.c
# 
# BitKeeper/deleted/.del-Makefile~bc1ee0a52ae19e6
#   2004/08/11 15:01:51-05:00 pfg@sgi.com +0 -0
#   Delete: arch/ia64/sn/io/platform_init/Makefile
# 
diff -Nru a/arch/ia64/sn/io/platform_init/Makefile b/arch/ia64/sn/io/platform_init/Makefile
--- a/arch/ia64/sn/io/platform_init/Makefile	2004-08-11 15:04:16 -05:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,10 +0,0 @@
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 2002-2003 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# Makefile for the sn2 io routines.
-
-obj-y				+=  sgi_io_init.o
diff -Nru a/arch/ia64/sn/io/platform_init/sgi_io_init.c b/arch/ia64/sn/io/platform_init/sgi_io_init.c
--- a/arch/ia64/sn/io/platform_init/sgi_io_init.c	2004-08-11 15:04:16 -05:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,174 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1992 - 1997, 2000-2003 Silicon Graphics, Inc. All rights reserved.
- */
-
-#include <linux/types.h>
-#include <linux/config.h>
-#include <linux/slab.h>
-#include <linux/smp.h>
-#include <asm/sn/sgi.h>
-#include <asm/sn/io.h>
-#include <asm/sn/sn_cpuid.h>
-#include <asm/sn/klconfig.h>
-#include <asm/sn/sn_private.h>
-#include <asm/sn/pda.h>
-
-extern void init_all_devices(void);
-extern void klhwg_add_all_modules(vertex_hdl_t);
-extern void klhwg_add_all_nodes(vertex_hdl_t);
-
-extern int init_hcl(void);
-extern vertex_hdl_t hwgraph_root;
-extern void io_module_init(void);
-extern int pci_bus_to_hcl_cvlink(void);
-
-nasid_t console_nasid = (nasid_t) - 1;
-char master_baseio_wid;
-
-nasid_t master_baseio_nasid;
-nasid_t master_nasid = INVALID_NASID;	/* This is the partition master nasid */
-
-/*
- * per_hub_init
- *
- * 	This code is executed once for each Hub chip.
- */
-static void __init
-per_hub_init(cnodeid_t cnode)
-{
-	nasid_t nasid;
-	nodepda_t *npdap;
-	ii_icmr_u_t ii_icmr;
-	ii_ibcr_u_t ii_ibcr;
-	ii_ilcsr_u_t ii_ilcsr;
-
-	nasid = cnodeid_to_nasid(cnode);
-
-	ASSERT(nasid != INVALID_NASID);
-	ASSERT(nasid_to_cnodeid(nasid) == cnode);
-
-	npdap = NODEPDA(cnode);
-
-	/* Disable the request and reply errors. */
-	REMOTE_HUB_S(nasid, IIO_IWEIM, 0xC000);
-
-	/*
-	 * Set the total number of CRBs that can be used.
-	 */
-	ii_icmr.ii_icmr_regval = 0x0;
-	ii_icmr.ii_icmr_fld_s.i_c_cnt = 0xf;
-	if (enable_shub_wars_1_1()) {
-		// Set bit one of ICMR to prevent II from sending interrupt for II bug.
-		ii_icmr.ii_icmr_regval |= 0x1;
-	}
-	REMOTE_HUB_S(nasid, IIO_ICMR, ii_icmr.ii_icmr_regval);
-
-	/*
-	 * Set the number of CRBs that both of the BTEs combined
-	 * can use minus 1.
-	 */
-	ii_ibcr.ii_ibcr_regval = 0x0;
-	ii_ilcsr.ii_ilcsr_regval = REMOTE_HUB_L(nasid, IIO_LLP_CSR);
-	if (ii_ilcsr.ii_ilcsr_fld_s.i_llp_stat & LNK_STAT_WORKING) {
-		ii_ibcr.ii_ibcr_fld_s.i_count = 0x8;
-	} else {
-		/*
-		 * if the LLP is down, there is no attached I/O, so
-		 * give BTE all the CRBs.
-		 */
-		ii_ibcr.ii_ibcr_fld_s.i_count = 0x14;
-	}
-	REMOTE_HUB_S(nasid, IIO_IBCR, ii_ibcr.ii_ibcr_regval);
-
-	/*
-	 * Set CRB timeout to be 10ms.
-	 */
-	REMOTE_HUB_S(nasid, IIO_ICTP, 0xffffff);
-	REMOTE_HUB_S(nasid, IIO_ICTO, 0xff);
-
-	/* Initialize error interrupts for this hub. */
-	hub_error_init(cnode);
-}
-
-/*
- * This routine is responsible for the setup of all the IRIX hwgraph style
- * stuff that's been pulled into linux.  It's called by sn_pci_find_bios which
- * is called just before the generic Linux PCI layer does its probing (by 
- * platform_pci_fixup aka sn_pci_fixup).
- *
- * It is very IMPORTANT that this call is only made by the Master CPU!
- *
- */
-
-void __init
-sgi_master_io_infr_init(void)
-{
-	cnodeid_t cnode;
-
-	if (init_hcl() < 0) {	/* Sets up the hwgraph compatibility layer */
-		printk("sgi_master_io_infr_init: Cannot init hcl\n");
-		return;
-	}
-
-	/*
-	 * Initialize platform-dependent vertices in the hwgraph:
-	 *      module
-	 *      node
-	 *      cpu
-	 *      memory
-	 *      slot
-	 *      hub
-	 *      router
-	 *      xbow
-	 */
-
-	io_module_init();	/* Use to be called module_init() .. */
-	klhwg_add_all_modules(hwgraph_root);
-	klhwg_add_all_nodes(hwgraph_root);
-
-	for (cnode = 0; cnode < numionodes; cnode++)
-		per_hub_init(cnode);
-
-	/*
-	 *
-	 * Our IO Infrastructure drivers are in place .. 
-	 * Initialize the whole IO Infrastructure .. xwidget/device probes.
-	 *
-	 */
-	init_all_devices();
-	pci_bus_to_hcl_cvlink();
-}
-
-inline int
-check_nasid_equiv(nasid_t nasida, nasid_t nasidb)
-{
-	if ((nasida == nasidb)
-	    || (nasida == NODEPDA(nasid_to_cnodeid(nasidb))->xbow_peer))
-		return 1;
-	else
-		return 0;
-}
-
-int
-is_master_baseio_nasid_widget(nasid_t test_nasid, xwidgetnum_t test_wid)
-{
-	/*
-	 * If the widget numbers are different, we're not the master.
-	 */
-	if (test_wid != (xwidgetnum_t) master_baseio_wid) {
-		return 0;
-	}
-
-	/*
-	 * If the NASIDs are the same or equivalent, we're the master.
-	 */
-	if (check_nasid_equiv(test_nasid, master_baseio_nasid)) {
-		return 1;
-	} else {
-		return 0;
-	}
-}
