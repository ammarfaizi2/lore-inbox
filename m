Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUEVVvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUEVVvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUEVVvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 17:51:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9863 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261232AbUEVVva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 17:51:30 -0400
Date: Sat, 22 May 2004 17:51:26 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org
Subject: PATCH: initial 2.6 fixup for ATP870U scsi
Message-ID: <20040522215126.GA20151@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty minimal. queue_command is now called locked, this requires propogating
some small locking changes for send_s870


--- ../linux.vanilla-2.6.6/drivers/scsi/atp870u.c	2004-05-10 03:32:28.000000000 +0100
+++ drivers/scsi/atp870u.c	2004-05-22 22:44:43.607956200 +0100
@@ -4,6 +4,7 @@
  *  Copyright (C) 1997	Wu Ching Chen
  *  2.1.x update (C) 1998  Krzysztof G. Baranowski
  *  2.5.x update (C) 2002  Red Hat <alan@redhat.com>
+ *  2.6.x update (C) 2004  Red Hat <alan@redhat.com>
  *
  * Marcelo Tosatti <marcelo@conectiva.com.br> : SMP fixes
  *
@@ -126,9 +127,11 @@
 			/*
 			 *      Issue more commands
 			 */
+			spin_lock_irqsave(dev->host->host_lock, flags);
 			if (((dev->quhdu != dev->quendu) || (dev->last_cmd != 0xff)) && (dev->in_snd == 0)) {
 				send_s870(host);
 			}
+			spin_unlock_irqrestore(dev->host->host_lock, flags);
 			/*
 			 *      Done
 			 */
@@ -371,9 +374,11 @@
 			/*
 			 *      If there is stuff to send and nothing going then send it
 			 */
+			spin_lock_irqsave(dev->host->host_lock, flags);
 			if (((dev->last_cmd != 0xff) || (dev->quhdu != dev->quendu)) && (dev->in_snd == 0)) {
 				send_s870(host);
 			}
+			spin_unlock_irqrestore(dev->host->host_lock, flags);
 			dev->in_int = 0;
 			goto out;
 		}
@@ -443,9 +448,16 @@
 	return IRQ_HANDLED;
 }
 
+/**
+ *	atp870u_queuecommand	-	Queue SCSI command
+ *	@req_p: request block
+ *	@done: completion function
+ *
+ *	Queue a command to the ATP queue. Called with the host lock held.
+ */
+ 
 static int atp870u_queuecommand(Scsi_Cmnd * req_p, void (*done) (Scsi_Cmnd *))
 {
-	unsigned long flags;
 	unsigned short int m;
 	unsigned int tmport;
 	struct Scsi_Host *host;
@@ -484,7 +496,6 @@
 	 *      Count new command
 	 */
 
-	spin_lock_irqsave(host->host_lock, flags);
 	dev->quendu++;
 	if (dev->quendu >= qcnt) {
 		dev->quendu = 0;
@@ -498,24 +509,31 @@
 		}
 		dev->quendu--;
 		req_p->result = 0x00020000;
-		spin_unlock_irqrestore(host->host_lock, flags);
 		done(req_p);
 		return 0;
 	}
 	dev->querequ[dev->quendu] = req_p;
 	tmport = dev->ioport + 0x1c;
-	spin_unlock_irqrestore(host->host_lock, flags);
 	if ((inb(tmport) == 0) && (dev->in_int == 0) && (dev->in_snd == 0)) {
 		send_s870(host);
 	}
 	return 0;
 }
 
+/**
+ *	send_s870	-	send a command to the controller
+ *	@host: host
+ *
+ *	On entry there is work queued to be done. We move some of that work to the
+ *	controller itself. 
+ *
+ *	Caller holds the host lock.
+ */
+ 
 static void send_s870(struct Scsi_Host *host)
 {
 	unsigned int tmport;
 	Scsi_Cmnd *workrequ;
-	unsigned long flags;
 	unsigned int i;
 	unsigned char j, target_id;
 	unsigned char *prd;
@@ -527,10 +545,7 @@
 	struct atp_unit *dev = (struct atp_unit *)&host->hostdata;
 	int sg_count;
 
-	spin_lock_irqsave(host->host_lock, flags);
-	
 	if (dev->in_snd != 0) {
-		spin_unlock_irqrestore(host->host_lock, flags);
 		return;
 	}
 	dev->in_snd = 1;
@@ -543,13 +558,11 @@
 		dev->last_cmd = 0xff;
 		if (dev->quhdu == dev->quendu) {
 			dev->in_snd = 0;
-			spin_unlock_irqrestore(dev->host->host_lock, flags);
 			return;
 		}
 	}
 	if ((dev->last_cmd != 0xff) && (dev->working != 0)) {
 		dev->in_snd = 0;
-		spin_unlock_irqrestore(dev->host->host_lock, flags);
 		return;
 	}
 	dev->working++;
@@ -567,7 +580,6 @@
 	dev->quhdu = j;
 	dev->working--;
 	dev->in_snd = 0;
-	spin_unlock_irqrestore(host->host_lock, flags);
 	return;
 cmd_subp:
 	workportu = dev->ioport;
@@ -582,7 +594,6 @@
 abortsnd:
 	dev->last_cmd |= 0x40;
 	dev->in_snd = 0;
-	spin_unlock_irqrestore(dev->host->host_lock, flags);
 	return;
 oktosend:
 	memcpy(&dev->ata_cdbu[0], &workrequ->cmnd[0], workrequ->cmd_len);
@@ -684,7 +695,6 @@
 			dev->last_cmd |= 0x40;
 		}
 		dev->in_snd = 0;
-		spin_unlock_irqrestore(host->host_lock, flags);
 		return;
 	}
 	tmpcip = dev->pciport;
@@ -770,7 +780,6 @@
 			dev->last_cmd |= 0x40;
 		}
 		dev->in_snd = 0;
-		spin_unlock_irqrestore(host->host_lock, flags);
 		return;
 	}
 	if (inb(tmport) == 0) {
@@ -781,9 +790,6 @@
 		dev->last_cmd |= 0x40;
 	}
 	dev->in_snd = 0;
-	spin_unlock_irqrestore(host->host_lock, flags);
-	return;
-
 }
 
 static unsigned char fun_scam(struct atp_unit *dev, unsigned short int *val)
