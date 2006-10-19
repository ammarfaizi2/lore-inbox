Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWJSNTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWJSNTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWJSNTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:19:40 -0400
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:7634 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1751601AbWJSNTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:19:40 -0400
Subject: Re: Unnecessary BKL contention in video1394
From: Daniel Drake <ddrake@brontes3d.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ak@suse.de
In-Reply-To: <45369E69.30007@s5r6.in-berlin.de>
References: <1161203487.28713.8.camel@systems03.lan.brontes3d.com>
	 <45369E69.30007@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 09:19:38 -0400
Message-Id: <1161263978.2845.6.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 23:36 +0200, Stefan Richter wrote:
> (added Cc: lkml to pull in some clues)
> 
> Daniel Drake wrote at linux1394-devel:
> > Hi,
> > 
> > I noticed that video1394 calls lock_kernel in it's file_operations. I
> > thought about converting these into a per-instance mutex or something,
> > but in the end I couldn't find a reason why this locking is needed. (The
> > more important I/O system is protected by separate spinlocks)
> > 
> > The BKL is only contended when operations such as ioctl() or release()
> > are invoked. My knowledge lacks at this point, but I'm reasonably sure
> > that some upper layer must ensure that these invokations are serialized,
> > as opposed to leaving it up to the driver to handle nasty potential
> > situations e.g. release() being called halfway through a read(). Can
> > anyone clarify?

> I think you are right. Same with dv1394. Although we need to
> double-check whether something needs replacement protection then.

Adding Andi Kleen to CC, who added the BKL around __video1394_ioctl a
long while back (when converting video1394 to compat_ioctl).

I don't feel that any replacement protection is needed, since the
critical sections (where structures are used both in interrupts and in
file_operations) are already protected by spinlocks.

> > ------------------------------------------------------------------------
> > 
> > Index: linux/drivers/ieee1394/video1394.c
> > ===================================================================
> > --- linux.orig/drivers/ieee1394/video1394.c
> > +++ linux/drivers/ieee1394/video1394.c
> > @@ -1161,9 +1161,7 @@ static int __video1394_ioctl(struct file
> >  static long video1394_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  {
> >  	int err;
> > -	lock_kernel();
> >  	err = __video1394_ioctl(file, cmd, arg);
> > -	unlock_kernel();
> >  	return err;
> >  }
> >  
> > @@ -1181,13 +1179,11 @@ static int video1394_mmap(struct file *f
> >  	struct file_ctx *ctx = (struct file_ctx *)file->private_data;
> >  	int res = -EINVAL;
> >  
> > -	lock_kernel();
> >  	if (ctx->current_ctx == NULL) {
> >  		PRINT(KERN_ERR, ctx->ohci->host->id,
> >  				"Current iso context not set");
> >  	} else
> >  		res = dma_region_mmap(&ctx->current_ctx->dma, file, vma);
> > -	unlock_kernel();
> >  
> >  	return res;
> >  }
> > @@ -1200,7 +1196,6 @@ static unsigned int video1394_poll(struc
> >  	struct dma_iso_ctx *d;
> >  	int i;
> >  
> > -	lock_kernel();
> >  	ctx = file->private_data;
> >  	d = ctx->current_ctx;
> >  	if (d == NULL) {
> > @@ -1221,7 +1216,6 @@ static unsigned int video1394_poll(struc
> >  	}
> >  	spin_unlock_irqrestore(&d->lock, flags);
> >  done:
> > -	unlock_kernel();
> >  
> >  	return mask;
> >  }
> > @@ -1257,7 +1251,6 @@ static int video1394_release(struct inod
> >  	struct list_head *lh, *next;
> >  	u64 mask;
> >  
> > -	lock_kernel();
> >  	list_for_each_safe(lh, next, &ctx->context_list) {
> >  		struct dma_iso_ctx *d;
> >  		d = list_entry(lh, struct dma_iso_ctx, link);
> > @@ -1278,7 +1271,6 @@ static int video1394_release(struct inod
> >  	kfree(ctx);
> >  	file->private_data = NULL;
> >  
> > -	unlock_kernel();
> >  	return 0;
> >  }
> >  
> > 
> 

