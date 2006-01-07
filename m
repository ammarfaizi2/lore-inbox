Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752516AbWAGCvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbWAGCvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbWAGCvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:51:38 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32985 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752498AbWAGCvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:51:37 -0500
Date: Sat, 07 Jan 2006 11:50:38 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH] Simple memory hot-add for ia64.
Cc: Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Bob Picco <bob.picco@hp.com>,
       Mike Kravetz <kravetz@us.ibm.com>
In-Reply-To: <1136575296.8189.25.camel@localhost.localdomain>
References: <20060106114249.5649.Y-GOTO@jp.fujitsu.com> <1136575296.8189.25.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060107114233.120C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2006-01-06 at 11:50 +0900, Yasunori Goto wrote:
> > Fortunately, 2.6.15 includes memory hot-add function for i386 and ppc.
> > So, I made a patch for ia64.
> > This doesn't make new pgdat. All of new memory will belong to
> > node 0 by this patch. But this is simplest first step and best start for
> > future work.
> 
> It does look quite simple.  Nice work.
> 
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +void online_page(struct page *page)
> > +{
> > +	ClearPageReserved(page);
> > +	set_page_count(page, 1);
> > +	__free_page(page);
> > +	totalram_pages++;
> > +	num_physpages++;
> > +}
> 
> You're the first one to get one of these in for an alternate
> architecture.  We'll need to keep an eye out so that one of these
> doesn't pop up on each of the 64-bit arches with no highmem as we add
> support.  But, this should be just fine for now. 
> 
> > +int add_memory(u64 start, u64 size)
> > +{
> > +	pg_data_t *pgdat;
> > +	struct zone *zone;
> > +	unsigned long start_pfn = start >> PAGE_SHIFT;
> > +	unsigned long nr_pages = size >> PAGE_SHIFT;
> > +	int ret;
> > +
> > +	pgdat = NODE_DATA(0);
> > +
> > +	zone = pgdat->node_zones + ZONE_NORMAL;
> > +	ret = __add_pages(zone, start_pfn, nr_pages);
> > +
> > +	if (ret)
> > +		printk("%s: Problem encountered in __add_pages() as ret=%d\n", __func__,  ret);
> 
> For some reason, I thought we were officially supposed to use
> __FUNCTION__ for stuff like this.  However, I am usually lazy in my
> debugging patches and use __func__.  I'm a bad example.

I didn't know it. Thanks!

> This also looks a bit past 80 columns.

Ok. This is newer one. :-)

Bye.

------------------

Fortunately, 2.6.15 includes memory hot-add function for i386 and ppc.
So, I made a patch for ia64.
This doesn't make new pgdat. All of new memory will belong to
node 0 by this patch. But this is simplest first step and best start for
future work.

I tested on my Tiger4. Please apply.

(This patch doesn't use ZONE_EASY_RECLAIM yet, because its zone will be useful
 for just hot-remove.)

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


Index: new_feature_patch/arch/ia64/mm/init.c
===================================================================
--- new_feature_patch.orig/arch/ia64/mm/init.c	2006-01-07 10:58:27.000000000 +0900
+++ new_feature_patch/arch/ia64/mm/init.c	2006-01-07 10:59:52.000000000 +0900
@@ -635,3 +635,39 @@ mem_init (void)
 	ia32_mem_init();
 #endif
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+void online_page(struct page *page)
+{
+	ClearPageReserved(page);
+	set_page_count(page, 1);
+	__free_page(page);
+	totalram_pages++;
+	num_physpages++;
+}
+
+int add_memory(u64 start, u64 size)
+{
+	pg_data_t *pgdat;
+	struct zone *zone;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int ret;
+
+	pgdat = NODE_DATA(0);
+
+	zone = pgdat->node_zones + ZONE_NORMAL;
+	ret = __add_pages(zone, start_pfn, nr_pages);
+
+	if (ret)
+		printk("%s: Problem encountered in __add_pages() as ret=%d\n",
+		       __FUNCTION__,  ret);
+
+	return ret;
+}
+
+int remove_memory(u64 start, u64 size)
+{
+	return -EINVAL;
+}
+#endif

-- 
Yasunori Goto 


