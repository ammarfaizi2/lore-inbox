Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbTCSBK7>; Tue, 18 Mar 2003 20:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbTCSBK6>; Tue, 18 Mar 2003 20:10:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:23980 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262879AbTCSBKy>;
	Tue, 18 Mar 2003 20:10:54 -0500
Date: Tue, 18 Mar 2003 18:03:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: Trammell Hudson <hudson@osresearch.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs fails for medium sized cpio archives
Message-Id: <20030318180350.2acdfcc7.akpm@digeo.com>
In-Reply-To: <20030319011116.GK8263@osbox.osresearch.net>
References: <20030319011116.GK8263@osbox.osresearch.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 01:21:35.0852 (UTC) FILETIME=[E221BAC0:01C2EDB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trammell Hudson <hudson@osresearch.net> wrote:
>
> 	unmapped_ratio = 100 - (ps->nr_mapped * 100) / total_pages;
> 
> I've added a sanity check in get_dirty_limits() that initialized
> total_pages if it is still zero and things seem to work, but
> should some of the memory management modules be initialized first?

This is fixed in 2.5.65, with the below patch.

> The kernel is booting on an Athlon and compiled with gcc 3.2.2.
> The cpio archive is uClibc based and is about 600 k in size.
> I created it with the following command:
> 
> 	find . \
> 		| cpio -H crc -ov \
> 		| gzip
> 		> ../linux-2.5.64/usr/initramfs_data.cpio.gz

Neat.  Nice to see it working.


--- 25/include/linux/writeback.h~early-writeback-init	2003-03-16 22:54:07.000000000 -0800
+++ 25-akpm/include/linux/writeback.h	2003-03-16 22:54:07.000000000 -0800
@@ -79,6 +79,7 @@ extern int dirty_writeback_centisecs;
 extern int dirty_expire_centisecs;
 
 
+void page_writeback_init(void);
 void balance_dirty_pages(struct address_space *mapping);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
diff -puN init/main.c~early-writeback-init init/main.c
--- 25/init/main.c~early-writeback-init	2003-03-16 22:54:07.000000000 -0800
+++ 25-akpm/init/main.c	2003-03-16 22:54:07.000000000 -0800
@@ -35,6 +35,7 @@
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
+#include <linux/writeback.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -443,6 +444,8 @@ asmlinkage void __init start_kernel(void
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
+	/* rootfs populating might need page-writeback */
+	page_writeback_init();
 	populate_rootfs();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
diff -puN mm/page-writeback.c~early-writeback-init mm/page-writeback.c
--- 25/mm/page-writeback.c~early-writeback-init	2003-03-16 22:54:07.000000000 -0800
+++ 25-akpm/mm/page-writeback.c	2003-03-16 22:54:07.000000000 -0800
@@ -369,7 +369,7 @@ static struct notifier_block ratelimit_n
  * dirty memory thresholds: allowing too much dirty highmem pins an excessive
  * number of buffer_heads.
  */
-static int __init page_writeback_init(void)
+void __init page_writeback_init(void)
 {
 	long buffer_pages = nr_free_buffer_pages();
 	long correction;
@@ -392,9 +392,7 @@ static int __init page_writeback_init(vo
 	add_timer(&wb_timer);
 	set_ratelimit();
 	register_cpu_notifier(&ratelimit_nb);
-	return 0;
 }
-module_init(page_writeback_init);
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {

_

