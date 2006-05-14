Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWENQCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWENQCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWENQCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:02:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751480AbWENQCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:02:01 -0400
Date: Sun, 14 May 2006 17:01:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Todd Blumer <todd@sdgsystems.com>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060514160144.GA28324@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
	axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Todd Blumer <todd@sdgsystems.com>
References: <1147460325.3769.46.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org> <20060512205804.GD17120@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605121409250.3866@g5.osdl.org> <20060512215151.GG17120@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605121508590.3866@g5.osdl.org> <Pine.LNX.4.64.0605121532360.3866@g5.osdl.org> <20060512235745.GA31148@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512235745.GA31148@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 04:57:45PM -0700, Greg KH wrote:
> On Fri, May 12, 2006 at 03:37:59PM -0700, Linus Torvalds wrote:
> > On Fri, 12 May 2006, Linus Torvalds wrote:
> > > On Fri, 12 May 2006, Russell King wrote:
> > > > 
> > > > From: Todd Blumer <todd@sdgsystems.com>
> > > > On a PXA27x handheld (iPAQ hx4700), when we eject a mounted SD memory
> > > > card, we get a kernel panic (kernel trying to clean up non-existent
> > > > device). One hack patch to avoid the panic is:
> > > > 
> > > > --- fs/partitions/check.c       10 Apr 2006 22:57:27 -0000      1.15
> > > > +++ fs/partitions/check.c       4 May 2006 20:30:15 -0000
> > > > @@ -491,6 +491,7 @@
> > > >                         kfree(disk_name);
> > > >                 }
> > > >                 put_device(disk->driverfs_dev);
> > > > +               disk->driverfs_dev = 0; /* HACK - what's the right solution? */
> > > >         }
> > > >         kobject_uevent(&disk->kobj, KOBJ_REMOVE);
> > > >         kobject_del(&disk->kobj);
> > > 
> > > Btw, on the face it of, I really think that this patch is correct 
> > > regardless of any other issues.
> > 
> > .. and I suspect it also shows what the "other issues" are.
> > 
> > Shouldn't that KOBJ_REMOVE uevent happen _before_ we do all the freeing of 
> > the backing dev object? That KOBJ_REMOVE thing actually seems to want to 
> > report the pathname for the disk it removes. Preferably before the thing 
> > is gone and can't be reported on..
> > 
> > Ie shouldn't the diff be something like this?
> 
> It looks sane to me.  Russell, does it solve your oops too?

It appears to.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
