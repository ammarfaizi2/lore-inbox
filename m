Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVCOWS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVCOWS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCOWOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:14:37 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:34758 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261925AbVCOWNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:13:44 -0500
Subject: [PATCH] Make md thread NO_FREEZE.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1110924908.6454.136.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 16 Mar 2005 09:15:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

The md driver is currently frozen during suspend. I'm told this doesn't help much if you're seeking to suspend to RAID :>

Signed-of-by: Nigel Cunningham <ncunningham@cyclades.com>

diff -ruNp 213-missing-refrigerator-calls-old/drivers/md/md.c 213-missing-refrigerator-calls-new/drivers/md/md.c
--- 213-missing-refrigerator-calls-old/drivers/md/md.c	2005-02-14 09:05:26.000000000 +1100
+++ 213-missing-refrigerator-calls-new/drivers/md/md.c	2005-03-11 09:35:15.000000000 +1100
@@ -36,7 +36,6 @@
 #include <linux/sysctl.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
-#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2763,6 +2762,7 @@ int md_thread(void * arg)
 	 */
 
 	daemonize(thread->name, mdname(thread->mddev));
+	current->flags |= PF_NOFREEZE;
 
 	current->exit_signal = SIGCHLD;
 	allow_signal(SIGKILL);
@@ -2787,8 +2787,6 @@ int md_thread(void * arg)
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
 

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

