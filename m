Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVHHOJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVHHOJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVHHOJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:09:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38902 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932070AbVHHOJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:09:52 -0400
Date: Mon, 8 Aug 2005 19:35:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@in.ibm.com, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: two 2.6.13-rc3-mm3 oddities
Message-ID: <20050808140536.GC4558@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050803095644.78b58cb4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803095644.78b58cb4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am ccing this to linux-kernel for a wider audience.

On Wed, Aug 03, 2005 at 09:56:44AM +1000, Andrew Morton wrote:
> 
> Subject: two 2.6.13-rc3-mm3 oddities
> 
> Just wanted to record a couple of oddities I noticed with 2.6.13-rc3-mm3
> (maybe there before: I hardly tested -mm1 and didn't even download -mm2),
> which have gone away in 2.6.13-rc4-mm1 - so of no great importance, but
> perhaps worth noting in case they resurface later.
> 
> One time my tmpfs-and-looped-tmpfs-kernel-builds collapsed with lots of
> VFS: file-max limit 49778 reached
> messages, which I imagine was a side-effect of the struct file RCU
> patches you've dropped from -rc4-mm1, perhaps a grace period problem.

Hugh, could you please try this with the experimental patch below ?
Manfred, is it safe to decrement nr_files in file_free()
instead of the destructor ? I can't see any problem.

> 
> And repeatably (after a couple of hours or so), on both i386 and x86_64,
> those tests hung waiting on page locks, as if there was a missing
> unlock_page (or a spurious SetPageLocked) somewhere.  I didn't have
> time to do any bisection, but studying source diffs showed no likely
> candidates whatsoever (I did wonder about Nick's __ClearPageDirty,
> but reproduced the problem with that backed out).  As I say, gone
> away (same tests on -rc4-mm1 have run two days), but curious.

Hugh, can you mail me the exact test you run ? I would like to run
it myself and see if I can reproduce it.

Thanks
Dipankar



nr_files need to decremented before the file structure is handed
over to RCU.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 fs/file_table.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN fs/file_table.c~files-fix-nr-files fs/file_table.c
--- linux-2.6.13-rc3-mm3-fixes/fs/file_table.c~files-fix-nr-files	2005-08-08 18:28:12.000000000 +0530
+++ linux-2.6.13-rc3-mm3-fixes-dipankar/fs/file_table.c	2005-08-08 18:32:31.000000000 +0530
@@ -48,10 +48,6 @@ void filp_ctor(void * objp, struct kmem_
 
 void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&filp_count_lock, flags);
-	files_stat.nr_files--;
-	spin_unlock_irqrestore(&filp_count_lock, flags);
 }
 
 static inline void file_free_rcu(struct rcu_head *head)
@@ -62,6 +58,10 @@ static inline void file_free_rcu(struct 
 
 static inline void file_free(struct file *f)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&filp_count_lock, flags);
+	files_stat.nr_files--;
+	spin_unlock_irqrestore(&filp_count_lock, flags);
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
 

_
