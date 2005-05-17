Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVEQTq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVEQTq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEQTq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:46:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26019 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261347AbVEQTqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:46:23 -0400
Date: Tue, 17 May 2005 14:46:17 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: Re: [patch 2/7] BSD Secure Levels: move bd claim from inode to filp
Message-ID: <20050517194616.GA14957@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us> <20050517152545.GA2944@halcrow.us> <20050517160900.GB32436@infradead.org> <20050517164922.GA29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517164922.GA29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al -

Thank you for your feedback.  I believe that most of your concerns are
addressed with this set of patches.

On Tue, May 17, 2005 at 05:49:22PM +0100, Al Viro wrote:
> On Tue, May 17, 2005 at 05:09:00PM +0100, Christoph Hellwig wrote:
> > On Tue, May 17, 2005 at 10:25:46AM -0500, Michael Halcrow wrote:
> > > +/**
> > > + * Claim the blockdev to exclude mounters; release on file close.
> > > + */
> > > +static int seclvl_bd_claim(struct file *filp)
> > >  {
> > > -	int holder;
> > >  	struct block_device *bdev = NULL;
> > > -	dev_t dev = inode->i_rdev;
> > > +	dev_t dev = filp->f_dentry->d_inode->i_rdev;
> > >  	bdev = open_by_devnum(dev, FMODE_WRITE);
> > >  	if (bdev) {
> > > -		if (bd_claim(bdev, &holder)) {
> > > +		if (bd_claim(bdev, filp)) {
> > >  			blkdev_put(bdev);
> > >  			return -EPERM;
> > >  		}
> > > -		/* claimed, mark it to release on close */
> > > -		inode->i_security = current;
> > > +		/* Claimed; mark it to release on close */
> > > +		filp->f_security = filp;
> > >  	}
> > >  	return 0;
> >
> > While we're at it this code is crap before and after your patch.
> > There's absolutely no point at all to use open_by_devnum if you
> > already have an inode or file that you can get the struct
> > block_device from easily.
>
> It's worse than you think.  No, they do *not* necessary have
> block_device there.  Guess what happens if some clown calls
> e.g. utime("/dev/sda", NULL)?  That's right, we go checking if we
> have write permissions on the file in question.

In my tests, utime() does not cause file_permission() to be called.

> Use of current in setting/checking ->i_security is a bad joke.

The patch fixes this:

-		/* claimed, mark it to release on close */
-		inode->i_security = current;
+		/* Claimed; mark it to release on close */
+		filp->f_security = filp
...

> d) cargo-cult programming: ->f_dentry and ->f_dentry->d_inode are
> *not* NULL, TYVM.

Exactly what code are you refering to here?

> While we are at it...  Guys, you do realize that registering an
> object and then deciding to bail out of module_init requires
> unregistering it?

Thanks; this is fixed in the next round of patches.

Mike
