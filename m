Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUBTNYQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUBTMwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:52:19 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:12320 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261187AbUBTMsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:48:35 -0500
Date: Fri, 20 Feb 2004 13:48:17 +0100
Message-Id: <200402201248.i1KCmHeA004281@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ralf Baechle <ralf@linux-mips.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 407] NCR53C9x slave_{alloc,destroy}()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x: Add missing slave_{alloc,destroy}() (from Kars de Jong and Matthias
Urlichs). This affects the following drivers:
  - Amiga Blizzard 1230, Blizzard 2060, CyberStorm, CyberStorm Mk II, Fastlane,
    and Oktagon SCSI
  - DECstation NCR53C94 SCSI
  - Jazz ESP 100/100a/200 SCSI
  - Mac 53C9x SCSI
  - MCA NCR 53c9x SCSI
  - Sun-3x SCSI (was already fixed on its own)

--- linux-2.6.3/drivers/scsi/NCR53C9x.c	2003-11-24 10:45:05.000000000 +0100
+++ linux-m68k-2.6.3/drivers/scsi/NCR53C9x.c	2004-02-06 10:38:27.000000000 +0100
@@ -3615,6 +3615,27 @@
 }
 #endif
 
+int esp_slave_alloc(Scsi_Device *SDptr)
+{
+	struct esp_device *esp_dev =
+		kmalloc(sizeof(struct esp_device), GFP_ATOMIC);
+
+	if (!esp_dev)
+		return -ENOMEM;
+	memset(esp_dev, 0, sizeof(struct esp_device));
+	SDptr->hostdata = esp_dev;
+	return 0;
+}
+
+void esp_slave_destroy(Scsi_Device *SDptr)
+{
+	struct NCR_ESP *esp = (struct NCR_ESP *) SDptr->host->hostdata;
+
+	esp->targets_present &= ~(1 << SDptr->id);
+	kfree(SDptr->hostdata);
+	SDptr->hostdata = NULL;
+}
+
 #ifdef MODULE
 int init_module(void) { return 0; }
 void cleanup_module(void) {}
--- linux-2.6.3/drivers/scsi/NCR53C9x.h	2004-01-21 22:03:40.000000000 +0100
+++ linux-m68k-2.6.3/drivers/scsi/NCR53C9x.h	2004-02-06 10:38:27.000000000 +0100
@@ -665,4 +665,6 @@
 extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(struct Scsi_Host *shost, char *buffer, char **start, off_t offset, int length,
 			 int inout);
+extern int esp_slave_alloc(Scsi_Device *);
+extern void esp_slave_destroy(Scsi_Device *);
 #endif /* !(NCR53C9X_H) */
--- linux-2.6.3/drivers/scsi/blz1230.c	2003-07-29 18:19:08.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/blz1230.c	2004-02-06 10:38:27.000000000 +0100
@@ -333,6 +333,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "Blizzard1230 SCSI IV",
 	.detect			= blz1230_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= blz1230_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
--- linux-2.6.3/drivers/scsi/blz2060.c	2003-07-29 18:19:09.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/blz2060.c	2004-02-06 10:38:27.000000000 +0100
@@ -287,6 +287,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "Blizzard2060 SCSI",
 	.detect			= blz2060_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= blz2060_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
--- linux-2.6.3/drivers/scsi/cyberstorm.c	2003-07-29 18:19:09.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/cyberstorm.c	2004-02-06 10:38:27.000000000 +0100
@@ -358,6 +358,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "CyberStorm SCSI",
 	.detect			= cyber_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= cyber_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
--- linux-2.6.3/drivers/scsi/cyberstormII.c	2003-07-29 18:19:09.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/cyberstormII.c	2004-02-06 10:38:27.000000000 +0100
@@ -295,6 +295,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "CyberStorm Mk II SCSI",
 	.detect			= cyberII_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= cyberII_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
--- linux-2.6.3/drivers/scsi/dec_esp.c	2003-07-29 18:19:09.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/dec_esp.c	2004-02-06 10:38:27.000000000 +0100
@@ -124,6 +124,8 @@
 	.proc_info		= &esp_proc_info,
 	.name			= "NCR53C94",
 	.detect			= dec_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= dec_esp_release,
 	.info			= esp_info,
 	.queuecommand		= esp_queue,
--- linux-2.6.3/drivers/scsi/fastlane.c	2003-07-29 18:19:09.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/fastlane.c	2004-02-06 10:38:27.000000000 +0100
@@ -404,6 +404,8 @@
 	.proc_info		= esp_proc_info,
 	.name			= "Fastlane SCSI",
 	.detect			= fastlane_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= fastlane_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
--- linux-2.6.3/drivers/scsi/jazz_esp.c	2003-07-29 18:19:10.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/jazz_esp.c	2004-02-06 10:38:27.000000000 +0100
@@ -290,6 +290,8 @@
 	.proc_info		= &esp_proc_info,
 	.name			= "ESP 100/100a/200",
 	.detect			= jazz_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= jazz_esp_release,
 	.info			= esp_info,
 	.queuecommand		= esp_queue,
--- linux-2.6.3/drivers/scsi/mac_esp.c	2004-01-21 22:03:41.000000000 +0100
+++ linux-m68k-2.6.3/drivers/scsi/mac_esp.c	2004-02-06 10:38:27.000000000 +0100
@@ -734,6 +734,8 @@
 	.proc_name		= "esp",
 	.name			= "Mac 53C9x SCSI",
 	.detect			= mac_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= mac_esp_release,
 	.info			= esp_info,
 	.queuecommand		= esp_queue,
--- linux-2.6.3/drivers/scsi/mca_53c9x.c	2003-07-29 18:19:10.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/mca_53c9x.c	2004-02-06 10:38:27.000000000 +0100
@@ -448,6 +448,8 @@
 	.proc_name		= "esp",
 	.name			= "NCR 53c9x SCSI",
 	.detect			= mca_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= mca_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
--- linux-2.6.3/drivers/scsi/oktagon_esp.c	2003-07-29 18:19:10.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/oktagon_esp.c	2004-02-06 10:38:27.000000000 +0100
@@ -595,6 +595,8 @@
 	.proc_info		= &esp_proc_info,
 	.name			= "BSC Oktagon SCSI",
 	.detect			= oktagon_esp_detect,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.release		= oktagon_esp_release,
 	.queuecommand		= esp_queue,
 	.eh_abort_handler	= esp_abort,
--- linux-2.6.3/drivers/scsi/sun3x_esp.c	2003-07-29 18:19:12.000000000 +0200
+++ linux-m68k-2.6.3/drivers/scsi/sun3x_esp.c	2004-02-06 13:43:34.000000000 +0100
@@ -374,29 +374,6 @@
     sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dvma_address);
 }
 
-
-static int esp_slave_alloc(Scsi_Device *SDptr)
-{
-	struct esp_device *esp_dev =
-		kmalloc(sizeof(struct esp_device), GFP_ATOMIC);
-
-	if (!esp_dev)
-		return -ENOMEM;
-	memset(esp_dev, 0, sizeof(struct esp_device));
-	SDptr->hostdata = esp_dev;
-	return 0;
-}
-
-static void esp_slave_destroy(Scsi_Device *SDptr)
-{
-	struct NCR_ESP *esp = (struct NCR_ESP *) SDptr->host->hostdata;
-
-	esp->targets_present &= ~(1 << SDptr->id);
-	kfree(SDptr->hostdata);
-	SDptr->hostdata = NULL;
-}
-
-
 static int sun3x_esp_release(struct Scsi_Host *instance)
 {
 	/* this code does not support being compiled as a module */	 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
