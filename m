Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270227AbUJSX5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270227AbUJSX5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270225AbUJSX5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:57:25 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6278 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270227AbUJSX4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:56:15 -0400
Subject: [PATCH] Make netif_rx_ni preempt-safe
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, herbert@gondor.apana.org.au,
       vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
       maxk@qualcomm.com, irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
Content-Type: text/plain
Message-Id: <1098230132.23628.28.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 19:55:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes netif_rx_ni() preempt-safe.  The problem was reported
by Alain Schroeder.  Here are the users:

drivers/s390/net/ctcmain.c
drivers/s390/net/netiucv.c
drivers/net/irda/vlsi_ir.c
drivers/net/tun.c

As David S. Miller explained, the do_softirq (and therefore the preempt
dis/enable) is required because there is no softirq check on the return
path when netif_rx is called from non-interrupt context.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- include/linux/netdevice.h~	2004-10-19 18:50:18.000000000 -0400
+++ include/linux/netdevice.h	2004-10-19 18:51:01.000000000 -0400
@@ -696,9 +696,11 @@
  */
 static inline int netif_rx_ni(struct sk_buff *skb)
 {
+       preempt_disable();
        int err = netif_rx(skb);
        if (softirq_pending(smp_processor_id()))
                do_softirq();
+       preempt_enable();
        return err;
 }
 


