Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUGBWsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUGBWsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUGBWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:48:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:12716 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265027AbUGBWsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:48:46 -0400
Date: Fri, 2 Jul 2004 15:47:20 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040702224720.GA7969@kroah.com>
References: <m2lli36ec9.fsf@telia.com> <m2u0wqqdpl.fsf@telia.com> <20040702150819.646b6103.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702150819.646b6103.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 03:08:19PM -0700, Andrew Morton wrote:
> Peter Osterlund <petero2@telia.com> wrote:
> >
> > This code leaks a module reference. The patch below fixes it. I'm not
> > sure it's correct, but do_open() also does module_put() after
> > put_disk().
> > 
> > Signed-off-by: Peter Osterlund <petero2@telia.com>
> > 
> > ---
> > 
> >  linux-petero/fs/partitions/check.c |    1 +
> >  1 files changed, 1 insertion(+)
> > 
> > diff -puN fs/partitions/check.c~packet-refcnt fs/partitions/check.c
> > --- linux/fs/partitions/check.c~packet-refcnt	2004-07-02 23:18:22.000000000 +0200
> > +++ linux-petero/fs/partitions/check.c	2004-07-02 23:18:23.000000000 +0200
> > @@ -151,6 +151,7 @@ const char *__bdevname(dev_t dev, char *
> >  	if (disk) {
> >  		buffer = disk_name(disk, part, buffer);
> >  		put_disk(disk);
> > +		module_put(disk->fops->owner);
> >  	} else {
> >  		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
> >  				MAJOR(dev), MINOR(dev));
> 
> Yes, there's certainly a leak there.  It's surprising that it hasn't been
> noted before.
> 
> But:
> 
> const char *__bdevname(dev_t dev, char *buffer)
> {
> 	struct gendisk *disk;
> 	int part;
> 
> 	disk = get_gendisk(dev, &part);
> 	if (disk) {
> 		buffer = disk_name(disk, part, buffer);
> 		put_disk(disk);
> 	} else {
> 		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
> 				MAJOR(dev), MINOR(dev));
> 	}
> 
> get_gendisk() did an internal module_get() in kobj_lookup().

But if kobj_lookup() succeeds, module_put() is called before returning
(actually it's always called, right?) 

> It would seem to be logical that the module_put() should be in
> kobject_put(), called from put_disk().  But surely if we made that
> change 1000 things would explode.

I don't see how that would fix anything, as the module reference is not
held after kobj_lookup() returns.  Or am I missing something here?

thanks,

greg k-h
