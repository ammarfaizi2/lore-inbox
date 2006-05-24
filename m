Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWEXLXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWEXLXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWEXLTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:43 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:12930 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932711AbWEXLTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:12 -0400
Message-ID: <348469549.18212@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111910.544274094@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:13 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Bart Samwel <bart@samwel.tk>
Subject: [PATCH 27/33] readahead: laptop mode
Content-Disposition: inline; filename=readahead-laptop-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the laptop drive is spinned down, defer look-ahead to spin up time.

The implementation employs a poll based method, for performance is not a
concern in this code path. The poll interval is 64KB, which should be small
enough for movies/musics. The user space application is responsible for
proper caching to hide the spin-up-and-read delay.

------------------------------------------------------------------------
For crazy laptop users who prefer aggressive read-ahead, here is the way:

# echo 1000 > /proc/sys/vm/readahead_ratio
# blockdev --setra 524280 /dev/hda      # this is the max possible value

Notes:
- It is still an untested feature.
- It is safer to use blockdev+fadvise to increase ra-max for a single file,
  which needs patching your movie player.
- Be sure to restore them to sane values in normal operations!

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/writeback.h |    6 ++++++
 mm/page-writeback.c       |    2 +-
 mm/readahead.c            |   30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/writeback.h
+++ linux-2.6.17-rc4-mm3/include/linux/writeback.h
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
--- linux-2.6.17-rc4-mm3.orig/mm/page-writeback.c
+++ linux-2.6.17-rc4-mm3/mm/page-writeback.c
@@ -389,7 +389,7 @@ static void wb_timer_fn(unsigned long un
 static void laptop_timer_fn(unsigned long unused);
 
 static DEFINE_TIMER(wb_timer, wb_timer_fn, 0, 0);
-static DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
+DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
 
 /*
  * Periodic writeback of "old" data.
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -817,6 +817,31 @@ out:
 }
 
 /*
+ * Set a new look-ahead mark at @new_index.
+ * Return 0 if the new mark is successfully set.
+ */
+static inline int renew_lookahead(struct address_space *mapping,
+				struct file_ra_state *ra,
+				pgoff_t index, pgoff_t new_index)
+{
+	struct page *page;
+
+	if (index == ra->lookahead_index &&
+			new_index >= ra->readahead_index)
+		return 1;
+
+	page = find_page(mapping, new_index);
+	if (!page)
+		return 1;
+
+	__SetPageReadahead(page);
+	if (ra->lookahead_index == index)
+		ra->lookahead_index = new_index;
+
+	return 0;
+}
+
+/*
  * Update `backing_dev_info.ra_thrash_bytes' to be a _biased_ average of
  * read-ahead sizes. Which makes it an a-bit-risky(*) estimation of the
  * _minimal_ read-ahead thrashing threshold on the device.
@@ -1760,6 +1785,11 @@ page_cache_readahead_adaptive(struct add
 							end_index - index);
 			return 0;
 		}
+		if (laptop_mode && laptop_spinned_down()) {
+			if (!renew_lookahead(mapping, ra, index,
+						index + LAPTOP_POLL_INTERVAL))
+				return 0;
+		}
 	}
 
 	if (page)

--
