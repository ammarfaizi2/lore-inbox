Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVCHMjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVCHMjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 07:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCHMje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 07:39:34 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:45515
	"EHLO mail.hennerich.de") by vger.kernel.org with ESMTP
	id S261462AbVCHMjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 07:39:25 -0500
Date: Tue, 8 Mar 2005 13:37:35 +0100
From: Tobias Hennerich <Tobias@Hennerich.de>
To: linux-kernel@vger.kernel.org
Subject: Strange memory leak in 2.6.x
Message-ID: <20050308133735.A13586@bart.hennerich.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we kindly ask for some suggestions about how to trace a memory leak
which we suspect in the linux kernel version 2.6:

The machine in question is a Dell PowerEdge 2500 (4GB RAM, Dual-PIII,
AAC-raid and several e1000) running SUSE Pro 9.2 with different kernels
(2.6.8-24.11-SMP from SUSE and now a native 2.6.10 from kernel.org).

It is used as a bastion host with the usual suspects: squid, apache,
bind, xntpd, postfix, spamassassin.

As you can see here

    http://download.hennerich.de/memory-leak.gif

the userspace processes consume unchanging less then 1GB RAM for several
days (vsz-sum/rss-sum).

Nonetheless, each night (after cron started logrotate) the kernel uses
~1.2GB less for cache. After an uptime a few days, we get messages from
the oom-killer like this :

oom-killer: gfp_mask=0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
 
Free pages:      131452kB (127680kB HighMem)
Active:579780 inactive:342244 dirty:0 writeback:0 unstable:0 free:32863
    slab:16212 mapped:20773 pagetables:230
DMA free:68kB min:68kB low:84kB high:100kB active:6016kB inactive:6028kB
    present:16384kB pages_scanned:37102 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:3704kB min:3756kB low:4692kB high:5632kB active:716344kB
    inactive:79172kB present:901120kB pages_scanned:2312264
    all_unreclaimable? yes
protections[]: 0 0 0
HighMem free:127680kB min:512kB low:640kB high:768kB active:1596760kB
    inactive:1283776kB present:3014592kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 2*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
    0*2048kB 0*4096kB = 68kB
Normal: 0*4kB 5*8kB 1*16kB 4*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB
    1*2048kB 0*4096kB = 3704kB
HighMem: 26482*4kB 2095*8kB 110*16kB 47*32kB 19*64kB 0*128kB 0*256kB
    1*512kB 0*1024kB 0*2048kB 0*4096kB = 127680kB
Swap cache: add 439887, delete 438471, find 242699/277105, race 0+0
Out of Memory: Killed process 29603 (cleanup).

(at that time we used a kernel 2.6.10 with CONFIG_SMP not set, so you
don't see the second CPU)

30 minutes later the machine swaps out some MBs (and only some few MBs),
kswapd needs CPU and the system freezes. System-load is most of the time
below 0.5, /proc/slabinfo seems to be normal.

Changing hardware (to another PowerEdge 2500) and upgrading the kernel
didn't help, only a backport to a system with a linux-2.4 changed the
behavior.

Do you have any suggestions how to isolate this problem?

Best regards	Tobias Hennerich

-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/
