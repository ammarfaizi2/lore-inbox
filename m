Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVJXKzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVJXKzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 06:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVJXKzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 06:55:55 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:61376 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1750860AbVJXKzy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 06:55:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: select() for delay.
Date: Mon, 24 Oct 2005 16:25:18 +0530
Message-ID: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: select() for delay.
Thread-Index: AcXYidLEWrDtK9dFSjmcNJpnBUnxcA==
From: <madhu.subbaiah@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Oct 2005 10:55:11.0454 (UTC) FILETIME=[67DC57E0:01C5D889]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is regarding select() system call.

Linux select() man page mentions " Some  code  calls  select with all
three sets empty, n zero, and a non-null timeout as a fairly portable
way to sleep  with  subsecond  precision".

This patch improves the sys_select() execution when used for delay. 

Kindly suggest.


--- linux-2.4.22/fs/select.c    2003-06-13 20:21:37.000000000 +0530
+++ linux/fs/select.c   2005-10-20 15:01:38.000000000 +0530
@@ -286,6 +286,29 @@ sys_select(int n, fd_set *inp, fd_set *o
        if (n < 0)
                goto out_nofds;
 

+       if ((n == 0) && (inp == NULL) && (outp == NULL) && (exp ==
NULL)) {
+                set_current_state(TASK_INTERRUPTIBLE);
+                ret = 0;
+                timeout = schedule_timeout(timeout);
+

+                if (signal_pending(current))
+                        ret = -ERESTARTNOHAND;
+

+                if (tvp && !(current->personality & STICKY_TIMEOUTS)) {
+                        time_t sec = 0, usec = 0;
+                        if (timeout) {
+                                sec = timeout / HZ;
+                                usec = timeout % HZ;
+                                usec *= (1000000 / HZ);
+                        }
+                        put_user(sec, &tvp->tv_sec);
+                        put_user(usec, &tvp->tv_usec);
+                }
+

+                current->state = TASK_RUNNING;
+                goto out_nofds;
+        }
+
        /* max_fdset can increase, so grab it once to avoid race */
        max_fdset = current->files->max_fdset;
        if (n > max_fdset)

Thanks,
Madhu K.S.
