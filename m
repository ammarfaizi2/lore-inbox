Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281196AbRKTTUz>; Tue, 20 Nov 2001 14:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281197AbRKTTUp>; Tue, 20 Nov 2001 14:20:45 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:22265 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281196AbRKTTUa>;
	Tue, 20 Nov 2001 14:20:30 -0500
Date: Tue, 20 Nov 2001 12:19:47 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: Tommi Kyntola <kynde@ts.ray.fi>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Message-ID: <20011120121947.V1308@lynx.no>
Mail-Followup-To: Ryan Cumming <bodnar42@phalynx.dhs.org>,
	Tommi Kyntola <kynde@ts.ray.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111200328550.842-100000@behemoth.ts.ray.fi> <E16608e-0001CL-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E16608e-0001CL-00@localhost>; from bodnar42@phalynx.dhs.org on Mon, Nov 19, 2001 at 05:55:51PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19, 2001  17:55 -0800, Ryan Cumming wrote:
> On November 19, 2001 17:37, you wrote:
> > Even so, I'm wondering wether this removal is standardad
> > procedure for hiding it once and for all or not?

Very definitely NOT.  It _may_ work until the filesystem is unmounted,
because the kernel will keep the file "open" so that the inode is not
freed, but the next time you try to mount the filesystem it will
complain about the journal being a bad inode.

> On my system, the journal appears to have a perfectly normal inode number for 
> a root entry (#22), which makes me think that it's just a normal file as far 
> as the core filesystem code is concerned.

Correct.  Normal, except that if you (as root) really work hard to fool with
it, you can potentially cause problems.  Don't do that.  The problems are
99.99% harmless - can't mount as ext3, e2fsck will complain, maybe you can't
boot your system, if it is the root fs.  If you really work at it, maybe
you can corrupt your fs, but that would take serious effort plus a crash.

> Now, I heard (from the same source I vaugely remember reading about hidden 
> journals, so take this with a grain of salt) that tune2fs would try to use 
> reserved inode #8 for the .journal if possible

Correct - IF the filesystem is unmounted when the journal is created.

> So, hopefully the partition of yours was using the reserved inode number.

This can be checked with "tune2fs -l <dev>" to see what it is really using
for the journal inode number.

> Seeing deletion is no longer dangerous, tune2fs may have decidedly not set
> the immutable flag so that you're free to 'hide' it using rm.

Just to repeat, so people don't start doing this - you cannot "hide" your
journal by deleting it.  Bad, bad, bad.  The most recent release of e2fsck
(1.25) will do it properly, by assigning the journal blocks to the reserved
inode #8, and removing the .journal entry from the directory.  This will
hopefully prevent users from trying to do more bad things to their journals.

I'm not 100% sure whether it can do this on the root fs, because the inode
is already in use, and that would seriously confuse things, I think.

> > Since what's there to stop you from 'chattr -i .journal ; rm .journal'.

> I think that's a case of "don't do that, then". I took the immutable flag 
> being set as a pretty clear indiction that if I cleared the flag and started 
> to play with the file, I pretty much deserve whatever I get. ;)

Correct.  We can only do so much to prevent users from shooting themselves
in the foot.  If you work at it, you can do it, at which point you learn.


Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

