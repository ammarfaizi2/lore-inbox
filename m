Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbTBUUMz>; Fri, 21 Feb 2003 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbTBUUMz>; Fri, 21 Feb 2003 15:12:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:38123 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267671AbTBUUMx>;
	Fri, 21 Feb 2003 15:12:53 -0500
Date: Fri, 21 Feb 2003 12:20:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-Id: <20030221122024.040055a0.akpm@digeo.com>
In-Reply-To: <11870000.1045848448@[10.10.2.4]>
References: <32720000.1045671824@[10.10.2.4]>
	<20030219101957.05088aa1.akpm@digeo.com>
	<17280000.1045811967@[10.10.2.4]>
	<17930000.1045812486@[10.10.2.4]>
	<20030220234522.185f3f6c.akpm@digeo.com>
	<11870000.1045848448@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 20:22:54.0498 (UTC) FILETIME=[03D86020:01C2D9E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> >> Some more stats ... which look rather suspicious. 600% increase for
> >> dentry_open and __mark_inode_dirty? Hmmmmm.
> > 
> > __mark_inode_dirty() just got itself an smp_mb().  Would be instructive to
> > disable that.
> > 
> > dentry_open(): don't know - fs/open.c hasn't changed at all.  Perhaps
> > dcache_rcu has caused additional pingpong?
> 
> 2.5.59-mjb6             84 __mark_inode_dirty
> 2.5.61-mjb1            594 __mark_inode_dirty
> 2.5.61-mjb1-no_mb       74 __mark_inode_dirty
> 
> Yup, that fixed that one ... but presumably it was put there for a reason,
> so I can't just rip it out ;-) Thanks, I'll go take a closer look at the
> others.

mark_inode_dirty() tends to be called _very_ frequently.  Too frequently.

Could you try remounting all filesystems noatime with

	mount /mnt/point -o remount,noatime

and the below patch will prevent us calling the barrier-happy
current_kernel_time() for noatime mounts.


diff -puN fs/inode.c~update_atime-speedup fs/inode.c
--- 25/fs/inode.c~update_atime-speedup	Fri Feb 21 12:17:00 2003
+++ 25-akpm/fs/inode.c	Fri Feb 21 12:17:33 2003
@@ -1091,17 +1091,20 @@ sector_t bmap(struct inode * inode, sect
  
 void update_atime(struct inode *inode)
 {
-	struct timespec now = CURRENT_TIME; 
+	struct timespec now;
 
-	/* Can later do this more lazily with a per superblock interval */
-	if (timespec_equal(&inode->i_atime, &now))
-		return;
 	if (IS_NOATIME(inode))
 		return;
 	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode))
 		return;
 	if (IS_RDONLY(inode))
 		return;
+
+	now = CURRENT_TIME;
+
+	/* Can later do this more lazily with a per superblock interval */
+	if (timespec_equal(&inode->i_atime, &now))
+		return;
 	inode->i_atime = now;
 	mark_inode_dirty_sync(inode);
 }

_

