Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbUKXODq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUKXODq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbUKXOCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:02:51 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:18583 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262698AbUKXN2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:28:22 -0500
Subject: Suspend 2 merge: 15/51: Disable pdflush during suspend.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101294981.5805.249.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here we disable pdflush once we've finished syncing data to disk. We
might be writing to a swap file, and don't want to corrupt the user's
disk by writing invalid data to their superblock.


diff -ruN 504-disable-pdflush-during-suspend-old/mm/page-writeback.c 504-disable-pdflush-during-suspend-new/mm/page-writeback.c
--- 504-disable-pdflush-during-suspend-old/mm/page-writeback.c	2004-11-03 21:54:16.000000000 +1100
+++ 504-disable-pdflush-during-suspend-new/mm/page-writeback.c	2004-11-04 16:27:40.000000000 +1100
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/suspend.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -369,6 +370,12 @@
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
@@ -389,6 +396,8 @@
 		}
 		nr_to_write -= MAX_WRITEBACK_PAGES - wbc.nr_to_write;
 	}
+
+out:
 	if (time_before(next_jif, jiffies + HZ))
 		next_jif = jiffies + HZ;
 	if (dirty_writeback_centisecs)


