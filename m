Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317401AbSFMCL3>; Wed, 12 Jun 2002 22:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSFMCL2>; Wed, 12 Jun 2002 22:11:28 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:32520
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S317401AbSFMCL1>; Wed, 12 Jun 2002 22:11:27 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: fgouget@free.fr
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020612211501.02246eb0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 22:05:06 -0400
To: Francois Gouget <fgouget@free.fr>, lkml <linux-kernel@vger.kernel.org>
From: Stevie O <stevie@qrpff.net>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <Pine.LNX.4.43.0206110712290.7449-100000@amboise.dolphin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My $0.02. Read the quote, as Francois has been so kind as to make most of it for me:

At 07:31 AM 6/11/2002 -0700, Francois wrote: 
{note that I have snipped parts unrelated to my argument}

>This looks like a bad idea. The reason is that the VFAT driver is the
>wrong abstraction layer to support the '.lnk' files:
>
> * Windows supports .lnk files on FAT, VFAT, NTFS, ISO9660, etc. So if
>such support is added in the Linux kernel, it should be added to all of
>the above filesystems. And then, there is no reason not to add it to
>ext2, NFS, etc!
>
>Other issues:
>
> * it has been mentionned that this makes it possible to extract source
>tarballs that contain symlinks on a VFAT filesystem. While this sounds
>cool I am not sure it is so useful.
>   - for VFAT one could use the UMSDOS filesystem to do the same thing,
>     and get many other features at the same time (at least while in
>     Linux)
>   - again, if it is useful on VFAT, then it would be useful for CD+RW
>     filesystems (UDF?) (e.g. for archival), on NTFS (assuming write is
>     well supported one day, etc.
>
>This would also hurt Wine as:
>
> * it would prevent wine from reading the information in the '.lnk'
>file... at least for 'supported' '.lnk' files

man 2 readlink

What's stopping us from adding an expanded version?

> * it was suggested to implement a hack to let Wine access the '.lnk'
>data. Why implement a hack which is going to be Linux specific when
>doing nothing works just fine and on any Unix system? Plus this is going
>to require Linux specific code in Wine if it is to be supported.

(see above)

-----

I am in full agreement with Francois' postulation; the VFAT driver is the wrong place to support these things. For one thing, it would be very nice to support these same symlinks on NTFS; however, unnecessary duplication of code is, if I recall correctly, a Bad Thing(TM).  I believe that the correct place for this support is in the VFS. Now, hear me out -- what I'm advocating will probably sound absolutely nuts to some of you guys ("I am NOT polluting the entire VFS with that $#!+ from Redmond!") -- but I actually have (what I think is) a good reason.

The first thing we need to do is ignore the origins. That means ignoring that the source of this discussion is from Redmond. Nobody here has any *major* gripes with the BSD people (compared a certain other OS), do they?

Let's say, just for theory's sake, that BSD 6 came out yesterday.

With it came a brand new type of symlink.  Instead of relying on some special bitflag in the inode (as it appears on disk, anyway) to mark these symlinks as such, they are instead regular files that are marked as symlinks by the last four characters in the filename being ".lnk". 

This new method of storing symlinks is extremely useful -- it allows one to create symlinks on a number of filesystems that you couldn't before, because those filesystems have nowhere to store a 'S_IFLNK' flag. 

Linux is about versatility; you have hardware, we'll run on it... we support TiVo hard drives! Likewise, if you have software, we'll run it. You can even get another program ("Wine") that will run programs for a particularly popular desktop operating system!  So if this theoretical OS ("BSD 6") supports this extremely flexible type of symlink, why shouldn't we? Hmm?

Now comes my argument for putting it into the VFS.

-- Some other arguments (and my counters)
Some have argued that we should hack around userspace programs for this to happen.  This is fine with me; get back to me when you've patched every single program in existence that accesses files (other than via stdin/stdout).

Some of the same people have argued that adding this sort of thing to *any* layer in Linux would break a popular program called Wine.  Wine will break because it uses the above method (hack userspace to make it work).  Thus, this argument sounds like "well... we did it this way before, so we should continue doing it this way, because if we change it, we'll have to redo what we already have."  If everybody used that line of logic, we'd still be using punch cards, because switching to floppy drives would force us to convert all the punch card data into floppy disks.
There comes a time when we will have to break userspace in order to progress forward; that time is called "the 2.5 series".
---

We (well, some of us) want to be able to support these ".lnk" files in both VFAT and NTFS (and GodKnowsWhatFS in the future). Therefore, it would be good to have the 'lnk' translation at a higher level than the filesystem driver; this could make it possible to automatically support '.lnk' files on other filesystems, without directly injecting the code to support it into those filesystems. The VFS is a layer directly above every filesystem!

Some of us don't want this .lnk garbage! Some of us hate it! Don't muck with MY filesystem! For this, we'd want a mount option to disable this.  The VFS already has support for certain global mount options -- the two that come to mind are 'ro' and 'rw'. 

root@whisper:~# mount /dev/hda3 -t vfat -o lnk

Some of us want to be able to directly access these '.lnk' files. 

man 2 readlink
man 2 lstat

All we need is forms of these that can treat treat these '.lnk' files as true files. Or perhaps a new "openlink" would be more appropriate, allowing direct read/write access.


The VFS is in a perfect position to intercept accesses to files ending in '.lnk' and do symlink-like translation.


And if you hate it all, well, just #define CONFIG_WYNLINKS N.  I don't need framebuffer support in my headless linux server -- you don't see me lobbying against its inclusion in mainline, do you?


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

