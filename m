Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbUBPX5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUBPX5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:57:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:51617 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265975AbUBPX5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:57:11 -0500
Subject: [PATCH] Fix rtasd zombie on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076975790.3648.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 10:56:31 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The rtasd kernel thread would exit before daemoniz'ing itself if
RTAS wasn't present (or if allocation of the buffer failed), thus
leaving a zombie. This patch fixes it (and remove #if 0'ed code)

Please apply,
Ben.

===== arch/ppc64/kernel/rtasd.c 1.15 vs edited =====
--- 1.15/arch/ppc64/kernel/rtasd.c	Mon Jan 19 17:28:25 2004
+++ edited/arch/ppc64/kernel/rtasd.c	Tue Feb 17 10:54:22 2004
@@ -347,6 +347,8 @@
 	int event_scan = rtas_token("event-scan");
 	int rc;
 
+	daemonize("rtasd");
+
 	if (event_scan == RTAS_UNKNOWN_SERVICE || get_eventscan_parms() == -1)
 		goto error;
 
@@ -359,15 +361,9 @@
 	/* We can use rtas_log_buf now */
 	no_more_logging = 0;
 
-	DEBUG("will sleep for %d jiffies\n", (HZ*60/rtas_event_scan_rate) / 2);
-
-	daemonize("rtasd");
+	printk(KERN_ERR "RTAS daemon started\n");
 
-#if 0
-	/* Rusty unreal time task */
-	current->policy = SCHED_FIFO;
-	current->nice = sys_sched_get_priority_max(SCHED_FIFO) + 1;
-#endif
+	DEBUG("will sleep for %d jiffies\n", (HZ*60/rtas_event_scan_rate) / 2);
 
 	/* See if we have any error stored in NVRAM */
 	memset(logdata, 0, rtas_error_log_max);
@@ -423,7 +419,9 @@
 	goto repeat;
 
 error_vfree:
-	vfree(rtas_log_buf);
+	if (rtas_log_buf)
+		vfree(rtas_log_buf);
+	rtas_log_buf = NULL;
 error:
 	/* Should delete proc entries */
 	return -EINVAL;
@@ -450,8 +448,6 @@
 
 	if (kernel_thread(rtasd, 0, CLONE_FS) < 0)
 		printk(KERN_ERR "Failed to start RTAS daemon\n");
-
-	printk(KERN_ERR "RTAS daemon started\n");
 
 	/* Make room for the sequence number */
 	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);


