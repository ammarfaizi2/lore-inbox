Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSKJKVc>; Sun, 10 Nov 2002 05:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSKJKVc>; Sun, 10 Nov 2002 05:21:32 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:61629 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264797AbSKJKVO>;
	Sun, 10 Nov 2002 05:21:14 -0500
Date: Sun, 10 Nov 2002 11:27:01 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
In-Reply-To: <20021103143320.A25170@infradead.org>
Message-ID: <Pine.GSO.4.21.0211101124070.20578-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Christoph Hellwig wrote:
> On Sun, Nov 03, 2002 at 03:28:55PM +0100, Geert Uytterhoeven wrote:
> > On Sun, 3 Nov 2002, Christoph Hellwig wrote:
> > > On Sun, Nov 03, 2002 at 11:46:48AM +0100, Geert Uytterhoeven wrote:
> > > > NCR53C9x ESP: C99 designated initializers
> > > 
> > > Please move the host template to the C file instead of the header
> > > if you touch it.  Having them in the header and the methods exported
> > > was needed in 2.2, but that's long ago..
> > 
> > At your service :-)
> > Except for the MIPS JAZZ driver, since SCSI_JAZZ_ESP is not actually used
> > anymore, probably due to bit rot.
> 
> The patch looks fine, thanks.  Now if all scsi host driver maintainers
> would do it this way.. :)

Next iteration (this replaces all 3 previous patches, which Linus didn't apply
anyway):
  + Move common NCR53C9x ESP prototypes from the host adapter-specific header
    files to NCR53C9x.h
  + Move host adapter-specific definitions from the host adapter-specific
    header files to the host adapter-specific source files

Full changeset log:

NCR53C9x ESP updates:
  - Port 2.5.45 Sun/SPARC ESP SCSI driver changes to the NCR53C9x ESP SCSI
    drivers
  - C99 designated initializers
  - Move NCR53C9x ESP host templates from the host adapter-specific header
    files to the source files
  - Move common NCR53C9x ESP prototypes from the host adapter-specific header
    files to NCR53C9x.h
  - Move host adapter-specific definitions from the host adapter-specific
    header files to the host adapter-specific source files

This affects the following SCSI host adapters:
  - Amiga Blizzard 1230IV, 1260, and 2060
  - Amiga BSC Oktagon
  - Amiga Cyberstorm and Cyberstorm II
  - Amiga Phase 5 Fastlane
  - DECstation NCR53C94
  - JAZZ Fas216
  - Mac 53C9x
  - MCA 53C9x
  - Sun-3x ESP

--- linux-2.5.46/drivers/scsi/NCR53C9x.c	Tue Oct 22 19:04:27 2002
+++ linux-m68k-2.5.46/drivers/scsi/NCR53C9x.c	Sun Nov 10 10:02:30 2002
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
--- linux-2.5.46/drivers/scsi/NCR53C9x.h	Sat Oct 12 19:20:31 2002
+++ linux-m68k-2.5.46/drivers/scsi/NCR53C9x.h	Sun Nov 10 10:09:12 2002
@@ -407,6 +407,7 @@
    * cannot be assosciated with any specific command.
    */
   unchar resetting_bus;
+  wait_queue_head_t reset_queue;
 
   unchar do_pio_cmds;		/* Do command transfer with pio */
 
@@ -657,4 +658,11 @@
 extern void esp_release(void);
 extern void esp_initialize(struct NCR_ESP *);
 extern void esp_intr(int, void *, struct pt_regs *);
+extern const char *esp_info(struct Scsi_Host *);
+extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+extern int esp_command(Scsi_Cmnd *);
+extern int esp_abort(Scsi_Cmnd *);
+extern int esp_reset(Scsi_Cmnd *);
+extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
+			 int hostno, int inout);
 #endif /* !(NCR53C9X_H) */
--- linux-2.5.46/drivers/scsi/blz1230.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.46/drivers/scsi/blz1230.c	Sun Nov 10 10:29:59 2002
@@ -29,7 +29,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "blz1230.h"
 
 #include <linux/zorro.h>
 #include <asm/irq.h>
@@ -40,6 +39,42 @@
 
 #define MKIV 1
 
+/* The controller registers can be found in the Z2 config area at these
+ * offsets:
+ */
+#define BLZ1230_ESP_ADDR 0x8000
+#define BLZ1230_DMA_ADDR 0x10000
+#define BLZ1230II_ESP_ADDR 0x10000
+#define BLZ1230II_DMA_ADDR 0x10021
+
+
+/* The Blizzard 1230 DMA interface
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * Only two things can be programmed in the Blizzard DMA:
+ *  1) The data direction is controlled by the status of bit 31 (1 = write)
+ *  2) The source/dest address (word aligned, shifted one right) in bits 30-0
+ *
+ * Program DMA by first latching the highest byte of the address/direction
+ * (i.e. bits 31-24 of the long word constructed as described in steps 1+2
+ * above). Then write each byte of the address/direction (starting with the
+ * top byte, working down) to the DMA address register.
+ *
+ * Figure out interrupt status by reading the ESP status byte.
+ */
+struct blz1230_dma_registers {
+	volatile unsigned char dma_addr; 	/* DMA address      [0x0000] */
+	unsigned char dmapad2[0x7fff];
+	volatile unsigned char dma_latch; 	/* DMA latch        [0x8000] */
+};
+
+struct blz1230II_dma_registers {
+	volatile unsigned char dma_addr; 	/* DMA address      [0x0000] */
+	unsigned char dmapad2[0xf];
+	volatile unsigned char dma_latch; 	/* DMA latch        [0x0010] */
+};
+
+#define BLZ1230_DMA_WRITE 0x80000000
+
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
@@ -279,12 +314,6 @@
 
 #define HOSTS_C
 
-#include "blz1230.h"
-
-static Scsi_Host_Template driver_template = SCSI_BLZ1230;
-
-#include "scsi_module.c"
-
 int blz1230_esp_release(struct Scsi_Host *instance)
 {
 #ifdef MODULE
@@ -296,5 +325,26 @@
 #endif
 	return 1;
 }
+
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-blz1230",
+	.proc_info		= esp_proc_info,
+	.name			= "Blizzard1230 SCSI IV",
+	.detect			= blz1230_esp_detect,
+	.release		= blz1230_esp_release,
+	.command		= esp_command,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+
+#include "scsi_module.c"
 
 MODULE_LICENSE("GPL");
--- linux-2.5.46/drivers/scsi/blz1230.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.46/drivers/scsi/blz1230.h	Thu Jan  1 01:00:00 1970
@@ -1,75 +0,0 @@
-/* blz1230.h: Defines and structures for the Blizzard 1230 SCSI IV driver.
- *
- * Copyright (C) 1996 Jesper Skov (jskov@cygnus.co.uk)
- *
- * This file is based on cyber_esp.h (hence the occasional reference to
- * CyberStorm).
- */
-
-#include "NCR53C9x.h"
-
-#ifndef BLZ1230_H
-#define BLZ1230_H
-
-/* The controller registers can be found in the Z2 config area at these
- * offsets:
- */
-#define BLZ1230_ESP_ADDR 0x8000
-#define BLZ1230_DMA_ADDR 0x10000
-#define BLZ1230II_ESP_ADDR 0x10000
-#define BLZ1230II_DMA_ADDR 0x10021
-
-
-/* The Blizzard 1230 DMA interface
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * Only two things can be programmed in the Blizzard DMA:
- *  1) The data direction is controlled by the status of bit 31 (1 = write)
- *  2) The source/dest address (word aligned, shifted one right) in bits 30-0
- *
- * Program DMA by first latching the highest byte of the address/direction
- * (i.e. bits 31-24 of the long word constructed as described in steps 1+2
- * above). Then write each byte of the address/direction (starting with the
- * top byte, working down) to the DMA address register.
- *
- * Figure out interrupt status by reading the ESP status byte.
- */
-struct blz1230_dma_registers {
-	volatile unsigned char dma_addr; 	/* DMA address      [0x0000] */
-	unsigned char dmapad2[0x7fff];
-	volatile unsigned char dma_latch; 	/* DMA latch        [0x8000] */
-};
-
-struct blz1230II_dma_registers {
-	volatile unsigned char dma_addr; 	/* DMA address      [0x0000] */
-	unsigned char dmapad2[0xf];
-	volatile unsigned char dma_latch; 	/* DMA latch        [0x0010] */
-};
-
-#define BLZ1230_DMA_WRITE 0x80000000
-
-extern int blz1230_esp_detect(struct SHT *);
-extern int blz1230_esp_release(struct Scsi_Host *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-#define SCSI_BLZ1230      { proc_name:		"esp-blz1230", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard1230 SCSI IV", \
-			    detect:		blz1230_esp_detect, \
-			    release:		blz1230_esp_release, \
-			    command:		esp_command, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
-#endif /* BLZ1230_H */
--- linux-2.5.46/drivers/scsi/blz2060.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.46/drivers/scsi/blz2060.c	Sun Nov 10 10:30:15 2002
@@ -29,7 +29,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "blz2060.h"
 
 #include <linux/zorro.h>
 #include <asm/irq.h>
@@ -38,6 +37,38 @@
 
 #include <asm/pgtable.h>
 
+/* The controller registers can be found in the Z2 config area at these
+ * offsets:
+ */
+#define BLZ2060_ESP_ADDR 0x1ff00
+#define BLZ2060_DMA_ADDR 0x1ffe0
+
+
+/* The Blizzard 2060 DMA interface
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * Only two things can be programmed in the Blizzard DMA:
+ *  1) The data direction is controlled by the status of bit 31 (1 = write)
+ *  2) The source/dest address (word aligned, shifted one right) in bits 30-0
+ *
+ * Figure out interrupt status by reading the ESP status byte.
+ */
+struct blz2060_dma_registers {
+	volatile unsigned char dma_led_ctrl;	/* DMA led control   [0x000] */
+	unsigned char dmapad1[0x0f];
+	volatile unsigned char dma_addr0; 	/* DMA address (MSB) [0x010] */
+	unsigned char dmapad2[0x03];
+	volatile unsigned char dma_addr1; 	/* DMA address       [0x014] */
+	unsigned char dmapad3[0x03];
+	volatile unsigned char dma_addr2; 	/* DMA address       [0x018] */
+	unsigned char dmapad4[0x03];
+	volatile unsigned char dma_addr3; 	/* DMA address (LSB) [0x01c] */
+};
+
+#define BLZ2060_DMA_WRITE 0x80000000
+
+/* DMA control bits */
+#define BLZ2060_DMA_LED    0x02		/* HD led control 1 = off */
+
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
@@ -236,12 +267,6 @@
 
 #define HOSTS_C
 
-#include "blz2060.h"
-
-static Scsi_Host_Template driver_template = SCSI_BLZ2060;
-
-#include "scsi_module.c"
-
 int blz2060_esp_release(struct Scsi_Host *instance)
 {
 #ifdef MODULE
@@ -254,5 +279,25 @@
 #endif
 	return 1;
 }
+
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-blz2060",
+	.proc_info		= esp_proc_info,
+	.name			= "Blizzard2060 SCSI",
+	.detect			= blz2060_esp_detect,
+	.release		= blz2060_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+
+#include "scsi_module.c"
 
 MODULE_LICENSE("GPL");
--- linux-2.5.46/drivers/scsi/blz2060.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.46/drivers/scsi/blz2060.h	Thu Jan  1 01:00:00 1970
@@ -1,70 +0,0 @@
-/* blz2060.h: Defines and structures for the Blizzard 2060 SCSI driver.
- *
- * Copyright (C) 1996 Jesper Skov (jskov@cygnus.co.uk)
- *
- * This file is based on cyber_esp.h (hence the occasional reference to
- * CyberStorm).
- */
-
-#include "NCR53C9x.h"
-
-#ifndef BLZ2060_H
-#define BLZ2060_H
-
-/* The controller registers can be found in the Z2 config area at these
- * offsets:
- */
-#define BLZ2060_ESP_ADDR 0x1ff00
-#define BLZ2060_DMA_ADDR 0x1ffe0
-
-
-/* The Blizzard 2060 DMA interface
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- * Only two things can be programmed in the Blizzard DMA:
- *  1) The data direction is controlled by the status of bit 31 (1 = write)
- *  2) The source/dest address (word aligned, shifted one right) in bits 30-0
- *
- * Figure out interrupt status by reading the ESP status byte.
- */
-struct blz2060_dma_registers {
-	volatile unsigned char dma_led_ctrl;	/* DMA led control   [0x000] */
-	unsigned char dmapad1[0x0f];
-	volatile unsigned char dma_addr0; 	/* DMA address (MSB) [0x010] */
-	unsigned char dmapad2[0x03];
-	volatile unsigned char dma_addr1; 	/* DMA address       [0x014] */
-	unsigned char dmapad3[0x03];
-	volatile unsigned char dma_addr2; 	/* DMA address       [0x018] */
-	unsigned char dmapad4[0x03];
-	volatile unsigned char dma_addr3; 	/* DMA address (LSB) [0x01c] */
-};
-
-#define BLZ2060_DMA_WRITE 0x80000000
-
-/* DMA control bits */
-#define BLZ2060_DMA_LED    0x02		/* HD led control 1 = off */
-
-extern int blz2060_esp_detect(struct SHT *);
-extern int blz2060_esp_release(struct Scsi_Host *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-#define SCSI_BLZ2060      { proc_name:		"esp-blz2060", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Blizzard2060 SCSI", \
-			    detect:		blz2060_esp_detect, \
-			    release:		blz2060_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
-#endif /* BLZ2060_H */
--- linux-2.5.46/drivers/scsi/cyberstorm.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.46/drivers/scsi/cyberstorm.c	Sun Nov 10 10:30:45 2002
@@ -32,7 +32,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "cyberstorm.h"
 
 #include <linux/zorro.h>
 #include <asm/irq.h>
@@ -41,6 +40,43 @@
 
 #include <asm/pgtable.h>
 
+/* The controller registers can be found in the Z2 config area at these
+ * offsets:
+ */
+#define CYBER_ESP_ADDR 0xf400
+#define CYBER_DMA_ADDR 0xf800
+
+
+/* The CyberStorm DMA interface */
+struct cyber_dma_registers {
+	volatile unsigned char dma_addr0;	/* DMA address (MSB) [0x000] */
+	unsigned char dmapad1[1];
+	volatile unsigned char dma_addr1;	/* DMA address       [0x002] */
+	unsigned char dmapad2[1];
+	volatile unsigned char dma_addr2;	/* DMA address       [0x004] */
+	unsigned char dmapad3[1];
+	volatile unsigned char dma_addr3;	/* DMA address (LSB) [0x006] */
+	unsigned char dmapad4[0x3fb];
+	volatile unsigned char cond_reg;        /* DMA cond    (ro)  [0x402] */
+#define ctrl_reg  cond_reg			/* DMA control (wo)  [0x402] */
+};
+
+/* DMA control bits */
+#define CYBER_DMA_LED    0x80	/* HD led control 1 = on */
+#define CYBER_DMA_WRITE  0x40	/* DMA direction. 1 = write */
+#define CYBER_DMA_Z3     0x20	/* 16 (Z2) or 32 (CHIP/Z3) bit DMA transfer */
+
+/* DMA status bits */
+#define CYBER_DMA_HNDL_INTR 0x80	/* DMA IRQ pending? */
+
+/* The bits below appears to be Phase5 Debug bits only; they were not
+ * described by Phase5 so using them may seem a bit stupid...
+ */
+#define CYBER_HOST_ID 0x02	/* If set, host ID should be 7, otherwise
+				 * it should be 6.
+				 */
+#define CYBER_SLOW_CABLE 0x08	/* If *not* set, assume SLOW_CABLE */
+
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
@@ -302,12 +338,6 @@
 
 #define HOSTS_C
 
-#include "cyberstorm.h"
-
-static Scsi_Host_Template driver_template = SCSI_CYBERSTORM;
-
-#include "scsi_module.c"
-
 int cyber_esp_release(struct Scsi_Host *instance)
 {
 #ifdef MODULE
@@ -320,5 +350,25 @@
 #endif
 	return 1;
 }
+
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-cyberstorm",
+	.proc_info		= esp_proc_info,
+	.name			= "CyberStorm SCSI",
+	.detect			= cyber_esp_detect,
+	.release		= cyber_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+
+#include "scsi_module.c"
 
 MODULE_LICENSE("GPL");
--- linux-2.5.46/drivers/scsi/cyberstorm.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.46/drivers/scsi/cyberstorm.h	Thu Jan  1 01:00:00 1970
@@ -1,73 +0,0 @@
-/* cyberstorm.h: Defines and structures for the CyberStorm SCSI driver.
- *
- * Copyright (C) 1996 Jesper Skov (jskov@cygnus.co.uk)
- */
-
-#include "NCR53C9x.h"
-
-#ifndef CYBER_ESP_H
-#define CYBER_ESP_H
-
-/* The controller registers can be found in the Z2 config area at these
- * offsets:
- */
-#define CYBER_ESP_ADDR 0xf400
-#define CYBER_DMA_ADDR 0xf800
-
-
-/* The CyberStorm DMA interface */
-struct cyber_dma_registers {
-	volatile unsigned char dma_addr0;	/* DMA address (MSB) [0x000] */
-	unsigned char dmapad1[1];
-	volatile unsigned char dma_addr1;	/* DMA address       [0x002] */
-	unsigned char dmapad2[1];
-	volatile unsigned char dma_addr2;	/* DMA address       [0x004] */
-	unsigned char dmapad3[1];
-	volatile unsigned char dma_addr3;	/* DMA address (LSB) [0x006] */
-	unsigned char dmapad4[0x3fb];
-	volatile unsigned char cond_reg;        /* DMA cond    (ro)  [0x402] */
-#define ctrl_reg  cond_reg			/* DMA control (wo)  [0x402] */
-};
-
-/* DMA control bits */
-#define CYBER_DMA_LED    0x80	/* HD led control 1 = on */
-#define CYBER_DMA_WRITE  0x40	/* DMA direction. 1 = write */
-#define CYBER_DMA_Z3     0x20	/* 16 (Z2) or 32 (CHIP/Z3) bit DMA transfer */
-
-/* DMA status bits */
-#define CYBER_DMA_HNDL_INTR 0x80	/* DMA IRQ pending? */
-
-/* The bits below appears to be Phase5 Debug bits only; they were not
- * described by Phase5 so using them may seem a bit stupid...
- */
-#define CYBER_HOST_ID 0x02	/* If set, host ID should be 7, otherwise
-				 * it should be 6.
-				 */
-#define CYBER_SLOW_CABLE 0x08	/* If *not* set, assume SLOW_CABLE */
-
-extern int cyber_esp_detect(struct SHT *);
-extern int cyber_esp_release(struct Scsi_Host *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-
-#define SCSI_CYBERSTORM   { proc_name:		"esp-cyberstorm", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm SCSI", \
-			    detect:		cyber_esp_detect, \
-			    release:		cyber_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
-#endif /* CYBER_ESP_H */
--- linux-2.5.46/drivers/scsi/cyberstormII.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.46/drivers/scsi/cyberstormII.c	Sun Nov 10 10:31:12 2002
@@ -28,7 +28,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "cyberstormII.h"
 
 #include <linux/zorro.h>
 #include <asm/irq.h>
@@ -37,6 +36,30 @@
 
 #include <asm/pgtable.h>
 
+/* The controller registers can be found in the Z2 config area at these
+ * offsets:
+ */
+#define CYBERII_ESP_ADDR 0x1ff03
+#define CYBERII_DMA_ADDR 0x1ff43
+
+
+/* The CyberStorm II DMA interface */
+struct cyberII_dma_registers {
+	volatile unsigned char cond_reg;        /* DMA cond    (ro)  [0x000] */
+#define ctrl_reg  cond_reg			/* DMA control (wo)  [0x000] */
+	unsigned char dmapad4[0x3f];
+	volatile unsigned char dma_addr0;	/* DMA address (MSB) [0x040] */
+	unsigned char dmapad1[3];
+	volatile unsigned char dma_addr1;	/* DMA address       [0x044] */
+	unsigned char dmapad2[3];
+	volatile unsigned char dma_addr2;	/* DMA address       [0x048] */
+	unsigned char dmapad3[3];
+	volatile unsigned char dma_addr3;	/* DMA address (LSB) [0x04c] */
+};
+
+/* DMA control bits */
+#define CYBERII_DMA_LED    0x02	/* HD led control 1 = on */
+
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
@@ -252,13 +275,6 @@
 
 #define HOSTS_C
 
-#include "cyberstormII.h"
-
-static Scsi_Host_Template driver_template = SCSI_CYBERSTORMII;
-
-#include "scsi_module.c"
-
-
 int cyberII_esp_release(struct Scsi_Host *instance)
 {
 #ifdef MODULE
@@ -271,5 +287,25 @@
 #endif
 	return 1;
 }
+
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-cyberstormII",
+	.proc_info		= esp_proc_info,
+	.name			= "CyberStorm Mk II SCSI",
+	.detect			= cyberII_esp_detect,
+	.release		= cyberII_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+
+#include "scsi_module.c"
 
 MODULE_LICENSE("GPL");
--- linux-2.5.46/drivers/scsi/cyberstormII.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.46/drivers/scsi/cyberstormII.h	Thu Jan  1 01:00:00 1970
@@ -1,60 +0,0 @@
-/* cyberstormII.h: Defines and structures for the CyberStorm SCSI Mk II driver.
- *
- * Copyright (C) 1996 Jesper Skov (jskov@cygnus.co.uk)
- */
-
-#include "NCR53C9x.h"
-
-#ifndef CYBERII_ESP_H
-#define CYBERII_ESP_H
-
-/* The controller registers can be found in the Z2 config area at these
- * offsets:
- */
-#define CYBERII_ESP_ADDR 0x1ff03
-#define CYBERII_DMA_ADDR 0x1ff43
-
-
-/* The CyberStorm II DMA interface */
-struct cyberII_dma_registers {
-	volatile unsigned char cond_reg;        /* DMA cond    (ro)  [0x000] */
-#define ctrl_reg  cond_reg			/* DMA control (wo)  [0x000] */
-	unsigned char dmapad4[0x3f];
-	volatile unsigned char dma_addr0;	/* DMA address (MSB) [0x040] */
-	unsigned char dmapad1[3];
-	volatile unsigned char dma_addr1;	/* DMA address       [0x044] */
-	unsigned char dmapad2[3];
-	volatile unsigned char dma_addr2;	/* DMA address       [0x048] */
-	unsigned char dmapad3[3];
-	volatile unsigned char dma_addr3;	/* DMA address (LSB) [0x04c] */
-};
-
-/* DMA control bits */
-#define CYBERII_DMA_LED    0x02	/* HD led control 1 = on */
-
-
-extern int cyberII_esp_detect(struct SHT *);
-extern int cyberII_esp_release(struct Scsi_Host *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-#define SCSI_CYBERSTORMII { proc_name:		"esp-cyberstormII", \
-			    proc_info:		esp_proc_info, \
-			    name:		"CyberStorm Mk II SCSI", \
-			    detect:		cyberII_esp_detect, \
-			    release:		cyberII_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
-#endif /* CYBERII_ESP_H */
--- linux-2.5.46/drivers/scsi/dec_esp.c	Fri Feb  1 09:36:52 2002
+++ linux-m68k-2.5.46/drivers/scsi/dec_esp.c	Sun Nov 10 10:31:40 2002
@@ -31,7 +31,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "dec_esp.h"
 
 #include <asm/irq.h>
 #include <asm/jazz.h>
@@ -46,6 +45,11 @@
 #include <asm/dec/ioasic_ints.h>
 #include <asm/dec/machtype.h>
 
+#define DEC_SCSI_SREG 0
+#define DEC_SCSI_DMAREG 0x40000
+#define DEC_SCSI_SRAM 0x80000
+#define DEC_SCSI_DIAG 0xC0000
+
 /*
  * Once upon a time the pmaz code used to be working but
  * it hasn't been maintained for quite some time.
@@ -103,7 +107,25 @@
 
 static void scsi_dma_int(int, void *, struct pt_regs *);
 
-static Scsi_Host_Template driver_template = SCSI_DEC_ESP;
+int dec_esp_detect(Scsi_Host_Template * tpnt);
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.proc_info		= &esp_proc_info,
+	.name			= "NCR53C94",
+	.detect			= dec_esp_detect,
+	.info			= esp_info,
+	.command		= esp_command,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= DISABLE_CLUSTERING,
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.46/drivers/scsi/dec_esp.h	Mon Jul 10 07:51:45 2000
+++ linux-m68k-2.5.46/drivers/scsi/dec_esp.h	Thu Jan  1 01:00:00 1970
@@ -1,45 +0,0 @@
-/* dec_esp.h: Defines and structures for the JAZZ SCSI driver.
- *
- * DECstation changes Copyright (C) 1998 Harald Koerfgen
- * and David Airlie
- *
- * based on jazz_esp.h:
- * Copyright (C) 1997 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
- */
-
-#ifndef DEC_ESP_H
-#define DEC_ESP_H
-
-#include "NCR53C9x.h"
-
-#define DEC_SCSI_SREG 0
-#define DEC_SCSI_DMAREG 0x40000
-#define DEC_SCSI_SRAM 0x80000
-#define DEC_SCSI_DIAG 0xC0000
-
-extern int dec_esp_detect(struct SHT *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-#define SCSI_DEC_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "NCR53C94",			\
-		detect:         dec_esp_detect,			\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
-
-#endif /* DEC_ESP_H */
--- linux-2.5.46/drivers/scsi/fastlane.c	Mon May 13 10:55:33 2002
+++ linux-m68k-2.5.46/drivers/scsi/fastlane.c	Sun Nov 10 10:32:18 2002
@@ -37,7 +37,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "fastlane.h"
 
 #include <linux/zorro.h>
 #include <asm/irq.h>
@@ -53,6 +52,36 @@
 #define NODMAIRQ
 #endif
 
+/* The controller registers can be found in the Z2 config area at these
+ * offsets:
+ */
+#define FASTLANE_ESP_ADDR 0x1000001
+#define FASTLANE_DMA_ADDR 0x1000041
+
+
+/* The Fastlane DMA interface */
+struct fastlane_dma_registers {
+	volatile unsigned char cond_reg;	/* DMA status  (ro) [0x0000] */
+#define ctrl_reg  cond_reg			/* DMA control (wo) [0x0000] */
+	unsigned char dmapad1[0x3f];
+	volatile unsigned char clear_strobe;    /* DMA clear   (wo) [0x0040] */
+};
+
+
+/* DMA status bits */
+#define FASTLANE_DMA_MINT  0x80
+#define FASTLANE_DMA_IACT  0x40
+#define FASTLANE_DMA_CREQ  0x20
+
+/* DMA control bits */
+#define FASTLANE_DMA_FCODE 0xa0
+#define FASTLANE_DMA_MASK  0xf3
+#define FASTLANE_DMA_LED   0x10	/* HD led control 1 = on */
+#define FASTLANE_DMA_WRITE 0x08 /* 1 = write */
+#define FASTLANE_DMA_ENABLE 0x04 /* Enable DMA */
+#define FASTLANE_DMA_EDI   0x02	/* Enable DMA IRQ ? */
+#define FASTLANE_DMA_ESI   0x01	/* Enable SCSI IRQ */
+
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
 static inline void dma_clear(struct NCR_ESP *esp);
@@ -356,11 +385,6 @@
 
 #define HOSTS_C
 
-#include "fastlane.h"
-
-static Scsi_Host_Template driver_template = SCSI_FASTLANE;
-#include "scsi_module.c"
-
 int fastlane_esp_release(struct Scsi_Host *instance)
 {
 #ifdef MODULE
@@ -372,5 +396,24 @@
 #endif
 	return 1;
 }
+
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-fastlane",
+	.proc_info		= esp_proc_info,
+	.name			= "Fastlane SCSI",
+	.detect			= fastlane_esp_detect,
+	.release		= fastlane_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+#include "scsi_module.c"
 
 MODULE_LICENSE("GPL");
--- linux-2.5.46/drivers/scsi/fastlane.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.46/drivers/scsi/fastlane.h	Thu Jan  1 01:00:00 1970
@@ -1,65 +0,0 @@
-/* fastlane.h: Defines and structures for the Fastlane SCSI driver.
- *
- * Copyright (C) 1996 Jesper Skov (jskov@cygnus.co.uk)
- */
-
-#include "NCR53C9x.h"
-
-#ifndef FASTLANE_H
-#define FASTLANE_H
-
-/* The controller registers can be found in the Z2 config area at these
- * offsets:
- */
-#define FASTLANE_ESP_ADDR 0x1000001
-#define FASTLANE_DMA_ADDR 0x1000041
-
-
-/* The Fastlane DMA interface */
-struct fastlane_dma_registers {
-	volatile unsigned char cond_reg;	/* DMA status  (ro) [0x0000] */
-#define ctrl_reg  cond_reg			/* DMA control (wo) [0x0000] */
-	unsigned char dmapad1[0x3f];
-	volatile unsigned char clear_strobe;    /* DMA clear   (wo) [0x0040] */
-};
-
-
-/* DMA status bits */
-#define FASTLANE_DMA_MINT  0x80
-#define FASTLANE_DMA_IACT  0x40
-#define FASTLANE_DMA_CREQ  0x20
-
-/* DMA control bits */
-#define FASTLANE_DMA_FCODE 0xa0
-#define FASTLANE_DMA_MASK  0xf3
-#define FASTLANE_DMA_LED   0x10	/* HD led control 1 = on */
-#define FASTLANE_DMA_WRITE 0x08 /* 1 = write */
-#define FASTLANE_DMA_ENABLE 0x04 /* Enable DMA */
-#define FASTLANE_DMA_EDI   0x02	/* Enable DMA IRQ ? */
-#define FASTLANE_DMA_ESI   0x01	/* Enable SCSI IRQ */
-
-extern int fastlane_esp_detect(struct SHT *);
-extern int fastlane_esp_release(struct Scsi_Host *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-#define SCSI_FASTLANE     { proc_name:		"esp-fastlane", \
-			    proc_info:		esp_proc_info, \
-			    name:		"Fastlane SCSI", \
-			    detect:		fastlane_esp_detect, \
-			    release:		fastlane_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	ENABLE_CLUSTERING }
-
-#endif /* FASTLANE_H */
--- linux-2.5.46/drivers/scsi/jazz_esp.c	Fri Jun 21 09:34:44 2002
+++ linux-m68k-2.5.46/drivers/scsi/jazz_esp.c	Sun Nov 10 10:35:21 2002
@@ -18,7 +18,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "jazz_esp.h"
 
 #include <asm/irq.h>
 #include <asm/jazz.h>
@@ -273,3 +272,21 @@
     *(unsigned char *)JAZZ_HDC_LED = 1;
 #endif    
 }
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.proc_info		= &esp_proc_info,
+	.name			= "ESP 100/100a/200",
+	.detect			= jazz_esp_detect,
+	.info			= esp_info,
+	.command		= esp_command,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= DISABLE_CLUSTERING,
+};
+
--- linux-2.5.46/drivers/scsi/jazz_esp.h	Mon Jul 10 07:51:45 2000
+++ linux-m68k-2.5.46/drivers/scsi/jazz_esp.h	Thu Jan  1 01:00:00 1970
@@ -1,39 +0,0 @@
-/* jazz_esp.h: Defines and structures for the JAZZ SCSI driver.
- *
- * Copyright (C) 1997 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
- */
-
-#ifndef JAZZ_ESP_H
-#define JAZZ_ESP_H
-
-#define EREGS_PAD(n)
-
-#include "NCR53C9x.h"
-
-
-extern int jazz_esp_detect(struct SHT *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-#define SCSI_JAZZ_ESP {                                         \
-		proc_name:      "esp",				\
-		proc_info:      &esp_proc_info,			\
-		name:           "ESP 100/100a/200",		\
-		detect:         jazz_esp_detect,		\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
-
-#endif /* JAZZ_ESP_H */
--- linux-2.5.46/drivers/scsi/mac_esp.c	Thu Jul 25 12:53:56 2002
+++ linux-m68k-2.5.46/drivers/scsi/mac_esp.c	Sun Nov 10 10:35:52 2002
@@ -27,7 +27,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "mac_esp.h"
 
 #include <asm/io.h>
 
@@ -41,6 +40,8 @@
 
 #include <asm/macintosh.h>
 
+/* #define DEBUG_MAC_ESP */
+
 #define mac_turnon_irq(x)	mac_enable_irq(x)
 #define mac_turnoff_irq(x)	mac_disable_irq(x)
 
@@ -710,7 +711,23 @@
 #endif
 }
 
-static Scsi_Host_Template driver_template = SCSI_MAC_ESP;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.name			= "Mac 53C9x SCSI",
+	.detect			= mac_esp_detect,
+	.release		= NULL,
+	.info			= esp_info,
+	/* .command		= esp_command, */
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.46/drivers/scsi/mac_esp.h	Sun Dec  9 15:15:30 2001
+++ linux-m68k-2.5.46/drivers/scsi/mac_esp.h	Thu Jan  1 01:00:00 1970
@@ -1,40 +0,0 @@
-
-/*
-mac_esp.h
-
-copyright 1997 David Weis, weisd3458@uni.edu
-*/
-
-
-#include "NCR53C9x.h"
-
-#ifndef MAC_ESP_H
-#define MAC_ESP_H
-
-/* #define DEBUG_MAC_ESP */
-
-extern int mac_esp_detect(struct SHT *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-
-
-#define SCSI_MAC_ESP      { proc_name:		"esp", \
-			    name:		"Mac 53C9x SCSI", \
-			    detect:		mac_esp_detect, \
-			    release:		NULL, \
-			    info:		esp_info, \
-			    /* command:		esp_command, */ \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    this_id:		7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-			    use_clustering:	DISABLE_CLUSTERING }
-
-#endif /* MAC_ESP_H */
-
--- linux-2.5.46/drivers/scsi/mca_53c9x.c	Mon Feb 11 09:14:40 2002
+++ linux-m68k-2.5.46/drivers/scsi/mca_53c9x.c	Sun Nov 10 10:36:46 2002
@@ -42,7 +42,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "mca_53c9x.h"
 
 #include <asm/dma.h>
 #include <linux/mca.h>
@@ -51,6 +50,31 @@
 
 #include <asm/pgtable.h>
 
+/*
+ * From ibmmca.c (IBM scsi controller card driver) -- used for turning PS2 disk
+ *  activity LED on and off
+ */
+
+#define PS2_SYS_CTR	0x92
+
+/* Ports the ncr's 53c94 can be put at; indexed by pos register value */
+
+#define MCA_53C9X_IO_PORTS {                             \
+                         0x0000, 0x0240, 0x0340, 0x0400, \
+	                 0x0420, 0x3240, 0x8240, 0xA240, \
+	                }
+			
+/*
+ * Supposedly there were some cards put together with the 'c9x and 86c01.  If
+ *   they have different ID's from the ones on the 3500 series machines, 
+ *   you can add them here and hopefully things will work out.
+ */
+			
+#define MCA_53C9X_IDS {          \
+                         0x7F4C, \
+			 0x0000, \
+                        }
+
 static int  dma_bytes_sent(struct NCR_ESP *, int);
 static int  dma_can_transfer(struct NCR_ESP *, Scsi_Cmnd *);
 static void dma_dump_state(struct NCR_ESP *);
@@ -419,7 +441,22 @@
 	outb(inb(PS2_SYS_CTR) & 0x3f, PS2_SYS_CTR);
 }
 
-static Scsi_Host_Template driver_template = MCA_53C9X;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.name			= "NCR 53c9x SCSI",
+	.detect			= mca_esp_detect,
+	.release		= mca_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.unchecked_isa_dma	= 1,
+	.use_clustering		= DISABLE_CLUSTERING
+};
+
+
 #include "scsi_module.c"
 
 /*
--- linux-2.5.46/drivers/scsi/mca_53c9x.h	Mon Jul 10 07:51:45 2000
+++ linux-m68k-2.5.46/drivers/scsi/mca_53c9x.h	Thu Jan  1 01:00:00 1970
@@ -1,66 +0,0 @@
-/* mca_53c94.h: Defines and structures for the SCSI adapter found on NCR 35xx
- *  (and maybe some other) Microchannel machines.
- *
- * Code taken mostly from Cyberstorm SCSI drivers
- *   Copyright (C) 1996 Jesper Skov (jskov@cygnus.co.uk)
- *
- * Hacked to work with the NCR MCA stuff by Tymm Twillman (tymm@computer.org)
- *   1998
- */
-
-#include "NCR53C9x.h"
-
-#ifndef MCA_53C9X_H
-#define MCA_53C9X_H
-
-/*
- * From ibmmca.c (IBM scsi controller card driver) -- used for turning PS2 disk
- *  activity LED on and off
- */
-
-#define PS2_SYS_CTR	0x92
-
-extern int mca_esp_detect(struct SHT *);
-extern int mca_esp_release(struct Scsi_Host *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-
-#define MCA_53C9X         { proc_name:		"esp", \
-			    name:		"NCR 53c9x SCSI", \
-			    detect:		mca_esp_detect, \
-			    release:		mca_esp_release, \
-			    queuecommand:	esp_queue, \
-			    abort:		esp_abort, \
-			    reset:		esp_reset, \
-			    can_queue:          7, \
-			    sg_tablesize:	SG_ALL, \
-			    cmd_per_lun:	1, \
-                            unchecked_isa_dma:  1, \
-			    use_clustering:	DISABLE_CLUSTERING }
-
-/* Ports the ncr's 53c94 can be put at; indexed by pos register value */
-
-#define MCA_53C9X_IO_PORTS {                             \
-                         0x0000, 0x0240, 0x0340, 0x0400, \
-	                 0x0420, 0x3240, 0x8240, 0xA240, \
-	                }
-			
-/*
- * Supposedly there were some cards put together with the 'c9x and 86c01.  If
- *   they have different ID's from the ones on the 3500 series machines, 
- *   you can add them here and hopefully things will work out.
- */
-			
-#define MCA_53C9X_IDS {          \
-                         0x7F4C, \
-			 0x0000, \
-                        }
-
-#endif /* MCA_53C9X_H */
-
--- linux-2.5.46/drivers/scsi/oktagon_esp.c	Mon Oct  7 22:04:40 2002
+++ linux-m68k-2.5.46/drivers/scsi/oktagon_esp.c	Sun Nov 10 10:37:56 2002
@@ -32,7 +32,6 @@
 #include "scsi.h"
 #include "hosts.h"
 #include "NCR53C9x.h"
-#include "oktagon_esp.h"
 
 #include <linux/zorro.h>
 #include <asm/irq.h>
@@ -46,6 +45,13 @@
 
 #include <linux/unistd.h>
 
+/* The controller registers can be found in the Z2 config area at these
+ * offsets:
+ */
+#define OKTAGON_ESP_ADDR 0x03000
+#define OKTAGON_DMA_ADDR 0x01000
+
+
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static int  dma_can_transfer(struct NCR_ESP *esp, Scsi_Cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
@@ -571,12 +577,6 @@
 
 #define HOSTS_C
 
-#include "oktagon_esp.h"
-
-static Scsi_Host_Template driver_template = SCSI_OKTAGON_ESP;
-
-#include "scsi_module.c"
-
 int oktagon_esp_release(struct Scsi_Host *instance)
 {
 #ifdef MODULE
@@ -588,5 +588,25 @@
 #endif
 	return 1;
 }
+
+
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp-oktagon",
+	.proc_info		= &esp_proc_info,
+	.name			= "BSC Oktagon SCSI",
+	.detect			= oktagon_esp_detect,
+	.release		= oktagon_esp_release,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= ENABLE_CLUSTERING
+};
+
+
+#include "scsi_module.c"
 
 MODULE_LICENSE("GPL");
--- linux-2.5.46/drivers/scsi/oktagon_esp.h	Mon Jul 10 07:51:43 2000
+++ linux-m68k-2.5.46/drivers/scsi/oktagon_esp.h	Thu Jan  1 01:00:00 1970
@@ -1,57 +0,0 @@
-/* oktagon_esp.h: Defines and structures for the CyberStorm SCSI Mk II driver.
- *
- * Copyright (C) 1996 Jesper Skov (jskov@cs.auc.dk)
- */
-
-#include "NCR53C9x.h"
-
-#ifndef OKTAGON_ESP_H
-#define OKTAGON_ESP_H
-
-/* The controller registers can be found in the Z2 config area at these
- * offsets:
- */
-#define OKTAGON_ESP_ADDR 0x03000
-#define OKTAGON_DMA_ADDR 0x01000
-
-
-/* The CyberStorm II DMA interface */
-struct oktagon_dma_registers {
-	volatile unsigned char cond_reg;        /* DMA cond    (ro)  [0x000] */
-#define ctrl_reg  cond_reg			/* DMA control (wo)  [0x000] */
-	unsigned char dmapad4[0x3f];
-	volatile unsigned char dma_addr0;	/* DMA address (MSB) [0x040] */
-	unsigned char dmapad1[3];
-	volatile unsigned char dma_addr1;	/* DMA address       [0x044] */
-	unsigned char dmapad2[3];
-	volatile unsigned char dma_addr2;	/* DMA address       [0x048] */
-	unsigned char dmapad3[3];
-	volatile unsigned char dma_addr3;	/* DMA address (LSB) [0x04c] */
-};
-
-extern int oktagon_esp_detect(struct SHT *);
-extern int oktagon_esp_release(struct Scsi_Host *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			int hostno, int inout);
-
-#define SCSI_OKTAGON_ESP {                       \
-   proc_name:           "esp-oktagon",           \
-   proc_info:           &esp_proc_info,          \
-   name:                "BSC Oktagon SCSI",      \
-   detect:              oktagon_esp_detect,      \
-   release:             oktagon_esp_release,     \
-   queuecommand:        esp_queue,               \
-   abort:               esp_abort,               \
-   reset:               esp_reset,               \
-   can_queue:           7,                       \
-   this_id:             7,                       \
-   sg_tablesize:        SG_ALL,                  \
-   cmd_per_lun:         1,                       \
-   use_clustering:      ENABLE_CLUSTERING }
-
-#endif /* OKTAGON_ESP_H */
--- linux-2.5.46/drivers/scsi/sun3x_esp.c	Tue Nov  5 10:10:06 2002
+++ linux-m68k-2.5.46/drivers/scsi/sun3x_esp.c	Sun Nov 10 10:41:19 2002
@@ -18,7 +18,6 @@
 #include "hosts.h"
 #include "NCR53C9x.h"
 
-#include "sun3x_esp.h"
 #include <asm/sun3x.h>
 #include <asm/dvma.h>
 #include <asm/irq.h>
@@ -374,7 +373,23 @@
     sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dvma_address);
 }
 
-static Scsi_Host_Template driver_template = SCSI_SUN3X_ESP;
+static Scsi_Host_Template driver_template = {
+	.proc_name		= "esp",
+	.proc_info		= &esp_proc_info,
+	.name			= "Sun ESP 100/100a/200",
+	.detect			= sun3x_esp_detect,
+	.info			= esp_info,
+	.command		= esp_command,
+	.queuecommand		= esp_queue,
+	.eh_abort_handler	= esp_abort,
+	.eh_bus_reset_handler	= esp_reset,
+	.can_queue		= 7,
+	.this_id		= 7,
+	.sg_tablesize		= SG_ALL,
+	.cmd_per_lun		= 1,
+	.use_clustering		= DISABLE_CLUSTERING,
+};
+
 
 #include "scsi_module.c"
 
--- linux-2.5.46/drivers/scsi/sun3x_esp.h	Fri Nov 12 01:57:30 1999
+++ linux-m68k-2.5.46/drivers/scsi/sun3x_esp.h	Thu Jan  1 01:00:00 1970
@@ -1,39 +0,0 @@
-/* sun3x_esp.h: Defines and structures for the Sun3x ESP
- *
- * (C) 1995 Thomas Bogendoerfer (tsbogend@alpha.franken.de)
- */
-
-#ifndef _SUN3X_ESP_H
-#define _SUN3X_ESP_H
-
-/* For dvma controller register definitions. */
-#include <asm/dvma.h>
-
-extern int sun3x_esp_detect(struct SHT *);
-extern const char *esp_info(struct Scsi_Host *);
-extern int esp_queue(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-extern int esp_command(Scsi_Cmnd *);
-extern int esp_abort(Scsi_Cmnd *);
-extern int esp_reset(Scsi_Cmnd *, unsigned int);
-extern int esp_proc_info(char *buffer, char **start, off_t offset, int length,
-			 int hostno, int inout);
-
-#define DMA_PORTS_P        (dregs->cond_reg & DMA_INT_ENAB)
-
-#define SCSI_SUN3X_ESP {                                        \
-		proc_name:      "esp",  			\
-		proc_info:      &esp_proc_info,			\
-		name:           "Sun ESP 100/100a/200",		\
-		detect:         sun3x_esp_detect,		\
-		info:           esp_info,			\
-		command:        esp_command,			\
-		queuecommand:   esp_queue,			\
-		abort:          esp_abort,			\
-		reset:          esp_reset,			\
-		can_queue:      7,				\
-		this_id:        7,				\
-		sg_tablesize:   SG_ALL,				\
-		cmd_per_lun:    1,				\
-		use_clustering: DISABLE_CLUSTERING, }
-
-#endif /* !(_SUN3X_ESP_H) */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

