Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284384AbRLENVo>; Wed, 5 Dec 2001 08:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284385AbRLENVd>; Wed, 5 Dec 2001 08:21:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:50700 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S284384AbRLENV1>; Wed, 5 Dec 2001 08:21:27 -0500
Message-ID: <3C0E1CFD.1E2265FB@evision-ventures.com>
Date: Wed, 05 Dec 2001 14:11:25 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Deep look into VFS
In-Reply-To: <E16BJvR-0002uc-00@the-village.bc.nu> <E16BK7Y-0000Rk-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yerstoday I had  a look into the virtual VFS. Out of this
the following question araises for me.

Inside fs/inode.c we have a generic clear_inode(). All fine
all well at one palce the usage of this function goes as follows:
(the function in question is iput() from the same file)

	if (op && op->delete_inode) {
		void (*delete)(struct inode *) = op->delete_inode;
		if (!is_bad_inode(inode))
			DQUOT_INIT(inode);
		/* s_op->delete_inode internally recalls clear_inode() */
		delete(inode);
	} else
		clear_inode(inode);

Well my tought was, that it would be nice to avoid
the explicit callback to inode from driver code in the middle for
nowhere, which would allow us to change the above code sequence into
the much cleaner:

	if (op && op->delete_inode) {
		void (*delete)(struct inode *) = op->delete_inode;
		if (!is_bad_inode(inode))
			DQUOT_INIT(inode);
		delete(inode);
	} 
	clear_inode(inode);

Therefore I have looked at all the places, where clear_inode
is actually called inside the FS implementation code.

shmmem() told me that the above change would be entierly fine with it.

We have however the following in ext2/ialloc.c:


/*
 * NOTE! When we get the inode, we're the only people
 * that have access to it, and as such there are no
 * race conditions we have to worry about. The inode
 * is not on the hash-lists, and it cannot be reached
 * through the filesystem because the directory entry
 * has been deleted earlier.
 *
 * HOWEVER: we must make sure that we get no aliases,
 * which means that we have to call "clear_inode()"
 * _before_ we mark the inode not in use in the inode
 * bitmaps. Otherwise a newly created file might use
 * the same inode number (not actually the same pointer
 * though), and then we'd have two inodes sharing the
 * same inode number and space on the harddisk.
 */
void ext2_free_inode (struct inode * inode)
{
...
	
	lock_super (sb);
...
	/* Do this BEFORE marking the inode not in use or returning an error */
	clear_inode (inode);

...
	unlock_super (sb);
}

Unless I'm compleatly misguided the lock on the superblock
should entierly prevent the race described inside the header comment
and we should be able to delete clear_inode from this function.

Question is: Can someone with more knowlendge of the intimidate 
inner workings of the VFS tell me whatever my suspiction is
right or not?

Thanks in advance...

PS. Deleting clear_inode() would help to simplify the
delete_inode parameters quite a significant bit, as
well as deleting the tail union in struct inode - that's the goal.
