Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267206AbUBSLkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 06:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267208AbUBSLkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 06:40:07 -0500
Received: from ehv-stm-62a7.mxs.adsl.euronet.nl ([62.234.130.167]:21954 "HELO
	mail.galettepress.nl") by vger.kernel.org with SMTP id S267206AbUBSLkB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 06:40:01 -0500
From: "Alex Scheele" <alex@ccbeheer.nl>
To: <linux-kernel@vger.kernel.org>
Cc: <rhl@traceroute.dk>
Subject: Re: e1000 (on-board CSA) lockup with 2.6.3 on ifconfig
Date: Thu, 19 Feb 2004 12:38:35 +0100
Message-ID: <000001c3f6dc$ed8ee9b0$3364a8c0@lapas>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The lockup is probably caused by a patch that made it in the tree 
which adds an interrupt disable/enable to keep interrupt assertion 
state synced between 82547 and APIC. This patch was in the tree before 
but was reverted a while back because it locked up 82547 CSA-based LOMs. 
Apparently it made it back in. Below I have inserted a patch (against 2.6.3)
which 
removes it again. Feel free to test if it stops the lockups.


Regards,

Alex Scheele



--- e1000_main.c        2004-02-18 04:57:26.000000000 +0100
+++ e1000_main_new.c    2004-02-19 12:28:15.000000000 +0100
@@ -2124,26 +2124,10 @@
                __netif_rx_schedule(netdev);
        }
 #else
-        /* Writing IMC and IMS is needed for 82547.
-          Due to Hub Link bus being occupied, an interrupt
-          de-assertion message is not able to be sent.
-          When an interrupt assertion message is generated later,
-          two messages are re-ordered and sent out.
-          That causes APIC to think 82547 is in de-assertion
-          state, while 82547 is in assertion state, resulting
-          in dead lock. Writing IMC forces 82547 into
-          de-assertion state.
-        */
-       if(hw->mac_type == e1000_82547 || hw->mac_type == e1000_82547_rev_2)
-               e1000_irq_disable(adapter);
-
        for(i = 0; i < E1000_MAX_INTR; i++)
                if(!e1000_clean_rx_irq(adapter) &
                   !e1000_clean_tx_irq(adapter))
                        break;
-
-       if(hw->mac_type == e1000_82547 || hw->mac_type == e1000_82547_rev_2)
-               e1000_irq_enable(adapter);
 #endif

        return IRQ_HANDLED;


