Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136037AbRD0OQM>; Fri, 27 Apr 2001 10:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136042AbRD0OP6>; Fri, 27 Apr 2001 10:15:58 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:5124 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S136037AbRD0OOY>;
	Fri, 27 Apr 2001 10:14:24 -0400
Message-ID: <20010427002853.A11426@bug.ucw.cz>
Date: Fri, 27 Apr 2001 00:28:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Chris Mason <mason@suse.com>, viro@math.psu.edu,
        kernel list <linux-kernel@vger.kernel.org>,
        jack@atrey.karlin.mff.cuni.cz
Cc: torvalds@transmeta.com
Subject: Re: [patch] linux likes to kill bad inodes
In-Reply-To: <20010425220120.A1540@bug.ucw.cz> <466810000.988230486@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <466810000.988230486@tiny>; from Chris Mason on Wed, Apr 25, 2001 at 04:28:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > I had a temporary disk failure (played with acpi too much). What
> >> > happened was that disk was not able to do anything for five minutes
> >> > or so. When disk recovered, linux happily overwrote all inodes it
> >> > could not read while disk was down with zeros -> massive disk
> >> > corruption.
> >> > 
> >> > Solution is not to write bad inodes back to disk.
> >> > 
> >> 
> >> Wouldn't we rather make it so bad inodes don't get marked dirty at all?
> > 
> > I guess this is cheaper: we can mark inode dirty at 1000 points, but
> > you only write it at one point.
> 
> Whoops, I worded that poorly.  To me, it seems like a bug to dirty a bad
> inode.  If this patch works, it is because somewhere, somebody did
> something with a bad inode, and thought the operation worked (otherwise,
> why dirty it?).  
> 
> So yes, even if we dirty them in a 1000 different places, we need to find
> the one place that believes it can do something worthwhile to a bad inode.

Okay, so what about following patch, followed by attempt to debug it?
[I'd really like to get patch it; killing user's data without good
reason seems evil to me, and this did quite a lot of damage to my
$HOME.]

								Pavel
PS: Only filesystem at use at time of problem was ext2, and it was
ext2 iinode that got killed.


--- clean/fs/inode.c	Wed Apr  4 23:58:04 2001
+++ linux/fs/inode.c	Fri Apr 27 00:25:46 2001
@@ -179,6 +179,10 @@
 
 static inline void write_inode(struct inode *inode, int sync)
 {
+	if (is_bad_inode(inode)) {
+		printk(KERN_CRIT "Cowardly refusing to kill your inode\n");
+		return;
+	}		
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode)
 		inode->i_sb->s_op->write_inode(inode, sync);
 }


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
