Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTDYNPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTDYNPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:15:11 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:57105 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263132AbTDYNOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:14:00 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha1740 update, take #2
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
	<20030424133641.A29770@infradead.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 25 Apr 2003 15:24:11 +0200
Message-ID: <wrp1xzqsoas.fsf_-_@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030424133641.A29770@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, Christoph,

Here is the updated aha1740 driver. All remarks have been taken into
account (patch is quite huge because of the re-indentation).

I removed the the scsi_to_dma_dir part, and sent it over to James (you
still need it though, see my previous mail to LKML for the patch).

Summary :
- Use EISA framework,
- Use DMA API,
- Use hotplug SCSI model (yeah, right... :-),

Patch is against latest 2.5.68-bk.

Thanks,

        M.

--- linux/drivers/scsi/aha1740.c	2003-04-25 13:59:36.000000000 +0200
+++ linux-2.5/drivers/scsi/aha1740.c	2003-04-25 13:42:53.000000000 +0200
@@ -8,6 +8,7 @@
  *
  *  This file is aha1740.c, written and
  *  Copyright (C) 1992,1993  Brad McLean
+ *  brad@saturn.gaylord.com or brad@bradpc.gaylord.com.
  *  
  *  Modifications to makecode and queuecommand
  *  for proper handling of multiple devices courteously
@@ -23,6 +24,9 @@
  *
  * Reworked for new_eh and new locking by Alan Cox <alan@redhat.com>
  *
+ * Converted to EISA and generic DMA APIs by Marc Zyngier
+ * <maz@wild-wind.fr.eu.org>, 4/2003.
+ *
  * For the avoidance of doubt the "preferred form" of this code is one which
  * is in an open non patent encumbered format. Where cryptographic key signing
  * forms part of the process of creating an executable the information
@@ -39,6 +43,10 @@
 #include <linux/ioport.h>
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/eisa.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -58,501 +66,602 @@
 #define DEB(x)
 #endif
 
-/*
-static const char RCSid[] = "$Header: /usr/src/linux/kernel/blk_drv/scsi/RCS/aha1740.c,v 1.1 1992/07/24 06:27:38 root Exp root $";
-*/
-
 struct aha1740_hostdata {
-    unsigned int slot;
-    unsigned int translation;
-    unsigned int last_ecb_used;
-    struct ecb ecb[AHA1740_ECBS];
+	struct eisa_device *edev;
+	unsigned int translation;
+	unsigned int last_ecb_used;
+	dma_addr_t ecb_dma_addr;
+	struct ecb ecb[AHA1740_ECBS];
+};
+
+struct aha1740_sg {
+	struct aha1740_chain sg_chain[AHA1740_SCATTER];
+	dma_addr_t sg_dma_addr;
+	dma_addr_t buf_dma_addr;
 };
 
 #define HOSTDATA(host) ((struct aha1740_hostdata *) &host->hostdata)
 
 static spinlock_t aha1740_lock = SPIN_LOCK_UNLOCKED;
 
-/* One for each IRQ level (9-15) */
-static struct Scsi_Host * aha_host[8] = {NULL, };
+static inline struct ecb *ecb_dma_to_cpu (struct Scsi_Host *host,
+					  dma_addr_t dma)
+{
+	struct aha1740_hostdata *hdata = HOSTDATA (host);
+	dma_addr_t offset;
+
+	offset = dma - hdata->ecb_dma_addr;
+
+	return (struct ecb *)(((char *) hdata->ecb) + (unsigned int) offset);
+}
+
+static inline dma_addr_t ecb_cpu_to_dma (struct Scsi_Host *host, void *cpu)
+{
+	struct aha1740_hostdata *hdata = HOSTDATA (host);
+	dma_addr_t offset;
+    
+	offset = (char *) cpu - (char *) hdata->ecb;
+
+	return hdata->ecb_dma_addr + offset;
+}
 
 static int aha1740_proc_info(char *buffer, char **start, off_t offset,
-		      int length, int hostno, int inout)
+			     int length, int hostno, int inout)
 {
-    int len;
-    struct Scsi_Host * shpnt;
-    struct aha1740_hostdata *host;
-
-    if (inout)
-	return-ENOSYS;
-
-    for (len = 0; len < 8; len++) {
-	shpnt = aha_host[len];
-	if (shpnt && shpnt->host_no == hostno)
-	    break;
-    }
-    host = HOSTDATA(shpnt);
-
-    len = sprintf(buffer, "aha174x at IO:%lx, IRQ %d, SLOT %d.\n"
-		  "Extended translation %sabled.\n",
-		  shpnt->io_port, shpnt->irq, host->slot,
-		  host->translation ? "en" : "dis");
+	int len;
+	struct Scsi_Host * shpnt;
+	struct aha1740_hostdata *host;
 
-    if (offset > len) {
-	*start = buffer;
-	return 0;
-    }
+	if (inout)
+		return-ENOSYS;
+
+	if (!(shpnt = scsi_host_hn_get (hostno)))
+		return 0;
 
-    *start = buffer + offset;
-    len -= offset;
-    if (len > length)
-	len = length;
-    return len;
+	host = HOSTDATA(shpnt);
+
+	len = sprintf(buffer, "aha174x at IO:%lx, IRQ %d, SLOT %d.\n"
+		      "Extended translation %sabled.\n",
+		      shpnt->io_port, shpnt->irq, host->edev->slot,
+		      host->translation ? "en" : "dis");
+
+	if (offset > len) {
+		*start = buffer;
+		return 0;
+	}
+
+	*start = buffer + offset;
+	len -= offset;
+	if (len > length)
+		len = length;
+	return len;
 }
 
 
 static int aha1740_makecode(unchar *sense, unchar *status)
 {
-    struct statusword
-    {
-	ushort	don:1,	/* Command Done - No Error */
-		du:1,	/* Data underrun */
-	:1,	qf:1,	/* Queue full */
-		sc:1,	/* Specification Check */
-		dor:1,	/* Data overrun */
-		ch:1,	/* Chaining Halted */
-		intr:1,	/* Interrupt issued */
-		asa:1,	/* Additional Status Available */
-		sns:1,	/* Sense information Stored */
-	:1,	ini:1,	/* Initialization Required */
-		me:1,	/* Major error or exception */
-	:1,	eca:1,  /* Extended Contingent alliance */
-	:1;
-    } status_word;
-    int retval = DID_OK;
+	struct statusword
+	{
+		ushort	don:1,	/* Command Done - No Error */
+			du:1,	/* Data underrun */
+		    :1,	qf:1,	/* Queue full */
+		        sc:1,	/* Specification Check */
+		        dor:1,	/* Data overrun */
+		        ch:1,	/* Chaining Halted */
+		        intr:1,	/* Interrupt issued */
+		        asa:1,	/* Additional Status Available */
+		        sns:1,	/* Sense information Stored */
+		    :1,	ini:1,	/* Initialization Required */
+			me:1,	/* Major error or exception */
+		    :1,	eca:1,  /* Extended Contingent alliance */
+		    :1;
+	} status_word;
+	int retval = DID_OK;
 
-    status_word = * (struct statusword *) status;
+	status_word = * (struct statusword *) status;
 #ifdef DEBUG
-    printk("makecode from %x,%x,%x,%x %x,%x,%x,%x",
-	   status[0], status[1], status[2], status[3],
-	   sense[0], sense[1], sense[2], sense[3]);
+	printk("makecode from %x,%x,%x,%x %x,%x,%x,%x",
+	       status[0], status[1], status[2], status[3],
+	       sense[0], sense[1], sense[2], sense[3]);
 #endif
-    if (!status_word.don) /* Anything abnormal was detected */
-    {
-	if ( (status[1]&0x18) || status_word.sc ) /*Additional info available*/
-	{
-	    /* Use the supplied info for further diagnostics */
-	    switch ( status[2] )
-	    {
-	    case 0x12:
-		if ( status_word.dor )
-		    retval=DID_ERROR;	/* It's an Overrun */
-		/* If not overrun, assume underrun and ignore it! */
-	    case 0x00: /* No info, assume no error, should not occur */
-		break;
-	    case 0x11:
-	    case 0x21:
-		retval=DID_TIME_OUT;
-		break;
-	    case 0x0a:
-		retval=DID_BAD_TARGET;
-		break;
-	    case 0x04:
-	    case 0x05:
-		retval=DID_ABORT;
-		/* Either by this driver or the AHA1740 itself */
-		break;
-	    default:
-		retval=DID_ERROR; /* No further diagnostics possible */
-	    } 
+	if (!status_word.don) /* Anything abnormal was detected */
+	{
+		if ( (status[1]&0x18) || status_word.sc ) /*Additional info available*/
+		{
+			/* Use the supplied info for further diagnostics */
+			switch ( status[2] )
+			{
+			case 0x12:
+				if ( status_word.dor )
+					retval=DID_ERROR; /* It's an Overrun */
+				/* If not overrun, assume underrun and
+				 * ignore it! */
+			case 0x00: /* No info, assume no error, should
+				    * not occur */
+				break;
+			case 0x11:
+			case 0x21:
+				retval=DID_TIME_OUT;
+				break;
+			case 0x0a:
+				retval=DID_BAD_TARGET;
+				break;
+			case 0x04:
+			case 0x05:
+				retval=DID_ABORT;
+				/* Either by this driver or the
+				 * AHA1740 itself */
+				break;
+			default:
+				retval=DID_ERROR; /* No further
+						   * diagnostics
+						   * possible */
+			} 
+		}
+		else
+		{ /* Michael suggests, and Brad concurs: */
+			if ( status_word.qf )
+			{
+				retval = DID_TIME_OUT; /* forces a redo */
+				/* I think this specific one should
+				 * not happen -Brad */
+				printk("aha1740.c: WARNING: AHA1740 queue overflow!\n");
+			}
+			else if ( status[0]&0x60 )
+			{
+				retval = DID_ERROR; /* Didn't find a
+						     * better error */
+			}
+			/* In any other case return DID_OK so for example
+			   CONDITION_CHECKS make it through to the appropriate
+			   device driver */
+		}
 	}
-	else
-	{ /* Michael suggests, and Brad concurs: */
-	    if ( status_word.qf )
-	    {
-		retval = DID_TIME_OUT; /* forces a redo */
-		/* I think this specific one should not happen -Brad */
-		printk("aha1740.c: WARNING: AHA1740 queue overflow!\n");
-	    }
-	    else if ( status[0]&0x60 )
-	    {
-		retval = DID_ERROR; /* Didn't find a better error */
-	    }
-	    /* In any other case return DID_OK so for example
-	       CONDITION_CHECKS make it through to the appropriate
-	       device driver */
-	}
-    }
-    /* Under all circumstances supply the target status -Michael */
-    return status[3] | retval << 16;
+	/* Under all circumstances supply the target status -Michael */
+	return status[3] | retval << 16;
 }
 
 static int aha1740_test_port(unsigned int base)
 {
-    char name[4], tmp;
-
-    /* Okay, look for the EISA ID's */
-    name[0]= 'A' -1 + ((tmp = inb(HID0(base))) >> 2); /* First character */
-    name[1]= 'A' -1 + ((tmp & 3) << 3);
-    name[1]+= ((tmp = inb(HID1(base))) >> 5)&0x7;	/* Second Character */
-    name[2]= 'A' -1 + (tmp & 0x1f);		/* Third Character */
-    name[3]=0;
-    tmp = inb(HID2(base));
-    if ( strcmp ( name, HID_MFG ) || inb(HID2(base)) != HID_PRD )
-	return 0;   /* Not an Adaptec 174x */
-
-/*  if ( inb(HID3(base)) != HID_REV )
-	printk("aha174x: Warning; board revision of %d; expected %d\n",
-	    inb(HID3(base)),HID_REV); */
-
-    if ( inb(EBCNTRL(base)) != EBCNTRL_VALUE )
-    {
-	printk("aha174x: Board detected, but EBCNTRL = %x, so disabled it.\n",
-	    inb(EBCNTRL(base)));
-	return 0;
-    }
+	if ( inb(EBCNTRL(base)) != EBCNTRL_VALUE )
+	{
+		printk("aha174x: Board detected, but EBCNTRL = %x, so disabled it.\n",
+		       inb(EBCNTRL(base)));
+		return 0;
+	}
 
-    if ( inb(PORTADR(base)) & PORTADDR_ENH )
-	return 1;   /* Okay, we're all set */
+	if ( inb(PORTADR(base)) & PORTADDR_ENH )
+		return 1;   /* Okay, we're all set */
 	
-    printk("aha174x: Board detected, but not in enhanced mode, so disabled it.\n");
-    return 0;
+	printk("aha174x: Board detected, but not in enhanced mode, so disabled it.\n");
+	return 0;
 }
 
 /* A "high" level interrupt handler */
 static irqreturn_t aha1740_intr_handle(int irq, void *dev_id,
-					struct pt_regs *regs)
+				       struct pt_regs *regs)
 {
-    struct Scsi_Host *host = aha_host[irq - 9];
-    void (*my_done)(Scsi_Cmnd *);
-    int errstatus, adapstat;
-    int number_serviced;
-    struct ecb *ecbptr;
-    Scsi_Cmnd *SCtmp;
-    unsigned int base;
-    unsigned long flags;
-    int handled = 0;
-
-    if (!host)
-	panic("aha1740.c: Irq from unknown host!\n");
-    spin_lock_irqsave(host->host_lock, flags);
-    base = host->io_port;
-    number_serviced = 0;
-
-    while(inb(G2STAT(base)) & G2STAT_INTPEND)
-    {
-	handled = 1;
-	DEB(printk("aha1740_intr top of loop.\n"));
-	adapstat = inb(G2INTST(base));
-	ecbptr = (struct ecb *) isa_bus_to_virt(inl(MBOXIN0(base)));
-	outb(G2CNTRL_IRST,G2CNTRL(base)); /* interrupt reset */
-      
-	switch ( adapstat & G2INTST_MASK )
+	struct Scsi_Host *host = (struct Scsi_Host *) dev_id;
+        void (*my_done)(Scsi_Cmnd *);
+	int errstatus, adapstat;
+	int number_serviced;
+	struct ecb *ecbptr;
+	Scsi_Cmnd *SCtmp;
+	unsigned int base;
+	unsigned long flags;
+	int handled = 0;
+	struct aha1740_sg *sgptr;
+	struct eisa_device *edev;
+	
+	if (!host)
+		panic("aha1740.c: Irq from unknown host!\n");
+	spin_lock_irqsave(host->host_lock, flags);
+	base = host->io_port;
+	number_serviced = 0;
+	edev = HOSTDATA(host)->edev;
+
+	while(inb(G2STAT(base)) & G2STAT_INTPEND)
 	{
-	case	G2INTST_CCBRETRY:
-	case	G2INTST_CCBERROR:
-	case	G2INTST_CCBGOOD:
-	    /* Host Ready -> Mailbox in complete */
-	    outb(G2CNTRL_HRDY,G2CNTRL(base));
-	    if (!ecbptr)
-	    {
-		printk("Aha1740 null ecbptr in interrupt (%x,%x,%x,%d)\n",
-		       inb(G2STAT(base)),adapstat,
-		       inb(G2INTST(base)), number_serviced++);
-		continue;
-	    }
-	    SCtmp = ecbptr->SCpnt;
-	    if (!SCtmp)
-	    {
-		printk("Aha1740 null SCtmp in interrupt (%x,%x,%x,%d)\n",
-		       inb(G2STAT(base)),adapstat,
-		       inb(G2INTST(base)), number_serviced++);
-		continue;
-	    }
-	    if (SCtmp->host_scribble)
-		kfree(SCtmp->host_scribble);
-	    /* Fetch the sense data, and tuck it away, in the required slot.
-	       The Adaptec automatically fetches it, and there is no
-	       guarantee that we will still have it in the cdb when we come
-	       back */
-	    if ( (adapstat & G2INTST_MASK) == G2INTST_CCBERROR )
-	    {
-		memcpy(SCtmp->sense_buffer, ecbptr->sense, 
-		       sizeof(SCtmp->sense_buffer));
-		errstatus = aha1740_makecode(ecbptr->sense,ecbptr->status);
-	    }
-	    else
-		errstatus = 0;
-	    DEB(if (errstatus) printk("aha1740_intr_handle: returning %6x\n",
-				      errstatus));
-	    SCtmp->result = errstatus;
-	    my_done = ecbptr->done;
-	    memset(ecbptr,0,sizeof(struct ecb)); 
-	    if ( my_done )
-		my_done(SCtmp);
-	    break;
-	case	G2INTST_HARDFAIL:
-	    printk(KERN_ALERT "aha1740 hardware failure!\n");
-	    panic("aha1740.c");	/* Goodbye */
-	case	G2INTST_ASNEVENT:
-	    printk("aha1740 asynchronous event: %02x %02x %02x %02x %02x\n",
-		   adapstat, inb(MBOXIN0(base)), inb(MBOXIN1(base)),
-		   inb(MBOXIN2(base)), inb(MBOXIN3(base))); /* Say What? */
-	    /* Host Ready -> Mailbox in complete */
-	    outb(G2CNTRL_HRDY,G2CNTRL(base));
-	    break;
-	case	G2INTST_CMDGOOD:
-	    /* set immediate command success flag here: */
-	    break;
-	case	G2INTST_CMDERROR:
-	    /* Set immediate command failure flag here: */
-	    break;
+		handled = 1;
+		DEB(printk("aha1740_intr top of loop.\n"));
+		adapstat = inb(G2INTST(base));
+		ecbptr = ecb_dma_to_cpu (host, inl(MBOXIN0(base)));
+		outb(G2CNTRL_IRST,G2CNTRL(base)); /* interrupt reset */
+      
+		switch ( adapstat & G2INTST_MASK )
+		{
+		case	G2INTST_CCBRETRY:
+		case	G2INTST_CCBERROR:
+		case	G2INTST_CCBGOOD:
+			/* Host Ready -> Mailbox in complete */
+			outb(G2CNTRL_HRDY,G2CNTRL(base));
+			if (!ecbptr)
+			{
+				printk("Aha1740 null ecbptr in interrupt (%x,%x,%x,%d)\n",
+				       inb(G2STAT(base)),adapstat,
+				       inb(G2INTST(base)), number_serviced++);
+				continue;
+			}
+			SCtmp = ecbptr->SCpnt;
+			if (!SCtmp)
+			{
+				printk("Aha1740 null SCtmp in interrupt (%x,%x,%x,%d)\n",
+				       inb(G2STAT(base)),adapstat,
+				       inb(G2INTST(base)), number_serviced++);
+				continue;
+			}
+			sgptr = (struct aha1740_sg *) SCtmp->host_scribble;
+			if (SCtmp->use_sg) {
+				/* We used scatter-gather.
+				   Do the unmapping dance. */
+				dma_unmap_sg (&edev->dev,
+					      (struct scatterlist *) SCtmp->request_buffer,
+					      SCtmp->use_sg,
+					      scsi_to_dma_dir (SCtmp->sc_data_direction));
+			} else {
+				dma_unmap_single (&edev->dev,
+						  sgptr->buf_dma_addr,
+						  SCtmp->request_bufflen,
+						  DMA_BIDIRECTIONAL);
+			}
+	    
+			/* Free the sg block */
+			dma_free_coherent (&edev->dev,
+					   sizeof (struct aha1740_sg),
+					   SCtmp->host_scribble,
+					   sgptr->sg_dma_addr);
+	    
+			/* Fetch the sense data, and tuck it away, in
+			   the required slot.  The Adaptec
+			   automatically fetches it, and there is no
+			   guarantee that we will still have it in the
+			   cdb when we come back */
+			if ( (adapstat & G2INTST_MASK) == G2INTST_CCBERROR )
+			{
+				memcpy(SCtmp->sense_buffer, ecbptr->sense, 
+				       sizeof(SCtmp->sense_buffer));
+				errstatus = aha1740_makecode(ecbptr->sense,ecbptr->status);
+			}
+			else
+				errstatus = 0;
+			DEB(if (errstatus)
+			    printk("aha1740_intr_handle: returning %6x\n",
+				   errstatus));
+			SCtmp->result = errstatus;
+			my_done = ecbptr->done;
+			memset(ecbptr,0,sizeof(struct ecb)); 
+			if ( my_done )
+				my_done(SCtmp);
+			break;
+			
+		case	G2INTST_HARDFAIL:
+			printk(KERN_ALERT "aha1740 hardware failure!\n");
+			panic("aha1740.c");	/* Goodbye */
+			
+		case	G2INTST_ASNEVENT:
+			printk("aha1740 asynchronous event: %02x %02x %02x %02x %02x\n",
+			       adapstat,
+			       inb(MBOXIN0(base)),
+			       inb(MBOXIN1(base)),
+			       inb(MBOXIN2(base)),
+			       inb(MBOXIN3(base))); /* Say What? */
+			/* Host Ready -> Mailbox in complete */
+			outb(G2CNTRL_HRDY,G2CNTRL(base));
+			break;
+			
+		case	G2INTST_CMDGOOD:
+			/* set immediate command success flag here: */
+			break;
+			
+		case	G2INTST_CMDERROR:
+			/* Set immediate command failure flag here: */
+			break;
+		}
+		number_serviced++;
 	}
-	number_serviced++;
-    }
 
-    spin_unlock_irqrestore(host->host_lock, flags);
-    return IRQ_RETVAL(handled);
+	spin_unlock_irqrestore(host->host_lock, flags);
+	return IRQ_RETVAL(handled);
 }
 
 static int aha1740_queuecommand(Scsi_Cmnd * SCpnt, void (*done)(Scsi_Cmnd *))
 {
-    unchar direction;
-    unchar *cmd = (unchar *) SCpnt->cmnd;
-    unchar target = SCpnt->device->id;
-    struct aha1740_hostdata *host = HOSTDATA(SCpnt->device->host);
-    unsigned long flags;
-    void *buff = SCpnt->request_buffer;
-    int bufflen = SCpnt->request_bufflen;
-    int ecbno;
-    DEB(int i);
-
-    if(*cmd == REQUEST_SENSE)
-    {
-	SCpnt->result = 0;
-	done(SCpnt); 
-	return 0;
-    }
+	unchar direction;
+	unchar *cmd = (unchar *) SCpnt->cmnd;
+	unchar target = SCpnt->device->id;
+	struct aha1740_hostdata *host = HOSTDATA(SCpnt->device->host);
+	unsigned long flags;
+	void *buff = SCpnt->request_buffer;
+	int bufflen = SCpnt->request_bufflen;
+	dma_addr_t sg_dma;
+	struct aha1740_sg *sgptr;
+	int ecbno;
+	DEB(int i);
+
+	if(*cmd == REQUEST_SENSE)
+	{
+		SCpnt->result = 0;
+		done(SCpnt); 
+		return 0;
+	}
 
 #ifdef DEBUG
-    if (*cmd == READ_10 || *cmd == WRITE_10)
-	i = xscsi2int(cmd+2);
-    else if (*cmd == READ_6 || *cmd == WRITE_6)
-	i = scsi2int(cmd+2);
-    else
-	i = -1;
-    printk("aha1740_queuecommand: dev %d cmd %02x pos %d len %d ",
-	   target, *cmd, i, bufflen);
-    printk("scsi cmd:");
-    for (i = 0; i < SCpnt->cmd_len; i++) printk("%02x ", cmd[i]);
-    printk("\n");
+	if (*cmd == READ_10 || *cmd == WRITE_10)
+		i = xscsi2int(cmd+2);
+	else if (*cmd == READ_6 || *cmd == WRITE_6)
+		i = scsi2int(cmd+2);
+	else
+		i = -1;
+	printk("aha1740_queuecommand: dev %d cmd %02x pos %d len %d ",
+	       target, *cmd, i, bufflen);
+	printk("scsi cmd:");
+	for (i = 0; i < SCpnt->cmd_len; i++) printk("%02x ", cmd[i]);
+	printk("\n");
 #endif
 
-    /* locate an available ecb */
-
-    spin_lock_irqsave(&aha1740_lock, flags);
-    ecbno = host->last_ecb_used + 1;		/* An optimization */
-    if (ecbno >= AHA1740_ECBS)
-	ecbno = 0;
-    do {
-	if (!host->ecb[ecbno].cmdw)
-	    break;
-	ecbno++;
+	/* locate an available ecb */
+	spin_lock_irqsave(&aha1740_lock, flags);
+	ecbno = host->last_ecb_used + 1; /* An optimization */
 	if (ecbno >= AHA1740_ECBS)
-	    ecbno = 0;
-    } while (ecbno != host->last_ecb_used);
+		ecbno = 0;
+	do {
+		if (!host->ecb[ecbno].cmdw)
+			break;
+		ecbno++;
+		if (ecbno >= AHA1740_ECBS)
+			ecbno = 0;
+	} while (ecbno != host->last_ecb_used);
 
-    if (host->ecb[ecbno].cmdw)
-	panic("Unable to find empty ecb for aha1740.\n");
+	if (host->ecb[ecbno].cmdw)
+		panic("Unable to find empty ecb for aha1740.\n");
 
-    host->ecb[ecbno].cmdw = AHA1740CMD_INIT;	/* SCSI Initiator Command
-						   doubles as reserved flag */
+	host->ecb[ecbno].cmdw = AHA1740CMD_INIT; /* SCSI Initiator Command
+						    doubles as reserved flag */
 
-    host->last_ecb_used = ecbno;    
-    spin_unlock_irqrestore(&aha1740_lock, flags);
+	host->last_ecb_used = ecbno;    
+	spin_unlock_irqrestore(&aha1740_lock, flags);
 
 #ifdef DEBUG
-    printk("Sending command (%d %x)...", ecbno, done);
+	printk("Sending command (%d %x)...", ecbno, done);
 #endif
 
-    host->ecb[ecbno].cdblen = SCpnt->cmd_len;	/* SCSI Command Descriptor Block Length */
+	host->ecb[ecbno].cdblen = SCpnt->cmd_len; /* SCSI Command
+						   * Descriptor Block
+						   * Length */
 
-    direction = 0;
-    if (*cmd == READ_10 || *cmd == READ_6)
-	direction = 1;
-    else if (*cmd == WRITE_10 || *cmd == WRITE_6)
 	direction = 0;
-
-    memcpy(host->ecb[ecbno].cdb, cmd, SCpnt->cmd_len);
-
-    if (SCpnt->use_sg)
-    {
-	struct scatterlist * sgpnt;
-	struct aha1740_chain * cptr;
-	int i;
-	DEB(unsigned char * ptr);
-
-	host->ecb[ecbno].sg = 1;  /* SCSI Initiator Command  w/scatter-gather*/
-	SCpnt->host_scribble = (unsigned char *)kmalloc(512, GFP_KERNEL);
+	if (*cmd == READ_10 || *cmd == READ_6)
+		direction = 1;
+	else if (*cmd == WRITE_10 || *cmd == WRITE_6)
+		direction = 0;
+
+	memcpy(host->ecb[ecbno].cdb, cmd, SCpnt->cmd_len);
+
+	SCpnt->host_scribble = dma_alloc_coherent (&host->edev->dev,
+						   sizeof (struct aha1740_sg),
+						   &sg_dma, GFP_ATOMIC);
 	if(SCpnt->host_scribble == NULL)
 	{
 		printk(KERN_WARNING "aha1740: out of memory in queuecommand!\n");
 		return 1;
 	}
-	sgpnt = (struct scatterlist *) SCpnt->request_buffer;
-	cptr = (struct aha1740_chain *) SCpnt->host_scribble; 
-	for(i=0; i<SCpnt->use_sg; i++)
+	sgptr = (struct aha1740_sg *) SCpnt->host_scribble;
+	sgptr->sg_dma_addr = sg_dma;
+    
+	if (SCpnt->use_sg)
 	{
-	    cptr[i].datalen = sgpnt[i].length;
-	    cptr[i].dataptr = isa_virt_to_bus(page_address(sgpnt[i].page) + sgpnt[i].offset);
-	}
-	host->ecb[ecbno].datalen = SCpnt->use_sg * sizeof(struct aha1740_chain);
-	host->ecb[ecbno].dataptr = isa_virt_to_bus(cptr);
+		struct scatterlist * sgpnt;
+		struct aha1740_chain * cptr;
+		int i, count;
+		DEB(unsigned char * ptr);
+
+		host->ecb[ecbno].sg = 1;  /* SCSI Initiator Command
+					   * w/scatter-gather*/
+		sgpnt = (struct scatterlist *) SCpnt->request_buffer;
+		cptr = sgptr->sg_chain;
+		count = dma_map_sg (&host->edev->dev, sgpnt, SCpnt->use_sg,
+				    scsi_to_dma_dir(SCpnt->sc_data_direction));
+		for(i=0; i < count; i++)
+		{
+			cptr[i].datalen = sg_dma_len (sgpnt + i);
+			cptr[i].dataptr = sg_dma_address (sgpnt + i);
+		}
+		host->ecb[ecbno].datalen = count*sizeof(struct aha1740_chain);
+		host->ecb[ecbno].dataptr = sg_dma;
 #ifdef DEBUG
-	printk("cptr %x: ",cptr);
-	ptr = (unsigned char *) cptr;
-	for(i=0;i<24;i++) printk("%02x ", ptr[i]);
+		printk("cptr %x: ",cptr);
+		ptr = (unsigned char *) cptr;
+		for(i=0;i<24;i++) printk("%02x ", ptr[i]);
 #endif
-    }
-    else
-    {
-	SCpnt->host_scribble = NULL;
-	host->ecb[ecbno].datalen = bufflen;
-	host->ecb[ecbno].dataptr = isa_virt_to_bus(buff);
-    }
-    host->ecb[ecbno].lun = SCpnt->device->lun;
-    host->ecb[ecbno].ses = 1;	/* Suppress underrun errors */
-    host->ecb[ecbno].dir = direction;
-    host->ecb[ecbno].ars = 1;  /* Yes, get the sense on an error */
-    host->ecb[ecbno].senselen = 12;
-    host->ecb[ecbno].senseptr = isa_virt_to_bus(host->ecb[ecbno].sense);
-    host->ecb[ecbno].statusptr = isa_virt_to_bus(host->ecb[ecbno].status);
-    host->ecb[ecbno].done = done;
-    host->ecb[ecbno].SCpnt = SCpnt;
+	}
+	else
+	{
+		host->ecb[ecbno].datalen = bufflen;
+		sgptr->buf_dma_addr =  dma_map_single (&host->edev->dev,
+						       buff, bufflen,
+						       DMA_BIDIRECTIONAL);
+		host->ecb[ecbno].dataptr = sgptr->buf_dma_addr;
+	}
+	host->ecb[ecbno].lun = SCpnt->device->lun;
+	host->ecb[ecbno].ses = 1; /* Suppress underrun errors */
+	host->ecb[ecbno].dir = direction;
+	host->ecb[ecbno].ars = 1; /* Yes, get the sense on an error */
+	host->ecb[ecbno].senselen = 12;
+	host->ecb[ecbno].senseptr = ecb_cpu_to_dma (SCpnt->device->host,
+						    host->ecb[ecbno].sense);
+	host->ecb[ecbno].statusptr = ecb_cpu_to_dma (SCpnt->device->host,
+						     host->ecb[ecbno].status);
+	host->ecb[ecbno].done = done;
+	host->ecb[ecbno].SCpnt = SCpnt;
 #ifdef DEBUG
-    {
-	int i;
-	printk("aha1740_command: sending.. ");
-	for (i = 0; i < sizeof(host->ecb[ecbno]) - 10; i++)
-	    printk("%02x ", ((unchar *)&host->ecb[ecbno])[i]);
-    }
-    printk("\n");
+	{
+		int i;
+		printk("aha1740_command: sending.. ");
+		for (i = 0; i < sizeof(host->ecb[ecbno]) - 10; i++)
+			printk("%02x ", ((unchar *)&host->ecb[ecbno])[i]);
+	}
+	printk("\n");
 #endif
-    if (done)
-    { /*  The Adaptec Spec says the card is so fast that the loops will
-	  only be executed once in the code below. Even if this was true
-	  with the fastest processors when the spec was written, it doesn't
-	  seem to be true with todays fast processors. We print a warning
-	  if the code is executed more often than LOOPCNT_WARN. If this
-	  happens, it should be investigated. If the count reaches
-	  LOOPCNT_MAX, we assume something is broken; since there is no
-	  way to return an error (the return value is ignored by the
-	  mid-level scsi layer) we have to panic (and maybe that's the
-	  best thing we can do then anyhow). */
+	if (done)
+	{ /*  The Adaptec Spec says the card is so fast that the loops
+	      will only be executed once in the code below. Even if
+	      this was true with the fastest processors when the spec
+	      was written, it doesn't seem to be true with todays fast
+	      processors. We print a warning if the code is executed
+	      more often than LOOPCNT_WARN. If this happens, it should
+	      be investigated. If the count reaches LOOPCNT_MAX, we
+	      assume something is broken; since there is no way to
+	      return an error (the return value is ignored by the
+	      mid-level scsi layer) we have to panic (and maybe that's
+	      the best thing we can do then anyhow). */
 
 #define LOOPCNT_WARN 10		/* excessive mbxout wait -> syslog-msg */
 #define LOOPCNT_MAX 1000000	/* mbxout deadlock -> panic() after ~ 2 sec. */
-	int loopcnt;
-	unsigned int base = SCpnt->device->host->io_port;
-	DEB(printk("aha1740[%d] critical section\n",ecbno));
-
-	spin_lock_irqsave(&aha1740_lock, flags);
-	for (loopcnt = 0; ; loopcnt++) {
-	    if (inb(G2STAT(base)) & G2STAT_MBXOUT) break;
-	    if (loopcnt == LOOPCNT_WARN) {
-		printk("aha1740[%d]_mbxout wait!\n",ecbno);
-	    }
-	    if (loopcnt == LOOPCNT_MAX)
-		panic("aha1740.c: mbxout busy!\n");
-	}
-	outl(isa_virt_to_bus(host->ecb + ecbno), MBOXOUT0(base));
-	for (loopcnt = 0; ; loopcnt++) {
-	    if (! (inb(G2STAT(base)) & G2STAT_BUSY)) break;
-	    if (loopcnt == LOOPCNT_WARN) {
-		printk("aha1740[%d]_attn wait!\n",ecbno);
-	    }
-	    if (loopcnt == LOOPCNT_MAX)
-		panic("aha1740.c: attn wait failed!\n");
+		int loopcnt;
+		unsigned int base = SCpnt->device->host->io_port;
+		DEB(printk("aha1740[%d] critical section\n",ecbno));
+
+		spin_lock_irqsave(&aha1740_lock, flags);
+		for (loopcnt = 0; ; loopcnt++) {
+			if (inb(G2STAT(base)) & G2STAT_MBXOUT) break;
+			if (loopcnt == LOOPCNT_WARN) {
+				printk("aha1740[%d]_mbxout wait!\n",ecbno);
+			}
+			if (loopcnt == LOOPCNT_MAX)
+				panic("aha1740.c: mbxout busy!\n");
+		}
+		outl (ecb_cpu_to_dma (SCpnt->device->host, host->ecb + ecbno),
+		      MBOXOUT0(base));
+		for (loopcnt = 0; ; loopcnt++) {
+			if (! (inb(G2STAT(base)) & G2STAT_BUSY)) break;
+			if (loopcnt == LOOPCNT_WARN) {
+				printk("aha1740[%d]_attn wait!\n",ecbno);
+			}
+			if (loopcnt == LOOPCNT_MAX)
+				panic("aha1740.c: attn wait failed!\n");
+		}
+		outb(ATTN_START | (target & 7), ATTN(base)); /* Start it up */
+		spin_unlock_irqrestore(&aha1740_lock, flags);
+		DEB(printk("aha1740[%d] request queued.\n",ecbno));
 	}
-	outb(ATTN_START | (target & 7), ATTN(base)); /* Start it up */
-	spin_unlock_irqrestore(&aha1740_lock, flags);
-	DEB(printk("aha1740[%d] request queued.\n",ecbno));
-    }
-    else
-	printk(KERN_ALERT "aha1740_queuecommand: done can't be NULL\n");
-    return 0;
+	else
+		printk(KERN_ALERT "aha1740_queuecommand: done can't be NULL\n");
+	return 0;
 }
 
 static void internal_done(Scsi_Cmnd * SCpnt)
 {
-    SCpnt->SCp.Status++;
+	SCpnt->SCp.Status++;
 }
 
 static int aha1740_command(Scsi_Cmnd * SCpnt)
 {
-    aha1740_queuecommand(SCpnt, internal_done);
-    SCpnt->SCp.Status = 0;
-    while (!SCpnt->SCp.Status)
-    {
-	cpu_relax();
-	barrier();
-    }
-    return SCpnt->result;
+	aha1740_queuecommand(SCpnt, internal_done);
+	SCpnt->SCp.Status = 0;
+	while (!SCpnt->SCp.Status)
+	{
+		cpu_relax();
+		barrier();
+	}
+	return SCpnt->result;
 }
 
 /* Query the board for its irq_level.  Nothing else matters
    in enhanced mode on an EISA bus. */
 
 static void aha1740_getconfig(unsigned int base, unsigned int *irq_level,
-		       unsigned int *translation)
+			      unsigned int *translation)
 {
-    static int intab[] = { 9, 10, 11, 12, 0, 14, 15, 0 };
+	static int intab[] = { 9, 10, 11, 12, 0, 14, 15, 0 };
 
-    *irq_level = intab[inb(INTDEF(base)) & 0x7];
-    *translation = inb(RESV1(base)) & 0x1;
-    outb(inb(INTDEF(base)) | 0x10, INTDEF(base));
+	*irq_level = intab[inb(INTDEF(base)) & 0x7];
+	*translation = inb(RESV1(base)) & 0x1;
+	outb(inb(INTDEF(base)) | 0x10, INTDEF(base));
 }
 
-static int aha1740_detect(Scsi_Host_Template * tpnt)
+static int aha1740_biosparam(struct scsi_device *sdev,
+			     struct block_device *dev,
+			     sector_t capacity, int* ip)
 {
-    int count = 0, slot;
+	int size = capacity;
+	int extended = HOSTDATA(sdev->host)->translation;
 
-    DEB(printk("aha1740_detect: \n"));
+	DEB(printk("aha1740_biosparam\n"));
+	if (extended && (ip[2] > 1024))
+	{
+		ip[0] = 255;
+		ip[1] = 63;
+		ip[2] = size / (255 * 63);
+	}
+	else
+	{
+		ip[0] = 64;
+		ip[1] = 32;
+		ip[2] = size >> 11;
+	}
+	return 0;
+}
+
+static int aha1740_eh_abort_handler (Scsi_Cmnd *dummy)
+{
+/*
+ * From Alan Cox :
+ * The AHA1740 has firmware handled abort/reset handling. The "head in
+ * sand" kernel code is correct for once 8)
+ *
+ * So we define a dummy handler just to keep the kernel SCSI code as
+ * quiet as possible...
+ */
 
-    for ( slot=MINEISA; slot <= MAXEISA; slot++ )
-    {
+	return 0;
+}
+
+static Scsi_Host_Template aha1740_template = {
+	.module           = THIS_MODULE,
+	.proc_name        = "aha1740",
+	.proc_info        = aha1740_proc_info,
+	.name             = "Adaptec 174x (EISA)",
+	.command          = aha1740_command,
+	.queuecommand     = aha1740_queuecommand,
+	.bios_param       = aha1740_biosparam,
+	.can_queue        = AHA1740_ECBS,
+	.this_id          = 7,
+	.sg_tablesize     = AHA1740_SCATTER,
+	.cmd_per_lun      = AHA1740_CMDLUN,
+	.use_clustering   = ENABLE_CLUSTERING,
+	.eh_abort_handler = aha1740_eh_abort_handler,
+};
+
+static int aha1740_probe (struct device *dev)
+{
 	int slotbase;
 	unsigned int irq_level, translation;
 	struct Scsi_Host *shpnt;
 	struct aha1740_hostdata *host;
-	slotbase = SLOTBASE(slot);
-	/*
-	 * The ioports for eisa boards are generally beyond that used in the
-	 * check/allocate region code, but this may change at some point,
-	 * so we go through the motions.
-	 */
-	if (!request_region(slotbase, SLOTSIZE, "aha1740"))  /* See if in use */
-	    continue;
+	struct eisa_device *edev = to_eisa_device (dev);
+
+	DEB(printk("aha1740_probe: \n"));
+	
+	slotbase = edev->base_addr + EISA_VENDOR_ID_OFFSET;
+	if (!request_region(slotbase, SLOTSIZE, "aha1740")) /* See if in use */
+		return -EBUSY;
 	if (!aha1740_test_port(slotbase))
-	    goto err_release;
+		goto err_release;
 	aha1740_getconfig(slotbase,&irq_level,&translation);
 	if ((inb(G2STAT(slotbase)) &
 	     (G2STAT_MBXOUT|G2STAT_BUSY)) != G2STAT_MBXOUT)
 	{	/* If the card isn't ready, hard reset it */
-	    outb(G2CNTRL_HRST, G2CNTRL(slotbase));
-	    outb(0, G2CNTRL(slotbase));
+		outb(G2CNTRL_HRST, G2CNTRL(slotbase));
+		outb(0, G2CNTRL(slotbase));
 	}
-	printk(KERN_INFO "Configuring aha174x at IO:%x, IRQ %d\n", slotbase, irq_level);
+	printk(KERN_INFO "Configuring aha174x at IO:%x, IRQ %d\n",
+	       slotbase, irq_level);
 	printk(KERN_INFO "aha174x: Extended translation %sabled.\n",
 	       translation ? "en" : "dis");
-	DEB(printk("aha1740_detect: enable interrupt channel %d\n",irq_level));
-	if (request_irq(irq_level,aha1740_intr_handle,0,"aha1740",NULL)) {
-	    printk("Unable to allocate IRQ for adaptec controller.\n");
-	    goto err_release;
-	}
-	shpnt = scsi_register(tpnt, sizeof(struct aha1740_hostdata));
+	shpnt = scsi_register(&aha1740_template,
+			      sizeof(struct aha1740_hostdata));
 	if(shpnt == NULL)
-		goto err_free_irq;
+		goto err_release;
 
 	shpnt->base = 0;
 	shpnt->io_port = slotbase;
@@ -560,49 +669,79 @@
 	shpnt->irq = irq_level;
 	shpnt->dma_channel = 0xff;
 	host = HOSTDATA(shpnt);
-	host->slot = slot;
+	host->edev = edev;
 	host->translation = translation;
-	aha_host[irq_level - 9] = shpnt;
-	count++;
-	continue;
-
-    err_free_irq:
-	free_irq(irq_level, aha1740_intr_handle);
-    err_release:
+	host->ecb_dma_addr = dma_map_single (&edev->dev, host->ecb,
+					     sizeof (host->ecb),
+					     DMA_BIDIRECTIONAL);
+	if (!host->ecb_dma_addr) {
+		printk (KERN_ERR "aha1740_probe: Couldn't map ECB, giving up\n");
+		scsi_unregister (shpnt);
+		goto err_release;
+	}
+	
+	DEB(printk("aha1740_probe: enable interrupt channel %d\n",irq_level));
+	if (request_irq(irq_level,aha1740_intr_handle,0,"aha1740",shpnt)) {
+		printk(KERN_ERR "aha1740_probe: Unable to allocate IRQ %d.\n",
+		       irq_level);
+		goto err_release;
+	}
+
+	eisa_set_drvdata (edev, shpnt);
+	scsi_add_host (shpnt, dev);
+	return 0;
+
+ err_release:
 	release_region(slotbase, SLOTSIZE);
-    }
-    return count;
+
+	return -ENODEV;
 }
 
-static int aha1740_biosparam(struct scsi_device *sdev, struct block_device *dev,
-		sector_t capacity, int* ip)
+static __devexit int aha1740_remove (struct device *dev)
 {
-    int size = capacity;
-    int extended = HOSTDATA(sdev->host)->translation;
-
-    DEB(printk("aha1740_biosparam\n"));
-    if (extended && (ip[2] > 1024))
-    {
-	ip[0] = 255;
-	ip[1] = 63;
-	ip[2] = size / (255 * 63);
-    }
-    else
-    {
-	ip[0] = 64;
-	ip[1] = 32;
-	ip[2] = size >> 11;
-    }
-    return 0;
+	struct Scsi_Host *shpnt = dev->driver_data;
+	struct aha1740_hostdata *host = HOSTDATA (shpnt);
+
+	if (scsi_remove_host (shpnt))
+		return -EBUSY;
+	
+	free_irq (shpnt->irq, shpnt);
+	dma_unmap_single (dev, host->ecb_dma_addr,
+			  sizeof (host->ecb), DMA_BIDIRECTIONAL);
+	release_region (shpnt->io_port, SLOTSIZE);
+
+	scsi_unregister (shpnt);
+	
+	return 0;
 }
 
-MODULE_LICENSE("GPL");
+static struct eisa_device_id aha1740_ids[] = {
+	{ "ADP0000" },
+	{ "ADP0001" },
+	{ "ADP0002" },
+	{ "" }
+};
+
+static struct eisa_driver aha1740_driver = {
+	.id_table = aha1740_ids,
+	.driver   = {
+		.name    = "aha1740",
+		.probe   = aha1740_probe,
+		.remove  = __devexit_p (aha1740_remove),
+	},
+};
 
-/* Eventually this will go into an include file, but this will be later */
-static Scsi_Host_Template driver_template = AHA1740;
+static __init int aha1740_init (void)
+{
+	return eisa_driver_register (&aha1740_driver);
+}
+
+static __exit void aha1740_exit (void)
+{
+	eisa_driver_unregister (&aha1740_driver);
+}
 
-#include "scsi_module.c"
+module_init (aha1740_init);
+module_exit (aha1740_exit);
 
-/* Okay, you made it all the way through.  As of this writing, 3/31/93, I'm
-brad@saturn.gaylord.com or brad@bradpc.gaylord.com.  I'll try to help as time
-permits if you have any trouble with this driver.  Happy Linuxing! */
+MODULE_LICENSE("GPL");
--- linux/drivers/scsi/aha1740.h	2003-04-25 14:00:37.000000000 +0200
+++ linux-2.5/drivers/scsi/aha1740.h	2003-04-24 16:51:29.000000000 +0200
@@ -12,11 +12,6 @@
 
 #include <linux/types.h>
 
-/* Eisa Enhanced mode operation - slot locating and addressing */
-#define MINEISA 1		/* I don't have an EISA Spec to know these ranges, so I */
-#define MAXEISA 8		/* Just took my machine's specifications.  Adjust to fit. */
-		    /* I just saw an ad, and bumped this from 6 to 8 */
-#define	SLOTBASE(x)	((x << 12) + 0xc80)
 #define SLOTSIZE	0x5c
 
 /* EISA configuration registers & values */
@@ -152,27 +147,8 @@
 #define AHA1740CMD_RINQ  0x0a	/* Read Host Adapter Inquiry Data */
 #define AHA1740CMD_TARG  0x10	/* Target SCSI Command */
 
-static int aha1740_detect(Scsi_Host_Template *);
-static int aha1740_command(Scsi_Cmnd *);
-static int aha1740_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
-static int aha1740_biosparam(struct scsi_device *, struct block_device *, sector_t, int *);
-static int aha1740_proc_info(char *buffer, char **start, off_t offset, int length, int hostno, int inout);
-
 #define AHA1740_ECBS 32
 #define AHA1740_SCATTER 16
 #define AHA1740_CMDLUN 1
 
-#define AHA1740 {  .proc_name      = "aha1740",				\
-		   .proc_info      = aha1740_proc_info,	                \
-		   .name           = "Adaptec 174x (EISA)",		\
-		   .detect         = aha1740_detect,			\
-		   .command        = aha1740_command,			\
-		   .queuecommand   = aha1740_queuecommand,		\
-		   .bios_param     = aha1740_biosparam,                   \
-		   .can_queue      = AHA1740_ECBS, 			\
-		   .this_id        = 7, 					\
-		   .sg_tablesize   = AHA1740_SCATTER, 			\
-		   .cmd_per_lun    = AHA1740_CMDLUN, 			\
-		   .use_clustering = ENABLE_CLUSTERING}
-
 #endif

-- 
Places change, faces change. Life is so very strange.
