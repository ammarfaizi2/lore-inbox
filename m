Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUFBB1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUFBB1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 21:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUFBB1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 21:27:33 -0400
Received: from holomorphy.com ([207.189.100.168]:62355 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265317AbUFBB0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 21:26:40 -0400
Date: Tue, 1 Jun 2004 18:26:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       suparna@in.ibm.com, linux-aio@kvack.org
Subject: [2/2] fix io_getevents() timer expiry setting
Message-ID: <20040602012636.GW2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	suparna@in.ibm.com, linux-aio@kvack.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602012429.GV2093@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602012429.GV2093@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 06:24:29PM -0700, William Lee Irwin III wrote:
> The time conversion functions may have const args, which is in fact
> useful for when they are passed const variables as arguments so as
> to avoid discarding qualifiers from pointer types warnings. This is
> a preparatory cleanup for a minor aio bugfix.

start_jiffies was not respected by set_timeout(), which reread jiffies
instead of respecting what read_events() passed it. This difference can
be significant, particularly if the calling process slept during the
copy_to_user() operation in read_events(). To correct this, this patch
teaches it to respect its argument, with the additional bonus of
converting it to use timespec_to_jiffies() instead of open-coding it.

Index: timer-2.6.7-rc2/fs/aio.c
===================================================================
--- timer-2.6.7-rc2.orig/fs/aio.c	2004-06-01 03:25:53.000000000 -0700
+++ timer-2.6.7-rc2/fs/aio.c	2004-06-01 16:03:41.000000000 -0700
@@ -777,19 +777,11 @@
 static inline void set_timeout(long start_jiffies, struct timeout *to,
 			       const struct timespec *ts)
 {
-	unsigned long how_long;
-
-	if (ts->tv_sec < 0 || (!ts->tv_sec && !ts->tv_nsec)) {
+	to->timer.expires = start_jiffies + timespec_to_jiffies(ts);
+	if (time_after(to->timer.expires, jiffies))
+		add_timer(&to->timer);
+	else
 		to->timed_out = 1;
-		return;
-	}
-
-	how_long = ts->tv_sec * HZ;
-#define HZ_NS (1000000000 / HZ)
-	how_long += (ts->tv_nsec + HZ_NS - 1) / HZ_NS;
-	
-	to->timer.expires = jiffies + how_long;
-	add_timer(&to->timer);
 }
 
 static inline void clear_timeout(struct timeout *to)
