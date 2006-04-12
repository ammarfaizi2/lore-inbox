Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWDLJbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWDLJbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 05:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWDLJbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 05:31:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30483 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751112AbWDLJba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 05:31:30 -0400
Date: Wed, 12 Apr 2006 10:30:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mikkel Erup <mikkelerup@yahoo.com>, Al Viro <viro@ftp.linux.org.uk>,
       Jens Axboe <axboe@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: sdhci driver produces kernel oops on ejecting the card
Message-ID: <20060412093020.GB25799@flint.arm.linux.org.uk>
Mail-Followup-To: Mikkel Erup <mikkelerup@yahoo.com>,
	Al Viro <viro@ftp.linux.org.uk>, Jens Axboe <axboe@suse.de>,
	Pierre Ossman <drzeus-list@drzeus.cx>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060411194356.4573.qmail@web52107.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411194356.4573.qmail@web52107.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 12:43:56PM -0700, Mikkel Erup wrote:
> > --- Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > 
> > > So the
> > > only place for sane
> > > refcounting seems to be genhd.c, as per the patch
> > > below.
> > > 
> > > Comments?
> > > 
> > > diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk
> > -x
> > > *.orig -x *.rej -x .git a/block/genhd.c
> > > b/block/genhd.c
> > > --- a/block/genhd.c	Sat Feb 18 10:31:37 2006
> > > +++ b/block/genhd.c	Fri Apr  7 15:22:21 2006
> > > @@ -262,6 +262,7 @@ static int exact_lock(dev_t
> > dev,
> > > void *d
> > >   */
> > >  void add_disk(struct gendisk *disk)
> > >  {
> > > +	get_device(disk->driverfs_dev);
> > >  	disk->flags |= GENHD_FL_UP;
> > >  	blk_register_region(MKDEV(disk->major,
> > > disk->first_minor),
> > >  			    disk->minors, NULL, exact_match,
> > exact_lock,
> > > disk);
> > > @@ -507,6 +508,7 @@ static struct attribute *
> > > default_attrs[
> > >  static void disk_release(struct kobject * kobj)
> > >  {
> > >  	struct gendisk *disk = to_disk(kobj);
> > > +	put_device(disk->driverfs_dev);
> > >  	kfree(disk->random);
> > >  	kfree(disk->part);
> > >  	free_disk_stats(disk);
> > 
> > I can confirm that this patch is working.
> > The 2.6.16-git20 kernel doesn't oops on
> > ejecting the card after the patch is applied.
> > 
> > Mikkel
> 
> I didn't see anything regarding this on sdchi-devel or lkml for a
> week or so, so I thought I'd just make sure it's not forgotten.
> This patch works really well for me. The kernel no longer oopses
> on ejecting the card because a NULL pointer is no longer
> dereferenced and I think the patch should be considered.

I think it needs someone like Al Viro or Jens Axboe to review it.
I sent the patch to them originally, but when you replied, your mailer
removed them from your reply.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
