Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270875AbTHAVYE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 17:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTHAVYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 17:24:04 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35490 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S270875AbTHAVYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 17:24:01 -0400
Date: Fri, 1 Aug 2003 23:23:58 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: File system synchronous completion poll.
Message-ID: <20030801212358.GA18944@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it's time again to poll for file system semantics with respect to
synchronous completion, for MTA use.

Define: directory operations := link, rename, mkdir (symlink, rmdir, unlink)

Assume the drive's write cache is off (if your file system is safe with
write cache on, because it queues ordered tags on SCSI, please state
so):

For each of XFS, JFS, ext3fs, ext2fs, reiserfs-3.6, reiserfs-4, for
both of 2.4.21 and 2.6.0-testX, please state (rationale below):

1.  Is mount -o sync implemented?
    If not, does mount -o sync fail?
    If yes, does mount -o sync mean a) "all operations synchronous" or
    b) "directory operations" synchronous?

2.  Is mount -o dirsync implemented?

3.  Is chattr +S implemented, and inherited by freshly-created subdirectories?

4.  Is chattr +D implemented, and inherited by freshly-created subdirectories?

5.  Does
    fd=open("a", ...); rename("a", "b"); fsync(fd); close(fd);
    guarantee that "b" is on disk after fsync() has returned?

6.  Which code fragment makes sure a directory is on disk?
    a. mkdir("parent/sub"); fd=open("parent"); fsync(fd);
    b. mkdir("parent/sub"); fd=open("parent/sub"); fsync(fd);
    This question may not be relevant if the system supports -o sync or
    -o dirsync.

7.  Is rename("a", "b") truly atomic or can it cause a file to either
    end up in lost+found or be there as "a" and "b" in a crash?

The results should be recorded (with date of finding) in man mount(8).

I am aware that XFS, reiserfs and ext3fs as of Linux 2.4 commit all
pending transactions within a file system when an fsync() is requested,
however, this isn't always sufficient (particularly in the mkdir case,
what do you open to fsync it?).

The rationale is to find out how much Linux file systems differ from BSD
UFS + softupdates code, and how well which file system suits the
opposite of the common tuning (data base): mail transfer agent. Their
authors are still reluctant to add explicit fd=open("directory");
fsync(fd) code and assume traditional BSD "noasync" (= dirsync)
semantics.

-- 
Matthias Andree
