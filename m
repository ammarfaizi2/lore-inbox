Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSKCKk0>; Sun, 3 Nov 2002 05:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSKCKk0>; Sun, 3 Nov 2002 05:40:26 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:34358 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261715AbSKCKkW>; Sun, 3 Nov 2002 05:40:22 -0500
Date: Sun, 3 Nov 2002 11:46:41 +0100
Message-Id: <200211031046.gA3Akf0V000889@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] NCR53C9x ESP updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x: Port 2.5.45 Sun/SPARC ESP SCSI driver changes to the NCR53C9x ESP
SCSI drivers:
  - Amiga Blizzard 1230IV, 1260, and 2060
  - Amiga BSC Oktagon
  - Amiga Cyberstorm and Cyberstorm II
  - Amiga Phase 5 Fastlane
  - DECstation NCR53C94
  - JAZZ Fas216
  - Mac 53C9x
  - MCA 53C9x
  - Sun-3x ESP

--- linux-2.5.45/drivers/scsi/NCR53C9x.c	Tue Oct 22 19:04:27 2002
+++ linux-m68k-2.5.45/drivers/scsi/NCR53C9x.c	Fri Nov  1 12:49:23 2002
@@ -715,6 +715,9 @@
 	esp->targets_present = 0;
 	esp->resetting_bus = 0;
 	esp->snip = 0;
+
+	init_waitqueue_head(&esp->reset_queue);
+
 	esp->fas_premature_intr_workaround = 0;
 	for(i = 0; i < 32; i++)
 		esp->espcmdlog[i] = 0;
@@ -1395,7 +1398,7 @@
 		esp->msgout_len = 1;
 		esp->msgout_ctr = 0;
 		esp_cmd(esp, eregs, ESP_CMD_SATN);
-		return SCSI_ABORT_PENDING;
+		return SUCCESS;
 	}
 
 	/* If it is still in the issue queue then we can safely
@@ -1420,7 +1423,7 @@
 				this->done(this);
 				if(don)
 					esp->dma_ints_on(esp);
-				return SCSI_ABORT_SUCCESS;
+				return SUCCESS;
 			}
 		}
 	}
@@ -1433,19 +1436,19 @@
 	if(esp->current_SC) {
 		if(don)
 			esp->dma_ints_on(esp);
-		return SCSI_ABORT_BUSY;
+		return FAILED;
 	}
 
 	/* It's disconnected, we have to reconnect to re-establish
 	 * the nexus and tell the device to abort.  However, we really
-	 * cannot 'reconnect' per se, therefore we tell the upper layer
-	 * the safest thing we can.  This is, wait a bit, if nothing
-	 * happens, we are really hung so reset the bus.
+	 * cannot 'reconnect' per se.  Don't try to be fancy, just
+	 * indicate failure, which causes our caller to reset the whole
+	 * bus.
 	 */
 
 	if(don)
 		esp->dma_ints_on(esp);
-	return SCSI_ABORT_SNOOZE;
+	return FAILED;
 }
 
 /* We've sent ESP_CMD_RS to the ESP, the interrupt had just
@@ -1479,6 +1482,7 @@
 
 	/* SCSI bus reset is complete. */
 	esp->resetting_bus = 0;
+	wake_up(&esp->reset_queue);
 
 	/* Ok, now it is safe to get commands going once more. */
 	if(esp->issue_SC)
@@ -1500,12 +1504,14 @@
 /* Reset ESP chip, reset hanging bus, then kill active and
  * disconnected commands for targets without soft reset.
  */
-int esp_reset(Scsi_Cmnd *SCptr, unsigned int how)
+int esp_reset(Scsi_Cmnd *SCptr)
 {
 	struct NCR_ESP *esp = (struct NCR_ESP *) SCptr->host->hostdata;
 
 	(void) esp_do_resetbus(esp, esp->eregs);
-	return SCSI_RESET_PENDING;
+	wait_event(esp->reset_queue, (esp->resetting_bus == 0));
+
+	return SUCCESS;
 }
 
 /* Internal ESP done function. */
--- linux-2.5.45/drivers/scsi/NCR53C9x.h	Sat Oct 12 19:20:31 2002
+++ linux-m68k-2.5.45/drivers/scsi/NCR53C9x.h	Fri Nov  1 12:49:23 2002
@@ -407,6 +407,7 @@
    * cannot be assosciated with any specific command.
    */
   unchar resetting_bus;
+  wait_queue_head_t reset_queue;
 
   unchar do_pio_cmds;		/* Do command transfer with pio */
 
--- linux-2.5.45/drivers/scsi/blz1230.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.45/drivers/scsi/blz1230.h	Fri Nov  1 12:49:23 2002
@@ -53,7 +53,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -64,8 +64,8 @@
 			    release:		blz1230_esp_release, \
 			    command:		esp_command, \
 			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
+			    eh_abort_handler:		esp_abort, \
+			    eh_bus_reset_handler:		esp_reset, \
 			    can_queue:          7, \
 			    this_id:		7, \
 			    sg_tablesize:	SG_ALL, \
--- linux-2.5.45/drivers/scsi/blz2060.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.45/drivers/scsi/blz2060.h	Fri Nov  1 12:49:23 2002
@@ -49,7 +49,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -59,8 +59,8 @@
 			    detect:		blz2060_esp_detect, \
 			    release:		blz2060_esp_release, \
 			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
+			    eh_abort_handler:		esp_abort, \
+			    eh_bus_reset_handler:		esp_reset, \
 			    can_queue:          7, \
 			    this_id:		7, \
 			    sg_tablesize:	SG_ALL, \
--- linux-2.5.45/drivers/scsi/cyberstorm.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.45/drivers/scsi/cyberstorm.h	Fri Nov  1 12:49:23 2002
@@ -51,7 +51,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -62,8 +62,8 @@
 			    detect:		cyber_esp_detect, \
 			    release:		cyber_esp_release, \
 			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
+			    eh_abort_handler:		esp_abort, \
+			    eh_bus_reset_handler:		esp_reset, \
 			    can_queue:          7, \
 			    this_id:		7, \
 			    sg_tablesize:	SG_ALL, \
--- linux-2.5.45/drivers/scsi/cyberstormII.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.45/drivers/scsi/cyberstormII.h	Fri Nov  1 12:49:23 2002
@@ -39,7 +39,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -49,8 +49,8 @@
 			    detect:		cyberII_esp_detect, \
 			    release:		cyberII_esp_release, \
 			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
+			    eh_abort_handler:		esp_abort, \
+			    eh_bus_reset_handler:		esp_reset, \
 			    can_queue:          7, \
 			    this_id:		7, \
 			    sg_tablesize:	SG_ALL, \
--- linux-2.5.45/drivers/scsi/dec_esp.h	Mon Jul 10 07:51:45 2000
+++ linux-m68k-2.5.45/drivers/scsi/dec_esp.h	Fri Nov  1 12:49:24 2002
@@ -22,7 +22,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -34,8 +34,8 @@
 		info:           esp_info,			\
 		command:        esp_command,			\
 		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
+		eh_abort_handler:          esp_abort,			\
+		eh_bus_reset_handler:          esp_reset,			\
 		can_queue:      7,				\
 		this_id:        7,				\
 		sg_tablesize:   SG_ALL,				\
--- linux-2.5.45/drivers/scsi/fastlane.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.45/drivers/scsi/fastlane.h	Fri Nov  1 12:49:24 2002
@@ -44,7 +44,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -54,8 +54,8 @@
 			    detect:		fastlane_esp_detect, \
 			    release:		fastlane_esp_release, \
 			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
+			    eh_abort_handler:		esp_abort, \
+			    eh_bus_reset_handler:		esp_reset, \
 			    can_queue:          7, \
 			    this_id:		7, \
 			    sg_tablesize:	SG_ALL, \
--- linux-2.5.45/drivers/scsi/jazz_esp.h	Mon Jul 10 07:51:45 2000
+++ linux-m68k-2.5.45/drivers/scsi/jazz_esp.h	Fri Nov  1 12:49:24 2002
@@ -16,7 +16,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -28,8 +28,8 @@
 		info:           esp_info,			\
 		command:        esp_command,			\
 		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
+		eh_abort_handler:          esp_abort,			\
+		eh_bus_reset_handler:          esp_reset,			\
 		can_queue:      7,				\
 		this_id:        7,				\
 		sg_tablesize:   SG_ALL,				\
--- linux-2.5.45/drivers/scsi/mac_esp.h	Sun Dec  9 15:15:30 2001
+++ linux-m68k-2.5.45/drivers/scsi/mac_esp.h	Fri Nov  1 12:49:24 2002
@@ -18,7 +18,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 
 
 #define SCSI_MAC_ESP      { proc_name:		"esp", \
@@ -28,8 +28,8 @@
 			    info:		esp_info, \
 			    /* command:		esp_command, */ \
 			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
+			    eh_abort_handler:		esp_abort, \
+			    eh_bus_reset_handler:		esp_reset, \
 			    can_queue:          7, \
 			    this_id:		7, \
 			    sg_tablesize:	SG_ALL, \
--- linux-2.5.45/drivers/scsi/mca_53c9x.h	Mon Jul 10 07:51:45 2000
+++ linux-m68k-2.5.45/drivers/scsi/mca_53c9x.h	Fri Nov  1 12:49:24 2002
@@ -26,7 +26,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -36,8 +36,8 @@
 			    detect:		mca_esp_detect, \
 			    release:		mca_esp_release, \
 			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
+			    eh_abort_handler:		esp_abort, \
+			    eh_bus_reset_handler:		esp_reset, \
 			    can_queue:          7, \
 			    sg_tablesize:	SG_ALL, \
 			    cmd_per_lun:	1, \
--- linux-2.5.45/drivers/scsi/oktagon_esp.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.45/drivers/scsi/oktagon_esp.h	Fri Nov  1 12:49:24 2002
@@ -35,7 +35,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			int hostno, int inout);
 
@@ -46,8 +46,8 @@
    detect:              oktagon_esp_detect,      \
    release:             oktagon_esp_release,     \
    queuecommand:        esp_queue,               \
-   abort:               esp_abort,               \
-   reset:               esp_reset,               \
+   eh_abort_handler:               esp_abort,               \
+   eh_bus_reset_handler:               esp_reset,               \
    can_queue:           7,                       \
    this_id:             7,                       \
    sg_tablesize:        SG_ALL,                  \
--- linux-2.5.45/drivers/scsi/sun3x_esp.h	Fri Nov 12 01:57:30 1999
+++ linux-m68k-2.5.45/drivers/scsi/sun3x_esp.h	Fri Nov  1 12:49:24 2002
@@ -14,7 +14,7 @@
 extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 extern int esp_command(Scsi_Cmnd *);
 extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
+extern int esp_reset(Scsi_Cmnd *);
 extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
 			 int hostno, int inout);
 
@@ -28,8 +28,8 @@
 		info:           esp_info,			\
 		command:        esp_command,			\
 		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
+		eh_abort_handler:          esp_abort,			\
+		eh_bus_reset_handler:          esp_reset,			\
 		can_queue:      7,				\
 		this_id:        7,				\
 		sg_tablesize:   SG_ALL,				\

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

