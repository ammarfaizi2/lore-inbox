Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262833AbTCKFCB>; Tue, 11 Mar 2003 00:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbTCKFCB>; Tue, 11 Mar 2003 00:02:01 -0500
Received: from [140.239.227.29] ([140.239.227.29]:4533 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262833AbTCKFB7>;
	Tue, 11 Mar 2003 00:01:59 -0500
Date: Mon, 10 Mar 2003 16:25:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Message-ID: <20030310212515.GA1750@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alex Tomas <bzzz@tmi.comex.ru>, Daniel Phillips <phillips@arcor.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <11490000.1046367063@[10.10.2.4]> <m34r6fyya8.fsf@lexa.home.net> <20030307173425.5C4D3FAAAE@mx12.arcor-online.net> <m3r89hrp8t.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r89hrp8t.fsf@lexa.home.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 10:08:34AM +0300, Alex Tomas wrote:
> 1) As far as I understand, duplicates are possible even in classic ext2
>    w/o sortdir/index. See the diagram:
> 
>                     Process 1                  Process 2
> 
>                     getdents(2) returns
>                     dentry1 (file1 -> Inode1)
>                     dentry2 (file2 -> Inode2)
> 
> context switch -->
>                                                unlink(file1), empty dentry1
>                                                creat(file3), Inode3, use dentry1
>                                                creat(file1), Inode1, use dentry3
> 
> context switch -->
> 
>                     getdents(2) returns
>                     dentry3(file1 -> Inode1)
> 
> 
> Am I right?

Yup.  POSIX allows this.  If you're in the middle of readdir() when a
file (or files) is created or deleted, then it is undefined how
readdir() will treat the filename(s) involved.  However, you're *not*
allowed to duplicate or omit filenames that were not touched by a file
creation or deletion.

> 2) Why do not use hash order for traversal like ext3_dx_readdir() does?
>    Upon reading several dentries within some hash set readdir() sorts them
>    in inode order and returns to an user.

Yeah, glibc could do this, although it would make telldir/seekdir more
than a little complicated.  (There's an awful lot of pain and agony
caused to filesystem developers caused by the existence of
telldir/seekdir, which inherently assumes a flat directory structure,
and so it makes it hard to do tricks like this.)

At some level this is the same solution as "do this in userspace",
except instead of needing to convince the maintainers of du and find,
we'd need to convince Ulrich.  It is *not* clear that it would
necessarily be easier to get this fix into the glibc.  In fact, since
du and find probably don't use seekdir/telldir, it's probably easier
to get the change into du and find.

						- Ted
