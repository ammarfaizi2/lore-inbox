Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423003AbWJRVgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbWJRVgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423007AbWJRVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:36:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:7384 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1423003AbWJRVgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:36:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45369E69.30007@s5r6.in-berlin.de>
Date: Wed, 18 Oct 2006 23:36:41 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Daniel Drake <ddrake@brontes3d.com>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary BKL contention in video1394
References: <1161203487.28713.8.camel@systems03.lan.brontes3d.com>
In-Reply-To: <1161203487.28713.8.camel@systems03.lan.brontes3d.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(added Cc: lkml to pull in some clues)

Daniel Drake wrote at linux1394-devel:
> Hi,
> 
> I noticed that video1394 calls lock_kernel in it's file_operations. I
> thought about converting these into a per-instance mutex or something,
> but in the end I couldn't find a reason why this locking is needed. (The
> more important I/O system is protected by separate spinlocks)
> 
> The BKL is only contended when operations such as ioctl() or release()
> are invoked. My knowledge lacks at this point, but I'm reasonably sure
> that some upper layer must ensure that these invokations are serialized,
> as opposed to leaving it up to the driver to handle nasty potential
> situations e.g. release() being called halfway through a read(). Can
> anyone clarify?
> 
> Thanks,
> Daniel

I think you are right. Same with dv1394. Although we need to
double-check whether something needs replacement protection then.

> ------------------------------------------------------------------------
> 
> Index: linux/drivers/ieee1394/video1394.c
> ===================================================================
> --- linux.orig/drivers/ieee1394/video1394.c
> +++ linux/drivers/ieee1394/video1394.c
> @@ -1161,9 +1161,7 @@ static int __video1394_ioctl(struct file
>  static long video1394_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	int err;
> -	lock_kernel();
>  	err = __video1394_ioctl(file, cmd, arg);
> -	unlock_kernel();
>  	return err;
>  }
>  
> @@ -1181,13 +1179,11 @@ static int video1394_mmap(struct file *f
>  	struct file_ctx *ctx = (struct file_ctx *)file->private_data;
>  	int res = -EINVAL;
>  
> -	lock_kernel();
>  	if (ctx->current_ctx == NULL) {
>  		PRINT(KERN_ERR, ctx->ohci->host->id,
>  				"Current iso context not set");
>  	} else
>  		res = dma_region_mmap(&ctx->current_ctx->dma, file, vma);
> -	unlock_kernel();
>  
>  	return res;
>  }
> @@ -1200,7 +1196,6 @@ static unsigned int video1394_poll(struc
>  	struct dma_iso_ctx *d;
>  	int i;
>  
> -	lock_kernel();
>  	ctx = file->private_data;
>  	d = ctx->current_ctx;
>  	if (d == NULL) {
> @@ -1221,7 +1216,6 @@ static unsigned int video1394_poll(struc
>  	}
>  	spin_unlock_irqrestore(&d->lock, flags);
>  done:
> -	unlock_kernel();
>  
>  	return mask;
>  }
> @@ -1257,7 +1251,6 @@ static int video1394_release(struct inod
>  	struct list_head *lh, *next;
>  	u64 mask;
>  
> -	lock_kernel();
>  	list_for_each_safe(lh, next, &ctx->context_list) {
>  		struct dma_iso_ctx *d;
>  		d = list_entry(lh, struct dma_iso_ctx, link);
> @@ -1278,7 +1271,6 @@ static int video1394_release(struct inod
>  	kfree(ctx);
>  	file->private_data = NULL;
>  
> -	unlock_kernel();
>  	return 0;
>  }
>  
> 

-- 
Stefan Richter
-=====-=-==- =-=- =--=-
http://arcgraph.de/sr/
