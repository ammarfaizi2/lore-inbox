Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263098AbTCYR2e>; Tue, 25 Mar 2003 12:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263131AbTCYR2e>; Tue, 25 Mar 2003 12:28:34 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63355 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263098AbTCYR2a>; Tue, 25 Mar 2003 12:28:30 -0500
Date: Tue, 25 Mar 2003 17:39:40 GMT
Message-Id: <200303251739.h2PHdeR3006892@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 2/8] 2.4: Fix for enormous numbers of buffers on BUF_LOCKED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer_head syncing places BUF_DIRTY buffers on the BUF_LOCKED, but
buffers can stay there indefinitely, upsetting buffer accounting.  The
symptoms are benign, mostly just nonsensical numbers in alt-sysrq-m
output, but it's pretty cheap to clean these up in kupdated
nonetheless, just by refiling any unlocked buffers which happen to be
at the head of the BUF_LOCKED list.  (We stop at the first locked
buffer rather than walking the whole list, avoiding walking any
buffers more than once.)

--- linux-2.4-ext3push/fs/buffer.c.=K0001=.orig	2003-03-25 10:59:15.000000000 +0000
+++ linux-2.4-ext3push/fs/buffer.c	2003-03-25 10:59:15.000000000 +0000
@@ -2958,6 +2958,30 @@ int bdflush(void *startup)
 	}
 }
 
+
+/*
+ * Do some IO post-processing here!!!
+ */
+void do_io_postprocessing(void)
+{
+	int i;
+	struct buffer_head *bh, *next;
+
+	spin_lock(&lru_list_lock);
+	bh = lru_list[BUF_LOCKED];
+	if (bh) {
+		for (i = nr_buffers_type[BUF_LOCKED]; i-- > 0; bh = next) {
+			next = bh->b_next_free;
+
+			if (!buffer_locked(bh)) 
+				__refile_buffer(bh);
+			else 
+				break;
+		}
+	}
+	spin_unlock(&lru_list_lock);
+}
+
 /*
  * This is the kernel update daemon. It was used to live in userspace
  * but since it's need to run safely we want it unkillable by mistake.
@@ -3009,6 +3033,7 @@ int kupdate(void *startup)
 #ifdef DEBUG
 		printk(KERN_DEBUG "kupdate() activated...\n");
 #endif
+		do_io_postprocessing();
 		sync_old_buffers();
 		run_task_queue(&tq_disk);
 	}
