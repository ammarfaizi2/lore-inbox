Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTIHXEy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTIHXEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:04:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43241 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263588AbTIHXEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:04:52 -0400
Message-ID: <3F5D0B09.1040802@pobox.com>
Date: Mon, 08 Sep 2003 19:04:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Re: Linux 2.6.0-test5
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020405060202020202040009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020405060202020202040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Note that people seeing "ifconfig down ... ifconfig up" problems need to 
apply this patch.  (to 2.4.23-pre, too)

	Jeff



--------------020405060202020202040009
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Mon Sep  8 18:14:36 2003
+++ b/net/core/dev.c	Mon Sep  8 18:14:36 2003
@@ -851,7 +851,11 @@
 	 * engine, but this requires more changes in devices. */
 
 	smp_mb__after_clear_bit(); /* Commit netif_running(). */
-	netif_poll_disable(dev);
+	while (test_bit(__LINK_STATE_RX_SCHED, &dev->state)) {
+		/* No hurry. */
+		current->state = TASK_INTERRUPTIBLE;
+		schedule_timeout(1);
+	}
 
 	/*
 	 *	Call the device specific close. This cannot fail.

--------------020405060202020202040009--

