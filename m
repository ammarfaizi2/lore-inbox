Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWAYHDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWAYHDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWAYHDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:03:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:26600 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750740AbWAYHDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:03:13 -0500
Date: Wed, 25 Jan 2006 12:33:18 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Jan Blunck <jblunck@suse.de>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060125070318.GA31764@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060123155728.GC26653@hasse.suse.de> <20060124055425.GA30609@in.ibm.com> <43D5F7DD.7010507@sw.ru> <20060124111019.GA9375@in.ibm.com> <43D6615D.2090101@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D6615D.2090101@sw.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> you check can happen 1 nanosecond before it sets s_active, after that 
> the code goes into prune_dentry(), while deactivate_super() successfully 
> sets s_active and starts umount main job. Nothing prevents the race... :(
> 
> 
Yes, true. Thanks for pointing this out.

Now I am thinking about s_umount semaphore that you mentioned yesterday.
I thought we could always do a down_read_trylock on it under the 
dcache lock.

Here is one more attempt at fixing the race :-)

Assumptions: 

1. Super block s is still valid after prune_one_dentry (found this to be true).
   This is required to do the up_read().

Costs:

1. Holding s_umount for each dentry

Comments?

Thanks,
Balbir




Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 fs/dcache.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

diff -puN fs/dcache.c~dcache_race_fix2 fs/dcache.c
--- linux-2.6/fs/dcache.c~dcache_race_fix2	2006-01-24 11:05:46.000000000 +0530
+++ linux-2.6-balbir/fs/dcache.c	2006-01-25 12:16:06.000000000 +0530
@@ -396,6 +396,8 @@ static void prune_dcache(int count)
 	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
+		int ret = 0;
+		struct super_block *s;
 
 		cond_resched_lock(&dcache_lock);
 
@@ -425,7 +427,25 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
+
+		/*
+		 * Is someone is unmounting the filesystem associated with
+		 * this dentry? If we are the allocator, leave the dentry
+		 * alone.
+		 */
+		s = dentry->d_sb;
+		if ((current->flags & PF_MEMALLOC) &&
+			!(ret = down_read_trylock(&s->s_umount))) {
+ 			spin_unlock(&dentry->d_lock);
+			continue;
+		}
+
 		prune_one_dentry(dentry);
+
+		if (ret) {
+			up_read(&s->s_umount);
+			ret = 0; /* for the next iteration */
+		}
 	}
 	spin_unlock(&dcache_lock);
 }
_
