Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbREYUSl>; Fri, 25 May 2001 16:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbREYUSb>; Fri, 25 May 2001 16:18:31 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:8743
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261809AbREYUSW>; Fri, 25 May 2001 16:18:22 -0400
Date: Fri, 25 May 2001 22:18:13 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kmalloc checks for drivers/ide/ide-probe.c (244ac16)
Message-ID: <20010525221813.F851@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch adds a number of checks for kmalloc returns
to drivers/ide/ide-probe.c. It applies against ac16.

One comment: This patch adds 'drive-present = 0' to the
code path for the EXABYTE case. I could not discern if this was a
shortcoming of the original code or not. Please comment.


--- linux-244-ac16-clean/drivers/ide/ide-probe.c	Fri May 25 21:11:08 2001
+++ linux-244-ac16/drivers/ide/ide-probe.c	Fri May 25 21:51:08 2001
@@ -58,6 +58,11 @@
 	struct hd_driveid *id;
 
 	id = drive->id = kmalloc (SECTOR_WORDS*4, GFP_ATOMIC);	/* called with interrupts disabled! */
+        if (!id) {
+                printk(KERN_WARNING "(ide-probe::do_identify) Out of memory.\n");
+                goto err_kmalloc;
+        }
+
 	ide_input_data(drive, id, SECTOR_WORDS);		/* read 512 bytes of id info */
 	ide__sti();	/* local CPU only */
 	ide_fix_driveid(id);
@@ -76,8 +81,7 @@
 	if ((id->model[0] == 'P' && id->model[1] == 'M')
 	 || (id->model[0] == 'S' && id->model[1] == 'K')) {
 		printk("%s: EATA SCSI HBA %.10s\n", drive->name, id->model);
-		drive->present = 0;
-		return;
+                goto err_misc;
 	}
 #endif /* CONFIG_SCSI_EATA_DMA || CONFIG_SCSI_EATA_PIO */
 
@@ -96,7 +100,7 @@
 	ide_fixstring (id->serial_no, sizeof(id->serial_no), bswap);
 
 	if (strstr(id->model, "E X A B Y T E N E S T"))
-		return;
+                goto err_misc;
 
 	id->model[sizeof(id->model)-1] = '\0';	/* we depend on this a lot! */
 	printk("%s: %s, ", drive->name, id->model);
@@ -111,8 +115,7 @@
 #ifdef CONFIG_BLK_DEV_PDC4030
 		if (HWIF(drive)->channel == 1 && HWIF(drive)->chipset == ide_pdc4030) {
 			printk(" -- not supported on 2nd Promise port\n");
-			drive->present = 0;
-			return;
+                        goto err_misc;
 		}
 #endif /* CONFIG_BLK_DEV_PDC4030 */
 		switch (type) {
@@ -174,6 +177,12 @@
 	printk("ATA DISK drive\n");
 	QUIRK_LIST(HWIF(drive),drive);
 	return;
+
+err_misc:
+        kfree(id);
+err_kmalloc:
+        drive->present = 0;
+        return;
 }
 
 /*
@@ -759,11 +768,23 @@
 	}
 	minors    = units * (1<<PARTN_BITS);
 	gd        = kmalloc (sizeof(struct gendisk), GFP_KERNEL);
-	gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
-	gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
-	bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
-	max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
-	max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
+        if (!gd)
+                goto err_kmalloc_gd;
+        gd->sizes = kmalloc (minors * sizeof(int), GFP_KERNEL);
+        if (!gd->sizes)
+                goto err_kmalloc_gd_sizes;
+        gd->part  = kmalloc (minors * sizeof(struct hd_struct), GFP_KERNEL);
+        if (!gd->part)
+                goto err_kmalloc_gd_part;
+        bs        = kmalloc (minors*sizeof(int), GFP_KERNEL);
+        if (!bs)
+                goto err_kmalloc_gs;
+        max_sect  = kmalloc (minors*sizeof(int), GFP_KERNEL);
+        if (!max_sect)
+                goto err_kmalloc_max_sect;
+        max_ra    = kmalloc (minors*sizeof(int), GFP_KERNEL);
+        if (!max_ra)
+                goto err_kmalloc_max_ra;
 
 	memset(gd->part, 0, minors * sizeof(struct hd_struct));
 
@@ -816,6 +837,21 @@
 				devfs_mk_dir (ide_devfs_handle, name, NULL);
 		}
 	}
+        return;
+
+err_kmalloc_max_ra:
+        kfree(max_sect);
+err_kmalloc_max_sect:
+        kfree(bs);
+err_kmalloc_gs:
+        kfree(gd->part);
+err_kmalloc_gd_part:
+        kfree(gd->sizes);
+err_kmalloc_gd_sizes:
+        kfree(gd);
+err_kmalloc_gd:
+        printk(KERN_WARNING "(ide::init_gendisk) Out of memory\n");
+        return;
 }
 
 static int hwif_init (ide_hwif_t *hwif)
-- 
regards,
        Rasmus(rasmus@jaquet.dk)

An Emacs reference mug is what I want. It would hold ten gallons of
coffee. -- Steve VanDevender 
