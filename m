Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130396AbQKPNNm>; Thu, 16 Nov 2000 08:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbQKPNNc>; Thu, 16 Nov 2000 08:13:32 -0500
Received: from [62.172.234.2] ([62.172.234.2]:13736 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130387AbQKPNNS>;
	Thu, 16 Nov 2000 08:13:18 -0500
Date: Thu, 16 Nov 2000 12:44:06 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_empty_inode() cleanup
In-Reply-To: <Pine.LNX.4.21.0011161238210.1530-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011161242330.1530-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Tigran Aivazian wrote:

> On Thu, 16 Nov 2000, Alexander Viro wrote:
> 
> > 	Almost all (== all filesystem and then some) callers of
> > get_empty_inode() follow it with
> > 	inode->i_sb = some_sb;
> > 	inode->i_dev = some_sb->s_dev;
> > Some of them do it twice for no good reason (assign the same value,
> > even though neither ->i_sb nor ->i_dev could change in interval).
> > Some of them duplicate the initializations already done by get_empty_inode()
> > (e.g. ->i_size to 0, ->i_nlink to 1, etc.).
> > 
> > 	Patch below adds an inlined function
> > struct inode *new_inode(struct super_block *sb)
> > {
> > 	struct inode *inode = get_empty_inode();
> > 	if (inode) {
> > 		inode->i_sb = sb;
> > 		inode->i_dev = sb->s_dev;
> > 	}
> > 	return inode;
> > }
> 
> Alexander,
> 
> IMHO, instead of adding a new function, it is cleaner to just add the 'sb'
> argument to get_empty_inode() and those who do not wish to pass it should
> just pass NULL. Checking if(sb) inside it is easier than making yet
> another function call, maybe.
> 

on the other hand, even 1 minute's thought reveals that making strict
logical separation between "consumers of inode with sb" and "consumers of
inode without sb" is probably worth the overhead of an extra function
call. So, I don't strongly feel about the above... maybe you are right :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
