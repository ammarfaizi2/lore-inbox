Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbUKPShj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbUKPShj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUKPShj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:37:39 -0500
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:48077
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S262082AbUKPSei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:34:38 -0500
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: pthread_cond_signal not waking thread
Date: Tue, 16 Nov 2004 13:34:23 -0500
Message-ID: <OMEGLKPBDPDHAGCIBHHJMEILFHAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20041116104821.GA31395@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Below is a sysrq-t dump (relevant process is called "tt1"), and a post I sent to ACE user group describing a situation I am seeing
where a pthread_cond_signal() call sometimes does not wake up the thread waiting on the condition variable, despite a call to
sched_yield() following the pthread_cond_signal().  All threads are running at equal priorities under SCHED_RR.

Simply put, it appears that despite thousands of calls to pthread_cond_signal() and sched_yeild() from another SCHED_RR thread, as
evidenced by s->count_ == 4088, the thread waiting on the condition variable never wakes up.

It *does* wake up sometime later, if the application starts a new thread.  It also gets unstuck on breaking in gdb and continuing.

Any comments?

A.





 SysRq : Show State

                                                sibling
   task             PC      pid father child younger older
 init          S 00000000  4840     1      0     2               (NOTLB)
 c1531ea4 00000086 0000015e 00000000 c1531eb4 c014591b 00000282 c0174ed5
        df6de1a0 00000000 00000282 c1531ea4 c1412020 00000000 ce6eaa80 0010b6b7
        dff4ab8c 18690d62 c1531eb8 0000000b c1531ef0 c02fef3b dfddeec0 00000286
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 migration/0   S CC09BF64  7724     2      1             3       (L-TLB)
 c1535fa0 00000046 00000001 cc09bf64 c1535f84 c011e807 00000000 cc09bf64
        dfaa2360 0112efc0 0010b68e dffeda60 c140a020 00000000 0112efc0 0010b68e
        dff4a18c c140a964 c140a020 c1534000 c1535fc8 c011f92c c140a020 00000000
 Call Trace:
  [<c011f92c>] migration_thread+0x11c/0x180
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 ksoftirqd/0   S C1536000  7476     3      1             4     2 (L-TLB)
 c1537fb4 00000046 00000000 c1536000 c1537f8c c0127be0 c03dca6c 00000001
        c1708d20 c03ddb40 c1537fa8 c01278a8 c140a020 00000000 c3225940 0010b669
        dff4fbac c1536000 c1536000 ffffe000 c1537fc8 c0127e87 c1536000 c1531f64
 Call Trace:
  [<c0127e87>] ksoftirqd+0xc7/0xe0
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 migration/1   S 00000000  7580     4      1             5     3 (L-TLB)
 c1539fa0 00000046 00000000 00000000 00000000 90157940 c1539f84 db5fdf64
        d0f093e0 00000003 db5fdf58 cbda85a0 c1412020 00000000 90157940 0010b6b6
        dff4f6ac c1412964 c1412020 c1538000 c1539fc8 c011f92c c140a020 00000000
 Call Trace:
  [<c011f92c>] migration_thread+0x11c/0x180
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 ksoftirqd/1   S DFF0A000  7384     5      1             6     4 (L-TLB)
 dff0bfb4 00000046 00000000 dff0a000 dff0bf8c c0127be0 c03dca6c 00000001
        c1708d20 c03ddb40 dff0bfa8 c01278a8 c1412020 000186a0 31b2e740 0010b669
        dff4f1ac dff0a000 dff0a000 ffffe000 dff0bfc8 c0127e87 dff0a000 c1531f24
 Call Trace:
  [<c0127e87>] ksoftirqd+0xc7/0xe0
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 events/0      S C1514000  6276     6      1     8       7     5 (L-TLB)
 dff11f48 00000046 c140bba0 c1514000 000007d0 c1514030 00000001 00000003
        c173a300 00000000 00000286 dff11f48 c140a020 00000000 6306d3c0 0010b6b8
        dffedbcc c1514018 c1514000 dff11f9c dff11fc8 c013247d 00000000 c140a020
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 events/1      S C1514000  6888     7      1    89      98     6 (L-TLB)
 dff13f48 00000046 c1413ba0 c1514000 000007d1 c15140b0 00000001 00000003
        dfaa25c0 00000000 00000286 dff13f48 c1412020 00000000 a51190c0 0010b6b8
        dffed6cc c1514098 c1514080 dff13f9c dff13fc8 c013247d 00000000 dff4aa20
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 khelper       S DDC09DE4  7192     8      6            21       (L-TLB)
 dff6bf48 00000046 00000001 ddc09de4 dff6bf2c dffeb830 00000001 00000003
        dcf0e580 00000000 00000286 df50ca40 c140a020 00000000 9dfa5b00 000f4210
        dffed1cc dffeb818 dffeb800 dff6bf9c dff6bfc8 c013247d 00000000 dffeda60
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 kacpid        S 00000000  7736    21      6           152     8 (L-TLB)
 dfcf1f48 00000046 00000000 00000000 00000000 00000000 00000001 00010000
        dfe5cc60 dffc70a0 00000286 dfcf1f48 c1412020 00000000 48764600 000f41fa
        dffc720c dffb5018 dffb5000 dfcf1f9c dfcf1fc8 c013247d dfcf1f5c c012c004
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 kblockd/0     S DF47B110  7264    89      7            90       (L-TLB)
 dff93f48 00000046 e083e0c0 df47b110 dff93f28 dff89830 00000001 00000003
        dfaa25c0 00000000 00000286 dff93f48 c140a020 00000000 8e5af800 0010b6b6
        dfd111cc dff89818 dff89800 dff93f9c dff93fc8 c013247d 00000000 c1412020
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 kblockd/1     S DF47B110  7300    90      7                  89 (L-TLB)
 dfe37f48 00000046 e083e0c0 df47b110 dfe37f28 dff898b0 00000001 00000003
        dcf0e0c0 00000000 00000286 dfe37f48 c1412020 00000000 c7c12ec0 0010b6b6
        dfd1c1ec dff89898 dff89880 dfe37f9c dfe37fc8 c013247d 00000000 dffed560
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 khubd         S C01094ED  7520    98      1           154     7 (L-TLB)
 dfe33f90 00000046 dfe33f5c c01094ed 00000000 dfe33f64 dfe33fc0 dfe33fec
        df8b8320 00000282 00000000 dfd2cac0 c140a020 000f4240 ebde1980 000f4209
        dfd1cbec dfe33fc0 ffffe000 dfe32000 dfe33fec c0272c3e c0325f7a dfe32000
 Call Trace:
  [<c0272c3e>] hub_thread+0xbe/0x110
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 pdflush       S 00009456  7424   152      6           153    21 (L-TLB)
 dff91f88 00000046 00000000 00009456 00000025 00000000 00000000 00000000
        df90d400 00000000 00000000 dfd245a0 c140a020 00000000 c7b33940 0010a1b3
        dfd116cc dff90000 dff91fb4 dff91fa8 dff91fa0 c0147743 00000286 dff90000
 Call Trace:
  [<c0147743>] __pdflush+0x83/0x1b0
  [<c014788e>] pdflush+0x1e/0x30
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 pdflush       S DFD81F38  6260   153      6           155   152 (L-TLB)
 dfd81f88 00000046 00000000 dfd81f38 00000208 0000013e 00000000 00000000
        dcf0ea40 00000000 00000005 df568020 c140a020 00061a80 b8702c40 0010b6b7
        dfd2470c dfd80000 dfd81fb4 dfd81fa8 dfd81fa0 c0147743 00000286 dfd80000
 Call Trace:
  [<c0147743>] __pdflush+0x83/0x1b0
  [<c014788e>] pdflush+0x1e/0x30
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 aio/0         S 00000000  7856   155      6           156   153 (L-TLB)
 dfd6ff48 00000046 00000000 00000000 00000000 00000000 00000001 00010000
        dffe92a0 dfd24aa0 00000286 dfd2c5c0 c140a020 00000000 4ee63900 000f41fa
        dfd24c0c dfd6a818 dfd6a800 dfd6ff9c dfd6ffc8 c013247d dffedc40 dffeda60
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 aio/1         S DFD9C000  7856   156      6                 155 (
 dfd9df48 00000046 dfd6a880 dfd9c000 dfd9df14 c011721f dfd9c000 00010000
        dfe27780 dfd2c5c0 00000286 dfcfa040 c1412020 00000000 4ee63900 000f41fa
        dfd2c72c dfd6a898 dfd6a880 dfd9df9c dfd9dfc8 c013247d dffedc40 dffeda60
 Call Trace:
  [<c013247d>] worker_thread+0x1ed/0x210
  [<c0136695>] kthread+0xa5/0xb0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 kswapd0       S 00000000  6412   154      1           245    98 (L-TLB)
 dfd0bf88 00000046 00000202 00000000 dfd0bf9c 00000000 0000000c 00000001
        c1708d20 00000286 00000040 0000001c c140a020 0003640e c2e55040 0010b669
        dfcfa6ac dfd0a000 dfd0bfc0 c034ffd0 dfd0bfec c014d6eb c0315bd8 00000000
 Call Trace:
  [<c014d6eb>] kswapd+0xbb/0xf0
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 kseriod       S 00000000  7808   245      1           358   154 (L-TLB)
 dfb19f90 00000046 00000002 00000000 c034daa0 dfb18000 00000000 00000286
        dfad8a20 00000282 c0226830 00000286 c1412020 00000000 67eeea00 000f41fa
        dfad172c dfb19fc0 ffffe000 dfb18000 dfb19fec c02268ee c0322440 dfb18000
 Call Trace:
  [<c02268ee>] serio_thread+0xbe/0x120
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 kirqd         S 00000000  7072   358      1           379   245 (L-TLB)
 df01bf84 00000046 c0107a6c 00000000 0000003c 00000002 00000286 c03e3788
        dfaa25c0 00000000 00000286 df01bf84 c1412020 00000000 2be47280 0010b6b8
        df77124c 18691382 df01bf98 1868fffa df01bfd0 c02fef3b c03e4968 00000016
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0118d70>] balanced_irq+0x50/0x80
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 scsi_eh_0     S 00000000  7856   379      1           380   358 (L-TLB)
 df01ff60 00000046 c140a020 00000000 00000086 df01ff74 c011cf0d 00000000
        df03c7a0 df0d0000 00000000 df7c0020 c140a020 00000000 be5ca840 000f41fb
        df7c068c df01ffcc df01ffc4 00000286 df01ffa4 c02fe2f8 df01e000 df01e000
 Call Trace:
  [<c02fe2f8>] __down_interruptible+0xa8/0x128
  [<c02fe396>] __down_failed_interruptible+0xa/0x10
  [<e083cfd2>] .text.lock.scsi_error+0x2d/0x3b [scsi_mod]
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 ahc_dv_0      S 00000000  7704   380      1           390   379 (L-TLB)
 dfb2bf7c 00000046 df7d5e00 00000000 df137800 dfb2bf50 c023cff7 df47b06c
        df77a760 0ed604c0 000f4200 dff4fa40 c140a020 00000000 0ed604c0 000f4200
        df53324c dfddd2dc dfddd2d4 00000286 dfb2bfc0 c02fe2f8 dfb2a000 dfb2a000
 Call Trace:
  [<c02fe2f8>] __down_interruptible+0xa8/0x128
  [<c02fe396>] __down_failed_interruptible+0xa/0x10
  [<e08a1558>] .text.lock.aic7xxx_osm+0x23/0x9b [aic7xxx]
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 scsi_eh_1     S 00000000  7856   390      1           391   380 (L-TLB)
 df1dbf60 00000046 c140a020 00000000 00000086 df1dbf74 c011cf0d 00000000
        df03c7a0 df0d0000 00000000 df7c0020 c140a020 00000000 d82e3540 000f4200
        df568b8c df1dbfcc df1dbfc4 00000286 df1dbfa4 c02fe2f8 df1da000 df1da000
 Call Trace:
  [<c02fe2f8>] __down_interruptible+0xa8/0x128
  [<c02fe396>] __down_failed_interruptible+0xa/0x10
  [<e083cfd2>] .text.lock.scsi_error+0x2d/0x3b [scsi_mod]
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 ahc_dv_1      S 00000000  7704   391      1           399   390 (L-TLB)
 df1d5f7c 00000046 df7efe00 00000000 df54ec00 df1d5f50 c023cff7 df47b36c
        df03c7a0 3b6e1680 000f4205 dff4fa40 c140a020 00000000 3b6e1680 000f4205
        dfd11bcc df7d3edc df7d3ed4 00000286 df1d5fc0 c02fe2f8 df1d4000 df1d4000
 Call Trace:
  [<c02fe2f8>] __down_interruptible+0xa8/0x128
  [<c02fe396>] __down_failed_interruptible+0xa/0x10
  [<e08a1558>] .text.lock.aic7xxx_osm+0x23/0x9b [aic7xxx]
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 kjournald     D DF137000  5928   399      1           437   391 (L-TLB)
 dffcdd08 00000046 00000000 df137000 dffcdcf4 e083e0c0 dffcdd74 dffcdcf4
        d0f09180 c0236519 df137194 cf9070c0 c140a020 00000000 ccd32d80 0010b6b8
        df7c018c c140a020 00000000 dffcdd74 dffcdd14 c02fee48 dffcdd6c dffcdd1c
 Call Trace:
  [<c02fee48>] io_schedule+0x28/0x40
  [<c015f360>] sync_buffer+0x30/0x40
  [<c02ff085>] __wait_on_bit+0x65/0x70
  [<c02ff10f>] out_of_line_wait_on_bit+0x7f/0x90
  [<c015f400>] __wait_on_buffer+0x30/0x40
  [<e085803b>] journal_commit_transaction+0x126b/0x1540 [jbd]
  [<e085a87b>] kjournald+0xdb/0x260 [jbd]
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 udevd         S 00000000  7032   437      1          1777   399 (NOTLB)
 df8abea4 00000082 0000015e 00000000 df8abeb4 c014591b df681f30 df8abe7c
        df90db20 df681a60 00000286 df681a60 c1412020 00000000 a2bf8ec0 000f4211
        c161a6cc 00000000 7fffffff 00000006 df8abef0 c02fef89 00000282 00000286
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 kjournald     S 00000286  6492  1777      1          2569   437 (L-TLB)
 df2a7f50 00000046 0000370c 00000286 df2a7f28 dfac506c 00000001 00000003
        dfaa25c0 00000286 00000001 df2a7f50 c1412020 00000000 e6579e80 00109809
        df14f70c dfac5000 00000000 00000001 df2a7fec e085a9ee 00000000 00000005
 Call Trace:
  [<e085a9ee>] kjournald+0x24e/0x260 [jbd]
  [<c01052d5>] kernel_thread_helper+0x5/0x10
 irqbalance    S DECE7F70  6340  2569      1          2587  1777 (NOTLB)
 dece7f44 00000086 c1409400 dece7f70 b7fff000 c50ff2c4 00000282 c014efb4
        dfdd0c60 00000000 00000282 dece7f44 c140a020 0001b207 796f2240 0010b6b6
        df7c0b8c 18690a94 dece7f58 000f41a7 dece7f90 c02fef3b bffffa78 dece7f70
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c012bc4e>] sys_nanosleep+0xce/0x150
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 portmap       S 00000001  6780  2587      1          2629  2569 (NOTLB)
 deb61f08 00000082 deb61eec 00000001 00000001 00000000 df450080 00000010
        df9cf120 00000000 000000d0 df3a4028 c140a020 000f4240 dccc1f00 000f420e
        df4501ec 00000000 7fffffff 7fffffff deb61f54 c02fef89 dff8dce8 df75b3c0
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c01715bc>] do_poll+0x9c/0xc0
  [<c0171709>] sys_poll+0x129/0x210
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 rpc.idmapd    S 20000000  6568  2629      1          2688  2587 (NOTLB)
 df3b9f08 00000082 c01400ba 20000000 00000001 00000002 00000286 c03e3788
        dfaa2ce0 00000000 00000286 df3b9f08 c140a020 00000000 b9bfddc0 0010b6b7
        dfd2cc2c 18690c07 df3b9f1c 00001388 df3b9f54 c02fef3b df3b9f1c c012b9ef
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0184dd2>] ep_poll+0x112/0x160
  [<c0183fb8>] sys_epoll_wait+0x98/0xa0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 smartd        S BFFFF8E0  6804  2688      1          2698  2629 (NOTLB)
 de82df44 00000082 00000010 bffff8e0 bffff860 bffff840 00000282 00000000
        dfdd0540 00000000 00000282 de82df44 c1412020 00000000 3dff6f80 0010b5bc
        dde321ec 1873f5a1 de82df58 000f41a7 de82df90 c02fef3b bffff890 de82df70
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c012bc4e>] sys_nanosleep+0xce/0x150
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 acpid         S C034F280  6648  2698      1          2751  2688 (NOTLB)
 deff7ea4 00000086 00000000 c034f280 0000015e 00000000 deff7ebc c014591b
        df829ac0 dd6a0d44 deff7eec dd6a0cd4 c140a020 000f4240 3e8c8900 000f420f
        c161a1cc 00000000 7fffffff 00000005 deff7ef0 c02fef89 00000282 000000d0
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 sshd          S 00000000  6540  2751      1 27898    2762  2698 (NOTLB)
 de1edea4 00000086 dff8d2c0 00000000 de1ede88 00000001 00000001 00000000
        df312500 00000010 c034ff80 00000000 c140a020 002dc6c0 01775fc0 00107aaa
        dfd2c22c 00000000 7fffffff 00000004 de1edef0 c02fef89 c0136920 e1017240
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 xinetd        S 00000000  6580  2762      1          2810  2751 (NOTLB)
 de337ea4 00000082 0000015e 00000000 de337eb4 c014591b de337e6c de337e6c
        dfaa2a80 8002bd68 de337ea8 dfb88ae0 c140a020 00000000 10b70680 000f4210
        df6811cc 00000000 7fffffff 00000004 de337ef0 c02fef89 c16d7c40 00000286
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 gpm           S C034F280  6580  2810      1          2820  2762 (NOTLB)
 c1641ea4 00000086 00000000 c034f280 0000015e 00000000 00000282 c014591b
        df6de660 00000000 00000282 c1641ea4 c140a020 00000000 7f922400 0010b414
        df808c2c 1d631410 c1641eb8 00000006 c1641ef0 c02fef3b 00000282 000000d0
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 crond         S DF944000  6648  2820      1          2839  2810 (NOTLB)
 df945f44 00000082 df568080 df944000 00000286 df945f94 00000282 bffffc78
        df6ded80 c6daa1c1 0010b6b6 c7472080 c140a020 0001e848 c6fad180 0010b6b6
        df56818c 1869cf18 df945f58 000f41a7 df945f90 c02fef3b bffff990 df945f70
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c012bc4e>] sys_nanosleep+0xce/0x150
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 atd           S DCF0D428  6580  2839      1          2869  2820 (NOTLB)
 de3e1f44 00000086 00000000 dcf0d428 df7d5600 419a4554 00000282 c017e08b
        df90d8c0 00000000 00000282 de3e1f44 c1412020 0001b207 44125080 0010b68f
        df80822c 186ae5c1 de3e1f58 000f41a7 de3e1f90 c02fef3b bffff9c0 de3e1f70
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c012bc4e>] sys_nanosleep+0xce/0x150
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 mingetty      S 00000000  7032  2869      1          2870  2839 (NOTLB)
 df93be54 00000086 0000003a 00000000 00000000 df1fbc78 00000282 00000246
        c1708ac0 df72d2b4 00000282 df5335e0 c1412020 000f4240 9b5af800 000f4210
        df41ac0c dd27f00c 7fffffff df93bf08 df93bea0 c02fef89 00000246 df72d2b6
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c020d022>] read_chan+0x632/0x770
  [<c020796b>] tty_read+0xdb/0x100
  [<c015e173>] vfs_read+0xc3/0x120
  [<c015e401>] sys_read+0x41/0x70
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 mingetty      S 00000000  7032  2870      1          2871  2869 (NOTLB)
 dc955e54 00000082 0000003a 00000000 00000000 df1fbc78 00000282 00000246
        df03c540 dfa182b4 00000282 df5335e0 c140a020 000f4240 9d063700 000f4210
        dfcfabac dcfc300c 7fffffff dc955f08 dc955ea0 c02fef89 00000246 dfa182b6
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c020d022>] read_chan+0x632/0x770
  [<c020796b>] tty_read+0xdb/0x100
  [<c015e173>] vfs_read+0xc3/0x120
  [<c015e401>] sys_read+0x41/0x70
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 mingetty      S 00000000  7032  2871      1          2872  2870 (NOTLB)
 ddd7be54 00000086 0000003a 00000000 00000000 df1fbc78 00000282 00000246
        dcf0eca0 8aaafc12 000f4210 dff4fa40 c140a020 000f4240 924ba200 000f4210
        dde32bec dc71000c 7fffffff ddd7bf08 ddd7bea0 c02fef89 00000246 dfa9b2b6
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c020d022>] read_chan+0x632/0x770
  [<c020796b>] tty_read+0xdb/0x100
  [<c015e173>] vfs_read+0xc3/0x120
  [<c015e401>] sys_read+0x41/0x70
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 mingetty      S 00000000  6580  2872      1          2873  2871 (NOTLB)
 ddd69e54 00000086 0000003a 00000000 00000000 df1fbc78 00000282 00000246
        c173a560 dfb442b4 00000282 dffc75a0 c140a020 00000000 90dd6c00 000f4210
        df41a70c dc5eb00c 7fffffff ddd69f08 ddd69ea0 c02fef89 00000246 dfb442b6
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c020d022>] read_chan+0x632/0x770
  [<c020796b>] tty_read+0xdb/0x100
  [<c015e173>] vfs_read+0xc3/0x120
  [<c015e401>] sys_read+0x41/0x70
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 mingetty      S 00000000  7032  2873      1          2874  2872 (NOTLB)
 ddc09e54 00000082 0000003a 00000000 00000000 df1fbc78 00000282 00000246
        dcf0e580 df9f62b4 00000282 dc15a5c0 c140a020 00000000 9eee7f00 000f4210
        df53374c dc56700c 7fffffff ddc09f08 ddc09ea0 c02fef89 00000246 df9f62b6
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c020d022>] read_chan+0x632/0x770
  [<c020796b>] tty_read+0xdb/0x100
  [<c015e173>] vfs_read+0xc3/0x120
  [<c015e401>] sys_read+0x41/0x70
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 monit         S DC72DF70  5560  2874      1          3085  2873 (NOTLB)
 dc72df44 00000086 c1409400 dc72df70 b6fe2000 dfdfc900 00000282 c014efb4
        c173a300 00000000 00000282 dc72df44 c140a020 0005b8d8 ba95fd00 0010b6b8
        dffc770c 18693067 dc72df58 000f41a7 dc72df90 c02fef3b bffffa80 dc72df70
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c012bc4e>] sys_nanosleep+0xce/0x150
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 monit         S DDCD3F70  6124  3085      1          3294  2874 (NOTLB)
 dc2d5ea4 00000086 00000000 ddcd3f70 00000000 00000001 00000282 00000000
        c173a300 00000000 00000282 dc2d5ea4 c140a020 00030d40 c105f000 0010b6b8
        df56868c 18690da8 dc2d5eb8 00000005 dc2d5ef0 c02fef3b c0136920 c0371d80
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 perl          S 00000000  6568  3294      1         10619  3085 (NOTLB)
 d677fea4 00000086 c16d7ce0 00000000 d677febc 00000001 00000282 00000000
        c1708860 00000000 00000282 d677fea4 c140a020 0001b207 e5424880 0010b6b6
        d6f0118c 186911a2 d677feb8 00000006 d677fef0 c02fef3b 00000282 c0371d80
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 bash          S C011CF0D  6880  3668      1  3709   10999 10628 (NOTLB)
 d3ab9f08 00000086 d3ab9f10 c011cf0d d40e0374 d38ae080 d3cfa000 00000001
        df3129c0 3332f240 000f5391 df771ae0 c1412020 00000000 3332f240 000f5391
        dfcfa1ac dfcfa0e4 0000000e fffffe00 d3ab9f94 c012663b bffff978 00000000
 Call Trace:
  [<c012663b>] do_wait+0x1ab/0x4a0
  [<c0126a00>] sys_wait4+0x30/0x40
  [<c0126a35>] sys_waitpid+0x25/0x29
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 bash          S C0150736  6496  3709   3668 17287               (NOTLB)
 d3cfbf08 00000086 d3cfbeec c0150736 d38d3ff8 d3e05bfc 1b663065 00000000
        df8293a0 df8fc60c 00000286 d6f01520 c140a020 00000000 04baec80 0010b6b7
        df771c4c df771b84 0000000e fffffe00 d3cfbf94 c012663b bffff278 00000000
 Call Trace:
  [<c012663b>] do_wait+0x1ab/0x4a0
  [<c0126a00>] sys_wait4+0x30/0x40
  [<c0126a35>] sys_waitpid+0x25/0x29
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 sendmail      S FFFFFFF4  6580 10619      1         10628  3294 (NOTLB)
 dcc47ea4 00000086 c0351de0 fffffff4 c1513ec0 00000001 00000282 00000000
        df3122a0 00000000 00000282 dcc47ea4 c1412020 00000000 a225e280 0010b6b8
        dfad1c2c 18691b42 dcc47eb8 00000005 dcc47ef0 c02fef3b c0136920 c0371d80
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 sendmail      S C010E2D7  6540 10628      1          3668 10619 (NOTLB)
 de8e7fb4 00000082 de8e7f7c c010e2d7 bfffcee8 00000000 de8e7f98 c0106555
        df829140 00330000 bfffcee0 dbf59aa0 c1412020 00000000 207f95c0 0010b431
        df6816cc 800b10a0 bfffd400 801244b8 de8e7fbc c012f4a7 de8e6000 c01070ad
 Call Trace:
  [<c012f4a7>] sys_pause+0x17/0x20
tor1 kernel: login         S DF3285B8  6344 10999      1 14178   28631  3668 (NOTLB)
 df553f20 00000082 dfdd00c0 df3285b8 dfdd0080 dfdd00ac df3285b8 df553fb4
        dfdd0080 00000001 00000286 00000001 c1412020 00000000 2b13ae00 000f79a3
        dfb88c4c dfb88b84 00000004 fffffe00 df553fac c012663b df552000 df553f38
 Call Trace:
  [<c012663b>] do_wait+0x1ab/0x4a0
  [<c0126a00>] sys_wait4+0x30/0x40
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 bash          S C5781E3C  6932 14178  10999                     (NOTLB)
 c5781e54 00000082 00000246 c5781e3c 00000286 00000000 00000282 00003fff
        df829d20 c0304ba0 00000282 c5781e48 c140a020 00000000 27f6f0c0 000f79bb
        dc797bcc df1f000c 7fffffff c5781f08 c5781ea0 c02fef89 00000800 00000001
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c020d022>] read_chan+0x632/0x770
  [<c020796b>] tty_read+0xdb/0x100
  [<c015e173>] vfs_read+0xc3/0x120
  [<c015e401>] sys_read+0x41/0x70
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 gdb           T DF703F90  7332 28631      1 28632   14265 10999 (NOTLB)
 d6fedeb4 00000086 df703f90 df703f90 00000000 df03c7a0 1bed1f80 000fb871
        df03c7a0 c140a020 00000000 1bed1f80 c1412020 00000000 1c0ba400 000fb871
        df4506ec d6fec000 d6feded0 00000105 d6fedec8 c012deb4 d6fec000 00000105
 Call Trace:
  [<c012deb4>] ptrace_stop+0x84/0xc0
  [<c012df6a>] ptrace_notify+0x7a/0xb0
  [<c0122022>] do_fork+0x132/0x199
  [<c0105c5f>] sys_clone+0x2f/0x40
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 gdb           X DF829600  7308 28632  28631                     (L-TLB)
 c4b2ff70 00000046 df703f90 df829600 dc797060 0102df60 dff4aa20 c4b2ff70
        df829600 dc7970c0 dc797104 00000001 c140a020 003d0900 df7b6cc0 000fb88c
        dc7971cc c151ffa0 0102df60 dc797060 c4b2ff9c c012538b c01529ea df829640
 Call Trace:
  [<c012538b>] do_exit+0x28b/0x4a0
  [<c012566a>] do_group_exit+0x3a/0xb0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 sshd          S C0206A8D  6240 27898   2751 27900   28032       (NOTLB)
 d627fea4 00000082 d627fe6c c0206a8d ce830000 df8e5f60 d627fec0 c035d3c4
        dcf0ea40 00000003 c035d3bc 00000000 c140a020 000186a0 ccc3eb40 0010b6b8
        c74721ec 00000000 7fffffff 0000000a d627fef0 c02fef89 d627fec0 c0206bd0
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 bash          R running  6408 27900  27898 10533               (NOTLB)
 sshd          S C0206A8D  6088 28032   2751 28036         27898 (NOTLB)
 d808dea4 00000086 d808de6c c0206a8d d26e4000 df6044c0 d808dec0 c035d3c4
        df6de8c0 00000003 c035d3bc 00000000 c140a020 0001b207 9fd2cac0 0010b6b8
        df41a20c 00000000 7fffffff 0000000a d808def0 c02fef89 d808dec0 c0206bd0
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 bash          S C011CF0D  6984 28036  28032  9337               (NOTLB)
 dd1ddf08 00000082 dd1ddf10 c011cf0d c1aeb374 c7096080 cd978000 00000001
        c1708140 4d1d3340 0010b4da df7715e0 c1412020 000f4240 4d1d3340 0010b4da
        dfd1c6ec dfd1c624 0000000e fffffe00 dd1ddf94 c012663b bffff8c8 00000000
 Call Trace:
  [<c012663b>] do_wait+0x1ab/0x4a0
  [<c0126a00>] sys_wait4+0x30/0x40
  [<c0126a35>] sys_waitpid+0x25/0x29
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tail          T 00000096  6408  9337  28036         14379       (NOTLB)
 d735feb8 00000082 00000014 00000096 c17d39ec 00000014 00000000 d735feac
        dffe9040 5d1c4940 0010adf8 dfd1c580 c140a020 00000000 5d1c4940 0010adf8
        dfb8874c 00000014 dfb885e0 d735e000 d735fec4 c012dfeb 00000014 d735fef0
 Call Trace:
  [<c012dfeb>] finish_stop+0x4b/0x80
  [<c012e3a1>] get_signal_to_deliver+0x1e1/0x310
  [<c0106efc>] do_signal+0x6c/0x100
  [<c0106fcb>] do_notify_resume+0x3b/0x40
  [<c010714a>] work_notifysig+0x13/0x15
 emacs         T 00000096  6276 10533  27900 16996               (NOTLB)
 d9f35eb8 00000086 00000014 00000096 c17d33ec 00000014 00000000 d9f35eac
        dcf0e0c0 00000000 00000082 c7472080 c140a020 00000000 7f6602c0 0010b6b8
        dfb8824c 00000014 dfb880e0 d9f34000 d9f35ec4 c012dfeb 00000014 d9f35ef0
 Call Trace:
  [<c012dfeb>] finish_stop+0x4b/0x80
  [<c012e3a1>] get_signal_to_deliver+0x1e1/0x310
  [<c0106efc>] do_signal+0x6c/0x100
  [<c0106fcb>] do_notify_resume+0x3b/0x40
  [<c010714a>] work_notifysig+0x13/0x15
 syslogd       D 00000089  6152 14265      1         14269 28631 (NOTLB)
 d9ce5de0 00000082 00002580 00000089 dffcc000 df7d528c 00000001 00000003
        d0f09180 00000286 00000001 d9ce5de0 c140a020 00000000 ccd32d80 0010b6b8
        cf90722c df7d5200 0001c425 df7d5264 d9ce5e48 e085b212 00000000 df7d5284
 Call Trace:
  [<e085b212>] log_wait_commit+0xe2/0x140 [jbd]
  [<e0855d2e>] journal_stop+0x1ce/0x280 [jbd]
  [<e0855dff>] journal_force_commit+0x1f/0x30 [jbd]
  [<e08c00c5>] ext3_force_commit+0x25/0x30 [ext3]
  [<c017e25b>] write_inode+0x4b/0x50
  [<c017e43a>] __sync_single_inode+0x1da/0x200
  [<c017e4d2>] __writeback_single_inode+0x72/0x150
  [<c017ec34>] sync_inode+0x24/0x40
  [<e08b5128>] ext3_sync_file+0xd8/0xe0 [ext3]
  [<c015f9d5>] sys_fsync+0xa5/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 klogd         S 00000000  6972 14269      1         14402 14265 (NOTLB)
 cf805d64 00000082 c011c977 00000000 00000001 cf805d4c d0f09180 00000001
        df9bad20 c03dc0c0 c140a020 cf805d58 c140a020 0001b207 ccd32d80 0010b6b8
        cedbcc4c dfbe20e0 7fffffff 00000001 cf805db0 c02fef89 00000000 c03db488
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c02f979c>] unix_wait_for_peer+0xbc/0xd0
  [<c02fa166>] unix_dgram_sendmsg+0x256/0x4b0
  [<c029508d>] sock_aio_write+0x11d/0x140
  [<c015e25f>] do_sync_write+0x8f/0xd0
  [<c015e38a>] vfs_write+0xea/0x120
  [<c015e471>] sys_write+0x41/0x70
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tail          S 0009096D  6644 14379  28036                9337 (NOTLB)
 cd979f44 00000086 00000000 0009096d 000081a4 00000001 00000282 00000000
        dfaa2100 9fc38880 0010b6b8 df41a0a0 c140a020 00000000 9fc38880 0010b6b8
        df77174c 18690b7c cd979f58 000f41a7 cd979f90 c02fef3b 0009096d 00000000
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c012bc4e>] sys_nanosleep+0xce/0x150
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 gdb           T DFA406B4  7440 14402      1 14403         14269 (NOTLB)
 dc2a5eb4 00000086 dfa406b4 dfa406b4 00000000 d0f098a0 9e6fad80 0010b4e5
        d0f098a0 c140a020 00000000 9e6fad80 c1412020 00000000 9e8e3200 0010b4e5
        dffc7c0c dc2a4000 dc2a5ed0 00000105 dc2a5ec8 c012deb4 dc2a4000 00000105
 Call Trace:
  [<c012deb4>] ptrace_stop+0x84/0xc0
  [<c012df6a>] ptrace_notify+0x7a/0xb0

  [<c0105c5f>] sys_clone+0x2f/0x40
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 gdb           T D0F09D60  7436 14403  14402                     (NOTLB)
 dab3feb0 00000086 d0f09d60 d0f09d60 b7ff12e8 d0f09d60 9e6fad80 0010b4e5
        d0f09d60 c140a020 00000000 dffc7aa0 c140a020 00000000 9e6fad80 0010b4e5
        c161abcc dab3e000 dab3ff24 00000013 dab3fec4 c012deb4 00000013 dab3e000
 Call Trace:
  [<c012deb4>] ptrace_stop+0x84/0xc0
  [<c012e24f>] get_signal_to_deliver+0x8f/0x310
  [<c0106efc>] do_signal+0x6c/0x100
  [<c0106fcb>] do_notify_resume+0x3b/0x40
  [<c010714a>] work_notifysig+0x13/0x15
 bash          S C011CF0D  6624 16996  10533 17228   17243       (NOTLB)
 dee9df08 00000086 dee9df10 c011cf0d dbe6b374 c1918080 d3056000 00000001
        df03cc60 11a26280 0010b689 df8085c0 c1412020 000f4240 11a26280 0010b689
        df681bcc df681b04 0000000e fffffe00 dee9df94 c012663b bffff488 00000000
 Call Trace:
  [<c012663b>] do_wait+0x1ab/0x4a0
  [<c0126a00>] sys_wait4+0x30/0x40
  [<c0126a35>] sys_waitpid+0x25/0x29
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 curl          S C012B5E5  6256 17228  16996                     (NOTLB)
 d3057ea4 00000086 d3057e68 c012b5e5 00000001 00000001 00000282 00000000
        df9ba600 00000000 00000282 d3057ea4 c1412020 00000000 a18d4c00 0010b6b8
        df80872c 18690b98 d3057eb8 00000004 d3057ef0 c02fef3b c0136920 c0371d80
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 gdb           S BFFFEB50  6464 17243  10533 17281         16996 (NOTLB)
 c64dbfa0 00000086 00000000 bfffeb50 bfffeaf8 bfffeb50 00000000 d6f01a20
        df03ca00 b9bddec0 0010b6b3 cbda8aa0 c1412020 00000000 b9bddec0 0010b6b3
        d6f01b8c c64da000 00000000 ffffffff c64dbfbc c010631d 00010000 00000000
 Call Trace:
  [<c010631d>] sys_rt_sigsuspend+0xad/0xd0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S 00000013  6580 17273  17243         17276 17274 (NOTLB)
 c5255e7c 00000086 00000000 00000013 00000026 c140f060 d6f01c00 d6f01a20
        dfaa25c0 c011d30d d6f01a20 d6f01a20 c1412020 00000000 b9bddec0 0010b6b3
        df450bec fffffff5 7fffffff c5254000 c5255ec8 c02fef89 c0152880 08310000
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0reflector1 kernel:  [<c0137730>] futex_wait+0x120/0x190
  [<c0137a13>] do_futex+0x33/0x80
  [<c0137b34>] sys_futex+0xd4/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S D271BEA8  6580 17274  17243         17273 17275 (NOTLB)
 d271bea4 00000086 df4102e0 d271bea8 d271beec 00000001 00000282 00a6cda6
        dfaa25c0 00000000 00000282 d271bea4 c1412020 00000000 9b69a440 0010b6b8
        cedbc24c 18690b31 d271beb8 00000000 d271bef0 c02fef3b 00000160 00a6cda6
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S DD9B5EA0  6796 17275  17243         17274 17277 (NOTLB)
 dd9b5e7c 00000086 dd9b5e80 dd9b5ea0 00000000 00004379 00000000 00000000
        dfaa25c0 cadba340 0010b6b8 cf9075c0 c1412020 00000000 cadba340 0010b6b8
        cbda870c fffffff5 7fffffff dd9b4000 dd9b5ec8 c02fef89 c0152880 b7414000
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0137730>] futex_wait+0x120/0x190
  [<c0137a13>] do_futex+0x33/0x80
  [<c0137b34>] sys_futex+0xd4/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S 00000000  6580 17276  17243               17273 (NOTLB)
 c7803e7c 00000086 d51715e0 00000000 00000000 00000000 00000000 00000000
        dfaa25c0 cadba340 0010b6b8 cbda85a0 c1412020 00000000 cadba340 0010b6b8
        cbda8c0c fffffff5 7fffffff c7802000 c7803ec8 c02fef89 c0152880 b6c13000
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0137730>] futex_wait+0x120/0x190
  [<c0137a13>] do_futex+0x33/0x80
  [<c0137b34>] sys_futex+0xd4/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S 00000000  6448 17277  17243         17275 17278 (NOTLB)
 dd95de7c 00000086 d51715e0 00000000 00000000 00000000 00000000 00000000
        dfaa25c0 cadba340 0010b6b8 df14f0a0 c1412020 00000000 cadba340 0010b6b8
        cf90772c fffffff5 7fffffff dd95c000 dd95dec8 c02fef89 c0152880 b6412000
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0137730>] futex_wait+0x120/0x190
  [<c0137a13>] do_futex+0x33/0x80
  [<c0137b34>] sys_futex+0xd4/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S 00000013  7052 17278  17243         17277 17279 (NOTLB)
 d253fe7c 00000086 00000000 00000013 d253fe60 c1407060 d6f01c00 d6f01a20
        dfaa25c0 c011d30d d6f01a20 d6f01a20 c140a020 00000000 b980d5c0 0010b6b3
        cf907c2c fffffff5 7fffffff d253e000 d253fec8 c02fef89 c0152880 082e6000
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0137730>] futex_wait+0x120/0x190
  [<c0137a13>] do_futex+0x33/0x80
  [<c0137b34>] sys_futex+0xd4/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S 00000000  6664 17279  17243         17278 17280 (NOTLB)
 d6cfdea4 00000086 c1412020 00000000 ca248840 00000001 00000001 00000000
        dfaa25c0 00000010 c034ff80 00000000 c1412020 00000000 cadba340 0010b6b8
        df14f20c 00000000 7fffffff 0000000f d6cfdef0 c02fef89 c0136920 c0371d80
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0170e2e>] do_select+0x15e/0x280
  [<c0171213>] sys_select+0x293/0x500
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S C011E115  7052 17280  17243         17279 17281 (NOTLB)
 d6cffe7c 00000086 d6cffe60 c011e115 00000001 c1407060 d6f01c00 d6f01a20
        dfaa25c0 c011d30d d6f01a20 d6f01a20 c140a020 00000000 ba567540 0010b6b3
        dc7976cc fffffff5 7fffffff d6cfe000 d6cffec8 c02fef89 c0152880 082f5000
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0137730>] futex_wait+0x120/0x190
  [<c0137a13>] do_futex+0x33/0x80
  [<c0137b34>] sys_futex+0xd4/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 tt1           S 00000000  6032 17281  17243         17280       (NOTLB)
 c4bf3e7c 00000086 c034c860 00000000 00000000 c4bf3e58 c01400ba 20000000
        dfaa25c0 00000000 c039f980 c4bf3e80 c140a020 0001b207 bfd44340 0010b6b7
        cedbc74c fffffff5 7fffffff c4bf2000 c4bf3ec8 c02fef89 c01094ed 00000000
 Call Trace:
  [<c02fef89>] schedule_timeout+0xb9/0xc0
  [<c0137730>] futex_wait+0x120/0x190
  [<c0137a13>] do_futex+0x33/0x80
  [<c0137b34>] sys_futex+0xd4/0xe0
  [<c01070ad>] sysenter_past_esp+0x52/0x71
 sleep         S 00A19130  7068 17287   3709                     (NOTLB)
 cc09bf44 00000086 00000000 00a19130 d6f01520 cc09bfc4 00000282 00000004
        c17083a0 00000000 00000282 cc09bf44 c140a020 001e8480 04d97100 0010b6b7
        d6f0168c 1869179f cc09bf58 000f41a7 cc09bf90 c02fef3b 00000000 d276d1a0
 Call Trace:
  [<c02fef3b>] schedule_timeout+0x6b/0xc0
  [<c012bc4e>] sys_nanosleep+0xce/0x150
  [<c01070ad>] sysenter_past_esp+0x52/0x71


...............................................
Email sent to ACE list...
...............................................


ACE 5.4 on 2x CPU Linux 2.6.10-rc1-bk7

I am running into a situation on Linux where a semaphore doesn't seem to be signaling the waiting thread, or perhaps more
accurately, where the OS doesn't seem to wake the waiting thread.  This is under SCHED_RR, so I suspected some kind of scheduler
starvation, so I added a sched_yield() immediately after posting to the semaphore.

As you can see below, s->count_ = 4088, s->waiters_ = 1, yet the waiting thread is stuck inside pthread_cond_wait!!!  Any ideas?

A.

==============================================


(gdb) p *s
$1 = {lock_ = {__m_reserved = 0, __m_count = 0, __m_owner = 0x0, __m_kind = 0, __m_lock = {__status = 1, __spinlock = 0}},
count_nonzero_ = {
    __c_lock = {__status = 0, __spinlock = 211332}, __c_waiting = 0x19cc2,
    __padding = "\000\000\000\000A\234\001\000\000\000\000\000A\234\001\000\000\000\000\000?T/\b\002\000\000", __align = 0}, count_
= 4088,
  waiters_ = 1}

=================================================

ACE_INLINE int
ACE_OS::sema_wait (ACE_sema_t *s)
{
  ACE_OS_TRACE ("ACE_OS::sema_wait");
# if defined (ACE_HAS_POSIX_SEM)
  ACE_OSCALL_RETURN (::sem_wait (s->sema_), int, -1);
# elif defined (ACE_HAS_THREADS)
#   if defined (ACE_HAS_STHREADS)
  ACE_OSCALL_RETURN (ACE_ADAPT_RETVAL (::sema_wait (s), ace_result_), int, -1);
#   elif defined (ACE_HAS_PTHREADS)
  int result = 0;

  ACE_PTHREAD_CLEANUP_PUSH (&s->lock_);

  if (ACE_OS::mutex_lock (&s->lock_) != 0)
    result = -1;
  else
    {
      // Keep track of the number of waiters so that we can signal
      // them properly in <ACE_OS::sema_post>.
      s->waiters_++;

      // Wait until the semaphore count is > 0.
      while (s->count_ == 0)
=>      if (ACE_OS::cond_wait (&s->count_nonzero_,
                               &s->lock_) == -1)
          {
            result = -2; // -2 means that we need to release the mutex.
            break;
          }

      --s->waiters_;
    }

  if (result == 0)
    --s->count_;

=======================================================

ACE_INLINE int
ACE_OS::cond_wait (ACE_cond_t *cv,
                   ACE_mutex_t *external_mutex)
{
  ACE_OS_TRACE ("ACE_OS::cond_wait");
# if defined (ACE_HAS_THREADS)
#   if defined (ACE_HAS_PTHREADS)
#     if defined (ACE_HAS_PTHREADS_DRAFT4) || defined (ACE_HAS_PTHREADS_DRAFT6)
  ACE_OSCALL_RETURN (::pthread_cond_wait (cv, external_mutex), int, -1);
#     else
=>ACE_OSCALL_RETURN (ACE_ADAPT_RETVAL (::pthread_cond_wait (cv, external_mutex), ace_result_),
                     int, -1);
#     endif /* ACE_HAS_PTHREADS_DRAFT4 || ACE_HAS_PTHREADS_DRAFT6 */
#   elif defined (ACE_HAS_STHREADS)
  ACE_OSCALL_RETURN (ACE_ADAPT_RETVAL (::cond_wait (cv, external_mutex), ace_result_),
                     int, -1);
#   elif defined (ACE_PSOS) && defined (ACE_PSOS_HAS_COND_T)
  ACE_OSCALL_RETURN (ACE_ADAPT_RETVAL (::cv_wait (*cv, *external_mutex, 0),
                                       ace_result_),


