Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317746AbSGVQq2>; Mon, 22 Jul 2002 12:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317744AbSGVQq1>; Mon, 22 Jul 2002 12:46:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1007 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317746AbSGVQpE>; Mon, 22 Jul 2002 12:45:04 -0400
Subject: PATCH: 2.5.27 - Fix up the atp870u scsi driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus.Torvalds.davej@suse.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 18:58:40 +0100
Message-Id: <1027360720.31782.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This imports the 2.4 fixes missing from 2.5, then rewrites chunks of it
so that its sane enough to add the pci dma api functionality.

This driver wants a much bigger workover before 2.6 really

--- linux-2.5.27/drivers/scsi/atp870u.c	Sat Jul 20 20:11:14 2002
+++ linux-2.5.27-ac1/drivers/scsi/atp870u.c	Mon Jul 22 01:03:16 2002
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 1997	Wu Ching Chen
  *  2.1.x update (C) 1998  Krzysztof G. Baranowski
+ *  2.5.x update (C) 2002  Red Hat <alan@redhat.com>
  *
  * Marcelo Tosatti <marcelo@conectiva.com.br> : SMP fixes
  *
@@ -11,11 +12,10 @@
  *		   enable 32 bit fifo transfer
  *		   support cdrom & remove device run ultra speed
  *		   fix disconnect bug  2000/12/21
- *		   support atp880 chip lvd u160 2001/05/15 (7.1)
+ *		   support atp880 chip lvd u160 2001/05/15
+ *		   fix prd table bug 2001/09/12 (7.1)
  */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -38,19 +38,15 @@
 
 #include<linux/stat.h>
 
-void mydlyu(unsigned int);
-
 /*
  *   static const char RCSid[] = "$Header: /usr/src/linux/kernel/blk_drv/scsi/RCS/atp870u.c,v 1.0 1997/05/07 15:22:00 root Exp root $";
  */
 
-static unsigned char admaxu = 1;
 static unsigned short int sync_idu;
 
-static unsigned int irqnumu[2] = {0, 0};
+#define MAX_ATP		16
 
-struct atp_unit
-{
+struct atp_unit {
 	unsigned long ioport;
 	unsigned long irq;
 	unsigned long pciport;
@@ -72,8 +68,7 @@
 	unsigned char ata_cdbu[16];
 	unsigned char sp[16];
 	Scsi_Cmnd *querequ[qcnt];
-	struct atp_id
-	{
+	struct atp_id {
 		unsigned char dirctu;
 		unsigned char devspu;
 		unsigned char devtypeu;
@@ -82,58 +77,50 @@
 		unsigned long last_lenu;
 		unsigned char *prd_posu;
 		unsigned char *prd_tableu;
+		dma_addr_t prd_phys;
 		Scsi_Cmnd *curr_req;
 	} id[16];
+	struct Scsi_Host *host;
+	struct pci_dev *pdev;
 };
 
-static struct Scsi_Host *atp_host[2] = {NULL, NULL};
-static struct atp_unit atp_unit[2];
+static struct Scsi_Host *atp_host[MAX_ATP];
+
+static void send_s870(struct Scsi_Host *);
 
 static void atp870u_intr_handle(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
 	unsigned short int tmpcip, id;
-	unsigned char i, j, h, target_id, lun;
+	unsigned char i, j, target_id, lun;
 	unsigned char *prd;
 	Scsi_Cmnd *workrequ;
 	unsigned int workportu, tmport;
 	unsigned long adrcntu, k;
 	int errstus;
-	struct atp_unit *dev = dev_id;
+	struct Scsi_Host *host = dev_id;
+	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
 
-	for (h = 0; h < 2; h++) {
-		if (irq == irqnumu[h]) {
-			goto irq_numok;
-		}
-	}
-	return;
-irq_numok:
 	dev->in_int = 1;
 	workportu = dev->ioport;
 	tmport = workportu;
 
-	if (dev->working != 0)
-	{
+	if (dev->working != 0) {
 		tmport += 0x1f;
 		j = inb(tmport);
-		if ((j & 0x80) == 0)
-		{
+		if ((j & 0x80) == 0) {
 			dev->in_int = 0;
 			return;
 		}
 
 		tmpcip = dev->pciport;
-		if ((inb(tmpcip) & 0x08) != 0)
-		{
+		if ((inb(tmpcip) & 0x08) != 0) {
 			tmpcip += 0x2;
-			for (k=0; k < 1000; k++)
-			{
-				if ((inb(tmpcip) & 0x08) == 0)
-				{
+			for (k = 0; k < 1000; k++) {
+				if ((inb(tmpcip) & 0x08) == 0) {
 					goto stop_dma;
 				}
-				if ((inb(tmpcip) & 0x01) == 0)
-				{
+				if ((inb(tmpcip) & 0x01) == 0) {
 					goto stop_dma;
 				}
 			}
@@ -150,7 +137,7 @@
 		tmport += 0x02;
 
 		/*
-		 *	Remap wide devices onto id numbers
+		 *      Remap wide devices onto id numbers
 		 */
 
 		if ((target_id & 0x40) != 0) {
@@ -159,60 +146,49 @@
 			target_id &= 0x07;
 		}
 
-		if ((j & 0x40) != 0)
-		{
-		     if (dev->last_cmd == 0xff)
-		     {
-			dev->last_cmd = target_id;
-		     }
-		     dev->last_cmd |= 0x40;
+		if ((j & 0x40) != 0) {
+			if (dev->last_cmd == 0xff) {
+				dev->last_cmd = target_id;
+			}
+			dev->last_cmd |= 0x40;
 		}
 
-		if (i == 0x85)
-		{
-			if ((dev->last_cmd & 0xf0) != 0x40)
-			{
-			   dev->last_cmd = 0xff;
+		if (i == 0x85) {
+			if ((dev->last_cmd & 0xf0) != 0x40) {
+				dev->last_cmd = 0xff;
 			}
 			/*
-			 *	Flip wide
+			 *      Flip wide
 			 */
-			if (dev->wide_idu != 0)
-			{
+			if (dev->wide_idu != 0) {
 				tmport = workportu + 0x1b;
-				outb(0x01,tmport);
-				while ((inb(tmport) & 0x01) != 0x01)
-				{
-				   outb(0x01,tmport);
+				outb(0x01, tmport);
+				while ((inb(tmport) & 0x01) != 0x01) {
+					outb(0x01, tmport);
 				}
 			}
 			/*
-			 *	Issue more commands
+			 *      Issue more commands
 			 */
-			if (((dev->quhdu != dev->quendu) || (dev->last_cmd != 0xff)) &&
-			    (dev->in_snd == 0))
-			{
-				send_s870(h);
+			if (((dev->quhdu != dev->quendu) || (dev->last_cmd != 0xff)) && (dev->in_snd == 0)) {
+				send_s870(host);
 			}
 			/*
-			 *	Done
+			 *      Done
 			 */
 			dev->in_int = 0;
 			return;
 		}
 
-		if (i == 0x40)
-		{
-		     dev->last_cmd |= 0x40;
-		     dev->in_int = 0;
-		     return;
+		if (i == 0x40) {
+			dev->last_cmd |= 0x40;
+			dev->in_int = 0;
+			return;
 		}
 
-		if (i == 0x21)
-		{
-			if ((dev->last_cmd & 0xf0) != 0x40)
-			{
-			   dev->last_cmd = 0xff;
+		if (i == 0x21) {
+			if ((dev->last_cmd & 0xf0) != 0x40) {
+				dev->last_cmd = 0xff;
 			}
 			tmport -= 0x05;
 			adrcntu = 0;
@@ -230,21 +206,18 @@
 			dev->in_int = 0;
 			return;
 		}
-		if ((i == 0x80) || (i == 0x8f))
-		{
+		if ((i == 0x80) || (i == 0x8f)) {
 			lun = 0;
 			tmport -= 0x07;
 			j = inb(tmport);
-			if (j == 0x44 || i==0x80) {
+			if (j == 0x44 || i == 0x80) {
 				tmport += 0x0d;
 				lun = inb(tmport) & 0x07;
 			} else {
-				if ((dev->last_cmd & 0xf0) != 0x40)
-				{
-				   dev->last_cmd = 0xff;
+				if ((dev->last_cmd & 0xf0) != 0x40) {
+					dev->last_cmd = 0xff;
 				}
-				if (j == 0x41)
-				{
+				if (j == 0x41) {
 					tmport += 0x02;
 					adrcntu = 0;
 					((unsigned char *) &adrcntu)[2] = inb(tmport++);
@@ -258,9 +231,7 @@
 					outb(0x08, tmport);
 					dev->in_int = 0;
 					return;
-				}
-				else
-				{
+				} else {
 					outb(0x46, tmport);
 					dev->id[target_id].dirctu = 0x00;
 					tmport += 0x02;
@@ -273,19 +244,17 @@
 					return;
 				}
 			}
-			if (dev->last_cmd != 0xff)
-			{
-			   dev->last_cmd |= 0x40;
+			if (dev->last_cmd != 0xff) {
+				dev->last_cmd |= 0x40;
 			}
 			tmport = workportu + 0x10;
 			outb(0x45, tmport);
 			tmport += 0x06;
 			target_id = inb(tmport);
 			/*
-			 *	Remap wide identifiers
+			 *      Remap wide identifiers
 			 */
-			if ((target_id & 0x10) != 0)
-			{
+			if ((target_id & 0x10) != 0) {
 				target_id = (target_id & 0x07) | 0x08;
 			} else {
 				target_id &= 0x07;
@@ -311,31 +280,20 @@
 			outb(0x80, tmport);
 
 			/* enable 32 bit fifo transfer */
-			if (dev->deviceid != 0x8081)
-			{
-			   tmport = workportu + 0x3a;
-			   if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) ||
-			       (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a))
-			   {
-			      outb((unsigned char)((inb(tmport) & 0xf3) | 0x08),tmport);
-			   }
-			   else
-			   {
-			      outb((unsigned char)(inb(tmport) & 0xf3),tmport);
-			   }
-			}
-			else
-			{
-			   tmport = workportu - 0x05;
-			   if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) ||
-			       (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a))
-			   {
-			      outb((unsigned char)((inb(tmport) & 0x3f) | 0xc0),tmport);
-			   }
-			   else
-			   {
-			      outb((unsigned char)(inb(tmport) & 0x3f),tmport);
-			   }
+			if (dev->deviceid != 0x8081) {
+				tmport = workportu + 0x3a;
+				if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) || (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a)) {
+					outb((unsigned char) ((inb(tmport) & 0xf3) | 0x08), tmport);
+				} else {
+					outb((unsigned char) (inb(tmport) & 0xf3), tmport);
+				}
+			} else {
+				tmport = workportu - 0x05;
+				if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) || (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a)) {
+					outb((unsigned char) ((inb(tmport) & 0x3f) | 0xc0), tmport);
+				} else {
+					outb((unsigned char) (inb(tmport) & 0x3f), tmport);
+				}
 			}
 
 			tmport = workportu + 0x1b;
@@ -343,15 +301,14 @@
 			id = 1;
 			id = id << target_id;
 			/*
-			 *	Is this a wide device
+			 *      Is this a wide device
 			 */
 			if ((id & dev->wide_idu) != 0) {
 				j |= 0x01;
 			}
 			outb(j, tmport);
-			while ((inb(tmport) & 0x01) != j)
-			{
-			   outb(j,tmport);
+			while ((inb(tmport) & 0x01) != j) {
+				outb(j, tmport);
 			}
 
 			if (dev->id[target_id].last_lenu == 0) {
@@ -361,8 +318,7 @@
 				return;
 			}
 			prd = dev->id[target_id].prd_posu;
-			while (adrcntu != 0)
-			{
+			while (adrcntu != 0) {
 				id = ((unsigned short int *) (prd))[2];
 				if (id == 0) {
 					k = 0x10000;
@@ -392,7 +348,7 @@
 			tmpcip -= 0x02;
 			tmport = workportu + 0x18;
 			/*
-			 *	Check transfer direction
+			 *      Check transfer direction
 			 */
 			if (dev->id[target_id].dirctu != 0) {
 				outb(0x08, tmport);
@@ -407,25 +363,22 @@
 		}
 
 		/*
-		 *	Current scsi request on this target
+		 *      Current scsi request on this target
 		 */
 
 		workrequ = dev->id[target_id].curr_req;
 
 		if (i == 0x42) {
-			if ((dev->last_cmd & 0xf0) != 0x40)
-			{
-			   dev->last_cmd = 0xff;
+			if ((dev->last_cmd & 0xf0) != 0x40) {
+				dev->last_cmd = 0xff;
 			}
 			errstus = 0x02;
 			workrequ->result = errstus;
 			goto go_42;
 		}
-		if (i == 0x16)
-		{
-			if ((dev->last_cmd & 0xf0) != 0x40)
-			{
-			   dev->last_cmd = 0xff;
+		if (i == 0x16) {
+			if ((dev->last_cmd & 0xf0) != 0x40) {
+				dev->last_cmd = 0xff;
 			}
 			errstus = 0;
 			tmport -= 0x08;
@@ -433,42 +386,43 @@
 			workrequ->result = errstus;
 go_42:
 			/*
-			 *	Complete the command
+			 *      Complete the command
 			 */
-			spin_lock_irqsave(workrequ->host->host_lock, flags);
+			 
+			if(workrequ->use_sg)
+				pci_unmap_sg(dev->pdev, (struct scatterlist *)workrequ->buffer, workrequ->use_sg, scsi_to_pci_dma_dir(workrequ->sc_data_direction));
+			else if(workrequ->request_bufflen && workrequ->sc_data_direction != SCSI_DATA_NONE)
+				pci_unmap_single(dev->pdev, workrequ->SCp.dma_handle, workrequ->request_bufflen, scsi_to_pci_dma_dir(workrequ->sc_data_direction));
+			spin_lock_irqsave(dev->host->host_lock, flags);
 			(*workrequ->scsi_done) (workrequ);
 
 			/*
-			 *	Clear it off the queue
+			 *      Clear it off the queue
 			 */
 			dev->id[target_id].curr_req = 0;
 			dev->working--;
-			spin_unlock_irqrestore(workrequ->host->host_lock, flags);
+			spin_unlock_irqrestore(dev->host->host_lock, flags);
 			/*
-			 *	Take it back wide
+			 *      Take it back wide
 			 */
 			if (dev->wide_idu != 0) {
 				tmport = workportu + 0x1b;
-				outb(0x01,tmport);
-				while ((inb(tmport) & 0x01) != 0x01)
-				{
-				   outb(0x01,tmport);
+				outb(0x01, tmport);
+				while ((inb(tmport) & 0x01) != 0x01) {
+					outb(0x01, tmport);
 				}
 			}
 			/*
-			 *	If there is stuff to send and nothing going then send it
+			 *      If there is stuff to send and nothing going then send it
 			 */
-			if (((dev->last_cmd != 0xff) || (dev->quhdu != dev->quendu)) &&
-			    (dev->in_snd == 0))
-			{
-			   send_s870(h);
+			if (((dev->last_cmd != 0xff) || (dev->quhdu != dev->quendu)) && (dev->in_snd == 0)) {
+				send_s870(host);
 			}
 			dev->in_int = 0;
 			return;
 		}
-		if ((dev->last_cmd & 0xf0) != 0x40)
-		{
-		   dev->last_cmd = 0xff;
+		if ((dev->last_cmd & 0xf0) != 0x40) {
+			dev->last_cmd = 0xff;
 		}
 		if (i == 0x4f) {
 			i = 0x89;
@@ -524,40 +478,36 @@
 		dev->in_int = 0;
 		return;
 	} else {
-//		tmport = workportu + 0x17;
-//		inb(tmport);
-//		dev->working = 0;
+//              tmport = workportu + 0x17;
+//              inb(tmport);
+//              dev->working = 0;
 		dev->in_int = 0;
 		return;
 	}
 }
 
-int atp870u_queuecommand(Scsi_Cmnd * req_p, void (*done) (Scsi_Cmnd *))
+static int atp870u_queuecommand(Scsi_Cmnd * req_p, void (*done) (Scsi_Cmnd *))
 {
-	unsigned char h;
 	unsigned long flags;
 	unsigned short int m;
 	unsigned int tmport;
+	struct Scsi_Host *host;
 	struct atp_unit *dev;
 
-	for (h = 0; h <= admaxu; h++) {
-		if (req_p->host == atp_host[h]) {
-			goto host_ok;
-		}
-	}
-	return 0;
-host_ok:
 	if (req_p->channel != 0) {
 		req_p->result = 0x00040000;
 		done(req_p);
 		return 0;
-	}
-	dev = &atp_unit[h];
+	};
+
+	host = req_p->host;
+	dev = (struct atp_unit *)&host->hostdata;
+	
 	m = 1;
 	m = m << req_p->target;
 
 	/*
-	 *	Fake a timeout for missing targets
+	 *      Fake a timeout for missing targets
 	 */
 
 	if ((m & dev->active_idu) == 0) {
@@ -574,16 +524,16 @@
 		return 0;
 	}
 	/*
-	 *	Count new command
+	 *      Count new command
 	 */
-	save_flags(flags);
-	cli();
+
+	spin_lock_irqsave(host->host_lock, flags);
 	dev->quendu++;
 	if (dev->quendu >= qcnt) {
 		dev->quendu = 0;
 	}
 	/*
-	 *	Check queue state
+	 *      Check queue state
 	 */
 	if (dev->quhdu == dev->quendu) {
 		if (dev->quendu == 0) {
@@ -591,28 +541,20 @@
 		}
 		dev->quendu--;
 		req_p->result = 0x00020000;
+		spin_unlock_irqrestore(host->host_lock, flags);
 		done(req_p);
-		restore_flags(flags);
 		return 0;
 	}
 	dev->querequ[dev->quendu] = req_p;
 	tmport = dev->ioport + 0x1c;
-	restore_flags(flags);
+	spin_unlock_irqrestore(host->host_lock, flags);
 	if ((inb(tmport) == 0) && (dev->in_int == 0) && (dev->in_snd == 0)) {
-		send_s870(h);
+		send_s870(host);
 	}
 	return 0;
 }
 
-void mydlyu(unsigned int dlycnt)
-{
-	unsigned int i;
-	for (i = 0; i < dlycnt; i++) {
-		inb(0x80);
-	}
-}
-
-void send_s870(unsigned char h)
+static void send_s870(struct Scsi_Host *host)
 {
 	unsigned int tmport;
 	Scsi_Cmnd *workrequ;
@@ -621,38 +563,37 @@
 	unsigned char j, target_id;
 	unsigned char *prd;
 	unsigned short int tmpcip, w;
-	unsigned long l, bttl;
+	unsigned long l;
+	dma_addr_t bttl;
 	unsigned int workportu;
 	struct scatterlist *sgpnt;
-	struct atp_unit *dev = &atp_unit[h];
+	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
+	int sg_count;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(host->host_lock, flags);
+	
 	if (dev->in_snd != 0) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return;
 	}
 	dev->in_snd = 1;
 	if ((dev->last_cmd != 0xff) && ((dev->last_cmd & 0x40) != 0)) {
 		dev->last_cmd &= 0x0f;
 		workrequ = dev->id[dev->last_cmd].curr_req;
-		if (workrequ != NULL)	     /* check NULL pointer */
-		{
-		   goto cmd_subp;
+		if (workrequ != NULL) {	/* check NULL pointer */
+			goto cmd_subp;
 		}
 		dev->last_cmd = 0xff;
-		if (dev->quhdu == dev->quendu)
-		{
-		   dev->in_snd = 0;
-		   restore_flags(flags);
-		   return ;
+		if (dev->quhdu == dev->quendu) {
+			dev->in_snd = 0;
+			spin_unlock_irqrestore(dev->host->host_lock, flags);
+			return;
 		}
 	}
-	if ((dev->last_cmd != 0xff) && (dev->working != 0))
-	{
-	     dev->in_snd = 0;
-	     restore_flags(flags);
-	     return ;
+	if ((dev->last_cmd != 0xff) && (dev->working != 0)) {
+		dev->in_snd = 0;
+		spin_unlock_irqrestore(dev->host->host_lock, flags);
+		return;
 	}
 	dev->working++;
 	j = dev->quhdu;
@@ -669,7 +610,7 @@
 	dev->quhdu = j;
 	dev->working--;
 	dev->in_snd = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(host->host_lock, flags);
 	return;
 cmd_subp:
 	workportu = dev->ioport;
@@ -684,7 +625,7 @@
 abortsnd:
 	dev->last_cmd |= 0x40;
 	dev->in_snd = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(dev->host->host_lock, flags);
 	return;
 oktosend:
 	memcpy(&dev->ata_cdbu[0], &workrequ->cmnd[0], workrequ->cmd_len);
@@ -702,7 +643,7 @@
 	target_id = workrequ->target;
 
 	/*
-	 *	Wide ?
+	 *      Wide ?
 	 */
 	w = 1;
 	w = w << target_id;
@@ -710,13 +651,12 @@
 		j |= 0x01;
 	}
 	outb(j, tmport);
-	while ((inb(tmport) & 0x01) != j)
-	{
-	   outb(j,tmport);
+	while ((inb(tmport) & 0x01) != j) {
+		outb(j, tmport);
 	}
 
 	/*
-	 *	Write the command
+	 *      Write the command
 	 */
 
 	tmport = workportu;
@@ -730,30 +670,30 @@
 	outb(workrequ->lun, tmport);
 	tmport += 0x02;
 	/*
-	 *	Write the target
+	 *      Write the target
 	 */
 	outb(dev->id[target_id].devspu, tmport++);
 
 	/*
-	 *	Figure out the transfer size
+	 *      Figure out the transfer size
 	 */
-	if (workrequ->use_sg)
-	{
+	if (workrequ->use_sg) {
 		l = 0;
 		sgpnt = (struct scatterlist *) workrequ->request_buffer;
-		for (i = 0; i < workrequ->use_sg; i++)
-		{
-			if (sgpnt[i].length == 0 || workrequ->use_sg > ATP870U_SCATTER)
-			{
+		sg_count = pci_map_sg(dev->pdev, sgpnt, workrequ->use_sg, scsi_to_pci_dma_dir(workrequ->sc_data_direction));
+		for (i = 0; i < workrequ->use_sg; i++) {
+			if (sgpnt[i].length == 0 || workrequ->use_sg > ATP870U_SCATTER) {
 				panic("Foooooooood fight!");
 			}
 			l += sgpnt[i].length;
 		}
-	} else {
+	} else if(workrequ->request_bufflen && workrequ->sc_data_direction != PCI_DMA_NONE) {
+		workrequ->SCp.dma_handle = pci_map_single(dev->pdev, workrequ->request_buffer, workrequ->request_bufflen, scsi_to_pci_dma_dir(workrequ->sc_data_direction));
 		l = workrequ->request_bufflen;
 	}
+	else l = 0;
 	/*
-	 *	Write transfer size
+	 *      Write transfer size
 	 */
 	outb((unsigned char) (((unsigned char *) (&l))[2]), tmport++);
 	outb((unsigned char) (((unsigned char *) (&l))[1]), tmport++);
@@ -762,21 +702,20 @@
 	dev->id[j].last_lenu = l;
 	dev->id[j].tran_lenu = 0;
 	/*
-	 *	Flip the wide bits
+	 *      Flip the wide bits
 	 */
 	if ((j & 0x08) != 0) {
 		j = (j & 0x07) | 0x40;
 	}
 	/*
-	 *	Check transfer direction
+	 *      Check transfer direction
 	 */
-	if ((dev->ata_cdbu[0] == WRITE_6) || (dev->ata_cdbu[0] == WRITE_10) ||
-	    (dev->ata_cdbu[0] == WRITE_12) || (dev->ata_cdbu[0] == MODE_SELECT)) {
+	if (workrequ->sc_data_direction == SCSI_DATA_WRITE) {
 		outb((unsigned char) (j | 0x20), tmport++);
 	} else {
 		outb(j, tmport++);
 	}
-	outb((unsigned char)(inb(tmport) | 0x80),tmport);
+	outb((unsigned char) (inb(tmport) | 0x80), tmport);
 	outb(0x80, tmport);
 	tmport = workportu + 0x1c;
 	dev->id[target_id].dirctu = 0;
@@ -788,7 +727,7 @@
 			dev->last_cmd |= 0x40;
 		}
 		dev->in_snd = 0;
-		restore_flags(flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return;
 	}
 	tmpcip = dev->pciport;
@@ -796,79 +735,75 @@
 	dev->id[target_id].prd_posu = prd;
 
 	/*
-	 *	Now write the request list. Either as scatter/gather or as
-	 *	a linear chain.
+	 *      Now write the request list. Either as scatter/gather or as
+	 *      a linear chain.
 	 */
 
-	if (workrequ->use_sg)
-	{
+	if (workrequ->use_sg) {
 		sgpnt = (struct scatterlist *) workrequ->request_buffer;
 		i = 0;
 		for (j = 0; j < workrequ->use_sg; j++) {
-			(unsigned long) (((unsigned long *) (prd))[i >> 1]) = virt_to_bus(sgpnt[j].address);
-			(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = sgpnt[j].length;
-			(unsigned short int) (((unsigned short int *) (prd))[i + 3]) = 0;
+			bttl = sg_dma_address(&sgpnt[j]);
+			l = sg_dma_len(&sgpnt[j]);
+			while (l > 0x10000) {
+				(u16) (((u16 *) (prd))[i + 3]) = 0x0000;
+				(u16) (((u16 *) (prd))[i + 2]) = 0x0000;
+				(u32) (((u32 *) (prd))[i >> 1]) = cpu_to_le32(bttl);
+				l -= 0x10000;
+				bttl += 0x10000;
+				i += 0x04;
+			}
+			(u32) (((u32 *) (prd))[i >> 1]) = cpu_to_le32(bttl);
+			(u16) (((u16 *) (prd))[i + 2]) = cpu_to_le16(l);
+			(u16) (((u16 *) (prd))[i + 3]) = 0;
 			i += 0x04;
 		}
-		(unsigned short int) (((unsigned short int *) (prd))[i - 1]) = 0x8000;
+		(u16) (((u16 *) (prd))[i - 1]) = cpu_to_le16(0x8000);
 	} else {
 		/*
-		 *	For a linear request write a chain of blocks
+		 *      For a linear request write a chain of blocks
 		 */
-		bttl = virt_to_bus(workrequ->request_buffer);
+		bttl = workrequ->SCp.dma_handle;
 		l = workrequ->request_bufflen;
 		i = 0;
 		while (l > 0x10000) {
-			(unsigned short int) (((unsigned short int *) (prd))[i + 3]) = 0x0000;
-			(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = 0x0000;
-			(unsigned long) (((unsigned long *) (prd))[i >> 1]) = bttl;
+			(u16) (((u16 *) (prd))[i + 3]) = 0x0000;
+			(u16) (((u16 *) (prd))[i + 2]) = 0x0000;
+			(u32) (((u32 *) (prd))[i >> 1]) = cpu_to_le32(bttl);
 			l -= 0x10000;
 			bttl += 0x10000;
 			i += 0x04;
 		}
-		(unsigned short int) (((unsigned short int *) (prd))[i + 3]) = 0x8000;
-		(unsigned short int) (((unsigned short int *) (prd))[i + 2]) = l;
-		(unsigned long) (((unsigned long *) (prd))[i >> 1]) = bttl;
+		(u16) (((u16 *) (prd))[i + 3]) = cpu_to_le16(0x8000);
+		(u16) (((u16 *) (prd))[i + 2]) = cpu_to_le16(l);
+		(u32) (((u32 *) (prd))[i >> 1]) = cpu_to_le32(bttl);
 	}
 	tmpcip = tmpcip + 4;
-	dev->id[target_id].prdaddru = virt_to_bus(dev->id[target_id].prd_tableu);
-	outl(dev->id[target_id].prdaddru, tmpcip);
+	dev->id[target_id].prdaddru = dev->id[target_id].prd_phys;
+	outl(dev->id[target_id].prd_phys, tmpcip);
 	tmpcip = tmpcip - 2;
 	outb(0x06, tmpcip);
 	outb(0x00, tmpcip);
 	tmpcip = tmpcip - 2;
 
-	if (dev->deviceid != 0x8081)
-	{
-	   tmport = workportu + 0x3a;
-	   if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) ||
-	       (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a))
-	   {
-	      outb((unsigned char)((inb(tmport) & 0xf3) | 0x08),tmport);
-	   }
-	   else
-	   {
-	      outb((unsigned char)(inb(tmport) & 0xf3),tmport);
-	   }
-	}
-	else
-	{
-	   tmport = workportu - 0x05;
-	   if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) ||
-	       (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a))
-	   {
-	      outb((unsigned char)((inb(tmport) & 0x3f) | 0xc0),tmport);
-	   }
-	   else
-	   {
-	      outb((unsigned char)(inb(tmport) & 0x3f),tmport);
-	   }
+	if (dev->deviceid != 0x8081) {
+		tmport = workportu + 0x3a;
+		if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) || (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a)) {
+			outb((inb(tmport) & 0xf3) | 0x08, tmport);
+		} else {
+			outb(inb(tmport) & 0xf3, tmport);
+		}
+	} else {
+		tmport = workportu - 0x05;
+		if ((dev->ata_cdbu[0] == 0x08) || (dev->ata_cdbu[0] == 0x28) || (dev->ata_cdbu[0] == 0x0a) || (dev->ata_cdbu[0] == 0x2a)) {
+			outb((unsigned char) ((inb(tmport) & 0x3f) | 0xc0), tmport);
+		} else {
+			outb((unsigned char) (inb(tmport) & 0x3f), tmport);
+		}
 	}
 	tmport = workportu + 0x1c;
 
-	if ((dev->ata_cdbu[0] == WRITE_6) || (dev->ata_cdbu[0] == WRITE_10) ||
-	    (dev->ata_cdbu[0] == WRITE_12) || (dev->ata_cdbu[0] == MODE_SELECT))
-	{
+	if (workrequ->sc_data_direction == SCSI_DATA_WRITE) {
 		dev->id[target_id].dirctu = 0x20;
 		if (inb(tmport) == 0) {
 			tmport = workportu + 0x18;
@@ -878,11 +813,10 @@
 			dev->last_cmd |= 0x40;
 		}
 		dev->in_snd = 0;
-		restore_flags(flags);
+		spin_unlock_irqrestore(host->host_lock, flags);
 		return;
 	}
-	if (inb(tmport) == 0)
-	{
+	if (inb(tmport) == 0) {
 		tmport = workportu + 0x18;
 		outb(0x08, tmport);
 		outb(0x09, tmpcip);
@@ -890,7 +824,7 @@
 		dev->last_cmd |= 0x40;
 	}
 	dev->in_snd = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(host->host_lock, flags);
 	return;
 
 }
@@ -900,18 +834,21 @@
 	SCpnt->SCp.Status++;
 }
 
-int atp870u_command(Scsi_Cmnd * SCpnt)
+static int atp870u_command(Scsi_Cmnd * SCpnt)
 {
 
 	atp870u_queuecommand(SCpnt, internal_done);
 
 	SCpnt->SCp.Status = 0;
 	while (!SCpnt->SCp.Status)
+	{
+		cpu_relax();
 		barrier();
+	}
 	return SCpnt->result;
 }
 
-unsigned char fun_scam(struct atp_unit *dev, unsigned short int *val)
+static unsigned char fun_scam(struct atp_unit *dev, unsigned short int *val)
 {
 	unsigned int tmport;
 	unsigned short int i, k;
@@ -927,22 +864,22 @@
 			goto FUN_D7;
 		}
 	}
-	*val |= 0x4000; 	/* assert DB6		*/
+	*val |= 0x4000;		/* assert DB6           */
 	outw(*val, tmport);
-	*val &= 0xdfff; 	/* assert DB5		*/
+	*val &= 0xdfff;		/* assert DB5           */
 	outw(*val, tmport);
 FUN_D5:
 	for (i = 0; i < 10; i++) {	/* stable >= bus settle delay(400 ns) */
-		if ((inw(tmport) & 0x2000) != 0) {	/* DB5 all release?	  */
+		if ((inw(tmport) & 0x2000) != 0) {	/* DB5 all release?       */
 			goto FUN_D5;
 		}
 	}
-	*val |= 0x8000; 	/* no DB4-0, assert DB7    */
+	*val |= 0x8000;		/* no DB4-0, assert DB7    */
 	*val &= 0xe0ff;
 	outw(*val, tmport);
-	*val &= 0xbfff; 	/* release DB6		   */
+	*val &= 0xbfff;		/* release DB6             */
 	outw(*val, tmport);
-      FUN_D6:
+FUN_D6:
 	for (i = 0; i < 10; i++) {	/* stable >= bus settle delay(400 ns)  */
 		if ((inw(tmport) & 0x4000) != 0) {	/* DB6 all release?  */
 			goto FUN_D6;
@@ -952,7 +889,7 @@
 	return j;
 }
 
-void tscam(unsigned char host)
+static void tscam(struct Scsi_Host *host)
 {
 
 	unsigned int tmport;
@@ -960,14 +897,14 @@
 	unsigned long n;
 	unsigned short int m, assignid_map, val;
 	unsigned char mbuf[33], quintet[2];
-	struct atp_unit *dev = &atp_unit[host];
+	struct atp_unit *dev = (struct atp_unit *)host->hostdata;
 	static unsigned char g2q_tab[8] = {
 		0x38, 0x31, 0x32, 0x2b, 0x34, 0x2d, 0x2e, 0x27
 	};
 

 	for (i = 0; i < 0x10; i++) {
-		mydlyu(0xffff);
+		udelay(0xffff);
 	}
 
 	tmport = dev->ioport + 1;
@@ -1046,18 +983,18 @@
 
 	outb(0, 0x80);
 
-	val = 0x0080;		/* bsy	*/
+	val = 0x0080;		/* bsy  */
 	tmport = dev->ioport + 0x1c;
 	outw(val, tmport);
-	val |= 0x0040;		/* sel	*/
+	val |= 0x0040;		/* sel  */
 	outw(val, tmport);
-	val |= 0x0004;		/* msg	*/
+	val |= 0x0004;		/* msg  */
 	outw(val, tmport);
 	inb(0x80);		/* 2 deskew delay(45ns*2=90ns) */
 	val &= 0x007f;		/* no bsy  */
 	outw(val, tmport);
-	mydlyu(0xffff); 	/* recommanded SCAM selection response time */
-	mydlyu(0xffff);
+	udelay(0xffff);		/* recommanded SCAM selection response time */
+	udelay(0xffff);
 	val &= 0x00fb;		/* after 1ms no msg */
 	outw(val, tmport);
 wait_nomsg:
@@ -1065,7 +1002,7 @@
 		goto wait_nomsg;
 	}
 	outb(1, 0x80);
-	mydlyu(100);
+	udelay(100);
 	for (n = 0; n < 0x30000; n++) {
 		if ((inb(tmport) & 0x80) != 0) {	/* bsy ? */
 			goto wait_io;
@@ -1088,7 +1025,7 @@
 	outw(val, tmport);
 	outb(2, 0x80);
 TCM_SYNC:
-	mydlyu(0x800);
+	udelay(0x800);
 	if ((inb(tmport) & 0x80) == 0x00) {	/* bsy ? */
 		outw(0, tmport--);
 		outb(0, tmport);
@@ -1106,7 +1043,7 @@
 	val |= 0x3f00;
 	fun_scam(dev, &val);
 	outb(3, 0x80);
-	val &= 0x00ff;		/* isolation	    */
+	val &= 0x00ff;		/* isolation        */
 	val |= 0x2000;
 	fun_scam(dev, &val);
 	outb(4, 0x80);
@@ -1141,10 +1078,10 @@
 	printk(" \n%x %x %x %s\n ",assignid_map,mbuf[0],mbuf[1],&mbuf[2]); */
 	i = 15;
 	j = mbuf[0];
-	if ((j & 0x20) != 0) {	/* bit5=1:ID upto 7	 */
+	if ((j & 0x20) != 0) {	/* bit5=1:ID upto 7      */
 		i = 7;
 	}
-	if ((j & 0x06) == 0) {	/* IDvalid?		*/
+	if ((j & 0x06) == 0) {	/* IDvalid?             */
 		goto G2Q5;
 	}
 	k = mbuf[1];
@@ -1158,8 +1095,8 @@
 		k--;
 		goto small_id;
 	}
-G2Q5:				/* srch from max acceptable ID#  */
-	k = i;			/* max acceptable ID#		 */
+G2Q5:			/* srch from max acceptable ID#  */
+	k = i;			/* max acceptable ID#            */
 G2Q_LP:
 	m = 1;
 	m <<= k;
@@ -1170,12 +1107,12 @@
 		k--;
 		goto G2Q_LP;
 	}
-G2Q_QUIN:		/* k=binID#,	   */
+G2Q_QUIN:		/* k=binID#,       */
 	assignid_map |= m;
 	if (k < 8) {
 		quintet[0] = 0x38;	/* 1st dft ID<8    */
 	} else {
-		quintet[0] = 0x31;	/* 1st	ID>=8	   */
+		quintet[0] = 0x31;	/* 1st  ID>=8      */
 	}
 	k &= 0x07;
 	quintet[1] = g2q_tab[k];
@@ -1193,19 +1130,19 @@
 
 }
 
-void is870(unsigned long host, unsigned int wkport)
+void is870(struct Scsi_Host *host, unsigned int wkport)
 {
 	unsigned int tmport;
 	unsigned char i, j, k, rmb, n;
 	unsigned short int m;
 	static unsigned char mbuf[512];
-	static unsigned char satn[9] =	{0, 0, 0, 0, 0, 0, 0, 6, 6};
-	static unsigned char inqd[9] =	{0x12, 0, 0, 0, 0x24, 0, 0, 0x24, 6};
-	static unsigned char synn[6] =	{0x80, 1, 3, 1, 0x19, 0x0e};
-	static unsigned char synu[6] =	{0x80, 1, 3, 1, 0x0c, 0x0e};
-	static unsigned char synw[6] =	{0x80, 1, 3, 1, 0x0c, 0x07};
-	static unsigned char wide[6] =	{0x80, 1, 2, 3, 1, 0};
-	struct atp_unit *dev = &atp_unit[host];
+	static unsigned char satn[9] = { 0, 0, 0, 0, 0, 0, 0, 6, 6 };
+	static unsigned char inqd[9] = { 0x12, 0, 0, 0, 0x24, 0, 0, 0x24, 6 };
+	static unsigned char synn[6] = { 0x80, 1, 3, 1, 0x19, 0x0e };
+	static unsigned char synu[6] = { 0x80, 1, 3, 1, 0x0c, 0x0e };
+	static unsigned char synw[6] = { 0x80, 1, 3, 1, 0x0c, 0x07 };
+	static unsigned char wide[6] = { 0x80, 1, 2, 3, 1, 0 };
+	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
 
 	sync_idu = 0;
 	tmport = wkport + 0x3a;
@@ -1226,11 +1163,9 @@
 		}
 		tmport = wkport + 0x1b;
 		if (dev->chip_veru == 4) {
-		   outb(0x01, tmport);
-		}
-		else
-		{
-		   outb(0x00, tmport);
+			outb(0x01, tmport);
+		} else {
+			outb(0x00, tmport);
 		}
 		tmport = wkport + 1;
 		outb(0x08, tmport++);
@@ -1499,9 +1434,7 @@
 		m = m << i;
 		dev->wide_idu |= m;
 not_wide:
-		if ((dev->id[i].devtypeu == 0x00) || (dev->id[i].devtypeu == 0x07) ||
-		    ((dev->id[i].devtypeu == 0x05) && ((n & 0x10) != 0)))
-		{
+		if ((dev->id[i].devtypeu == 0x00) || (dev->id[i].devtypeu == 0x07) || ((dev->id[i].devtypeu == 0x05) && ((n & 0x10) != 0))) {
 			goto set_sync;
 		}
 		continue;
@@ -1682,31 +1615,31 @@
 			goto set_syn_ok;
 		}
 		j = 0x60;
-	      set_syn_ok:
+set_syn_ok:
 		dev->id[i].devspu = (dev->id[i].devspu & 0x0f) | j;
 	}
 	tmport = wkport + 0x3a;
 	outb((unsigned char) (inb(tmport) & 0xef), tmport);
 }
 
-void is880(unsigned long host, unsigned int wkport)
+static void is880(struct Scsi_Host *host, unsigned int wkport)
 {
 	unsigned int tmport;
 	unsigned char i, j, k, rmb, n, lvdmode;
 	unsigned short int m;
 	static unsigned char mbuf[512];
-	static unsigned char satn[9] =	{0, 0, 0, 0, 0, 0, 0, 6, 6};
-	static unsigned char inqd[9] =	{0x12, 0, 0, 0, 0x24, 0, 0, 0x24, 6};
-	static unsigned char synn[6] =	{0x80, 1, 3, 1, 0x19, 0x0e};
-	unsigned char synu[6] =  {0x80, 1, 3, 1, 0x0a, 0x0e};
-	static unsigned char synw[6] =	{0x80, 1, 3, 1, 0x19, 0x0e};
-	unsigned char synuw[6] =  {0x80, 1, 3, 1, 0x0a, 0x0e};
-	static unsigned char wide[6] =	{0x80, 1, 2, 3, 1, 0};
-	static unsigned char u3[9] = { 0x80,1,6,4,0x09,00,0x0e,0x01,0x02 };
-	struct atp_unit *dev = &atp_unit[host];
+	static unsigned char satn[9] = { 0, 0, 0, 0, 0, 0, 0, 6, 6 };
+	static unsigned char inqd[9] = { 0x12, 0, 0, 0, 0x24, 0, 0, 0x24, 6 };
+	static unsigned char synn[6] = { 0x80, 1, 3, 1, 0x19, 0x0e };
+	unsigned char synu[6] = { 0x80, 1, 3, 1, 0x0a, 0x0e };
+	static unsigned char synw[6] = { 0x80, 1, 3, 1, 0x19, 0x0e };
+	unsigned char synuw[6] = { 0x80, 1, 3, 1, 0x0a, 0x0e };
+	static unsigned char wide[6] = { 0x80, 1, 2, 3, 1, 0 };
+	static unsigned char u3[9] = { 0x80, 1, 6, 4, 0x09, 00, 0x0e, 0x01, 0x02 };
+	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
 
 	sync_idu = 0;
-	lvdmode=inb(wkport + 0x3f) & 0x40;
+	lvdmode = inb(wkport + 0x3f) & 0x40;
 
 	for (i = 0; i < 16; i++) {
 		m = 1;
@@ -1842,13 +1775,12 @@
 		if ((i < 8) && ((dev->global_map & 0x20) == 0)) {
 			goto not_wide;
 		}
-		if (lvdmode == 0)
-		{
-		   goto chg_wide;
+		if (lvdmode == 0) {
+			goto chg_wide;
 		}
-		if (dev->sp[i] != 0x04) 	 // force u2
+		if (dev->sp[i] != 0x04)	// force u2
 		{
-		   goto chg_wide;
+			goto chg_wide;
 		}
 
 		tmport = wkport + 0x5b;
@@ -1985,11 +1917,11 @@
 			goto chg_wide;
 		}
 		if (mbuf[3] == 0x09) {
-		   m = 1;
-		   m = m << i;
-		   dev->wide_idu |= m;
-		   dev->id[i].devspu = 0xce;
-		   continue;
+			m = 1;
+			m = m << i;
+			dev->wide_idu |= m;
+			dev->id[i].devspu = 0xce;
+			continue;
 		}
 chg_wide:
 		tmport = wkport + 0x5b;
@@ -2132,30 +2064,23 @@
 		m = m << i;
 		dev->wide_idu |= m;
 not_wide:
-		if ((dev->id[i].devtypeu == 0x00) || (dev->id[i].devtypeu == 0x07) ||
-		    ((dev->id[i].devtypeu == 0x05) && ((n & 0x10) != 0)))
-		{
+		if ((dev->id[i].devtypeu == 0x00) || (dev->id[i].devtypeu == 0x07) || ((dev->id[i].devtypeu == 0x05) && ((n & 0x10) != 0))) {
 			m = 1;
 			m = m << i;
-			if ((dev->async & m) != 0)
-			{
-			   goto set_sync;
+			if ((dev->async & m) != 0) {
+				goto set_sync;
 			}
 		}
 		continue;
 set_sync:
-		if (dev->sp[i] == 0x02)
-		{
-		   synu[4]=0x0c;
-		   synuw[4]=0x0c;
-		}
-		else
-		{
-		   if (dev->sp[i] >= 0x03)
-		   {
-		      synu[4]=0x0a;
-		      synuw[4]=0x0a;
-		   }
+		if (dev->sp[i] == 0x02) {
+			synu[4] = 0x0c;
+			synuw[4] = 0x0c;
+		} else {
+			if (dev->sp[i] >= 0x03) {
+				synu[4] = 0x0a;
+				synuw[4] = 0x0a;
+			}
 		}
 		tmport = wkport + 0x5b;
 		j = 0;
@@ -2320,7 +2245,7 @@
 			mbuf[4] = 0x0e;
 		}
 		dev->id[i].devspu = mbuf[4];
-		if (mbuf[3] < 0x0c){
+		if (mbuf[3] < 0x0c) {
 			j = 0xb0;
 			goto set_syn_ok;
 		}
@@ -2341,101 +2266,102 @@
 			goto set_syn_ok;
 		}
 		j = 0x60;
-	      set_syn_ok:
+set_syn_ok:
 		dev->id[i].devspu = (dev->id[i].devspu & 0x0f) | j;
 	}
 }
 
+
+static void atp870u_init_tables(struct Scsi_Host *host)
+{
+	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
+	int k;
+
+	for (k = 0; k < 16; k++) {
+		/* FIXME */
+		dev->id[k].prd_tableu = pci_alloc_consistent(dev->pdev, 1024, &dev->id[k].prd_phys);
+		dev->id[k].devspu = 0x20;
+		dev->id[k].devtypeu = 0;
+		dev->id[k].curr_req = NULL;
+	}
+	dev->active_idu = 0;
+	dev->wide_idu = 0;
+	dev->host_idu = 0x07;
+	dev->quhdu = 0;
+	dev->quendu = 0;
+	dev->chip_veru = 0;
+	dev->last_cmd = 0xff;
+	dev->in_snd = 0;
+	dev->in_int = 0;
+	for (k = 0; k < qcnt; k++) {
+		dev->querequ[k] = 0;
+	}
+	for (k = 0; k < 16; k++) {
+		dev->id[k].curr_req = 0;
+		dev->sp[k] = 0x04;
+	}
+}			
+
 /* return non-zero on detection */
-int atp870u_detect(Scsi_Host_Template * tpnt)
+static int atp870u_detect(Scsi_Host_Template * tpnt)
 {
 	unsigned char irq, h, k, m;
 	unsigned long flags;
 	unsigned int base_io, error, tmport;
-	unsigned short index = 0;
-	struct pci_dev *pdev[3];
-	unsigned char chip_ver[3], host_id;
-	unsigned short dev_id[3], n;
+	struct pci_dev *pdev[MAX_ATP];
+	unsigned char chip_ver[MAX_ATP], host_id;
+	unsigned short dev_id[MAX_ATP], n;
 	struct Scsi_Host *shpnt = NULL;
-	int tmpcnt = 0;
+	int card = 0;
 	int count = 0;
 
 	static unsigned short devid[9] = {
-	  0x8081, 0x8002, 0x8010, 0x8020, 0x8030, 0x8040, 0x8050, 0x8060, 0
+		0x8081, 0x8002, 0x8010, 0x8020, 0x8030, 0x8040, 0x8050, 0x8060, 0
 	};
 
 	printk(KERN_INFO "aec671x_detect: \n");
 	if (!pci_present()) {
-		printk(KERN_INFO"   NO PCI SUPPORT.\n");
+		printk(KERN_INFO "   NO PCI SUPPORT.\n");
 		return count;
 	}
 	tpnt->proc_name = "atp870u";
 
-	for (h = 0; h < 2; h++) {
-		struct atp_unit *dev = &atp_unit[h];
-		for(k=0;k<16;k++)
-		{
-			dev->id[k].prd_tableu = kmalloc(1024, GFP_KERNEL);
-			dev->id[k].devspu=0x20;
-			dev->id[k].devtypeu = 0;
-			dev->id[k].curr_req = NULL;
-		}
-		dev->active_idu = 0;
-		dev->wide_idu = 0;
-		dev->host_idu = 0x07;
-		dev->quhdu = 0;
-		dev->quendu = 0;
-		pdev[h]=NULL;
-		pdev[2]=NULL;
-		dev->chip_veru = 0;
-		dev->last_cmd = 0xff;
-		dev->in_snd = 0;
-		dev->in_int = 0;
-		for (k = 0; k < qcnt; k++) {
-			dev->querequ[k] = 0;
-		}
-		for (k = 0; k < 16; k++) {
-			dev->id[k].curr_req = 0;
-			dev->sp[k] = 0x04;
-		}
-	}
 	h = 0;
-	while (devid[h] != 0) {
-		pdev[2] = pci_find_device(0x1191, devid[h], pdev[2]);
-		if (pdev[2] == NULL || pci_enable_device(pdev[2])) {
-			h++;
-			index = 0;
-			continue;
-		}
-		chip_ver[2] = 0;
-		dev_id[2] = devid[h];
+	while (devid[h] != 0)
+	{
+		struct pci_dev *dev = NULL;
+		
+		while((dev = pci_find_device(0x1191, devid[h], dev))!=NULL)
+		{
+			if(pci_enable_device(dev))
+				continue;
 
-		if (devid[h] == 0x8002) {
-			error = pci_read_config_byte(pdev[2], 0x08, &chip_ver[2]);
-			if (chip_ver[2] < 2) {
-				goto nxt_devfn;
+			if(pci_set_dma_mask(dev, 0xFFFFFFFFUL))
+			{
+				printk(KERN_ERR "atp870u: 32bit DMA mask required but not available.\n");
+				continue;
 			}
+			chip_ver[card] = 0;
+			dev_id[card] = devid[h];
+
+			if (devid[h] == 0x8002) {
+				error = pci_read_config_byte(dev, 0x08, &chip_ver[card]);
+				if (chip_ver[card] < 2) {
+					continue;
+				}
+			}
+			if (devid[h] == 0x8010 || devid[h] == 0x8081 || devid[h] == 0x8050) {
+				chip_ver[card] = 0x04;
+			}
+			pdev[card] = dev;
+			card++;
+			if (card == MAX_ATP)
+				break;
 		}
-		if (devid[h] == 0x8010 || devid[h] == 0x8081 || devid[h] == 0x8050)
-		{
-			chip_ver[2] = 0x04;
-		}
-		pdev[tmpcnt] = pdev[2];
-		chip_ver[tmpcnt] = chip_ver[2];
-		dev_id[tmpcnt] = dev_id[2];
-		tmpcnt++;
-	      nxt_devfn:
-		index++;
-		if (index > 3) {
-			index = 0;
-			h++;
-		}
-		if(tmpcnt>1)
-			break;
 	}
-	for (h = 0; h < 2; h++) {
-		struct atp_unit *dev=&atp_unit[h];
-		if (pdev[h]==NULL) {
+	for (h = 0; h < MAX_ATP; h++) {
+		struct atp_unit tmp, *dev;
+		if (pdev[h] == NULL) {
 			return count;
 		}
 
@@ -2443,211 +2369,205 @@
 		base_io = pci_resource_start(pdev[h], 0);
 		irq = pdev[h]->irq;
 
-		if (dev_id[h] != 0x8081)
-		{
-		   error = pci_read_config_byte(pdev[h],0x49,&host_id);
+		if (dev_id[h] != 0x8081) {
+			error = pci_read_config_byte(pdev[h], 0x49, &host_id);
 
-		   base_io &= 0xfffffff8;
+			base_io &= 0xfffffff8;
 
-		   if (check_region(base_io,0x40) != 0)
-		   {
-			   return 0;
-		   }
-		   printk(KERN_INFO "   ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: %d    IO:%x, IRQ:%d.\n"
-			  ,h, base_io, irq);
-		   dev->ioport = base_io;
-		   dev->pciport = base_io + 0x20;
-		   dev->deviceid = dev_id[h];
-		   irqnumu[h] = irq;
-		   host_id &= 0x07;
-		   dev->host_idu = host_id;
-		   dev->chip_veru = chip_ver[h];
-
-		   tmport = base_io + 0x22;
-		   dev->scam_on = inb(tmport);
-		   tmport += 0x0b;
-		   dev->global_map = inb(tmport++);
-		   dev->ultra_map = inw(tmport);
-		   if (dev->ultra_map == 0) {
-			   dev->scam_on = 0x00;
-			   dev->global_map = 0x20;
-			   dev->ultra_map = 0xffff;
-		   }
-		   shpnt = scsi_register(tpnt, 4);
-		   if(shpnt==NULL)
-			   return count;
-
-		   save_flags(flags);
-		   cli();
-		   if (request_irq(irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", dev)) {
-			   printk(KERN_ERR "Unable to allocate IRQ for Acard controller.\n");
-			   goto unregister;
-		   }
-
-		   if (chip_ver[h] > 0x07)	     /* check if atp876 chip   */
-		   {				     /* then enable terminator */
-		      tmport = base_io + 0x3e;
-		      outb(0x00, tmport);
-		   }
-
-		   tmport = base_io + 0x3a;
-		   k = (inb(tmport) & 0xf3) | 0x10;
-		   outb(k, tmport);
-		   outb((k & 0xdf), tmport);
-		   mydlyu(0x8000);
-		   outb(k, tmport);
-		   mydlyu(0x8000);
-		   tmport = base_io;
-		   outb((host_id | 0x08), tmport);
-		   tmport += 0x18;
-		   outb(0, tmport);
-		   tmport += 0x07;
-		   while ((inb(tmport) & 0x80) == 0);
-		   tmport -= 0x08;
-		   inb(tmport);
-		   tmport = base_io + 1;
-		   outb(8, tmport++);
-		   outb(0x7f, tmport);
-		   tmport = base_io + 0x11;
-		   outb(0x20, tmport);
-
-		   tscam(h);
-		   is870(h, base_io);
-		   tmport = base_io + 0x3a;
-		   outb((inb(tmport) & 0xef), tmport);
-		   tmport++;
-		   outb((inb(tmport) | 0x20),tmport);
-		}
-		else
-		{
-		   base_io &= 0xfffffff8;
+			if (check_region(base_io, 0x40) != 0) {
+				return 0;
+			}
+			printk(KERN_INFO "   ACARD AEC-671X PCI Ultra/W SCSI-3 Host Adapter: %d    IO:%x, IRQ:%d.\n", h, base_io, irq);
+			
+			tmp.ioport = base_io;
+			tmp.pciport = base_io + 0x20;
+			tmp.deviceid = dev_id[h];
+			host_id &= 0x07;
+			tmp.host_idu = host_id;
+			tmp.chip_veru = chip_ver[h];
+
+			tmport = base_io + 0x22;
+			tmp.scam_on = inb(tmport);
+			tmport += 0x0b;
+			tmp.global_map = inb(tmport++);
+			tmp.ultra_map = inw(tmport);
+			if (tmp.ultra_map == 0) {
+				tmp.scam_on = 0x00;
+				tmp.global_map = 0x20;
+				tmp.ultra_map = 0xffff;
+			}
+			shpnt = scsi_register(tpnt, sizeof(struct atp_unit));
+			if (shpnt == NULL)
+				return count;
+			tmp.host = shpnt;
+			tmp.pdev = pdev[h];
+			/* Save the atp_unit data */
+			memcpy(&shpnt->hostdata, &tmp, sizeof(tmp));
+
+			atp870u_init_tables(shpnt);
+			spin_lock_irqsave(shpnt->host_lock, flags);
+			if (request_irq(irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", shpnt)) {
+				printk(KERN_ERR "Unable to allocate IRQ for Acard controller.\n");
+				goto unregister;
+			}
 
-		   if (check_region(base_io,0x60) != 0)
-		   {
-			   return 0;
-		   }
-		   host_id = inb(base_io + 0x39);
-		   host_id >>= 0x04;
-
-		   printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra160 LVD/SE SCSI Adapter: %d    IO:%x, IRQ:%d.\n"
-			  ,h, base_io, irq);
-		   dev->ioport = base_io + 0x40;
-		   dev->pciport = base_io + 0x28;
-		   dev->deviceid = dev_id[h];
-		   irqnumu[h] = irq;
-		   dev->host_idu = host_id;
-		   dev->chip_veru = chip_ver[h];
-
-		   tmport = base_io + 0x22;
-		   dev->scam_on = inb(tmport);
-		   tmport += 0x13;
-		   dev->global_map = inb(tmport);
-		   tmport += 0x07;
-		   dev->ultra_map = inw(tmport);
+			if (chip_ver[h] > 0x07) {	/* check if atp876 chip   *//* then enable terminator */
+				tmport = base_io + 0x3e;
+				outb(0x00, tmport);
+			}
+
+			tmport = base_io + 0x3a;
+			k = (inb(tmport) & 0xf3) | 0x10;
+			outb(k, tmport);
+			outb((k & 0xdf), tmport);
+			udelay(0x8000);
+			outb(k, tmport);
+			udelay(0x8000);
+			tmport = base_io;
+			outb((host_id | 0x08), tmport);
+			tmport += 0x18;
+			outb(0, tmport);
+			tmport += 0x07;
+			while ((inb(tmport) & 0x80) == 0);
+			tmport -= 0x08;
+			inb(tmport);
+			tmport = base_io + 1;
+			outb(8, tmport++);
+			outb(0x7f, tmport);
+			tmport = base_io + 0x11;
+			outb(0x20, tmport);
+
+			tscam(shpnt);
+			is870(shpnt, base_io);
+			tmport = base_io + 0x3a;
+			outb((inb(tmport) & 0xef), tmport);
+			tmport++;
+			outb((inb(tmport) | 0x20), tmport);
+		} else {
+			base_io &= 0xfffffff8;
+
+			if (check_region(base_io, 0x60) != 0) {
+				return 0;
+			}
+			host_id = inb(base_io + 0x39);
+			host_id >>= 0x04;
+
+			printk(KERN_INFO "   ACARD AEC-67160 PCI Ultra3 LVD Host Adapter: %d    IO:%x, IRQ:%d.\n", h, base_io, irq);
+			tmp.ioport = base_io + 0x40;
+			tmp.pciport = base_io + 0x28;
+			tmp.deviceid = dev_id[h];
+			tmp.host_idu = host_id;
+			tmp.chip_veru = chip_ver[h];
+
+			tmport = base_io + 0x22;
+			tmp.scam_on = inb(tmport);
+			tmport += 0x13;
+			tmp.global_map = inb(tmport);
+			tmport += 0x07;
+			tmp.ultra_map = inw(tmport);
 
-		   n=0x3f09;
+			n = 0x3f09;
 next_fblk:
-		   if (n >= 0x4000)
-		   {
-		      goto flash_ok;
-		   }
-		   m=0;
-		   outw(n,base_io + 0x34);
-		   n += 0x0002;
-		   if (inb(base_io + 0x30) == 0xff)
-		   {
-		      goto flash_ok;
-		   }
-		   dev->sp[m++]=inb(base_io + 0x30);
-		   dev->sp[m++]=inb(base_io + 0x31);
-		   dev->sp[m++]=inb(base_io + 0x32);
-		   dev->sp[m++]=inb(base_io + 0x33);
-		   outw(n,base_io + 0x34);
-		   n += 0x0002;
-		   dev->sp[m++]=inb(base_io + 0x30);
-		   dev->sp[m++]=inb(base_io + 0x31);
-		   dev->sp[m++]=inb(base_io + 0x32);
-		   dev->sp[m++]=inb(base_io + 0x33);
-		   outw(n,base_io + 0x34);
-		   n += 0x0002;
-		   dev->sp[m++]=inb(base_io + 0x30);
-		   dev->sp[m++]=inb(base_io + 0x31);
-		   dev->sp[m++]=inb(base_io + 0x32);
-		   dev->sp[m++]=inb(base_io + 0x33);
-		   outw(n,base_io + 0x34);
-		   n += 0x0002;
-		   dev->sp[m++]=inb(base_io + 0x30);
-		   dev->sp[m++]=inb(base_io + 0x31);
-		   dev->sp[m++]=inb(base_io + 0x32);
-		   dev->sp[m++]=inb(base_io + 0x33);
-		   n += 0x0018;
-		   goto next_fblk;
+			if (n >= 0x4000) {
+				goto flash_ok;
+			}
+			m = 0;
+			outw(n, base_io + 0x34);
+			n += 0x0002;
+			if (inb(base_io + 0x30) == 0xff) {
+				goto flash_ok;
+			}
+			tmp.sp[m++] = inb(base_io + 0x30);
+			tmp.sp[m++] = inb(base_io + 0x31);
+			tmp.sp[m++] = inb(base_io + 0x32);
+			tmp.sp[m++] = inb(base_io + 0x33);
+			outw(n, base_io + 0x34);
+			n += 0x0002;
+			tmp.sp[m++] = inb(base_io + 0x30);
+			tmp.sp[m++] = inb(base_io + 0x31);
+			tmp.sp[m++] = inb(base_io + 0x32);
+			tmp.sp[m++] = inb(base_io + 0x33);
+			outw(n, base_io + 0x34);
+			n += 0x0002;
+			tmp.sp[m++] = inb(base_io + 0x30);
+			tmp.sp[m++] = inb(base_io + 0x31);
+			tmp.sp[m++] = inb(base_io + 0x32);
+			tmp.sp[m++] = inb(base_io + 0x33);
+			outw(n, base_io + 0x34);
+			n += 0x0002;
+			tmp.sp[m++] = inb(base_io + 0x30);
+			tmp.sp[m++] = inb(base_io + 0x31);
+			tmp.sp[m++] = inb(base_io + 0x32);
+			tmp.sp[m++] = inb(base_io + 0x33);
+			n += 0x0018;
+			goto next_fblk;
 flash_ok:
-		   outw(0,base_io + 0x34);
-		   dev->ultra_map=0;
-		   dev->async = 0;
-		   for (k=0; k < 16; k++)
-		   {
-		       n=1;
-		       n = n << k;
-		       if (dev->sp[k] > 1)
-		       {
-			  dev->ultra_map |= n;
-		       }
-		       else
-		       {
-			  if (dev->sp[k] == 0)
-			  {
-			     dev->async |= n;
-			  }
-		       }
-		   }
-		   dev->async = ~(dev->async);
-		   outb(dev->global_map,base_io + 0x35);
-
-		   shpnt = scsi_register(tpnt, 4);
-		   if(shpnt==NULL)
-			   return count;
-
-		   save_flags(flags);
-		   cli();
-		   if (request_irq(irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", dev)) {
-			   printk(KERN_ERR "Unable to allocate IRQ for Acard controller.\n");
-			   goto unregister;
-		   }
-
-		   tmport = base_io + 0x38;
-		   k = inb(tmport) & 0x80;
-		   outb(k, tmport);
-		   tmport += 0x03;
-		   outb(0x20, tmport);
-		   mydlyu(0x8000);
-		   outb(0, tmport);
-		   mydlyu(0x8000);
-		   tmport = base_io + 0x5b;
-		   inb(tmport);
-		   tmport -= 0x04;
-		   inb(tmport);
-		   tmport = base_io + 0x40;
-		   outb((host_id | 0x08), tmport);
-		   tmport += 0x18;
-		   outb(0, tmport);
-		   tmport += 0x07;
-		   while ((inb(tmport) & 0x80) == 0);
-		   tmport -= 0x08;
-		   inb(tmport);
-		   tmport = base_io + 0x41;
-		   outb(8, tmport++);
-		   outb(0x7f, tmport);
-		   tmport = base_io + 0x51;
-		   outb(0x20, tmport);
-
-		   tscam(h);
-		   is880(h, base_io);
-		   tmport = base_io + 0x38;
-		   outb(0xb0, tmport);
+			outw(0, base_io + 0x34);
+			tmp.ultra_map = 0;
+			tmp.async = 0;
+			for (k = 0; k < 16; k++) {
+				n = 1;
+				n = n << k;
+				if (tmp.sp[k] > 1) {
+					tmp.ultra_map |= n;
+				} else {
+					if (tmp.sp[k] == 0) {
+						tmp.async |= n;
+					}
+				}
+			}
+			tmp.async = ~(tmp.async);
+			outb(tmp.global_map, base_io + 0x35);
+
+			shpnt = scsi_register(tpnt, sizeof(struct atp_unit));
+			if (shpnt == NULL)
+				return count;
+				
+			tmp.pdev = pdev[h];
+			memcpy(&shpnt->hostdata, &tmp, sizeof(tmp));
+			
+			atp870u_init_tables(shpnt);
+
+			spin_lock_irqsave(shpnt->host_lock, flags);
+			if (request_irq(irq, atp870u_intr_handle, SA_SHIRQ, "atp870u", shpnt)) {
+				printk(KERN_ERR "Unable to allocate IRQ for Acard controller.\n");
+				goto unregister;
+			}
+
+			tmport = base_io + 0x38;
+			k = inb(tmport) & 0x80;
+			outb(k, tmport);
+			tmport += 0x03;
+			outb(0x20, tmport);
+			udelay(0x8000);
+			outb(0, tmport);
+			udelay(0x8000);
+			tmport = base_io + 0x5b;
+			inb(tmport);
+			tmport -= 0x04;
+			inb(tmport);
+			tmport = base_io + 0x40;
+			outb((host_id | 0x08), tmport);
+			tmport += 0x18;
+			outb(0, tmport);
+			tmport += 0x07;
+			while ((inb(tmport) & 0x80) == 0);
+			tmport -= 0x08;
+			inb(tmport);
+			tmport = base_io + 0x41;
+			outb(8, tmport++);
+			outb(0x7f, tmport);
+			tmport = base_io + 0x51;
+			outb(0x20, tmport);
+
+			tscam(shpnt);
+			is880(shpnt, base_io);
+			tmport = base_io + 0x38;
+			outb(0xb0, tmport);
 		}
 
+		dev = (struct atp_unit *)&shpnt->hostdata;
+		
 		atp_host[h] = shpnt;
 		if (dev->chip_veru == 4) {
 			shpnt->max_id = 16;
@@ -2655,31 +2575,23 @@
 		shpnt->this_id = host_id;
 		shpnt->unique_id = base_io;
 		shpnt->io_port = base_io;
-		if (dev_id[h] == 0x8081)
-		{
-		   shpnt->n_io_port = 0x60;	   /* Number of bytes of I/O space used */
-		}
-		else
-		{
-		   shpnt->n_io_port = 0x40;	   /* Number of bytes of I/O space used */
+		if (dev_id[h] == 0x8081) {
+			shpnt->n_io_port = 0x60;	/* Number of bytes of I/O space used */
+		} else {
+			shpnt->n_io_port = 0x40;	/* Number of bytes of I/O space used */
 		}
 		shpnt->irq = irq;
 		restore_flags(flags);
-		if (dev_id[h] == 0x8081)
-		{
-		   request_region(base_io, 0x60, "atp870u");       /* Register the IO ports that we use */
-		}
-		else
-		{
-		   request_region(base_io, 0x40, "atp870u");       /* Register the IO ports that we use */
+		if (dev_id[h] == 0x8081) {
+			request_region(base_io, 0x60, "atp870u");	/* Register the IO ports that we use */
+		} else {
+			request_region(base_io, 0x40, "atp870u");	/* Register the IO ports that we use */
 		}
 		count++;
-		index++;
 		continue;
 unregister:
 		scsi_unregister(shpnt);
-		restore_flags(flags);
-		index++;
+		spin_unlock_irqrestore(shpnt->host_lock, flags);
 		continue;
 	}
 
@@ -2692,18 +2604,11 @@
 
 int atp870u_abort(Scsi_Cmnd * SCpnt)
 {
-	unsigned char h, j, k;
+	unsigned char j, k;
 	Scsi_Cmnd *workrequ;
 	unsigned int tmport;
-	struct atp_unit *dev;
-	for (h = 0; h <= admaxu; h++) {
-		if (SCpnt->host == atp_host[h]) {
-			goto find_adp;
-		}
-	}
-	panic("Abort host not found !");
-find_adp:
-	dev=&atp_unit[h];
+	struct atp_unit *dev = (struct atp_unit *)&SCpnt->host->hostdata;
+
 	printk(KERN_DEBUG "working=%x last_cmd=%x ", dev->working, dev->last_cmd);
 	printk(" quhdu=%x quendu=%x ", dev->quhdu, dev->quendu);
 	tmport = dev->ioport;
@@ -2714,71 +2619,44 @@
 	printk(" r1c=%2x", inb(tmport));
 	tmport += 0x03;
 	printk(" r1f=%2x in_snd=%2x ", inb(tmport), dev->in_snd);
-	tmport= dev->pciport;
+	tmport = dev->pciport;
 	printk(" r20=%2x", inb(tmport));
 	tmport += 0x02;
 	printk(" r22=%2x", inb(tmport));
 	tmport = dev->ioport + 0x3a;
-	printk(" r3a=%2x \n",inb(tmport));
+	printk(" r3a=%2x \n", inb(tmport));
 	tmport = dev->ioport + 0x3b;
-	printk(" r3b=%2x \n",inb(tmport));
-	for(j=0;j<16;j++)
-	{
-	   if (dev->id[j].curr_req != NULL)
-	   {
-		workrequ = dev->id[j].curr_req;
-		printk("\n que cdb= ");
-		for (k=0; k < workrequ->cmd_len; k++)
-		{
-		    printk(" %2x ",workrequ->cmnd[k]);
-		}
-		printk(" last_lenu= %lx ",dev->id[j].last_lenu);
-	   }
-	}
-	return (SCSI_ABORT_SNOOZE);
-}
-
-int atp870u_reset(Scsi_Cmnd * SCpnt, unsigned int reset_flags)
-{
-	unsigned char h;
-	struct atp_unit *dev;
-	/*
-	 * See if a bus reset was suggested.
-	 */
-	for (h = 0; h <= admaxu; h++) {
-		if (SCpnt->host == atp_host[h]) {
-			goto find_host;
+	printk(" r3b=%2x \n", inb(tmport));
+	for (j = 0; j < 16; j++) {
+		if (dev->id[j].curr_req != NULL) {
+			workrequ = dev->id[j].curr_req;
+			printk("\n que cdb= ");
+			for (k = 0; k < workrequ->cmd_len; k++) {
+				printk(" %2x ", workrequ->cmnd[k]);
+			}
+			printk(" last_lenu= %lx ", dev->id[j].last_lenu);
 		}
 	}
-	panic("Reset bus host not found !");
-find_host:
-	dev=&atp_unit[h];
-/*	SCpnt->result = 0x00080000;
-	SCpnt->scsi_done(SCpnt);
-	dev->working=0;
-	dev->quhdu=0;
-	dev->quendu=0;
-	return (SCSI_RESET_SUCCESS | SCSI_RESET_BUS_RESET);  */
-	return (SCSI_RESET_SNOOZE);
+	/* Sort of - the thing handles itself */
+	return SUCCESS;
 }
 
 const char *atp870u_info(struct Scsi_Host *notused)
 {
 	static char buffer[128];
 
-	strcpy(buffer, "ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver V2.5+ac ");
+	strcpy(buffer, "ACARD AEC-6710/6712/67160 PCI Ultra/W/LVD SCSI-3 Adapter Driver V2.6+ac ");
 
 	return buffer;
 }
 
 int atp870u_set_info(char *buffer, int length, struct Scsi_Host *HBAptr)
 {
-	return -ENOSYS; 	/* Currently this is a no-op */
+	return -ENOSYS;		/* Currently this is a no-op */
 }
 
 #define BLS buffer + len + size
-int atp870u_proc_info(char *buffer, char **start, off_t offset, int length,
-		      int hostno, int inout)
+int atp870u_proc_info(char *buffer, char **start, off_t offset, int length, int hostno, int inout)
 {
 	struct Scsi_Host *HBAptr;
 	static u8 buff[512];
@@ -2789,7 +2667,7 @@
 	off_t pos = 0;
 
 	HBAptr = NULL;
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < MAX_ATP; i++) {
 		if ((HBAptr = atp_host[i]) != NULL) {
 			if (HBAptr->host_no == hostno) {
 				break;
@@ -2811,7 +2689,7 @@
 	if (offset == 0) {
 		memset(buff, 0, sizeof(buff));
 	}
-	size += sprintf(BLS, "ACARD AEC-671X Driver Version: 2.5+ac\n");
+	size += sprintf(BLS, "ACARD AEC-671X Driver Version: 2.6+ac\n");
 	len += size;
 	pos = begin + len;
 	size = 0;
@@ -2835,7 +2713,7 @@
 
 #include "sd.h"
 
-int atp870u_biosparam(Scsi_Disk * disk, kdev_t dev, int *ip)
+static int atp870u_biosparam(Scsi_Disk * disk, kdev_t dev, int *ip)
 {
 	int heads, sectors, cylinders;
 
@@ -2856,24 +2734,18 @@
 }
 

-int atp870u_release (struct Scsi_Host *pshost)
+static int atp870u_release(struct Scsi_Host *pshost)
 {
-	int h;
-	for (h = 0; h <= admaxu; h++)
-	{
-		if (pshost == atp_host[h]) {
-			int k;
-			free_irq (pshost->irq, &atp_unit[h]);
-			release_region (pshost->io_port, pshost->n_io_port);
-			scsi_unregister(pshost);
-			for(k=0;k<16;k++)
-				kfree(atp_unit[h].id[k].prd_tableu);
-			return 0;
-		}
-	}
-	panic("atp870u: bad scsi host passed.\n");
-
+	struct atp_unit *dev = (struct atp_unit *)&pshost->hostdata;
+	int k;
+	free_irq(pshost->irq, pshost);
+	release_region(pshost->io_port, pshost->n_io_port);
+	scsi_unregister(pshost);
+	for (k = 0; k < 16; k++)
+		pci_free_consistent(dev->pdev, 1024, dev->id[k].prd_tableu, dev->id[k].prd_phys);
+	return 0;
 }
+
 MODULE_LICENSE("GPL");
 
 static Scsi_Host_Template driver_template = ATP870U;
--- linux-2.5.27/drivers/scsi/atp870u.h	Sat Jul 20 20:11:07 2002
+++ linux-2.5.27-ac1/drivers/scsi/atp870u.h	Sun Jul 21 23:27:21 2002
@@ -18,14 +18,12 @@
 #define MAX_CDB 12
 #define MAX_SENSE 14
 
-int atp870u_detect(Scsi_Host_Template *);
-int atp870u_command(Scsi_Cmnd *);
-int atp870u_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
-int atp870u_abort(Scsi_Cmnd *);
-int atp870u_reset(Scsi_Cmnd *, unsigned int);
-int atp870u_biosparam(Disk *, kdev_t, int *);
-int atp870u_release(struct Scsi_Host *);
-void send_s870(unsigned char);
+static int atp870u_detect(Scsi_Host_Template *);
+static int atp870u_command(Scsi_Cmnd *);
+static int atp870u_queuecommand(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
+static int atp870u_abort(Scsi_Cmnd *);
+static int atp870u_biosparam(Disk *, kdev_t, int *);
+static int atp870u_release(struct Scsi_Host *);
 
 #define qcnt		32
 #define ATP870U_SCATTER 128
@@ -50,12 +48,7 @@
 	command: atp870u_command,				\
 	queuecommand: atp870u_queuecommand,			\
 	eh_strategy_handler: NULL,				\
-	eh_abort_handler: NULL, 				\
-	eh_device_reset_handler: NULL,				\
-	eh_bus_reset_handler: NULL,				\
-	eh_host_reset_handler: NULL,				\
-	abort: atp870u_abort,					\
-	reset: atp870u_reset,					\
+	eh_abort_handler: atp870u_abort, 			\
 	slave_attach: NULL,					\
 	bios_param: atp870u_biosparam,				\
 	can_queue: qcnt,	 /* max simultaneous cmds      */\


