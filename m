Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbTI2MJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 08:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263218AbTI2MJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 08:09:41 -0400
Received: from guard.arkoon.net ([62.161.237.193]:60937 "EHLO
	akguard.arkoon.net") by vger.kernel.org with ESMTP id S263213AbTI2MJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 08:09:39 -0400
X-Lotus-FromDomain: ARKOON
From: dfages@arkoon.net
To: linux-kernel@vger.kernel.org
Message-ID: <C1256DB0.0042BC40.00@arkoon-mail.arkoon.net>
Date: Mon, 29 Sep 2003 14:08:54 +0200
Subject: [BUG/PATCH] CONFIG_NET_HW_FLOWCONTROL and SMP
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
by testing the CONFIG_NET_HW_FLOWCONTROL (NIC Hardware throttling) on
a SMP system, I found a bug in net/core/dev.c : the netdev_dropping
variable can be set to a negative value (the result is that a CPU can
be locked in "throttle" state).
This bug seems to exist in 2.4 and in 2.6 kernels.

Here's a typical scenario :

- Throttling --> (CPU 0)queue->throttle==1 && (CPU 1)queue->throttle==1
     && netdev_dropping == 2
- 1st packet Unthrottle ( in net_rx_action() ), received by CPU 0
     --> (CPU 0)queue->throttle==1 && (CPU 1)queue->throttle==1
     && netdev_dropping == 1
- 2nd packet Unthrottle ( in net_rx_action() ), received by CPU 0
     --> (CPU 0)queue->throttle==0 && (CPU 1)queue->throttle==1
     && netdev_dropping == 0
- 3nd packet Unthrottle ( in net_rx_action() ), received by CPU 1
     --> (CPU 0)queue->throttle==0 && (CPU 1)queue->throttle==0
     && netdev_dropping == -1

and so on...

The problem is that the (CPU)queue->throttle should be set to zero every
time the netdev_dropping variable is decremented.


Here's a patch for the 2.4.19 kernel (tested with success) :

--- linux-2.4.19/net/core/dev.c.orig     Mon Sep 29 12:49:14 2003
+++ linux-2.4.19/net/core/dev.c    Tue Sep 23 18:35:35 2003
@@ -1519,8 +1519,8 @@

 #ifdef CONFIG_NET_HW_FLOWCONTROL
     if (queue->throttle && queue->input_pkt_queue.qlen < no_cong_thresh ) {
+         queue->throttle = 0;
          if (atomic_dec_and_test(&netdev_dropping)) {
-              queue->throttle = 0;
               netdev_wakeup();
               goto softnet_break;
          }




I haven't done a patch for 2.4.22 (as we currently use 2.4.19) but the same
modification should be applied around lines 1572 to 1577 of net/core/dev.c

For 2.6.0-test5, the lines to modified are arount 1631 to 1637.

Regards,
---
Daniel FAGES
ARKOON Network Security    http://www.arkoon.net


