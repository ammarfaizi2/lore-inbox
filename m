Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWAXLKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWAXLKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 06:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWAXLKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 06:10:22 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50661 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030456AbWAXLKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 06:10:20 -0500
Date: Tue, 24 Jan 2006 16:40:19 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Jan Blunck <jblunck@suse.de>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060124111019.GA9375@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru> <20060123155728.GC26653@hasse.suse.de> <20060124055425.GA30609@in.ibm.com> <43D5F7DD.7010507@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D5F7DD.7010507@sw.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kirill,

On Tue, Jan 24, 2006 at 12:48:13PM +0300, Kirill Korotaev wrote:
> I like your idea, but some comments below... I doubt it works.
> I will think it over a bit later...
> 

Thanks. Please find my comments and updated patch below

> Kirill
> P.S. it's not easily reproducable. Before my fix it took us 3-6 hours on 
> automated stress testing to hit this bug. Right now I can't setup it for 
> testing, maybe in a week or so.

Sure, please test whenever you set it up.

[snip]

> >+		spin_lock(&sb_lock);
> <<<< 1. sb_lock doesn't protect atomic_read() anyhow...
> <<<<    I mean, sb_lock is not required to read its value...

Good point, the sb_lock is not required. I have removed it.

> >+		if (!atomic_read(&dentry->d_sb->s_active)) {
> >+			/*
> >+			 * Race condition, umount and other pruning is 
> >happening
> >+			 * in parallel.
> >+			 */
> >+			if (current->flags & PF_MEMALLOC) {
> >+				/*
> >+				 * let the allocator leave this dentry alone
> >+				 */
> >+				spin_unlock(&sb_lock);
> >+				spin_unlock(&dentry->d_lock);
> >+				spin_unlock(&dcache_lock);
> >+				return;
> <<<< you should not return, but rather 'continue'. otherwise you skip 
> _all_ dentries, even from active super blocks.

Good point.

> >+			}
> >+		}
> >+		spin_unlock(&sb_lock);
> >+
> <<<< and here, when you drop sb_lock, and dentry->d_lock/dcache_lock in 
> prune_dentry() it looks to me that we have exactly the same situation as 
> it was without your patch:
> <<<< another CPU can start umount in parallel.
> <<<< maybe sb_lock barrier helps this somehow, but I can't see how yet...

>From the unmount path, __mntput() is called. It sets s_active to 0 in
deactivate_super(), hence our check would prevent us from pruning a dentry
that is a part of a super block that is going to go away soon. The idea
is to let the unmount do all the work here, the allocator can concentrate
on other dentries.

> 
> <<<< another idea: down_read(&sb->s_umount) probably could help...
> <<<< because it will block the whole umount operation...
> <<<< but we can't take it under dcache_lock...

Yes, we cannot do a down* under a spinlock

[snip]

How does the modified patch look? 

Regards,
Balbir


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 fs/dcache.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -puN fs/dcache.c~dcache_race_fix2 fs/dcache.c
--- linux-2.6/fs/dcache.c~dcache_race_fix2	2006-01-24 11:05:46.000000000 +0530
+++ linux-2.6-balbir/fs/dcache.c	2006-01-24 15:49:30.000000000 +0530
@@ -425,6 +425,21 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
+
+		if (!atomic_read(&dentry->d_sb->s_active)) {
+			/*
+			 * Race condition, umount and other pruning is happening
+			 * in parallel.
+			 */
+			if (current->flags & PF_MEMALLOC) {
+				/*
+				 * Ask the allocator leave this dentry alone
+				 */
+				spin_unlock(&dentry->d_lock);
+				continue;
+			}
+		}
+
 		prune_one_dentry(dentry);
 	}
 	spin_unlock(&dcache_lock);
_
