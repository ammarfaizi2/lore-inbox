Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVEASlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVEASlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 14:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVEASlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 14:41:14 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:41609 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262641AbVEASlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 14:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y0IvQJjDu3PAR/V+0sVWsYDmAQjWr4S01LbqwXGGM4LIvoh5YiZPSY9Ux0mvEiPGve2s3jC55i+E7r3HYIKLi2qkvIeeyrdhtALvITBwffKMEGeMUWZlrZW1Xmkf9Z/NwGSYO/aJeeSgygbT0yWYn3hOdoDllnPXxXQneDk97KM=
Message-ID: <58cb370e0505011141a2b3c58@mail.gmail.com>
Date: Sun, 1 May 2005 20:41:03 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: IDE problems in 2.6.12-rc1-bk1 onwards (was Re: 2.6.12-rc3-mm1)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <03be01c54e77$83d86980$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <03be01c54e77$83d86980$0f01a8c0@max>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/05, Richard Purdie <rpurdie@rpsys.net> wrote:
> I've switched back to 2.6.12-rc3-mm1 and added some debuging to all the ide
> functions to trace the order functions are getting called. I've shown the
> result below for two different oops. There is more than one problem. The
> first problem was introduced in 2.6.12-rc1-bk1 in the ide-disk changes. The
> second has been around for a while but is showing up again.
>  
> The problem is idedisk_cleanup() gets called twice from ide_unregister().
> Once here:
> 
>  for (unit = 0; unit < MAX_DRIVES; ++unit) {
>   drive = &hwif->drives[unit];
>   if (!drive->present)
>    continue;
>   DRIVER(drive)->cleanup(drive);
>  }
> 
> and secondly in ide_unregister indirectly via:
> 
>   blk_cleanup_queue(drive->queue);
>   printk(KERN_ERR "ide_unregister4()\n");
>   device_unregister(&drive->gendev);
>   down(&drive->gendev_rel_sem);
>   spin_lock_irq(&ide_lock);
>   drive->queue = NULL;
>   printk(KERN_ERR "ide_unregister5()\n");
> 
> device_unregister()  triggers ide_drive_remove() which calls
> DRIVER(drive)->cleanup(drive);
> 
> In the first call to idedisk_cleanup(), ide_disk_put(idkp) is called which
> decreases the reference counter to zero. This triggers ide_disk_release()
> which calls kfree(idkp). Hence the second call to idedisk_cleanup() calls
> what is now a null pointer (or worse).

Thanks for excellent debugging.

Both problems should be fixed by "convert IDE device drivers to 
driver-model" patch but I need to resync it against latest kernels.

Bartlomiej
