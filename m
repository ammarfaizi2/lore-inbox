Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSFMDcS>; Wed, 12 Jun 2002 23:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSFMDcR>; Wed, 12 Jun 2002 23:32:17 -0400
Received: from adsl-63-205-245-1.dsl.snfc21.pacbell.net ([63.205.245.1]:4566
	"EHLO amboise.dolphin") by vger.kernel.org with ESMTP
	id <S317433AbSFMDcO>; Wed, 12 Jun 2002 23:32:14 -0400
Date: Wed, 12 Jun 2002 20:31:56 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: Stevie O <stevie@qrpff.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <5.1.0.14.2.20020612211501.02246eb0@whisper.qrpff.net>
Message-ID: <Pine.LNX.4.43.0206122004420.18826-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Stevie O wrote:
[...]
> With it came a brand new type of symlink.  Instead of relying on some
> special bitflag in the inode (as it appears on disk, anyway) to mark
> these symlinks as such, they are instead regular files that are marked
> as symlinks by the last four characters in the filename being ".lnk".
>
> This new method of storing symlinks is extremely useful -- it allows
> one to create symlinks on a number of filesystems that you couldn't
> before, because those filesystems have nowhere to store a 'S_IFLNK'
> flag.
[...]
> Now comes my argument for putting it into the VFS.

Yes, this would be much more useful. Mainly because it would make it
usable on more filesystems: VFAT, NTFS, ISO9660, etc.

However, since files with the .lnk extension are already widely
used and have strictly nothing to do with the notion of symbolic
links, I would propose the following modifications:
 * first use another distinguishing feature to recognize these files.
The goal is to minimize the risk of interference with normal legitimate
files.
 * use of weird characters comes to mind but compatibility with a wide
range of filesystems restricts choices
 * using .desktop as the extension is of course definitely eliminated
 * since this has strictly nothing to do with .lnk files the format of
these files can be very simple: just the destination file name


> Some of us don't want this .lnk garbage! Some of us hate it! Don't
> muck with MY filesystem! For this, we'd want a mount option to disable
> this.  The VFS already has support for certain global mount options --
> the two that come to mind are 'ro' and 'rw'.
>
> root@whisper:~# mount /dev/hda3 -t vfat -o lnk

I propose 'slnk' as the name of the option as an abreviation of
'symbolic link'. This way later one can add an 'hlnk' option for hard
links though I very much doubt this would be feasible.
(and no, 'slnk' has nothing to do with '.lnk' files ;-)


> And if you hate it all, well, just #define CONFIG_WYNLINKS N.

Agreed. Most users will be quite happy with regular symbolic links
so making this a compile option is a good thing.


Now, why not generalize a bit and redo UMSDOS stackable filesystem that
would work on top of any other filesystem?
('stackable filesystem', does that exist on Linux?)

What I mean by that is when you try to create a symbolic link (for
instance), the request would be handled by this 'virtual' filesystem. It
would do tricks ala UMSDOS, and pass the appropriate requests down to
the underlying filesystem driver, be that VFAT, NTFS or ISO9660.

There might be issues like how to identify a given file correctly in a
way which is independent from the underlying filesystem (e.g. I believe
there's no inode on NTFS), and I am not sure what a mount entry would
look like (maybe vufs defaults,dev=/dev/hda1,fs=vfat,nouser), But if
these issues could be resolved, it would give you a filesystem with the
full Unix semantics.

--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
                      Computers are like airconditioners
                They stop working properly if you open WINDOWS

