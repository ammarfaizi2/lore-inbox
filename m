Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRJZJlL>; Fri, 26 Oct 2001 05:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278084AbRJZJlB>; Fri, 26 Oct 2001 05:41:01 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:19689 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278081AbRJZJkv>; Fri, 26 Oct 2001 05:40:51 -0400
Date: Fri, 26 Oct 2001 10:41:25 +0100
From: Tim Waugh <twaugh@redhat.com>
To: junio@siamese.dhis.twinsun.com
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: [patch] Re: linux-2.4.12 / linux-2.4.13 parallel port problem
Message-ID: <20011026104125.Z7544@redhat.com>
In-Reply-To: <20011024230917.H7544@redhat.com> <ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com> <20011025165226.T7544@redhat.com> <7vofmuu9d7.fsf@siamese.dhis.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7vofmuu9d7.fsf@siamese.dhis.twinsun.com>; from junio@siamese.dhis.twinsun.com on Fri, Oct 26, 2001 at 12:51:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 12:51:48AM -0700, junio@siamese.dhis.twinsun.com wrote:

> >From the original poster's description, 2.4.10 claimed to have
> detected both address and irq for parport0, while 2.4.12,
> according to the your response, could not tell that IRQ=7.  Do
> you mean that the logic which made 2.4.10 to claime to have
> detected IRQ=7 was faulty and the logic in 2.4.12 is being
> careful not to misdetect?

Oh, I see.  No, this is a regression.  Please try this patch:

--- linux/drivers/parport/ChangeLog.irq	Fri Oct 26 10:11:02 2001
+++ linux/drivers/parport/ChangeLog	Fri Oct 26 10:37:36 2001
@@ -0,0 +1,8 @@
+2001-10-26  Tim Waugh  <twaugh@redhat.com>
+
+	* parport_pc.c (parport_irq_probe): When ECR programmable IRQ
+	support fails, generate interrupts using the FIFO even if we don't
+	want to use the FIFO for real data transfers.
+	(parport_pc_probe_port): Display the ECR address if we have an
+	ECR, not just if we will use the FIFO.
+
--- linux/drivers/parport/parport_pc.c.irq	Fri Oct 26 10:11:06 2001
+++ linux/drivers/parport/parport_pc.c	Fri Oct 26 10:35:49 2001
@@ -2119,10 +2119,9 @@
 
 	if (priv->ecr) {
 		pb->irq = programmable_irq_support(pb);
-	}
 
-	if (pb->modes & PARPORT_MODE_ECP) {
-		pb->irq = irq_probe_ECP(pb);
+		if (pb->irq == PARPORT_IRQ_NONE)
+			pb->irq = irq_probe_ECP(pb);
 	}
 
 	if ((pb->irq == PARPORT_IRQ_NONE) && priv->ecr &&
@@ -2255,7 +2254,7 @@
 	p->private_data = priv;
 
 	printk(KERN_INFO "%s: PC-style at 0x%lx", p->name, p->base);
-	if (p->base_hi && (p->modes & PARPORT_MODE_ECP))
+	if (p->base_hi && priv->ecr)
 		printk(" (0x%lx)", p->base_hi);
 	p->irq = irq;
 	p->dma = dma;

Tim.
*/
