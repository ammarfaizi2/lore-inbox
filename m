Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312076AbSCQRVe>; Sun, 17 Mar 2002 12:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312082AbSCQRVZ>; Sun, 17 Mar 2002 12:21:25 -0500
Received: from waste.org ([209.173.204.2]:2196 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S312077AbSCQRVO>;
	Sun, 17 Mar 2002 12:21:14 -0500
Date: Sun, 17 Mar 2002 11:21:08 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
cc: Paul Allen <allenp@nwlink.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
In-Reply-To: <20020317072505.GA768@snap.thunk.org>
Message-ID: <Pine.LNX.4.44.0203171049400.31834-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002 tytso@mit.edu wrote:

> On Sat, Mar 16, 2002 at 12:24:15AM -0800, Paul Allen wrote:
> > While helping a friend recover from a catastrophic "rm -rf" accident,
> > I discovered that deleted files have the inode number in their old
> > directory entries zeroed.  This makes it impossible to match file
> > names with recovered files.  I've verified this behavior on Mandrake
> > 8.1 with Mandrake's stock 2.4.8 kernel.  In my kernel sources and
> > in the stock 2.4.8 sources, the function ext2_delete_entry() in
> > fs/ext2/dir.c has this line:
> >
> > 	dir->inode = 0;
> >
> > Now, I'm tempted to comment the line out in my kernel and see
> > what happens.  But it does occur to me that hackers with more
> > experience than I may zeroing the inode number for a reason and
> > may be depending on it elsewhere in the kernel.  Or perhaps the
> > ext2 flavor of fsck will malfunction if deleted directory entries
> > have a non-zero inode?
>
> Um....  the way directory entries are marked as deleted is by zeroing
> out the inode number.
>
> So if you take out that line, deleted files will appear not to be
> deleted, the kernel will get confused, and you can be sure that fsck
> will complain.

Yes and no.

Procedurally, rm -rf must delete all children before deleting the parent,
but in the end result, it is sufficient to have marked the parent deleted,
without flushing the modified child directories back to disk.

Also, (for the benefit of our readers) in the case of ext2 directories,
dirents are in the form

[inode][reclen][namelen]["name"][inode][reclen][namelen]["name"]

where reclen is effectively a pointer to the next record. It should be
sufficient for the purposes of e2fsck and the kernel that records be
unlinked from the list by extending the previous record and the inode in
the entry be marked unused in the inode bitmap. So I see no reason to be
zeroing the contents of unreferenced disk space, as it needlessly hinders
future rescue attempts.

Paul, if you feel like hacking, I once wrote a Perl module that
understands (pre-sparse-superblock) Ext2 disk layouts:

 http://waste.org/~oxymoron/E2fs.pm

In combination with other scripts, I've used it to recover gigabytes of
files, even in the presence of mangled directories and zeroed indirect
blocks (which hopefully are no longer senselessly zeroed by current
kernels).

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

