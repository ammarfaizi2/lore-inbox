Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbUAQSn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUAQSnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:43:55 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:24229 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266104AbUAQSnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:43:47 -0500
Message-ID: <40098259.9020405@colorfullife.com>
Date: Sat, 17 Jan 2004 19:43:37 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] remove sleep_on from drivers/net/shaper.c
Content-Type: multipart/mixed;
 boundary="------------060709080206020109000607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060709080206020109000607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The shaper devices uses sleep_on for it's wait queue. The implementation
is racy, the attached patch replaces it with an explicit
add/remove_wait_queue.




--------------060709080206020109000607
Content-Type: text/plain;
 name="patch-sleep_on_shaper"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sleep_on_shaper"

--- 2.6/drivers/net/shaper.c	2004-01-17 12:19:27.000000000 +0100
+++ build-2.6/drivers/net/shaper.c	2004-01-17 12:34:19.000000000 +0100
@@ -83,6 +83,7 @@
 #include <linux/if_arp.h>
 #include <linux/init.h>
 #include <linux/if_shaper.h>
+#include <linux/wait.h>
 
 #include <net/dst.h>
 #include <net/arp.h>
@@ -106,17 +107,27 @@
  
 static int shaper_lock(struct shaper *sh)
 {
+	DECLARE_WAITQUEUE(wait, current);
+
 	/*
 	 *	Lock in an interrupt must fail
 	 */
-	while (test_and_set_bit(0, &sh->locked))
-	{
-		if (!in_interrupt())
-			sleep_on(&sh->wait_queue);
-		else
+	if (in_interrupt()) {
+		if (test_and_set_bit(0, &sh->locked)) {
 			return 0;
-			
+		} else {
+			return 1;
+		}
+	}
+	add_wait_queue(&sh->wait_queue, &wait);
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (test_and_set_bit(0, &sh->locked) == 0)
+			break;
+		schedule();
 	}
+	remove_wait_queue(&sh->wait_queue, &wait);
+	__set_current_state(TASK_RUNNING);
 	return 1;
 }
 


--------------060709080206020109000607--

