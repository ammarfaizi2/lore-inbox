Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWFFQmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWFFQmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWFFQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:42:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:10474 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750780AbWFFQmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:42:06 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4485AFB9.3040005@s5r6.in-berlin.de>
Date: Tue, 06 Jun 2006 18:39:21 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3-lockdep -
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu> <44852819.2080503@gmail.com> <4485798B.4030007@s5r6.in-berlin.de>
In-Reply-To: <4485798B.4030007@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.272) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Valdis.Kletnieks@vt.edu napsal(a):
...
>>>[  464.687000] [ BUG: illegal lock usage! ]
>>>[  464.687000] ----------------------------
>>>[  464.687000] illegal {in-hardirq-W} -> {hardirq-on-W} usage.
>>>[  464.687000] id/2700 [HC0[0]:SC0[1]:HE1:SE0] takes:
>>>[  464.687000]  (&list->lock){++..}, at: [<c0351a07>] unix_stream_connect+0x334/0x408
>>>[  464.687000] {in-hardirq-W} state was registered at:
>>>[  464.687000]   [<c012dd45>] lockdep_acquire+0x67/0x7f
>>>[  464.687000]   [<c0383f11>] _spin_lock_irqsave+0x30/0x3f
>>>[  464.687000]   [<c02fa93f>] skb_dequeue+0x18/0x49
>>>[  464.687000]   [<f086b7f1>] hpsb_bus_reset+0x5e/0xa2 [ieee1394]
>>>[  464.687000]   [<f0887007>] ohci_irq_handler+0x370/0x726 [ohci1394]
>>>[  464.687000]   [<c013f9a8>] handle_IRQ_event+0x1d/0x52
>>>[  464.687000]   [<c0140bc4>] handle_level_irq+0x97/0xe3
>>>[  464.687000]   [<c01045d0>] do_IRQ+0x8b/0xaf
>>>[  464.687000] irq event stamp: 2964
>>>[  464.687000] hardirqs last  enabled at (2963): [<c0384223>] _spin_unlock_irqrestore+0x3b/0x6d
>>>[  464.687000] hardirqs last disabled at (2962): [<c0383ef5>] _spin_lock_irqsave+0x14/0x3f
>>>[  464.687000] softirqs last  enabled at (2956): [<c0119da0>] __do_softirq+0x9d/0xa5
>>>[  464.687000] softirqs last disabled at (2964): [<c0383f6b>] _spin_lock_bh+0x10/0x3a
>>>[  464.687000] 
>>>[  464.687000] other info that might help us debug this:
>>>[  464.687000] 1 locks held by id/2700:
>>>[  464.687000]  #0:  (&u->lock){--..}, at: [<c03517bb>] unix_stream_connect+0xe8/0x408
>>>[  464.687000] 
>>>[  464.687000] stack backtrace:
>>>[  464.687000]  [<c01032d6>] show_trace_log_lvl+0x64/0x125
>>>[  464.687000]  [<c0103865>] show_trace+0x1b/0x20
>>>[  464.687000]  [<c010391c>] dump_stack+0x1f/0x24
>>>[  464.687000]  [<c012bfb1>] print_usage_bug+0x1a8/0x1b4
>>>[  464.687000]  [<c012c6c7>] mark_lock+0x2ba/0x4e5
>>>[  464.687000]  [<c012d2b8>] __lockdep_acquire+0x476/0xa91
>>>[  464.687000]  [<c012dd45>] lockdep_acquire+0x67/0x7f
>>>[  464.687000]  [<c0383f87>] _spin_lock_bh+0x2c/0x3a
>>>[  464.687000]  [<c0351a07>] unix_stream_connect+0x334/0x408
>>>[  464.687000]  [<c02f7236>] sys_connect+0x6e/0xa3
>>>[  464.687000]  [<c02f79da>] sys_socketcall+0x96/0x190
>>>[  464.687000]  [<c03845e2>] sysenter_past_esp+0x63/0xa1

On second look it doesn't seem to be a problem of the ieee1394 stack but 
rather of underlying skb and net infrastructure.

BTW, the locking in -mm's net/unix/af_unix.c::unix_stream_connect() 
differs a bit from stock unix_stream_connect(). I see spin_lock_bh() in 
2.6.17-rc5-mm3 where 2.6.17-rc5 has spin_lock().

(added Cc: netdev)
-- 
Stefan Richter
-=====-=-==- -==- --==-
http://arcgraph.de/sr/
