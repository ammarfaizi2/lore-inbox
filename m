Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267472AbUGWBcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267472AbUGWBcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 21:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbUGWBcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 21:32:54 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.75]:40167 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267467AbUGWBby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 21:31:54 -0400
Date: Thu, 22 Jul 2004 21:31:52 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: [PATCH] prelim ACPI support for aic7xxx
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       random1@o-o.yi.org, pavel@ucw.cz
Message-id: <41006A88.9040700@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_XSFtrgNAB/XXnYCbukZWKg)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_XSFtrgNAB/XXnYCbukZWKg)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


Hi.

This patch (against arjanv's latest kernel, but should apply to 
2.6.8-rc) is still a little messy and NOT ready to go into the mainline 
kernel... Luben hasn't seen it yet (Hi Luben!), so the usual disclaimers 
apply. But it's time to get some more eyes on it. The good news is it 
works, the bad news is there is no support for error recovery during 
those few seconds when the bus is setttling and hard disk is powering up 
after a resume. (Need suggestions on how best to attack that part, I 
really don't know anything about SCSI...) It works, after a few 
residuals if your filesystems are mounted read-only, however. If you are 
mounted read-write then you will get aborted commands, ext3 will 
complain, and remount your fs read-only until you reboot. To avoid this, 
remount read-only, suspend/resume, then remount read-write manually 
after everything starts working.

One other thing that needs outside eyes to look at is the additional 
call to ahc_pci_config(), from ahc_pci_resume(). It might do some 
redundant initializations, I'm not really sure what is needed and did 
not want to disturb the init order for the normal boot sequence, so I 
just if'd out the stuff that seemed irrelevant.

Nathan

--Boundary_(ID_XSFtrgNAB/XXnYCbukZWKg)
Content-type: text/plain; name=aic7xxx_acpi.patch6
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=aic7xxx_acpi.patch6

diff -ur linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic79xx_osm.c linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic79xx_osm.c
--- linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-06-16 01:19:36.000000000 -0400
+++ linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic79xx_osm.c	2004-07-21 18:30:06.000000000 -0400
@@ -2591,7 +2591,7 @@
 	sprintf(current->comm, "ahd_dv_%d", ahd->unit);
 #else
 	daemonize("ahd_dv_%d", ahd->unit);
-	current->flags |= PF_FREEZE;
+	current->flags |= PF_NOFREEZE;
 #endif
 	unlock_kernel();
 
diff -ur linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_core.c linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_core.c
--- linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_core.c	2004-06-16 01:19:22.000000000 -0400
+++ linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_core.c	2004-07-22 20:45:10.000000000 -0400
@@ -605,6 +605,7 @@
 		printf("SXFRCTL0 == 0x%x\n", ahc_inb(ahc, SXFRCTL0));
 		printf("SEQCTL == 0x%x\n", ahc_inb(ahc, SEQCTL));
 		ahc_dump_card_state(ahc);
+		panic("halting to avoid infinite interrupt loop");
 		ahc->msgout_buf[0] = MSG_BUS_DEV_RESET;
 		ahc->msgout_len = 1;
 		ahc->msgout_index = 0;
@@ -4046,6 +4047,7 @@
 
 	ahc = (struct ahc_softc *)arg;
 
+	ahc_intr_enable(ahc, FALSE);
 	/* This will reset most registers to 0, but not all */
 	ahc_reset(ahc, /*reinit*/FALSE);
 	ahc_outb(ahc, SCSISEQ, 0);
@@ -5163,6 +5165,7 @@
 {
 
 	ahc_reset(ahc, /*reinit*/TRUE);
+	//ahc->bus_chip_init(ahc);
 	ahc_intr_enable(ahc, TRUE); 
 	ahc_restart(ahc);
 	return (0);
diff -ur linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx.h linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx.h
--- linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx.h	2004-06-16 01:19:29.000000000 -0400
+++ linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx.h	2004-07-21 22:42:46.000000000 -0400
@@ -1109,6 +1109,8 @@
 
 	uint16_t	 	  user_discenable;/* Disconnection allowed  */
 	uint16_t		  user_tagenable;/* Tagged Queuing allowed */
+
+	u32                      PciState[64]; /* save PCI state to this area */
 };
 
 TAILQ_HEAD(ahc_softc_tailq, ahc_softc);
@@ -1169,7 +1171,7 @@
 /***************************** PCI Front End *********************************/
 struct ahc_pci_identity	*ahc_find_pci_device(ahc_dev_softc_t);
 int			 ahc_pci_config(struct ahc_softc *,
-					struct ahc_pci_identity *);
+					struct ahc_pci_identity *, int resume);
 int			 ahc_pci_test_register_access(struct ahc_softc *);
 
 /*************************** EISA/VL Front End ********************************/
diff -ur linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-07-15 14:23:17.000000000 -0400
+++ linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-07-22 19:51:25.000000000 -0400
@@ -2295,7 +2295,7 @@
 	sprintf(current->comm, "ahc_dv_%d", ahc->unit);
 #else
 	daemonize("ahc_dv_%d", ahc->unit);
-	current->flags |= PF_FREEZE;
+	current->flags |= PF_NOFREEZE;
 #endif
 	unlock_kernel();
 
diff -ur linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
--- linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-07-15 14:23:17.000000000 -0400
+++ linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c	2004-07-21 22:51:01.000000000 -0400
@@ -54,6 +54,10 @@
 static int	ahc_linux_pci_reserve_mem_region(struct ahc_softc *ahc,
 						 u_long *bus_addr,
 						 uint8_t **maddr);
+#ifdef CONFIG_PM
+static int	ahc_linux_pci_suspend(struct pci_dev *dev, u32 state);
+static int	ahc_linux_pci_resume(struct pci_dev *dev);
+#endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 static void	ahc_linux_pci_dev_remove(struct pci_dev *pdev);
 
@@ -76,6 +80,10 @@
 	.name		= "aic7xxx",
 	.probe		= ahc_linux_pci_dev_probe,
 	.remove		= ahc_linux_pci_dev_remove,
+#ifdef CONFIG_PM
+	.suspend	= ahc_linux_pci_suspend,
+	.resume		= ahc_linux_pci_resume,
+#endif
 	.id_table	= ahc_linux_pci_id_table
 };
 
@@ -174,7 +182,7 @@
 	}
 #endif
 	ahc->dev_softc = pci;
-	error = ahc_pci_config(ahc, entry);
+	error = ahc_pci_config(ahc, entry, /*resume*/FALSE);
 	if (error != 0) {
 		ahc_free(ahc);
 		return (-error);
@@ -225,6 +233,72 @@
 #endif
 }
 
+#ifdef CONFIG_PM
+int ahc_linux_pci_suspend(struct pci_dev *dev, u32 state)
+{
+	int rval;
+	u32 device_state;
+	struct ahc_softc *ahc =
+		ahc_find_softc((struct ahc_softc *)pci_get_drvdata(dev));
+
+        switch(state)
+        {
+		case PM_SUSPEND_ON:
+			device_state = 0;
+			break;
+		case PM_SUSPEND_STANDBY:
+		case PM_SUSPEND_MEM:
+		case PM_SUSPEND_DISK:
+		case PM_SUSPEND_MAX:
+                default:
+			device_state = 3;
+                        break;
+        }
+
+        printk(KERN_INFO
+        "aic7xxx: pci-suspend: pdev=0x%p, slot=%s, Entering operating state [D%d]\n",
+                dev, pci_name(dev), device_state);
+
+	rval = ahc->bus_suspend(ahc);
+	if (rval != 0)
+		return rval;
+
+	ahc_dump_card_state(ahc);
+
+	pci_save_state(dev, ahc->PciState);
+	pci_disable_device(dev);
+	pci_set_power_state(dev, device_state);
+	return 0;
+	/*return -EAGAIN;*/
+}
+
+int ahc_linux_pci_resume(struct pci_dev *dev)
+{
+	int rval;
+	int device_state = dev->current_state;
+	struct ahc_softc *ahc =
+		ahc_find_softc((struct ahc_softc *)pci_get_drvdata(dev));
+
+        printk(KERN_INFO
+        "aic7xxx: pci-resume: pdev=0x%p, slot=%s, Previous operating state [D%d]\n",
+                dev, pci_name(dev), device_state);
+
+        pci_set_power_state(dev, AHC_POWER_STATE_D0);
+        pci_restore_state(dev, ahc->PciState);
+        pci_enable_device(dev);
+        pci_set_master(dev);
+
+	rval = ahc->bus_resume(ahc);
+#ifdef AHC_DEBUG
+	if (ahc_debug & AHC_SHOW_MISC) {
+		ahc_dump_card_state(ahc);
+		printk(KERN_DEBUG "look for SCSISEQ=SCSIRSTO, SSTAT1\n");
+	}
+#endif
+	return rval;
+}
+#endif /* CONFIG_PM */
+
 void
 ahc_linux_pci_exit(void)
 {
diff -ur linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_pci.c linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_pci.c
--- linux-2.6.7-1.492.backup/drivers/scsi/aic7xxx/aic7xxx_pci.c	2004-06-16 01:18:57.000000000 -0400
+++ linux-2.6.7-1.492/drivers/scsi/aic7xxx/aic7xxx_pci.c	2004-07-22 20:45:33.000000000 -0400
@@ -779,7 +779,7 @@
 }
 
 int
-ahc_pci_config(struct ahc_softc *ahc, struct ahc_pci_identity *entry)
+ahc_pci_config(struct ahc_softc *ahc, struct ahc_pci_identity *entry, int resume)
 {
 	u_long	 l;
 	u_int	 command;
@@ -792,60 +792,62 @@
 	uint8_t	 sblkctl;
 
 	our_id = 0;
-	error = entry->setup(ahc);
-	if (error != 0)
-		return (error);
-	ahc->chip |= AHC_PCI;
-	ahc->description = entry->name;
-
-	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
-
-	error = ahc_pci_map_registers(ahc);
-	if (error != 0)
-		return (error);
-
-	/*
-	 * Before we continue probing the card, ensure that
-	 * its interrupts are *disabled*.  We don't want
-	 * a misstep to hang the machine in an interrupt
-	 * storm.
-	 */
-	ahc_intr_enable(ahc, FALSE);
-
-	devconfig = ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
-
-	/*
-	 * If we need to support high memory, enable dual
-	 * address cycles.  This bit must be set to enable
-	 * high address bit generation even if we are on a
-	 * 64bit bus (PCI64BIT set in devconfig).
-	 */
-	if ((ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
+	if (!resume) {
+		error = entry->setup(ahc);
+		if (error != 0)
+			return (error);
+		
+		ahc->chip |= AHC_PCI;
+		ahc->description = entry->name;
+		
+		ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
+		
+		error = ahc_pci_map_registers(ahc);
+		if (error != 0)
+			return (error);
+		
+		/*
+		 * Before we continue probing the card, ensure that
+		 * its interrupts are *disabled*.  We don't want
+		 * a misstep to hang the machine in an interrupt
+		 * storm.
+		 */
+		ahc_intr_enable(ahc, FALSE);
 
-		if (bootverbose)
-			printf("%s: Enabling 39Bit Addressing\n",
-			       ahc_name(ahc));
-		devconfig |= DACEN;
-	}
+		devconfig = ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
+		
+		/*
+		 * If we need to support high memory, enable dual
+		 * address cycles.  This bit must be set to enable
+		 * high address bit generation even if we are on a
+		 * 64bit bus (PCI64BIT set in devconfig).
+		 */
+		if ((ahc->flags & AHC_39BIT_ADDRESSING) != 0) {
+			
+			if (bootverbose)
+				printf("%s: Enabling 39Bit Addressing\n",
+				       ahc_name(ahc));
+			devconfig |= DACEN;
+		}
 	
-	/* Ensure that pci error generation, a test feature, is disabled. */
-	devconfig |= PCIERRGENDIS;
-
-	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG, devconfig, /*bytes*/4);
-
-	/* Ensure busmastering is enabled */
-	command = ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/2);
-	command |= PCIM_CMD_BUSMASTEREN;
-
-	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, command, /*bytes*/2);
-
-	/* On all PCI adapters, we allow SCB paging */
-	ahc->flags |= AHC_PAGESCBS;
-
-	error = ahc_softc_init(ahc);
-	if (error != 0)
-		return (error);
-
+		/* Ensure that pci error generation, a test feature, is disabled. */
+		devconfig |= PCIERRGENDIS;
+		
+		ahc_pci_write_config(ahc->dev_softc, DEVCONFIG, devconfig, /*bytes*/4);
+		
+		/* Ensure busmastering is enabled */
+		command = ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/2);
+		command |= PCIM_CMD_BUSMASTEREN;
+		
+		ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, command, /*bytes*/2);
+		
+		/* On all PCI adapters, we allow SCB paging */
+		ahc->flags |= AHC_PAGESCBS;
+		
+		error = ahc_softc_init(ahc);
+		if (error != 0)
+			return (error);
+	}
 	/*
 	 * Disable PCI parity error checking.  Users typically
 	 * do this to work around broken PCI chipsets that get
@@ -857,30 +859,32 @@
 	if ((ahc->flags & AHC_DISABLE_PCI_PERR) != 0)
 		ahc->seqctl |= FAILDIS;
 
-	ahc->bus_intr = ahc_pci_intr;
-	ahc->bus_chip_init = ahc_pci_chip_init;
-	ahc->bus_suspend = ahc_pci_suspend;
-	ahc->bus_resume = ahc_pci_resume;
-
-	/* Remeber how the card was setup in case there is no SEEPROM */
-	if ((ahc_inb(ahc, HCNTRL) & POWRDN) == 0) {
-		ahc_pause(ahc);
-		if ((ahc->features & AHC_ULTRA2) != 0)
-			our_id = ahc_inb(ahc, SCSIID_ULTRA2) & OID;
-		else
-			our_id = ahc_inb(ahc, SCSIID) & OID;
-		sxfrctl1 = ahc_inb(ahc, SXFRCTL1) & STPWEN;
-		scsiseq = ahc_inb(ahc, SCSISEQ);
-	} else {
-		sxfrctl1 = STPWEN;
-		our_id = 7;
-		scsiseq = 0;
+	if (!resume) {
+		ahc->bus_intr = ahc_pci_intr;
+		ahc->bus_chip_init = ahc_pci_chip_init;
+		ahc->bus_suspend = ahc_pci_suspend;
+		ahc->bus_resume = ahc_pci_resume;
+
+		/* Remeber how the card was setup in case there is no SEEPROM */
+		if ((ahc_inb(ahc, HCNTRL) & POWRDN) == 0) {
+			ahc_pause(ahc);
+			if ((ahc->features & AHC_ULTRA2) != 0)
+				our_id = ahc_inb(ahc, SCSIID_ULTRA2) & OID;
+			else
+				our_id = ahc_inb(ahc, SCSIID) & OID;
+			sxfrctl1 = ahc_inb(ahc, SXFRCTL1) & STPWEN;
+			scsiseq = ahc_inb(ahc, SCSISEQ);
+		} else {
+			sxfrctl1 = STPWEN;
+			our_id = 7;
+			scsiseq = 0;
+		}
+		
+		error = ahc_reset(ahc, /*reinit*/FALSE);
+		if (error != 0)
+			return (ENXIO);
 	}
 
-	error = ahc_reset(ahc, /*reinit*/FALSE);
-	if (error != 0)
-		return (ENXIO);
-
 	if ((ahc->features & AHC_DT) != 0) {
 		u_int sfunct;
 
@@ -919,30 +923,32 @@
 
 	ahc_outb(ahc, DSCOMMAND0, dscommand0);
 
-	ahc->pci_cachesize =
-	    ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME,
-				/*bytes*/1) & CACHESIZE;
-	ahc->pci_cachesize *= 4;
-
-	if ((ahc->bugs & AHC_PCI_2_1_RETRY_BUG) != 0
-	 && ahc->pci_cachesize == 4) {
-
-		ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME,
-				     0, /*bytes*/1);
-		ahc->pci_cachesize = 0;
-	}
-
-	/*
-	 * We cannot perform ULTRA speeds without the presense
-	 * of the external precision resistor.
-	 */
-	if ((ahc->features & AHC_ULTRA) != 0) {
-		uint32_t devconfig;
+	if (!resume) {
+		ahc->pci_cachesize =
+			ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME,
+					    /*bytes*/1) & CACHESIZE;
+		ahc->pci_cachesize *= 4;
+
+		if ((ahc->bugs & AHC_PCI_2_1_RETRY_BUG) != 0
+		    && ahc->pci_cachesize == 4) {
+			
+			ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME,
+					     0, /*bytes*/1);
+			ahc->pci_cachesize = 0;
+		}
 
-		devconfig = ahc_pci_read_config(ahc->dev_softc,
-						DEVCONFIG, /*bytes*/4);
-		if ((devconfig & REXTVALID) == 0)
-			ahc->features &= ~AHC_ULTRA;
+		/*
+		 * We cannot perform ULTRA speeds without the presense
+		 * of the external precision resistor.
+		 */
+		if ((ahc->features & AHC_ULTRA) != 0) {
+			uint32_t devconfig;
+			
+			devconfig = ahc_pci_read_config(ahc->dev_softc,
+							DEVCONFIG, /*bytes*/4);
+			if ((devconfig & REXTVALID) == 0)
+				ahc->features &= ~AHC_ULTRA;
+		}
 	}
 
 	/* See if we have a SEEPROM and perform auto-term */
@@ -960,30 +966,32 @@
 		ahc_outb(ahc, DSPCISTATUS, DFTHRSH_100);
 	}
 
-	if (ahc->flags & AHC_USEDEFAULTS) {
-		/*
-		 * PCI Adapter default setup
-		 * Should only be used if the adapter does not have
-		 * a SEEPROM.
-		 */
-		/* See if someone else set us up already */
-		if ((ahc->flags & AHC_NO_BIOS_INIT) == 0
-		 && scsiseq != 0) {
-			printf("%s: Using left over BIOS settings\n",
-				ahc_name(ahc));
-			ahc->flags &= ~AHC_USEDEFAULTS;
-			ahc->flags |= AHC_BIOS_ENABLED;
-		} else {
+	if (!resume) {
+		if (ahc->flags & AHC_USEDEFAULTS) {
 			/*
-			 * Assume only one connector and always turn
-			 * on termination.
+			 * PCI Adapter default setup
+			 * Should only be used if the adapter does not have
+			 * a SEEPROM.
 			 */
- 			our_id = 0x07;
-			sxfrctl1 = STPWEN;
+			/* See if someone else set us up already */
+			if ((ahc->flags & AHC_NO_BIOS_INIT) == 0
+			    && scsiseq != 0) {
+				printf("%s: Using left over BIOS settings\n",
+				       ahc_name(ahc));
+				ahc->flags &= ~AHC_USEDEFAULTS;
+				ahc->flags |= AHC_BIOS_ENABLED;
+			} else {
+				/*
+				 * Assume only one connector and always turn
+				 * on termination.
+				 */
+				our_id = 0x07;
+				sxfrctl1 = STPWEN;
+			}
+			ahc_outb(ahc, SCSICONF, our_id|ENSPCHK|RESET_SCSI);
+			
+			ahc->our_id = our_id;
 		}
-		ahc_outb(ahc, SCSICONF, our_id|ENSPCHK|RESET_SCSI);
-
-		ahc->our_id = our_id;
 	}
 
 	/*
@@ -1000,53 +1008,55 @@
 	if ((sxfrctl1 & STPWEN) != 0)
 		ahc->flags |= AHC_TERM_ENB_A;
 
-	/*
-	 * Save chip register configuration data for chip resets
-	 * that occur during runtime and resume events.
-	 */
-	ahc->bus_softc.pci_softc.devconfig =
-	    ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
-	ahc->bus_softc.pci_softc.command =
-	    ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/1);
-	ahc->bus_softc.pci_softc.csize_lattime =
-	    ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME, /*bytes*/1);
-	ahc->bus_softc.pci_softc.dscommand0 = ahc_inb(ahc, DSCOMMAND0);
-	ahc->bus_softc.pci_softc.dspcistatus = ahc_inb(ahc, DSPCISTATUS);
-	if ((ahc->features & AHC_DT) != 0) {
-		u_int sfunct;
+	if (!resume) {
+		/*
+		 * Save chip register configuration data for chip resets
+		 * that occur during runtime and resume events.
+		 */
+		ahc->bus_softc.pci_softc.devconfig =
+			ahc_pci_read_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4);
+		ahc->bus_softc.pci_softc.command =
+			ahc_pci_read_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/1);
+		ahc->bus_softc.pci_softc.csize_lattime =
+			ahc_pci_read_config(ahc->dev_softc, CSIZE_LATTIME, /*bytes*/1);
+		ahc->bus_softc.pci_softc.dscommand0 = ahc_inb(ahc, DSCOMMAND0);
+		ahc->bus_softc.pci_softc.dspcistatus = ahc_inb(ahc, DSPCISTATUS);
+		if ((ahc->features & AHC_DT) != 0) {
+			u_int sfunct;
+			
+			sfunct = ahc_inb(ahc, SFUNCT) & ~ALT_MODE;
+			ahc_outb(ahc, SFUNCT, sfunct | ALT_MODE);
+			ahc->bus_softc.pci_softc.optionmode = ahc_inb(ahc, OPTIONMODE);
+			ahc->bus_softc.pci_softc.targcrccnt = ahc_inw(ahc, TARGCRCCNT);
+			ahc_outb(ahc, SFUNCT, sfunct);
+			ahc->bus_softc.pci_softc.crccontrol1 =
+				ahc_inb(ahc, CRCCONTROL1);
+		}
+		if ((ahc->features & AHC_MULTI_FUNC) != 0)
+			ahc->bus_softc.pci_softc.scbbaddr = ahc_inb(ahc, SCBBADDR);
+		
+		if ((ahc->features & AHC_ULTRA2) != 0)
+			ahc->bus_softc.pci_softc.dff_thrsh = ahc_inb(ahc, DFF_THRSH);
+		
+		/* Core initialization */
+		error = ahc_init(ahc);
+		if (error != 0)
+			return (error);
 
-		sfunct = ahc_inb(ahc, SFUNCT) & ~ALT_MODE;
-		ahc_outb(ahc, SFUNCT, sfunct | ALT_MODE);
-		ahc->bus_softc.pci_softc.optionmode = ahc_inb(ahc, OPTIONMODE);
-		ahc->bus_softc.pci_softc.targcrccnt = ahc_inw(ahc, TARGCRCCNT);
-		ahc_outb(ahc, SFUNCT, sfunct);
-		ahc->bus_softc.pci_softc.crccontrol1 =
-		    ahc_inb(ahc, CRCCONTROL1);
+		/*
+		 * Allow interrupts now that we are completely setup.
+		 */
+		error = ahc_pci_map_int(ahc);
+		if (error != 0)
+			return (error);
+		
+		ahc_list_lock(&l);
+		/*
+		 * Link this softc in with all other ahc instances.
+		 */
+		ahc_softc_insert(ahc);
+		ahc_list_unlock(&l);
 	}
-	if ((ahc->features & AHC_MULTI_FUNC) != 0)
-		ahc->bus_softc.pci_softc.scbbaddr = ahc_inb(ahc, SCBBADDR);
-
-	if ((ahc->features & AHC_ULTRA2) != 0)
-		ahc->bus_softc.pci_softc.dff_thrsh = ahc_inb(ahc, DFF_THRSH);
-
-	/* Core initialization */
-	error = ahc_init(ahc);
-	if (error != 0)
-		return (error);
-
-	/*
-	 * Allow interrupts now that we are completely setup.
-	 */
-	error = ahc_pci_map_int(ahc);
-	if (error != 0)
-		return (error);
-
-	ahc_list_lock(&l);
-	/*
-	 * Link this softc in with all other ahc instances.
-	 */
-	ahc_softc_insert(ahc);
-	ahc_list_unlock(&l);
 	return (0);
 }
 
@@ -2090,21 +2100,18 @@
 static int
 ahc_pci_resume(struct ahc_softc *ahc)
 {
-
-	ahc_power_state_change(ahc, AHC_POWER_STATE_D0);
-
 	/*
 	 * We assume that the OS has restored our register
 	 * mappings, etc.  Just update the config space registers
 	 * that the OS doesn't know about and rely on our chip
 	 * reset handler to handle the rest.
 	 */
-	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG, /*bytes*/4,
-			     ahc->bus_softc.pci_softc.devconfig);
-	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND, /*bytes*/1,
-			     ahc->bus_softc.pci_softc.command);
-	ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME, /*bytes*/1,
-			     ahc->bus_softc.pci_softc.csize_lattime);
+	ahc_pci_write_config(ahc->dev_softc, DEVCONFIG,
+			     ahc->bus_softc.pci_softc.devconfig, /*bytes*/4);
+	ahc_pci_write_config(ahc->dev_softc, PCIR_COMMAND,
+			     ahc->bus_softc.pci_softc.command, /*bytes*/1);
+	ahc_pci_write_config(ahc->dev_softc, CSIZE_LATTIME,
+			     ahc->bus_softc.pci_softc.csize_lattime, /*bytes*/1);
 	if ((ahc->flags & AHC_HAS_TERM_LOGIC) != 0) {
 		struct	seeprom_descriptor sd;
 		u_int	sxfrctl1;
@@ -2120,6 +2127,7 @@
 				      &sxfrctl1);
 		ahc_release_seeprom(&sd);
 	}
+	ahc_pci_config(ahc, NULL, /*resume*/TRUE);
 	return (ahc_resume(ahc));
 }
 

--Boundary_(ID_XSFtrgNAB/XXnYCbukZWKg)--
