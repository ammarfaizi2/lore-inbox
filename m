Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUEFLdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUEFLdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUEFLdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:33:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262006AbUEFLdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:33:44 -0400
Date: Thu, 6 May 2004 13:33:09 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506113309.GB16548@devserv.devel.redhat.com>
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org> <20040506075044.GC12862@devserv.devel.redhat.com> <20040506085549.A13098@infradead.org> <20040506104638.GA9929@devserv.devel.redhat.com> <20040506115220.A14669@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506115220.A14669@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 11:52:20AM +0100, Christoph Hellwig wrote:
> > +	idedisk_driver.gen_driver.shutdown = ide_drive_shutdown;
> 
> isn't idedisk_driver initialized statically somewhere?  You should probably

ok ok you win

diff -purN linux-2.6.5/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.6.5/drivers/ide/ide-disk.c	2004-05-06 13:26:53.350284720 +0200
+++ linux/drivers/ide/ide-disk.c	2004-05-06 13:32:01.322465832 +0200
@@ -1725,6 +1725,9 @@ static ide_driver_t idedisk_driver = {
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
 	.start_power_step	= idedisk_start_power_step,
 	.complete_power_step	= idedisk_complete_power_step,
+	.gen_driver = {
+		.shutdown	= ide_drive_shutdown,
+	},	                                
 };
 
@@ -1820,6 +1823,23 @@ static int idedisk_revalidate_disk(struc
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
