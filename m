Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262204AbSJISZj>; Wed, 9 Oct 2002 14:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262293AbSJISZi>; Wed, 9 Oct 2002 14:25:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34309 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262204AbSJISZa>; Wed, 9 Oct 2002 14:25:30 -0400
Subject: PATCH: first pass over the in2000
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Wed, 9 Oct 2002 19:22:38 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17zLTi-0006Kw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- new locking
- new_eh
- use ->page/->offset

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/in2000.c linux.2.5.41-ac2/drivers/scsi/in2000.c
--- linux.2.5.41/drivers/scsi/in2000.c	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac2/drivers/scsi/in2000.c	2002-10-09 16:23:17.000000000 +0100
@@ -317,13 +317,15 @@
 
 static void in2000_execute(struct Scsi_Host *instance);
 
-int in2000_queuecommand (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
+static int in2000_queuecommand (Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
 {
+struct Scsi_Host *instance;
 struct IN2000_hostdata *hostdata;
 Scsi_Cmnd *tmp;
 unsigned long flags;
 
-   hostdata = (struct IN2000_hostdata *)cmd->host->hostdata;
+   instance = cmd->host;
+   hostdata = (struct IN2000_hostdata *)instance->hostdata;
 
 DB(DB_QUEUE_COMMAND,printk("Q-%d-%02x-%ld(",cmd->target,cmd->cmnd[0],cmd->pid))
 
@@ -355,7 +357,7 @@
    if (cmd->use_sg) {
       cmd->SCp.buffer = (struct scatterlist *)cmd->buffer;
       cmd->SCp.buffers_residual = cmd->use_sg - 1;
-      cmd->SCp.ptr = (char *)cmd->SCp.buffer->address;
+      cmd->SCp.ptr = (char *)page_address(cmd->SCp.buffer->page)+cmd->SCp.buffer->offset;
       cmd->SCp.this_residual = cmd->SCp.buffer->length;
       }
    else {
@@ -391,9 +393,7 @@
  * queue and calling in2000_execute().
  */
 
-   save_flags(flags);
-   cli();
-
+   spin_lock_irqsave(instance->host_lock, flags);
    /*
     * Add the cmd to the end of 'input_Q'. Note that REQUEST_SENSE
     * commands are added to the head of the queue so that the desired
@@ -418,8 +418,7 @@
    in2000_execute(cmd->host);
 
 DB(DB_QUEUE_COMMAND,printk(")Q-%ld ",cmd->pid))
-
-   restore_flags(flags);
+   spin_unlock_irqrestore(instance->host_lock, flags);
    return 0;
 }
 
@@ -762,7 +761,7 @@
       ++cmd->SCp.buffer;
       --cmd->SCp.buffers_residual;
       cmd->SCp.this_residual = cmd->SCp.buffer->length;
-      cmd->SCp.ptr = cmd->SCp.buffer->address;
+      cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
       }
 
 /* Set up hardware registers */
@@ -855,7 +854,7 @@
 
 /* Get the spin_lock and disable further ints, for SMP */
 
-   CLISPIN_LOCK(instance, flags);
+   spin_lock_irqsave(instance->host_lock, flags);
 
 #ifdef PROC_STATISTICS
    hostdata->int_cnt++;
@@ -993,7 +992,7 @@
       write1_io(0, IO_LED_OFF);
 
 /* release the SMP spin_lock and restore irq state */
-      CLISPIN_UNLOCK(instance, flags);
+      spin_unlock_irqrestore(instance->host_lock, flags);
       return;
       }
 
@@ -1011,7 +1010,7 @@
       write1_io(0, IO_LED_OFF);
 
 /* release the SMP spin_lock and restore irq state */
-      CLISPIN_UNLOCK(instance, flags);
+      spin_unlock_irqrestore(instance->host_lock, flags);
       return;
       }
 
@@ -1433,7 +1432,7 @@
             hostdata->state = S_UNCONNECTED;
 
 /* release the SMP spin_lock and restore irq state */
-            CLISPIN_UNLOCK(instance, flags);
+            spin_unlock_irqrestore(instance->host_lock, flags);
             return;
             }
 DB(DB_INTR,printk("UNEXP_DISC-%ld",cmd->pid))
@@ -1609,7 +1608,7 @@
 DB(DB_INTR,printk("} "))
 
 /* release the SMP spin_lock and restore irq state */
-   CLISPIN_UNLOCK(instance, flags);
+   spin_unlock_irqrestore(instance->host_lock, flags);
 
 }
 
@@ -1619,11 +1618,14 @@
 #define RESET_CARD_AND_BUS 1
 #define B_FLAG 0x80
 
+/*
+ *	Caller must hold instance lock!
+ */
+ 
 static int reset_hardware(struct Scsi_Host *instance, int type)
 {
 struct IN2000_hostdata *hostdata;
 int qt,x;
-unsigned long flags;
 
    hostdata = (struct IN2000_hostdata *)instance->hostdata;
 
@@ -1638,16 +1640,16 @@
    write_3393(hostdata,WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_POLLED);
    write_3393(hostdata,WD_SYNCHRONOUS_TRANSFER,
               calc_sync_xfer(hostdata->default_sx_per/4,DEFAULT_SX_OFF));
-   save_flags(flags);
-   cli();
+
    write1_io(0,IO_FIFO_WRITE);            /* clear fifo counter */
    write1_io(0,IO_FIFO_READ);             /* start fifo out in read mode */
    write_3393(hostdata,WD_COMMAND, WD_CMD_RESET);
+   /* FIXME: timeout ?? */
    while (!(READ_AUX_STAT() & ASR_INT))
-      ;                                   /* wait for RESET to complete */
+      cpu_relax();                           /* wait for RESET to complete */
 
    x = read_3393(hostdata,WD_SCSI_STATUS);   /* clear interrupt */
-   restore_flags(flags);
+
    write_3393(hostdata,WD_QUEUE_TAG,0xa5);   /* any random number */
    qt = read_3393(hostdata,WD_QUEUE_TAG);
    if (qt == 0xa5) {
@@ -1662,7 +1664,7 @@
 
 
 
-int in2000_reset(Scsi_Cmnd *cmd, unsigned int reset_flags)
+static int in2000_bus_reset(Scsi_Cmnd *cmd)
 {
 unsigned long flags;
 struct Scsi_Host *instance;
@@ -1672,10 +1674,9 @@
    instance = cmd->host;
    hostdata = (struct IN2000_hostdata *)instance->hostdata;
 
-   printk("scsi%d: Reset. ", instance->host_no);
-   save_flags(flags);
-   cli();
+   printk(KERN_WARNING "scsi%d: Reset. ", instance->host_no);
 
+   spin_lock_irqsave(instance->host_lock, flags);
    /* do scsi-reset here */
 
    reset_hardware(instance, RESET_CARD_AND_BUS);
@@ -1694,13 +1695,22 @@
    hostdata->outgoing_len = 0;
 
    cmd->result = DID_RESET << 16;
-   restore_flags(flags);
-   return 0;
+   spin_unlock_irqrestore(instance->host_lock, flags);
+   return SUCCESS;
 }
 
+static int in2000_host_reset(Scsi_Cmnd *cmd)
+{
+	return FAILED;
+}
 
+static int in2000_device_reset(Scsi_Cmnd *cmd)
+{
+	return FAILED;
+}
 
-int in2000_abort (Scsi_Cmnd *cmd)
+
+static int in2000_abort (Scsi_Cmnd *cmd)
 {
 struct Scsi_Host *instance;
 struct IN2000_hostdata *hostdata;
@@ -1709,13 +1719,10 @@
 uchar sr, asr;
 unsigned long timeout;
 
-   save_flags (flags);
-   cli();
-
    instance = cmd->host;
    hostdata = (struct IN2000_hostdata *)instance->hostdata;
 
-   printk ("scsi%d: Abort-", instance->host_no);
+   printk(KERN_DEBUG "scsi%d: Abort-", instance->host_no);
    printk("(asr=%02x,count=%ld,resid=%d,buf_resid=%d,have_data=%d,FC=%02x)- ",
             READ_AUX_STAT(),read_3393_count(hostdata),cmd->SCp.this_residual,cmd->SCp.buffers_residual,
             cmd->SCp.have_data_in,read1_io(IO_FIFO_COUNT));
@@ -1725,6 +1732,7 @@
  *     from the inout_Q.
  */
 
+   spin_lock_irqsave(instance->host_lock, flags);
    tmp = (Scsi_Cmnd *)hostdata->input_Q;
    prev = 0;
    while (tmp) {
@@ -1733,11 +1741,11 @@
             prev->host_scribble = cmd->host_scribble;
          cmd->host_scribble = NULL;
          cmd->result = DID_ABORT << 16;
-         printk("scsi%d: Abort - removing command %ld from input_Q. ",
+         printk(KERN_WARNING "scsi%d: Abort - removing command %ld from input_Q. ",
            instance->host_no, cmd->pid);
          cmd->scsi_done(cmd);
-         restore_flags(flags);
-         return SCSI_ABORT_SUCCESS;
+         spin_unlock_irqrestore(instance->host_lock, flags);
+         return SUCCESS;
          }
       prev = tmp;
       tmp = (Scsi_Cmnd *)tmp->host_scribble;
@@ -1756,7 +1764,7 @@
 
    if (hostdata->connected == cmd) {
 
-      printk("scsi%d: Aborting connected command %ld - ",
+      printk(KERN_WARNING "scsi%d: Aborting connected command %ld - ",
               instance->host_no, cmd->pid);
 
       printk("sending wd33c93 ABORT command - ");
@@ -1800,7 +1808,6 @@
 
       in2000_execute (instance);
 
-      restore_flags(flags);
       return SCSI_ABORT_SUCCESS;
       }
 
@@ -1813,9 +1820,9 @@
    for (tmp=(Scsi_Cmnd *)hostdata->disconnected_Q; tmp;
          tmp=(Scsi_Cmnd *)tmp->host_scribble)
       if (cmd == tmp) {
-         restore_flags(flags);
-         printk("Sending ABORT_SNOOZE. ");
-         return SCSI_ABORT_SNOOZE;
+	 spin_unlock_irqrestore(instance->host_lock, flags);
+	 printk(KERN_DEBUG "scsi%d: unable to abort disconnected command.\n", instance->host_no);
+         return FAILED;
          }
 
 /*
@@ -1830,10 +1837,10 @@
 
    in2000_execute (instance);
 
-   restore_flags(flags);
+   spin_unlock_irqrestore(instance->host_lock, flags);
    printk("scsi%d: warning : SCSI command probably completed successfully"
       "         before abortion. ", instance->host_no);
-   return SCSI_ABORT_NOT_RUNNING;
+   return SUCCESS;
 }
 
 
@@ -1845,7 +1852,7 @@
 static char setup_used[MAX_SETUP_ARGS];
 static int done_setup = 0;
 
-void __init in2000_setup (char *str, int *ints)
+static void __init in2000_setup (char *str, int *ints)
 {
 int i;
 char *p1,*p2;
@@ -1931,7 +1938,7 @@
    };
 
 
-int __init in2000_detect(Scsi_Host_Template * tpnt)
+static int __init in2000_detect(Scsi_Host_Template * tpnt)
 {
 struct Scsi_Host *instance;
 struct IN2000_hostdata *hostdata;
@@ -2115,7 +2122,11 @@
 #endif
 
 
+      /* FIXME: not strictly needed I think but the called code expects
+         to be locked */
+      spin_lock_irqsave(instance->host_lock, flags);
       x = reset_hardware(instance,(hostdata->args & A_NO_SCSI_RESET)?RESET_CARD:RESET_CARD_AND_BUS);
+      spin_unlock_irqrestore(instance->host_lock, flags);
 
       hostdata->microcode = read_3393(hostdata,WD_CDB_1);
       if (x & 0x01) {
@@ -2158,7 +2169,7 @@
  *       supposed to do...
  */
 
-int in2000_biosparam(Disk *disk, struct block_device *dev, int *iinfo)
+static int in2000_biosparam(Disk *disk, struct block_device *dev, int *iinfo)
 {
 int size;
 
@@ -2190,7 +2201,7 @@
 }
 
 
-int in2000_proc_info(char *buf, char **start, off_t off, int len, int hn, int in)
+static int in2000_proc_info(char *buf, char **start, off_t off, int len, int hn, int in)
 {
 
 #ifdef PROC_INTERFACE
@@ -2260,8 +2271,7 @@
       return len;
       }
 
-   save_flags(flags);
-   cli();
+   spin_lock_irqsave(instance->host_lock, flags);
    bp = buf;
    *bp = '\0';
    if (hd->proc & PR_VERSION) {
@@ -2340,7 +2350,7 @@
       ;  /* insert your own custom function here */
       }
    strcat(bp,"\n");
-   restore_flags(flags);
+   spin_unlock_irqrestore(instance->host_lock, flags);
    *start = buf;
    if (stop) {
       stop = 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/in2000.h linux.2.5.41-ac2/drivers/scsi/in2000.h
--- linux.2.5.41/drivers/scsi/in2000.h	2002-10-02 21:32:55.000000000 +0100
+++ linux.2.5.41-ac2/drivers/scsi/in2000.h	2002-10-09 16:17:42.000000000 +0100
@@ -397,13 +397,15 @@
 # define CLISPIN_UNLOCK(host,flags) spin_unlock_irqrestore(host->host_lock, \
 							   flags)
 
-int in2000_detect(Scsi_Host_Template *) in2000__INIT;
-int in2000_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int in2000_abort(Scsi_Cmnd *);
-void in2000_setup(char *, int *) in2000__INIT;
-int in2000_proc_info(char *, char **, off_t, int, int, int);
-int in2000_biosparam(struct scsi_disk *, struct block_device *, int *);
-int in2000_reset(Scsi_Cmnd *, unsigned int);
+static int in2000_detect(Scsi_Host_Template *) in2000__INIT;
+static int in2000_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+static int in2000_abort(Scsi_Cmnd *);
+static void in2000_setup(char *, int *) in2000__INIT;
+static int in2000_proc_info(char *, char **, off_t, int, int, int);
+static int in2000_biosparam(struct scsi_disk *, struct block_device *, int *);
+static int in2000_host_reset(Scsi_Cmnd *);
+static int in2000_bus_reset(Scsi_Cmnd *);
+static int in2000_device_reset(Scsi_Cmnd *);
 
 
 #define IN2000_CAN_Q    16
@@ -411,19 +413,21 @@
 #define IN2000_CPL      2
 #define IN2000_HOST_ID  7
 
-#define IN2000 {  proc_name:       "in2000",		/* name of /proc/scsi directory entry */ \
-                  proc_info:       in2000_proc_info,    /* pointer to proc info function */ \
-                  name:            "Always IN2000",     /* device name */ \
-                  detect:          in2000_detect,       /* returns number of in2000's found */ \
-                  queuecommand:    in2000_queuecommand, /* queue scsi command, don't wait */ \
-                  abort:           in2000_abort,        /* abort current command */ \
-                  reset:           in2000_reset,        /* reset scsi bus */ \
-                  bios_param:      in2000_biosparam,    /* figures out BIOS parameters for lilo, etc */ \
-                  can_queue:       IN2000_CAN_Q,        /* max commands we can queue up */ \
-                  this_id:         IN2000_HOST_ID,      /* host-adapter scsi id */ \
-                  sg_tablesize:    IN2000_SG,           /* scatter-gather table size */ \
-                  cmd_per_lun:     IN2000_CPL,          /* commands per lun */ \
-                  use_clustering:  DISABLE_CLUSTERING,  /* ENABLE_CLUSTERING may speed things up */ \
+#define IN2000 {  proc_name:       		"in2000",	     /* name of /proc/scsi directory entry */ \
+                  proc_info:       		in2000_proc_info,    /* pointer to proc info function */ \
+                  name:            		"Always IN2000",     /* device name */ \
+                  detect:          		in2000_detect,       /* returns number of in2000's found */ \
+                  queuecommand:    		in2000_queuecommand, /* queue scsi command, don't wait */ \
+                  eh_abort_handler:		in2000_abort,        /* abort current command */ \
+                  eh_bus_reset_handler:		in2000_bus_reset,    /* reset scsi bus */ \
+                  eh_device_reset_handler:	in2000_device_reset, /* reset scsi device */ \
+                  eh_host_reset_handler:	in2000_host_reset,   /* reset scsi hba */ \
+                  bios_param:      		in2000_biosparam,    /* figures out BIOS parameters for lilo, etc */ \
+                  can_queue:       		IN2000_CAN_Q,        /* max commands we can queue up */ \
+                  this_id:         		IN2000_HOST_ID,      /* host-adapter scsi id */ \
+                  sg_tablesize:    		IN2000_SG,           /* scatter-gather table size */ \
+                  cmd_per_lun:     		IN2000_CPL,          /* commands per lun */ \
+                  use_clustering:  		DISABLE_CLUSTERING,  /* ENABLE_CLUSTERING may speed things up */ \
                 }
 
 #endif /* IN2000_H */
