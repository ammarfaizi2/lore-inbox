Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVAYLnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVAYLnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVAYLkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:40:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:646 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261909AbVAYLiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:38:17 -0500
From: Andrew Tridgell <tridge@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16886.12026.810752.23284@samba.org>
Date: Tue, 25 Jan 2005 22:35:22 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: memory leak in 2.6.11-rc2
In-Reply-To: <20050124220624.4a8eca97.akpm@osdl.org>
References: <20050120020124.110155000@suse.de>
	<16884.8352.76012.779869@samba.org>
	<200501232358.09926.agruen@suse.de>
	<200501240032.17236.agruen@suse.de>
	<16884.56071.773949.280386@samba.org>
	<16885.47804.68041.144011@samba.org>
	<41F5BB0D.6090006@osdl.org>
	<16885.48502.243516.563660@samba.org>
	<16885.53121.883933.986880@samba.org>
	<20050124220624.4a8eca97.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

 > So what you should do before generating the leak tool output is to put
 > heavy memory pressure on the machine to try to get it to free up as much of
 > that pagecache as possible.  bzero(malloc(lots)) will do it - create a real
 > swapstorm, then do swapoff to kill remaining swapcache as well.

As you saw when you logged into the machine earlier tonight, when you
suspend the dbench processes and run a memory filler the memory is
reclaimed.

I still think its a bug though, as the oom killer is being triggered
when it shouldn't be. I have 4G of ram in this machine, and I'm only
running a couple of hundred processes that should be using maybe 500M
in total, so for the oom killer to kick in might mean that the memory
isn't being reclaimed under normal memory pressure. Certainly a ps
shows no process using more than a few MB.

The oom killer report is below. This is with 2.6.11-rc2, with the pipe
leak fix, and the pgown monitoring patch. It was running one nbench of
size 50 and one dbench of size 40 at the time.

If this isn't a leak, then it would also be good to fix /usr/bin/free
so the -/+ buffers line becomes meaningful again. With the machine
completely idle (just a sshd running) I see:

Mem:       3701184    3483188     217996          0     130092    1889440
-/+ buffers/cache:    1463656    2237528

which looks like a leak. This persists even after the disks are
unmounted. After filling/freeing memory I see:

Mem:       3701184      28176    3673008          0        520       3764
-/+ buffers/cache:      23892    3677292

so it can recover it, but under normal usage it doesn't before the oom
killer kicks in.

Cheers, Tridge


Jan 25 00:49:14 dev4-003 kernel: Out of Memory: Killed process 18910 (smbd).
Jan 25 00:49:14 dev4-003 kernel: oom-killer: gfp_mask=0xd0
Jan 25 00:49:14 dev4-003 kernel: DMA per-cpu:
Jan 25 00:49:14 dev4-003 kernel: cpu 0 hot: low 2, high 6, batch 1
Jan 25 00:49:14 dev4-003 kernel: cpu 0 cold: low 0, high 2, batch 1
Jan 25 00:49:14 dev4-003 kernel: cpu 1 hot: low 2, high 6, batch 1
Jan 25 00:49:14 dev4-003 kernel: cpu 1 cold: low 0, high 2, batch 1
Jan 25 00:49:14 dev4-003 kernel: cpu 2 hot: low 2, high 6, batch 1
Jan 25 00:49:14 dev4-003 kernel: cpu 2 cold: low 0, high 2, batch 1
Jan 25 00:49:14 dev4-003 kernel: cpu 3 hot: low 2, high 6, batch 1
Jan 25 00:49:14 dev4-003 kernel: cpu 3 cold: low 0, high 2, batch 1
Jan 25 00:49:14 dev4-003 kernel: Normal per-cpu:
Jan 25 00:49:14 dev4-003 kernel: cpu 0 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 0 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 1 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 1 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 2 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 2 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 3 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 3 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel: HighMem per-cpu:
Jan 25 00:49:14 dev4-003 kernel: cpu 0 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 0 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 1 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 1 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 2 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 2 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 3 hot: low 32, high 96, batch 16
Jan 25 00:49:14 dev4-003 kernel: cpu 3 cold: low 0, high 32, batch 16
Jan 25 00:49:14 dev4-003 kernel:
Jan 25 00:49:14 dev4-003 kernel: Free pages:        5884kB (640kB HighMem)
Jan 25 00:49:14 dev4-003 kernel: Active:84764 inactive:806173 dirty:338229 writeback:36 unstable:0 free:1471 slab:23814 mapped:31610 pagetables:1616
Jan 25 00:49:14 dev4-003 kernel: DMA free:284kB min:68kB low:84kB high:100kB active:440kB inactive:10048kB present:16384kB pages_scanned:140 all_unreclaimable? no
Jan 25 00:49:14 dev4-003 kernel: protections[]: 0 0 0
Jan 25 00:49:14 dev4-003 kernel: Normal free:4960kB min:3756kB low:4692kB high:5632kB active:72072kB inactive:632096kB present:901120kB pages_scanned:58999 all_unreclaimable? no
Jan 25 00:49:14 dev4-003 kernel: protections[]: 0 0 0
Jan 25 00:49:14 dev4-003 kernel: HighMem free:640kB min:512kB low:640kB high:768kB active:266948kB inactive:2581960kB present:2850752kB pages_scanned:0 all_unreclaimable? no
Jan 25 00:49:14 dev4-003 kernel: protections[]: 0 0 0
Jan 25 00:49:14 dev4-003 kernel: DMA: 53*4kB 3*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 284kB
Jan 25 00:49:14 dev4-003 kernel: Normal: 400*4kB 16*8kB 0*16kB 1*32kB 0*64kB 1*128kB 0*256kB 2*512kB 0*1024kB 1*2048kB 0*4096kB = 4960kB
Jan 25 00:49:14 dev4-003 kernel: HighMem: 6*4kB 11*8kB 1*16kB 0*32kB 0*64kB 2*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 640kB
Jan 25 00:49:14 dev4-003 kernel: Swap cache: add 1584899, delete 1585025, find 294/351, race 0+0
Jan 25 00:49:14 dev4-003 kernel: Out of Memory: Killed process 18914 (smbd).
