Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTE2VEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTE2VEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:04:20 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:59390 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262964AbTE2VDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:03:21 -0400
Date: Thu, 29 May 2003 14:14:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Message-Id: <20030529141405.4578b72c.akpm@digeo.com>
In-Reply-To: <39810000.1054240214@[10.10.2.4]>
References: <20030527004255.5e32297b.akpm@digeo.com>
	<1980000.1054189401@[10.10.2.4]>
	<18080000.1054233607@[10.10.2.4]>
	<20030529115237.33c9c09a.akpm@digeo.com>
	<39810000.1054240214@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 21:16:39.0792 (UTC) FILETIME=[9856EF00:01C32627]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > OK, a 10x improvement isn't too bad.  I'm hoping the gap between ext2 and
> > ext3 is mainly idle time and not spinning-on-locks time.
> > 
> > 
> >> 
> >>    2024927   267.3% total
> >>    1677960   472.8% default_idle
> >>     116350     0.0% .text.lock.transaction
> >>      42783     0.0% do_get_write_access
> >>      40293     0.0% journal_dirty_metadata
> >>      34251  6414.0% __down
> >>      27867  9166.8% .text.lock.attr
> > 
> > Bah.  In inode_setattr(), move the mark_inode_dirty() outside
> > lock_kernel().
> 
> OK, will do. 

Actually we can just ditch it.

diff -puN fs/attr.c~inode_setattr-speedup fs/attr.c
--- 25/fs/attr.c~inode_setattr-speedup	Thu May 29 14:01:54 2003
+++ 25-akpm/fs/attr.c	Thu May 29 14:07:57 2003
@@ -81,7 +81,6 @@ int inode_setattr(struct inode * inode, 
 		}
 	}
 
-	lock_kernel();
 	if (ia_valid & ATTR_UID)
 		inode->i_uid = attr->ia_uid;
 	if (ia_valid & ATTR_GID)
@@ -93,12 +92,13 @@ int inode_setattr(struct inode * inode, 
 	if (ia_valid & ATTR_CTIME)
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
-		inode->i_mode = attr->ia_mode;
+		umode_t mode = attr->ia_mode;
+
 		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
-			inode->i_mode &= ~S_ISGID;
+			mode &= ~S_ISGID;
+		inode->i_mode = mode;
 	}
 	mark_inode_dirty(inode);
-	unlock_kernel();
 out:
 	return error;
 }


> >>      20016  2619.9% __wake_up
> >>      19632   927.4% schedule
> >>      12204     0.0% .text.lock.sched
> >>      12128     0.0% start_this_handle
> >>      10011     0.0% journal_add_journal_head
> > 
> > hm, lots of context switches still.
> 
> I think that's ext3 busily kicking the living crap out of semaphores ;-)

But I deleted them all!.  Well.  There is one semaphore left in ext3/jbd,
and that is for serialisation around the oh-shit-we're-out-of-space
checkpointing code.  I shall go on a hat diet if that is being a problem.

hmm, very odd.

You could try my "find out who's doing down() too much" patch:


diff -puN arch/i386/kernel/semaphore.c~down-diag arch/i386/kernel/semaphore.c
--- 25/arch/i386/kernel/semaphore.c~down-diag	Thu May 29 14:11:46 2003
+++ 25-akpm/arch/i386/kernel/semaphore.c	Thu May 29 14:12:18 2003
@@ -66,6 +66,7 @@ void __down(struct semaphore * sem)
 	sem->sleepers++;
 	for (;;) {
 		int sleepers = sem->sleepers;
+		static int count;
 
 		/*
 		 * Add "everybody else" into it. They aren't
@@ -79,6 +80,10 @@ void __down(struct semaphore * sem)
 		sem->sleepers = 1;	/* us - see -1 above */
 		spin_unlock_irqrestore(&sem->wait.lock, flags);
 
+		if (count++ > 100000) {
+			count = 0;
+			dump_stack();
+		}
 		schedule();
 
 		spin_lock_irqsave(&sem->wait.lock, flags);

_

