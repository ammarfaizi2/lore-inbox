Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUJOPMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUJOPMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUJOPKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:10:40 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:24026 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267953AbUJOPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:05:40 -0400
Subject: Re: cciss update [2/2] fixes for Steeleye Lifekeeper
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: mikem@beardog.cca.cpqcorp.net, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041014183948.GA12325@infradead.org>
References: <20041013212253.GB9866@beardog.cca.cpqcorp.net>
	<20041014083900.GB7747@infradead.org> <1097764660.2198.11.camel@mulgrave> 
	<20041014183948.GA12325@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Oct 2004 10:05:09 -0500
Message-Id: <1097852716.1718.9.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 13:39, Christoph Hellwig wrote:
> Such a volume has been configured and set up, and although it's still
> ugly I'd say it's okay.  But the patch also adds one gendisk per controller
> even if no volume is set up.

That's this bit of code:

@@ -2762,7 +2810,9 @@ static int __devinit cciss_init_one(stru
                disk->fops = &cciss_fops;
                disk->queue = hba[i]->queue;
                disk->private_data = drv;
-               if( !(drv->nr_blocks))
+               /* we must register the controller even if no disks
exist */
+               /* this is for the online array utilities */
+               if(!drv->heads && j)
                        continue;
                blk_queue_hardsect_size(hba[i]->queue, drv->block_size);
                set_capacity(disk, drv->nr_blocks);

Mike, is there a way we can only allocate a gendisk when we know there's
actually a device there (if owned by another controller currently)?

James


