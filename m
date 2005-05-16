Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVEPVpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVEPVpm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVEPVoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:44:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:22692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261908AbVEPVkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:40:03 -0400
Date: Mon, 16 May 2005 13:58:25 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Message-ID: <20050516205825.GB11938@kroah.com>
References: <200505132117.37461.arnd@arndb.de> <200505132129.07603.arnd@arndb.de> <20050514074524.GC20021@kroah.com> <200505141505.08999.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505141505.08999.arnd@arndb.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 03:05:06PM +0200, Arnd Bergmann wrote:
> On S?nnavend 14 Mai 2005 09:45, Greg KH wrote:
> > On Fri, May 13, 2005 at 09:29:06PM +0200, Arnd Bergmann wrote:
> > > /run	A stub file that lets us do ioctl.
> > 
> > No, as Ben said, do not do this.  Use write.  And as you are only doing
> > 1 type of ioctl, it shouldn't be an issue.  Also it will be faster than
> > the ioctl due to lack of BKL usage :)
> 
> I've been back and forth between a number of interfaces here and haven't
> found one that I'm really happy with. Using write() is probably my least
> favorite one, but these are the alternatives I've come up with so far:
> 
> 1. ioctl:
>  pro:
>      - easy to do in a file system
>      - can have both input and output arguments
>  contra:
>      - ugly
>      - weakly typed
>      - unpopular
> 
> 2. sys_spufs_run(int fd, __u32 pc, __u32 *new_pc, __u32 *status):
>  pro:
>      - strong types
>      - can have both input and output arguments
>  contra:
>      - does not fit file system semantics well
>      - bad for prototyping

I suggest you do this.  Based on what you say you want the code to do, I
agree, write() doesn't really work out well (but it might, and if you
want an example of how to do it, look at the ibmasm driver, it
implements write() in a way much like what you are wanting to do.)

> > > +/**** spufs attributes
> > > + *
> 
> > > + * Perhaps these file operations could be put in debugfs or libfs instead,
> > > + * they are not really SPU specific.
> > 
> > Yes they should.  I'll gladly take them for debugfs or like you state,
> > libfs is probably the better place for them so everyone can use them.
> > 
> > If you make up a patch, I'll fix up debugfs to use them properly.
> 
> Ok. I'll do the patch for libfs then. I've been thinking about
> changing
> 
> +#define spufs_attribute(name)						   \
> +static int name ## _open(struct inode *inode, struct file *file)	   \
> +{									   \
> +	return spufs_attr_open(inode, file, &name ## _get, &name ## _set); \
> +}									   \
> +static struct file_operations name = {					   \
> +	.open	 = name ## _open,					   \
> +	.release = spufs_attr_close,					   \
> +	.read	 = spufs_attr_read,					   \
> +	.write	 = spufs_attr_write,					   \
> +};
> 
> to take a format string argument as well, which is then used in the
> spufs_attr_read function instead of the hardcoded "%ld\n". Do you think
> I should do that or rather keep the current implementation?

yeah, you probably need the format string.

> > > +#define spufs_attribute(name)						   \
> > > +static int name ## _open(struct inode *inode, struct file *file)	   \
> > > +{									   \
> > > +	return spufs_attr_open(inode, file, &name ## _get, &name ## _set); \
> > > +}									   \
> > > +static struct file_operations name = {					   \
> > > +	.open	 = name ## _open,					   \
> > > +	.release = spufs_attr_close,					   \
> > > +	.read	 = spufs_attr_read,					   \
> > > +	.write	 = spufs_attr_write,					   \
> > > +};
> > 
> > No module owner set?  Be careful if not...
> 
> Right. Is there ever a reason to have file operations without owner?

Code built into the kernel?

> Maybe dentry_open() could warn about this.

Would die a horrible death due to the above :)

> > > +/* This looks really wrong! */
> > > +static int spufs_rmdir(struct inode *root, struct dentry *dir_dentry)
> > 
> > Why do you need this?  Doesn't 'simple_rmdir' work for you?
> 
> The idea was to keep the file system contents consistant with the
> underlying data structures. If I allow users to unlink context
> directories or files in there, there is no longer a way to extract
> reliable information from the file system, e.g. for the debugger
> or for implementing something like spu_ps.
> 
> My solution was to force the dentries in each directory to be
> present. When the directory is created, the files are already
> there and unlinking a single file is impossible. To destroy the
> spu context, the user has to rmdir it, which will either remove
> all files in there as well or fail in the case that any file is
> still open.

Ick.

> Of course that is not really Posix behavior, but it avoids some
> other pitfalls.

Go with a syscall :)

> > Remember __u16 and friends for structures that cross the user/kernel
> > boundry (like your ioctl that you will be rewriting...)
> 
> Yes. There are no data structures that are shared with user space
> except the current ioctl argument. The MFC_TagSizeClassCmd (yes, I
> need to remember to change the name some day, currently this still
> uses the identifiers from the spec) and the others are defined
> by the hardware interface.

Identifiers that are named as per a spec are ok to leave alone.  We did
that with USB, as it makes sense to do it that way for anyone who reads
the spec and the code.

But if your spec is only for the Linux OS, well, that's a different
issue...

thanks,

greg k-h
