Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTJGXRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTJGXRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:17:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58100 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262432AbTJGXRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:17:33 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] remove parent field from ide_pci_host_proc_t
Date: Wed, 8 Oct 2003 01:21:16 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310080121.16410.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] remove parent field from ide_pci_host_proc_t

It is always set to proc_ide_root, so kill it.

 drivers/ide/ide-proc.c         |   12 +++++-------
 drivers/ide/pci/aec62xx.h      |    1 -
 drivers/ide/pci/alim15x3.h     |    1 -
 drivers/ide/pci/amd74xx.h      |    1 -
 drivers/ide/pci/cmd64x.h       |    1 -
 drivers/ide/pci/cs5520.h       |    1 -
 drivers/ide/pci/cs5530.h       |    1 -
 drivers/ide/pci/hpt34x.h       |    1 -
 drivers/ide/pci/hpt366.h       |    1 -
 drivers/ide/pci/pdc202xx_new.h |    1 -
 drivers/ide/pci/pdc202xx_old.h |    1 -
 drivers/ide/pci/piix.h         |    1 -
 drivers/ide/pci/sc1200.h       |    1 -
 drivers/ide/pci/serverworks.h  |    1 -
 drivers/ide/pci/siimage.h      |    1 -
 drivers/ide/pci/sis5513.h      |    1 -
 drivers/ide/pci/slc90e66.h     |    1 -
 drivers/ide/pci/via82cxxx.h    |    1 -
 include/linux/ide.h            |    1 -
 19 files changed, 5 insertions(+), 25 deletions(-)

diff -puN drivers/ide/ide-proc.c~ide-pci-host-proc-parent drivers/ide/ide-proc.c
--- linux-2.6.0-test6-bk2/drivers/ide/ide-proc.c~ide-pci-host-proc-parent	2003-10-07 21:45:14.356439280 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/ide-proc.c	2003-10-07 22:10:27.647384088 +0200
@@ -858,12 +858,10 @@ void proc_ide_create(void)
 		entry->proc_fops = &ide_drivers_operations;
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	while (p != NULL)
-	{
-		if (p->name != NULL && p->set == 1 && p->get_info != NULL) 
-		{
-			p->parent = proc_ide_root;
-			create_proc_info_entry(p->name, 0, p->parent, p->get_info);
+	while (p) {
+		if (p->name && p->get_info && p->set == 1) {
+			create_proc_info_entry(p->name, 0, proc_ide_root,
+					       p->get_info);
 			p->set = 2;
 		}
 		p = p->next;
@@ -880,7 +878,7 @@ void proc_ide_destroy(void)
 
 	for (p = ide_pci_host_proc_list; p; p = p->next) {
 		if (p->set == 2)
-			remove_proc_entry(p->name, p->parent);
+			remove_proc_entry(p->name, proc_ide_root);
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 	remove_proc_entry("ide/drivers", proc_ide_root);
diff -puN drivers/ide/pci/aec62xx.h~ide-pci-host-proc-parent drivers/ide/pci/aec62xx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/aec62xx.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.360438672 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/aec62xx.h	2003-10-08 00:33:43.210659848 +0200
@@ -83,7 +83,6 @@ static ide_pci_host_proc_t aec62xx_procs
 		.name		= "aec62xx",
 		.set		= 1,
 		.get_info	= aec62xx_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_AEC62XX_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/alim15x3.h~ide-pci-host-proc-parent drivers/ide/pci/alim15x3.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/alim15x3.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.362438368 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/alim15x3.h	2003-10-08 00:33:43.211659696 +0200
@@ -20,7 +20,6 @@ static ide_pci_host_proc_t ali_procs[] _
 		.name		= "ali",
 		.set		= 1,
 		.get_info	= ali_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_ALI_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/amd74xx.h~ide-pci-host-proc-parent drivers/ide/pci/amd74xx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/amd74xx.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.365437912 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/amd74xx.h	2003-10-08 00:33:43.211659696 +0200
@@ -20,7 +20,6 @@ static ide_pci_host_proc_t amd74xx_procs
 		.name		= "amd74xx",
 		.set		= 1,
 		.get_info	= amd74xx_get_info,
-		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_AMD_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/cmd64x.h~ide-pci-host-proc-parent drivers/ide/pci/cmd64x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cmd64x.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.369437304 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cmd64x.h	2003-10-08 00:33:43.213659392 +0200
@@ -74,7 +74,6 @@ static ide_pci_host_proc_t cmd64x_procs[
 		.name		= "cmd64x",
 		.set		= 1,
 		.get_info	= cmd64x_get_info,
-		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/cs5520.h~ide-pci-host-proc-parent drivers/ide/pci/cs5520.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cs5520.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.371437000 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cs5520.h	2003-10-08 00:33:43.214659240 +0200
@@ -20,7 +20,6 @@ static ide_pci_host_proc_t cs5520_procs[
 		.name		= "cs5520",
 		.set		= 1,
 		.get_info	= cs5520_get_info,
-		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_CS5520_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/cs5530.h~ide-pci-host-proc-parent drivers/ide/pci/cs5530.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cs5530.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.374436544 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cs5530.h	2003-10-08 00:33:43.214659240 +0200
@@ -20,7 +20,6 @@ static ide_pci_host_proc_t cs5530_procs[
 		.name		= "cs5530",
 		.set		= 1,
 		.get_info	= cs5530_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/hpt34x.h~ide-pci-host-proc-parent drivers/ide/pci/hpt34x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt34x.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.381435480 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt34x.h	2003-10-08 00:33:43.217658784 +0200
@@ -26,7 +26,6 @@ static ide_pci_host_proc_t hpt34x_procs[
 		.name		= "hpt34x",
 		.set		= 1,
 		.get_info	= hpt34x_get_info,
-		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/hpt366.h~ide-pci-host-proc-parent drivers/ide/pci/hpt366.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt366.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.384435024 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt366.h	2003-10-08 00:33:43.218658632 +0200
@@ -429,7 +429,6 @@ static ide_pci_host_proc_t hpt366_procs[
 		.name		= "hpt366",
 		.set		= 1,
 		.get_info	= hpt366_get_info,
-		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/pdc202xx_new.h~ide-pci-host-proc-parent drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_new.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.387434568 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_new.h	2003-10-08 00:33:43.220658328 +0200
@@ -177,7 +177,6 @@ static ide_pci_host_proc_t pdcnew_procs[
 		.name		= "pdcnew",
 		.set		= 1,
 		.get_info	= pdcnew_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/pdc202xx_old.h~ide-pci-host-proc-parent drivers/ide/pci/pdc202xx_old.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_old.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.390434112 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_old.h	2003-10-08 00:33:43.221658176 +0200
@@ -212,7 +212,6 @@ static ide_pci_host_proc_t pdc202xx_proc
 		.name		= "pdc202xx",
 		.set		= 1,
 		.get_info	= pdc202xx_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/piix.h~ide-pci-host-proc-parent drivers/ide/pci/piix.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/piix.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.392433808 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/piix.h	2003-10-08 00:33:43.222658024 +0200
@@ -22,7 +22,6 @@ static ide_pci_host_proc_t piix_procs[] 
 		.name		= "piix",
 		.set		= 1,
 		.get_info	= piix_get_info,
-		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/sc1200.h~ide-pci-host-proc-parent drivers/ide/pci/sc1200.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sc1200.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.395433352 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sc1200.h	2003-10-08 00:33:43.223657872 +0200
@@ -20,7 +20,6 @@ static ide_pci_host_proc_t sc1200_procs[
 		.name		= "sc1200",
 		.set		= 1,
 		.get_info	= sc1200_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/serverworks.h~ide-pci-host-proc-parent drivers/ide/pci/serverworks.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/serverworks.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.398432896 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/serverworks.h	2003-10-08 00:33:43.223657872 +0200
@@ -36,7 +36,6 @@ static ide_pci_host_proc_t svwks_procs[]
 		.name		= "svwks",
 		.set		= 1,
 		.get_info	= svwks_get_info,
-		.parent		= NULL,
 	},
 };
 #endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/siimage.h~ide-pci-host-proc-parent drivers/ide/pci/siimage.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/siimage.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.401432440 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/siimage.h	2003-10-08 00:33:43.224657720 +0200
@@ -36,7 +36,6 @@ static ide_pci_host_proc_t siimage_procs
 		.name		= "siimage",
 		.set		= 1,
 		.get_info	= siimage_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_SIIMAGE_TIMINGS && CONFIG_PROC_FS */	
diff -puN drivers/ide/pci/sis5513.h~ide-pci-host-proc-parent drivers/ide/pci/sis5513.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sis5513.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.405431832 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sis5513.h	2003-10-08 00:33:43.224657720 +0200
@@ -20,7 +20,6 @@ static ide_pci_host_proc_t sis_procs[] _
 		.name		= "sis",
 		.set		= 1,
 		.get_info	= sis_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/slc90e66.h~ide-pci-host-proc-parent drivers/ide/pci/slc90e66.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/slc90e66.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.408431376 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/slc90e66.h	2003-10-08 00:33:43.225657568 +0200
@@ -22,7 +22,6 @@ static ide_pci_host_proc_t slc90e66_proc
 		.name		= "slc90e66",
 		.set		= 1,
 		.get_info	= slc90e66_get_info,
-		.parent		= NULL,
 	},
 };
 #endif	/* defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS) */
diff -puN drivers/ide/pci/via82cxxx.h~ide-pci-host-proc-parent drivers/ide/pci/via82cxxx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/via82cxxx.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.411430920 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/via82cxxx.h	2003-10-08 00:33:43.226657416 +0200
@@ -20,7 +20,6 @@ static ide_pci_host_proc_t via_procs[] _
 		.name		= "via",
 		.set		= 1,
 		.get_info	= via_get_info,
-		.parent		= NULL,
 	},
 };
 #endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */
diff -puN include/linux/ide.h~ide-pci-host-proc-parent include/linux/ide.h
--- linux-2.6.0-test6-bk2/include/linux/ide.h~ide-pci-host-proc-parent	2003-10-07 21:45:14.414430464 +0200
+++ linux-2.6.0-test6-bk2-root/include/linux/ide.h	2003-10-08 00:33:42.433777952 +0200
@@ -1642,7 +1642,6 @@ typedef struct ide_pci_host_proc_s {
 	char				*name;
 	u8				set;
 	get_info_t			*get_info;
-	struct proc_dir_entry		*parent;
 	struct ide_pci_host_proc_s	*next;
 } ide_pci_host_proc_t;
 

_

