Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWB1DRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWB1DRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 22:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWB1DRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 22:17:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932141AbWB1DRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 22:17:40 -0500
Date: Mon, 27 Feb 2006 19:16:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH -mm 1/2] mm: make shrink_all_memory
 overflow-resistant
Message-Id: <20060227191630.467846d7.akpm@osdl.org>
In-Reply-To: <200602271928.22791.rjw@sisk.pl>
References: <200602271926.20294.rjw@sisk.pl>
	<200602271928.22791.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Make shrink_all_memory() overflow-resistant.
> 

As you've probably noticed, I'm moving toward making all the scalars which
hold counts of pages in the VM toward unsigned long.  For uniformity, and
because there is a small risk that a huge machine with 4k pages could
actually overflow a 32-bit counter.

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  include/linux/swap.h |    2 +-
>  mm/vmscan.c          |    9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.16-rc4-mm2/mm/vmscan.c
> ===================================================================
> --- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
> +++ linux-2.6.16-rc4-mm2/mm/vmscan.c
> @@ -1785,18 +1785,19 @@ void wakeup_kswapd(struct zone *zone, in
>   * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
>   * pages.
>   */
> -int shrink_all_memory(unsigned long nr_pages)
> +unsigned long shrink_all_memory(unsigned int nr_pages)

So nr_pages should remain unsigned long.

> +	long long nr_to_free = nr_pages;

As should nr_to_free.

The actual bug is the (unsigned <= 0) thing.   So how's about this?

--- devel/include/linux/swap.h~vmscan-use-unsigned-longs-shrink_all_memory-fix	2006-02-27 19:13:30.000000000 -0800
+++ devel-akpm/include/linux/swap.h	2006-02-27 19:13:30.000000000 -0800
@@ -173,7 +173,7 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern unsigned long try_to_free_pages(struct zone **, gfp_t);
-extern int shrink_all_memory(unsigned long nr_pages);
+extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 
 #ifdef CONFIG_NUMA
--- devel/mm/vmscan.c~vmscan-use-unsigned-longs-shrink_all_memory-fix	2006-02-27 19:13:30.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2006-02-27 19:13:30.000000000 -0800
@@ -1779,22 +1779,23 @@ void wakeup_kswapd(struct zone *zone, in
  * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
  * pages.
  */
-int shrink_all_memory(unsigned long nr_pages)
+unsigned long shrink_all_memory(unsigned long nr_pages)
 {
 	pg_data_t *pgdat;
 	unsigned long nr_to_free = nr_pages;
-	int ret = 0;
+	unsigned long ret = 0;
 	struct reclaim_state reclaim_state = {
 		.reclaimed_slab = 0,
 	};
 
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
-		int freed;
+		unsigned long freed;
+
 		freed = balance_pgdat(pgdat, nr_to_free, 0);
 		ret += freed;
 		nr_to_free -= freed;
-		if (nr_to_free <= 0)
+		if ((long)nr_to_free <= 0)
 			break;
 	}
 	current->reclaim_state = NULL;
_

