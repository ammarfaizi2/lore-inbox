Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTGCPIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTGCPIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:08:17 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:44558 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264144AbTGCPIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:08:12 -0400
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: 2.5.74: aha1740.c doesn't compile
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
	<20030703101846.GH282@fs.tum.de>
	<wrpy8zfizqd.fsf@hina.wild-wind.fr.eu.org>
	<20030703142705.GL282@fs.tum.de>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Thu, 03 Jul 2003 17:16:51 +0200
Message-ID: <wrpfzlniqsc.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030703142705.GL282@fs.tum.de> (Adrian Bunk's message of
 "Thu, 3 Jul 2003 16:27:06 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:

Adrian> On Thu, Jul 03, 2003 at 02:03:38PM +0200, Marc Zyngier wrote:
>> >>>>> "Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:
>> 
Adrian> drivers/scsi/aha1740.c fails to build on 2.5.74 withthe
Adrian> following error:
>> 
>> Weird error.
>> 
>> Compiles just fine here... Please send your .config.

Adrian> It's attached.

Ok, paper bag, please. I should _really_ use DEBUG_SPINLOCK...

James, please apply.

       M.

--- linux-2.5/drivers/scsi/aha1740.c	2003-07-01 18:51:30.000000000 +0200
+++ linux-2.5.74/drivers/scsi/aha1740.c	2003-07-03 17:12:31.000000000 +0200
@@ -375,7 +375,7 @@
 #endif
 
 	/* locate an available ecb */
-	spin_lock_irqsave(&SCpnt->device->host->host_lock, flags);
+	spin_lock_irqsave(SCpnt->device->host->host_lock, flags);
 	ecbno = host->last_ecb_used + 1; /* An optimization */
 	if (ecbno >= AHA1740_ECBS)
 		ecbno = 0;
@@ -394,7 +394,7 @@
 						    doubles as reserved flag */
 
 	host->last_ecb_used = ecbno;    
-	spin_unlock_irqrestore(&SCpnt->device->host->host_lock, flags);
+	spin_unlock_irqrestore(SCpnt->device->host->host_lock, flags);
 
 #ifdef DEBUG
 	printk("Sending command (%d %x)...", ecbno, done);
@@ -491,7 +491,7 @@
 		unsigned int base = SCpnt->device->host->io_port;
 		DEB(printk("aha1740[%d] critical section\n",ecbno));
 
-		spin_lock_irqsave(&SCpnt->device->host->host_lock, flags);
+		spin_lock_irqsave(SCpnt->device->host->host_lock, flags);
 		for (loopcnt = 0; ; loopcnt++) {
 			if (inb(G2STAT(base)) & G2STAT_MBXOUT) break;
 			if (loopcnt == LOOPCNT_WARN) {
@@ -511,7 +511,7 @@
 				panic("aha1740.c: attn wait failed!\n");
 		}
 		outb(ATTN_START | (target & 7), ATTN(base)); /* Start it up */
-		spin_unlock_irqrestore(&SCpnt->device->host->host_lock, flags);
+		spin_unlock_irqrestore(SCpnt->device->host->host_lock, flags);
 		DEB(printk("aha1740[%d] request queued.\n",ecbno));
 	} else
 		printk(KERN_ALERT "aha1740_queuecommand: done can't be NULL\n");

-- 
Places change, faces change. Life is so very strange.
