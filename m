Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSKGGj3>; Thu, 7 Nov 2002 01:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266385AbSKGGj3>; Thu, 7 Nov 2002 01:39:29 -0500
Received: from thunk.org ([140.239.227.29]:19107 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266384AbSKGGj2>;
	Thu, 7 Nov 2002 01:39:28 -0500
Date: Thu, 7 Nov 2002 01:46:05 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT2 corruption -- After running 2.5.46, my root partition cannot be mounted by older kernels
Message-ID: <20021107064605.GA12519@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Miles Lane <miles.lane@attbi.com>, linux-kernel@vger.kernel.org
References: <3DC9D145.6040109@attbi.com> <20021107041325.GB11010@think.thunk.org> <3DCA086E.8000802@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCA086E.8000802@attbi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 10:30:06PM -0800, Miles Lane wrote:
> I do also have initrd support compiled into the kernel:
> 
> # Block devices
> #
> ...
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> 
> I added this because I have been basing my latest kernel configs
> off if the default Redhat 8.0 configuration.  Hmm.  

... and you no doubt are compiling ext3 as a module.  Don't do that,
or make sure your initrd image includes the ext3.o module.

> I have, indeed, compiled my 2.5.46 kernel with ACL support.
> Mea culpa for not studying the effect on the filesystem 
> before testing this new code.  I usually try to do compile 
> testing on a lot of options, whether or not I exercize the 
> code.  I didn't realise that ACL support would modify the 
> filesystem whether or not I applied ACLs to a particular file.
> Or is that what has happened?

No, it has nothing to do with ACL support.

Look at your dumpe2fs output:

> >>dumpe2fs -h /dev/hda12
> dumpe2fs 1.27 (8-Mar-2002)
> Filesystem volume name:   /
> Last mounted on:          <not available>
> Filesystem UUID:          0a3ccf38-e09c-4ce8-af56-4c086b7adce4
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal filetype needs_recovery sparse_super
                                                 ^^^^^^^^^^^^^^

There are no ACL or extended attribute features listed in the
dumpe2fs's output.  The only feature which would give ext2 filesystems
heartburn is the needs_recovery feature.  This means either (a) the
filesystem was mounted (using the ext3 filesystem) when you ran
dumpe2fs, or (b) the filesystem was mounted using ext3, but the system
wasn't cleanly shutdown.

This needs_recovery feature is set when the filesystem is mounted as
ext3, and indicates that there may be commited metadata blocks in the
journal which must be copied to their final place on disk before the
filesystem canbe considered consistent.  This feature will stop ext2
filesystems from mounting the filesystem (since the ext2 filesystem
code will check the feature flags, and will stop because it doesn't
understand the needs_revoery flag).

> >(1) tends to be the most likely cause, given the confused users who
> >ask these sorts of questions on th ext3-users mailing list.  As a
> >result, I've developed a very strong distaste for initrd, and
> >generally strongly encourage people to compile ext3 and whatever
> >device drivers you require into the kernel, and to not try to use
> >initrd.  initrd turns out to be a confusing stumbling block for far
> >too many users.

And yup, once again, the confusing initrd feature strikes **again**.

The problem is that your initrd image doesn't include the ext3 module,
and so when you boot your system, the initrd scripts try to mount your
filesystem as ext2, but because it wasn't cleanly shutdown, there the
ext2 filesystem code complains because the needs_recovery feature flag
is set.

Just recompile your 2.4 kernel with ext3 and all device drivers needed
to mount your root filesystem compiled into the kernel, and abandon
using initrd altogether, and you will be a much happier camper.

						- Ted
