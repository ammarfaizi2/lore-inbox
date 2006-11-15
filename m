Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755473AbWKOH4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbWKOH4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966599AbWKOH4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:56:09 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:60622 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755478AbWKOHuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:32 -0500
Message-ID: <363577028.93218@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075031.909090639@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:30 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 23/28] readahead: laptop mode
Content-Disposition: inline; filename=readahead-laptop-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the laptop drive is spinned down, defer look-ahead to spin up time.

The implementation employs a poll based method, for performance is not a
concern in this code path. The poll interval is 64KB, which should be small
enough for movies/musics. The user space application is responsible for
proper caching to hide the spin-up-and-read delay.

For crazy laptop users who prefer aggressive read-ahead, here is the way:

# echo 1000 > /proc/sys/vm/readahead_ratio
# blockdev --setra 524280 /dev/hda      # this is the max possible value

Notes:
- It is still an untested feature.
- It is safer to use blockdev+fadvise to increase ra-max for a single file,
  which needs patching your movie player.
- Be sure to restore them to sane values in normal operations!

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/include/linux/writeback.h
+++ linux-2.6.19-rc5-mm2/include/linux/writeback.h
@@ -86,6 +86,12 @@ void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
 
+extern struct timer_list laptop_mode_wb_timer;
+static inline int laptop_spinned_down(void)
+{
+	return !timer_pending(&laptop_mode_wb_timer);
+}
+
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int vm_dirty_ratio;
--- linux-2.6.19-rc5-mm2.orig/mm/page-writeback.c
+++ linux-2.6.19-rc5-mm2/mm/page-writeback.c
@@ -375,7 +375,7 @@ static void wb_timer_fn(unsigned long un
 static void laptop_timer_fn(unsigned long unused);
 
 static DEFINE_TIMER(wb_timer, wb_timer_fn, 0, 0);
-static DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
+DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
 
 /*
  * Periodic writeback of "old" data.
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -17,6 +17,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/buffer_head.h>
+#include <linux/writeback.h>
 
 #include <asm/div64.h>
 
@@ -822,6 +823,32 @@ out:
 }
 
 /*
+ * Set a new look-ahead mark at @next.
+ * Return 0 if the new mark is successfully set.
+ */
+static int renew_lookahead(struct address_space *mapping,
+				struct file_ra_state *ra,
+				pgoff_t offset, pgoff_t next)
+{
+	struct page *page;
+
+	if (offset == ra->lookahead_index &&
+	      next >= ra->readahead_index)
+		return 1;
+
+	if (!(page = find_get_page(mapping, next)))
+		return 1;
+
+	SetPageReadahead(page);
+	page_cache_release(page);
+
+	if (ra->lookahead_index == offset)
+	    ra->lookahead_index = next;
+
+	return 0;
+}
+
+/*
  * Update `backing_dev_info.ra_thrash_bytes' to be a _biased_ average of
  * read-ahead sizes. Which makes it an a-bit-risky(*) estimation of the
  * _minimal_ read-ahead thrashing threshold on the device.
@@ -1629,6 +1656,15 @@ page_cache_readahead_adaptive(struct add
 			ra_account(ra, RA_EVENT_IO_CONGESTION, req_size);
 			return 0;
 		}
+
+		/*
+		 * Defer read-ahead to save energy.
+		 */
+		if (unlikely(laptop_mode && laptop_spinned_down())) {
+			if (!renew_lookahead(mapping, ra, offset,
+						offset + LAPTOP_POLL_INTERVAL))
+				return 0;
+		}
 	}
 
 	if (page)

--
