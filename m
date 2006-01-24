Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWAXFy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWAXFy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 00:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWAXFy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 00:54:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:14020 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932435AbWAXFy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 00:54:28 -0500
Date: Tue, 24 Jan 2006 11:24:25 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jan Blunck <jblunck@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060124055425.GA30609@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060123155728.GC26653@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123155728.GC26653@hasse.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 04:57:28PM +0100, Jan Blunck wrote:
> On Mon, Jan 23, Kirill Korotaev wrote:
>
> [snip] 
>
> Hmm, will think about that one again. shrink_dcache_parent() and
> shrink_dcache_memory()/dput() are not racing against each other now since the
> reference counting is done before giving up dcache_lock and the select_parent
> could start.
> 
> Regards,
> 	Jan
>

I have been playing around with a possible solution to the problem.
I have not been able to reproduce this issue, hence I am unable to verify
if the patch below fixes the problem. I have run the system with this
patch and verified that no obvious badness is observed.

Kirill, Jan if you can easily reproduce the problem, could you
try this patch and review it as well for correctness of the solution?

All callers that try to free memory set the PF_MEMALLOC flag, we check
if the super block is going away due to an unmount, if so we ask the
allocator to return.

The patch adds additional cost of holding the sb_lock for each dentry
being pruned. It holds sb_lock under dentry->d_lock and dcache_lock,
I am not sure about the locking order of these locks.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 fs/dcache.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

diff -puN fs/dcache.c~dcache_race_fix2 fs/dcache.c
--- linux-2.6/fs/dcache.c~dcache_race_fix2	2006-01-24 11:05:46.000000000 +0530
+++ linux-2.6-balbir/fs/dcache.c	2006-01-24 11:05:46.000000000 +0530
@@ -425,6 +425,29 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
+
+		/*
+		 * Note to reviewers: our current lock order is dcache_lock,
+		 * dentry->d_lock & sb_lock. Could this create a deadlock?
+		 */
+		spin_lock(&sb_lock);
+		if (!atomic_read(&dentry->d_sb->s_active)) {
+			/*
+			 * Race condition, umount and other pruning is happening
+			 * in parallel.
+			 */
+			if (current->flags & PF_MEMALLOC) {
+				/*
+				 * let the allocator leave this dentry alone
+				 */
+				spin_unlock(&sb_lock);
+				spin_unlock(&dentry->d_lock);
+				spin_unlock(&dcache_lock);
+				return;
+			}
+		}
+		spin_unlock(&sb_lock);
+
 		prune_one_dentry(dentry);
 	}
 	spin_unlock(&dcache_lock);

Thanks,
Balbir
_
