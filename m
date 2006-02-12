Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWBLSND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWBLSND (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 13:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBLSND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 13:13:03 -0500
Received: from verein.lst.de ([213.95.11.210]:27802 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751117AbWBLSNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 13:13:02 -0500
Date: Sun, 12 Feb 2006 19:12:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dasd: cleanup dasd_ioctl
Message-ID: <20060212181255.GA26799@lst.de>
References: <20060212173855.GB26035@lst.de> <20060212180308.GA24896@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212180308.GA24896@wavehammer.waldi.eu.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 07:03:08PM +0100, Bastian Blank wrote:
> On Sun, Feb 12, 2006 at 06:38:55PM +0100, Christoph Hellwig wrote:
> >  static int
> > -dasd_ioctl_api_version(struct block_device *bdev, int no, long args)
> > +dasd_ioctl_api_version(void __user *argp)
> >  {
> >  	int ver = DASD_API_VERSION;
> > -	return put_user(ver, (int __user *) args);
> > +	return put_user(ver, (int *)argp);
> >  }
> 
> Doesn't this need to be "int __user *"?

Yes.

> > +long
> > +dasd_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  {
> > -	int i;
> > +	int rval;
> >  
> > -	for (i = 0; dasd_ioctls[i].no != -1; i++)
> > -		dasd_ioctl_no_unregister(NULL, dasd_ioctls[i].no,
> > -					 dasd_ioctls[i].fn);
> > +	lock_kernel();
> > +	rval = dasd_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
> > +	unlock_kernel();
> 
> The lock_kernel looks spurious.

dasd_compat_ioctl just moved down unchanged to the end of the file so it
can call dasd_ioctl without a forward-prototype.  When I introduced this
function a while ago I added the lock_kernel because that the BKL is
held when dasd_ioctl is called directly and I wanted to avoid different
locks from different codepathes.  Once we can switch dasd to
->unlocked_ioctl it could probably go away.
