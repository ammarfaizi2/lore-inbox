Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWDKToA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWDKToA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWDKTn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:43:59 -0400
Received: from web52107.mail.yahoo.com ([206.190.48.110]:21093 "HELO
	web52107.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750852AbWDKTn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:43:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CW/BwldntEJ6k3/UKsAzp4j9FK66aEr6eIhdsSdDMU6Lkfm8KtdjOim+YCjbMbu4k132DUR8m6IU79aSD5zvIfM5/hVCZfXTsGRMAGx7ImuECoxyRYt7NhpRivIysjJCflbLR5nV7oLuMDGUcgxpDII+OI66+ICZR7Ydda7mmW4=  ;
Message-ID: <20060411194356.4573.qmail@web52107.mail.yahoo.com>
Date: Tue, 11 Apr 2006 12:43:56 -0700 (PDT)
From: Mikkel Erup <mikkelerup@yahoo.com>
Subject: Re: sdhci driver produces kernel oops on ejecting the card
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > So the
> > only place for sane
> > refcounting seems to be genhd.c, as per the patch
> > below.
> > 
> > Comments?
> > 
> > diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk
> -x
> > *.orig -x *.rej -x .git a/block/genhd.c
> > b/block/genhd.c
> > --- a/block/genhd.c	Sat Feb 18 10:31:37 2006
> > +++ b/block/genhd.c	Fri Apr  7 15:22:21 2006
> > @@ -262,6 +262,7 @@ static int exact_lock(dev_t
> dev,
> > void *d
> >   */
> >  void add_disk(struct gendisk *disk)
> >  {
> > +	get_device(disk->driverfs_dev);
> >  	disk->flags |= GENHD_FL_UP;
> >  	blk_register_region(MKDEV(disk->major,
> > disk->first_minor),
> >  			    disk->minors, NULL, exact_match,
> exact_lock,
> > disk);
> > @@ -507,6 +508,7 @@ static struct attribute *
> > default_attrs[
> >  static void disk_release(struct kobject * kobj)
> >  {
> >  	struct gendisk *disk = to_disk(kobj);
> > +	put_device(disk->driverfs_dev);
> >  	kfree(disk->random);
> >  	kfree(disk->part);
> >  	free_disk_stats(disk);
> 
> I can confirm that this patch is working.
> The 2.6.16-git20 kernel doesn't oops on
> ejecting the card after the patch is applied.
> 
> Mikkel

I didn't see anything regarding this on sdchi-devel or lkml for a
week or so, so I thought I'd just make sure it's not forgotten.
This patch works really well for me. The kernel no longer oopses
on ejecting the card because a NULL pointer is no longer
dereferenced and I think the patch should be considered.

Mikkel

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
