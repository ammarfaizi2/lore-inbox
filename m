Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271039AbUJUWbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271039AbUJUWbh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbUJUW2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:28:52 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:10418 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271027AbUJUW1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:27:04 -0400
Message-ID: <417837A7.8010908@yahoo.com.au>
Date: Fri, 22 Oct 2004 08:26:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@novell.com, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random>	<417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org>
In-Reply-To: <20041020213622.77afdd4a.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090604020000060309030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090604020000060309030405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>> #if defined(CONFIG_SMP)
>>
>> >  struct zone_padding {
>> > -	int x;
>> >  } ____cacheline_maxaligned_in_smp;
>> >  #define ZONE_PADDING(name)	struct zone_padding name;
>> >  #else
>>
>> Perhaps to keep old compilers working? Not sure.
> 
> 
> gcc-2.95 is OK with it.
> 
> Stock 2.6.9:
> 
> 	sizeof(struct zone) = 1920
> 
> With Andrea's patch:
> 
> 	sizeof(struct zone) = 1536
> 
> With ZONE_PADDING removed:
> 
> 	sizeof(struct zone) = 1408
> 	
> 

How about this patch. 1536 before, 1152 afterwards for me.

Uses the zero length array which seems to be quite abundant throughout
the tree (although maybe that also causes problems when it is by itself
in an array?).

Also try to be a bit smarter about getting commonly accessed fields
together, which surely can't be worse than before.

--------------090604020000060309030405
Content-Type: text/x-patch;
 name="mm-help-zone-padding.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-help-zone-padding.patch"




---

 linux-2.6-npiggin/include/linux/mmzone.h |   37 +++++++++++++++----------------
 1 files changed, 19 insertions(+), 18 deletions(-)

diff -puN include/linux/mmzone.h~mm-help-zone-padding include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~mm-help-zone-padding	2004-10-22 08:21:30.000000000 +1000
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-10-22 08:24:09.000000000 +1000
@@ -35,7 +35,7 @@ struct pglist_data;
  */
 #if defined(CONFIG_SMP)
 struct zone_padding {
-	int x;
+	char x[0];
 } ____cacheline_maxaligned_in_smp;
 #define ZONE_PADDING(name)	struct zone_padding name;
 #else
@@ -108,10 +108,7 @@ struct per_cpu_pageset {
  */
 
 struct zone {
-	/*
-	 * Commonly accessed fields:
-	 */
-	spinlock_t		lock;
+	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
 	/*
@@ -128,8 +125,18 @@ struct zone {
 	 */
 	unsigned long		protection[MAX_NR_ZONES];
 
+	struct per_cpu_pageset	pageset[NR_CPUS];
+
+	/*
+	 * free areas of different sizes
+	 */
+	spinlock_t		lock;
+	struct free_area	free_area[MAX_ORDER];
+
+
 	ZONE_PADDING(_pad1_)
 
+	/* Fields commonly accessed by the page reclaim scanner */
 	spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
@@ -137,10 +144,8 @@ struct zone {
 	unsigned long		nr_scan_inactive;
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
-	int			all_unreclaimable; /* All pages pinned */
 	unsigned long		pages_scanned;	   /* since last reclaim */
-
-	ZONE_PADDING(_pad2_)
+	int			all_unreclaimable; /* All pages pinned */
 
 	/*
 	 * prev_priority holds the scanning priority for this zone.  It is
@@ -161,10 +166,9 @@ struct zone {
 	int temp_priority;
 	int prev_priority;
 
-	/*
-	 * free areas of different sizes
-	 */
-	struct free_area	free_area[MAX_ORDER];
+	
+	ZONE_PADDING(_pad2_)
+	/* Rarely used or read-mostly fields */
 
 	/*
 	 * wait_table		-- the array holding the hash table
@@ -194,10 +198,6 @@ struct zone {
 	unsigned long		wait_table_size;
 	unsigned long		wait_table_bits;
 
-	ZONE_PADDING(_pad3_)
-
-	struct per_cpu_pageset	pageset[NR_CPUS];
-
 	/*
 	 * Discontig memory support fields.
 	 */
@@ -206,12 +206,13 @@ struct zone {
 	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
 	unsigned long		zone_start_pfn;
 
+	unsigned long		spanned_pages;	/* total size, including holes */
+	unsigned long		present_pages;	/* amount of memory (excluding holes) */
+
 	/*
 	 * rarely used fields:
 	 */
 	char			*name;
-	unsigned long		spanned_pages;	/* total size, including holes */
-	unsigned long		present_pages;	/* amount of memory (excluding holes) */
 } ____cacheline_maxaligned_in_smp;
 
 

_

--------------090604020000060309030405--
