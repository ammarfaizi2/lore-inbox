Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbUBAV7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbUBAV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:59:52 -0500
Received: from s4.uklinux.net ([80.84.72.14]:30673 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S265528AbUBAV7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:59:47 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
From: Philip Martin <philip@codematters.co.uk>
Date: Sun, 01 Feb 2004 21:34:06 +0000
Message-ID: <87oesieb75.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The machine is a dual P3 450MHz, 512MB, aic7xxx, 2 disk RAID-0 and
ReiserFS.  It's a few years old and has always run Linux, most
recently 2.4.24.  I decided to try 2.6.1 and the performance is
disappointing.

My test is a software build of about 200 source files (written in C)
that I usually build using "nice make -j4".  Timing the build on
2.4.24 I typically get something like

242.27user 81.06system 2:44.18elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1742270major+1942279minor)pagefaults 0swaps

and on 2.6.1 I get

244.08user 116.33system 3:27.40elapsed 173%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3763670minor)pagefaults 0swaps

The results are repeatable.  The user CPU is about the same for the
two kernels, but on 2.6.1 the elapsed time is much greater, as is the
system CPU.  I note a big difference in the pagefaults between 2.4 and
2.6 but I don't know what to make of it.

Comparing /proc/scsi/aic7xxx/0 before and after the build I see
another difference, the "Commands Queued" to the RAID disks are much
greater for 2.6 than 2.4

          disk0   disk2
2.4
before:    8459    4766
after:    13798    7351

2.6
before:   21287    8555
after:    40491   15995

(The root partition is also on disk0 and that's not part of the RAID
array; I guess that's why disk0 has higher numbers than disk2.)

The machine has another disk that is not part of the RAID array, it's
a slower disk but I think the build is CPU bound anyway.  I put an
ext2 filesystem on this extra disk, and then used that for my trial
build with the rest of the system, gcc, as, ld, etc. still coming from
RAID array.  On 2.4 the time for the ext2 build is essentially the
same as for the RAID build, the difference is within the normal
variation between builds.  On 2.6 the ext2 build takes

244.43user 111.75system 3:16.42elapsed 181%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3757151minor)pagefaults 0swaps

Although the CPU used is about the same as the RAID build the elapsed
time is less, so there is some improvement but it is still worse than
2.4.24.

-- 
Philip Martin
