Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWJBMEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWJBMEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 08:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWJBMEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 08:04:43 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:1517 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1750941AbWJBMEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 08:04:42 -0400
Date: Mon, 2 Oct 2006 14:04:31 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] restore parport_pc probing on powermac
Message-ID: <20061002120431.GA14670@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The last change for partport_pc did fix the common case for all PowerMacs,
but it broke the case for PCI multiport IO cards.
In fact, the config option CONFIG_PARPORT_PC_SUPERIO=y lead to a hard crash
when cups probed the parport driver. It enables the winbond and smsc probing.

Remove the PARPORT_BASE check again, parport_pc_find_nonpci_ports() will take
care of it. 
All powerpc configs should have CONFIG_PARPORT_PC_SUPERIO=n, the code did not
find anything on the chrp boards we tested it on.

Tested on a G4/466 with a PCI card:

0001:10:13.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01) (prog-if 02 [16550])
        Subsystem: Timedia Technology Co Ltd Unknown device 5079
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 53
        Region 0: I/O ports at f2000800 [size=32]
        Region 2: I/O ports at f2000870 [size=8]
        Region 3: I/O ports at f2000860 [size=8]

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/platforms/pseries/setup.c |    6 ------
 drivers/parport/parport_pc.c           |    4 ----
 include/asm-powerpc/io.h               |    1 -
 3 files changed, 11 deletions(-)

Index: linux-2.6.18-git17/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.18-git17.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6.18-git17/arch/powerpc/platforms/pseries/setup.c
@@ -415,12 +415,6 @@ static int pSeries_check_legacy_ioport(u
 			return -ENODEV;
 		of_node_put(np);
 		break;
-	case PARALLEL_BASE:
-		np = of_find_node_by_type(NULL, "parallel");
-		if (np == NULL)
-			return -ENODEV;
-		of_node_put(np);
-		break;
 	}
 	return 0;
 }
Index: linux-2.6.18-git17/drivers/parport/parport_pc.c
===================================================================
--- linux-2.6.18-git17.orig/drivers/parport/parport_pc.c
+++ linux-2.6.18-git17/drivers/parport/parport_pc.c
@@ -3374,10 +3374,6 @@ __setup("parport_init_mode=",parport_ini
 
 static int __init parport_pc_init(void)
 {
-#if defined(CONFIG_PPC_MERGE)
-	if (check_legacy_ioport(PARALLEL_BASE))
-		return -ENODEV;
-#endif
 	if (parse_parport_params())
 		return -EINVAL;
 
Index: linux-2.6.18-git17/include/asm-powerpc/io.h
===================================================================
--- linux-2.6.18-git17.orig/include/asm-powerpc/io.h
+++ linux-2.6.18-git17/include/asm-powerpc/io.h
@@ -11,7 +11,6 @@
 
 /* Check of existence of legacy devices */
 extern int check_legacy_ioport(unsigned long base_port);
-#define PARALLEL_BASE	0x378
 #define PNPBIOS_BASE	0xf000	/* only relevant for PReP */
 
 #ifndef CONFIG_PPC64
