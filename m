Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVCAHv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVCAHv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 02:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVCAHv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 02:51:27 -0500
Received: from h155.mvista.com ([12.44.186.155]:25220 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S261276AbVCAHvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 02:51:25 -0500
Subject: [patch] Fix e1000 driver disable interrupts bug for
	realtime-preempt-2.6.11-rc4-V0.7.39-02
From: Yang Yi <yyang@ch.mvista.com>
Reply-To: yyang@ch.mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, Rt-Dev@Mvista.Com
Content-Type: text/plain
Organization: MontaVista China R&D Center
Message-Id: <1109663530.18759.207.camel@montavista2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Mar 2005 15:52:10 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,Ingo

this patch fixes e1000 driver disable interrupt bug when enabling
"Complete Preemption (Realtime)".

Type: Defect Fix
Disposition: submitted to LKML
Signed-off-by: Yi Yang <yyang@ch.mvista.com>
Description: When enabling Complete Real-time Preemption, e1000 driver
always disables interrupts while calling e1000_xmit_frame, this will
lead to some serious problem, for example, the time will be skewed
because timer interrupt is also disabled, it also leads to network
packet missed, netperf's result indicates that thing is very very bad.
As a matter of fact, the reason is that
spin_unlock_irqrestore(&adapter->tx_lock) won't restore flags under the
Complete Preemption (Realtime) case, according to Real-time Preemption
regular, spin_lock_irqsave(&adapter->tx_lock) also dosen't disable
interrupts, so, local_irq_save and local_irq_restore should be changed
into local_irq_save_nort and local_irq_restore_nort, respectively.

--- a/drivers/net/e1000/e1000_main.c    2005-03-01 11:04:53.000000000
+0800
+++ b/drivers/net/e1000/e1000_main.c    2005-03-01 13:46:40.000000000
+0800
@@ -1802,10 +1802,10 @@ e1000_xmit_frame(struct sk_buff *skb, st
        if(adapter->pcix_82544)
                count += nr_frags;

-       local_irq_save(flags);
+       local_irq_save_nort(flags);
        if (!spin_trylock(&adapter->tx_lock)) {
                /* Collision - tell upper layer to requeue */
-               local_irq_restore(flags);
+               local_irq_restore_nort(flags);
                return NETDEV_TX_LOCKED;
        }

