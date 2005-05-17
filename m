Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVEQQtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVEQQtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEQQtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:49:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62931 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261795AbVEQQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:49:03 -0400
Date: Tue, 17 May 2005 17:49:22 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>
Subject: Re: [patch 2/7] BSD Secure Levels: move bd claim from inode to filp
Message-ID: <20050517164922.GA29811@parcelfarce.linux.theplanet.co.uk>
References: <20050517152303.GA2814@halcrow.us> <20050517152545.GA2944@halcrow.us> <20050517160900.GB32436@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517160900.GB32436@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 05:09:00PM +0100, Christoph Hellwig wrote:
> On Tue, May 17, 2005 at 10:25:46AM -0500, Michael Halcrow wrote:
> > +/**
> > + * Claim the blockdev to exclude mounters; release on file close.
> > + */
> > +static int seclvl_bd_claim(struct file *filp)
> >  {
> > -	int holder;
> >  	struct block_device *bdev = NULL;
> > -	dev_t dev = inode->i_rdev;
> > +	dev_t dev = filp->f_dentry->d_inode->i_rdev;
> >  	bdev = open_by_devnum(dev, FMODE_WRITE);
> >  	if (bdev) {
> > -		if (bd_claim(bdev, &holder)) {
> > +		if (bd_claim(bdev, filp)) {
> >  			blkdev_put(bdev);
> >  			return -EPERM;
> >  		}
> > -		/* claimed, mark it to release on close */
> > -		inode->i_security = current;
> > +		/* Claimed; mark it to release on close */
> > +		filp->f_security = filp;
> >  	}
> >  	return 0;
> 
> While we're at it this code is crap before and after your patch.  There's absolutely
> no point at all to use open_by_devnum if you already have an inode or file that you
> can get the struct block_device from easily.

It's worse than you think.  No, they do *not* necessary have block_device
there.  Guess what happens if some clown calls e.g. utime("/dev/sda", NULL)?
That's right, we go checking if we have write permissions on the file in
question.  Which happens to be block device node.  Which triggers a call
of that junk.  At which point we
	a) have caused open() on that device node, even though caller did
not ask for that and actually had not planned to do anything with actual
device.
	b) have caused all subsequent permission() for MAY_WRITE fail for
that sucker [*] until somebody opens and closes device in question (for
read, obviously).
	c) seclvl_bd_release() expects, for some reason, to be called when
task that had called seclvl_bd_claim() to be still alive.  Use of current
in setting/checking ->i_security is a bad joke.
	d) cargo-cult programming: ->f_dentry and ->f_dentry->d_inode are
*not* NULL, TYVM.

While we are at it...  Guys, you do realize that registering an object
and then deciding to bail out of module_init requires unregistering it?

[*] that is, unless they happen to get the same address of local variable
when calling this Fine Piece Of Software - nice misuse of bd_claim() that
should've warned that something is not right here.  As it is, just call
utime() several times in row and you've won a cookie - device that had been
opened that many times and will *never* get closed.
