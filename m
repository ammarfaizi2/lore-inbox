Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTFVAsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 20:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbTFVAsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 20:48:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50407 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264949AbTFVAso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 20:48:44 -0400
Date: Sun, 22 Jun 2003 03:02:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Ed Okerson <eokerson@quicknet.net>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch] ixj.c: EXPORT_SYMBOL of static functions
Message-ID: <20030622010245.GA3763@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/telephony/ixj.c EXPORT_SYMBOL's two static functions.

Does this make any sense or is the patch below OK?

cu
Adrian


--- linux-2.5.72-mm2/drivers/telephony/ixj.c.old	2003-06-22 02:47:07.000000000 +0200
+++ linux-2.5.72-mm2/drivers/telephony/ixj.c	2003-06-22 02:51:49.000000000 +0200
@@ -404,14 +404,10 @@
 	return 0;
 }
 
-static IXJ_REGFUNC ixj_DownloadG729 = &Stub;
-static IXJ_REGFUNC ixj_DownloadTS85 = &Stub;
 static IXJ_REGFUNC ixj_PreRead = &Stub;
 static IXJ_REGFUNC ixj_PostRead = &Stub;
 static IXJ_REGFUNC ixj_PreWrite = &Stub;
 static IXJ_REGFUNC ixj_PostWrite = &Stub;
-static IXJ_REGFUNC ixj_PreIoctl = &Stub;
-static IXJ_REGFUNC ixj_PostIoctl = &Stub;
 
 static void ixj_read_frame(IXJ *j);
 static void ixj_write_frame(IXJ *j);
@@ -790,97 +786,6 @@
 	return 0;
 }
 
-static int ixj_register(int index, IXJ_REGFUNC regfunc)
-{
-	int cnt;
-	int retval = 0;
-	switch (index) {
-	case G729LOADER:
-		ixj_DownloadG729 = regfunc;
-		for (cnt = 0; cnt < IXJMAX; cnt++) {
-			IXJ *j = get_ixj(cnt);
-			while(test_and_set_bit(cnt, (void *)&j->busyflags) != 0) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(1);
-			}
-			ixj_DownloadG729(j, 0L);
-			clear_bit(cnt, &j->busyflags);
-		}
-		break;
-	case TS85LOADER:
-		ixj_DownloadTS85 = regfunc;
-		for (cnt = 0; cnt < IXJMAX; cnt++) {
-			IXJ *j = get_ixj(cnt);
-			while(test_and_set_bit(cnt, (void *)&j->busyflags) != 0) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(1);
-			}
-			ixj_DownloadTS85(j, 0L);
-			clear_bit(cnt, &j->busyflags);
-		}
-		break;
-	case PRE_READ:
-		ixj_PreRead = regfunc;
-		break;
-	case POST_READ:
-		ixj_PostRead = regfunc;
-		break;
-	case PRE_WRITE:
-		ixj_PreWrite = regfunc;
-		break;
-	case POST_WRITE:
-		ixj_PostWrite = regfunc;
-		break;
-	case PRE_IOCTL:
-		ixj_PreIoctl = regfunc;
-		break;
-	case POST_IOCTL:
-		ixj_PostIoctl = regfunc;
-		break;
-	default:
-		retval = 1;
-	}
-	return retval;
-}
-
-EXPORT_SYMBOL(ixj_register);
-
-static int ixj_unregister(int index)
-{
-	int retval = 0;
-	switch (index) {
-	case G729LOADER:
-		ixj_DownloadG729 = &Stub;
-		break;
-	case TS85LOADER:
-		ixj_DownloadTS85 = &Stub;
-		break;
-	case PRE_READ:
-		ixj_PreRead = &Stub;
-		break;
-	case POST_READ:
-		ixj_PostRead = &Stub;
-		break;
-	case PRE_WRITE:
-		ixj_PreWrite = &Stub;
-		break;
-	case POST_WRITE:
-		ixj_PostWrite = &Stub;
-		break;
-	case PRE_IOCTL:
-		ixj_PreIoctl = &Stub;
-		break;
-	case POST_IOCTL:
-		ixj_PostIoctl = &Stub;
-		break;
-	default:
-		retval = 1;
-	}
-	return retval;
-}
-
-EXPORT_SYMBOL(ixj_unregister);
-
 static void ixj_init_timer(IXJ *j)
 {
 	init_timer(&j->timer);
