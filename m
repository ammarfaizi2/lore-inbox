Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVL0SIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVL0SIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 13:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVL0SIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 13:08:34 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:36063 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932367AbVL0SId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 13:08:33 -0500
Date: Tue, 27 Dec 2005 19:09:18 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SCHED] Totally WRONG prority calculation with specific test-case
 (since 2.6.10-bk12)
Message-ID: <20051227190918.65c2abac@localhost>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found an easy-to-reproduce-for-me test case that shows a totally
wrong priority calculation: basically a CPU-intensitive process gets
better priority than a disk-intensitive one (dd if=bigfile
of=/dev/null ...).

Seems impossible, isn't it?

---- THE NUMBERS with 2.6.15-rc7 -----

The test-case is the Xvid encoding of dvd-ripped track with transcode
(using "dvd::rip" interface). The copied-and-pasted command line is
this:

mkdir -m 0775 -p '/home/paolo/tmp/test/tmp' &&
cd /home/paolo/tmp/test/tmp && dr_exec transcode -H 10 -a 2 -x vob,null
-i /home/paolo/tmp/test/vob/003 -w 1198,50 -b 128,0,0 -s 1.972
--a52_drc_off -f 25 -Y 52,8,52,8 -B 27,10,8 -R 1 -y xvid4,null
-o /dev/null --print_status 20 && echo DVDRIP_SUCCESS mkdir -m 0775 -p
'/home/paolo/tmp/test/tmp' && cd /home/paolo/tmp/test/tmp && dr_exec
transcode -H 10 -a 2 -x vob -i /home/paolo/tmp/test/vob/003 -w 1198,50
-b 128,0,0 -s 1.972 --a52_drc_off -f 25 -Y 52,8,52,8 -B 27,10,8 -R 2 -y
xvid4 -o /home/paolo/tmp/test/avi/003/test-003.avi --print_status 20 &&
echo DVDRIP_SUCCESS


Here there is a TOP snapshot while running it:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5721 paolo     16   0  115m  18m 2428 R 84.4  3.7   0:15.11 transcode
 5736 paolo     25   0 50352 4516 1912 R  8.4  0.9   0:01.53 tcdecode
 5725 paolo     15   0  115m  18m 2428 S  4.6  3.7   0:00.84 transcode
 5738 paolo     18   0  115m  18m 2428 S  0.8  3.7   0:00.15 transcode
 5734 paolo     25   0 20356 1140  920 S  0.6  0.2   0:00.12 tcdemux
 5731 paolo     25   0 47312 2540 1996 R  0.4  0.5   0:00.08 tcdecode
 5319 root      15   0  166m  16m 2584 S  0.2  3.2   0:25.06 X
 5444 paolo     16   0 87116  22m  15m R  0.2  4.6   0:04.05 konsole
 5716 paolo     16   0 10424 1160  876 R  0.2  0.2   0:00.06 top
 5735 paolo     25   0 22364 1436  932 S  0.2  0.3   0:00.01 tcextract


DD running alone:

paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
128+0 records in
128+0 records out

real    0m4.052s
user    0m0.000s
sys     0m0.209s

DD while transcoding:

paolo@tux /mnt $ mount space/; time dd if=space/bigfile of=/dev/null bs=1M count=128; umount space/
128+0 records in
128+0 records out

real    0m26.121s
user    0m0.001s
sys     0m0.255s

---------------------------------------

I've tried older kernels finding that 2.6.11 is the first affected.

Going on with testing...

        2.6.11-rc[1-5]:
2.6.11-rc3 bad
2.6.11-rc1 bad

        2.6.10-bk[1-14]
2.6.10-bk7 good
2.6.10-bk11 good
2.6.10-bk13 bad
2.6.10-bk12 bad

So the problem was introduced with:
	>> 2.6.10-bk12 09-Jan-2005 <<

The exact behaviour is different with 2.6.11/12/13/14... for example:
with 2.6.11 the priority of "transcode" is initially set to ~25 and go
down to 17/18 when running DD.

The problem doesn't seem 100% reproducible with every kernel, sometimes
a "BAD" kernel looks "GOOD"... or maybe it was me confused by too
much compile/install/reboot/test work ;)

Other INFO:
- I'm on x86_64
- preemption ON/OFF doesn't make any differences


Can anyone reproduce this?
IOW: is this affecting only my machine?

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-gf89f5948 on x86_64
