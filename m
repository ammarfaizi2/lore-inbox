Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSJFRUK>; Sun, 6 Oct 2002 13:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262150AbSJFRUJ>; Sun, 6 Oct 2002 13:20:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55556 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262137AbSJFRSw>; Sun, 6 Oct 2002 13:18:52 -0400
Subject: PATCH: 2.5.40 first pass at the ancient wd7000 crap
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:15:38 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yF0E-0001ss-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Wants indenting but I'll do an indenting pass after the code changes
are accepted)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/scsi/wd7000.c linux.2.5.40-ac5/drivers/scsi/wd7000.c
--- linux.2.5.40/drivers/scsi/wd7000.c	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.40-ac5/drivers/scsi/wd7000.c	2002-10-06 01:09:06.000000000 +0100
@@ -145,6 +145,19 @@
  * 12/31/2001 - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *
  * use host->host_lock, not io_request_lock, cleanups
+ *
+ * 2002/10/04 - Alan Cox <alan@redhat.com>
+ *
+ * Use dev_id for interrupts, kill __FUNCTION__ pasting
+ * Add a lock for the scb pool, clean up all other cli/sti usage stuff
+ * Use the adapter lock for the other places we had the cli's
+ *
+ * 2002/10/06 - Alan Cox <alan@redhat.com>
+ *
+ * Switch to new style error handling
+ * Clean up delay to udelay, and yielding sleeps
+ * Make host reset actually reset the card
+ * Make everything static
  */
 
 #include <linux/module.h>
@@ -254,19 +267,12 @@
 #define NUM_DMAS (sizeof(wd7000_dma)/sizeof(short))
 
 /*
- * possible irq range
+ * The following is set up by wd7000_detect, and used thereafter for
+ * proc and other global ookups
  */
-#define IRQ_MIN   3
-#define IRQ_MAX   15
-#define IRQS      (IRQ_MAX - IRQ_MIN + 1)
-
-/*
- * The following is set up by wd7000_detect, and used thereafter by
- * wd7000_intr_handle to map the irq level to the corresponding Adapter.
- * Note that if SA_INTERRUPT is not used, wd7000_intr_handle must be
- * changed to pick up the IRQ level correctly.
- */
-static struct Scsi_Host *wd7000_host[IRQS];
+ 
+#define UNITS	8
+static struct Scsi_Host *wd7000_host[UNITS];
 
 #define BUS_ON    64	/* x 125ns = 8000ns (BIOS default) */
 #define BUS_OFF   15	/* x 125ns = 1875ns (BIOS default) */
@@ -580,6 +586,7 @@
 static Scb scbs[MAX_SCBS];
 static Scb *scbfree;		/* free list         */
 static int freescbs = MAX_SCBS;	/* free list counter */
+static spinlock_t scbpool_lock; /* guards the scb free list and count */
 
 /*
  *  END of data/declarations - code follows.
@@ -621,16 +628,16 @@
 	(void)get_options(str, ARRAY_SIZE(ints), ints);
 
 	if (wd7000_card_num >= NUM_CONFIGS) {
-		printk(KERN_ERR __FUNCTION__
-			": Too many \"wd7000=\" configurations in "
-			"command line!\n");
+		printk(KERN_ERR
+			"%s: Too many \"wd7000=\" configurations in "
+			"command line!\n", __FUNCTION__);
 		return 0;
 	}
 
 	if ((ints[0] < 3) || (ints[0] > 5)) {
-		printk(KERN_ERR __FUNCTION__ ": Error in command line!  "
+		printk(KERN_ERR "%s: Error in command line!  "
 			"Usage: wd7000=<IRQ>,<DMA>,IO>[,<BUS_ON>"
-			"[,<BUS_OFF>]]\n");
+			"[,<BUS_OFF>]]\n", __FUNCTION__);
 	} else {
 		for (i = 0; i < NUM_IRQS; i++)
 			if (ints[1] == wd7000_irq[i])
@@ -812,14 +819,6 @@
 }
 
 
-static inline void delay (unsigned how_long)
-{
-    register unsigned long time = jiffies + how_long;
-
-    while (time_before(jiffies, time));
-}
-
-
 static inline int command_out (Adapter * host, unchar * cmd, int len)
 {
     if (!WAIT (host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
@@ -853,43 +852,44 @@
  */
 static inline Scb *alloc_scbs(struct Scsi_Host *host, int needed)
 {
-    register Scb *scb, *p;
+    register Scb *scb, *p = NULL;
     register unsigned long flags;
     register unsigned long timeout = jiffies + WAITnexttimeout;
     register unsigned long now;
-    static int busy = 0;
     int i;
 
     if (needed <= 0)
 	return (NULL);		/* sanity check */
 
-    save_flags (flags);
-    cli ();
-    while (busy) {		/* someone else is allocating */
-	spin_unlock_irq(host->host_lock);
-	for (now = jiffies; now == jiffies; );	/* wait a jiffy */
-	spin_lock_irq(host->host_lock);
-    }
-    busy = 1;			/* not busy now; it's our turn */
-
+    spin_unlock_irq(host->host_lock);
+	
+retry:
     while (freescbs < needed) {
 	timeout = jiffies + WAITnexttimeout;
 	do {
-	    spin_unlock_irq(host->host_lock);
-	    for (now = jiffies; now == jiffies; );	/* wait a jiffy */
-	    spin_lock_irq(host->host_lock);
+	    /* FIXME: can we actually just yield here ?? */
+	    for (now = jiffies; now == jiffies; )
+	    	cpu_relax();	/* wait a jiffy */
 	} while (freescbs < needed && time_before_eq(jiffies, timeout));
 	/*
 	 *  If we get here with enough free Scbs, we can take them.
 	 *  Otherwise, we timed out and didn't get enough.
 	 */
 	if (freescbs < needed) {
-	    busy = 0;
 	    printk (KERN_ERR "wd7000: can't get enough free SCBs.\n");
-	    restore_flags (flags);
+	    spin_unlock_irq(host->host_lock);
 	    return (NULL);
 	}
     }
+
+    /* Take the lock, then check we didnt get beaten, if so try again */
+    spin_lock_irqsave(&scbpool_lock, flags);
+    if(freescbs < needed)
+    {
+    	spin_unlock_irqrestore(&scbpool_lock, flags);
+    	goto retry;
+    }
+    	
     scb = scbfree;
     freescbs -= needed;
     for (i = 0; i < needed; i++) {
@@ -897,10 +897,10 @@
 	scbfree = p->next;
     }
     p->next = NULL;
-    busy = 0;			/* we're done */
-
-    restore_flags (flags);
+   
+    spin_unlock_irqrestore(&scbpool_lock, flags);
 
+    spin_lock_irq(host->host_lock);
     return (scb);
 }
 
@@ -909,26 +909,25 @@
 {
     register unsigned long flags;
 
-    save_flags (flags);
-    cli ();
+    spin_lock_irqsave(&scbpool_lock, flags);
 
     memset (scb, 0, sizeof (Scb));
     scb->next = scbfree;
     scbfree = scb;
     freescbs++;
 
-    restore_flags (flags);
+    spin_unlock_irqrestore(&scbpool_lock, flags);
 }
 
 
 static inline void init_scbs (void)
 {
     int i;
-    unsigned long flags;
 
-    save_flags (flags);
-    cli ();
+    spin_lock_init(&scbpool_lock);
 
+    /* This is only ever called before the SCB pool is active */
+    
     scbfree = &(scbs[0]);
     memset (scbs, 0, sizeof (scbs));
     for (i = 0; i < MAX_SCBS - 1; i++) {
@@ -937,8 +936,6 @@
     }
     scbs[MAX_SCBS - 1].next = NULL;
     scbs[MAX_SCBS - 1].SCpnt = NULL;
-
-    restore_flags (flags);
 }
 
 
@@ -956,8 +953,7 @@
     dprintk("wd7000_mail_out: 0x%06lx", (long) scbptr);
 
     /* We first look for a free outgoing mailbox */
-    save_flags (flags);
-    cli ();
+    spin_lock_irqsave(host->sh->host_lock, flags);
     ogmb = *next_ogmb;
     for (i = 0; i < OGMB_CNT; i++) {
 	if (ogmbs[ogmb].status == 0) {
@@ -971,8 +967,8 @@
 	else
 	    ogmb = (ogmb + 1) % OGMB_CNT;
     }
-    restore_flags (flags);
-
+    spin_unlock_irqrestore(host->sh->host_lock, flags);
+    
     dprintk(", scb is 0x%06lx", (long) scbptr);
 
     if (i >= OGMB_CNT) {
@@ -999,7 +995,7 @@
 }
 
 
-int make_code (unsigned hosterr, unsigned scsierr)
+static int make_code (unsigned hosterr, unsigned scsierr)
 {
 #ifdef WD7000_DEBUG
     int in_error = hosterr;
@@ -1056,14 +1052,14 @@
 
 #define wd7000_intr_ack(host)   outb (0, host->iobase + ASC_INTR_ACK)
 
-void wd7000_intr_handle (int irq, void *dev_id, struct pt_regs *regs)
+static void wd7000_intr_handle (int irq, void *dev_id, struct pt_regs *regs)
 {
     register int flag, icmb, errstatus, icmb_status;
     register int host_error, scsi_error;
     register Scb *scb;		/* for SCSI commands */
     register IcbAny *icb;	/* for host commands */
     register Scsi_Cmnd *SCpnt;
-    Adapter *host = (Adapter *) wd7000_host[irq - IRQ_MIN]->hostdata;	/* This MUST be set!!! */
+    Adapter *host = (Adapter *)dev_id;
     Mailbox *icmbs = host->mb.icmb;
 
     host->int_counter++;
@@ -1139,7 +1135,7 @@
     dprintk("wd7000_intr_handle: return from interrupt handler\n");
 }
 
-void do_wd7000_intr_handle (int irq, void *dev_id, struct pt_regs *regs)
+static void do_wd7000_intr_handle (int irq, void *dev_id, struct pt_regs *regs)
 {
     unsigned long flags;
     struct Scsi_Host *host = dev_id;
@@ -1150,7 +1146,7 @@
 }
 
 
-int wd7000_queuecommand (Scsi_Cmnd *SCpnt, void (*done) (Scsi_Cmnd *))
+static int wd7000_queuecommand (Scsi_Cmnd *SCpnt, void (*done) (Scsi_Cmnd *))
 {
     register Scb *scb;
     register Sgb *sgb;
@@ -1197,25 +1193,31 @@
 	any2scsi (scb->dataptr, isa_virt_to_bus(SCpnt->request_buffer));
 	any2scsi (scb->maxlen, SCpnt->request_bufflen);
     }
+    
+    /* FIXME: drop lock and yield here ? */
 
-    while (!mail_out (host, scb));	/* keep trying */
+    while (!mail_out (host, scb))
+    	cpu_relax();	/* keep trying */
 
-    return (1);
+    return 0;
 }
 
 
-int wd7000_command (Scsi_Cmnd *SCpnt)
+static int wd7000_command (Scsi_Cmnd *SCpnt)
 {
     wd7000_queuecommand (SCpnt, wd7000_scsi_done);
 
     while (SCpnt->SCp.phase > 0)
-	barrier ();		/* phase counts scbs down to 0 */
+    {
+    	cpu_relax();
+	barrier();		/* phase counts scbs down to 0 */
+    }
 
     return (SCpnt->result);
 }
 
 
-int wd7000_diagnostics (Adapter *host, int code)
+static int wd7000_diagnostics (Adapter *host, int code)
 {
     static IcbDiag icb = {ICB_OP_DIAGNOSTICS};
     static unchar buf[256];
@@ -1233,7 +1235,10 @@
     mail_out (host, (struct scb *) &icb);
     timeout = jiffies + WAITnexttimeout;	/* wait up to 2 seconds */
     while (icb.phase && time_before(jiffies, timeout))
-	barrier ();		/* wait for completion */
+    {
+	cpu_relax();		/* wait for completion */
+	barrier();
+    }
 
     if (icb.phase) {
 	printk ("wd7000_diagnostics: timed out.\n");
@@ -1249,7 +1254,7 @@
 }
 
 
-int wd7000_init (Adapter *host)
+static int wd7000_adapter_reset(Adapter *host)
 {
     InitCmd init_cmd =
     {
@@ -1263,19 +1268,18 @@
 	ICMB_CNT
     };
     int diag;
-
     /*
      *  Reset the adapter - only.  The SCSI bus was initialized at power-up,
      *  and we need to do this just so we control the mailboxes, etc.
      */
     outb (ASC_RES, host->iobase + ASC_CONTROL);
-    delay (1);			/* reset pulse: this is 10ms, only need 25us */
+    udelay(40);			/* reset pulse: this is 40us, only need 25us */
     outb (0, host->iobase + ASC_CONTROL);
     host->control = 0;		/* this must always shadow ASC_CONTROL */
 
     if (WAIT (host->iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
 	printk ("wd7000_init: WAIT timed out.\n");
-	return (0);		/* 0 = not ok */
+	return -1;		/* -1 = not ok */
     }
 
     if ((diag = inb (host->iobase + ASC_INTR_STAT)) != 1) {
@@ -1296,31 +1300,38 @@
 		     break;
 	    default: printk ("diagnostic code 0x%02Xh received.\n", diag);
 	}
-	return (0);
+	return -1;
     }
-
-    /* Clear mailboxes */
+   /* Clear mailboxes */
     memset (&(host->mb), 0, sizeof (host->mb));
 
     /* Execute init command */
     any2scsi ((unchar *) & (init_cmd.mailboxes), (int) &(host->mb));
     if (!command_out (host, (unchar *) &init_cmd, sizeof (init_cmd))) {
-	printk ("wd7000_init: adapter initialization failed.\n");
-	return (0);
+	printk (KERN_ERR "wd7000_adapter_reset: adapter initialization failed.\n");
+	return -1;
     }
 
     if (WAIT (host->iobase + ASC_STAT, ASC_STATMASK, ASC_INIT, 0)) {
-	printk ("wd7000_init: WAIT timed out.\n");
-	return (0);
+	printk ("wd7000_adapter_reset: WAIT timed out.\n");
+	return -1;
     }
+    return 0;
+}
 
-    if (request_irq (host->irq, do_wd7000_intr_handle, SA_INTERRUPT, "wd7000", NULL)) {
+static int wd7000_init (Adapter *host)
+{
+    if(wd7000_adapter_reset(host) == -1)
+    	return 0;
+
+ 
+    if (request_irq (host->irq, do_wd7000_intr_handle, SA_INTERRUPT, "wd7000", host)) {
 	printk ("wd7000_init: can't get IRQ %d.\n", host->irq);
 	return (0);
     }
     if (request_dma (host->dma, "wd7000")) {
 	printk ("wd7000_init: can't get DMA channel %d.\n", host->dma);
-	free_irq (host->irq, NULL);
+	free_irq (host->irq, host);
 	return (0);
     }
     wd7000_enable_dma (host);
@@ -1336,7 +1347,7 @@
 }
 
 
-void wd7000_revision (Adapter *host)
+static void wd7000_revision (Adapter *host)
 {
     static IcbRevLvl icb =
     {ICB_OP_GET_REVISION};
@@ -1350,7 +1361,10 @@
      */
     mail_out (host, (struct scb *) &icb);
     while (icb.phase)
-	barrier ();		/* wait for completion */
+    {
+	cpu_relax();		/* wait for completion */
+	barrier();
+    }
     host->rev1 = icb.primary;
     host->rev2 = icb.secondary;
 }
@@ -1359,27 +1373,19 @@
 #undef SPRINTF
 #define SPRINTF(args...) { if (pos < (buffer + length)) pos += sprintf (pos, ## args); }
 
-int wd7000_set_info (char *buffer, int length, struct Scsi_Host *host)
+static int wd7000_set_info (char *buffer, int length, struct Scsi_Host *host)
 {
-    unsigned long flags;
-
-    save_flags (flags);
-    cli ();
-
     dprintk("Buffer = <%.*s>, length = %d\n", length, buffer, length);
 
     /*
      * Currently this is a no-op
      */
     dprintk("Sorry, this function is currently out of order...\n");
-
-    restore_flags (flags);
-
     return (length);
 }
 
 
-int wd7000_proc_info (char *buffer, char **start, off_t offset, int length, int hostno, int inout)
+static int wd7000_proc_info (char *buffer, char **start, off_t offset, int length, int hostno, int inout)
 {
     struct Scsi_Host *host = NULL;
     Scsi_Device *scd;
@@ -1396,7 +1402,7 @@
     /*
      * Find the specified host board.
      */
-    for (i = 0; i < IRQS; i++)
+    for (i = 0; i < UNITS; i++)
 	if (wd7000_host[i] && (wd7000_host[i]->host_no == hostno)) {
 	    host = wd7000_host[i];
 
@@ -1417,9 +1423,7 @@
 
     adapter = (Adapter *) host->hostdata;
 
-    save_flags (flags);
-    cli ();
-
+    spin_lock_irqsave(host->host_lock, flags);
     SPRINTF ("Host scsi%d: Western Digital WD-7000 (rev %d.%d)\n", hostno, adapter->rev1, adapter->rev2);
     SPRINTF ("  IO base:      0x%x\n", adapter->iobase);
     SPRINTF ("  IRQ:          %d\n", adapter->irq);
@@ -1484,7 +1488,7 @@
 
     SPRINTF ("\n");
 
-    restore_flags (flags);
+    spin_unlock_irqrestore(host->host_lock, flags);
 
     /*
      * Calculate start of next buffer, and return value.
@@ -1510,13 +1514,15 @@
  *  calling scsi_unregister.
  *
  */
-int wd7000_detect (Scsi_Host_Template *tpnt)
+
+static int wd7000_detect (Scsi_Host_Template *tpnt)
 {
     short present = 0, biosaddr_ptr, sig_ptr, i, pass;
     short biosptr[NUM_CONFIGS];
     unsigned iobase;
     Adapter *host = NULL;
     struct Scsi_Host *sh;
+    int unit = 0;
 
     dprintk("wd7000_detect: started\n");
 
@@ -1525,7 +1531,7 @@
 		wd7000_setup(wd7000);     
 #endif
 
-    for (i = 0; i < IRQS; wd7000_host[i++] = NULL) ;
+    for (i = 0; i < UNITS; wd7000_host[i++] = NULL) ;
     for (i = 0; i < NUM_CONFIGS; biosptr[i++] = -1) ;
 
     tpnt->proc_name = "wd7000";
@@ -1579,6 +1585,9 @@
 
 	if (configs[pass].irq < 0)
 	    continue;
+	    
+	if (unit == UNITS)
+	    continue;
 
 	iobase = configs[pass].iobase;
 
@@ -1591,7 +1600,8 @@
 	     * ASC reset...
 	     */
 	    outb (ASC_RES, iobase + ASC_CONTROL);
-	    delay (1);
+	    set_current_state(TASK_UNINTERRUPTIBLE);
+	    schedule_timeout(HZ/100);
 	    outb (0, iobase + ASC_CONTROL);
 
 	    if (WAIT (iobase + ASC_STAT, ASC_STATMASK, CMD_RDY, 0)) {
@@ -1624,7 +1634,8 @@
 		host->int_counter = 0;
 		host->bus_on = configs[pass].bus_on;
 		host->bus_off = configs[pass].bus_off;
-		host->sh = wd7000_host[host->irq - IRQ_MIN] = sh;
+		host->sh = wd7000_host[unit] = sh;
+		unit++;
 
 		dprintk("wd7000_detect: Trying init WD-7000 card at IO "
 			"0x%x, IRQ %d, DMA %d...\n",
@@ -1649,7 +1660,7 @@
 		if (biosaddr_ptr != NUM_ADDRS)
 		    biosptr[pass] = biosaddr_ptr;
 
-		printk ("Western Digital WD-7000 (rev %d.%d) ",
+		printk (KERN_INFO "Western Digital WD-7000 (rev %d.%d) ",
 			host->rev1, host->rev2);
 		printk ("using IO 0x%x, IRQ %d, DMA %d.\n",
 			host->iobase, host->irq, host->dma);
@@ -1679,34 +1690,53 @@
 /*
  *  I have absolutely NO idea how to do an abort with the WD7000...
  */
-int wd7000_abort (Scsi_Cmnd *SCpnt)
+static int wd7000_abort (Scsi_Cmnd *SCpnt)
 {
     Adapter *host = (Adapter *) SCpnt->host->hostdata;
 
     if (inb (host->iobase + ASC_STAT) & INT_IM) {
 	printk ("wd7000_abort: lost interrupt\n");
 	wd7000_intr_handle (host->irq, NULL, NULL);
-
-	return (SCSI_ABORT_SUCCESS);
+	return FAILED;
     }
-
-    return (SCSI_ABORT_SNOOZE);
+    return FAILED;
 }
 
 
 /*
  *  I also have no idea how to do a reset...
  */
-int wd7000_reset (Scsi_Cmnd *SCpnt, unsigned int unused)
+
+static int wd7000_bus_reset (Scsi_Cmnd *SCpnt)
 {
-    return (SCSI_RESET_PUNT);
+    return FAILED;
+}
+
+static int wd7000_device_reset (Scsi_Cmnd *SCpnt)
+{
+    return FAILED;
+}
+
+/*
+ *  Last resort. Reinitialize the board.
+ */
+ 
+static int wd7000_host_reset (Scsi_Cmnd *SCpnt)
+{
+    Adapter *host = (Adapter *) SCpnt->host->hostdata;
+    
+    if(wd7000_adapter_reset(host)<0)
+	    return FAILED;
+    wd7000_enable_intr (host);
+    return SUCCESS;
 }
 
 
 /*
  *  This was borrowed directly from aha1542.c. (Zaga)
  */
-int wd7000_biosparam (Disk *disk, struct block_device *bdev, int *ip)
+
+static int wd7000_biosparam (Disk *disk, struct block_device *bdev, int *ip)
 {
     dprintk("wd7000_biosparam: dev=%s, size=%d, ", bdevname(bdev),
 	    disk->capacity);
@@ -1743,8 +1773,8 @@
 	    ip[2] = info[2];
 
 	    if (info[0] == 255)
-		printk(KERN_INFO __FUNCTION__ ": current partition table is "
-			"using extended translation.\n");
+		printk(KERN_INFO "%s: current partition table is "
+			"using extended translation.\n", __FUNCTION__);
 	}
     }
 
@@ -1754,6 +1784,8 @@
     return (0);
 }
 
+MODULE_AUTHOR("Thomas Wuensche, John Boyd, Miroslav Zagorac");
+MODULE_DESCRIPTION("Driver for the WD7000 series ISA controllers");
 MODULE_LICENSE("GPL");
 
 /* Eventually this will go into an include file, but this will be later */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/scsi/wd7000.h linux.2.5.40-ac5/drivers/scsi/wd7000.h
--- linux.2.5.40/drivers/scsi/wd7000.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.40-ac5/drivers/scsi/wd7000.h	2002-10-06 01:05:29.000000000 +0100
@@ -13,14 +13,16 @@
 
 #include <linux/types.h>
 
-int wd7000_set_info (char *buffer, int length, struct Scsi_Host *host);
-int wd7000_proc_info (char *buffer, char **start, off_t offset, int length, int hostno, int inout);
-int wd7000_detect (Scsi_Host_Template *);
-int wd7000_command (Scsi_Cmnd *);
-int wd7000_queuecommand (Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd7000_abort (Scsi_Cmnd *);
-int wd7000_reset (Scsi_Cmnd *, unsigned int);
-int wd7000_biosparam (Disk *, struct block_device *, int *);
+static int wd7000_set_info (char *buffer, int length, struct Scsi_Host *host);
+static int wd7000_proc_info (char *buffer, char **start, off_t offset, int length, int hostno, int inout);
+static int wd7000_detect (Scsi_Host_Template *);
+static int wd7000_command (Scsi_Cmnd *);
+static int wd7000_queuecommand (Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+static int wd7000_abort (Scsi_Cmnd *);
+static int wd7000_bus_reset (Scsi_Cmnd *);
+static int wd7000_host_reset (Scsi_Cmnd *);
+static int wd7000_device_reset (Scsi_Cmnd *);
+static int wd7000_biosparam (Disk *, struct block_device *, int *);
 
 #ifndef NULL
 #define NULL 0L
@@ -48,7 +50,9 @@
 	command:		wd7000_command,			\
 	queuecommand:		wd7000_queuecommand,		\
 	abort:			wd7000_abort,			\
-	reset:			wd7000_reset,			\
+	eh_bus_reset_handler:	wd7000_bus_reset,		\
+	eh_device_reset_handler:wd7000_device_reset,		\
+	eh_host_reset_handler:	wd7000_host_reset,		\
 	bios_param:		wd7000_biosparam,		\
 	can_queue:		WD7000_Q,			\
 	this_id:		7,				\
