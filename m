Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbRLFJTl>; Thu, 6 Dec 2001 04:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285070AbRLFJTZ>; Thu, 6 Dec 2001 04:19:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62730 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285063AbRLFJTE>; Thu, 6 Dec 2001 04:19:04 -0500
Subject: Re: Adaptec-2920 eats too much cpu time when reading from the CD-ROM
To: florin@iucha.net (Florin Iucha)
Date: Thu, 6 Dec 2001 09:28:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, faith@acm.org
In-Reply-To: <20011206030154.GA5979@iucha.net> from "Florin Iucha" at Dec 05, 2001 09:01:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Bup6-00012G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have recently purchased a Plextor 12x CD-RW and I have attached it to
> and Adaptec-2920 SCSI card. The card uses the "Future Domain Corp. TMC-18C30
> [36C70]" chip.
> 
> The problem I see: when reading from the CD-RW my system becomes very
> unresponsive and top reveals 90-95% of the time is spent on "system".
> My CPU is AMD K6-III/500MHz with 256 Mb RAM.

I'd expect that. The 2920 is pretty old. It has no DMA channel and several
processes it must perform are polled not interrupt driven.

>    scsi1: <fdomain> No BIOS; using scsi id 7
>    scsi1: <fdomain> TMC-36C70 (PCI bus) chip at 0xdc00 irq 10
>    Bad boy: fdomain (at 0xd08b7866) called us without a dev_id!

The Bad boy: line is fixable tho.. This should do it - let me know if it 
makes that one go away.

--- linux.gamma/drivers/scsi/fdomain.h	Sat Nov 17 20:47:53 2001
+++ linux.ac/drivers/scsi/fdomain.h	Thu Dec  6 10:14:51 2001
@@ -43,6 +43,7 @@
 		       abort:          fdomain_16x0_abort,               \
 		       reset:          fdomain_16x0_reset,               \
 		       bios_param:     fdomain_16x0_biosparam,           \
+		       release:        fdomain_16x0_release,		 \
 		       can_queue:      1, 				 \
 		       this_id:        6, 				 \
 		       sg_tablesize:   64, 				 \
--- linux.gamma/drivers/scsi/fdomain.c	Sat Nov 17 20:47:53 2001
+++ linux.ac/drivers/scsi/fdomain.c	Thu Dec  6 10:15:08 2001
@@ -983,7 +983,7 @@
       /* Register the IRQ with the kernel */
 
       retcode = request_irq( interrupt_level,
-			     do_fdomain_16x0_intr, pdev?SA_SHIRQ:0, "fdomain", NULL);
+			     do_fdomain_16x0_intr, pdev?SA_SHIRQ:0, "fdomain", shpnt);
 
       if (retcode < 0) {
 	 if (retcode == -EINVAL) {
@@ -2033,6 +2033,15 @@
    }
    
    return 0;
+}
+
+int fdomain_16x0_release(struct Scsi_Host *shpnt)
+{
+	if (shpnt->irq)
+		free_irq(shpnt->irq, shpnt);
+	if (shpnt->io_port && shpnt->n_io_port)
+		release_region(shpnt->io_port, shpnt->n_io_port);
+
 }
 
 MODULE_LICENSE("GPL");
