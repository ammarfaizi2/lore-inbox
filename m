Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVG0Bmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVG0Bmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVG0Bm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:42:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262260AbVG0Blv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:41:51 -0400
Date: Tue, 26 Jul 2005 18:40:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726184042.439e336f.akpm@osdl.org>
In-Reply-To: <1122427889.6433.71.camel@dyn9047017102.beaverton.ibm.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	<20050726111110.6b9db241.akpm@osdl.org>
	<1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	<20050726114824.136d3dad.akpm@osdl.org>
	<20050726121250.0ba7d744.akpm@osdl.org>
	<1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com>
	<20050726142410.4ff2e56a.akpm@osdl.org>
	<1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com>
	<20050726151003.6aa3aecb.akpm@osdl.org>
	<1122418089.6433.62.camel@dyn9047017102.beaverton.ibm.com>
	<20050726160728.55245dae.akpm@osdl.org>
	<1122420376.6433.68.camel@dyn9047017102.beaverton.ibm.com>
	<20050726173126.5368266b.akpm@osdl.org>
	<1122427889.6433.71.camel@dyn9047017102.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > This machine only has 4G of memory, so the platform code is overestimating
> > the number of pages by 50%.  Can you please check your dmesg, see if your
> > system is also getting this wrong?
> 
> 
> 
> On node 0 totalpages: 1572863
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 1568767 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:1
> On node 1 totalpages: 131071
>   DMA zone: 0 pages, LIFO batch:1
>   Normal zone: 131071 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:1
> On node 2 totalpages: 131071
>   DMA zone: 0 pages, LIFO batch:1
>   Normal zone: 131071 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:1
> On node 3 totalpages: 131071
>   DMA zone: 0 pages, LIFO batch:1
>   Normal zone: 131071 pages, LIFO batch:31
>   HighMem zone: 0 pages, LIFO batch:1

That's 7.7GB, yes?   On a 6GB machine?

If so, that's a bit off, but not grossly.

Here's the dopey debug patch which I used:

- boot
- dmesg -s 1000000 | grep total_pages > foo
- kill off syslogd  (sudo service syslog stop)
- run the dd command
- wait for it to hit steady state (max dirty memory)
- dmesg -s 1000000 >> foo

diff -puN mm/page-writeback.c~a mm/page-writeback.c
--- 25/mm/page-writeback.c~a	2005-07-26 15:53:46.000000000 -0700
+++ 25-akpm/mm/page-writeback.c	2005-07-26 16:21:55.000000000 -0700
@@ -161,7 +161,8 @@ get_dirty_limits(struct writeback_state 
 	dirty_ratio = vm_dirty_ratio;
 	if (dirty_ratio > unmapped_ratio / 2)
 		dirty_ratio = unmapped_ratio / 2;
-
+	printk("vm_dirty_ratio=%d unmapped_ratio=%d dirty_ratio=%d\n",
+		vm_dirty_ratio, unmapped_ratio, dirty_ratio);
 	if (dirty_ratio < 5)
 		dirty_ratio = 5;
 
@@ -171,6 +172,8 @@ get_dirty_limits(struct writeback_state 
 
 	background = (background_ratio * available_memory) / 100;
 	dirty = (dirty_ratio * available_memory) / 100;
+	printk("dirty_ratio=%d available_memory=%lu dirty=%lu\n",
+		dirty_ratio, available_memory, dirty);
 	tsk = current;
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
 		background += background / 4;
@@ -209,6 +212,12 @@ static void balance_dirty_pages(struct a
 		get_dirty_limits(&wbs, &background_thresh,
 					&dirty_thresh, mapping);
 		nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
+		printk("background_thresh=%ld dirty_thresh=%ld "
+				"nr_dirty=%ld nr_unstable=%ld "
+				"nr_reclaimable=%ld wbs.nr_writeback=%ld\n",
+			background_thresh, dirty_thresh,
+			wbs.nr_dirty, wbs.nr_unstable,
+			nr_reclaimable, wbs.nr_writeback);
 		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
 			break;
 
@@ -532,6 +541,8 @@ void __init page_writeback_init(void)
 
 	total_pages = nr_free_pagecache_pages();
 
+	printk("total_pages=%ld\n", total_pages);
+
 	correction = (100 * 4 * buffer_pages) / total_pages;
 
 	if (correction < 100) {
_

