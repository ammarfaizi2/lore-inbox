Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUKVJVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUKVJVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUKVJVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:21:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:489 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261988AbUKVJVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:21:19 -0500
Subject: [PATCH]time run too fast after S3
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1101114923.14572.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 22 Nov 2004 17:15:23 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
after resume from S3, 'date' shows time run too fast. Here is a patch.

Thanks,
Shaohua

Signed-off-by: Li Shaohua <shaohua.li@intel.com>

diff -puN arch/i386/kernel/time.c~wall_jiffies arch/i386/kernel/time.c
--- 2.6/arch/i386/kernel/time.c~wall_jiffies	2004-11-22 17:04:42.720038352 +0800
+++ 2.6-root/arch/i386/kernel/time.c	2004-11-22 17:06:21.373040816 +0800
@@ -343,12 +343,13 @@ static int timer_resume(struct sys_devic
 		hpet_reenable();
 #endif
 	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = get_cmos_time() - sleep_start;
+	sleep_length = (get_cmos_time() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
-	jiffies += sleep_length * HZ;
+	jiffies += sleep_length;
+	wall_jiffies += sleep_length;
 	return 0;
 }
 


