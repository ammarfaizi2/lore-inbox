Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316504AbSEOV6C>; Wed, 15 May 2002 17:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316507AbSEOV6B>; Wed, 15 May 2002 17:58:01 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:12794 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316504AbSEOV6A>; Wed, 15 May 2002 17:58:00 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 15 May 2002 15:56:21 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020515215621.GE12975@turbolinux.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020515212733.GA1025@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 15, 2002  23:27 +0200, Andrea Arcangeli wrote:
> Only in 2.4.19pre8aa3: 00_ext3-register-filesystem-lifo-1
> 
> 	Make sure to always try mounting with ext3 before ext2 (otherwise
> 	it's impossible to mount the real rootfs with ext3 if ext3 is a module
> 	loaded by an initrd and ext2 is linked into the kernel).

Hmm, I don't think this is true.  While I'm not an initrd user, people
have been doing this with RH for quite some time.  Note that it is not
necessarily true that they get it _correct_ all the time, but eventually
it works.  Apparently you need to explicitly specify the root filesystem
type for the initrd mount.

Note that I haven't seen the patch in question yet (mirrors don't have
it), but somehow I don't think that changing the order of the
registration is going to help.  If they have both ext2 and ext3 as
modules, and insmod ext3 first and ext2 second, you've just broken
their setup.  Similarly, (depending on how it is done) I imagine this
would break kernels that have both ext3 and ext2 compiled in.

The only reasonable solution is to not guess at the root filesystem type
and mount it with the correct type explicitly.  I think the RH mkinitrd
will check /etc/filesystems for the root fs and use the type there.  If
the user forgets to run mkinitrd after changing their kernel, there is
not much you can do about that.

What _may_ be helpful is if ext2 printed a small warning that it is
mounting a filesystem with a journal as ext2 and no journaling will
be done, if the user really wanted to do that (normally they will not).

This will at least alert some users that their root filesystem is not
being mounted as ext3 and eliminate a number of support requests on
ext2-devel when initrd users are wondering why e2fsck is being run on
their supposedly journaled filesystem.  The fact that "mount" output
shows ext3 as the filesystem type (while 'cat /proc/mounts' shows ext2)
does nothing to help the user figure out what is wrong.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

