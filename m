Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316531AbSEPCSn>; Wed, 15 May 2002 22:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSEPCSm>; Wed, 15 May 2002 22:18:42 -0400
Received: from [195.223.140.120] ([195.223.140.120]:61005 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316531AbSEPCSl>; Wed, 15 May 2002 22:18:41 -0400
Date: Thu, 16 May 2002 04:18:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516021834.GD1025@dualathlon.random>
In-Reply-To: <20020515212733.GA1025@dualathlon.random> <20020515215621.GE12975@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 03:56:21PM -0600, Andreas Dilger wrote:
> On May 15, 2002  23:27 +0200, Andrea Arcangeli wrote:
> > Only in 2.4.19pre8aa3: 00_ext3-register-filesystem-lifo-1
> > 
> > 	Make sure to always try mounting with ext3 before ext2 (otherwise
> > 	it's impossible to mount the real rootfs with ext3 if ext3 is a module
> > 	loaded by an initrd and ext2 is linked into the kernel).
> 
> Hmm, I don't think this is true.  While I'm not an initrd user, people
> have been doing this with RH for quite some time.  Note that it is not
> necessarily true that they get it _correct_ all the time, but eventually
> it works.  Apparently you need to explicitly specify the root filesystem
> type for the initrd mount.
> 
> Note that I haven't seen the patch in question yet (mirrors don't have
> it), but somehow I don't think that changing the order of the
> registration is going to help.  If they have both ext2 and ext3 as

it helps, it cures the autodetection bug for me.

> modules, and insmod ext3 first and ext2 second, you've just broken
> their setup.  Similarly, (depending on how it is done) I imagine this
> would break kernels that have both ext3 and ext2 compiled in.

can you elaborate what actually breaks in trying ext3 before ext2? That
is the right thing to do always, if the fs is ext3 it must be mounted
ext3 not ext2. If ext3 fails because the journal is missing, then ext2
will be used as expected, that's the right ordering.

> The only reasonable solution is to not guess at the root filesystem type
> and mount it with the correct type explicitly.  I think the RH mkinitrd

First I hate to do something that can be very well done at runtime by
the kernel accurately at ~zero cost. But anyways you can't workaround
the problem with rootfstype, if you do you will be forced to use ext3
for the filesystem on the initrd too (for all the wrong reasons, but
that's another problem and one that I'm not interested to fix because I
pretend the autodetection to work always) and that's never the case
normally, it doesn't even make any sense to use journaling on a ramdisk.
initrd will be a minixfs or an ext2, never an ext3.

> will check /etc/filesystems for the root fs and use the type there.  If
> the user forgets to run mkinitrd after changing their kernel, there is
> not much you can do about that.
> 
> What _may_ be helpful is if ext2 printed a small warning that it is

the issue is not to know about the fact the root fs is been mounted by
ext2 despite it's an ext3, the issue is that after your learnt the bad
news, you still cannot mount it as ext3 unless you use workarounds that
somehow make the mount to fail as ext2 first, like a SYSRQ+B. The patch
fixes this completly and permanently, no matter of the ext2/ext3
module/linked 4 possible combinations.

> mounting a filesystem with a journal as ext2 and no journaling will
> be done, if the user really wanted to do that (normally they will not).
> 
> This will at least alert some users that their root filesystem is not
> being mounted as ext3 and eliminate a number of support requests on
> ext2-devel when initrd users are wondering why e2fsck is being run on
> their supposedly journaled filesystem.  The fact that "mount" output
> shows ext3 as the filesystem type (while 'cat /proc/mounts' shows ext2)
> does nothing to help the user figure out what is wrong.

This is true, mount is very misleading in that case so the warning is a
good idea, but this is orthogonal to my fix. And after my fix the
warning will correctly happen only if the user doesn't have ext3 into
his kernel. Now instead the warning would happen even with ext3 loaded
as module into the kernel, and that's the bug.

Andrea
