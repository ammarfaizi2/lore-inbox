Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262998AbTCSMSB>; Wed, 19 Mar 2003 07:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTCSMSB>; Wed, 19 Mar 2003 07:18:01 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:21383 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262987AbTCSMQq>;
	Wed, 19 Mar 2003 07:16:46 -0500
Date: Wed, 19 Mar 2003 13:27:48 +0100 (MET)
Message-Id: <200303191227.h2JCRmH00943@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k NCR5380 SCSI updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k NCR5380 SCSI updates for changes in SCSI and NCR5380 SCSI layers:
  - Sun-3/3x (from Sam Creasey)
  - Atari (ported updates from Sun-3)
  - Mac (ported updates from Sun-3)

--- linux-2.5.x/drivers/scsi/sun3_NCR5380.c	Wed Nov 20 11:56:10 2002
+++ linux-m68k-2.5.x/drivers/scsi/sun3_NCR5380.c	Fri Feb  7 22:02:17 2003
@@ -842,7 +842,7 @@
  * 
  */
 
-static void __init NCR5380_init (struct Scsi_Host *instance, int flags)
+static int NCR5380_init (struct Scsi_Host *instance, int flags)
 {
     int i;
     SETUP_HOSTDATA(instance);
@@ -886,6 +886,8 @@
     NCR5380_write(MODE_REG, MR_BASE);
     NCR5380_write(TARGET_COMMAND_REG, 0);
     NCR5380_write(SELECT_ENABLE_REG, 0);
+
+    return 0;
 }
 
 /* 
@@ -914,7 +914,6 @@
     SETUP_HOSTDATA(cmd->host);
     Scsi_Cmnd *tmp;
     unsigned long flags;
-    extern int update_timeout(Scsi_Cmnd * SCset, int timeout);
 
 #if (NDEBUG & NDEBUG_NO_WRITE)
     switch (cmd->cmnd[0]) {
@@ -1014,7 +1016,7 @@
     if (in_interrupt() || ((flags >> 8) & 7) >= 6)
 	queue_main();
     else
-	NCR5380_main();
+	NCR5380_main(NULL);
     return 0;
 }
 
@@ -1030,7 +1032,7 @@
  *  reenable them.  This prevents reentrancy and kernel stack overflow.
  */ 	
     
-static void NCR5380_main (void)
+static void NCR5380_main (void *bl)
 {
     Scsi_Cmnd *tmp, *prev;
     struct Scsi_Host *instance = first_instance;
@@ -1065,7 +1067,7 @@
 
     local_save_flags(flags);
     do {
-	local_irq_disable(flags); /* Freeze request queues */
+	local_irq_disable(); /* Freeze request queues */
 	done = 1;
 	
 	if (!hostdata->connected) {
--- linux-2.5.x/drivers/scsi/sun3_NCR5380.c	Mon Feb 17 18:09:44 2003
+++ linux-m68k-2.5.x/drivers/scsi/sun3_NCR5380.c	Fri Feb 14 13:25:54 2003
@@ -2869,7 +2869,7 @@
 
 
 /* 
- * Function : int NCR5380_reset (Scsi_Cmnd *cmd, unsigned int reset_flags)
+ * Function : int NCR5380_bus_reset (Scsi_Cmnd *cmd)
  * 
  * Purpose : reset the SCSI bus.
  *
@@ -2877,7 +2877,7 @@
  *
  */ 
 
-static int NCR5380_reset( Scsi_Cmnd *cmd, unsigned int reset_flags)
+static int NCR5380_bus_reset( Scsi_Cmnd *cmd)
 {
     SETUP_HOSTDATA(cmd->device->host);
     int           i;
--- linux-2.5.x/drivers/scsi/sun3_scsi.c	Wed Nov 20 11:36:31 2002
+++ linux-m68k-2.5.x/drivers/scsi/sun3_scsi.c	Fri Feb  7 22:02:17 2003
@@ -79,6 +79,8 @@
 #include "sun3_scsi.h"
 #include "NCR5380.h"
 
+static void NCR5380_print(struct Scsi_Host *instance);
+
 /* #define OLDDMA */
 
 #define USE_WRAPPER
@@ -621,8 +623,8 @@
 	.release		= sun3scsi_release,
 	.info			= sun3scsi_info,
 	.queuecommand		= sun3scsi_queue_command,
-	.abort			= sun3scsi_abort,
-	.reset			= sun3scsi_reset,
+	.eh_abort_handler      	= sun3scsi_abort,
+	.eh_bus_reset_handler  	= sun3scsi_bus_reset,
 	.can_queue		= CAN_QUEUE,
 	.this_id		= 7,
 	.sg_tablesize		= SG_TABLESIZE,
--- linux-2.5.x/drivers/scsi/sun3_scsi.h	Wed Nov 20 11:36:31 2002
+++ linux-m68k-2.5.x/drivers/scsi/sun3_scsi.h	Fri Feb  7 22:02:17 2003
@@ -55,7 +55,7 @@
 static int sun3scsi_abort (Scsi_Cmnd *);
 static int sun3scsi_detect (Scsi_Host_Template *);
 static const char *sun3scsi_info (struct Scsi_Host *);
-static int sun3scsi_reset(Scsi_Cmnd *, unsigned int);
+static int sun3scsi_bus_reset(Scsi_Cmnd *);
 static int sun3scsi_queue_command (Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 static int sun3scsi_proc_info (char *buffer, char **start, off_t offset,
 			int length, int hostno, int inout);
@@ -109,7 +109,7 @@
 
 #define NCR5380_intr sun3scsi_intr
 #define NCR5380_queue_command sun3scsi_queue_command
-#define NCR5380_reset sun3scsi_reset
+#define NCR5380_bus_reset sun3scsi_bus_reset
 #define NCR5380_abort sun3scsi_abort
 #define NCR5380_proc_info sun3scsi_proc_info
 #define NCR5380_dma_xfer_len(i, cmd, phase) \
--- linux-2.5.x/drivers/scsi/sun3_scsi_vme.c	Wed Nov 20 11:36:31 2002
+++ linux-m68k-2.5.x/drivers/scsi/sun3_scsi_vme.c	Fri Feb  7 22:02:17 2003
@@ -1,4 +1,4 @@
-/*
+ /*
  * Sun3 SCSI stuff by Erik Verbruggen (erik@bigmama.xtdnet.nl)
  *
  * Sun3 DMA routines added by Sam Creasey (sammy@sammy.net)
@@ -566,8 +566,8 @@
 	.release		= sun3scsi_release,
 	.info			= sun3scsi_info,
 	.queuecommand		= sun3scsi_queue_command,
-	.abort			= sun3scsi_abort,
-	.reset			= sun3scsi_reset,
+	.eh_abort_handler      	= sun3scsi_abort,
+	.eh_bus_reset_handler  	= sun3scsi_bus_reset,
 	.can_queue		= CAN_QUEUE,
 	.this_id		= 7,
 	.sg_tablesize		= SG_TABLESIZE,
--- linux-2.5.x/drivers/scsi/sun3x_esp.c	Mon Nov 18 22:39:10 2002
+++ linux-m68k-2.5.x/drivers/scsi/sun3x_esp.c	Fri Feb  7 22:02:17 2003
@@ -374,11 +374,44 @@
     sp->SCp.ptr = (char *)((unsigned long)sp->SCp.buffer->dvma_address);
 }
 
+
+static int esp_slave_alloc(Scsi_Device *SDptr)
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
+static void esp_slave_destroy(Scsi_Device *SDptr)
+{
+	struct NCR_ESP *esp = (struct NCR_ESP *) SDptr->host->hostdata;
+
+	esp->targets_present &= ~(1 << SDptr->id);
+	kfree(SDptr->hostdata);
+	SDptr->hostdata = NULL;
+}
+
+
+static int sun3x_esp_release(struct Scsi_Host *instance)
+{
+	/* this code does not support being compiled as a module */	 
+	return 1;
+
+}
+
 static Scsi_Host_Template driver_template = {
 	.proc_name		= "esp",
 	.proc_info		= &esp_proc_info,
 	.name			= "Sun ESP 100/100a/200",
 	.detect			= sun3x_esp_detect,
+	.release                = sun3x_esp_release,
+	.slave_alloc		= esp_slave_alloc,
+	.slave_destroy		= esp_slave_destroy,
 	.info			= esp_info,
 	.command		= esp_command,
 	.queuecommand		= esp_queue,
--- linux-2.5.x/drivers/scsi/atari_NCR5380.c	Thu Jan  2 14:03:18 2003
+++ linux-m68k-2.5.x/drivers/scsi/atari_NCR5380.c	Sun Feb  9 15:46:42 2003
@@ -834,7 +834,7 @@
  * 
  */
 
-static void __init NCR5380_init (struct Scsi_Host *instance, int flags)
+static int NCR5380_init (struct Scsi_Host *instance, int flags)
 {
     int i;
     SETUP_HOSTDATA(instance);
@@ -878,6 +878,8 @@
     NCR5380_write(MODE_REG, MR_BASE);
     NCR5380_write(TARGET_COMMAND_REG, 0);
     NCR5380_write(SELECT_ENABLE_REG, 0);
+
+    return 0;
 }
 
 /* 
@@ -898,10 +900,7 @@
  *
  */
 
-/* Only make static if a wrapper function is used */
-#ifndef NCR5380_queue_command
 static
-#endif
 int NCR5380_queue_command (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
     SETUP_HOSTDATA(cmd->host);
@@ -1014,7 +1013,7 @@
     if (in_interrupt() || ((flags >> 8) & 7) >= 6)
 	queue_main();
     else
-	NCR5380_main();
+	NCR5380_main(NULL);
     return 0;
 }
 
@@ -1030,7 +1029,7 @@
  *  reenable them.  This prevents reentrancy and kernel stack overflow.
  */ 	
     
-static void NCR5380_main (void)
+static void NCR5380_main (void *bl)
 {
     Scsi_Cmnd *tmp, *prev;
     struct Scsi_Host *instance = first_instance;
@@ -2642,9 +2641,7 @@
  * 	 called where the loop started in NCR5380_main().
  */
 
-#ifndef NCR5380_abort
 static
-#endif
 int NCR5380_abort (Scsi_Cmnd *cmd)
 {
     struct Scsi_Host *instance = cmd->host;
@@ -2842,7 +2839,7 @@
 
 
 /* 
- * Function : int NCR5380_reset (Scsi_Cmnd *cmd, unsigned int reset_flags)
+ * Function : int NCR5380_reset (Scsi_Cmnd *cmd)
  * 
  * Purpose : reset the SCSI bus.
  *
@@ -2850,7 +2847,7 @@
  *
  */ 
 
-static int NCR5380_reset( Scsi_Cmnd *cmd, unsigned int reset_flags)
+static int NCR5380_bus_reset( Scsi_Cmnd *cmd)
 {
     SETUP_HOSTDATA(cmd->host);
     int           i;
--- linux-2.5.x/drivers/scsi/atari_scsi.c	Wed Nov 20 11:36:29 2002
+++ linux-m68k-2.5.x/drivers/scsi/atari_scsi.c	Sun Feb  9 15:44:38 2003
@@ -819,7 +819,7 @@
 #endif
 }
 
-int atari_scsi_reset( Scsi_Cmnd *cmd, unsigned int reset_flags)
+int atari_scsi_bus_reset(Scsi_Cmnd *cmd)
 {
 	int		rv;
 	struct NCR5380_hostdata *hostdata =
@@ -845,7 +845,7 @@
 #endif /* REAL_DMA */
 	}
 
-	rv = NCR5380_reset(cmd, reset_flags);
+	rv = NCR5380_bus_reset(cmd);
 
 	/* Re-enable ints */
 	if (IS_A_TT()) {
@@ -1146,8 +1146,8 @@
 	.release		= atari_scsi_release,
 	.info			= atari_scsi_info,
 	.queuecommand		= atari_scsi_queue_command,
-	.abort			= atari_scsi_abort,
-	.reset			= atari_scsi_reset,
+	.eh_abort_handler	= atari_scsi_abort,
+	.eh_bus_reset_handler	= atari_scsi_bus_reset,
 	.can_queue		= 0, /* initialized at run-time */
 	.this_id		= 0, /* initialized at run-time */
 	.sg_tablesize		= 0, /* initialized at run-time */
--- linux-2.5.x/drivers/scsi/atari_scsi.h	Fri Dec 20 14:28:58 2002
+++ linux-m68k-2.5.x/drivers/scsi/atari_scsi.h	Sun Feb  9 19:14:51 2003
@@ -18,10 +18,8 @@
 /* (I_HAVE_OVERRUNS stuff removed) */
 
 #ifndef ASM
-int atari_scsi_abort (Scsi_Cmnd *);
 int atari_scsi_detect (Scsi_Host_Template *);
 const char *atari_scsi_info (struct Scsi_Host *);
-int atari_scsi_queue_command (Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
 int atari_scsi_reset (Scsi_Cmnd *, unsigned int);
 int atari_scsi_proc_info (char *, char **, off_t, int, int, int);
 #ifdef MODULE
--- linux-2.5.x/drivers/scsi/mac_NCR5380.c	Wed Feb 12 12:34:46 2003
+++ linux-m68k-2.5.x/drivers/scsi/mac_NCR5380.c	Wed Feb 12 17:43:38 2003
@@ -850,7 +850,7 @@
 
 
 /* 
- * Function : void NCR5380_init (struct Scsi_Host *instance)
+ * Function : void NCR5380_init (struct Scsi_Host *instance, int flags)
  *
  * Purpose : initializes *instance and corresponding 5380 chip.
  *
@@ -861,7 +861,7 @@
  * 
  */
 
-static void NCR5380_init (struct Scsi_Host *instance, int flags)
+static int NCR5380_init (struct Scsi_Host *instance, int flags)
 {
     int i;
     SETUP_HOSTDATA(instance);
@@ -905,6 +905,8 @@
     NCR5380_write(MODE_REG, MR_BASE);
     NCR5380_write(TARGET_COMMAND_REG, 0);
     NCR5380_write(SELECT_ENABLE_REG, 0);
+
+    return 0;
 }
 
 /* 
@@ -925,17 +927,13 @@
  *
  */
 
-/* Only make static if a wrapper function is used */
-#ifndef NCR5380_queue_command
 static
-#endif
 int NCR5380_queue_command (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
     SETUP_HOSTDATA(cmd->host);
     Scsi_Cmnd *tmp;
     int oldto;
     unsigned long flags;
-    extern int update_timeout(Scsi_Cmnd * SCset, int timeout);
 
 #if (NDEBUG & NDEBUG_NO_WRITE)
     switch (cmd->cmnd[0]) {
@@ -1025,12 +1023,12 @@
     if (in_interrupt() > 0 || ((flags >> 8) & 7) >= 6)
 	queue_main();
     else
-	NCR5380_main();
+	NCR5380_main(NULL);
     return 0;
 }
 
 /*
- * Function : NCR5380_main (void) 
+ * Function : NCR5380_main (void *bl)
  *
  * Purpose : NCR5380_main is a coroutine that runs as long as more work can 
  *	be done on the NCR5380 host adapters in a system.  Both 
@@ -1041,7 +1039,7 @@
  *  reenable them.  This prevents reentrancy and kernel stack overflow.
  */ 	
     
-static void NCR5380_main (void)
+static void NCR5380_main (void *bl)
 {
     Scsi_Cmnd *tmp, *prev;
     struct Scsi_Host *instance = first_instance;
@@ -2790,9 +2788,6 @@
  * 	 called where the loop started in NCR5380_main().
  */
 
-#ifndef NCR5380_abort
-static
-#endif
 int NCR5380_abort (Scsi_Cmnd *cmd)
 {
     struct Scsi_Host *instance = cmd->host;
@@ -2982,7 +2977,7 @@
 
 
 /* 
- * Function : int NCR5380_reset (Scsi_Cmnd *cmd, unsigned int reset_flags)
+ * Function : int NCR5380_bus_reset (Scsi_Cmnd *cmd)
  * 
  * Purpose : reset the SCSI bus.
  *
@@ -2990,7 +2985,7 @@
  *
  */ 
 
-static int NCR5380_reset( Scsi_Cmnd *cmd, unsigned int reset_flags)
+static int NCR5380_bus_reset( Scsi_Cmnd *cmd)
 {
     SETUP_HOSTDATA(cmd->host);
     int           i;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
