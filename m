Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317785AbSGVSFe>; Mon, 22 Jul 2002 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317787AbSGVSFe>; Mon, 22 Jul 2002 14:05:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:7948 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317785AbSGVSFb>;
	Mon, 22 Jul 2002 14:05:31 -0400
Message-ID: <3D3C48D5.6080500@evision.ag>
Date: Mon, 22 Jul 2002 20:03:01 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: martin@dalecki.de, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 devfs
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>	<3D3BE1DD.3040803@evision.ag> <200207221728.g6MHSkY15219@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> Marcin Dalecki writes:
> 
>>Kill two inlines which are notwhere used and which don't make sense
>>in the case someone is not compiling devfs at all.
> 
> 
> Rejected. Linus, please don't apply this bogus patch. External patches
> and drivers rely on the inline stubs so that #ifdef CONFIG_DEVFS_FS
> isn't needed.

Dare to actually *name* one of them?

> Martin, why are you bothering with this kind of false cleanup? These
> inline stubs don't take up any space in the object files, so why
> bother? Also, given that the stubs were carefully added in the first
> place, it suggests that there is a good reason for their presence.

They where not "carefully added".

The interface you are exposing is bogous.
Look in md.c for one example why.

Last time I counted you provide at least three different ways of object 
allocations which play nasty games with major minor numbers in repeating
code in drivers all scattered over the kernel.
cd-roms are treated special md.c is doing. And you are doing the
whole object management in a side step instead of embarcing the
normal structures holding already device information so you get
of course memmory management problems...

> Why didn't you stop and think it through before firing off a patch, or
> at least ask me if you couldn't see why? This "patch first, think/ask
> questions later" approach is disturbing.

You didn't think doing devfs_fs_kernel.h. One simple sample from there:

devfs_get_maj_min(devfs_get_handle_from_inode((inode))

If I look at md.c which is using it... well better don't tell.

And the above of of course inside ({ })...

Everybody would expect the following to be only a single function:

extern devfs_handle_t devfs_get_handle (devfs_handle_t dir, const char
extern devfs_handle_t devfs_find_handle (devfs_handle_t dir, const char

And it was of course too hard to unify ops and handle:

extern void *devfs_get_ops (devfs_handle_t de);
extern void devfs_put_ops (devfs_handle_t de);

You couldn't resist adding the redundant devfs_ prefix overall in the 
kernel:

extern devfs_register_chrdev (unsigned int major, const char *name,
                                   struct file_operations *fops);
extern int devfs_register_blkdev (unsigned int major, const char *name,
                                   struct block_device_operations *bdops);
extern int devfs_unregister_chrdev (unsigned int major, const char *name);
extern int devfs_unregister_blkdev (unsigned int major, const char *name);

Three different allocators and deallocators for one single subsystem,
preserving the illusion that there is in linux a real difference between 
major and minor numbers...

extern int devfs_alloc_major (char type);
extern void devfs_dealloc_major (char type, int major);
extern kdev_t devfs_alloc_devnum (char type);
extern void devfs_dealloc_devnum (char type, kdev_t devnum);
extern int devfs_alloc_unique_number (struct unique_numspace *space);
extern void devfs_dealloc_unique_number (struct unique_numspace *space,
                                          int number);

If flags are invalid -> add an invalid flag! instead of value return 
through pointer.

static inline int devfs_get_flags (devfs_handle_t de, unsigned int *flags)
{
     return 0;
}

And so on and so on.... Viro is simple right.

