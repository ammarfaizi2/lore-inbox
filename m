Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSKEFjF>; Tue, 5 Nov 2002 00:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264787AbSKEFjF>; Tue, 5 Nov 2002 00:39:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:24706 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264756AbSKEFjE>;
	Tue, 5 Nov 2002 00:39:04 -0500
Message-ID: <3DC75AFD.C2EE9DCF@digeo.com>
Date: Mon, 04 Nov 2002 21:45:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/4] timers: initialisers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2002 05:45:33.0645 (UTC) FILETIME=[8ED6A7D0:01C2848E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add some infrastructure for statically initialising timers,
use that in workqueues.



 include/linux/timer.h |    9 +++++++++
 1 files changed, 9 insertions(+)

--- 25/include/linux/timer.h~timer-initialiser	Mon Nov  4 21:11:41 2002
+++ 25-akpm/include/linux/timer.h	Mon Nov  4 21:11:49 2002
@@ -22,6 +22,15 @@ struct timer_list {
 
 #define TIMER_MAGIC	0x4b87ad6e
 
+#define TIMER_INITIALIZER(_function, _expires, _data) {		\
+		.function = (_function),			\
+		.expires = (_expires),				\
+		.data = (_data),				\
+		.base = NULL,					\
+		.magic = TIMER_MAGIC,				\
+		.lock = SPIN_LOCK_UNLOCKED,			\
+	}
+
 /***
  * init_timer - initialize a timer.
  * @timer: the timer to be initialized

.

 include/linux/workqueue.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- 25/include/linux/workqueue.h~work-initialiser	Mon Nov  4 21:11:51 2002
+++ 25-akpm/include/linux/workqueue.h	Mon Nov  4 21:12:06 2002
@@ -22,7 +22,9 @@ struct work_struct {
 #define __WORK_INITIALIZER(n, f, d) {				\
         .entry	= { &(n).entry, &(n).entry },			\
 	.func = (f),						\
-	.data = (d) }
+	.data = (d),						\
+	.timer = TIMER_INITIALIZER(NULL, 0, 0),			\
+	}
 
 #define DECLARE_WORK(n, f, d)					\
 	struct work_struct n = __WORK_INITIALIZER(n, f, d)

.
