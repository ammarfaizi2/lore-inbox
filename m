Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTEZEOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTEZEOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:14:21 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:23045 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264248AbTEZEOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:14:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1053923249281@movementarian.org>
Subject: [PATCH 1/5] OProfile update
In-Reply-To: 
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Mon, 26 May 2003 05:27:29 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19K9a5-000OE2-UW*6oyxQ2Aw8SM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The five patches here change the following files :

 Documentation/kernel-parameters.txt |    3 ++
 drivers/oprofile/buffer_sync.c      |   49 ++++++++++++++++++++++++++----------
 drivers/oprofile/cpu_buffer.c       |    6 +---
 drivers/oprofile/event_buffer.h     |    1
 drivers/oprofile/oprof.c            |   25 +++++++++++++-----
 fs/dcookies.c                       |    6 ++++
 6 files changed, 67 insertions(+), 23 deletions(-)

please apply
john


My previous fix was incomplete, we could get the same thing happening
on the init-failure path. Fix that.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-me/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-05-26 03:20:20.000000000 +0100
+++ linux-me/drivers/oprofile/buffer_sync.c	2003-05-26 04:25:15.000000000 +0100
@@ -127,6 +127,14 @@
 };
 
  
+static void end_sync_timer(void)
+{
+	del_timer_sync(&sync_timer);
+	/* timer might have queued work, make sure it's completed. */
+	flush_scheduled_work();
+}
+
+
 int sync_start(void)
 {
 	int err;
@@ -158,7 +166,7 @@
 out2:
 	profile_event_unregister(EXIT_TASK, &exit_task_nb);
 out1:
-	del_timer_sync(&sync_timer);
+	end_sync_timer();
 	goto out;
 }
 
@@ -169,9 +177,7 @@
 	profile_event_unregister(EXIT_TASK, &exit_task_nb);
 	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
 	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
-	del_timer_sync(&sync_timer);
-	/* timer might have queued work, make sure it's completed. */
-	flush_scheduled_work();
+	end_sync_timer();
 }
 
  

