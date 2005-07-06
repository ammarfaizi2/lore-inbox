Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVGFC0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVGFC0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVGFCWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:22:45 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:58008 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262052AbVGFCTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:16 -0400
Subject: [PATCH] [6/48] Suspend2 2.1.9.8 for 2.6.12: 351-syncthreads.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:39 +1000
Message-Id: <11206164391570@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 352-disable-pdflush-during-suspend.patch-old/mm/page-writeback.c 352-disable-pdflush-during-suspend.patch-new/mm/page-writeback.c
--- 352-disable-pdflush-during-suspend.patch-old/mm/page-writeback.c	2005-06-20 11:47:32.000000000 +1000
+++ 352-disable-pdflush-during-suspend.patch-new/mm/page-writeback.c	2005-07-04 23:14:19.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/suspend.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -404,6 +405,12 @@ static void wb_kupdate(unsigned long arg
 		.for_kupdate	= 1,
 	};
 
+	if (test_suspend_state(SUSPEND_DISABLE_SYNCING)) {
+		start_jif = jiffies;
+		next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
+		goto out;
+	}
+
 	sync_supers();
 
 	get_writeback_state(&wbs);
@@ -424,6 +431,8 @@ static void wb_kupdate(unsigned long arg
 		}
 		nr_to_write -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
 	}
+
+out:
 	if (time_before(next_jif, jiffies + HZ))
 		next_jif = jiffies + HZ;
 	if (dirty_writeback_centisecs)

