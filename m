Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267747AbSLTIY4>; Fri, 20 Dec 2002 03:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267748AbSLTIY4>; Fri, 20 Dec 2002 03:24:56 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55194 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267747AbSLTIYy>; Fri, 20 Dec 2002 03:24:54 -0500
Date: Fri, 20 Dec 2002 03:32:58 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: jgarzik@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch for e100 on my z505je
Message-ID: <20021220033258.A771@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I tried Marcelo's 2.4.21-pre2 and the driver fails the self-test,
then dies in an unserviced interrupt storm. An obvious patch
seems to fix the problem here.

Amazingly enough, the driver works in RH 2.4.18-14 (e100 2.1.6-k1),
but if I take the same 2.1.6-k1 and implant it into Marcelo tree,
everything dies as before. Something is fishy here.

-- Pete

diff -urN -X dontdiff linux-2.4.21-pre2/drivers/net/e100/e100_main.c linux-2.4.21-pre2-usb/drivers/net/e100/e100_main.c
--- linux-2.4.21-pre2/drivers/net/e100/e100_main.c	2002-12-19 19:50:58.000000000 -0800
+++ linux-2.4.21-pre2-usb/drivers/net/e100/e100_main.c	2002-12-20 00:07:36.000000000 -0800
@@ -2288,6 +2288,8 @@
 
 	/* initialize the nic state before running test */
 	e100_sw_reset(bdp, PORT_SOFTWARE_RESET);
+	e100_dis_intr(bdp);
+
 	/* Setup the address of the self_test area */
 	selftest_cmd = bdp->selftest_phys;
 
@@ -2302,9 +2304,9 @@
 	writel(selftest_cmd, &bdp->scb->scb_port);
 	readw(&(bdp->scb->scb_status));	/* flushes last write, read-safe */
 
-	/* Wait at least 10 milliseconds for the self-test to complete */
+	/* Wait at least 20 milliseconds for the self-test to complete */
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ / 100 + 1);
+	schedule_timeout(HZ / 50 + 1);
 
 	/* disable interrupts since the're now enabled */
 	e100_dis_intr(bdp);
