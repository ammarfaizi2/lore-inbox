Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270853AbUJUTMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270853AbUJUTMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270833AbUJUTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:07:10 -0400
Received: from kanga.kvack.org ([66.96.29.28]:1689 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S270803AbUJUTDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:03:21 -0400
Date: Thu, 21 Oct 2004 15:03:12 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/timer.c: xtime lock missing
Message-ID: <20041021190312.GA30847@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

While looking at the time keeping code for related work, I came across 
the following bug.  During 2.5 development, the smptimers patch removed 
a lock from update_times() that is actually needed over the xtime 
update, since the second overflow is not an atomic operation.  This 
patch fixes that by doing a write_seqlock() over the course of the 
update.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler

===== timer.c 1.93 vs edited =====
--- 1.93/kernel/timer.c	2004-09-17 03:07:06 -04:00
+++ edited/timer.c	2004-10-21 14:51:53 -04:00
@@ -940,11 +940,14 @@
 {
 	unsigned long ticks;
 
+	/* interrupts are disabled */
+	write_seqlock(&xtime_lock);
 	ticks = jiffies - wall_jiffies;
 	if (ticks) {
 		wall_jiffies += ticks;
 		update_wall_time(ticks);
 	}
+	write_sequnlock(&xtime_lock);
 	calc_load(ticks);
 }
   
