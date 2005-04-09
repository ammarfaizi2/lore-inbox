Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVDIPSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVDIPSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 11:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVDIPSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 11:18:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41376 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261348AbVDIPSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 11:18:03 -0400
Date: Sat, 9 Apr 2005 08:15:53 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: cw@f00f.org, matthias.christian@tiscali.de, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409081553.744bbb55.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	<4256AE0D.201@tiscali.de>
	<Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	<20050408171518.GA4201@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504081037310.28951@ppc970.osdl.org>
	<20050408180540.GA4522@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504081149010.28951@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> you need to reuse the same inode/dev numbers
> (again - I didn't worry about portability, and filesystems where those
> aren't stable are a "don't do that then") 

On filesystems that don't have a stable inode number, I use the md5sum
of the full (relative to mount point) pathname as the inode number. 

Since these same file systems (not surprisingly) lack hard links as
well, the pathname _is_ essentially the stable inode number.


Off-topic details ...

This is on my backup program, which does a full snapshot of my 90 Gb
system, including some FAT file systems, in 6 or 7 minutes, plus time
proportional to actual changes.  I have given up finding a backup
program I can tolerate, and write my own.  It stores each md5sum unique
blob exactly once, but uses the same sort of tricks you describe to
detect changes from examining just the stat information so as to avoid
reading every damn byte on the disk.  It works with smb, fat, vfat,
ntfs, reiserfs, xfs, ext2/3, ...  A single manifest file, in plain
ascii, one file per line, captures a full snapshot, disk-to-disk, every
few hours.

This comment from my backup source explains more:

# Unfortunately, fat, vfat, smb, and ncpfs (Netware) file systems
# do not have unique disk-based persistent inode numbers.
# The kernel constructs transient inode numbers for inodes
# in its cache.  But after an umount and re-mount, the inode
# numbers are all different.  So we would end up recalculating
# the md5sums of all files in any such file systems.
#
# To avoid this, we keep track of which directories are on such
# file systems, and for files in any such directory, instead
# of using the inode value from stat'ing a file, we use the
# md5sum of its path as a pseudo-inode number.  This digest of
# a file's path has improved persistance over it's transiently
# assigned inode number.  Fields 5,6,7 (files total, free and
# avail) happen to be zero on file systems (fat, vfat, smb,
# ...) with no real inodes, so we we use this fallback means
# of getting a persistent pseudo-inode if a statvfs() call on
# its directory has fields 5,6,7 summing to zero:
#       sum(os.statvfs(dir)[5:8]) == 0
# We include that dir in the fat_directories set in this case.

fat_directories = sets.Set()    # set of directory paths on FAT file systems

# The Python statvfs() on Linux is a tad expensive - the
# glibc statvfs(2) code does several system calls, including
# scanning /proc/mounts and stat'ing its entries.  We need
# to know for each file whether it is on a "fat" file system
# (see above), but for efficiency we only statvfs at mount
# points, then propagate the file system type from there down.

mountpoints = [m.split()[1] for m in open("/proc/mounts")]



-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
