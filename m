Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314656AbSDTRM7>; Sat, 20 Apr 2002 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSDTRM6>; Sat, 20 Apr 2002 13:12:58 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:15275 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314656AbSDTRM5>; Sat, 20 Apr 2002 13:12:57 -0400
Date: Sat, 20 Apr 2002 18:33:23 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix sysrq/panic for gcc 3.1
Message-ID: <20020420183323.A22383@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without this patch a loop checking for emergency_sync_scheduled in panic() is optimized
away by gcc 3.1, which causes hangs in panic.

-Andi

diff -X ../../KDIFX -x *-o -x *-RESERVE -burpN ../../v2.5/linux/drivers/char/sysrq.c linux/drivers/char/sysrq.c
--- ../../v2.5/linux/drivers/char/sysrq.c	Thu Mar 28 10:06:16 2002
+++ linux/drivers/char/sysrq.c	Fri Apr 12 18:32:46 2002
@@ -186,7 +186,7 @@ static void go_sync(struct super_block *
  * block devices and malfunctional network filesystems.
  */
 
-int emergency_sync_scheduled;
+volatile int emergency_sync_scheduled;
 
 void do_emergency_sync(void) {
 	struct super_block *sb;
diff -X ../../KDIFX -x *-o -x *-RESERVE -burpN ../../v2.5/linux/include/linux/sysrq.h linux/include/linux/sysrq.h
--- ../../v2.5/linux/include/linux/sysrq.h	Wed Apr 17 13:33:34 2002
+++ linux/include/linux/sysrq.h	Sat Apr 20 16:12:00 2002
@@ -103,7 +103,7 @@ static inline int __reterr(void)
 
 /* Deferred actions */
 
-extern int emergency_sync_scheduled;
+extern volatile int emergency_sync_scheduled;
 
 #define EMERG_SYNC 1
 #define EMERG_REMOUNT 2
