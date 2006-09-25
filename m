Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWIYGpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWIYGpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWIYGpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:45:54 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:53691 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1750821AbWIYGpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:45:53 -0400
Subject: [PATCH] ioremap balanced with iounmap for drivers/mtd subsystem
From: Amol Lad <amol@verismonetworks.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
In-Reply-To: <20060923124359.GA17408@electric-eye.fr.zoreil.com>
References: <200609222101.k8ML1oW5019174@hera.kernel.org>
	 <20060923124359.GA17408@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 12:19:10 +0530
Message-Id: <1159166950.25016.30.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Incorporated Francoiss' comments.

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only) with:
- allmodconfig
- Modifying drivers/mtd/maps/Kconfig and drivers/mtd/nand/Kconfig to
make sure that the changed file is compiling without warning

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 maps/arctic-mtd.c     |   14 ++++++++++++--
 maps/beech-mtd.c      |   14 ++++++++++++--
 maps/cstm_mips_ixx.c  |   18 ++++++++++++++++--
 maps/ebony.c          |    4 ++++
 maps/fortunet.c       |    3 +++
 maps/lasat.c          |    2 ++
 maps/nettel.c         |   34 +++++++++++++++++++++++++++-------
 maps/ocotea.c         |    4 ++++
 maps/pcmciamtd.c      |    4 ++++
 maps/redwood.c        |   11 ++++++++++-
 maps/sbc8240.c        |   11 ++++++++++-
 maps/walnut.c         |    4 ++++
 nand/edb7312.c        |    3 +++
 nand/ppchameleonevb.c |    7 +++++++
 14 files changed, 118 insertions(+), 15 deletions(-)
---
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/arctic-mtd.c linux-2.6.18/drivers/mtd/maps/arctic-mtd.c
--- linux-2.6.18-orig/drivers/mtd/maps/arctic-mtd.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/arctic-mtd.c	2006-09-21 16:51:44.000000000 +0530
@@ -96,6 +96,8 @@ static struct mtd_partition arctic_parti
 static int __init
 init_arctic_mtd(void)
 {
+	int err;
+
 	printk("%s: 0x%08x at 0x%08x\n", NAME, SIZE, PADDR);
 
 	arctic_mtd_map.virt = ioremap(PADDR, SIZE);
@@ -109,12 +111,20 @@ init_arctic_mtd(void)
 	printk("%s: probing %d-bit flash bus\n", NAME, BUSWIDTH * 8);
 	arctic_mtd = do_map_probe("cfi_probe", &arctic_mtd_map);
 
-	if (!arctic_mtd)
+	if (!arctic_mtd) {
+		iounmap(arctic_mtd_map.virt);
 		return -ENXIO;
+	}
 
 	arctic_mtd->owner = THIS_MODULE;
 
-	return add_mtd_partitions(arctic_mtd, arctic_partitions, PARTITIONS);
+	err = add_mtd_partitions(arctic_mtd, arctic_partitions, PARTITIONS);
+	if (err) {
+		printk("%s: add_mtd_partitions failed\n", NAME);
+		iounmap(arctic_mtd_map.virt);
+	}
+
+	return err;
 }
 
 static void __exit
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/beech-mtd.c linux-2.6.18/drivers/mtd/maps/beech-mtd.c
--- linux-2.6.18-orig/drivers/mtd/maps/beech-mtd.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/beech-mtd.c	2006-09-21 16:52:39.000000000 +0530
@@ -72,6 +72,8 @@ static struct mtd_partition beech_partit
 static int __init
 init_beech_mtd(void)
 {
+	int err;
+
 	printk("%s: 0x%08x at 0x%08x\n", NAME, SIZE, PADDR);
 
 	beech_mtd_map.virt = ioremap(PADDR, SIZE);
@@ -86,12 +88,20 @@ init_beech_mtd(void)
 	printk("%s: probing %d-bit flash bus\n", NAME, BUSWIDTH * 8);
 	beech_mtd = do_map_probe("cfi_probe", &beech_mtd_map);
 
-	if (!beech_mtd)
+	if (!beech_mtd) {
+		iounmap(beech_mtd_map.virt);
 		return -ENXIO;
+	}
 
 	beech_mtd->owner = THIS_MODULE;
 
-	return add_mtd_partitions(beech_mtd, beech_partitions, 2);
+	err = add_mtd_partitions(beech_mtd, beech_partitions, 2);
+	if (err) {
+		printk("%s: add_mtd_partitions failed\n", NAME);
+		iounmap(beech_mtd_map.virt);
+	}
+
+	return err;
 }
 
 static void __exit
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/cstm_mips_ixx.c linux-2.6.18/drivers/mtd/maps/cstm_mips_ixx.c
--- linux-2.6.18-orig/drivers/mtd/maps/cstm_mips_ixx.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/cstm_mips_ixx.c	2006-09-21 16:52:39.000000000 +0530
@@ -171,7 +171,14 @@ int __init init_cstm_mips_ixx(void)
 		cstm_mips_ixx_map[i].phys = cstm_mips_ixx_board_desc[i].window_addr;
 		cstm_mips_ixx_map[i].virt = ioremap(cstm_mips_ixx_board_desc[i].window_addr, cstm_mips_ixx_board_desc[i].window_size);
 		if (!cstm_mips_ixx_map[i].virt) {
+			int j = 0;
 			printk(KERN_WARNING "Failed to ioremap\n");
+			for (j = 0; j < i; j++) {
+				if (cstm_mips_ixx_map[j].virt) {
+					iounmap(cstm_mips_ixx_map[j].virt);
+					cstm_mips_ixx_map[j].virt = NULL;
+				}
+			}
 			return -EIO;
 	        }
 		cstm_mips_ixx_map[i].name = cstm_mips_ixx_board_desc[i].name;
@@ -204,8 +211,15 @@ int __init init_cstm_mips_ixx(void)
 	                cstm_mips_ixx_map[i].map_priv_2 = (unsigned long)mymtd;
 		        add_mtd_partitions(mymtd, parts, cstm_mips_ixx_board_desc[i].num_partitions);
 		}
-		else
-	           return -ENXIO;
+		else {
+			for (i = 0; i < PHYSMAP_NUMBER; i++) {
+				if (cstm_mips_ixx_map[i].virt) {
+					iounmap(cstm_mips_ixx_map[i].virt);
+					cstm_mips_ixx_map[i].virt = NULL;
+				}
+			}
+			return -ENXIO;
+		}
 	}
 	return 0;
 }
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/ebony.c linux-2.6.18/drivers/mtd/maps/ebony.c
--- linux-2.6.18-orig/drivers/mtd/maps/ebony.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/ebony.c	2006-09-21 16:52:39.000000000 +0530
@@ -108,6 +108,7 @@ int __init init_ebony(void)
 					ARRAY_SIZE(ebony_small_partitions));
 	} else {
 		printk("map probe failed for flash\n");
+		iounmap(ebony_small_map.virt);
 		return -ENXIO;
 	}
 
@@ -117,6 +118,7 @@ int __init init_ebony(void)
 
 	if (!ebony_large_map.virt) {
 		printk("Failed to ioremap flash\n");
+		iounmap(ebony_small_map.virt);
 		return -EIO;
 	}
 
@@ -129,6 +131,8 @@ int __init init_ebony(void)
 					ARRAY_SIZE(ebony_large_partitions));
 	} else {
 		printk("map probe failed for flash\n");
+		iounmap(ebony_small_map.virt);
+		iounmap(ebony_large_map.virt);
 		return -ENXIO;
 	}
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/fortunet.c linux-2.6.18/drivers/mtd/maps/fortunet.c
--- linux-2.6.18-orig/drivers/mtd/maps/fortunet.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/fortunet.c	2006-09-21 16:52:39.000000000 +0530
@@ -218,8 +218,11 @@ int __init init_fortunet(void)
 				map_regions[ix].map_info.size);
 			if(!map_regions[ix].map_info.virt)
 			{
+				int j = 0;
 				printk(MTD_FORTUNET_PK "%s flash failed to ioremap!\n",
 					map_regions[ix].map_info.name);
+				for (j = 0 ; j < ix; j++)
+					iounmap(map_regions[j].map_info.virt);
 				return -ENXIO;
 			}
 			simple_map_init(&map_regions[ix].map_info);
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/lasat.c linux-2.6.18/drivers/mtd/maps/lasat.c
--- linux-2.6.18-orig/drivers/mtd/maps/lasat.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/lasat.c	2006-09-21 16:52:39.000000000 +0530
@@ -79,6 +79,7 @@ static int __init init_lasat(void)
 		return 0;
 	}
 
+	iounmap(lasat_map.virt);
 	return -ENXIO;
 }
 
@@ -89,6 +90,7 @@ static void __exit cleanup_lasat(void)
 		map_destroy(lasat_mtd);
 	}
 	if (lasat_map.virt) {
+		iounmap(lasat_map.virt);
 		lasat_map.virt = 0;
 	}
 }
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/nettel.c linux-2.6.18/drivers/mtd/maps/nettel.c
--- linux-2.6.18-orig/drivers/mtd/maps/nettel.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/nettel.c	2006-09-21 16:55:13.000000000 +0530
@@ -277,6 +277,7 @@ int __init nettel_init(void)
 	nettel_amd_map.virt = ioremap_nocache(amdaddr, maxsize);
 	if (!nettel_amd_map.virt) {
 		printk("SNAPGEAR: failed to ioremap() BOOTCS\n");
+		iounmap(nettel_mmcrp);
 		return(-EIO);
 	}
 	simple_map_init(&nettel_amd_map);
@@ -337,7 +338,8 @@ int __init nettel_init(void)
 		nettel_amd_map.virt = NULL;
 #else
 		/* Only AMD flash supported */
-		return(-ENXIO);
+		rc = -ENXIO;
+		goto out_unmap2;
 #endif
 	}
 
@@ -361,14 +363,15 @@ int __init nettel_init(void)
 	nettel_intel_map.virt = ioremap_nocache(intel0addr, maxsize);
 	if (!nettel_intel_map.virt) {
 		printk("SNAPGEAR: failed to ioremap() ROMCS1\n");
-		return(-EIO);
+		rc = -EIO;
+		goto out_unmap2;
 	}
 	simple_map_init(&nettel_intel_map);
 
 	intel_mtd = do_map_probe("cfi_probe", &nettel_intel_map);
 	if (!intel_mtd) {
-		iounmap(nettel_intel_map.virt);
-		return(-ENXIO);
+		rc = -ENXIO;
+		goto out_unmap1;
 	}
 
 	/* Set PAR to the detected size */
@@ -394,13 +397,14 @@ int __init nettel_init(void)
 	nettel_intel_map.virt = ioremap_nocache(intel0addr, maxsize);
 	if (!nettel_intel_map.virt) {
 		printk("SNAPGEAR: failed to ioremap() ROMCS1/2\n");
-		return(-EIO);
+		rc = -EIO;
+		goto out_unmap2;
 	}
 
 	intel_mtd = do_map_probe("cfi_probe", &nettel_intel_map);
 	if (! intel_mtd) {
-		iounmap((void *) nettel_intel_map.virt);
-		return(-ENXIO);
+		rc = -ENXIO;
+		goto out_unmap1;
 	}
 
 	intel1size = intel_mtd->size - intel0size;
@@ -456,6 +460,18 @@ int __init nettel_init(void)
 #endif
 
 	return(rc);
+
+#ifdef CONFIG_MTD_CFI_INTELEXT
+out_unmap1:
+	iounmap(nettel_intel_map.virt);
+#endif
+
+out_unmap2:
+	iounmap(nettel_mmcrp);
+	iounmap(nettel_amd_map.virt);
+
+	return(rc);
+		
 }
 
 /****************************************************************************/
@@ -469,6 +485,10 @@ void __exit nettel_cleanup(void)
 		del_mtd_partitions(amd_mtd);
 		map_destroy(amd_mtd);
 	}
+	if (nettel_mmcrp) {
+		iounmap(nettel_mmcrp);
+		nettel_mmcrp = NULL;
+	}
 	if (nettel_amd_map.virt) {
 		iounmap(nettel_amd_map.virt);
 		nettel_amd_map.virt = NULL;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/ocotea.c linux-2.6.18/drivers/mtd/maps/ocotea.c
--- linux-2.6.18-orig/drivers/mtd/maps/ocotea.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/ocotea.c	2006-09-21 16:52:39.000000000 +0530
@@ -97,6 +97,7 @@ int __init init_ocotea(void)
 					ARRAY_SIZE(ocotea_small_partitions));
 	} else {
 		printk("map probe failed for flash\n");
+		iounmap(ocotea_small_map.virt);
 		return -ENXIO;
 	}
 
@@ -106,6 +107,7 @@ int __init init_ocotea(void)
 
 	if (!ocotea_large_map.virt) {
 		printk("Failed to ioremap flash\n");
+		iounmap(ocotea_small_map.virt);
 		return -EIO;
 	}
 
@@ -118,6 +120,8 @@ int __init init_ocotea(void)
 					ARRAY_SIZE(ocotea_large_partitions));
 	} else {
 		printk("map probe failed for flash\n");
+		iounmap(ocotea_small_map.virt);
+		iounmap(ocotea_large_map.virt);
 		return -ENXIO;
 	}
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/pcmciamtd.c linux-2.6.18/drivers/mtd/maps/pcmciamtd.c
--- linux-2.6.18-orig/drivers/mtd/maps/pcmciamtd.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/pcmciamtd.c	2006-09-21 16:52:39.000000000 +0530
@@ -602,6 +602,10 @@ static int pcmciamtd_config(struct pcmci
 	ret = pcmcia_request_configuration(link, &link->conf);
 	if(ret != CS_SUCCESS) {
 		cs_error(link, RequestConfiguration, ret);
+		if (dev->win_base) {
+			iounmap(dev->win_base);
+			dev->win_base = NULL;
+		}
 		return -ENODEV;
 	}
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/redwood.c linux-2.6.18/drivers/mtd/maps/redwood.c
--- linux-2.6.18-orig/drivers/mtd/maps/redwood.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/redwood.c	2006-09-21 16:52:39.000000000 +0530
@@ -126,6 +126,8 @@ static struct mtd_info *redwood_mtd;
 
 int __init init_redwood_flash(void)
 {
+	int err;
+
 	printk(KERN_NOTICE "redwood: flash mapping: %x at %x\n",
 			WINDOW_SIZE, WINDOW_ADDR);
 
@@ -141,11 +143,18 @@ int __init init_redwood_flash(void)
 
 	if (redwood_mtd) {
 		redwood_mtd->owner = THIS_MODULE;
-		return add_mtd_partitions(redwood_mtd,
+		err = add_mtd_partitions(redwood_mtd,
 				redwood_flash_partitions,
 				NUM_REDWOOD_FLASH_PARTITIONS);
+		if (err) {
+			printk("init_redwood_flash: add_mtd_partitions failed\n");
+			iounmap(redwood_flash_map.virt);
+		}
+		return err;
+
 	}
 
+	iounmap(redwood_flash_map.virt);
 	return -ENXIO;
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/sbc8240.c linux-2.6.18/drivers/mtd/maps/sbc8240.c
--- linux-2.6.18-orig/drivers/mtd/maps/sbc8240.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/sbc8240.c	2006-09-21 17:17:27.000000000 +0530
@@ -156,7 +156,7 @@ int __init init_sbc8240_mtd (void)
 	};
 
 	int devicesfound = 0;
-	int i;
+	int i,j;
 
 	for (i = 0; i < NUM_FLASH_BANKS; i++) {
 		printk (KERN_NOTICE MSG_PREFIX
@@ -166,6 +166,10 @@ int __init init_sbc8240_mtd (void)
 			(unsigned long) ioremap (pt[i].addr, pt[i].size);
 		if (!sbc8240_map[i].map_priv_1) {
 			printk (MSG_PREFIX "failed to ioremap\n");
+			for (j = 0; j < i; j++) {
+				iounmap((void *) sbc8240_map[j].map_priv_1);
+				sbc8240_map[j].map_priv_1 = 0;
+			}
 			return -EIO;
 		}
 		simple_map_init(&sbc8240_mtd[i]);
@@ -175,6 +179,11 @@ int __init init_sbc8240_mtd (void)
 		if (sbc8240_mtd[i]) {
 			sbc8240_mtd[i]->module = THIS_MODULE;
 			devicesfound++;
+		} else {
+			if (sbc8240_map[i].map_priv_1) {
+				iounmap((void *) sbc8240_map[i].map_priv_1);
+				sbc8240_map[i].map_priv_1 = 0;
+			}
 		}
 	}
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/maps/walnut.c linux-2.6.18/drivers/mtd/maps/walnut.c
--- linux-2.6.18-orig/drivers/mtd/maps/walnut.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/maps/walnut.c	2006-09-21 16:52:39.000000000 +0530
@@ -68,6 +68,7 @@ int __init init_walnut(void)
 
 	if (WALNUT_FLASH_ONBD_N(fpga_brds1)) {
 		printk("The on-board flash is disabled (U79 sw 5)!");
+		iounmap(fpga_status_adr);
 		return -EIO;
 	}
 	if (WALNUT_FLASH_SRAM_SEL(fpga_brds1))
@@ -81,6 +82,7 @@ int __init init_walnut(void)
 
 	if (!walnut_map.virt) {
 		printk("Failed to ioremap flash.\n");
+		iounmap(fpga_status_adr);
 		return -EIO;
 	}
 
@@ -93,9 +95,11 @@ int __init init_walnut(void)
 					ARRAY_SIZE(walnut_partitions));
 	} else {
 		printk("map probe failed for flash\n");
+		iounmap(fpga_status_adr);
 		return -ENXIO;
 	}
 
+	iounmap(fpga_status_adr);
 	return 0;
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/nand/edb7312.c linux-2.6.18/drivers/mtd/nand/edb7312.c
--- linux-2.6.18-orig/drivers/mtd/nand/edb7312.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/nand/edb7312.c	2006-09-21 17:35:56.000000000 +0530
@@ -198,6 +198,9 @@ static void __exit ep7312_cleanup(void)
 	/* Release resources, unregister device */
 	nand_release(ap7312_mtd);
 
+	/* Release io resource */
+	iounmap(this->IO_ADDR_R);
+
 	/* Free the MTD device structure */
 	kfree(ep7312_mtd);
 }
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/mtd/nand/ppchameleonevb.c linux-2.6.18/drivers/mtd/nand/ppchameleonevb.c
--- linux-2.6.18-orig/drivers/mtd/nand/ppchameleonevb.c	2006-09-21 10:15:35.000000000 +0530
+++ linux-2.6.18/drivers/mtd/nand/ppchameleonevb.c	2006-09-21 16:52:39.000000000 +0530
@@ -276,6 +276,7 @@ static int __init ppchameleonevb_init(vo
 	/* Scan to find existence of the device (it could not be mounted) */
 	if (nand_scan(ppchameleon_mtd, 1)) {
 		iounmap((void *)ppchameleon_fio_base);
+		ppchameleon_fio_base = NULL;
 		kfree(ppchameleon_mtd);
 		goto nand_evb_init;
 	}
@@ -314,6 +315,8 @@ static int __init ppchameleonevb_init(vo
 	ppchameleonevb_mtd = kmalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
 	if (!ppchameleonevb_mtd) {
 		printk("Unable to allocate PPChameleonEVB NAND MTD device structure.\n");
+		if (ppchameleon_fio_base)
+			iounmap(ppchameleon_fio_base);
 		return -ENOMEM;
 	}
 
@@ -322,6 +325,8 @@ static int __init ppchameleonevb_init(vo
 	if (!ppchameleonevb_fio_base) {
 		printk("ioremap PPChameleonEVB NAND flash failed\n");
 		kfree(ppchameleonevb_mtd);
+		if (ppchameleon_fio_base)
+			iounmap(ppchameleon_fio_base);
 		return -EIO;
 	}
 
@@ -378,6 +383,8 @@ static int __init ppchameleonevb_init(vo
 	if (nand_scan(ppchameleonevb_mtd, 1)) {
 		iounmap((void *)ppchameleonevb_fio_base);
 		kfree(ppchameleonevb_mtd);
+		if (ppchameleon_fio_base)
+			iounmap(ppchameleon_fio_base);
 		return -ENXIO;
 	}
 #ifdef CONFIG_MTD_PARTITIONS


