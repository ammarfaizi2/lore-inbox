Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbVKSDKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbVKSDKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 22:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbVKSDKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 22:10:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161231AbVKSDKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 22:10:13 -0500
Date: Fri, 18 Nov 2005 19:09:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] Fix race in set_max_huge_pages for multiple updaters of
 nr_huge_pages
Message-Id: <20051118190950.2cff4e54.akpm@osdl.org>
In-Reply-To: <1132336300.5151.47.camel@localhost.localdomain>
References: <1132336300.5151.47.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Paris <eparis@redhat.com> wrote:
>
> If there are multiple updaters to /proc/sys/vm/nr_hugepages
> simultaneously it is possible for the nr_huge_pages variable to become
> incorrect.  There is no locking in the set_max_huge_pages function
> around alloc_fresh_huge_page which is able to update nr_huge_pages.  Two
> callers to alloc_fresh_huge_page could race against each other as could
> a call to alloc_fresh_huge_page and a call to update_and_free_page.
> This patch just expands the area covered by the hugetlb_lock to cover
> the call into alloc_fresh_huge_page.  I'm not sure how we could say that
> a sysctl section is performance critical where more specific locking
> would be needed.
> 
> My reproducer was to run a couple copies of the following script
> simultaneously
> 
> while [ true ]; do
> 	echo 1000 > /proc/sys/vm/nr_hugepages
> 	echo 500 > /proc/sys/vm/nr_hugepages
> 	echo 750 > /proc/sys/vm/nr_hugepages
> 	echo 100 > /proc/sys/vm/nr_hugepages
> 	echo 0 > /proc/sys/vm/nr_hugepages
> done
> 
> and then watch /proc/meminfo and eventually you will see things like
> 
> HugePages_Total:     100
> HugePages_Free:      109
> 
> After applying the patch all seemed well.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ----
> 
>  hugetlb.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.14.2/mm/hugetlb.c.old
> +++ linux-2.6.14.2/mm/hugetlb.c
> @@ -22,6 +22,7 @@
>  static struct list_head hugepage_freelists[MAX_NUMNODES];
>  static unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  static unsigned int free_huge_pages_node[MAX_NUMNODES];
> +/* This lock protects updates to hugepage_freelists, nr_huge_pages, and free_huge_pages */
>  static DEFINE_SPINLOCK(hugetlb_lock);
>  
>  static void enqueue_huge_page(struct page *page)
> @@ -172,10 +173,13 @@
>  static unsigned long set_max_huge_pages(unsigned long count)
>  {
>  	while (count > nr_huge_pages) {
> -		struct page *page = alloc_fresh_huge_page();
> -		if (!page)
> -			return nr_huge_pages;
> +		struct page *page;
>  		spin_lock(&hugetlb_lock);
> +		page = alloc_fresh_huge_page();
> +		if (!page) {
> +			spin_unlock(&hugetlb_lock);
> +			return nr_huge_pages;
> +		}
>  		enqueue_huge_page(page);
>  		spin_unlock(&hugetlb_lock);
>  	}

Nope, alloc_fresh_huge_page() does a GFP_HIGHUSER allocation, which can
sleep and may not be called inside spinlock.  You would have seen a spew of
might_sleep() warnings if this was tested with the appropriate kernel
debugging options.


How about this?

--- devel/mm/hugetlb.c~hugetlb-fix-race-in-set_max_huge_pages-for-multiple-updaters-of-nr_huge_pages	2005-11-18 19:04:10.000000000 -0800
+++ devel-akpm/mm/hugetlb.c	2005-11-18 19:07:26.000000000 -0800
@@ -22,6 +22,10 @@ unsigned long max_huge_pages;
 static struct list_head hugepage_freelists[MAX_NUMNODES];
 static unsigned int nr_huge_pages_node[MAX_NUMNODES];
 static unsigned int free_huge_pages_node[MAX_NUMNODES];
+
+/*
+ * Protects updates to hugepage_freelists, nr_huge_pages, and free_huge_pages
+ */
 static DEFINE_SPINLOCK(hugetlb_lock);
 
 static void enqueue_huge_page(struct page *page)
@@ -61,8 +65,10 @@ static struct page *alloc_fresh_huge_pag
 					HUGETLB_PAGE_ORDER);
 	nid = (nid + 1) % num_online_nodes();
 	if (page) {
+		spin_lock(&hugetlb_lock);
 		nr_huge_pages++;
 		nr_huge_pages_node[page_to_nid(page)]++;
+		spin_unlock(&hugetlb_lock);
 	}
 	return page;
 }
_

