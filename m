Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRKAVP7>; Thu, 1 Nov 2001 16:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279784AbRKAVPt>; Thu, 1 Nov 2001 16:15:49 -0500
Received: from [63.231.122.81] ([63.231.122.81]:39983 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S279783AbRKAVPe>;
	Thu, 1 Nov 2001 16:15:34 -0500
Date: Thu, 1 Nov 2001 14:14:38 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
Message-ID: <20011101141438.F16554@lynx.no>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	reiser@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <200111012017.VAA02942@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111012017.VAA02942@mustard.heime.net>; from roy@karlsbakk.net on Thu, Nov 01, 2001 at 08:17:24PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 01, 2001  20:17 +0000, Roy Sigurd Karlsbakk wrote:
> Andreas Dilger (adilger@turbolabs.com) wrote*: 
> >Yes, there is a patch for ext2 that does this as well.
> 
> I just thought there was a patch doing windows nt-like 
> compress-em-all-realtime-and-get-doomed!

I don't know what the actual heuristics for determining which files are
compression with the ext2 patch.  It is definitely NOT a compressed
block device.  Files are compressed in chunks (32kB?), so that it is
possible to seek and do read-modify-write (e.g. appending to a file)
without decompressing the entire file and/or recompressing it.  This also
protects against block corruption, since you would limit the amount of
data lost to the end of the chunk after the bad spot.

> >> New attributes must be added somehow. 'ls' and 'find' and perhaps other
> >> files must be modified to take advantage of this. The compression job can
> >> be a simple script with something like
> >>
> >>  find . -type f ! --compressed ! --dont-compress / -exec fcomp {} \;
> >>
> >> (and check can't compress and force compression).
> 
> > There already exists a patch for reiserfs which uses the same interface
> > to file attributes that ext2 and ext3 use.
> 
> ok? with batched compression?

No compression is there for either ext2 (without the patch), and not at
all for reiserfs (AFAIK).  All the patch does is give reiserfs the ABILITY
to store per-inode attributes in a way compatible with the existing ext2
attributes.  Since most people already have e2fsprogs installed (fsck,
lsattr, chattr live there) it makes sense to use the same user-space
tools to do the same thing, and even the same ioctl numbers/flag values.

> >Also, ext2 already has a "compressed", "do not compress", and "dirty"
> >attributes.  They are currently not all user modifyable for ext2
> >filesystems via chattr/lsattr, but that doesn't mean they cannot be
> >on reiserfs.
> 
> yes, but it's kinda nice to have some way of checking a file's attributes
> for a  sysadmin...

That's what "lsattr" is for.  All I was getting at (when mentioning "ls"
and "cp") is that where possible the user tools should be compatible,
even if the underlying filesystem is different.  I would rather avoid the
case (currently being worked on) with ext2 and XFS ACL user tools being
different, using different ioctls, but doing 99% of the same function.
It is ugly to think "reiserattr" and "xfsattr" and "chattr/lsattr (ext2)",
and "getacl/setacl", "xfsacl" commands instead of a single set of commands
(and even kernel API) that hide the details from the user.

> Do you think the other flags I mentioned may be useful?

Yes, definitely disabling compression for a file is good.  The "accessed
in last 7 days flag" is questionable.  This could be determined via the
atime on Unix and doesn't need a separate flag.  Also, the difference
between "do not compress" and "can't compress" is very small.  If it is
found that the file is incompressible, you could just as easily set the
"do not compress" flag.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

