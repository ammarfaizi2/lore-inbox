Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262123AbREPXHM>; Wed, 16 May 2001 19:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262124AbREPXHC>; Wed, 16 May 2001 19:07:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22996 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262123AbREPXGt>;
	Wed, 16 May 2001 19:06:49 -0400
Date: Wed, 16 May 2001 19:06:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <9duuh1$mes$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105161850200.26191-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 May 2001, H. Peter Anvin wrote:

> Followup to:  <Pine.GSO.4.21.0105161434420.26191-100000@weyl.math.psu.edu>
> By author:    Alexander Viro <viro@math.psu.edu>
> In newsgroup: linux.dev.kernel
> > 
> > Well, since all I actually use in the full variant of patch is sys_mknod(),
> > sys_chdir() and sys_mkdir()... IMO tmpfs is an overkill here. Maybe we
> > really need minimal rootfs in the kernel (no regular files) and let
> > ramfs, tmpfs, whatever-device-fs use it as a library.
> > 
> 
> One thing that I thought was really spiffy was someone who had done
> patches to populate a ramfs from a tarball loaded via the initrd
> bootloader protocol... call it "initial ramfs."  It allowed a whole
> lot of cleanup -- the "initrd" isn't magic anymore (instead use
> pivot_root), and it gets rid of the rd stuff.  At the same time it
> does allow the full flexibility of a fullblown filesystem that can be
> populated with arbitrary contents.

In full variant of patch I don't _have_ mount_root(9). It's done by
mount(2). Period. Initrd or not. Notice that rootfs stays absolute root
forever - it's much more convenient for fs/super.c, since you can get rid
of many kludges that way. So I'm not too happy about populating rootfs with
tons of files. BTW, loading initrd is done by open(2), read(2) and write(2) -
none of this fake struct file business anymore.

So late-boot stuff (mounting root, unpacking initrd, mounting devfs if
asked to, loading initrd from floppies,  moving initrd around - the whole
whorehouse) is actually done by sane, normal system calls. And it's
very easy to expand - I refused to apply any fancy patches simply because
I wanted 100% compatibility with all existing boot setups, no matter
how silly they are. If behaviour is absent in Linus' tree - sorry.
However, playing with that stuff becomes much easier - essentially it's
a userland code. You have an empty, writable fs, your root and cwd are
on it, you can do any system calls you want.

So if you want this untar-into-ramfs - well, more power to you. I'd
recommend to use a separate instance of ramfs for that, though, so that
you could easily get rid of it afterwards. Again, at that point you
have normal userland environment, so doing whatever you want to do
doesn't require any kernel-specific stuff. Write as if you were adding
your code to the beginning of /sbin/init.

