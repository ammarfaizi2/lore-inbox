Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTELJzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTELJsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:48:40 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:43599 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262049AbTELJpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:13 -0400
Date: Mon, 12 May 2003 11:54:45 +0200
Message-Id: <200305120954.h4C9sjL0001063@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [19/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k SCSI drivers: Update to the new irq API (from Roman Zippel and me) [19/20]

--- linux-2.5.69/drivers/scsi/53c7xx.c	Mon May  5 10:31:51 2003
+++ linux-m68k-2.5.69/drivers/scsi/53c7xx.c	Fri May  9 10:21:34 2003
@@ -322,7 +322,7 @@
 static void abnormal_finished (struct NCR53c7x0_cmd *cmd, int result);
 static int disable (struct Scsi_Host *host);
 static int NCR53c7xx_run_tests (struct Scsi_Host *host);
-static void NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs);
+static irqreturn_t NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs);
 static void NCR53c7x0_intfly (struct Scsi_Host *host);
 static int ncr_halt (struct Scsi_Host *host);
 static void intr_phase_mismatch (struct Scsi_Host *host, struct NCR53c7x0_cmd 
@@ -4226,7 +4226,7 @@
 }
 
 /*
- * Function : static void NCR53c7x0_intr (int irq, void *dev_id, struct pt_regs * regs)
+ * Function : static irqreturn_t NCR53c7x0_intr (int irq, void *dev_id, struct pt_regs * regs)
  *
  * Purpose : handle NCR53c7x0 interrupts for all NCR devices sharing
  *	the same IRQ line.  
@@ -4239,14 +4239,16 @@
  * script interrupt handler will call back to this function.
  */
 
-static void 
-NCR53c7x0_intr (int irq, void *dev_id, struct pt_regs * regs) {
+static irqreturn_t
+NCR53c7x0_intr (int irq, void *dev_id, struct pt_regs * regs)
+{
     NCR53c7x0_local_declare();
     struct Scsi_Host *host;			/* Host we are looking at */
     unsigned char istat; 			/* Values of interrupt regs */
     struct NCR53c7x0_hostdata *hostdata;	/* host->hostdata[0] */
     struct NCR53c7x0_cmd *cmd;			/* command which halted */
     u32 *dsa;					/* DSA */
+    int handled = 0;
 
 #ifdef NCR_DEBUG
     char buf[80];				/* Debugging sprintf buffer */
@@ -4263,6 +4265,7 @@
      */
 
     while ((istat = NCR53c7x0_read8(hostdata->istat)) & (ISTAT_SIP|ISTAT_DIP)) {
+	handled = 1;
 	hostdata->dsp_changed = 0;
 	hostdata->dstat_valid = 0;
     	hostdata->state = STATE_HALTED;
@@ -4347,6 +4350,7 @@
 	    }
 	}
     }
+    return IRQ_HANDLED;
 }
 
 
--- linux-2.5.69/drivers/scsi/a2091.c	Sun May 11 12:15:02 2003
+++ linux-m68k-2.5.69/drivers/scsi/a2091.c	Fri May  9 10:21:34 2003
@@ -28,11 +28,13 @@
 static struct Scsi_Host *first_instance = NULL;
 static Scsi_Host_Template *a2091_template;
 
-static void a2091_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t a2091_intr (int irq, void *dummy, struct pt_regs *fp)
 {
     unsigned long flags;
     unsigned int status;
     struct Scsi_Host *instance;
+    int handled = 0;
+
     for (instance = first_instance; instance &&
 	 instance->hostt == a2091_template; instance = instance->next)
     {
@@ -44,8 +46,10 @@
 		spin_lock_irqsave(&instance->host_lock, flags);
 		wd33c93_intr (instance);
 		spin_unlock_irqrestore(&instance->host_lock, flags);
+		handled = 1;
 	}
     }
+    return IRQ_RETVAL(handled);
 }
 
 static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
--- linux-2.5.69/drivers/scsi/a3000.c	Sun May 11 12:15:02 2003
+++ linux-m68k-2.5.69/drivers/scsi/a3000.c	Fri May  9 10:21:34 2003
@@ -27,21 +27,22 @@
 
 static struct Scsi_Host *a3000_host = NULL;
 
-static void a3000_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t a3000_intr (int irq, void *dummy, struct pt_regs *fp)
 {
 	unsigned long flags;
 	unsigned int status = DMA(a3000_host)->ISTR;
 
 	if (!(status & ISTR_INT_P))
-		return;
+		return IRQ_NONE;
 	if (status & ISTR_INTS)
 	{
 		spin_lock_irqsave(&a3000_host->host_lock, flags);
 		wd33c93_intr (a3000_host);
 		spin_unlock_irqrestore(&a3000_host->host_lock, flags);
-	} else
-		printk("Non-serviced A3000 SCSI-interrupt? ISTR = %02x\n",
-		       status);
+		return IRQ_HANDLED;
+	}
+	printk("Non-serviced A3000 SCSI-interrupt? ISTR = %02x\n", status);
+	return IRQ_NONE;
 }
 
 static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
--- linux-2.5.69/drivers/scsi/atari_NCR5380.c	Tue Mar 25 10:06:51 2003
+++ linux-m68k-2.5.69/drivers/scsi/atari_NCR5380.c	Fri May  9 10:21:34 2003
@@ -1267,10 +1267,10 @@
  *
  */
 
-static void NCR5380_intr (int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t NCR5380_intr (int irq, void *dev_id, struct pt_regs *regs)
 {
     struct Scsi_Host *instance = first_instance;
-    int done = 1;
+    int done = 1, handled = 0;
     unsigned char basr;
 
     INT_PRINTK("scsi%d: NCR5380 irq triggered\n", HOSTNO);
@@ -1329,6 +1329,7 @@
 		(void) NCR5380_read(RESET_PARITY_INTERRUPT_REG);
 	    }
 	} /* if !(SELECTION || PARITY) */
+	handled = 1;
     } /* BASR & IRQ */
     else {
 	printk(KERN_NOTICE "scsi%d: interrupt without IRQ bit set in BASR, "
@@ -1342,6 +1343,7 @@
 	/* Put a call to NCR5380_main() on the queue... */
 	queue_main();
     }
+    return IRQ_RETVAL(handled);
 }
 
 #ifdef NCR5380_STATS
--- linux-2.5.69/drivers/scsi/atari_dma_emul.c	Mon Feb 19 10:04:52 2001
+++ linux-m68k-2.5.69/drivers/scsi/atari_dma_emul.c	Fri May  9 10:21:34 2003
@@ -138,7 +138,7 @@
  *    increased with one.
  */
 
-static void hades_dma_emulator(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t hades_dma_emulator(int irq, void *dummy, struct pt_regs *fp)
 {
 	unsigned long dma_base;
 	register unsigned long dma_cnt asm ("d3");
@@ -166,7 +166,7 @@
 	if ((tt_scsi_dma.dma_ctrl & 2) == 0)
 	{
 		atari_enable_irq(IRQ_TT_MFP_SCSI);
-		return;
+		return IRQ_HANDLED;
 	}
 
 	if (dma_cnt == 0)
@@ -174,7 +174,7 @@
 		printk(KERN_NOTICE "DMA emulation: count is zero.\n");
 		tt_scsi_dma.dma_ctrl &= 0xfd;	/* DMA ready. */
 		atari_enable_irq(IRQ_TT_MFP_SCSI);
-		return;
+		return IRQ_HANDLED;
 	}
 
 	/*
@@ -338,7 +338,7 @@
 
 	atari_enable_irq(IRQ_TT_MFP_SCSI);
 
-	return;
+	return IRQ_HANDLED;
 
 scsi_bus_error:
 	/*
--- linux-2.5.69/drivers/scsi/atari_scsi.c	Tue Mar 25 10:06:51 2003
+++ linux-m68k-2.5.69/drivers/scsi/atari_scsi.c	Fri May  9 10:21:34 2003
@@ -195,8 +195,8 @@
 static unsigned long atari_dma_xfer_len( unsigned long wanted_len,
                                          Scsi_Cmnd *cmd, int write_flag );
 #endif
-static void scsi_tt_intr( int irq, void *dummy, struct pt_regs *fp);
-static void scsi_falcon_intr( int irq, void *dummy, struct pt_regs *fp);
+static irqreturn_t scsi_tt_intr( int irq, void *dummy, struct pt_regs *fp);
+static irqreturn_t scsi_falcon_intr( int irq, void *dummy, struct pt_regs *fp);
 static void falcon_release_lock_if_possible( struct NCR5380_hostdata *
                                              hostdata );
 static void falcon_get_lock( void );
@@ -315,7 +315,7 @@
 #endif
 
 
-static void scsi_tt_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t scsi_tt_intr (int irq, void *dummy, struct pt_regs *fp)
 {
 #ifdef REAL_DMA
 	int dma_stat;
@@ -403,10 +403,11 @@
 	/* To be sure the int is not masked */
 	atari_enable_irq( IRQ_TT_MFP_SCSI );
 #endif
+	return IRQ_HANDLED;
 }
 
 
-static void scsi_falcon_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t scsi_falcon_intr (int irq, void *dummy, struct pt_regs *fp)
 {
 #ifdef REAL_DMA
 	int dma_stat;
@@ -463,6 +464,7 @@
 #endif /* REAL_DMA */
 
 	NCR5380_intr (0, 0, 0);
+	return IRQ_HANDLED;
 }
 
 
--- linux-2.5.69/drivers/scsi/gvp11.c	Sun May 11 12:15:02 2003
+++ linux-m68k-2.5.69/drivers/scsi/gvp11.c	Fri May  9 10:21:34 2003
@@ -28,11 +28,12 @@
 static struct Scsi_Host *first_instance = NULL;
 static Scsi_Host_Template *gvp11_template;
 
-static void gvp11_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t gvp11_intr (int irq, void *dummy, struct pt_regs *fp)
 {
     unsigned long flags;
     unsigned int status;
     struct Scsi_Host *instance;
+    int handled = 0;
 
     for (instance = first_instance; instance &&
 	 instance->hostt == gvp11_template; instance = instance->next)
@@ -44,7 +45,9 @@
 	spin_lock_irqsave(&instance->host_lock, flags);
 	wd33c93_intr (instance);
 	spin_unlock_irqrestore(&instance->host_lock, flags);
+	handled = 1;
     }
+    return IRQ_RETVAL(handled);
 }
 
 static int gvp11_xfer_mask = 0;
--- linux-2.5.69/drivers/scsi/mac_NCR5380.c	Tue Mar 25 10:06:53 2003
+++ linux-m68k-2.5.69/drivers/scsi/mac_NCR5380.c	Fri May  9 10:21:35 2003
@@ -1274,7 +1274,7 @@
 static void NCR5380_intr (int irq, void *dev_id, struct pt_regs *regs)
 {
     struct Scsi_Host *instance = first_instance;
-    int done = 1;
+    int done = 1, handled = 0;
     unsigned char basr;
 
     INT_PRINTK("scsi%d: NCR5380 irq triggered\n", HOSTNO);
@@ -1333,6 +1333,7 @@
 		(void) NCR5380_read(RESET_PARITY_INTERRUPT_REG);
 	    }
 	} /* if !(SELECTION || PARITY) */
+	handled = 1;
     } /* BASR & IRQ */
     else {
 	printk(KERN_NOTICE "scsi%d: interrupt without IRQ bit set in BASR, "
@@ -1346,6 +1347,7 @@
 	/* Put a call to NCR5380_main() on the queue... */
 	queue_main();
     }
+    return IRQ_RETVAL(handled);
 }
 
 #ifdef NCR5380_STATS
--- linux-2.5.69/drivers/scsi/mac_esp.c	Thu Jan  2 12:54:42 2003
+++ linux-m68k-2.5.69/drivers/scsi/mac_esp.c	Fri May  9 10:21:35 2003
@@ -142,9 +142,10 @@
 	mac_esp_intr(irq, dev_id, pregs);
 }
 
-void fake_drq(int irq, void *dev_id, struct pt_regs *pregs)
+irqreturn_t fake_drq(int irq, void *dev_id, struct pt_regs *pregs)
 {
 	printk("mac_esp: got drq\n");
+	return IRQ_HANDLED;
 }
 
 #define DRIVER_SETUP
--- linux-2.5.69/drivers/scsi/mvme147.c	Sun May 11 12:15:02 2003
+++ linux-m68k-2.5.69/drivers/scsi/mvme147.c	Fri May  9 10:21:35 2003
@@ -21,12 +21,13 @@
 
 static struct Scsi_Host *mvme147_host = NULL;
 
-static void mvme147_intr (int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t mvme147_intr (int irq, void *dummy, struct pt_regs *fp)
 {
     if (irq == MVME147_IRQ_SCSI_PORT)
 	wd33c93_intr (mvme147_host);
     else
 	m147_pcc->dma_intr = 0x89;	/* Ack and enable ints */
+    return IRQ_HANDLED;
 }
 
 static int dma_setup (Scsi_Cmnd *cmd, int dir_in)
--- linux-2.5.69/drivers/scsi/sun3_NCR5380.c	Tue Mar 25 10:06:53 2003
+++ linux-m68k-2.5.69/drivers/scsi/sun3_NCR5380.c	Fri May  9 10:21:35 2003
@@ -1255,10 +1255,10 @@
  *
  */
 
-static void NCR5380_intr (int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t NCR5380_intr (int irq, void *dev_id, struct pt_regs *regs)
 {
     struct Scsi_Host *instance = first_instance;
-    int done = 1;
+    int done = 1, handled = 0;
     unsigned char basr;
 
     INT_PRINTK("scsi%d: NCR5380 irq triggered\n", HOSTNO);
@@ -1320,6 +1320,7 @@
 #endif
 	    }
 	} /* if !(SELECTION || PARITY) */
+	handled = 1;
     } /* BASR & IRQ */
     else {
 
@@ -1337,6 +1338,7 @@
 	/* Put a call to NCR5380_main() on the queue... */
 	queue_main();
     }
+    return IRQ_RETVAL(handled);
 }
 
 #ifdef NCR5380_STATS
--- linux-2.5.69/drivers/scsi/sun3_scsi.c	Mon May  5 10:32:03 2003
+++ linux-m68k-2.5.69/drivers/scsi/sun3_scsi.c	Fri May  9 10:21:35 2003
@@ -102,7 +102,7 @@
 #define	ENABLE_IRQ()	enable_irq( IRQ_SUN3_SCSI ); 
 
 
-static void scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp);
+static irqreturn_t scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp);
 static inline unsigned char sun3scsi_read(int reg);
 static inline void sun3scsi_write(int reg, int value);
 
@@ -373,9 +373,10 @@
 // safe bits for the CSR
 #define CSR_GOOD 0x060f
 
-static void scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp)
 {
 	unsigned short csr = dregs->csr;
+	int handled = 0;
 
 	if(csr & ~CSR_GOOD) {
 		if(csr & CSR_DMA_BUSERR) {
@@ -385,10 +386,15 @@
 		if(csr & CSR_DMA_CONFLICT) {
 			printk("scsi%d: dma conflict\n", default_instance->host_no);
 		}
+		handled = 1;
 	}
 
-	if(csr & (CSR_SDB_INT | CSR_DMA_INT))
+	if(csr & (CSR_SDB_INT | CSR_DMA_INT)) {
 		NCR5380_intr(irq, dummy, fp);
+		handled = 1;
+	}
+
+	return IRQ_RETVAL(handled);
 }
 
 /*
--- linux-2.5.69/drivers/scsi/sun3_scsi_vme.c	Mon May  5 10:32:03 2003
+++ linux-m68k-2.5.69/drivers/scsi/sun3_scsi_vme.c	Fri May  9 10:21:35 2003
@@ -67,7 +67,7 @@
 #define ENABLE_IRQ()
 
 
-static void scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp);
+static irqreturn_t scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp);
 static inline unsigned char sun3scsi_read(int reg);
 static inline void sun3scsi_write(int reg, int value);
 
@@ -342,9 +342,10 @@
 // safe bits for the CSR
 #define CSR_GOOD 0x060f
 
-static void scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp)
+static irqreturn_t scsi_sun3_intr(int irq, void *dummy, struct pt_regs *fp)
 {
 	unsigned short csr = dregs->csr;
+	int handled = 0;
 
 	dregs->csr &= ~CSR_DMA_ENABLE;
 
@@ -368,10 +369,15 @@
 		if(csr & CSR_DMA_CONFLICT) {
 			printk("scsi%d: dma conflict\n", default_instance->host_no);
 		}
+		handled = 1;
 	}
 
-	if(csr & (CSR_SDB_INT | CSR_DMA_INT))
+	if(csr & (CSR_SDB_INT | CSR_DMA_INT)) {
 		NCR5380_intr(irq, dummy, fp);
+		handled = 1;
+	}
+
+	return IRQ_RETVAL(handled);
 }
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
