Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293390AbSCSAv5>; Mon, 18 Mar 2002 19:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293403AbSCSAvq>; Mon, 18 Mar 2002 19:51:46 -0500
Received: from smtp000.nwlink.com ([209.20.130.57]:36626 "EHLO
	smtp000.nwlink.com") by vger.kernel.org with ESMTP
	id <S293390AbSCSAvb>; Mon, 18 Mar 2002 19:51:31 -0500
Message-ID: <3C968B38.4070405@nwlink.com>
Date: Mon, 18 Mar 2002 16:50:00 -0800
From: Paul Allen <allenp@nwlink.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
In-Reply-To: <20020317131702.A16140@mark.mielke.cc> <Pine.LNX.4.44.0203171516540.21552-100000@waste.org> <20020317185356.C16140@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I've been informed by none other than Alan Cox and
Ted Tso that the ext2 filesystem has to zero inode numbers
in deleted directory entries because it has to.  And I've
been told to go read McKusick by the amazing Alexander Viro.
Wizards such as these have scant time to waste on questioners
such as myself, and I am grateful for the words they sent
my way.

Although I have been around Unix and kernel sources for
quite a long time, I am not a member of the elite Linux
kernel hacking community.  Perhaps you can imagine the
trepidation with which I put forth the following fact:

Prior to 2.4.6, the inode number of a deleted file was only
zeroed if there was no previous entry with a reclen value
to be adjusted.  If I'm reading the code right, when the
first entry in a directory block was deleted, its inode
number was zeroed.  If any other entry in a directory block
was deleted, the reclen of the previous entry was adjusted
to point past the deleted entry and the inode number was
not zeroed.

With 2.4.6, the ext2_delete_entry() function moved from
fs/ext2/namei.c to fs/ext2/dir.c and its behavior changed.
Now, the inode number is always zeroed.

I've tested file deletion on a stock 2.2.18 kernel, and it
behaved the same as a pre 2.4.6 kernel would.  A single
deleted file in the root of an ext2 filesystem on a floppy
retained its inode number.  The ext2_delete_entry() function
in the 2.2.18 fs/ext2/namei.c looks very similar to the
2.4.0 version.

So, prior to the 2.4.6 kernel, it appears that most deleted
directory entries had non-zero inode numbers.  The kernel,
fsck, and everybody else was perfectly happy.  And someone
needing to resurrect filenames to go with deleted inodes
could usually find them.  It would be possible for multiple
deleted directory entries to point to the same inode, but I
think this preferable to losing all filenames.

Certainly, file undeletion is dicey on a multi-user system
or one with background activity other than the silly user's
errant "rm" command in the foreground.  However, in the
case of a single-user system with little going on except
the foreground shell, retaining most of the inode numbers
on deleted files is arguably useful.  In the event that
damaged my friend's filesystem, about 16,000 files were
deleted over a span of a few seconds.  Most of these were
chaff: browser caches, metadata stores for KDE, Gnome,
and the like.  Not more than a couple hundred of the 16,000
files were actually useful, but they were anonymous needles
in a haystack of data.  It's been a month now, and we think
we've got most of the good data recovered.

In short, I liked the pre-2.4.6 behavior.  I'm curious as
to the rationale for changing it.


Thanks!

Paul Allen
allenp@nwlink.com

