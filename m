Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283227AbRK2Nzm>; Thu, 29 Nov 2001 08:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283229AbRK2Nzc>; Thu, 29 Nov 2001 08:55:32 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:15623 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S283227AbRK2NzX>; Thu, 29 Nov 2001 08:55:23 -0500
Date: Thu, 29 Nov 2001 16:54:56 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: new bio: compile fix for alpha
Message-ID: <20011129165456.A13610@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added BUG_ON macro, similar to x86 one;
arg 2 for blk_queue_bounce_limit() declared `long long' in blkdev.h
and `u64' in ll_rw_blk.c, which is not the same thing on alpha.
There are several compiler warnings "long long format, long arg",
caused by the same reason, but I think they could be ignored at this point.

Ivan.

--- 2.5.1p3/include/linux/blkdev.h	Wed Nov 28 16:35:34 2001
+++ linux/include/linux/blkdev.h	Wed Nov 28 18:31:32 2001
@@ -238,7 +238,7 @@ extern void blk_attempt_remerge(request_
 extern int blk_init_queue(request_queue_t *, request_fn_proc *, char *);
 extern void blk_cleanup_queue(request_queue_t *);
 extern void blk_queue_make_request(request_queue_t *, make_request_fn *);
-extern void blk_queue_bounce_limit(request_queue_t *, unsigned long long);
+extern void blk_queue_bounce_limit(request_queue_t *, u64);
 extern void blk_queue_max_sectors(request_queue_t *q, unsigned short);
 extern void blk_queue_max_segments(request_queue_t *q, unsigned short);
 extern void blk_queue_max_segment_size(request_queue_t *q, unsigned int);
--- 2.5.1p3/include/asm-alpha/page.h	Wed Nov 28 16:34:32 2001
+++ linux/include/asm-alpha/page.h	Wed Nov 28 18:30:31 2001
@@ -64,7 +64,14 @@ do {										\
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__);			\
 	__asm__ __volatile__("call_pal %0  # bugchk" : : "i" (PAL_bugchk));	\
 } while (0)
+
 #define PAGE_BUG(page)	BUG()
+
+#define BUG_ON(condition)			\
+	do {					\
+		if (unlikely((long)(condition)))\
+			BUG();			\
+	} while (0)
 
 /* Pure 2^n version of get_order */
 extern __inline__ int get_order(unsigned long size)
