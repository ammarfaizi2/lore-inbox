Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317951AbSGWFBk>; Tue, 23 Jul 2002 01:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317953AbSGWFBk>; Tue, 23 Jul 2002 01:01:40 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46469 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317951AbSGWFBj>; Tue, 23 Jul 2002 01:01:39 -0400
Date: Mon, 22 Jul 2002 23:04:45 -0600
Message-Id: <200207230504.g6N54jW24260@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 devfs
In-Reply-To: <3D3C48D5.6080500@evision.ag>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
	<3D3BE1DD.3040803@evision.ag>
	<200207221728.g6MHSkY15219@vindaloo.ras.ucalgary.ca>
	<3D3C48D5.6080500@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki writes:
> Richard Gooch wrote:
> > Marcin Dalecki writes:
> > 
> >>Kill two inlines which are notwhere used and which don't make sense
> >>in the case someone is not compiling devfs at all.
> > 
> > 
> > Rejected. Linus, please don't apply this bogus patch. External patches
> > and drivers rely on the inline stubs so that #ifdef CONFIG_DEVFS_FS
> > isn't needed.
> 
> Dare to actually *name* one of them?

Apart from my own sdmany patch, other people have contacted me about
this feature and said they were making use of it. I don't bother
tracking everyone who uses my code. I've got better things to do.

In any case, I don't *need* to justify it to you, particularly not
when the compiler completely optimises the inline stubs away. There is
*zero* benefit to removing them, and doing so only breaks external
code.

> You didn't think doing devfs_fs_kernel.h. One simple sample from there:
> 
> devfs_get_maj_min(devfs_get_handle_from_inode((inode))

You've managed to pick a function that I'm not thrilled about
either. But it has been necessary.

> Everybody would expect the following to be only a single function:
> 
> extern devfs_handle_t devfs_get_handle (devfs_handle_t dir, const char
> extern devfs_handle_t devfs_find_handle (devfs_handle_t dir, const char

devfs_get_handle() is the preferred interface. For compatibility
reasons, devfs_find_handle() remains. However, if you look at the
implementation for devfs_find_handle(), you'll notice that it's marked
for removal. But I believe in stable interfaces, so I want to give
people time to transition.

> And it was of course too hard to unify ops and handle:
> 
> extern void *devfs_get_ops (devfs_handle_t de);
> extern void devfs_put_ops (devfs_handle_t de);

Huh? They are different animals.

> You couldn't resist adding the redundant devfs_ prefix overall in the 
> kernel:
> 
> extern devfs_register_chrdev (unsigned int major, const char *name,
>                                    struct file_operations *fops);
> extern int devfs_register_blkdev (unsigned int major, const char *name,
>                                    struct block_device_operations *bdops);
> extern int devfs_unregister_chrdev (unsigned int major, const char *name);
> extern int devfs_unregister_blkdev (unsigned int major, const char *name);

These do subtly different things than the non "devfs_" versions.

> Three different allocators and deallocators for one single subsystem,
> preserving the illusion that there is in linux a real difference between 
> major and minor numbers...
> 
> extern int devfs_alloc_major (char type);
> extern void devfs_dealloc_major (char type, int major);
> extern kdev_t devfs_alloc_devnum (char type);
> extern void devfs_dealloc_devnum (char type, kdev_t devnum);

Well, there *is* a difference between major and minor numbers. The two
different interfaces service different driver requirements.
Fortunately, one interface is built on top of the other.

> extern int devfs_alloc_unique_number (struct unique_numspace *space);
> extern void devfs_dealloc_unique_number (struct unique_numspace *space,
>                                           int number);

These are completely unrelated to device numbers, so there's no point
even comparing them.

> If flags are invalid -> add an invalid flag! instead of value return 
> through pointer.
> 
> static inline int devfs_get_flags (devfs_handle_t de, unsigned int *flags)
> {
>      return 0;
> }

That's a spurious objection. The return value indicates whether the
entry was valid or not. That is quite separate from flag values.
Mixing data types by overloading the return value is not a sensible
approach.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
