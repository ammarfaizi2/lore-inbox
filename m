Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbULHNaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbULHNaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbULHNaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:30:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50406 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261210AbULHN3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:29:17 -0500
Date: Wed, 8 Dec 2004 14:28:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Time sliced CFQ #4
Message-ID: <20041208132826.GT19522@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The stupid sort bug warrants another release, as it basically killed
(well cut by 30%) sequential write performance. This one gets close to
'AS' tiobench sequential write performance (still 5% off), equalling it
in others. Changes:

- Various little bug fixes

- RCU the per-process-per-disk cfq io context. It probably wants a
  better structure later for the many-disk setup, but at least it runs
  lockless now.

- Kill the PF_SYNCWRITE stuff. Belongs to another patch, if at all.

- Fix a silly problem that caused very bad sort of dispatch list.

Might perhaps need a little re-tuning of the slice_async* values after
the sort fix.

BK patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-9.gz

-mm patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc2-mm4/cfq-time-slices-9-mm.gz

Quick benches (reads and reads/writes mixed, 64kb block size for all)

CFQ:

buffered IO:

thread1 (read): err=0, max=398msec, min=0msec, run=30144msec, bw=6091KiB/sec
thread2 (read): err=0, max=362msec, min=0msec, run=29895msec, bw=7444KiB/sec
thread3 (write): err=0, max=4535msec, min=0msec, run=28531msec, bw=5735KiB/sec
thread4 (write): err=0, max=7926msec, min=0msec, run=28816msec, bw=5922KiB/sec
Run status:
   READ: io=396672MiB, maxt=30144msec, mint=29895msec, maxb=7444, minb=6091, aggrb=13475
  WRITE: io=326464MiB, maxt=28816msec, mint=28531msec, maxb=5922, minb=5735, aggrb=11601

thread1 (read): err=0, max=332msec, min=0msec, run=30030msec, bw=6739KiB/sec
thread2 (read): err=0, max=326msec, min=0msec, run=30049msec, bw=6830KiB/sec
thread3 (read): err=0, max=333msec, min=0msec, run=30065msec, bw=6779KiB/sec
thread4 (read): err=0, max=331msec, min=0msec, run=30003msec, bw=6801KiB/sec
Run status:
   READ: io=796416MiB, maxt=30065msec, mint=30003msec, maxb=6830, minb=6739, aggrb=27125

direct IO:

thread1 (read): err=0, max=318msec, min=2msec, run=30023msec, bw=6614KiB/sec
thread2 (read): err=0, max=321msec, min=2msec, run=30042msec, bw=6598KiB/sec
thread3 (read): err=0, max=329msec, min=2msec, run=30003msec, bw=6557KiB/sec
thread4 (read): err=0, max=321msec, min=2msec, run=30037msec, bw=6565KiB/sec
Run status:
   READ: io=772224MiB, maxt=30042msec, mint=30003msec, maxb=6614, minb=6557, aggrb=26321

AS:

buffered IO:

thread1 (read): err=0, max=285msec, min=0msec, run=30052msec, bw=10432KiB/sec
thread2 (read): err=0, max=331msec, min=0msec, run=30033msec, bw=10714KiB/sec
thread3 (write): err=0, max=2815msec, min=0msec, run=29732msec, bw=3857KiB/sec
thread4 (write): err=0, max=2463msec, min=0msec, run=29739msec, bw=3768KiB/sec
Run status:
   READ: io=620416MiB, maxt=30052msec, mint=30033msec, maxb=10714, minb=10432, aggrb=21140
  WRITE: io=221440MiB, maxt=29739msec, mint=29732msec, maxb=3857, minb=3768, aggrb=7624

thread1 (read): err=0, max=644msec, min=0msec, run=30051msec, bw=7563KiB/sec
thread2 (read): err=0, max=735msec, min=0msec, run=30034msec, bw=6794KiB/sec
thread3 (read): err=0, max=843msec, min=0msec, run=30021msec, bw=6239KiB/sec
thread4 (read): err=0, max=862msec, min=0msec, run=30002msec, bw=6636KiB/sec
Run status:
   READ: io=798592MiB, maxt=30051msec, mint=30002msec, maxb=7563, minb=6239, aggrb=27212

direct IO:

thread1 (read): err=0, max=518msec, min=2msec, run=30048msec, bw=6813KiB/sec
thread2 (read): err=0, max=867msec, min=2msec, run=30031msec, bw=7125KiB/sec
thread3 (read): err=0, max=939msec, min=2msec, run=30018msec, bw=6540KiB/sec
thread4 (read): err=0, max=1071msec, min=2msec, run=30000msec, bw=6201KiB/sec
Run status:
   READ: io=782336MiB, maxt=30048msec, mint=30000msec, maxb=7125, minb=6201, aggrb=26661


-- 
Jens Axboe

