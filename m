Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312122AbSCQVUu>; Sun, 17 Mar 2002 16:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312123AbSCQVUl>; Sun, 17 Mar 2002 16:20:41 -0500
Received: from waste.org ([209.173.204.2]:62878 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S312122AbSCQVUd>;
	Sun, 17 Mar 2002 16:20:33 -0500
Date: Sun, 17 Mar 2002 15:20:19 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Mark Mielke <mark@mark.mielke.cc>
cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Paul Allen <allenp@nwlink.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext2 zeros inode in directory entry when deleting files.
In-Reply-To: <20020317131702.A16140@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44.0203171516540.21552-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2002, Mark Mielke wrote:

> On Sun, Mar 17, 2002 at 11:21:08AM -0600, Oliver Xymoron wrote:
> > Also, (for the benefit of our readers) in the case of ext2 directories,
> > dirents are in the form
> >     [inode][reclen][namelen]["name"][inode][reclen][namelen]["name"]
> > where reclen is effectively a pointer to the next record. It should be
> > sufficient for the purposes of e2fsck and the kernel that records be
> > unlinked from the list by extending the previous record and the inode in
> > the entry be marked unused in the inode bitmap. So I see no reason to be
> > zeroing the contents of unreferenced disk space, as it needlessly hinders
> > future rescue attempts.
>
> Out of curiosity... how would you mark the first entry in a directory
> as 'deleted' under your suggestion?

It's not a suggestion, the current code already does this:

/*
 * ext2_delete_entry deletes a directory entry by merging it with the
 * previous entry. Page is up-to-date. Releases the page.
 */
...
        if (pde)
                pde->rec_len = cpu_to_le16(to-from);

As it happens, the first entry tends to be '.'.

> Also, I'm not certain, but I suspect that the reclen vs namelen
> difference allows the ext2(/3) format to be extended while minimizing
> breakage to existing code. One day another field might be added to the
> inode and any assumptions regarding the size of a record length would
> limit such extensions. (One such field is currently the 'file type',
> although, the file type does not actually use up any additional bytes)

Doesn't matter, reclen still makes it a linked list, and we'd still skip
over 'dead' entries, regardless of content.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

