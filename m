Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUFFSJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUFFSJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFFSJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:09:52 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:43904 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263928AbUFFSJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:09:47 -0400
Date: Sun, 6 Jun 2004 20:09:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: firewire problems with suspend
Message-ID: <20040606180925.GA4542@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There are some bad problems with firewire & swsusp. This fixes some,
but other remain. If ohci1394 is removed before suspend, then
reinserted, then rmmod hangs.

This is certainly better better than what was there, what about
applying?

								Pavel

--- clean/drivers/ieee1394/ieee1394_core.c	2004-05-20 23:08:14.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_core.c	2004-06-01 23:33:48.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/bitops.h>
 #include <linux/kdev_t.h>
 #include <linux/skbuff.h>
+#include <linux/suspend.h>
 
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -1024,6 +1025,11 @@
 		if (khpsbpkt_kill)
 			break;
 
+		if (current->flags & PF_FREEZE) {
+			refrigerator(0);
+			continue;
+		}
+
 		while ((skb = skb_dequeue(&hpsbpkt_queue)) != NULL) {
 			packet = (struct hpsb_packet *)skb->data;
 
--- clean/drivers/ieee1394/nodemgr.c	2004-05-20 23:08:14.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2004-06-06 19:34:56.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/moduleparam.h>
+#include <linux/suspend.h>
 #include <asm/atomic.h>
 
 #include "ieee1394_types.h"
@@ -1474,11 +1475,20 @@
 
 	/* Sit and wait for a signal to probe the nodes on the bus. This
 	 * happens when we get a bus reset. */
-	while (!down_interruptible(&hi->reset_sem) &&
-	       !down_interruptible(&nodemgr_serialize)) {
+	while (1) {
 		unsigned int generation = 0;
 		int i;
 
+		if (down_interruptible(&hi->reset_sem) ||
+		    down_interruptible(&nodemgr_serialize)) {
+			if (current->flags & PF_FREEZE) {
+				refrigerator(0);
+				continue;
+			}
+			printk("nodemgr: received unexpected signal?!\n" );
+			break;
+		}
+
 		if (hi->kill_me)
 			break;
 
@@ -1532,6 +1542,7 @@
 
 		up(&nodemgr_serialize);
 	}
+	printk("nodemgr: Exiting due to no down\n");
 
 caught_signal:
 	HPSB_VERBOSE("NodeMgr: Exiting thread");

-- 
934a471f20d6580d5aad759bf0d97ddc
