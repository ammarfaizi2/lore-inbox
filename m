Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbULAHvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbULAHvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 02:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbULAHvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 02:51:38 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:31655 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261321AbULAHvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 02:51:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pZ7LUh8eoAkIj9HnlHQNP0Tk8JNYUbyQKrna0FFkAB/S99/oB7mHkBYRMpueeCrDwGEScSwqKmI9nAXwWjozdmg0Z9+mit+i72uC4J42qUwnbFHoSvRC5hJ2BSMuroOcMxKEDIhvO052WPl2EEBi5Uccu2FG+mi6oq5XU+ty6ig=
Message-ID: <cce9e37e041130235149c2fa97@mail.gmail.com>
Date: Wed, 1 Dec 2004 07:51:29 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Subject: Re: Designing Another File System
Cc: linux-kernel@vger.kernel.org, phillip@lougher.demon.co.uk
In-Reply-To: <E1CZMAH-00053k-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <cce9e37e04113018465091010f@mail.gmail.com>
	 <E1CZMAH-00053k-00@calista.eckenfels.6bone.ka-ip.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2004 05:32:29 +0100, Bernd Eckenfels
<ecki-news2004-05@lina.inka.de> wrote:
> In article <cce9e37e04113018465091010f@mail.gmail.com> you wrote:
> > systems.  The next release of Squashfs has considerably improved
> > indexed directories which are O(1) for large directories.
> 
> Are you talking about time complexity based on a named lookup over the
> number of files in a directory? (you might also want to look at the
> complexity relative to the naming component length). What data structure
> which is not wasting memory allows you those lookups? Even if you consider
> hashing the name as a constant O(1) operation (which it isnt), you still can
> get collisions.
> 

Ouch.  I was being very loose with the O(1) operation definition. 
Squashfs dentry operations have particular performance problems
because directories are compressed in blocks of 8K (BTW as AFAIK
Squashfs is the only Linux fs that compresses metadata).  With the
original Squashfs directories lookup was purely O(n), directory
scanning for a file started at the directory start and finished when
the file was found.  The major performance hit here was the bigger the
directory the more and more blocks needed to be decompressed to scan
the directory.    If the directory fitted inside the internal Squashfs
decompressed metadata cache (eight 8K blocks), then once the directory
was scanned directory lookups occuring soon afterwards didn't need to
decompress the data (being satisfied from the internal metadata
cache), this would be the case say for ls --color=always (ls to
stdout) or find operations.  If the directory was larger than 64K (too
big to fit inside the internal cache), then the performance was
terrible (each lookup re-decompressed the directory data!).

The major goal to improve performance wasn't to get O(1) performance
directly hashing to the required filename, but to get O(1) performance
in terms of going directly to the compressed block containing the
required filename, i.e. irrespective of the length of the directory,
only one directory block needs to be decompressed for a dentry lookup.
 It's important to appreciate that for Squashfs directly hashing to
the filename is useless because that filename is hidden inside a
compressed block and that block always has to be decompressed (unless
it is in the internal cache).

I looked into (various) tree structures and filename hashing but they
didn't give me what I wanted, requiring either large extra data
overhead on disk and/or requiring the directory to be entirely
decompressed on first access and memory overhead for the computed
structure for the lifetime of the directory inode in memory.  For a
filesystem that is used in embedded systems (as well as the archiving
uses that were causing this problem) both were unacceptable (and
destroyed a lot of the savings gained by compressing the directory)
and were unnecessary for my uses anyway.

I opted for a simple index, one entry per 8K compressed block, each
entry stores a pointer to the first filename in each compressed block
(location of start of compressed block, and offset into that block of
the first filename - directory entries can overlap compressed blocks),
and the first filename in each compressed block.  Directories are
sorted in alphabetical order, and the index is scanned linearly
looking for the first filename alphabetically larger than the filename
being looked up.  At this point the index of the compressed block the
filename should be in has been found.  Now this isn't O(1) as far as
as filenames are concerned but it is O(1) in terms of only needing to
decompress one directory block.  The index is stored within the
directory inode (which is also compressed).  Of course you may argue a
 linear scan of the index is slow, however, because it is also
compressed you *have* to do a linear scan (unless you build an index
of that index).   This scheme has the advantage that it solves my
problem, doesn't require extra memory overhead and doesn't require
much extra storage on disk.

Statistics speak louder than words.  The following statistics are from
doing a "time find /mnt -type f | cat > /dev/null" on an Ubuntu livecd
filesystem compressed using Cloop, zisofs, Squashfs 2.0, Squashfs 2.1
(with the improvements) and ext3 (uncompressed).  The Ubuntu
filesystem is about 1.4 GB uncompressed or 470 MB compressed.  Of
course the find indicates the speed of dentry lookup operations only
and deliberately performs no file I/O.  All filesystems were from hard
disk (rather than CD-ROM).

Cloop:              Real 12.692 secs  User 0.216 secs Sys 12.036 secs
zisofs:              Real 12.151 secs  User 0.176 secs Sys 10.499 secs
Squashfs 2.0:  Real 10.697 secs  User 0.132  secs Sys 9.996 secs
Squashfs 2.1:  Real  4.083 secs   User 0.126 secs  Sys 3.931 secs
ext3 (uncom): Real  24.791 secs  User 0.174 secs  Sys 0.694 secs

FYI the filesystem compressed sizes were cloop 472 MB, Squashfs (2.0 &
2.1) 450M, zisofs 591 MB.

This is a somewhat longer description than I intended, but, you did ask!

Phillip Lougher
