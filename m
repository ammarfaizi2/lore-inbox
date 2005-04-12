Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVDLFZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVDLFZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVDLFZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:25:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:8154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262036AbVDLFEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:04:53 -0400
Date: Mon, 11 Apr 2005 22:00:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050411220013.23416d5f.akpm@osdl.org>
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> - The anticipatory I/O scheduler has always been fairly useless with SCSI
>    disks which perform tagged command queueing.  There's a patch here from Jens
>    which is designed to fix that up by constraining the number of requests
>    which we'll leave pending in the device.
> 
>    The depth currently defaults to 1.  Tunable in
>    /sys/block/hdX/queue/iosched/queue_depth
> 
>    This patch hasn't been performance tested at all yet.  If you think it is
>    misbehaving (the usual symptom is processes stuck in D state) then please
>    report it, then boot with `elevator=cfq' or `elevator=deadline' to work
>    around it.

So it turns out that patch was broken.  I've fixed it locally and the
results are good, but odd.

The machine is a 4GB x86_64 with aic79xx controllers and MAXTOR
ATLAS10K4_73WLS disks.  ext2 filesystem.

The workload is continuous pagecache writeback versus
read-lots-of-little-files:

	while true
	do
		dd if=/dev/zero of=/mnt/sdb2/x bs=40M count=100 conv=notrunc
	done

versus

	find /mnt/sdb2/linux-2.4.25 -type f | xargs cat > /dev/null

we measure how long the find+cat takes.

2.6.12-rc2, 	as,	tcq depth=2:		7.241 seconds
2.6.12-rc2, 	as,	tcq depth=64:		12.172 seconds
2.6.12-rc2+patch,as,	tcq depth=64:		7.199 seconds
2.6.12-rc2, 	cfq2,	tcq depth=64:		much more than 5 minutes
2.6.12-rc2, 	cfq3,	tcq depth=64:		much more than 5 minutes

So

- The effects of tcq on AS are much less disastrous than I thought they
  were.  Do I have the wrong workload?  Memory fails me.  Or did we fix the
  anticipatory scheduler?

- as-limit-queue-depth.patch fixes things right up anyway.  Seems to be
  doing the right thing.  

- CFQ is seriously, seriously read-starved on this workload.

CFQ2:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  3   1116  25504   4868 3854008    4    0     8 61976 1112   291  0  4 39 58
 0  4   1112  24992   4868 3855120    0  568     4 53804 1124   452  0  4 54 43
 0  4   1112  24032   4868 3856004    0    0     8 44652 1110   303  0  3 45 53
 0  2   1112  25912   4872 3854164    0    0     4 51108 1122   321  0  3 52 45
 2  3   1112  24312   4872 3855728    0    0    32 52240 1113   300  0  4 44 52
 1  3   1112  25728   4876 3854432    0    0    20 48128 1118   296  0  3 58 39
 0  2   1112  23872   4876 3856336    0    0     4 48136 1116   288  0  4 47 49
 0  4   1112  25856   4876 3854300    0    4    16 50260 1117   294  0  3 55 42

CFQ3:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  5   1008  25888   4204 3845820    0    0    12 50544 1119   116  0  3 49 48
 0  5   1008  24096   4204 3847520    0    0     8 51200 1112   110  0  3 49 48
 0  5   1008  25824   4204 3845820    0    0     8 54816 1117   120  0  4 49 48
 0  5   1008  25440   4204 3846160    0    0     8 52880 1113   115  0  3 49 48
 0  5   1008  25888   4208 3845748    0    0    16 51024 1121   116  0  3 49 48


