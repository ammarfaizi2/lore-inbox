Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbUK3TWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUK3TWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUK3TWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:22:37 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:58501 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262265AbUK3TW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:22:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QV1wh+P/QeuCYO1J3etq0ZFMuDaWqV9iSHw5ORyM/T3QiaQuK91/zKyY5rfByEgh3sXRXtiLAEx1SDv+SAOx9aEmXknMiK5DUD2pSLfR9V41viLm7Uuv5AW2NBqmoaZ+OYwfX1XbitoHZozTK0fyJlmla9LfcYcfp26uwrefERo=
Message-ID: <cce9e37e041130112243beb62d@mail.gmail.com>
Date: Tue, 30 Nov 2004 19:22:29 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Designing Another File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41ABF7C5.5070609@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41ABF7C5.5070609@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 23:32:05 -0500, John Richard Moser
<nigelenki@comcast.net> wrote:

> - - localization of Inodes and related meta-data to prevent disk thrashing

All filesystems place their filesystem metadata inside the inodes.  If
you mean file metadata then please be more precise.  This isn't
terribly new, recent posts have discussed how moving eas/acls inside
the inode for ext3 has sped up performance.

> 
> - - a scheme which allows Inodes to be dynamically allocated and
> deallocated out of order
>

Um,  all filesystems do that, I think you're missing words to the
effect "without any performance loss or block fragmentation" !

> - - 64 bit indices indicating the exact physical location on disk of
> Inodes, giving a O(1) seek to the Inode itself

> 1)  Can Unix utilities in general deal with 64 bit Inodes?  (Most
> programs I assume won't care; ls -i and df -i might have trouble)
> 

There seems to be some confusion here.  The filesystem can use 64 bit
inode numbers internally but hide these 64 bits and instead present
munged 32 bit numbers to Linux.

The 64 bit resolution is only necessary within the filesystem dentry
lookup function to go from a directory name entry to the physical
inode location on disk.  The inode number can then be reduced to 32
bits for 'presentation' to the VFS.  AFAIK as all file access is
through the dentry cache this is sufficient.  The only problems are
that VFS iget() needs to be replaced with a filesystem specific iget. 
A number of filesystems do this.  Squashfs internally uses 37 bit
inode numbers and presents them as 32 bit inode numbers in this way.

> 3)  What basic information do I absolutely *need* in my super block?
> 4)  What basic information do I absolutely *need* in my Inodes? (I'm
> thinking {type,atime,dtime,ctime,mtime,posix_dac,meta_data_offset,size,\
> links}

Very much depends on your filesystem.  Cramfs is a good example of the
minimum you need to store to satisfy the Linux VFS.  If you don't care
what they are almost anything can be invented (uid, gid, mode, atime,
dtime etc) and set to a useful default.  The *absolute* minimum is
probably type, file/dir size, and file/dir data location on disk.

> I guess the second would be better?  I can't locate any directories on
> my drive with >2000 entries *shrug*.  The end key is just the entry
> {name,inode} pair.

I've had people trying to store 500,000 + files in a Squashfs
directory.  Needless to say with the original directory implementation
this didn't work terribly well...

Phillip Lougher
