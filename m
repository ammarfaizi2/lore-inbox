Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbTDQGtr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 02:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTDQGtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 02:49:47 -0400
Received: from isis.cs3-inc.com ([207.224.119.73]:23798 "EHLO isis.cs3-inc.com")
	by vger.kernel.org with ESMTP id S263103AbTDQGtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 02:49:45 -0400
Date: Wed, 16 Apr 2003 23:56:45 -0700
Message-Id: <200304170656.h3H6ujA28940@isis.cs3-inc.com>
From: don-linux@isis.cs3-inc.com (Don Cohen)
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: proposed optimization for network drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I notice that netif_rx (net/core/dev.c) discards packets when it's
in throttle mode.  However, before it does this the driver has already
wasted a lot of time allocating the skb, calling eth_type_trans, etc.
That effort could be saved if the driver checked throttle first.


Sample diff:

--- /usr/src/linux-2.4.18-clean/drivers/net/8139too.c   Mon Feb 25 11:37:59 2002
+++ /usr/src/linux-2.4.18/drivers/net/8139too.c Wed Apr 16 23:30:30 2003
@@ -1908,6 +1908,11 @@
                        return;
                }

+               if (softnet_data[smp_processor_id()].throttle) {
+                 dev->last_rx = jiffies;
+                 netdev_rx_stat[smp_processor_id()].dropped++;
+               } else {
+
                /* Malloc up new buffer, compatible with net-2e. */
                /* Omit the four octet CRC from the length. */

@@ -1936,6 +1941,7 @@
                                dev->name);
                        tp->stats.rx_dropped++;
                }
+               }

                cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
                RTL_W16 (RxBufPtr, cur_rx - 16);

Hmm, now that I notice, there is one small change in semantics here.
Before every packet that was counted by netdev_rx_stat[].dropped had
also been counted in stats.rx_bytes and rx_packets and this is no
longer the case.  If that bothers you then perhaps there should just
be a separate counter for packets dropped like this.

In my limited experimentation this sort of change has significantly
increased the number of packets I could process when they were
arriving too fast. 

Please cc me on replies.
