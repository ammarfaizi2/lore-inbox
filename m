Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSCaOFt>; Sun, 31 Mar 2002 09:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSCaOFj>; Sun, 31 Mar 2002 09:05:39 -0500
Received: from www.wen-online.de ([212.223.88.39]:14353 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S310517AbSCaOFb>;
	Sun, 31 Mar 2002 09:05:31 -0500
Date: Sun, 31 Mar 2002 14:26:14 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
In-Reply-To: <3C9807AD.65EBB69C@zip.com.au>
Message-ID: <Pine.LNX.4.10.10203311422310.2622-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andrew Morton wrote:

> I've been crunching on Andrea's 10_vm-32 patch for a number of days
> with a view to getting it into the main tree.

Hi Andrew,  (just an fyi)

I was curious as to what effect some of these aa patches would have
on 2.5.7 throughput, so I wiggled..
	aa-096-swap_out
	aa-180-activate_page_cleanup
	aa-150-read_write_tweaks
	aa-110-zone_accounting
	aa-093-vm_tunables
	aa-040-touch_buffer
	aa-030-writeout_scheduling
	aa-020-sync_buffers
..into it any gave it a little spin.  At swap, the aa modified
kernel won.  At disk blasting though, the stock kernel won big.

freshboot; time make -j70 bzImage CC=gcc-3.0.3 && procinfo
Linux 2.5.7aa (root@mikeg) (gcc gcc-2.95.3 20010315 ) #89 [mikeg.]

user  :       0:08:02.98  77.9%  page in :   549622
nice  :       0:00:00.00   0.0%  page out:   437908
system:       0:00:50.93   8.2%  swap in :   105628
idle  :       0:01:25.86  13.9%  swap out:    89827

real    8m59.259s     aside   6m55.169s  gcc-2.95.3 doing make -j90
user    7m54.930s             6m12.100s  on very same 384 mb box...
sys     0m34.320s             0m25.050s

#!/bin/sh
# testo
# /tmp is tmpfs

for i in 1 2 3 4 5
do
	mv /test/linux-2.5.7 /tmp/.
	mv /tmp/linux-2.5.7 /test/.
done

time testo
real    3m43.775s
user    0m4.850s
sys     0m47.460s

freshboot; time make -j70 bzImage CC=gcc-3.0.3 && procinfo
Linux 2.5.7 (root@mikeg) (gcc gcc-2.95.3 20010315 ) #83 [mikeg.]

user  :       0:08:04.81  73.4%  page in :   606872
nice  :       0:00:00.00   0.0%  page out:   482386
system:       0:00:50.95   7.7%  swap in :   129625
idle  :       0:02:04.66  18.9%  swap out:   115843

real    9m39.606s
user    7m56.300s
sys     0m34.570s

time testo
real    2m7.581s
user    0m4.490s
sys     0m41.850s

