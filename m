Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUIDRsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUIDRsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUIDRsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:48:04 -0400
Received: from ozlabs.org ([203.10.76.45]:26819 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264997AbUIDRqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:46:17 -0400
Date: Sun, 5 Sep 2004 03:44:03 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: levon@movementarian.org, phil.el@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] use for_each_cpu in oprofile code
Message-ID: <20040904174403.GC7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace open coded versions with for_each_cpu()/for_each_online_cpu().

Signed-off-by: Anton Blanchard <anton@samba.org>

===== cpu_buffer.c 1.11 vs edited =====
--- 1.11/drivers/oprofile/cpu_buffer.c	Fri Aug 27 16:42:56 2004
+++ edited/cpu_buffer.c	Sun Sep  5 02:18:01 2004
@@ -36,11 +36,8 @@
 {
 	int i;
  
-	for (i = 0; i < NR_CPUS; ++i) {
-		if (!cpu_online(i))
-			continue;
+	for_each_online_cpu(i)
 		vfree(cpu_buffer[i].buffer);
-	}
 }
  
  
@@ -50,12 +47,9 @@
  
 	unsigned long buffer_size = fs_cpu_buffer_size;
  
-	for (i = 0; i < NR_CPUS; ++i) {
+	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
  
-		if (!cpu_online(i))
-			continue;
-
 		b->buffer = vmalloc(sizeof(struct op_sample) * buffer_size);
 		if (!b->buffer)
 			goto fail;
@@ -94,12 +88,9 @@
 
 	timers_enabled = 1;
 
-	for (i = 0; i < NR_CPUS; ++i) {
+	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
 
-		if (!cpu_online(i))
-			continue;
-
 		add_timer_on(&b->timer, i);
 	}
 }
@@ -111,11 +102,8 @@
 
 	timers_enabled = 0;
 
-	for (i = 0; i < NR_CPUS; ++i) {
+	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
-
-		if (!cpu_online(i))
-			continue;
 
 		del_timer_sync(&b->timer);
 	}
===== oprofile_stats.c 1.8 vs edited =====
--- 1.8/drivers/oprofile/oprofile_stats.c	Fri Aug 27 16:42:56 2004
+++ edited/oprofile_stats.c	Sun Sep  5 02:15:49 2004
@@ -22,10 +22,7 @@
 	struct oprofile_cpu_buffer * cpu_buf; 
 	int i;
  
-	for (i = 0; i < NR_CPUS; ++i) {
-		if (!cpu_possible(i))
-			continue;
-
+	for_each_cpu(i) {
 		cpu_buf = &cpu_buffer[i]; 
 		cpu_buf->sample_received = 0;
 		cpu_buf->sample_lost_overflow = 0;
@@ -49,10 +46,7 @@
 	if (!dir)
 		return;
 
-	for (i = 0; i < NR_CPUS; ++i) {
-		if (!cpu_possible(i))
-			continue;
-
+	for_each_cpu(i) {
 		cpu_buf = &cpu_buffer[i]; 
 		snprintf(buf, 10, "cpu%d", i);
 		cpudir = oprofilefs_mkdir(sb, dir, buf);
