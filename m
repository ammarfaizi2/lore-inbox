Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVDEDx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVDEDx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 23:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVDEDxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 23:53:46 -0400
Received: from THUNK.ORG ([69.25.196.29]:7570 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261459AbVDEDxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 23:53:18 -0400
Date: Mon, 4 Apr 2005 23:53:14 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Vineet Joglekar <vintya@excite.com>, linux-kernel@vger.kernel.org,
       linux-c-programming@vger.kernel.org
Subject: Re: Adding a field to ext2_dir_entry_2
Message-ID: <20050405035314.GB9131@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Vineet Joglekar <vintya@excite.com>, linux-kernel@vger.kernel.org,
	linux-c-programming@vger.kernel.org
References: <20050405000857.0C26B8AEAC@xprdmailfe2.nwk.excite.com> <20050405011251.GP1753@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405011251.GP1753@schnapps.adilger.int>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 07:12:51PM -0600, Andreas Dilger wrote:
> > Let me be more clear about what I am trying to do. In my masters
> > project, I am encrypting inodes along with the data part of the file. Keys
> > of different users are different. In the same directory, if there are
> > 2 files stored by different users, their inodes will be encrypted with
> > different keys. If user1 is doing "ls" on that directory, the inode
> > of the other file - which is encrypted by user2, will be decrypted by
> > using user1's key, resulting into garbage. To avoid this, I am trying
> > to store the uid in the directry entry, so that  I can match it with
> > current->fsuid and skip decrypting the inode if the file doesn't belong
> > to the current user. (assuming user1 doesnt want to share that file and
> > different users can store different files under same directory.)
> 
> This is broken by design.  What happens if you chown a file?  The UID will
> change in the inode, but nothing will be updated in the directory.  This
> key must be stored in the inode along with the ownership info (it can be
> an EA, and possibly a fast EA or fixed inode field in a large inode).

What else is broken about this design.  Let me count the ways...

1)  What about group access to files?

2)  It means that you can't do a filesystem consistency check without
knowing all of the keys, since the block pointers in the inode would
also be encrypted.

3) If user1 has previously accessed the file, the encrypted inode
information will already be cached, and visible when user2 accesses
the file; stat() doesn't result in a call into filesystem code if the
information is already cached.  

What's the point of encrypting the inode?  What problem are you trying
to solve?

As to why you're having problems:

"ext2-fs error (device fd(2,0)): ext2_check_page: bad entry in directory #2:
unaligned directory entry - offset=0, inode=2, rec_len=46, name_len=0"

46 is ascii for '.'.  You missed a spot in mke2fs where you changed
the directory entry structure.  Specifically, in libext2fs, and note
that some portions of the ext2fs library which still use
ext2_dir_entry as well as ext2_dir_entry_2, for historical / ABI
backwards compatibility reasons.

						- Ted

