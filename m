Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbSLTI0q>; Fri, 20 Dec 2002 03:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267751AbSLTI0q>; Fri, 20 Dec 2002 03:26:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3846 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267750AbSLTI0o>;
	Fri, 20 Dec 2002 03:26:44 -0500
Date: Fri, 20 Dec 2002 00:31:50 -0800
From: Greg KH <greg@kroah.com>
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] add kobject to struct mapped_device
Message-ID: <20021220083149.GA10484@kroah.com>
References: <20021218184307.GA32190@kroah.com> <20021219105530.GA2003@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219105530.GA2003@reti>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 10:55:30AM +0000, Joe Thornber wrote:
> Greg,
> 
> This looks like patch 1 of many, since it doesn't actually export any
> attributes through sysfs yet.

Correct.

> Can you please give me more of an idea
> of what the attributes are that you want to export ?  Are you trying
> to move the dmfs functionality into sysfs ?

Only the parts of dmfs that make sense to :)

Right now every struct gendisk shows up in sysfs under the block/
directory, including every struct mapped_device that is created through
the dm code.  Now every mapped_device that already exists in sysfs,
exports the major/minor number (in the dev file), and other gendisk
specific attributes.  Why not just add the mapped_device specific
attributes of this gendisk object into the same directory (or one lower
to try to partition things a bit.)  That would mean taking the files
that were going to be in dmfs, and placing them into this directory
(like status, suspend, and others).  Some of them might have to be split
up into multiple files to keep the "one value per file" rule, but that
shouldn't be very difficult.

Here's an ascii picture which probably makes more sense:
/sys/block/
|-- fd0
|   |-- dev
|   |-- range
|   |-- size
|   `-- stat
|-- dm-1
|   |-- dev
|   |-- dm
|   |   |-- device0 -> ../../devices/pci0/00:02.5/ide0/0.0
|   |   |-- device1 -> ../../devices/pci0/00:02.5/ide1/1.0
|   |   |-- status
|   |   |-- suspend
|   |   `-- table
|   |-- range
|   |-- size
|   `-- stat

Look reasonable?

And yes, the deviceX files are symlinks to the struct block_device that
are controlled by this mapped_device, which I think is a easy visual
clue as to what is going on.

I know, this doesn't address the issue of creating these mapped_device
structures in the first place with either an ioctl, or a "special file",
but let's try to export the values and relationships that we already
have.  One step at a time...

> I won't accept this patch on it's own, but am sure what you are trying
> to do is the right thing, so will probably have no objections when the
> rest of the patches arrive.

That's fair enough, I'll work on getting the rest of the patches out in
a fairly timely manner, considering the holiday season...

> On Wed, Dec 18, 2002 at 10:43:07AM -0800, Greg KH wrote:
> > Oh, and why isn't struct mapped_device declared in dm.h?  If it was,
> > dm_get and dm_put could be inlined, along with a few other potential
> > cleanups.
> 
> I'm try to keep implementation details out of header files.  dm_get()
> and dm_put() are not performance critical so I see no need to inline them.

Ok.  I can place all of the sysfs specific functions in dm.c, just like
drivers/block/genhd.c has, or if we place struct mapped_device into
dm.h, they can live in their own file.  Doesn't bother me either way.

thanks,

greg k-h
