Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSDNLji>; Sun, 14 Apr 2002 07:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312181AbSDNLjh>; Sun, 14 Apr 2002 07:39:37 -0400
Received: from pD954F818.dip.t-dialin.net ([217.84.248.24]:39565 "EHLO
	linux-buechse.de") by vger.kernel.org with ESMTP id <S312178AbSDNLjb>;
	Sun, 14 Apr 2002 07:39:31 -0400
Date: Sun, 14 Apr 2002 13:39:25 +0200
From: "Juergen E. Fischer" <fischer@norbit.de>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch] aha152x.c
Message-ID: <20020414113925.GA10001@linux-buechse.de>
Reply-To: fischer@linux-buechse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi there,

attached a patch for the aha152x driver.

Jürgen

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aha152x-2.5.diff"

diff -ur orig/linux-2.5/drivers/scsi/aha152x.c linux-2.5/drivers/scsi/aha152x.c
--- orig/linux-2.5/drivers/scsi/aha152x.c	Wed Feb 20 03:10:54 2002
+++ linux-2.5/drivers/scsi/aha152x.c	Sun Apr 14 13:25:20 2002
@@ -13,9 +13,14 @@
  * General Public License for more details.
  *
  *
- * $Id: aha152x.c,v 2.4 2000/12/16 12:53:56 fischer Exp $
+ * $Id: aha152x.c,v 2.5 2002/04/14 11:24:53 fischer Exp $
  *
  * $Log: aha152x.c,v $
+ * Revision 2.5  2002/04/14 11:24:53  fischer
+ * - isapnp support
+ * - abort fixed
+ * - 2.5 support
+ *
  * Revision 2.4  2000/12/16 12:53:56  fischer
  * - allow REQUEST SENSE to be queued
  * - handle shared PCI interrupts
@@ -222,7 +227,9 @@
 #endif
 
 #include <linux/sched.h>
+#include <asm/irq.h>
 #include <asm/io.h>
+#include <linux/version.h>
 #include <linux/blk.h>
 #include "scsi.h"
 #include "sd.h"
@@ -306,15 +313,17 @@
 
 #define DELAY_DEFAULT 1000
 
-/* possible irq range */
 #if defined(PCMCIA)
 #define IRQ_MIN 0
 #define IRQ_MAX 16
 #else
 #define IRQ_MIN 9
+#if defined(__PPC)
+#define IRQ_MAX (NR_IRQS-1)
+#else
 #define IRQ_MAX 12
 #endif
-#define IRQS    IRQ_MAX-IRQ_MIN+1
+#endif
 
 enum {
 	not_issued	= 0x0001,	/* command not yet issued */
@@ -417,7 +426,7 @@
 	char *conf;
 } setup[2];
 
-static struct Scsi_Host *aha152x_host[IRQS];
+static struct Scsi_Host *aha152x_host[2];
 
 /*
  * internal states of the host
@@ -593,6 +602,7 @@
 #define SCDONE(SCpnt)		SCDATA(SCpnt)->done
 #define SCSEM(SCpnt)		SCDATA(SCpnt)->sem
 
+#define SG_ADDRESS(buffer)	((char *) (page_address((buffer)->page)+(buffer)->offset))
 
 /* state handling */
 static void seldi_run(struct Scsi_Host *shpnt);
@@ -668,7 +678,6 @@
 
 /* possible i/o addresses for the AIC-6260; default first */
 static unsigned short ports[] = { 0x340, 0x140 };
-#define PORT_COUNT (sizeof(ports) / sizeof(unsigned short))
 
 #if !defined(SKIP_BIOSTEST)
 /* possible locations for the Adaptec BIOS; defaults first */
@@ -684,7 +693,6 @@
 	0xeb800,		/* VTech Platinum SMP */
 	0xf0000,
 };
-#define ADDRESS_COUNT (sizeof(addresses) / sizeof(unsigned int))
 
 /* signatures for various AIC-6[23]60 based controllers.
    The point in detecting signatures is to avoid useless and maybe
@@ -726,8 +734,6 @@
 	{ "DTC3520A Host Adapter BIOS", 0x318a, 26 },
 		/* DTC 3520A ISA SCSI */
 };
-
-#define SIGNATURE_COUNT (sizeof(signatures) / sizeof(struct signature))
 #endif
 
 
@@ -806,7 +812,7 @@
 #if defined(PCMCIA) || !defined(MODULE)
 void aha152x_setup(char *str, int *ints)
 {
-	if(setup_count>2) {
+	if(setup_count>=ARRAY_SIZE(setup)) {
 		printk(KERN_ERR "aha152x: you can only configure up to two controllers\n");
 		return;
 	}
@@ -849,7 +855,7 @@
 #endif
 	int count=setup_count;
 
-	get_options(str, sizeof(ints)/sizeof(int), ints);
+	get_options(str, ARRAY_SIZE(ints), ints);
 	aha152x_setup(str,ints);
 
 	return count<setup_count;
@@ -903,10 +909,10 @@
 
 #if !defined(PCMCIA)
 	int i;
-	for (i = 0; i < PORT_COUNT && (setup->io_port != ports[i]); i++)
+	for (i = 0; i < ARRAY_SIZE(ports) && (setup->io_port != ports[i]); i++)
 		;
 
-	if (i == PORT_COUNT)
+	if (i == ARRAY_SIZE(ports))
 		return 0;
 #endif
 
@@ -939,12 +945,25 @@
 	return 1;
 }
 
+static inline struct Scsi_Host *lookup_irq(int irqno)
+{
+	int i;
+
+	for(i=0; i<ARRAY_SIZE(aha152x_host); i++)
+		if(aha152x_host[i] && aha152x_host[i]->irq==irqno)
+			return aha152x_host[i];
+
+	return 0;
+}
+
 static void swintr(int irqno, void *dev_id, struct pt_regs *regs)
 {
-	struct Scsi_Host *shpnt = aha152x_host[irqno - IRQ_MIN];
+	struct Scsi_Host *shpnt = lookup_irq(irqno);
 
-	if (!shpnt)
-        	printk(KERN_ERR "aha152x%d: catched software interrupt for unknown controller.\n", HOSTNO);
+	if (!shpnt) {
+        	printk(KERN_ERR "aha152x%d: catched software interrupt %d for unknown controller.\n", HOSTNO, irqno);
+		return;
+	}
 
 	HOSTDATA(shpnt)->swint++;
 
@@ -966,7 +985,7 @@
 #endif
 	tpnt->proc_name = "aha152x"; 
 
-	for (i = 0; i < IRQS; i++)
+	for (i = 0; i < ARRAY_SIZE(aha152x_host); i++)
 		aha152x_host[i] = (struct Scsi_Host *) NULL;
 
 	if (setup_count) {
@@ -981,7 +1000,7 @@
 	}
 
 #if defined(SETUP0)
-	if (setup_count < 2) {
+	if (setup_count < ARRAY_SIZE(setup)) {
 		struct aha152x_setup override = SETUP0;
 
 		if (setup_count == 0 || (override.io_port != setup[0].io_port)) {
@@ -1002,7 +1021,7 @@
 #endif
 
 #if defined(SETUP1)
-	if (setup_count < 2) {
+	if (setup_count < ARRAY_SIZE(setup)) {
 		struct aha152x_setup override = SETUP1;
 
 		if (setup_count == 0 || (override.io_port != setup[0].io_port)) {
@@ -1023,7 +1042,7 @@
 #endif
 
 #if defined(MODULE)
-	if (setup_count<2 && (aha152x[0]!=0 || io[0]!=0 || irq[0]!=0)) {
+	if (setup_count<ARRAY_SIZE(setup) && (aha152x[0]!=0 || io[0]!=0 || irq[0]!=0)) {
 		if(aha152x[0]!=0) {
 			setup[setup_count].conf        = "";
 			setup[setup_count].io_port     = aha152x[0];
@@ -1066,7 +1085,7 @@
 			       setup[setup_count].ext_trans);
 	}
 
-	if (setup_count < 2 && (aha152x1[0]!=0 || io[1]!=0 || irq[1]!=0)) {
+	if (setup_count<ARRAY_SIZE(setup) && (aha152x1[0]!=0 || io[1]!=0 || irq[1]!=0)) {
 		if(aha152x1[0]!=0) {
 			setup[setup_count].conf        = "";
 			setup[setup_count].io_port     = aha152x1[0];
@@ -1110,7 +1129,7 @@
 #endif
 
 #ifdef __ISAPNP__
-	while ( setup_count<2 && (dev=isapnp_find_dev(NULL, ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1505), dev)) ) {
+	while ( setup_count<ARRAY_SIZE(setup) && (dev=isapnp_find_dev(NULL, ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1505), dev)) ) {
 		if (dev->prepare(dev) < 0)
 			continue;
 		if (dev->active)
@@ -1145,11 +1164,11 @@
 
 
 #if defined(AUTOCONF)
-	if (setup_count < 2) {
+	if (setup_count<ARRAY_SIZE(setup)) {
 #if !defined(SKIP_BIOSTEST)
 		ok = 0;
-		for (i = 0; i < ADDRESS_COUNT && !ok; i++)
-			for (j = 0; (j < SIGNATURE_COUNT) && !ok; j++)
+		for (i = 0; i < ARRAY_SIZE(addresses) && !ok; i++)
+			for (j = 0; j<ARRAY_SIZE(signatures) && !ok; j++)
 				ok = isa_check_signature(addresses[i] + signatures[j].sig_offset,
 								signatures[j].signature, signatures[j].sig_length);
 
@@ -1162,7 +1181,7 @@
 #endif				/* !SKIP_BIOSTEST */
 
 		ok = 0;
-		for (i = 0; i < PORT_COUNT && setup_count < 2; i++) {
+		for (i = 0; i < ARRAY_SIZE(ports) && setup_count < 2; i++) {
 			if ((setup_count == 1) && (setup[0].io_port == ports[i]))
 				continue;
 
@@ -1217,7 +1236,7 @@
 	for (i=0; i<setup_count; i++) {
 		struct Scsi_Host *shpnt;
 
-		aha152x_host[setup[i].irq - IRQ_MIN] = shpnt =
+		aha152x_host[registered_count] = shpnt =
 		    scsi_register(tpnt, sizeof(struct aha152x_hostdata));
 
 		if(!shpnt) {
@@ -1341,7 +1360,7 @@
 			scsi_unregister(shpnt);
 			registered_count--;
 			release_region(shpnt->io_port, IO_RANGE);
-			aha152x_host[shpnt->irq - IRQ_MIN] = 0;
+			aha152x_host[registered_count] = 0;
 			shpnt = 0;
 			continue;
 		}
@@ -1349,9 +1368,7 @@
 
 		printk(KERN_INFO "aha152x%d: trying software interrupt, ", HOSTNO);
 		SETPORT(DMACNTRL0, SWINT|INTEN);
-		spin_unlock_irq(shpnt->host_lock);
 		mdelay(1000);
-		spin_lock_irq(shpnt->host_lock);
 		free_irq(shpnt->irq, shpnt);
 
 		if (!HOSTDATA(shpnt)->swint) {
@@ -1367,7 +1384,7 @@
 
 			registered_count--;
 			release_region(shpnt->io_port, IO_RANGE);
-			aha152x_host[shpnt->irq - IRQ_MIN] = 0;
+			aha152x_host[registered_count] = 0;
 			scsi_unregister(shpnt);
 			shpnt=NULL;
 			continue;
@@ -1382,10 +1399,11 @@
 		if (request_irq(shpnt->irq, intr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) < 0) {
 			printk(KERN_ERR "aha152x%d: failed to reassign interrupt.\n", HOSTNO);
 
-			scsi_unregister(shpnt);
 			registered_count--;
 			release_region(shpnt->io_port, IO_RANGE);
-			shpnt = aha152x_host[shpnt->irq - IRQ_MIN] = 0;
+			aha152x_host[registered_count] = 0;
+			scsi_unregister(shpnt);
+			shpnt=NULL;
 			continue;
 		}
 	}
@@ -1494,7 +1512,7 @@
 	   SCp.phase            : current state of the command */
 	if (SCpnt->use_sg) {
 		SCpnt->SCp.buffer           = (struct scatterlist *) SCpnt->request_buffer;
-		SCpnt->SCp.ptr              = SCpnt->SCp.buffer->address;
+		SCpnt->SCp.ptr              = SG_ADDRESS(SCpnt->SCp.buffer);
 		SCpnt->SCp.this_residual    = SCpnt->SCp.buffer->length;
 		SCpnt->SCp.buffers_residual = SCpnt->use_sg - 1;
 	} else {
@@ -1584,7 +1602,6 @@
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
 		printk(DEBUG_LEAD "abort(%p)", CMDINFO(SCpnt), SCpnt);
 		show_queues(shpnt);
-		mdelay(1000);
 	}
 #endif
 
@@ -1622,9 +1639,19 @@
 
 static void timer_expired(unsigned long p)
 {
-	struct semaphore *sem = (void *)p;
+	Scsi_Cmnd	 *SCp   = (Scsi_Cmnd *)p;
+	struct semaphore *sem   = SCSEM(SCp);
+	struct Scsi_Host *shpnt = SCp->host;
+
+	/* remove command from issue queue */
+	if(remove_SC(&ISSUE_SC, SCp)) {
+		printk(KERN_INFO "aha152x: ABORT timed out - removed from issue queue\n");
+		kfree(SCp->host_scribble);
+		SCp->host_scribble=0;
+	} else {
+		printk(KERN_INFO "aha152x: ABORT timed out - not on issue queue\n");
+	}
 
-	printk(KERN_INFO "aha152x: timer expired\n");
 	up(sem);
 }
 
@@ -1645,7 +1672,6 @@
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
 		printk(INFO_LEAD "aha152x_device_reset(%p)", CMDINFO(SCpnt), SCpnt);
 		show_queues(shpnt);
-		mdelay(1000);
 	}
 #endif
 
@@ -1663,13 +1689,13 @@
 	cmnd.request_bufflen = 0;
 
 	init_timer(&timer);
-	timer.data     = (unsigned long) &sem;
+	timer.data     = (unsigned long) &cmnd;
 	timer.expires  = jiffies + 100*HZ;   /* 10s */
 	timer.function = (void (*)(unsigned long)) timer_expired;
-	add_timer(&timer);
 
 	aha152x_internal_queue(&cmnd, &sem, resetting, 0, internal_done);
 
+	add_timer(&timer);
 	down(&sem);
 
 	del_timer(&timer);
@@ -1719,7 +1745,6 @@
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
 		printk(DEBUG_LEAD "aha152x_bus_reset(%p)", CMDINFO(SCpnt), SCpnt);
 		show_queues(shpnt);
-		mdelay(1000);
 	}
 #endif
 
@@ -1878,7 +1903,7 @@
 static void run(void)
 {
 	int i;
-	for (i = 0; i < IRQS; i++) {
+	for (i = 0; i<ARRAY_SIZE(aha152x_host); i++) {
 		struct Scsi_Host *shpnt = aha152x_host[i];
 		if (shpnt && HOSTDATA(shpnt)->service) {
 			HOSTDATA(shpnt)->service=0;
@@ -1894,10 +1919,10 @@
 
 static void intr(int irqno, void *dev_id, struct pt_regs *regs)
 {
-	struct Scsi_Host *shpnt = aha152x_host[irqno - IRQ_MIN];
+	struct Scsi_Host *shpnt = lookup_irq(irqno);
 
 	if (!shpnt) {
-		printk(KERN_ERR "aha152x: catched interrupt for unknown controller.\n");
+		printk(KERN_ERR "aha152x: catched interrupt %d for unknown controller.\n", irqno);
 		return;
 	}
 
@@ -2681,7 +2706,7 @@
                                		/* advance to next buffer */
                                		CURRENT_SC->SCp.buffers_residual--;
                                		CURRENT_SC->SCp.buffer++;
-                               		CURRENT_SC->SCp.ptr           = CURRENT_SC->SCp.buffer->address;
+                               		CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
                                		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 				} 
                 	}
@@ -2791,7 +2816,7 @@
 			/* advance to next buffer */
 			CURRENT_SC->SCp.buffers_residual--;
 			CURRENT_SC->SCp.buffer++;
-			CURRENT_SC->SCp.ptr           = CURRENT_SC->SCp.buffer->address;
+			CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
 			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 		}
 
@@ -2821,13 +2846,13 @@
 		CURRENT_SC->resid += data_count;
 
 		if(CURRENT_SC->use_sg) {
-			data_count -= CURRENT_SC->SCp.ptr - CURRENT_SC->SCp.buffer->address;
+			data_count -= CURRENT_SC->SCp.ptr - SG_ADDRESS(CURRENT_SC->SCp.buffer);
 			while(data_count>0) {
 				CURRENT_SC->SCp.buffer--;
 				CURRENT_SC->SCp.buffers_residual++;
 				data_count -= CURRENT_SC->SCp.buffer->length;
 			}
-			CURRENT_SC->SCp.ptr           = CURRENT_SC->SCp.buffer->address - data_count;
+			CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer) - data_count;
 			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length + data_count;
 		} else {
 			CURRENT_SC->SCp.ptr           -= data_count;
@@ -2955,10 +2980,9 @@
 	int pending;
 
 	DO_LOCK(flags);
-	if(HOSTDATA(shpnt)->in_intr!=0)
-	{
+	if(HOSTDATA(shpnt)->in_intr!=0) {
 		DO_UNLOCK(flags);
-		/* _error never returns.. */
+		/* aha152x_error never returns.. */
 		aha152x_error(shpnt, "bottom-half already running!?");
 	}
 	HOSTDATA(shpnt)->in_intr++;
@@ -3765,7 +3789,7 @@
 	unsigned long flags;
 	int thislength;
 
-	for (i = 0, shpnt = (struct Scsi_Host *) NULL; i < IRQS; i++)
+	for (i = 0, shpnt = (struct Scsi_Host *) NULL; i<ARRAY_SIZE(aha152x_host); i++)
 		if (aha152x_host[i] && aha152x_host[i]->host_no == hostno)
 			shpnt = aha152x_host[i];
 
diff -ur orig/linux-2.5/drivers/scsi/aha152x.h linux-2.5/drivers/scsi/aha152x.h
--- orig/linux-2.5/drivers/scsi/aha152x.h	Wed Feb 20 03:10:55 2002
+++ linux-2.5/drivers/scsi/aha152x.h	Sun Apr 14 13:25:21 2002
@@ -2,7 +2,7 @@
 #define _AHA152X_H
 
 /*
- * $Id: aha152x.h,v 2.4 2000/12/16 12:48:48 fischer Exp $
+ * $Id: aha152x.h,v 2.5 2002/04/14 11:24:12 fischer Exp $
  */
 
 #if defined(__KERNEL__)
@@ -27,7 +27,7 @@
    (unless we support more than 1 cmd_per_lun this should do) */
 #define AHA152X_MAXQUEUE 7
 
-#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.4 $"
+#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.5 $"
 
 /* Initial value of Scsi_Host entry */
 #define AHA152X { proc_name:			"aha152x",		\

--PEIAKu/WMn1b1Hv9--
