Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQLOPAO>; Fri, 15 Dec 2000 10:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130376AbQLOPAE>; Fri, 15 Dec 2000 10:00:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:49019 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130180AbQLOO7s>; Fri, 15 Dec 2000 09:59:48 -0500
Date: Fri, 15 Dec 2000 15:29:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: J Sloan <jjs@toyota.com>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lkml]Re: VM problems still in 2.2.18
Message-ID: <20001215152908.M11505@inspiron.random>
In-Reply-To: <3A394C2F.C2895995@toyota.com> <E146hcf-0000DG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E146hcf-0000DG-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 11:17:11PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 11:17:11PM +0000, Alan Cox wrote:
> Andrea - can we have the core VM changes you did without adopting the
> change in semaphore semantics for file system locking which will give third 
> party fs maintainers headaches and doesnt match 2.4 behaviour either ?

The changes in semaphore semantics are necessary to fix the spurious out of
memory with MAP_SHARED mappings and they came together with the removal of the
always-asynchronous kpiod. While it's certainly possible to remove it I don't
think removing the fix for MAP_SHARED stuff is a good idea.

Basically it's always safe to replace:

	down(&inode->i_sem);
	/* critical section */
	up(&inode->isem);

with the new fs-semaphore:

	fs_down(&inode->i_sem);
	/* critical section */
	fs_up(&inode->i_sem);

While it's always safe to use fs_down() in place of down(), it should be done
only with inodes that can be memory mapped using MAP_SHARED if in the
/* critical section */ there is any kind of not-GFP_ATOMIC or not-GFP_BUFFER
allocation like any kind of user-copy (as in every f_ops->write callback).
Most of those down are handled in the VFS and 99% of the time no changes are
necessary in the lowlevel fs so it should not even generate headaches to third
party fs maintainers (I think infact reiserfs patch didn't need any change).

Note: directory i_sem doesn't need the fs_down since a directory can't be
mapped in memory.

2.4.x doesn't need this per-process fs_locks information to avoid recursing on
the i_sem while flushing MAP_SHARED mappings to disk because the lowlevel fs
is required to implement a_ops->writepage to support MAP_SHARED, and the
page-flush gets synchronized only via the per-page lock (while in 2.2.x we need
the i_sem on the inode to call the non-zero-copy f_ops->write to flush the
MAP_SHARED dirty pages).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
