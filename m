Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262236AbTCMLVi>; Thu, 13 Mar 2003 06:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbTCMLVi>; Thu, 13 Mar 2003 06:21:38 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:51204 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262236AbTCMLVh>; Thu, 13 Mar 2003 06:21:37 -0500
Date: Thu, 13 Mar 2003 11:32:23 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fix oprofile timer race
Message-ID: <20030313113223.GA48379@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18tQwh-000HX6-00*zjEHdzdsBG6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


wli got an oops from this. The callbacks call mod_timer so the timer had
better be setup by then

please apply
john


--- linux/drivers/oprofile/buffer_sync.c	2003-03-06 16:20:31.000000000 +0000
+++ linux-cvs/drivers/oprofile/buffer_sync.c	2003-03-12 15:24:33.000000000 +0000
@@ -82,9 +82,16 @@
  
 int sync_start(void)
 {
-	int err = profile_event_register(EXIT_TASK, &exit_task_nb);
+	int err;
+
+	init_timer(&sync_timer);
+	sync_timer.function = timer_ping;
+	sync_timer.expires = jiffies + DEFAULT_EXPIRE;
+	add_timer(&sync_timer);
+
+	err = profile_event_register(EXIT_TASK, &exit_task_nb);
 	if (err)
-		goto out;
+		goto out1;
 	err = profile_event_register(EXIT_MMAP, &exit_mmap_nb);
 	if (err)
 		goto out2;
@@ -92,16 +99,14 @@
 	if (err)
 		goto out3;
 
-	init_timer(&sync_timer);
-	sync_timer.function = timer_ping;
-	sync_timer.expires = jiffies + DEFAULT_EXPIRE;
-	add_timer(&sync_timer);
 out:
 	return err;
 out3:
 	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
 out2:
 	profile_event_unregister(EXIT_TASK, &exit_task_nb);
+out1:
+	del_timer_sync(&sync_timer);
 	goto out;
 }
 

