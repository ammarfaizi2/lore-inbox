Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272979AbTHFAIw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272980AbTHFAIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:08:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:59038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272979AbTHFAIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:08:17 -0400
Date: Tue, 5 Aug 2003 17:09:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
       piggin@cyberone.com.au, kernel@kolivas.org, linux-mm@kvack.org
Subject: Re: [patch] real-time enhanced page allocator and throttling
Message-Id: <20030805170954.59385c78.akpm@osdl.org>
In-Reply-To: <1060121638.4494.111.camel@localhost>
References: <1060121638.4494.111.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> > There is a very good argument for giving !SCHED_OTHER tasks
>  > "special treatment" in the VM.
> 
>  Yes, there is.
> 
>  Attached patch is against 2.6.0-test2-mm4. 

Thanks.  I guess we should extend the special treatment in the page
allocator and in balance_dirty_pages() we still should go and update the
various bits of state and poke pdflush if needed.

These changes should yield quite significant improvements in worst-case
latencies for realtime tasks under some situations.  I'll test them...


diff -puN mm/page_alloc.c~rt-tasks-special-vm-treatment-2 mm/page_alloc.c
--- 25/mm/page_alloc.c~rt-tasks-special-vm-treatment-2	2003-08-05 16:57:51.000000000 -0700
+++ 25-akpm/mm/page_alloc.c	2003-08-05 16:58:11.000000000 -0700
@@ -592,6 +592,8 @@ __alloc_pages(unsigned int gfp_mask, uns
 		local_min = z->pages_min;
 		if (gfp_mask & __GFP_HIGH)
 			local_min >>= 2;
+		if (rt_task(p))
+			local_min >>= 1;
 		min += local_min;
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
diff -puN mm/page-writeback.c~rt-tasks-special-vm-treatment-2 mm/page-writeback.c
--- 25/mm/page-writeback.c~rt-tasks-special-vm-treatment-2	2003-08-05 16:57:51.000000000 -0700
+++ 25-akpm/mm/page-writeback.c	2003-08-05 17:02:40.000000000 -0700
@@ -144,7 +144,7 @@ get_dirty_limits(struct page_state *ps, 
  * If we're over `background_thresh' then pdflush is woken to perform some
  * writeout.
  */
-void balance_dirty_pages(struct address_space *mapping)
+static void balance_dirty_pages(struct address_space *mapping)
 {
 	struct page_state ps;
 	long nr_reclaimable;
@@ -167,8 +167,9 @@ void balance_dirty_pages(struct address_
 		nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
 		if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 			break;
-
 		dirty_exceeded = 1;
+		if (rt_task(current))
+			break;
 
 		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
 		 * Unstable writes are a feature of certain networked
@@ -223,7 +224,7 @@ void balance_dirty_pages_ratelimited(str
 	 * Check the rate limiting. Also, we do not want to throttle real-time
 	 * tasks in balance_dirty_pages(). Period.
 	 */
-	if (get_cpu_var(ratelimits)++ >= ratelimit && !rt_task(current)) {
+	if (get_cpu_var(ratelimits)++ >= ratelimit) {
 		__get_cpu_var(ratelimits) = 0;
 		put_cpu_var(ratelimits);
 		balance_dirty_pages(mapping);

_

