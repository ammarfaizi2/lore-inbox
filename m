Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281069AbRKPEw0>; Thu, 15 Nov 2001 23:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280909AbRKPEwG>; Thu, 15 Nov 2001 23:52:06 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:47857 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280898AbRKPEwA>;
	Thu, 15 Nov 2001 23:52:00 -0500
Date: Thu, 15 Nov 2001 21:50:42 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
Message-ID: <20011115215042.B5739@lynx.no>
Mail-Followup-To: Ben Collins <bcollins@debian.org>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3BF42A1A.5AE96A78@zip.com.au> <20011115160232.H329@visi.net> <20011115145803.R5739@lynx.no> <20011115170628.J329@visi.net> <20011115162149.U5739@lynx.no> <20011115183858.N329@visi.net> <20011115170742.W5739@lynx.no> <20011115195551.Q329@visi.net> <20011115200916.A5739@lynx.no> <20011115222055.S329@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011115222055.S329@visi.net>; from bcollins@debian.org on Thu, Nov 15, 2001 at 10:20:55PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  22:20 -0500, Ben Collins wrote:
> On Thu, Nov 15, 2001 at 08:09:16PM -0700, Andreas Dilger wrote:
> > That means the source of the other corruption is unknown.
> 
> The "other" corruption only occured while booted with the ext3-enabled
> kernel. They haven't appeared under the non-ext3 kernel at all. Even
> after it got mounted read-only, performing an fsck, and remounting
> read-write, it would reoccur over and over. So this "other" corruption
> doesn't even sound like it can be caused by the scenario you described
> (which sounds like a one shot problem).

I'm not saying it wasn't caused by ext3, I'm just saying that it is
unknown.

The problem I described _would_ happen each time the filesystem was tried
to be mounted as ext3, but it would only happen to the single file given
as the journal inode (i.e. inode #48 in your case).

You say that remounting the root fs read-only, running fsck, and then
remounting read-write would cause the filesystem to be corrupted?  In that
case, the problem _has_ to be in ext2, because the root filesystem was
mounted as ext2, so there is _no_ way that ext3 could corrupt it again
(the two filesystem codes are completely separate).

Note also, that if you have a serious corruption in the filesystem,
and you run e2fsck on it while it is mounted (read only, presumably),
then you need to reboot the system after e2fsck is done.  Otherwise,
the kernel cache may not be consistent with what is on disk, and anything
that gets written to the disk again from the kernel has the possibility
of corrupting the filesystem.

Normally, this doesn't happen, but it is possible.  With the directories
in the page cache (since 2.4.5 or so), the block device and the directory
pages are not coherent.  This makes it much more important to reboot
if e2fsck makes major changes to the filesystem.  Regular files have
been in the page cache for a long time, but e2fsck does not change the
contents of files, so it is not normally an issue.

This _might_ be worked around by e2fsck calling an ioctl to flush
the kernel caches, but that would probably be complex, and given the
complexity of system startup scripts today it is hard to limit the
number of affected directories/processes.  An alternative would be to put
e2fsck into the initrd, so that root can be checked before it is mounted,
but that is also a change to the way systems are started.

There _may_ also be some issues with the block devices in page cache (i.e.
disconnect between inode tables or bitmaps between the block device user
(e2fsck) and what the kernel sees, but that would be an outright bug.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

