Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316869AbSF0QLI>; Thu, 27 Jun 2002 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSF0QLH>; Thu, 27 Jun 2002 12:11:07 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3459 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316869AbSF0QKq>;
	Thu, 27 Jun 2002 12:10:46 -0400
From: "Denis M. Yarkovoy" <dyarkovoy@distar.com.ua>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: code in ppp_generic.c leads to occasional instability of ppp connections
Date: Thu, 27 Jun 2002 19:12:27 +0300
Message-ID: <CJEKJCHIIMBEGKKNAOABCEDPCAAA.dyarkovoy@distar.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] code in ppp_generic.c leads to occasional instability of ppp
connections
[2.] sometimes, when several pppX devices are up simultaneously and ppp
traffic is quite high, ppp peers suddenly loose communication, while pppX
device is still up and no diagnostic message is provided in log files.
Having investigated the problem, i somewhat fixed it, although i'm not sure
this fix doesn't break anything in turn...
[3.] ppp_generic, kernel, module, ppp, networking
[4.] 2.4.18-6mdk
[5.] N/A
[6.] N/A
[7.] PPPD ver. 2.4.1 (although, IMHO bug is not in PPPD)
[7.1-5.] information is not related to the problem
[X.] The cause of the problem and my fix (most definitely incorrect, but
working ;) is in the ppp_xmit_process() routine of ppp_generic.c. The
problem is, that this routine MUST CALL netif_wake_queue() unconditionally
(or under some condition, other that specified), otherwise device queue
becomes locked FOREVER, as noone else in PPP driver wants to wake it up.
To my knowledge, what happens is once network load becomes to high,
ppp_xmit_process() is called while ppp->xmit_pending is not 0 (ppp device
still has something to send). at this time device queue is locked (it was
locked above in the ppp_start_xmit() by netif_stop_queue()). since there is
a condition to netif_wake_queue()call which checks ppp->xmit_pending before
calling netif_wake_queue(), it doesn't get called, and, consequently, ANY
NEW SKB THAT IS PUT ON A DEVICE QUEUE IS NOT PROCESSED, because of the code
in dev_queue_xmit() /dev.c/ that calls qdisc_run() /pkt_sched.h/, that, in
turn, will NEVER CALL qdisc_restart() (which actually dequeues and tries to
send queued packet), and, therefore, will leave the device queue to grow to
its limit - presently 4 entries which NEVER ACTUALLY GET SENT OVER THE
PHYSICAL INTERFACE.
Therefore, I changed the code in ppp_xmit_process() in a way, that
netif_wake_queue() will be called regardless of the ppp->xmit_pending and
other conditions, and IT WORKED! although i sometimes experience strange
behavior of ping replies, but that's the price i'm willing to pay for
everything else working alright.

