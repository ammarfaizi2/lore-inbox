Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTECXdC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTECXcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:32:01 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:60939 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263480AbTECXbp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10520054473121@movementarian.org>
Subject: [PATCH 7/8] OProfile update
In-Reply-To: <10520054473225@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:07 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -6.4 (------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fo-000JiS-4z*RonlpB65dXY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change the lost_mmap_sem stat to lost_no_mm, and account it.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-me/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-04-05 18:44:49.000000000 +0100
+++ linux-me/drivers/oprofile/buffer_sync.c	2003-05-03 20:10:44.000000000 +0100
@@ -296,6 +321,8 @@
 		add_sample_entry(s->eip, s->event);
 	} else if (mm) {
 		add_us_sample(mm, s);
+	} else {
+		atomic_inc(&oprofile_stats.sample_lost_no_mm);
 	}
 }
  
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprofile_stats.c linux-me/drivers/oprofile/oprofile_stats.c
--- linux-cvs/drivers/oprofile/oprofile_stats.c	2003-03-07 15:39:16.000000000 +0000
+++ linux-me/drivers/oprofile/oprofile_stats.c	2003-05-01 14:40:18.000000000 +0100
@@ -31,7 +31,7 @@
 		cpu_buf->sample_lost_task_exit = 0;
 	}
  
-	atomic_set(&oprofile_stats.sample_lost_mmap_sem, 0);
+	atomic_set(&oprofile_stats.sample_lost_no_mm, 0);
 	atomic_set(&oprofile_stats.event_lost_overflow, 0);
 }
 
@@ -68,8 +68,8 @@
 			&cpu_buf->sample_lost_task_exit);
 	}
  
-	oprofilefs_create_ro_atomic(sb, dir, "sample_lost_mmap_sem",
-		&oprofile_stats.sample_lost_mmap_sem);
+	oprofilefs_create_ro_atomic(sb, dir, "sample_lost_no_mm",
+		&oprofile_stats.sample_lost_no_mm);
 	oprofilefs_create_ro_atomic(sb, dir, "event_lost_overflow",
 		&oprofile_stats.event_lost_overflow);
 }
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprofile_stats.h linux-me/drivers/oprofile/oprofile_stats.h
--- linux-cvs/drivers/oprofile/oprofile_stats.h	2002-10-16 03:26:30.000000000 +0100
+++ linux-me/drivers/oprofile/oprofile_stats.h	2003-05-01 14:36:12.000000000 +0100
@@ -13,7 +13,7 @@
 #include <asm/atomic.h>
  
 struct oprofile_stat_struct {
-	atomic_t sample_lost_mmap_sem;
+	atomic_t sample_lost_no_mm;
 	atomic_t event_lost_overflow;
 };
 

