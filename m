Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289946AbSAKNPa>; Fri, 11 Jan 2002 08:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289944AbSAKNPK>; Fri, 11 Jan 2002 08:15:10 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:54927 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S289942AbSAKNO6>; Fri, 11 Jan 2002 08:14:58 -0500
Date: Fri, 11 Jan 2002 05:14:56 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Big patch: linux-2.5.2-pre11/drivers/scsi compilation fixes
Message-ID: <20020111051456.A12788@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Today I plan to post patches to make everything in
linux-2.5.2-pre11/drivers/scsi compile, at least everything under
x86, compiled as modules.  They compile, and, the only undefined
symbol in when I boot is scsi_mark_host_reset in BusLogic.c.
However, the 2.5.2-pre11 patches are completely untested.

	I have already delayed a day in trying to find time to
prepare patches individually with explanations, so, in the interest
of making the changes available quickly, here is a straight diff
from linux-2.5.2-pre11/drivers/scsi to my 2.5/drivers/scsi tree,
which should be handy for any driver maintainers who are kind
enough to catch my errors before I post them separately.

	A few notes about this big diff:

	1. In addition to the compilation fixes, these changes
	   also add all(?) missing pci_device_id tables.

	2. For some drivers, I needed to make some small changes
	   to facilitate the change from io_request_lock to host->host_lock,
	   mostly for interrupt handlers that may service multiple host
	   controllers in one call or that did not figure out which
	   host controller they were dealing with right away.  In a
	   couple of cases, I removed some locks which I think are
	   unnecessary, in one case switching to use of atomic_t.

	3. scsi_debug.c changes are incomplete in that they ifdef out
	   some checks that need to be ported to bio.

	Linus: unless I hear otherwise from you, I plan to repost these
changes in smaller sets with clearer explanations (although you're
welcome to apply this huge patch if you want).

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scsi.diffs"

diff -u linux-2.5.2-pre11/drivers/scsi/3w-xxxx.c linux/drivers/scsi/3w-xxxx.c
--- linux-2.5.2-pre11/drivers/scsi/3w-xxxx.c	Fri Nov  9 14:05:02 2001
+++ linux/drivers/scsi/3w-xxxx.c	Thu Jan 10 07:20:00 2002
@@ -128,6 +128,7 @@
 #include <linux/smp.h>
 #include <linux/reboot.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include <asm/errno.h>
 #include <asm/io.h>
@@ -142,6 +143,19 @@
 
 #include "3w-xxxx.h"
 
+#ifdef MODULE
+static struct pci_device_id tw_scsi_pci_tbl[] __initdata = {
+	{
+	  vendor: TW_VENDOR_ID,
+	  device: TW_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, tw_scsi_pci_tbl);
+#endif
+
 static int tw_copy_info(TW_Info *info, char *fmt, ...);
 static void tw_copy_mem_info(TW_Info *info, char *data, int len);
 static void tw_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
@@ -1326,7 +1340,7 @@
 	TW_Command *command_packet;
 	if (test_and_set_bit(TW_IN_INTR, &tw_dev->flags))
 		return;
-	spin_lock_irqsave(&io_request_lock, flags);
+	spin_lock_irqsave(&tw_dev->host->host_lock, flags);
 
 	if (tw_dev->tw_pci_dev->irq == irq) {
 		spin_lock(&tw_dev->tw_lock);
@@ -1475,7 +1489,7 @@
 		}
 		spin_unlock(&tw_dev->tw_lock);
 	}
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(&tw_dev->host->host_lock, flags);
 	clear_bit(TW_IN_INTR, &tw_dev->flags);
 }	/* End tw_interrupt() */
 
@@ -1902,9 +1916,7 @@
 		return 0;
 	}
 
-	spin_unlock_irq(&io_request_lock);
 	ret = tw_findcards(tw_host);
-	spin_lock_irq(&io_request_lock);
 
 	return ret;
 } /* End tw_scsi_detect() */
@@ -1929,9 +1941,9 @@
 	}
 
 	/* We have to let AEN requests through before the reset */
-	spin_unlock_irq(&io_request_lock);
+	spin_unlock_irq(&tw_dev->host->host_lock);
 	mdelay(TW_AEN_WAIT_TIME);
-	spin_lock_irq(&io_request_lock);
+	spin_lock_irq(&tw_dev->host->host_lock);
 
 	spin_lock(&tw_dev->tw_lock);
 	tw_dev->num_aborts++;
@@ -1993,9 +2005,9 @@
 	}
 
 	/* We have to let AEN requests through before the reset */
-	spin_unlock_irq(&io_request_lock);
+	spin_unlock_irq(&tw_dev->host->host_lock);
 	mdelay(TW_AEN_WAIT_TIME);
-	spin_lock_irq(&io_request_lock);
+	spin_lock_irq(&tw_dev->host->host_lock);
 
 	spin_lock(&tw_dev->tw_lock);
 	tw_dev->num_resets++;
diff -u linux-2.5.2-pre11/drivers/scsi/53c7,8xx.c linux/drivers/scsi/53c7,8xx.c
--- linux-2.5.2-pre11/drivers/scsi/53c7,8xx.c	Mon Nov 26 14:23:58 2001
+++ linux/drivers/scsi/53c7,8xx.c	Thu Jan 10 05:39:39 2002
@@ -265,7 +265,6 @@
 static int NCR53c8xx_script_len;
 static int NCR53c8xx_dsa_len;
 static void NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs);
-static void do_NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs);
 static int ncr_halt (struct Scsi_Host *host);
 static void intr_phase_mismatch (struct Scsi_Host *host, struct NCR53c7x0_cmd 
     *cmd);
@@ -1108,9 +1107,9 @@
 
     if (!search) {
 #ifdef __powerpc__
-	if (request_irq(host->irq, do_NCR53c7x0_intr, SA_SHIRQ, "53c7,8xx", NULL)) 
+	if (request_irq(host->irq, NCR53c7x0_intr, SA_SHIRQ, "53c7,8xx", NULL)) 
 #else
-	if (request_irq(host->irq, do_NCR53c7x0_intr, SA_INTERRUPT, "53c7,8xx", NULL))
+	if (request_irq(host->irq, NCR53c7x0_intr, SA_INTERRUPT, "53c7,8xx", NULL))
 #endif
 	  {
 	  
@@ -4350,22 +4349,6 @@
 }
 
 /*
- * Function : do_NCR53c7x0_intr()
- *
- * Purpose : A quick wrapper function added to grab the io_request_lock
- *      spin lock prior to entering the real interrupt handler.  Needed
- *      for 2.1.95 and above.
- */
-static void
-do_NCR53c7x0_intr(int irq, void *dev_id, struct pt_regs * regs) {
-    unsigned long flags;
-
-    spin_lock_irqsave(&io_request_lock, flags);
-    NCR53c7x0_intr(irq, dev_id, regs);
-    spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-/*
  * Function : static void NCR53c7x0_intr (int irq, void *dev_id, struct pt_regs * regs)
  *
  * Purpose : handle NCR53c7x0 interrupts for all NCR devices sharing
@@ -4402,6 +4385,8 @@
 	done = 1;
 	for (host = first_host; host; host = host->next) 
 	    if (host->hostt == the_template && host->irq == irq) {
+
+	    spin_lock_irqsave(&host->host_lock, flags);
     	    NCR53c7x0_local_setup(host);
 
 	    hostdata = (struct NCR53c7x0_hostdata *) host->hostdata;
@@ -4452,8 +4437,6 @@
 		     */
 
 
-		    save_flags(flags);
-		    cli();
 restart:
 		    for (cmd_prev_ptr = (struct NCR53c7x0_cmd **) 
 			 &(hostdata->running_list), cmd = 
@@ -4512,7 +4495,6 @@
 			goto restart;
 
 		    }
-		    restore_flags(flags);
 		   
     /*
      * I think that we're stacking INTFLY interrupts; taking care of 
@@ -4604,6 +4586,7 @@
 			hostdata->dstat |= DSTAT_DFE;
 		    }
 		}
+		spin_unlock_irqrestore(&host->host_lock, flags);
 	    } while (interrupted);
 
 
diff -u linux-2.5.2-pre11/drivers/scsi/53c700.c linux/drivers/scsi/53c700.c
--- linux-2.5.2-pre11/drivers/scsi/53c700.c	Wed Nov 28 10:22:27 2001
+++ linux/drivers/scsi/53c700.c	Thu Jan 10 05:15:36 2002
@@ -1519,7 +1519,7 @@
 	 * of locking in queuecommand: 1) io_request_lock then 2)
 	 * hostdata->lock would be the reverse of taking it in this
 	 * routine */
-	spin_lock_irqsave(&io_request_lock, flags);
+	spin_lock_irqsave(&host->host_lock, flags);
 	if((istat = NCR_700_readb(host, ISTAT_REG))
 	      & (SCSI_INT_PENDING | DMA_INT_PENDING)) {
 		__u32 dsps;
@@ -1764,7 +1764,7 @@
 		}
 	}
  out_unlock:
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(&host->host_lock, flags);
 }
 
 /* FIXME: Need to put some proc information in and plumb it
diff -u linux-2.5.2-pre11/drivers/scsi/AM53C974.c linux/drivers/scsi/AM53C974.c
--- linux-2.5.2-pre11/drivers/scsi/AM53C974.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/AM53C974.c	Thu Jan 10 06:15:14 2002
@@ -340,6 +340,20 @@
 #define TAG_NONE	-2	/* Establish I_T_L nexus instead of I_T_L_Q
 				   * even on SCSI-II devices */
 
+#ifdef MODULE
+static struct pci_device_id am53c974_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_AMD,
+	  device: PCI_DEVICE_ID_AMD_SCSI,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, am53c974_pci_tbl);
+#endif /* MODULE */
+
+
 /************ LILO overrides *************/
 typedef struct _override_t {
 	int host_scsi_id;	/* SCSI id of the bus controller */
@@ -362,7 +376,6 @@
 static __inline__ void run_main(void);
 static void AM53C974_main(void);
 static void AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs);
-static void do_AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs);
 static void AM53C974_intr_disconnect(struct Scsi_Host *instance);
 static int AM53C974_sync_neg(struct Scsi_Host *instance, int target, unsigned char *msg);
 static __inline__ void AM53C974_set_async(struct Scsi_Host *instance, int target);
@@ -738,7 +751,7 @@
 		 (search->irq != instance->irq) || (search == instance));
 	     search = search->next);
 	if (!search) {
-		if (request_irq(instance->irq, do_AM53C974_intr, SA_SHIRQ, "AM53C974", instance)) {
+		if (request_irq(instance->irq, AM53C974_intr, SA_SHIRQ, "AM53C974", instance)) {
 			printk("scsi%d: IRQ%d not free, detaching\n", instance->host_no, instance->irq);
 			scsi_unregister(instance);
 			return 0;
@@ -1018,30 +1031,13 @@
 *                                                                       *
 * Returns : nothing                                                     *
 ************************************************************************/
-static void do_AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-	AM53C974_intr(irq, dev_id, regs);
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-/************************************************************************
-* Function : AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs) *
-*                                                                       *
-* Purpose : interrupt handler                                           *
-*                                                                       *
-* Inputs : irq - interrupt line, regs - ?                               *
-*                                                                       *
-* Returns : nothing                                                     *
-************************************************************************/
 static void AM53C974_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	AM53C974_local_declare();
 	struct Scsi_Host *instance;
 	struct AM53C974_hostdata *hostdata;
 	unsigned char cmdreg, dmastatus, statreg, isreg, instreg, cfifo;
+	unsigned long flags;
 
 /* find AM53C974 hostadapter responsible for this interrupt */
 	for (instance = first_instance; instance; instance = instance->next)
@@ -1051,7 +1047,8 @@
 
 /* found; now decode and process */
 	FOUND:
-	    hostdata = (struct AM53C974_hostdata *) instance->hostdata;
+	spin_lock_irqsave(&instance->host_lock, flags);
+	hostdata = (struct AM53C974_hostdata *) instance->hostdata;
 	AM53C974_setio(instance);
 	dmastatus = AM53C974_read_8(DMASTATUS);
 
@@ -1073,9 +1070,6 @@
 	if (hostdata->connected && (dmastatus & DMASTATUS_DONE)) {
 		/* DMA transfer done */
 		unsigned long residual;
-		unsigned long flags;
-		save_flags(flags);
-		cli();
 		if (!(AM53C974_read_8(DMACMD) & DMACMD_DIR)) {
 			do {
 				dmastatus = AM53C974_read_8(DMASTATUS);
@@ -1104,10 +1098,9 @@
 			AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo,
 						      dmastatus);
 		}
-		restore_flags(flags);
 	}
 	if (!(dmastatus & DMASTATUS_SCSIINT)) {
-		return;
+		goto abort;
 	}
 /*** SCSI related interrupts ***/
 	cmdreg = AM53C974_read_8(CMDREG);
@@ -1140,15 +1133,12 @@
 		       cmdreg, AM53C974_read_8(DMACMD), statreg, isreg, instreg, cfifo);
 	}
 	if (hostdata->in_reset && (instreg & INSTREG_SRST)) {
-		unsigned long flags;
 		/* RESET INTERRUPT */
 #ifdef AM53C974_DEBUG
 		deb_stop = 1;
 #endif
 		DEB(printk("Bus reset interrupt received\n"));
 		AM53C974_intr_bus_reset(instance);
-		save_flags(flags);
-		cli();
 		if (hostdata->connected) {
 			hostdata->connected->result = DID_RESET << 16;
 			hostdata->connected->scsi_done((Scsi_Cmnd *) hostdata->connected);
@@ -1160,11 +1150,11 @@
 				hostdata->sel_cmd = NULL;
 			}
 		}
-		restore_flags(flags);
 		if (hostdata->in_reset == 1)
 			goto EXIT;
-		else
-			return;
+		else {
+			goto abort;
+		}
 	}
 	if (instreg & INSTREG_ICMD) {
 		/* INVALID COMMAND INTERRUPT */
@@ -1178,62 +1168,43 @@
 		panic("scsi%d: cannot recover\n", instance->host_no);
 	}
 	if (instreg & INSTREG_DIS) {
-		unsigned long flags;
 		/* DISCONNECT INTERRUPT */
 		DEB_INTR(printk("Disconnect interrupt received; "));
-		save_flags(flags);
-		cli();
 		AM53C974_intr_disconnect(instance);
-		restore_flags(flags);
 		goto EXIT;
 	}
 	if (instreg & INSTREG_RESEL) {
-		unsigned long flags;
 		/* RESELECTION INTERRUPT */
 		DEB_INTR(printk("Reselection interrupt received\n"));
-		save_flags(flags);
-		cli();
 		AM53C974_intr_reselect(instance, statreg);
-		restore_flags(flags);
 		goto EXIT;
 	}
 	if (instreg & INSTREG_SO) {
 		DEB_INTR(printk("Successful operation interrupt received\n"));
 		if (hostdata->selecting) {
-			unsigned long flags;
 			DEB_INTR(printk("DSR completed, starting select\n"));
-			save_flags(flags);
-			cli();
 			AM53C974_select(instance, (Scsi_Cmnd *) hostdata->sel_cmd,
 			  (hostdata->sel_cmd->cmnd[0] == REQUEST_SENSE) ?
 					TAG_NONE : TAG_NEXT);
 			hostdata->selecting = 0;
 			AM53C974_set_sync(instance, hostdata->sel_cmd->target);
-			restore_flags(flags);
-			return;
+			goto abort;
 		}
 		if (hostdata->sel_cmd != NULL) {
 			if (((isreg & ISREG_IS) != ISREG_OK_NO_STOP) &&
 			    ((isreg & ISREG_IS) != ISREG_OK_STOP)) {
-				unsigned long flags;
 				/* UNSUCCESSFUL SELECTION */
 				DEB_INTR(printk("unsuccessful selection\n"));
-				save_flags(flags);
-				cli();
 				hostdata->dma_busy = 0;
 				LIST(hostdata->sel_cmd, hostdata->issue_queue);
 				hostdata->sel_cmd->host_scribble = (unsigned char *) hostdata->issue_queue;
 				hostdata->issue_queue = hostdata->sel_cmd;
 				hostdata->sel_cmd = NULL;
 				hostdata->selecting = 0;
-				restore_flags(flags);
 				goto EXIT;
 			} else {
-				unsigned long flags;
 				/* SUCCESSFUL SELECTION */
 				DEB(printk("successful selection; cmd=0x%02lx\n", (long) hostdata->sel_cmd));
-				save_flags(flags);
-				cli();
 				hostdata->dma_busy = 0;
 				hostdata->disconnecting = 0;
 				hostdata->connected = hostdata->sel_cmd;
@@ -1252,27 +1223,18 @@
 				initialize_SCp((Scsi_Cmnd *) hostdata->connected);
 				hostdata->connected->SCp.phase = PHASE_CMDOUT;
 				AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo, dmastatus);
-				restore_flags(flags);
-				return;
+				goto abort;
 			}
 		} else {
-			unsigned long flags;
-			save_flags(flags);
-			cli();
 			AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo, dmastatus);
-			restore_flags(flags);
-			return;
+			goto abort;
 		}
 	}
 	if (instreg & INSTREG_SR) {
 		DEB_INTR(printk("Service request interrupt received, "));
 		if (hostdata->connected) {
-			unsigned long flags;
 			DEB_INTR(printk("calling information_transfer\n"));
-			save_flags(flags);
-			cli();
 			AM53C974_information_transfer(instance, statreg, isreg, instreg, cfifo, dmastatus);
-			restore_flags(flags);
 		} else {
 			printk("scsi%d: weird: service request when no command connected\n", instance->host_no);
 			AM53C974_write_8(CMDREG, CMDREG_CFIFO);
@@ -1282,6 +1244,9 @@
 	EXIT:
 	    DEB_INTR(printk("intr: starting main\n"));
 	run_main();
+
+abort:
+	spin_unlock_irqrestore(&instance->host_lock, flags);
 	DEB_INTR(printk("end of intr\n"));
 }
 
diff -u linux-2.5.2-pre11/drivers/scsi/BusLogic.c linux/drivers/scsi/BusLogic.c
--- linux-2.5.2-pre11/drivers/scsi/BusLogic.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/BusLogic.c	Thu Dec 27 14:20:29 2001
@@ -53,6 +53,30 @@
 #include "BusLogic.h"
 #include "FlashPoint.c"
 
+#ifdef MODULE
+static struct pci_device_id buslogic_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER_NC,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_BUSLOGIC,
+	  device: PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, buslogic_pci_tbl);
+#endif
 
 /*
   BusLogic_DriverOptionsCount is a count of the number of BusLogic Driver
diff -u linux-2.5.2-pre11/drivers/scsi/Makefile linux/drivers/scsi/Makefile
--- linux-2.5.2-pre11/drivers/scsi/Makefile	Sun Dec 16 12:20:20 2001
+++ linux/drivers/scsi/Makefile	Sun Dec 16 23:51:18 2001
@@ -21,7 +21,7 @@
 
 O_TARGET := scsidrv.o
 
-export-objs	:= scsi_syms.o 53c700.o
+export-objs	:= scsi_syms.o NCR53C9x.o 53c700.o
 mod-subdirs	:= pcmcia ../acorn/scsi
 
 
diff -u linux-2.5.2-pre11/drivers/scsi/NCR5380.c linux/drivers/scsi/NCR5380.c
--- linux-2.5.2-pre11/drivers/scsi/NCR5380.c	Fri Feb 16 16:02:36 2001
+++ linux/drivers/scsi/NCR5380.c	Thu Jan 10 05:10:17 2002
@@ -1,3 +1,4 @@
+#include <asm/atomic.h>
 #ifndef NDEBUG
 #define NDEBUG (NDEBUG_RESTART_SELECT | NDEBUG_ABORT)
 #endif
@@ -549,7 +550,7 @@
  * conditions are possible.
  */
 
-static volatile int main_running = 0;
+static atomic_t main_running = ATOMIC_INIT(1); /* 0 == main is running */
 
 /* 
  * Function : run_main(void)
@@ -563,10 +564,10 @@
 
 static __inline__ void run_main(void)
 {
-	if (!main_running) {
-		main_running = 1;
+	if (!atomic_dec_and_test(&main_running)) {
 		NCR5380_main();
-	}
+	} else
+	atomic_inc(&main_running);
 }
 
 #ifdef USLEEP
@@ -692,9 +693,7 @@
 	}
 	restore_flags(flags);
 
-	spin_lock_irqsave(&io_request_lock, flags);
 	run_main();
-	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 #endif				/* def USLEEP */
 
@@ -847,7 +846,7 @@
 	int len;
 
 	printk("NCR5380 : coroutine is%s running.\n",
-	       main_running ? "" : "n't");
+	       atomic_read(&main_running) ? "" : "n't");
 
 #ifdef NDEBUG
 	NCR5380_print(instance);
@@ -944,7 +943,7 @@
 #endif
 	save_flags(flags);
 	cli();
-	SPRINTF("NCR5380 : coroutine is%s running.\n", main_running ? "" : "n't");
+	SPRINTF("NCR5380 : coroutine is%s running.\n", atomic_read(&main_running) ? "" : "n't");
 	if (!hostdata->connected)
 		SPRINTF("scsi%d: no currently connected command\n", instance->host_no);
 	else
@@ -1236,7 +1235,9 @@
 #endif
 
 /* Run the coroutine if it isn't already running. */
+	spin_unlock_irq(&instance->host_lock);
 	run_main();
+	spin_lock_irq(&instance->host_lock);
 	return 0;
 }
 
@@ -1271,8 +1272,6 @@
 	 * this should prevent any race conditions.
 	 */
 
-	spin_unlock_irq(&io_request_lock);
-	
 	save_flags(flags);
 	
 	do {
@@ -1424,9 +1423,7 @@
 				break;
 		}		/* for instance */
 	} while (!done);
-	spin_lock_irq(&io_request_lock);
   /* 	cli();*/
-	main_running = 0;
 }
 
 #ifndef DONT_USE_INTR
@@ -1462,6 +1459,7 @@
 				the_template); instance = instance->next)
 			if (instance->irq == irq) {
 
+				spin_lock_irq(&instance->host_lock);
 				/* Look for pending interrupts */
 				NCR5380_setup(instance);
 				basr = NCR5380_read(BUS_AND_STATUS_REG);
@@ -1521,10 +1519,10 @@
 							{
 								unsigned long timeout = jiffies + NCR_TIMEOUT;
 
-								spin_unlock_irq(&io_request_lock);
+								spin_unlock_irq(&instance->host_lock);
 								while (NCR5380_read(BUS_AND_STATUS_REG) & BASR_ACK
 								       && time_before(jiffies, timeout));
-								spin_lock_irq(&io_request_lock);
+								spin_lock_irq(&instace->host_lock);
 								
 								if (time_after_eq(jiffies, timeout) )
 									printk("scsi%d: timeout at NCR5380.c:%d\n",
@@ -1545,6 +1543,7 @@
 #endif
 					}
 				}	/* if BASR_IRQ */
+				spin_unlock_irq(&instance->host_lock);
 				if (!done)
 					run_main();
 			}	/* if (instance->irq == irq) */
@@ -1553,11 +1552,7 @@
 
 
 static void do_NCR5380_intr(int irq, void *dev_id, struct pt_regs *regs) {
-	unsigned long flags;
-
-	 spin_lock_irqsave(&io_request_lock, flags);
 	 NCR5380_intr(irq, dev_id, regs);
-	 spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
 #endif
@@ -1669,12 +1664,12 @@
 	{
 		unsigned long timeout = jiffies + 2 * NCR_TIMEOUT;
 
-		spin_unlock_irq(&io_request_lock);
+		spin_unlock_irq(&host->host_lock);
 
 		while (!(NCR5380_read(INITIATOR_COMMAND_REG) & ICR_ARBITRATION_PROGRESS)
 		       && time_before(jiffies,timeout));
 
-		spin_lock_irq(&io_request_lock);
+		spin_lock_irq(&host->host_lock);
 		       
 		if (time_after_eq(jiffies,timeout)) {
 			printk("scsi: arbitration timeout at %d\n", __LINE__);
@@ -1834,10 +1829,10 @@
 	hostdata->selecting = 0; /* clear this pointer, because we passed the
 				waiting period */
 #else
-	spin_unlock_irq(&io_request_lock);
+	spin_unlock_irq(&instance->host_lock);
 	while (time_before(jiffies, timeout) && !(NCR5380_read(STATUS_REG) &
 					(SR_BSY | SR_IO)));
-	spin_lock_irq(&io_request_lock);
+	spin_lock_irq(&instance->host_lock);
 #endif
 	if ((NCR5380_read(STATUS_REG) & (SR_SEL | SR_IO)) ==
 	    (SR_SEL | SR_IO)) {
@@ -1905,9 +1900,9 @@
 	{
 		unsigned long timeout = jiffies + NCR_TIMEOUT;
 
-		spin_unlock_irq(&io_request_lock);
+		spin_unlock_irq(&instance->host_lock);
 		while (!(NCR5380_read(STATUS_REG) & SR_REQ) && time_before(jiffies, timeout));
-		spin_lock_irq(&io_request_lock);
+		spin_lock_irq(&instance->host_lock);
 		
 		if (time_after_eq(jiffies, timeout)) {
 			printk("scsi%d: timeout at NCR5380.c:%d\n", instance->host_no, __LINE__);
diff -u linux-2.5.2-pre11/drivers/scsi/NCR53C9x.c linux/drivers/scsi/NCR53C9x.c
--- linux-2.5.2-pre11/drivers/scsi/NCR53C9x.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/NCR53C9x.c	Thu Jan 10 05:52:36 2002
@@ -22,7 +22,6 @@
  */
 
 #include <linux/module.h>
-
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -732,9 +731,7 @@
 	/* Reset the thing before we try anything... */
 	esp_bootup_reset(esp, eregs);
 
-#ifdef MODULE
 	MOD_INC_USE_COUNT;
-#endif
 	esps_in_use++;
 }
 
@@ -3582,9 +3579,11 @@
 	unsigned long flags;
 
 	/* Handle all ESP interrupts showing at this IRQ level. */
-	spin_lock_irqsave(&io_request_lock, flags);
+	save_flags(flags);
+	cli();
 	for_each_esp(esp) {
 		if(((esp)->irq & 0xf) == irq) {
+			spin_lock(&esp->ehost->host_lock);
 			if(esp->dma_irq_p(esp)) {
 				esp->dma_ints_off(esp);
 
@@ -3596,12 +3595,22 @@
 				esp->dma_ints_on(esp);
 				goto out;
 			}
+			spin_unlock(&esp->ehost->host_lock);
 		}
 	}
 out:
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	restore_flags(flags);
 }
 #endif
+
+EXPORT_SYMBOL(esp_intr);
+EXPORT_SYMBOL(esp_allocate);
+EXPORT_SYMBOL(esp_initialize);
+EXPORT_SYMBOL(esp_reset);
+EXPORT_SYMBOL(esp_abort);
+EXPORT_SYMBOL(esps_in_use);
+EXPORT_SYMBOL(esp_deallocate);
+EXPORT_SYMBOL(esp_queue);
 
 #ifdef MODULE
 int init_module(void) { return 0; }
diff -u linux-2.5.2-pre11/drivers/scsi/NCR53c406a.c linux/drivers/scsi/NCR53c406a.c
--- linux-2.5.2-pre11/drivers/scsi/NCR53c406a.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/NCR53c406a.c	Thu Jan 10 05:13:38 2002
@@ -781,9 +781,9 @@
 do_NCR53c406a_intr(int unused, void *dev_id, struct pt_regs *regs){
     unsigned long flags;
 
-    spin_lock_irqsave(&io_request_lock, flags);
+    spin_lock_irqsave(&current_SC->host->host_lock, flags);
     NCR53c406a_intr(0, dev_id, regs);
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&current_SC->host->host_lock, flags);
 }
 
      static void
diff -u linux-2.5.2-pre11/drivers/scsi/a2091.c linux/drivers/scsi/a2091.c
--- linux-2.5.2-pre11/drivers/scsi/a2091.c	Thu Oct 25 13:53:48 2001
+++ linux/drivers/scsi/a2091.c	Thu Jan 10 08:06:21 2002
@@ -60,7 +60,7 @@
 	HDATA(instance)->dma_bounce_len = (cmd->SCp.this_residual + 511)
 	    & ~0x1ff;
 	HDATA(instance)->dma_bounce_buffer =
-	    scsi_malloc (HDATA(instance)->dma_bounce_len);
+	    kmalloc (HDATA(instance)->dma_bounce_len, GFP_DMA);
 	
 	/* can't allocate memory; use PIO */
 	if (!HDATA(instance)->dma_bounce_buffer) {
@@ -74,8 +74,7 @@
 	/* the bounce buffer may not be in the first 16M of physmem */
 	if (addr & A2091_XFER_MASK) {
 	    /* we could use chipmem... maybe later */
-	    scsi_free (HDATA(instance)->dma_bounce_buffer,
-		       HDATA(instance)->dma_bounce_len);
+	    kfree (HDATA(instance)->dma_bounce_buffer);
 	    HDATA(instance)->dma_bounce_buffer = NULL;
 	    HDATA(instance)->dma_bounce_len = 0;
 	    return 1;
@@ -162,8 +161,7 @@
 		memcpy (SCpnt->SCp.ptr, 
 			HDATA(instance)->dma_bounce_buffer,
 			SCpnt->SCp.this_residual);
-	    scsi_free (HDATA(instance)->dma_bounce_buffer,
-		       HDATA(instance)->dma_bounce_len);
+	    kfree (HDATA(instance)->dma_bounce_buffer);
 	    HDATA(instance)->dma_bounce_buffer = NULL;
 	    HDATA(instance)->dma_bounce_len = 0;
 	    
@@ -174,8 +172,7 @@
 			HDATA(instance)->dma_bounce_buffer,
 			SCpnt->request_bufflen);
 
-	    scsi_free (HDATA(instance)->dma_bounce_buffer,
-		       HDATA(instance)->dma_bounce_len);
+	    kfree (HDATA(instance)->dma_bounce_buffer);
 	    HDATA(instance)->dma_bounce_buffer = NULL;
 	    HDATA(instance)->dma_bounce_len = 0;
 	}
diff -u linux-2.5.2-pre11/drivers/scsi/a3000.c linux/drivers/scsi/a3000.c
--- linux-2.5.2-pre11/drivers/scsi/a3000.c	Thu Oct 25 13:53:48 2001
+++ linux/drivers/scsi/a3000.c	Thu Jan 10 08:06:33 2002
@@ -60,7 +60,7 @@
 	HDATA(a3000_host)->dma_bounce_len = (cmd->SCp.this_residual + 511)
 	    & ~0x1ff;
 	HDATA(a3000_host)->dma_bounce_buffer =
-	    scsi_malloc (HDATA(a3000_host)->dma_bounce_len);
+	    kmalloc (HDATA(a3000_host)->dma_bounce_len, GFP_DMA);
 	
 	/* can't allocate memory; use PIO */
 	if (!HDATA(a3000_host)->dma_bounce_buffer) {
@@ -151,8 +151,7 @@
 		memcpy (SCpnt->SCp.ptr,
 			HDATA(instance)->dma_bounce_buffer,
 			SCpnt->SCp.this_residual);
-	    scsi_free (HDATA(instance)->dma_bounce_buffer,
-		       HDATA(instance)->dma_bounce_len);
+	    kfree (HDATA(instance)->dma_bounce_buffer);
 	    HDATA(instance)->dma_bounce_buffer = NULL;
 	    HDATA(instance)->dma_bounce_len = 0;
 	} else {
@@ -161,8 +160,7 @@
 			HDATA(instance)->dma_bounce_buffer,
 			SCpnt->request_bufflen);
 
-	    scsi_free (HDATA(instance)->dma_bounce_buffer,
-		       HDATA(instance)->dma_bounce_len);
+	    kfree (HDATA(instance)->dma_bounce_buffer);
 	    HDATA(instance)->dma_bounce_buffer = NULL;
 	    HDATA(instance)->dma_bounce_len = 0;
 	}
diff -u linux-2.5.2-pre11/drivers/scsi/advansys.c linux/drivers/scsi/advansys.c
--- linux-2.5.2-pre11/drivers/scsi/advansys.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/advansys.c	Thu Jan  3 20:12:22 2002
@@ -4174,6 +4174,18 @@
     ASC_IS_PCI,
 };
 
+#if LINUX_VERSION_CODE >= ASC_LINUX_VERSION(2,4,0) && defined(MODULE)
+static struct pci_device_id advansys_pci_tbl[] __initdata = {
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1100, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1200, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_1300, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_2300, PCI_ANY_ID, PCI_ANY_ID },
+    { ADV_PCI_VENDOR_ID, ASC_PCI_DEVICE_ID_2500, PCI_ANY_ID, PCI_ANY_ID },
+    { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, advansys_pci_tbl);
+#endif
+
 /*
  * Used with the LILO 'advansys' option to eliminate or
  * limit I/O port probing at boot time, cf. advansys_setup().
diff -u linux-2.5.2-pre11/drivers/scsi/aha1542.c linux/drivers/scsi/aha1542.c
--- linux-2.5.2-pre11/drivers/scsi/aha1542.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/aha1542.c	Mon Dec 31 16:02:00 2001
@@ -51,6 +51,20 @@
 
 #include "aha1542.h"
 
+#ifdef MODULE
+static struct isapnp_card_id aha1542_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('A', 'D', 'P', 0x1542) },
+	},
+	{
+		ISAPNP_CARD_END,
+	}
+};
+ISAPNP_CARD_TABLE(aha1542_isa_ids);
+#endif
+
 #define SCSI_PA(address) virt_to_bus(address)
 
 static void BAD_DMA(void *address, unsigned int length)
diff -u linux-2.5.2-pre11/drivers/scsi/aha1740.c linux/drivers/scsi/aha1740.c
--- linux-2.5.2-pre11/drivers/scsi/aha1740.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/aha1740.c	Thu Jan 10 08:07:32 2002
@@ -258,7 +258,7 @@
 		continue;
 	    }
 	    if (SCtmp->host_scribble)
-		scsi_free(SCtmp->host_scribble, 512);
+		kfree(SCtmp->host_scribble);
 	    /* Fetch the sense data, and tuck it away, in the required slot.
 	       The Adaptec automatically fetches it, and there is no
 	       guarantee that we will still have it in the cdb when we come
@@ -390,7 +390,7 @@
 	DEB(unsigned char * ptr);
 
 	host->ecb[ecbno].sg = 1;  /* SCSI Initiator Command  w/scatter-gather*/
-	SCpnt->host_scribble = (unsigned char *) scsi_malloc(512);
+	SCpnt->host_scribble = (unsigned char *) kmalloc(512, GFP_DMA);
 	sgpnt = (struct scatterlist *) SCpnt->request_buffer;
 	cptr = (struct aha1740_chain *) SCpnt->host_scribble; 
 	if (cptr == NULL) panic("aha1740.c: unable to allocate DMA memory\n");
Common subdirectories: linux-2.5.2-pre11/drivers/scsi/aic7xxx and linux/drivers/scsi/aic7xxx
Common subdirectories: linux-2.5.2-pre11/drivers/scsi/aic7xxx_old and linux/drivers/scsi/aic7xxx_old
diff -u linux-2.5.2-pre11/drivers/scsi/atp870u.c linux/drivers/scsi/atp870u.c
--- linux-2.5.2-pre11/drivers/scsi/atp870u.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/atp870u.c	Thu Jan 10 06:35:38 2002
@@ -1,4 +1,4 @@
-/* $Id: atp870u.c,v 1.0 1997/05/07 15:22:00 root Exp root $
+/* $Id$
  *  linux/kernel/atp870u.c
  *
  *  Copyright (C) 1997	Wu Ching Chen
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <linux/pci.h>
@@ -39,7 +40,7 @@
 void mydlyu(unsigned int);
 
 /*
- *   static const char RCSid[] = "$Header: /usr/src/linux/kernel/blk_drv/scsi/RCS/atp870u.c,v 1.0 1997/05/07 15:22:00 root Exp root $";
+ *   static const char RCSid[] = "$Header$";
  */
 
 static unsigned char admaxu = 1;
@@ -82,9 +83,9 @@
 		unsigned char *prd_tableu;
 		Scsi_Cmnd *curr_req;
 	} id[16];
+	struct Scsi_Host *host;
 };
 
-static struct Scsi_Host *atp_host[2] = {NULL, NULL};
 static struct atp_unit atp_unit[2];
 
 static void atp870u_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
@@ -433,7 +434,7 @@
 			/*
 			 *	Complete the command
 			 */
-			spin_lock_irqsave(&io_request_lock, flags);
+			spin_lock_irqsave(&dev->host->host_lock, flags);
 			(*workrequ->scsi_done) (workrequ);
 
 			/*
@@ -441,7 +442,7 @@
 			 */
 			dev->id[target_id].curr_req = 0;
 			dev->working--;
-			spin_unlock_irqrestore(&io_request_lock, flags);
+			spin_unlock_irqrestore(&dev->host->host_lock, flags);
 			/*
 			 *	Take it back wide
 			 */
@@ -539,7 +540,7 @@
 	struct atp_unit *dev;
 
 	for (h = 0; h <= admaxu; h++) {
-		if (req_p->host == atp_host[h]) {
+		if (req_p->host == atp_unit[h].host) {
 			goto host_ok;
 		}
 	}
@@ -1687,6 +1688,20 @@
 	outb((unsigned char) (inb(tmport) & 0xef), tmport);
 }
 
+#ifdef MODULE
+static struct pci_device_id atp870u_pci_tbl[] __initdata = {
+{vendor: 0x1191, device: 0x8002, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8010, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8020, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8030, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8040, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8050, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{vendor: 0x1191, device: 0x8060, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
+{ } 	/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, atp870u_pci_tbl);
+#endif
+
 void is880(unsigned long host, unsigned int wkport)
 {
 	unsigned int tmport;
@@ -2646,7 +2661,7 @@
 		   outb(0xb0, tmport);
 		}
 
-		atp_host[h] = shpnt;
+		atp_unit[h].host = shpnt;
 		if (dev->chip_veru == 4) {
 			shpnt->max_id = 16;
 		}
@@ -2695,7 +2710,7 @@
 	unsigned int tmport;
 	struct atp_unit *dev;
 	for (h = 0; h <= admaxu; h++) {
-		if (SCpnt->host == atp_host[h]) {
+		if (SCpnt->host == atp_unit[h].host) {
 			goto find_adp;
 		}
 	}
@@ -2744,7 +2759,7 @@
 	 * See if a bus reset was suggested.
 	 */
 	for (h = 0; h <= admaxu; h++) {
-		if (SCpnt->host == atp_host[h]) {
+		if (SCpnt->host == atp_unit[h].host) {
 			goto find_host;
 		}
 	}
@@ -2788,7 +2803,7 @@
 
 	HBAptr = NULL;
 	for (i = 0; i < 2; i++) {
-		if ((HBAptr = atp_host[i]) != NULL) {
+		if ((HBAptr = atp_unit[i].host) != NULL) {
 			if (HBAptr->host_no == hostno) {
 				break;
 			}
@@ -2859,7 +2874,7 @@
 	int h;
 	for (h = 0; h <= admaxu; h++)
 	{
-		if (pshost == atp_host[h]) {
+		if (pshost == atp_unit[h].host) {
 			int k;
 			free_irq (pshost->irq, &atp_unit[h]);
 			release_region (pshost->io_port, pshost->n_io_port);
diff -u linux-2.5.2-pre11/drivers/scsi/cpqfcTSinit.c linux/drivers/scsi/cpqfcTSinit.c
--- linux-2.5.2-pre11/drivers/scsi/cpqfcTSinit.c	Mon Dec 10 14:22:21 2001
+++ linux/drivers/scsi/cpqfcTSinit.c	Wed Dec 12 03:59:21 2001
@@ -63,6 +63,7 @@
 
 #include <linux/config.h>  
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/version.h> 
 
 /* Embedded module documentation macros - see module.h */
@@ -266,6 +267,24 @@
 // Agilent XL2 
 #define HBA_TYPES 2
 
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) && defined(MODULE)
+static struct pci_device_id cpqfcTS_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_COMPAQ,
+	  device: CPQ_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_HP,
+	  device: AGILENT_XL2_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, cpqfcTS_pci_tbl);
+#endif
 
 int cpqfcTS_detect(Scsi_Host_Template *ScsiHostTemplate)
 {
diff -u linux-2.5.2-pre11/drivers/scsi/dmx3191d.c linux/drivers/scsi/dmx3191d.c
--- linux-2.5.2-pre11/drivers/scsi/dmx3191d.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/dmx3191d.c	Thu Oct  4 23:53:58 2001
@@ -52,6 +52,19 @@
 #include "NCR5380.h"
 #include "NCR5380.c"
 
+#ifdef MODULE
+static struct pci_device_id dmx3191d_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_DOMEX,
+	  device: PCI_DEVICE_ID_DOMEX_DMX3191D,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, dmx3191d_pci_tbl);
+#endif
+
 
 int __init dmx3191d_detect(Scsi_Host_Template *tmpl) {
 	int boards = 0;
Common subdirectories: linux-2.5.2-pre11/drivers/scsi/dpt and linux/drivers/scsi/dpt
diff -u linux-2.5.2-pre11/drivers/scsi/eata_dma.c linux/drivers/scsi/eata_dma.c
--- linux-2.5.2-pre11/drivers/scsi/eata_dma.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/eata_dma.c	Thu Jan 10 05:43:00 2002
@@ -73,6 +73,7 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <asm/byteorder.h>
 #include <asm/types.h>
 #include <asm/io.h>
@@ -92,6 +93,19 @@
 #include <linux/stat.h>
 #include <linux/config.h>	/* for CONFIG_PCI */
 
+#if defined(CONFIG_PCI) && defined(MODULE)
+static struct pci_device_id eata_dma_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_DPT,
+	  device: PCI_DEVICE_ID_DPT,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, eata_dma_pci_tbl);
+#endif
+
 static u32 ISAbases[] =
 {0x1F0, 0x170, 0x330, 0x230};
 static unchar EISAbases[] =
@@ -226,15 +240,6 @@
 
 void eata_int_handler(int, void *, struct pt_regs *);
 
-void do_eata_int_handler(int irq, void *dev_id, struct pt_regs * regs)
-{
-    unsigned long flags;
-
-    spin_lock_irqsave(&io_request_lock, flags);
-    eata_int_handler(irq, dev_id, regs);
-    spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
 void eata_int_handler(int irq, void *dev_id, struct pt_regs * regs)
 {
     uint i, result = 0;
@@ -245,11 +250,13 @@
     uint base;
     uint x;
     struct Scsi_Host *sh;
+    unsigned long flags;
 
     for (x = 1, sh = first_HBA; x <= registered_HBAs; x++, sh = SD(sh)->next) {
 	if (sh->irq != irq)
 	    continue;
 	
+	spin_lock_irqsave(&sh->host_lock, flags);
 	while(inb((uint)sh->base + HA_RAUXSTAT) & HA_AIRQ) {
 	    
 	    int_counter++;
@@ -376,6 +383,7 @@
 	    ccb->status = FREE;	    /* now we can release the slot  */
 	    cmd->scsi_done(cmd);
 	}
+	spin_unlock_irqrestore(&sh->host_lock, flags);
     }
 
     return;
@@ -1502,7 +1510,7 @@
     for (i = 0; i <= MAXIRQ; i++) { /* Now that we know what we have, we     */
 	if (reg_IRQ[i] >= 1){       /* exchange the interrupt handler which  */
 	    free_irq(i, NULL);      /* we used for probing with the real one */
-	    request_irq(i, (void *)(do_eata_int_handler), SA_INTERRUPT|SA_SHIRQ, 
+	    request_irq(i, (void *)(eata_int_handler), SA_INTERRUPT|SA_SHIRQ, 
 			"eata_dma", NULL);
 	}
     }
diff -u linux-2.5.2-pre11/drivers/scsi/eata_pio.c linux/drivers/scsi/eata_pio.c
--- linux-2.5.2-pre11/drivers/scsi/eata_pio.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/eata_pio.c	Thu Jan 10 05:47:56 2002
@@ -107,15 +107,6 @@
 
 void eata_pio_int_handler(int irq, void *dev_id, struct pt_regs * regs);
 
-void do_eata_pio_int_handler(int irq, void *dev_id, struct pt_regs * regs)
-{
-    unsigned long flags;
-
-    spin_lock_irqsave(&io_request_lock, flags);
-    eata_pio_int_handler(irq, dev_id, regs);
-    spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
 void eata_pio_int_handler(int irq, void *dev_id, struct pt_regs * regs)
 {
     uint eata_stat = 0xfffff;
@@ -138,6 +129,8 @@
 	if (inb((uint)sh->base + HA_RSTATUS) & HA_SBUSY)
 	    continue;
 	
+        spin_lock(&sh->host_lock);
+
 	int_counter++;
 	
 	hd=SD(sh);
@@ -249,6 +242,7 @@
 	
 	cp->status = FREE;   /* now we can release the slot  */
 	
+        spin_unlock(&sh->host_lock);
 	restore_flags(flags);
 	cmd->scsi_done(cmd);
 	save_flags(flags);
@@ -705,7 +699,7 @@
     }
     
     if (!reg_IRQ[gc->IRQ]) {    /* Interrupt already registered ? */
-	if (!request_irq(gc->IRQ, do_eata_pio_int_handler, SA_INTERRUPT, 
+	if (!request_irq(gc->IRQ, eata_pio_int_handler, SA_INTERRUPT, 
 			 "EATA-PIO", NULL)){
 	    reg_IRQ[gc->IRQ]++;
 	    if (!gc->IRQ_TR)
@@ -959,7 +953,7 @@
     
     for (i = 0; i <= MAXIRQ; i++)
 	if (reg_IRQ[i])
-	    request_irq(i, do_eata_pio_int_handler, SA_INTERRUPT, "EATA-PIO", NULL);
+	    request_irq(i, eata_pio_int_handler, SA_INTERRUPT, "EATA-PIO", NULL);
     
     HBA_ptr = first_HBA;
   
diff -u linux-2.5.2-pre11/drivers/scsi/fd_mcs.c linux/drivers/scsi/fd_mcs.c
--- linux-2.5.2-pre11/drivers/scsi/fd_mcs.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/fd_mcs.c	Thu Jan 10 04:22:35 2002
@@ -740,9 +740,9 @@
 #if EVERY_ACCESS
       printk( " AFAIL " );
 #endif
-      spin_lock_irqsave(&io_request_lock, flags);
+      spin_lock_irqsave(&shpnt->host_lock, flags);
       my_done( shpnt, DID_BUS_BUSY << 16 );
-      spin_unlock_irqrestore(&io_request_lock, flags);
+      spin_unlock_irqrestore(&shpnt->host_lock, flags);
       return;
     }
     current_SC->SCp.phase = in_selection;
@@ -766,9 +766,9 @@
 #if EVERY_ACCESS
 	printk( " SFAIL " );
 #endif
-	spin_lock_irqsave(&io_request_lock, flags);
+	spin_lock_irqsave(&shpnt->host_lock, flags);
 	my_done( shpnt, DID_NO_CONNECT << 16 );
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(&shpnt->host_lock, flags);
 	return;
       } else {
 #if EVERY_ACCESS
@@ -1117,11 +1117,11 @@
 #if EVERY_ACCESS
     printk( "BEFORE MY_DONE. . ." );
 #endif
-    spin_lock_irqsave(&io_request_lock, flags);
+    spin_lock_irqsave(&shpnt->host_lock, flags);
     my_done( shpnt,
 	     (current_SC->SCp.Status & 0xff)
 	     | ((current_SC->SCp.Message & 0xff) << 8) | (DID_OK << 16) );
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&shpnt->host_lock, flags);
 #if EVERY_ACCESS
     printk( "RETURNING.\n" );
 #endif
@@ -1342,9 +1342,9 @@
   restore_flags( flags );
    
   /* Aborts are not done well. . . */
-  spin_lock_irqsave(&io_request_lock, flags);
+  spin_lock_irqsave(&shpnt->host_lock, flags);
   my_done( shpnt, DID_ABORT << 16 );
-  spin_unlock_irqrestore(&io_request_lock, flags);
+  spin_unlock_irqrestore(&shpnt->host_lock, flags);
 
   return SCSI_ABORT_SUCCESS;
 }
@@ -1394,7 +1394,7 @@
   int              retcode;
 
   /* BIOS >= 3.4 for MCA cards */
-  drive = MINOR(dev) / 16;
+  drive = minor(dev) / 16;
 
   /* This algorithm was provided by Future Domain (much thanks!). */
 
diff -u linux-2.5.2-pre11/drivers/scsi/fdomain.c linux/drivers/scsi/fdomain.c
--- linux-2.5.2-pre11/drivers/scsi/fdomain.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/fdomain.c	Thu Jan  3 20:12:24 2002
@@ -428,7 +428,18 @@
 				*/
 static char * fdomain = NULL;
 MODULE_PARM(fdomain, "s");
+static struct pci_device_id fdomain_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_FD,
+	  device: PCI_DEVICE_ID_FD_36C70,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, fdomain_pci_tbl);
 #endif
+
 
 static unsigned long addresses[] = {
    0xc8000,
diff -u linux-2.5.2-pre11/drivers/scsi/g_NCR5380.c linux/drivers/scsi/g_NCR5380.c
--- linux-2.5.2-pre11/drivers/scsi/g_NCR5380.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/g_NCR5380.c	Thu Jan 10 04:23:59 2002
@@ -107,6 +107,7 @@
 #error You must configure the Generic NCR 5380 SCSI Driver for one of memory mapped I/O and port mapped I/O.
 #endif
 
+#include <linux/module.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <linux/signal.h>
@@ -145,6 +146,18 @@
 #endif
 
 #define NO_OVERRIDES (sizeof(overrides) / sizeof(struct override))
+
+#ifdef MODULE
+static struct isapnp_card_id ncr5380_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('D', 'T', 'C', 0x436e) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ncr5380_isa_ids);
+#endif
 
 /*
  * Function : static internal_setup(int board, char *str, int *ints)
diff -u linux-2.5.2-pre11/drivers/scsi/gdth.c linux/drivers/scsi/gdth.c
--- linux-2.5.2-pre11/drivers/scsi/gdth.c	Fri Nov  9 14:05:06 2001
+++ linux/drivers/scsi/gdth.c	Thu Jan 10 06:45:48 2002
@@ -629,8 +629,14 @@
 #define GDTH_LOCK_HA(ha,flags)          spin_lock_irqsave(&(ha)->smp_lock,flags)
 #define GDTH_UNLOCK_HA(ha,flags)        spin_unlock_irqrestore(&(ha)->smp_lock,flags)
 
-#define GDTH_LOCK_SCSI_DONE(flags)      spin_lock_irqsave(&io_request_lock,flags)
-#define GDTH_UNLOCK_SCSI_DONE(flags)    spin_unlock_irqrestore(&io_request_lock,flags)
+# if LINUX_VERSION_CODE >= 0x020502
+#  define GDTH_LOCK_SCSI_DONE(scp,flags)      spin_lock_irqsave(&(scp)->host->host_lock,flags)
+#  define GDTH_UNLOCK_SCSI_DONE(scp,flags)    spin_unlock_irqrestore(&(scp)->host->host_lock,flags)
+# else
+#  define GDTH_LOCK_SCSI_DONE(scp,flags)      spin_lock_irqsave(&io_request_lock,flags)
+#  define GDTH_UNLOCK_SCSI_DONE(scp,flags)    spin_unlock_irqrestore(&io_request_lock,flags)
+# endif
+
 #define GDTH_LOCK_SCSI_DOCMD()          spin_lock_irq(&io_request_lock)
 #define GDTH_UNLOCK_SCSI_DOCMD()        spin_unlock_irq(&io_request_lock)
 #else
@@ -638,8 +644,8 @@
 #define GDTH_LOCK_HA(ha,flags)          do {save_flags(flags); cli();} while (0)
 #define GDTH_UNLOCK_HA(ha,flags)        do {restore_flags(flags);} while (0)
 
-#define GDTH_LOCK_SCSI_DONE(flags)      do {} while (0)
-#define GDTH_UNLOCK_SCSI_DONE(flags)    do {} while (0)
+#define GDTH_LOCK_SCSI_DONE(scp,flags)      do {} while (0)
+#define GDTH_UNLOCK_SCSI_DONE(scp,flags)    do {} while (0)
 #define GDTH_LOCK_SCSI_DOCMD()          do {} while (0)
 #define GDTH_UNLOCK_SCSI_DOCMD()        do {} while (0)
 #endif
@@ -3339,9 +3345,9 @@
     if (rval == 2) {
         gdth_putq(hanum,scp,scp->SCp.this_residual);
     } else if (rval == 1) {
-        GDTH_LOCK_SCSI_DONE(flags);
+        GDTH_LOCK_SCSI_DONE(scp,flags);
         scp->scsi_done(scp);
-        GDTH_UNLOCK_SCSI_DONE(flags);
+        GDTH_UNLOCK_SCSI_DONE(scp,flags);
     }
     gdth_next(hanum);
 }
diff -u linux-2.5.2-pre11/drivers/scsi/gdth_proc.c linux/drivers/scsi/gdth_proc.c
--- linux-2.5.2-pre11/drivers/scsi/gdth_proc.c	Fri Sep  7 09:28:37 2001
+++ linux/drivers/scsi/gdth_proc.c	Thu Jan 10 06:45:05 2002
@@ -2,6 +2,7 @@
  * $Id: gdth_proc.c,v 1.33 2001/08/10 07:54:39 achim Exp $
  */
 
+#include <linux/version.h>
 #include "gdth_ioctl.h"
 #if LINUX_VERSION_CODE >= 0x020407
 #include <linux/completion.h>
@@ -1390,9 +1391,9 @@
             GDTH_UNLOCK_HA(ha, flags);
             while (!scp->SCp.have_data_in)
                 barrier();
-            GDTH_LOCK_SCSI_DONE(flags);
+            GDTH_LOCK_SCSI_DONE(scp, flags);
             scp->scsi_done(scp);
-            GDTH_UNLOCK_SCSI_DONE(flags);
+            GDTH_UNLOCK_SCSI_DONE(scp, flags);
         GDTH_LOCK_HA(ha, flags);
         }
     }
diff -u linux-2.5.2-pre11/drivers/scsi/gvp11.c linux/drivers/scsi/gvp11.c
--- linux-2.5.2-pre11/drivers/scsi/gvp11.c	Thu Oct 25 13:53:51 2001
+++ linux/drivers/scsi/gvp11.c	Thu Jan 10 08:08:17 2002
@@ -69,7 +69,7 @@
 
  	if( !scsi_alloc_out_of_range ) {
 	    HDATA(cmd->host)->dma_bounce_buffer =
-		scsi_malloc (HDATA(cmd->host)->dma_bounce_len);
+		kmalloc (HDATA(cmd->host)->dma_bounce_len, GFP_DMA);
 	    HDATA(cmd->host)->dma_buffer_pool = BUF_SCSI_ALLOCED;
 	}
 
@@ -93,8 +93,7 @@
 	if (addr & HDATA(cmd->host)->dma_xfer_mask) {
 	    /* fall back to Chip RAM if address out of range */
 	    if( HDATA(cmd->host)->dma_buffer_pool == BUF_SCSI_ALLOCED) {
-		scsi_free (HDATA(cmd->host)->dma_bounce_buffer,
-			   HDATA(cmd->host)->dma_bounce_len);
+	        kfree (HDATA(cmd->host)->dma_bounce_buffer);
 		scsi_alloc_out_of_range = 1;
 	    } else {
 		amiga_chip_free (HDATA(cmd->host)->dma_bounce_buffer);
@@ -164,8 +163,7 @@
 		    SCpnt->SCp.this_residual);
 	
 	if (HDATA(instance)->dma_buffer_pool == BUF_SCSI_ALLOCED)
-	    scsi_free (HDATA(instance)->dma_bounce_buffer,
-		       HDATA(instance)->dma_bounce_len);
+	    kfree (HDATA(instance)->dma_bounce_buffer);
 	else
 	    amiga_chip_free(HDATA(instance)->dma_bounce_buffer);
 	
diff -u linux-2.5.2-pre11/drivers/scsi/i91uscsi.c linux/drivers/scsi/i91uscsi.c
--- linux-2.5.2-pre11/drivers/scsi/i91uscsi.c	Sun Aug 12 10:51:41 2001
+++ linux/drivers/scsi/i91uscsi.c	Thu Jan 10 07:10:05 2002
@@ -93,6 +93,8 @@
 #include <linux/blk.h>
 #include <asm/io.h>
 
+#include "scsi.h"
+#include "hosts.h"
 #include "i91uscsi.h"
 
 /*--- external functions --*/
@@ -1357,10 +1359,17 @@
 }
 
 /***************************************************************************/
-int tul_isr(HCS * pCurHcb)
+void tul_isr(int irqno, void *dev_id, struct pt_regs *regs)
 {
+	HCS * pCurHcb = dev_id;
+	unsigned long flags;
+
+	if (pCurHcb->HCS_Intr != irqno)
+		return;
+
 	/* Enter critical section       */
 
+	spin_lock_irqsave(&pCurHcb->host->host_lock, flags);
 	if (TUL_RD(pCurHcb->HCS_Base, TUL_Int) & TSS_INT_PENDING) {
 		if (pCurHcb->HCS_Semaph == 1) {
 			TUL_WR(pCurHcb->HCS_Base + TUL_Mask, 0x1F);
@@ -1374,7 +1383,7 @@
 			return (1);
 		}
 	}
-	return (0);
+	spin_unlock_irqrestore(&pCurHcb->host->host_lock, flags);
 }
 
 /***************************************************************************/
diff -u linux-2.5.2-pre11/drivers/scsi/i91uscsi.h linux/drivers/scsi/i91uscsi.h
--- linux-2.5.2-pre11/drivers/scsi/i91uscsi.h	Thu Oct 11 09:43:30 2001
+++ linux/drivers/scsi/i91uscsi.h	Thu Jan 10 07:06:32 2002
@@ -602,6 +602,7 @@
 	spinlock_t HCS_SemaphLock;
 	spinlock_t pSRB_lock;	/* SRB queue lock            */
 #endif
+	struct Scsi_Host *host;
 } HCS;
 
 /* Bit Definition for HCB_Config */
diff -u linux-2.5.2-pre11/drivers/scsi/ibmmca.c linux/drivers/scsi/ibmmca.c
--- linux-2.5.2-pre11/drivers/scsi/ibmmca.c	Tue May  1 16:05:00 2001
+++ linux/drivers/scsi/ibmmca.c	Thu Jan 10 05:59:41 2002
@@ -41,8 +41,8 @@
 /* current version of this driver-source: */
 #define IBMMCA_SCSI_DRIVER_VERSION "4.0b"
 
-#define IBMLOCK spin_lock_irqsave(&io_request_lock, flags);
-#define IBMUNLOCK spin_unlock_irqrestore(&io_request_lock, flags);
+#define IBMLOCK spin_lock_irqsave(&shpnt->host_lock, flags);
+#define IBMUNLOCK spin_unlock_irqrestore(&shpnt->host_lock, flags);
 
 /* driver configuration */
 #define IM_MAX_HOSTS     8 /* maximum number of host adapters */
@@ -505,14 +505,15 @@
    Scsi_Cmnd *cmd;
    int lastSCSI;
 
-   IBMLOCK
+   save_flags(flags);
+   cli();
    /* search for one adapter-response on shared interrupt */
    for (host_index=0;
 	hosts[host_index] && !(inb(IM_STAT_REG(host_index)) & IM_INTR_REQUEST);
 	host_index++);
    /* return if some other device on this IRQ caused the interrupt */
    if (!hosts[host_index]) {
-      IBMUNLOCK
+      restore_flags(flags);
       return;
    }
 
@@ -521,15 +522,15 @@
    if ((reset_status(host_index) == IM_RESET_NOT_IN_PROGRESS_NO_INT)||
        (reset_status(host_index) == IM_RESET_FINISHED_OK_NO_INT)) {
       reset_status(host_index) = IM_RESET_NOT_IN_PROGRESS;
-      IBMUNLOCK
+      restore_flags(flags);
       return;
    }
 
    /*must wait for attention reg not busy, then send EOI to subsystem */
    while (1) {
       if (!(inb (IM_STAT_REG(host_index)) & IM_BUSY)) break;
-      IBMUNLOCK /* cycle interrupt */
-      IBMLOCK
+      restore_flags(flags); /* cycle interrupt */
+      cli();
    }
    ihost_index=host_index;
    /*get command result and logical device */
@@ -539,7 +540,7 @@
    /* get the last_scsi_command here */
    lastSCSI = last_scsi_command(ihost_index)[ldn];
    outb (IM_EOI | ldn, IM_ATTN_REG(ihost_index));
-   IBMUNLOCK
+   restore_flags(flags);
    /*these should never happen (hw fails, or a local programming bug) */
    if (!global_command_error_excuse) {
       switch (cmd_result) {
@@ -730,15 +731,16 @@
 {
    unsigned long flags;
    /* must wait for attention reg not busy */
+   save_flags(flags);
    while (1) {
-      IBMLOCK
+      cli();
       if (!(inb(IM_STAT_REG(host_index)) & IM_BUSY)) break;
-      IBMUNLOCK
+      restore_flags(flags);
    }
    /* write registers and enable system interrupts */
    outl (cmd_reg, IM_CMD_REG(host_index));
    outb (attn_reg, IM_ATTN_REG(host_index));
-   IBMUNLOCK
+   restore_flags(flags);
    return;
 }
 
@@ -1442,8 +1444,8 @@
    unsigned int pos[8];
    unsigned long flags;
 
-   IBMLOCK
    shpnt = dev; /* assign host-structure to local pointer */
+   IBMLOCK
    len = 0; /* set filled text-buffer index to 0 */
    /* get the _special contents of the hostdata structure */
    speciale = ((struct ibmmca_hostdata *)shpnt->hostdata)->_special;
@@ -2192,8 +2194,8 @@
 #ifdef IM_DEBUG_PROBE
    printk("IBM MCA SCSI: Abort subroutine called...\n");
 #endif
-   IBMLOCK
    shpnt = cmd->host;
+   IBMLOCK
    /* search for the right hostadapter */
    for (host_index = 0; hosts[host_index] && hosts[host_index]->host_no != shpnt->host_no; host_index++);
 
@@ -2297,9 +2299,9 @@
       printk("IBM MCA SCSI: Reset called with NULL-command!\n");
       return(SCSI_RESET_SNOOZE);
    }
-   IBMLOCK
    ticks = IM_RESET_DELAY*HZ;
    shpnt = cmd->host;
+   IBMLOCK
    /* search for the right hostadapter */
    for (host_index = 0; hosts[host_index] && hosts[host_index]->host_no != shpnt->host_no; host_index++);
 
@@ -2454,9 +2456,9 @@
    unsigned long flags;
    int max_pun;
 
-   IBMLOCK
    for (i = 0; hosts[i] && hosts[i]->host_no != hostno; i++);
    shpnt = hosts[i];
+   IBMLOCK
    host_index = i;
    if (!shpnt) {
       len += sprintf(buffer+len, "\nIBM MCA SCSI: Can't find adapter for host number %d\n", hostno);
diff -u linux-2.5.2-pre11/drivers/scsi/ini9100u.c linux/drivers/scsi/ini9100u.c
--- linux-2.5.2-pre11/drivers/scsi/ini9100u.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/ini9100u.c	Thu Jan 10 07:04:44 2002
@@ -166,15 +166,6 @@
 
 static char *setup_str = (char *) NULL;
 
-static void i91u_intr0(int irq, void *dev_id, struct pt_regs *);
-static void i91u_intr1(int irq, void *dev_id, struct pt_regs *);
-static void i91u_intr2(int irq, void *dev_id, struct pt_regs *);
-static void i91u_intr3(int irq, void *dev_id, struct pt_regs *);
-static void i91u_intr4(int irq, void *dev_id, struct pt_regs *);
-static void i91u_intr5(int irq, void *dev_id, struct pt_regs *);
-static void i91u_intr6(int irq, void *dev_id, struct pt_regs *);
-static void i91u_intr7(int irq, void *dev_id, struct pt_regs *);
-
 static void i91u_panic(char *msg);
 
 static void i91uSCBPost(BYTE * pHcb, BYTE * pScb);
@@ -192,7 +183,7 @@
 extern void tul_release_scb(HCS * pHCB, SCB * pSCB);
 extern void tul_stop_bm(HCS * pHCB);
 extern int tul_reset_scsi(HCS * pCurHcb, int seconds);
-extern int tul_isr(HCS * pHCB);
+extern void tul_isr(int irqno, void *dev_id, struct pt_regs *regs);
 extern int tul_reset(HCS * pHCB, Scsi_Cmnd * pSRB, unsigned char target);
 extern int tul_reset_scsi_bus(HCS * pCurHcb);
 extern int tul_device_reset(HCS * pCurHcb, ULONG pSrb, unsigned int target, unsigned int ResetFlags);
@@ -207,6 +198,18 @@
 	{ DMX_VENDOR_ID, I920_DEVICE_ID },
 };
 
+#ifdef MODULE
+static struct pci_device_id ini9100u_pci_tbl[] __initdata = {
+  { INI_VENDOR_ID, I950_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { INI_VENDOR_ID, I940_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { INI_VENDOR_ID, I935_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { INI_VENDOR_ID, I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { DMX_VENDOR_ID, I920_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ini9100u_pci_tbl);
+#endif
+
 /*
  *  queue services:
  */
@@ -392,6 +395,7 @@
 			release_region(pHCB->HCS_Base, 256);
 			return 0;
 		}
+		pHCB->host = hreg;
 		hreg->io_port = pHCB->HCS_Base;
 		hreg->n_io_port = 0xff;
 		hreg->can_queue = tul_num_scb;	/* 03/05/98                      */
@@ -404,35 +408,13 @@
 		hreg->sg_tablesize = TOTAL_SG_ENTRY;	/* Maximun support is 32 */
 
 		/* Initial tulip chip           */
-		switch (i) {
-		case 0:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr0, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		case 1:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr1, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		case 2:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr2, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		case 3:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr3, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		case 4:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr4, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		case 5:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr5, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		case 6:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr6, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		case 7:
-			ok = request_irq(pHCB->HCS_Intr, i91u_intr7, SA_INTERRUPT | SA_SHIRQ, "i91u", hreg);
-			break;
-		default:
+		if (i <= 7)
+			ok = request_irq(pHCB->HCS_Intr, tul_isr,
+					 SA_INTERRUPT | SA_SHIRQ, "i91u",
+					 &tul_hcs[i]);
+		else
 			i91u_panic("i91u: Too many host adapters\n");
-			break;
-		}
+
 		if (ok < 0) {
 			if (ok == -EINVAL) {
 				printk("i91u: bad IRQ %d.\n", pHCB->HCS_Intr);
@@ -691,121 +673,6 @@
 		tul_release_scb(pHCB, pSCB);	/* Release SCB for current channel */
 	}
 	return;
-}
-
-/*
- * Interrupts handler (main routine of the driver)
- */
-static void i91u_intr0(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[0].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[0]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-static void i91u_intr1(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[1].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[1]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-static void i91u_intr2(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[2].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[2]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-static void i91u_intr3(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[3].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[3]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-static void i91u_intr4(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[4].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[4]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-static void i91u_intr5(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[5].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[5]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-static void i91u_intr6(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[6].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[6]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
-}
-
-static void i91u_intr7(int irqno, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (tul_hcs[7].HCS_Intr != irqno)
-		return;
-
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	tul_isr(&tul_hcs[7]);
-
-	spin_unlock_irqrestore(&io_request_lock, flags);
 }
 
 /* 
diff -u linux-2.5.2-pre11/drivers/scsi/ini9100u.h linux/drivers/scsi/ini9100u.h
--- linux-2.5.2-pre11/drivers/scsi/ini9100u.h	Wed Nov 28 10:22:27 2001
+++ linux/drivers/scsi/ini9100u.h	Thu Jan 10 08:11:29 2002
@@ -272,6 +272,7 @@
 	spinlock_t HCS_AvailLock;
 	spinlock_t HCS_SemaphLock;
 	spinlock_t pSRB_lock;
+	struct Scsi_Host *host;
 	struct pci_dev *pci_dev;
 } HCS;
 
diff -u linux-2.5.2-pre11/drivers/scsi/inia100.c linux/drivers/scsi/inia100.c
--- linux-2.5.2-pre11/drivers/scsi/inia100.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/inia100.c	Thu Jan 10 07:16:10 2002
@@ -137,6 +137,26 @@
 extern int orc_num_scb;
 extern ORC_HCS orc_hcs[];
 
+#ifdef MODULE
+static struct pci_device_id inia100_pci_tbl[] __initdata = {
+	{
+	  vendor: ORC_VENDOR_ID,
+	  device: I920_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: ORC_VENDOR_ID,
+	  device: ORC_DEVICE_ID,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, inia100_pci_tbl);
+#endif
+
+
 /*****************************************************************************
  Function name  : inia100AppendSRBToQueue
  Description    : This function will push current request into save list
@@ -385,6 +405,7 @@
 			release_region(pHCB->HCS_Base, 256);	/* Register */
 			return 0;
 		}
+		pHCB->host = hreg;
 		hreg->io_port = pHCB->HCS_Base;
 		hreg->n_io_port = 0xff;
 		hreg->can_queue = orc_num_scb;	/* 03/05/98                   */
@@ -721,15 +742,14 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&io_request_lock, flags);
-
-	if (pHCB->HCS_Intr != irqno) {
-		spin_unlock_irqrestore(&io_request_lock, flags);
+	if (pHCB->HCS_Intr != irqno)
 		return;
-	}
+
+	spin_lock_irqsave(&pHCB->host->host_lock, flags);
+
 	orc_interrupt(pHCB);
 
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(&pHCB->host->host_lock, flags);
 }
 
 /*
diff -u linux-2.5.2-pre11/drivers/scsi/inia100.h linux/drivers/scsi/inia100.h
--- linux-2.5.2-pre11/drivers/scsi/inia100.h	Wed Nov 28 10:22:27 2001
+++ linux/drivers/scsi/inia100.h	Thu Jan 10 08:11:29 2002
@@ -386,6 +386,7 @@
 	Scsi_Cmnd *pSRB_head;
 	Scsi_Cmnd *pSRB_tail;
 	spinlock_t pSRB_lock;
+	struct Scsi_Host *host;
 } ORC_HCS;
 
 /* Bit Definition for HCS_Flags */
diff -u linux-2.5.2-pre11/drivers/scsi/ips.c linux/drivers/scsi/ips.c
--- linux-2.5.2-pre11/drivers/scsi/ips.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/ips.c	Thu Jan  3 20:12:33 2002
@@ -547,6 +547,27 @@
 __setup("ips=", ips_setup);
 #endif
 
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) && defined(MODULE)
+static struct pci_device_id ips_pci_tbl[] __initdata = {
+	{
+	  vendor: IPS_VENDORID,
+	  device: IPS_DEVICEID_MORPHEUS,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: IPS_VENDORID,
+	  device: IPS_DEVICEID_COPPERHEAD,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ips_pci_tbl);
+#endif
+
+
+
 /****************************************************************************/
 /*                                                                          */
 /* Routine Name: ips_detect                                                 */
diff -u linux-2.5.2-pre11/drivers/scsi/megaraid.c linux/drivers/scsi/megaraid.c
--- linux-2.5.2-pre11/drivers/scsi/megaraid.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/megaraid.c	Thu Jan 10 06:29:06 2002
@@ -528,6 +528,7 @@
 #include "hosts.h"
 
 #include "megaraid.h"
+#include <scsi/scsicam.h>
 
 /*
  *================================================================
@@ -581,6 +582,31 @@
 MODULE_DESCRIPTION ("LSI Logic MegaRAID driver");
 MODULE_LICENSE ("GPL");
 
+#ifdef MODULE
+static struct pci_device_id megaraid_pci_tbl[] __initdata = {
+	{
+	  vendor: 0x101E,
+	  device: 0x9010,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: 0x101E,
+	  device: 0x9060,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: 0x8086,
+	  device: 0x1960,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, megaraid_pci_tbl);
+#endif /* MODULE */
+
 #define DRIVER_LOCK_T
 #define DRIVER_LOCK_INIT(p)
 #define DRIVER_LOCK(p)
@@ -4557,7 +4583,7 @@
 #endif
 	IO_LOCK_T;
 
-	if (!inode || !(dev = inode->i_rdev))
+	if (!inode || kdev_none(dev = inode->i_rdev))
 		return -EINVAL;
 
 	if (_IOC_TYPE (cmd) != MEGAIOC_MAGIC)
@@ -5104,16 +5130,14 @@
 	 * Stop sending commands to the controller, queue them internally.
 	 * When deletion is complete, ISR will flush the queue.
 	 */
-	IO_LOCK;
 	this_hba->quiescent = 1;
-	IO_UNLOCK;
 
 	while( this_hba->qPcnt ) {
 			sleep_on_timeout( &wq, 1*HZ );	/* sleep for 1s */
 	}
 	rval = mega_do_del_logdrv(this_hba, logdrv);
 
-	IO_LOCK;
+	IO_LOCK(this_hba->host);
 	/*
 	 * Attach the internal queue to the pending queue
 	 */
@@ -5158,7 +5182,7 @@
 	}
 	this_hba->quiescent = 0;
 
-	IO_UNLOCK;
+	IO_UNLOCK(this_hba->host);
 
 	return rval;
 }
diff -u linux-2.5.2-pre11/drivers/scsi/ncr53c8xx.c linux/drivers/scsi/ncr53c8xx.c
--- linux-2.5.2-pre11/drivers/scsi/ncr53c8xx.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/ncr53c8xx.c	Mon Dec 31 16:02:05 2001
@@ -9225,6 +9225,25 @@
 	PCI_DEVICE_ID_NCR_53C1510D
 };
 
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) && defined(MODULE)
+static struct pci_device_id ncr53c8xx_pci_tbl[] __initdata = {
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C815, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C820, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C825, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C860, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875J, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C885, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C896, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895A, PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C1510D, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ncr53c8xx_pci_tbl);
+#endif
+
 /*==========================================================
 **
 **	Chip detection entry point.
diff -u linux-2.5.2-pre11/drivers/scsi/osst.c linux/drivers/scsi/osst.c
--- linux-2.5.2-pre11/drivers/scsi/osst.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/osst.c	Thu Jan 10 07:32:08 2002
@@ -125,8 +125,8 @@
 #define OSST_TIMEOUT (200 * HZ)
 #define OSST_LONG_TIMEOUT (1800 * HZ)
 
-#define TAPE_NR(x) (MINOR(x) & ~(128 | ST_MODE_MASK))
-#define TAPE_MODE(x) ((MINOR(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
+#define TAPE_NR(x) (minor(x) & ~(128 | ST_MODE_MASK))
+#define TAPE_MODE(x) ((minor(x) & ST_MODE_MASK) >> ST_MODE_SHIFT)
 
 /* Internal ioctl to set both density (uppermost 8 bits) and blocksize (lower
    24 bits) */
@@ -4103,7 +4103,7 @@
 		return (-EBUSY);
 	}
 	STp->in_use       = 1;
-	STp->rew_at_close = (MINOR(inode->i_rdev) & 0x80) == 0;
+	STp->rew_at_close = (minor(inode->i_rdev) & 0x80) == 0;
 
 	if (STp->device->host->hostt->module)
 		 __MOD_INC_USE_COUNT(STp->device->host->hostt->module);
@@ -4124,7 +4124,7 @@
 	flags = filp->f_flags;
 	STp->write_prot = ((flags & O_ACCMODE) == O_RDONLY);
 
-	STp->raw = (MINOR(inode->i_rdev) & 0x40) != 0;
+	STp->raw = (minor(inode->i_rdev) & 0x40) != 0;
 
 	/* Allocate a buffer for this user */
 	need_dma_buffer = STp->restr_dma;
@@ -5407,7 +5407,7 @@
 #endif
 
 	tpnt->device = SDp;
-	tpnt->devt = MKDEV(MAJOR_NR, i);
+	tpnt->devt = mk_kdev(MAJOR_NR, i);
 	tpnt->dirty = 0;
 	tpnt->in_use = 0;
 	tpnt->drv_buffer = 1;  /* Try buffering if no mode sense */
diff -u linux-2.5.2-pre11/drivers/scsi/pci2000.c linux/drivers/scsi/pci2000.c
--- linux-2.5.2-pre11/drivers/scsi/pci2000.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/pci2000.c	Sat Jan  5 03:20:09 2002
@@ -53,6 +53,7 @@
 #include "hosts.h"
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include "pci2000.h"
 #include "psi_roy.h"
@@ -102,6 +103,18 @@
 #define HOSTDATA(host) ((PADAPTER2000)&host->hostdata)
 #define consistentLen (MAX_BUS * MAX_UNITS * (16 * sizeof (SCATGATH) + MAX_COMMAND_SIZE))
 
+#ifdef MODULE
+static struct pci_device_id pci2000_pci_tbl[] __initdata = {
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_ROY_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pci2000_pci_tbl);
+#endif
 
 static struct	Scsi_Host 	   *PsiHost[MAXADAPTER] = {NULL,};  // One for each adapter
 static			int				NumAdapters = 0;
diff -u linux-2.5.2-pre11/drivers/scsi/pci2220i.c linux/drivers/scsi/pci2220i.c
--- linux-2.5.2-pre11/drivers/scsi/pci2220i.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/pci2220i.c	Thu Jan  3 20:12:30 2002
@@ -51,6 +51,7 @@
 #include <linux/blk.h>
 #include <linux/timer.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/dma.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -75,6 +76,24 @@
 
 #define MAXADAPTER 4					// Increase this and the sizes of the arrays below, if you need more.
 
+#ifdef MODULE
+static struct pci_device_id pci2220i_pci_tbl[] __initdata = {
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_DALE_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: VENDOR_PSI,
+	  device: DEVICE_BIGD_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, pci2220i_pci_tbl);
+#endif
 
 typedef struct
 	{
Common subdirectories: linux-2.5.2-pre11/drivers/scsi/pcmcia and linux/drivers/scsi/pcmcia
diff -u linux-2.5.2-pre11/drivers/scsi/ppa.c linux/drivers/scsi/ppa.c
--- linux-2.5.2-pre11/drivers/scsi/ppa.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/ppa.c	Thu Jan 10 07:25:46 2002
@@ -119,7 +119,6 @@
      * unlock to allow the lowlevel parport driver to probe
      * the irqs
      */
-    spin_unlock_irq(&io_request_lock);
     pb = parport_enumerate();
 
     printk("ppa: Version %s\n", PPA_VERSION);
@@ -128,7 +127,6 @@
 
     if (!pb) {
 	printk("ppa: parport reports no devices.\n");
-	spin_lock_irq(&io_request_lock);
 	return 0;
     }
   retry_entry:
@@ -154,7 +152,6 @@
 		      "pardevice is owning the port for too longtime!\n",
 			   i);
 		    parport_unregister_device(ppa_hosts[i].dev);
-		    spin_lock_irq(&io_request_lock);
 		    return 0;
 		}
 	    }
@@ -223,13 +220,11 @@
 	    printk("  supported by the imm (ZIP Plus) driver. If the\n");
 	    printk("  cable is marked with \"AutoDetect\", this is what has\n");
 	    printk("  happened.\n");
-	    spin_lock_irq(&io_request_lock);
 	    return 0;
 	}
 	try_again = 1;
 	goto retry_entry;
     } else {
-	spin_lock_irq(&io_request_lock);
 	return 1;		/* return number of hosts detected */
     }
 }
@@ -847,9 +842,9 @@
 
     tmp->cur_cmd = 0;
     
-    spin_lock_irqsave(&io_request_lock, flags);
+    spin_lock_irqsave(&cmd->host->host_lock, flags);
     cmd->scsi_done(cmd);
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&cmd->host->host_lock, flags);
     return;
 }
 
diff -u linux-2.5.2-pre11/drivers/scsi/psi240i.c linux/drivers/scsi/psi240i.c
--- linux-2.5.2-pre11/drivers/scsi/psi240i.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/psi240i.c	Thu Jan 10 04:07:08 2002
@@ -370,10 +370,11 @@
 static void do_Irq_Handler (int irq, void *dev_id, struct pt_regs *regs)
 	{
 	unsigned long flags;
+        struct Scsi_Host *host = PsiHost[irq - 10];
 
-	spin_lock_irqsave(&io_request_lock, flags);
+        spin_lock_irqsave(&host->host_lock, flags);
 	Irq_Handler(irq, dev_id, regs);
-	spin_unlock_irqrestore(&io_request_lock, flags);
+        spin_unlock_irqrestore(&host->host_lock, flags);
 	}
 /****************************************************************
  *	Name:	Psi240i_QueueCommand
diff -u linux-2.5.2-pre11/drivers/scsi/qla1280.c linux/drivers/scsi/qla1280.c
--- linux-2.5.2-pre11/drivers/scsi/qla1280.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/qla1280.c	Thu Jan 10 05:26:13 2002
@@ -206,6 +206,7 @@
 #include <linux/proc_fs.h>
 #include <linux/blk.h>
 #include <linux/tqueue.h>
+#include <linux/init.h>
 /* MRS #include <linux/tasks.h> */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,95)
 # include <linux/bios32.h>
@@ -486,6 +487,18 @@
   {"        ",                 0,           0}
 };
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) && defined(MODULE)
+static struct pci_device_id qla1280_pci_tbl[] __initdata = {
+  { QLA1280_VENDOR_ID, QLA1080_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA1240_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA1280_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA12160_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { QLA1280_VENDOR_ID, QLA10160_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, qla1280_pci_tbl);
+#endif
+
 static unsigned long qla1280_verbose = 1L;
 static scsi_qla_host_t *qla1280_hostlist = NULL;
 #ifdef QLA1280_PROFILE
@@ -1523,11 +1536,11 @@
         return;
     }
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,95)
-    spin_lock_irqsave(&io_request_lock, cpu_flags);
+    spin_lock_irqsave(&ha->host->host_lock, cpu_flags);
     if(test_and_set_bit(QLA1280_IN_ISR_BIT, &ha->flags))
     {
         COMTRACE('X')
-        spin_unlock_irqrestore(&io_request_lock, cpu_flags);
+        spin_unlock_irqrestore(&ha->host->host_lock, cpu_flags);
         return;
     }
     ha->isr_count++;
@@ -1548,7 +1561,7 @@
         qla1280_done(ha, (srb_t **)&ha->done_q_first, (srb_t **)&ha->done_q_last);
 
     clear_bit(QLA1280_IN_ISR_BIT, &ha->flags);
-    spin_unlock_irqrestore(&io_request_lock, cpu_flags);
+    spin_unlock_irqrestore(&ha->host->host_lock, cpu_flags);
 #else  /* LINUX_VERSION_CODE < KERNEL_VERSION(2,1,95) */
 
     if( test_bit(QLA1280_IN_ISR_BIT, (int *)&ha->flags) )
@@ -1619,7 +1632,7 @@
 
     COMTRACE('p')  
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,95)
-    spin_lock_irqsave(&io_request_lock, cpu_flags);
+    spin_lock_irqsave(&ha->host->host_lock, cpu_flags);
 #endif
     if (ha->flags.isp_abort_needed)
         qla1280_abort_isp(ha);
@@ -1631,7 +1644,7 @@
         qla1280_done(ha, (srb_t **)&ha->done_q_first, (srb_t **)&ha->done_q_last);
     ha->flags.dpc_sched = FALSE;
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,95)
-    spin_unlock_irqrestore(&io_request_lock, cpu_flags);
+    spin_unlock_irqrestore(&ha->host->host_lock, cpu_flags);
 #endif
 }
 
diff -u linux-2.5.2-pre11/drivers/scsi/qlogicfc.c linux/drivers/scsi/qlogicfc.c
--- linux-2.5.2-pre11/drivers/scsi/qlogicfc.c	Sun Dec 16 12:20:20 2001
+++ linux/drivers/scsi/qlogicfc.c	Sun Dec 16 23:51:27 2001
@@ -60,6 +60,7 @@
 #include <linux/delay.h>
 #include <linux/unistd.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 
@@ -678,6 +679,26 @@
 #if DEBUG_ISP2x00_INTR
 static void isp2x00_print_status_entry(struct Status_Entry *);
 #endif
+
+#ifdef MODULE
+static struct pci_device_id qlogicfc_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_QLOGIC,
+	  device: PCI_DEVICE_ID_QLOGIC_ISP2100,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_QLOGIC,
+	  device: PCI_DEVICE_ID_QLOGIC_ISP2200,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, qlogicfc_pci_tbl);
+#endif
+
 
 static inline void isp2x00_enable_irqs(struct Scsi_Host *host)
 {
diff -u linux-2.5.2-pre11/drivers/scsi/qlogicisp.c linux/drivers/scsi/qlogicisp.c
--- linux-2.5.2-pre11/drivers/scsi/qlogicisp.c	Sun Dec 16 12:20:20 2001
+++ linux/drivers/scsi/qlogicisp.c	Sun Dec 16 23:51:29 2001
@@ -34,6 +34,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/byteorder.h>
+#include <linux/init.h>
 
 #include "sd.h"
 #include "hosts.h"
@@ -65,6 +66,19 @@
 /* End Configuration section *************************************************/
 
 #include <linux/module.h>
+
+#ifdef MODULE
+static struct pci_device_id qlogicisp_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_QLOGIC,
+	  device: PCI_DEVICE_ID_QLOGIC_ISP1020,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, qlogicisp_pci_tbl);
+#endif
 
 #if TRACE_ISP
 
diff -u linux-2.5.2-pre11/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- linux-2.5.2-pre11/drivers/scsi/scsi.h	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/scsi.h	Thu Jan 10 08:04:44 2002
@@ -449,8 +449,6 @@
  */
 void scsi_resize_dma_pool(void);
 int scsi_init_minimal_dma_pool(void);
-void *scsi_malloc(unsigned int);
-int scsi_free(void *, unsigned int);
 
 /*
  * Prototypes for functions in scsi_merge.c
@@ -792,11 +790,11 @@
 	Scsi_Pointer SCp;	/* Scratchpad used by some host adapters */
 
 	unsigned char *host_scribble;	/* The host adapter is allowed to
-					   * call scsi_malloc and get some memory
+					   * call kmalloc and get some memory
 					   * and hang it here.     The host adapter
-					   * is also expected to call scsi_free
+					   * is also expected to call kfree
 					   * to release this memory.  (The memory
-					   * obtained by scsi_malloc is guaranteed
+					   * obtained by kmalloc(...,GFP_DMA) is guaranteed
 					   * to be at an address < 16Mb). */
 
 	int result;		/* Status code from lower level driver */
diff -u linux-2.5.2-pre11/drivers/scsi/scsi_debug.c linux/drivers/scsi/scsi_debug.c
--- linux-2.5.2-pre11/drivers/scsi/scsi_debug.c	Sun Dec 16 12:20:20 2001
+++ linux/drivers/scsi/scsi_debug.c	Thu Jan 10 07:43:05 2002
@@ -88,6 +88,8 @@
     if (bufflen != 1024) {printk("%d", bufflen); panic("(1)Bad bufflen");};         \
     start = 0;                          \
     if ((MINOR(SCpnt->request.rq_dev) & 0xf) != 0) start = starts[(MINOR(SCpnt->request.rq_dev) & 0xf) - 1];        \
+
+#ifdef FIXME_BIO
     if (bh){                            \
 	if (bh->b_size != 1024) panic ("Wrong bh size");    \
 	if ((bh->b_blocknr << 1) + start != block)          \
@@ -97,6 +99,7 @@
 	if (bh->b_dev != SCpnt->request.rq_dev)  \
 	    panic ("Bad bh target"); \
     };
+#endif
 
 #define VERIFY_DEBUG(RW)                            \
     if (bufflen != 1024 && (!SCpnt->use_sg)) {printk("%x %d\n ",bufflen, SCpnt->use_sg); panic("Bad bufflen");};    \
@@ -106,6 +109,8 @@
     if (SCpnt->request.cmd != RW) panic ("Wrong  operation");       \
     if (SCpnt->request.sector + start != block) panic("Wrong block.");  \
     if (SCpnt->request.current_nr_sectors != 2 && (!SCpnt->use_sg)) panic ("Wrong # blocks");   \
+
+# ifdef FIXME_BIO
     if (SCpnt->request.bh){                         \
 	if (SCpnt->request.bh->b_size != 1024) panic ("Wrong bh size"); \
 	if ((SCpnt->request.bh->b_blocknr << 1) + start != block)           \
@@ -115,6 +120,7 @@
 	if (SCpnt->request.bh->b_dev != SCpnt->request.rq_dev) \
 	    panic ("Bad bh target");\
     };
+# endif /* FIXME_BIO */
 #endif
 
 typedef void (*done_fct_t) (Scsi_Cmnd *);
@@ -189,7 +195,9 @@
 	unchar *cmd = (unchar *) SCpnt->cmnd;
 	struct partition *p;
 	int block;
+#ifdef FIXME_BIO
 	struct buffer_head *bh = NULL;
+#endif
 	unsigned char *buff;
 	int nbytes, sgcount;
 	int scsi_debug_errsts;
@@ -205,9 +213,9 @@
         /*
          * The io_request_lock *must* be held at this point.
          */
-        if( io_request_lock.lock == 0 )
+        if( SCpnt->host->host_lock.lock == 0 )
         {
-                printk("Warning - io_request_lock is not held in queuecommand\n");
+                printk("Warning - host_lock is not held in queuecommand\n");
         }
 #endif
 
@@ -301,7 +309,7 @@
 		SCSI_LOG_LLQUEUE(3, printk("Read Capacity\n"));
                 SHpnt = SCpnt->host;
 		if (NR_REAL < 0)
-			NR_REAL = (MINOR(SCpnt->request.rq_dev) >> 4) & 0x0f;
+			NR_REAL = (minor(SCpnt->request.rq_dev) >> 4) & 0x0f;
 		memset(buff, 0, bufflen);
 		buff[0] = (CAPACITY >> 24);
 		buff[1] = (CAPACITY >> 16) & 0xff;
@@ -343,7 +351,9 @@
 			sgpnt = (struct scatterlist *) buff;
 			buff = sgpnt[sgcount].address;
 			bufflen = sgpnt[sgcount].length;
+#ifdef FIXME_BIO
 			bh = SCpnt->request.bh;
+#endif
 		};
 		scsi_debug_errsts = 0;
 		do {
@@ -423,15 +433,19 @@
 #endif
 			nbytes -= bufflen;
 			if (SCpnt->use_sg) {
-#ifdef CLEAR
+#if defined(CLEAR) && defined(FIXME_BIO)
 				memcpy(buff + 128, bh, sizeof(struct buffer_head));
 #endif
 				block += bufflen >> 9;
+#ifdef FIXME_BIO
 				bh = bh->b_reqnext;
+#endif
 				sgcount++;
 				if (nbytes) {
+#ifdef FIXME_BIO
 					if (!bh)
 						panic("Too few blocks for linked request.");
+#endif
 					buff = sgpnt[sgcount].address;
 					bufflen = sgpnt[sgcount].length;
 				};
@@ -442,9 +456,11 @@
 		(done) (SCpnt);
 		return 0;
 
+#ifdef FIXME_BIO
 		if (SCpnt->use_sg && !scsi_debug_errsts)
 			if (bh)
 				scsi_dump(SCpnt, 0);
+#endif
 		break;
 	case WRITE_10:
 	case WRITE_6:
diff -u linux-2.5.2-pre11/drivers/scsi/seagate.c linux/drivers/scsi/seagate.c
--- linux-2.5.2-pre11/drivers/scsi/seagate.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/seagate.c	Thu Jan 10 05:29:47 2002
@@ -253,6 +253,7 @@
 						   boards or FD for TMC-8xx
 						   boards */
 static int irq = IRQ;
+static struct Scsi_Host *instance;
 
 MODULE_PARM (base_address, "i");
 MODULE_PARM (controller_type, "b");
@@ -427,7 +428,6 @@
 
 int __init seagate_st0x_detect (Scsi_Host_Template * tpnt)
 {
-	struct Scsi_Host *instance;
 	int i, j;
 
 	tpnt->proc_name = "seagate";
@@ -630,9 +630,9 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave (&io_request_lock, flags);
+	spin_lock_irqsave (&instance->host_lock, flags);
 	seagate_reconnect_intr (irq, dev_id, regs);
-	spin_unlock_irqrestore (&io_request_lock, flags);
+	spin_unlock_irqrestore (&instance->host_lock, flags);
 }
 
 static void seagate_reconnect_intr (int irq, void *dev_id, struct pt_regs *regs)
diff -u linux-2.5.2-pre11/drivers/scsi/sym53c416.c linux/drivers/scsi/sym53c416.c
--- linux-2.5.2-pre11/drivers/scsi/sym53c416.c	Sun Sep 30 12:26:07 2001
+++ linux/drivers/scsi/sym53c416.c	Thu Jan 10 05:23:47 2002
@@ -359,11 +359,11 @@
 	}
 	/* Now we have the base address and we can start handling the interrupt */
 
-	spin_lock_irqsave(&io_request_lock,flags);
+	spin_lock_irqsave(&current_command->host->host_lock,flags);
 	status_reg = inb(base + STATUS_REG);
 	pio_int_reg = inb(base + PIO_INT_REG);
 	int_reg = inb(base + INT_REG);
-	spin_unlock_irqrestore(&io_request_lock, flags);
+	spin_unlock_irqrestore(&current_command->host->host_lock, flags);
 
 	/* First, we handle error conditions */
 	if(int_reg & SCI)         /* SCSI Reset */
@@ -371,9 +371,9 @@
 		printk(KERN_DEBUG "sym53c416: Reset received\n");
 		current_command->SCp.phase = idle;
 		current_command->result = DID_RESET << 16;
-		spin_lock_irqsave(&io_request_lock, flags);
+		spin_lock_irqsave(&current_command->host->host_lock, flags);
 		current_command->scsi_done(current_command);
-		spin_unlock_irqrestore(&io_request_lock, flags);
+		spin_unlock_irqrestore(&current_command->host->host_lock, flags);
 		return;
 	}
 	if(int_reg & ILCMD)       /* Illegal Command */
@@ -381,9 +381,9 @@
 		printk(KERN_WARNING "sym53c416: Illegal Command: 0x%02x.\n", inb(base + COMMAND_REG));
 		current_command->SCp.phase = idle;
 		current_command->result = DID_ERROR << 16;
-		spin_lock_irqsave(&io_request_lock, flags);
+		spin_lock_irqsave(&current_command->host->host_lock, flags);
 		current_command->scsi_done(current_command);
-		spin_unlock_irqrestore(&io_request_lock, flags);
+		spin_unlock_irqrestore(&current_command->host->host_lock, flags);
 		return;
 	}
 	if(status_reg & GE)         /* Gross Error */
@@ -391,9 +391,9 @@
 		printk(KERN_WARNING "sym53c416: Controller reports gross error.\n");
 		current_command->SCp.phase = idle;
 		current_command->result = DID_ERROR << 16;
-		spin_lock_irqsave(&io_request_lock, flags);
+		spin_lock_irqsave(&current_command->host->host_lock, flags);
 		current_command->scsi_done(current_command);
-		spin_unlock_irqrestore(&io_request_lock, flags);
+		spin_unlock_irqrestore(&current_command->host->host_lock, flags);
 		return;
 	}
 	if(status_reg & PE)         /* Parity Error */
@@ -401,9 +401,9 @@
 		printk(KERN_WARNING "sym53c416:SCSI parity error.\n");
 		current_command->SCp.phase = idle;
 		current_command->result = DID_PARITY << 16;
-		spin_lock_irqsave(&io_request_lock, flags);
+		spin_lock_irqsave(&current_command->host->host_lock, flags);
 		current_command->scsi_done(current_command);
-		spin_unlock_irqrestore(&io_request_lock, flags);
+		spin_unlock_irqrestore(&current_command->host->host_lock, flags);
 		return;
 	}
 	if(pio_int_reg & (CE | OUE))
@@ -411,9 +411,9 @@
 		printk(KERN_WARNING "sym53c416: PIO interrupt error.\n");
 		current_command->SCp.phase = idle;
 		current_command->result = DID_ERROR << 16;
-		spin_lock_irqsave(&io_request_lock, flags);
+		spin_lock_irqsave(&current_command->host->host_lock, flags);
 		current_command->scsi_done(current_command);
-		spin_unlock_irqrestore(&io_request_lock, flags);
+		spin_unlock_irqrestore(&current_command->host->host_lock, flags);
 		return;
 	}
 	if(int_reg & DIS)           /* Disconnect */
@@ -423,9 +423,9 @@
 		else
 			current_command->result = (current_command->SCp.Status & 0xFF) | ((current_command->SCp.Message & 0xFF) << 8) | (DID_OK << 16);
 		current_command->SCp.phase = idle;
-		spin_lock_irqsave(&io_request_lock, flags);
+		spin_lock_irqsave(&current_command->host->host_lock, flags);
 		current_command->scsi_done(current_command);
-		spin_unlock_irqrestore(&io_request_lock, flags);
+		spin_unlock_irqrestore(&current_command->host->host_lock, flags);
 		return;
 	}
 	/* Now we handle SCSI phases         */
diff -u linux-2.5.2-pre11/drivers/scsi/sym53c8xx.c linux/drivers/scsi/sym53c8xx.c
--- linux-2.5.2-pre11/drivers/scsi/sym53c8xx.c	Sun Dec 16 12:20:21 2001
+++ linux/drivers/scsi/sym53c8xx.c	Sun Dec 16 23:51:31 2001
@@ -578,6 +578,27 @@
 
 #endif	/* LINUX_VERSION_CODE >= LinuxVersionCode(2,2,0) */
 
+#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,0) && defined(MODULE)
+static struct pci_device_id sym53c8xx_pci_tbl[] __initdata = {
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C815,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C820,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C825,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C860,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C875J,    PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C885,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C896,     PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C895A,    PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C1510D,   PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_LSI_53C1010,    PCI_ANY_ID, PCI_ANY_ID },
+  { PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_LSI_53C1010_66, PCI_ANY_ID, PCI_ANY_ID },
+  { }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, sym53c8xx_pci_tbl);
+#endif
+
 /* Does not make sense in earlier kernels */
 #if LINUX_VERSION_CODE < LinuxVersionCode(2,4,0)
 #define pci_enable_device(pdev)		(0)
Common subdirectories: linux-2.5.2-pre11/drivers/scsi/sym53c8xx_2 and linux/drivers/scsi/sym53c8xx_2
diff -u linux-2.5.2-pre11/drivers/scsi/tmscsim.c linux/drivers/scsi/tmscsim.c
--- linux-2.5.2-pre11/drivers/scsi/tmscsim.c	Thu Jan 10 07:59:28 2002
+++ linux/drivers/scsi/tmscsim.c	Thu Jan 10 06:03:33 2002
@@ -304,8 +304,8 @@
 #  define DC390_IFLAGS unsigned long iflags;
 #  define DC390_DFLAGS unsigned long dflags; 
 
-#  define DC390_LOCK_IO spin_lock_irqsave (&io_request_lock, iflags)
-#  define DC390_UNLOCK_IO spin_unlock_irqrestore (&io_request_lock, iflags)
+#  define DC390_LOCK_IO spin_lock_irqsave (&pACB->pScsiHost->host_lock, iflags)
+#  define DC390_UNLOCK_IO spin_unlock_irqrestore (&pACB->pScsiHost->host_lock, iflags)
 
 #  define DC390_LOCK_DRV spin_lock_irqsave (&dc390_drvlock, dflags)
 #  define DC390_UNLOCK_DRV spin_unlock_irqrestore (&dc390_drvlock, dflags)
@@ -349,8 +349,8 @@
 #   define DC390_IFLAGS unsigned long iflags;
 #   define DC390_DFLAGS unsigned long dflags; 
     spinlock_t dc390_drvlock = SPIN_LOCK_UNLOCKED;
-#   define DC390_LOCK_IO spin_lock_irqsave (&io_request_lock, iflags)
-#   define DC390_UNLOCK_IO spin_unlock_irqrestore (&io_request_lock, iflags)
+#   define DC390_LOCK_IO spin_lock_irqsave (&pACB->pScsiHost->host_lock, iflags)
+#   define DC390_UNLOCK_IO spin_unlock_irqrestore (&pACB->pScsiHost->host_lock, iflags)
 #   define DC390_LOCK_DRV spin_lock_irqsave (&dc390_drvlock, dflags)
 #   define DC390_UNLOCK_DRV spin_unlock_irqrestore (&dc390_drvlock, dflags)
 #   define DC390_LOCK_DRV_NI spin_lock (&dc390_drvlock)
diff -u linux-2.5.2-pre11/drivers/scsi/ultrastor.c linux/drivers/scsi/ultrastor.c
--- linux-2.5.2-pre11/drivers/scsi/ultrastor.c	Sun Sep 30 12:26:08 2001
+++ linux/drivers/scsi/ultrastor.c	Thu Jan 10 04:20:19 2002
@@ -254,6 +254,7 @@
 #endif
   volatile unsigned char aborted[ULTRASTOR_MAX_CMDS];
   struct mscp mscp[ULTRASTOR_MAX_CMDS];
+  struct Scsi_Host *host;
 } config = {0};
 
 /* Set this to 1 to reset the SCSI bus on error.  */
@@ -605,6 +606,7 @@
              free_irq(config.interrupt, do_ultrastor_interrupt);
              return FALSE;
       }
+      config.host = shpnt; 
 
       shpnt->irq = config.interrupt;
       shpnt->dma_channel = config.dma_channel;
@@ -1160,9 +1162,9 @@
 {
     unsigned long flags;
 
-    spin_lock_irqsave(&io_request_lock, flags);
+    spin_lock_irqsave(&config.host->host_lock, flags);
     ultrastor_interrupt(irq, dev_id, regs);
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&config.host->host_lock, flags);
 }
 
 MODULE_LICENSE("GPL");

--k+w/mQv8wyuph6w0--
