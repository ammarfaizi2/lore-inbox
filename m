Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275280AbTHSBYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275283AbTHSBYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:24:11 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:62987 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S275280AbTHSBXx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:23:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <106125623288@movementarian.org>
Subject: [PATCH 3/3] OProfile: add a useful statistic
In-Reply-To: <1061256231526@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 19 Aug 2003 02:23:52 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19ovE0-000BdY-Jp*jHkeMMjSIgA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a stat counting the (relatively common) case where a PC value is logged
but there is no (longer) any executable mapping covering that address.

diff -X dontdiff -Naur linux-cvs/drivers/oprofile/buffer_sync.c linux-fixes/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-06-18 15:06:09.000000000 +0100
+++ linux-fixes/drivers/oprofile/buffer_sync.c	2003-08-19 01:15:36.000000000 +0100
@@ -308,8 +308,10 @@
  
  	cookie = lookup_dcookie(mm, s->eip, &offset);
  
-	if (!cookie)
+	if (!cookie) {
+		atomic_inc(&oprofile_stats.sample_lost_no_mapping);
 		return;
+	}
 
 	if (cookie != last_cookie) {
 		add_cookie_switch(cookie);
diff -X dontdiff -Naur linux-cvs/drivers/oprofile/oprofile_stats.c linux-fixes/drivers/oprofile/oprofile_stats.c
--- linux-cvs/drivers/oprofile/oprofile_stats.c	2003-05-04 02:42:47.000000000 +0100
+++ linux-fixes/drivers/oprofile/oprofile_stats.c	2003-08-19 01:17:17.000000000 +0100
@@ -32,6 +32,7 @@
 	}
  
 	atomic_set(&oprofile_stats.sample_lost_no_mm, 0);
+	atomic_set(&oprofile_stats.sample_lost_no_mapping, 0);
 	atomic_set(&oprofile_stats.event_lost_overflow, 0);
 }
 
@@ -70,6 +71,8 @@
  
 	oprofilefs_create_ro_atomic(sb, dir, "sample_lost_no_mm",
 		&oprofile_stats.sample_lost_no_mm);
+	oprofilefs_create_ro_atomic(sb, dir, "sample_lost_no_mapping",
+		&oprofile_stats.sample_lost_no_mapping);
 	oprofilefs_create_ro_atomic(sb, dir, "event_lost_overflow",
 		&oprofile_stats.event_lost_overflow);
 }
diff -X dontdiff -Naur linux-cvs/drivers/oprofile/oprofile_stats.h linux-fixes/drivers/oprofile/oprofile_stats.h
--- linux-cvs/drivers/oprofile/oprofile_stats.h	2003-05-04 02:42:47.000000000 +0100
+++ linux-fixes/drivers/oprofile/oprofile_stats.h	2003-08-19 01:16:23.000000000 +0100
@@ -14,6 +14,7 @@
  
 struct oprofile_stat_struct {
 	atomic_t sample_lost_no_mm;
+	atomic_t sample_lost_no_mapping;
 	atomic_t event_lost_overflow;
 };
 

