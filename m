Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUEFKtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUEFKtS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUEFKtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:49:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6309 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262029AbUEFKrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:47:04 -0400
Date: Thu, 6 May 2004 12:46:38 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506104638.GA9929@devserv.devel.redhat.com>
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org> <20040506075044.GC12862@devserv.devel.redhat.com> <20040506085549.A13098@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506085549.A13098@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 06, 2004 at 08:55:49AM +0100, Christoph Hellwig wrote:
> On Thu, May 06, 2004 at 09:50:44AM +0200, Arjan van de Ven wrote:
> > > Please don't use reboot notifiers in new driver code.  The driver
> > > model has a ->shutdown method for that.
> > 
> > there is somewhat of a problem with that; the reboot command potentially
> > runs from the disk in question, so that might never get called since that
> > will keep things busy.
> 
> shutdown != remove.  Shutdown is called for all devices on shutdown, remove
> isn't called at all at reboot.

Ok the following does the trick for me. Better?

diff -purN linux-2.6.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.6.5/drivers/ide/ide-disk.c	2004-05-06 10:56:55.672139712 +0200
+++ linux/drivers/ide/ide-disk.c	2004-05-06 11:09:19.470065240 +0200
@@ -1820,6 +1820,23 @@ static int idedisk_revalidate_disk(struc
 	return 0;
 }
 
+static int ide_drive_shutdown(struct device * dev)
+{
+	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
+	
+	/* safety checks */
+	if (!drive->present)
+		return 0;
+	if (drive->media != ide_disk)
+		return 0;
+	printk("Flushing cache: %s \n", drive->name);
+	ide_cacheflush_p(drive);
+	/* give the hardware time to finish; it may return prematurely to cheat */
+	mdelay(300);
+	return 0;
+}
+                        
+
 static struct block_device_operations idedisk_ops = {
 	.owner		= THIS_MODULE,
 	.open		= idedisk_open,
@@ -1881,6 +1898,7 @@ static void __exit idedisk_exit (void)
 
 static int idedisk_init (void)
 {
+	idedisk_driver.gen_driver.shutdown = ide_drive_shutdown;
 	return ide_register_driver(&idedisk_driver);
 }
 
