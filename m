Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVL1NiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVL1NiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVL1NiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:38:12 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:33923 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964813AbVL1NiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:38:11 -0500
Message-ID: <43B29540.1030904@bigpond.net.au>
Date: Thu, 29 Dec 2005 00:38:08 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific test-case
 (since 2.6.10-bk12)
References: <20051227190918.65c2abac@localhost>	<20051227224846.6edcff88@localhost>	<43B1D551.5050503@bigpond.net.au> <20051228112058.2c0c1137@localhost>
In-Reply-To: <20051228112058.2c0c1137@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 28 Dec 2005 13:38:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Wed, 28 Dec 2005 10:59:13 +1100
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>Any chance of you applying the PlugSched patches and seeing how the 
>>other schedulers that it contains handle this situation?
>>
>>The patch at:
>>
>><http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.6-for-2.6.15-rc5.patch?download>
>>
>>should apply without problems to the 2.6.15-rc7 kernel.
>>
>>Very Brief Documentation:
>>
>>You can select a default scheduler at kernel build time.  If you wish to
>>boot with a scheduler other than the default it can be selected at boot
>>time by adding:
>>
>>cpusched=<scheduler>
>>
>>to the boot command line where <scheduler> is one of: ingosched,
>>nicksched, staircase, spa_no_frills, spa_ws, spa_svr or zaphod.  If you
>>don't change the default when you build the kernel the default scheduler
>>will be ingosched (which is the normal scheduler).
> 
> 
> 
> First of all, this is the "pstree" structure of transcode an friends:
> 
>      |-kdesktop---perl---sh---transcode-+-2*[sh-+-tccat]
>      |                                  |       |-tcdecode]
>      |                                  |       |-tcdemux]
>      |                                  |       `-tcextract]
>      |                                  `-transcode---5*[transcode]
> 
> 
> Results with various schedulers:

First, thanks for doing this.

> 
> ------------------------------------------------------------------------
> 
> 	1) nicksched: perfect! This is the behaviour I want.
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5562 paolo     40   0  115m  18m 2428 R 82.2  3.7   0:22.16 transcode
>  5576 paolo     26   0 50348 4516 1912 S  9.5  0.9   0:02.43 tcdecode
>  5566 paolo     23   0  115m  18m 2428 S  4.6  3.7   0:01.24 transcode
>  5573 paolo     21   0  115m  18m 2428 S  0.9  3.7   0:00.22 transcode
>  5577 paolo     27   0 20356 1140  920 S  0.9  0.2   0:00.21 tcdemux
>  5295 root      20   0  167m  17m 3624 S  0.6  3.5   0:11.02 X
>  5579 paolo     20   0 47308 2540 1996 S  0.5  0.5   0:00.14 tcdecode
>  5574 paolo     20   0 20356 1144  920 S  0.4  0.2   0:00.11 tcdemux
> ...
> 
> transcode get recognized for what it is, and I/O bounded processes
> don't even notice that it is running :)

Interesting.  This one's more or less a dead scheduler and hasn't had 
any development work done on it for some time.  I just keep porting the 
original version to new kernels.

> 
> 
> 	2) staircase: bad, as you can see:
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5582 paolo     26   0  115m  18m 2428 R 82.7  3.7   0:47.63 transcode
>  5599 paolo     39   0 50352 4516 1912 R  9.6  0.9   0:05.21 tcdecode
>  5586 paolo      0   0  115m  18m 2428 S  4.5  3.7   0:02.61 transcode
>  5622 paolo     39   0  4948 1520  412 R  1.1  0.3   0:00.15 dd
>  5591 paolo      0   0  115m  18m 2428 S  0.6  3.7   0:00.36 transcode
>  5575 paolo      0   0 98476  37m 9392 S  0.4  7.5   0:01.44 perl
>  5597 paolo     27   0 20356 1144  920 S  0.4  0.2   0:00.21 tcdemux
>  5475 paolo      0   0 86556  22m  15m S  0.2  4.5   0:01.24 konsole
>  5388 root       0   0  167m  17m 3208 S  0.1  3.4   0:03.16 X
>  5587 paolo      0   0  115m  18m 2428 S  0.1  3.7   0:00.03 transcode
>  5595 paolo     20   0 47312 2540 1996 S  0.1  0.5   0:00.14 tcdecode
>  5596 paolo     26   0 22672 1268 1020 S  0.1  0.2   0:00.03 tccat
>  5598 paolo     28   0 22364 1436  932 S  0.1  0.3   0:00.04 tcextract
> 
> 
> And "DD" is affected badly:
> 
> paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile
> of=/dev/null bs=1M count=128; umount space/ 128+0 records in
> 128+0 records out
> 
> real    0m6.341s
> user    0m0.002s
> sys     0m0.229s
> 
> While transcoding:
> 
> paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile
> of=/dev/null bs=1M count=256; umount space/ 256+0 records in
> 256+0 records out
> 
> real    0m15.793s
> user    0m0.001s
> sys     0m0.374s
> 
> 
> 	3) spa_no_frills: bad, but this is OK since it is Round Robin :)
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5356 paolo     20   0  115m  18m 2428 R 81.1  3.7   0:27.61 transcode
>  5371 paolo     20   0 50348 4516 1912 R  8.9  0.9   0:02.97 tcdecode
>  5360 paolo     20   0  115m  18m 2428 S  4.1  3.7   0:01.54 transcode
>  5378 paolo     20   0  4948 1520  412 D  1.4  0.3   0:00.29 dd
>  5364 paolo     20   0 20352 1144  920 S  0.9  0.2   0:00.20 tcdemux
>  5373 paolo     20   0  115m  18m 2428 S  0.7  3.7   0:00.32 transcode
>  5369 paolo     20   0 20356 1144  920 S  0.5  0.2   0:00.14 tcdemux
>  5205 root      20   0  165m  15m 2584 R  0.2  3.2   0:01.86 X
> 

Yes, no surprises there.

> 
> 	4) spa_ws: bad
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5334 paolo     32   0  115m  18m 2428 R 82.7  3.7   0:18.77 transcode
>  5349 paolo     32   0 50348 4516 1912 R  8.9  0.9   0:02.00 tcdecode
>  5338 paolo     21   0  115m  18m 2428 S  4.6  3.7   0:01.08 transcode
>  5356 paolo     32   0  4948 1520  412 D  1.1  0.3   0:00.12 dd
>  5351 paolo     32   0  115m  18m 2428 S  1.0  3.7   0:00.20 transcode
>  5199 root      21   0  165m  15m 2584 S  0.4  3.2   0:01.68 X
>  5347 paolo     32   0 20356 1140  920 S  0.4  0.2   0:00.08 tcdemux
>  5296 paolo     22   0 98472  37m 9392 S  0.2  7.5   0:01.47 perl
>  5299 paolo     21   0 86556  22m  15m S  0.2  4.4   0:00.75 konsole
>  5344 paolo     32   0 47308 2540 1996 S  0.2  0.5   0:00.07 tcdecode
>  5339 paolo     21   0  115m  18m 2428 S  0.1  3.7   0:00.01 transcode
> 
> paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile
> of=/dev/null bs=1M count=256; umount space/ 256+0 records in
> 256+0 records out
> 
> real    0m8.112s
> user    0m0.001s
> sys     0m0.444s
> 
> paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile
> of=/dev/null bs=1M count=256; umount space/ 256+0 records in
> 256+0 records out
> 
> real    0m29.222s
> user    0m0.000s
> sys     0m0.400s

This one is aimed purely at good interactive responsiveness (i.e. 
keyboard, mouse, X server and media players such as rythmbox/xmms) so no 
real surprises here either.

> 
> 
> 	5) spa_svr: surprise, surprise! Not all that bad. At least DD
> gets better priority than transcode... and DD real time is only a bit
> affected (8s --> ~9s).
>

This will be the "throughput bonus" in action.  It's overall aim is to 
reduce the time tasks spend on the runqueue waiting for CPU access 
a.k.a. delay.  It does this by using the system load and the average 
amount of CPU time that the task uses each scheduling cycle to estimate 
the expected delay for the task and gives it a bonus if the actual 
average delays being experienced are bigger than this value.

It's intended for server systems not interactive systems as reducing 
overall delay isn't necessarily good for interactive systems where the 
aim is to quell the user's impatience by giving good latency to the 
interactive tasks.  These aims aren't always compatible.

> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5334 paolo     33   0  115m  18m 2428 R 78.1  3.7   0:22.70 transcode
>  5349 paolo     28   0 50352 4516 1912 S  9.0  0.9   0:02.41 tcdecode
>  5338 paolo     25   0  115m  18m 2428 S  4.7  3.7   0:01.29 transcode
>  5363 paolo     27   0  4952 1520  412 R  4.7  0.3   0:00.25 dd
>  5342 paolo     33   0 20352 1140  920 S  1.6  0.2   0:00.21 tcdemux
>  5351 paolo     25   0  115m  18m 2428 S  0.8  3.7   0:00.23 transcode
>  5144 root      22   0  166m  16m 3120 S  0.4  3.3   0:01.85 X
>  5344 paolo     23   0 47308 2540 1996 S  0.4  0.5   0:00.13 tcdecode
>  5347 paolo     27   0 20356 1144  920 S  0.4  0.2   0:00.10 tcdemux
>  5231 paolo     22   0 86660  22m  15m S  0.2  4.5   0:00.95 konsole
>  5271 paolo     25   0 98476  37m 9396 S  0.2  7.5   0:01.54 perl
>  5341 paolo     23   0 22672 1268 1020 S  0.2  0.2   0:00.02 tccat
> 
> 
> 	6) zaphod: more or less like spa_svr

Zaphod includes the throughput bonus in its armoury which why it is 
similar in performance to spa_svr.

> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5308 paolo     34   0  115m  18m 2428 R 52.1  3.7   0:49.77 transcode
>  5323 paolo     32   0 50352 4516 1912 S  6.0  0.9   0:05.61 tcdecode
>  5356 paolo     28   0  4952 1520  412 D  3.5  0.3   0:00.28 dd
>  5312 paolo     28   0  115m  18m 2428 S  2.6  3.7   0:02.71 transcode
>  5325 paolo     31   0  115m  18m 2428 S  0.7  3.7   0:00.55 transcode
>  5316 paolo     37   0 20352 1140  920 S  0.4  0.2   0:00.33 tcdemux
>  5202 root      23   0  165m  15m 2584 S  0.2  3.1   0:01.57 X
>  5318 paolo     31   0 47312 2540 1996 S  0.2  0.5   0:00.28 tcdecode
>  5321 paolo     33   0 20356 1144  920 S  0.2  0.2   0:00.26 tcdemux
>  4760 messageb  25   0 13248 1068  848 S  0.1  0.2   0:00.07
> dbus-daemon-1 5264 paolo     24   0 93920  17m  10m S  0.1  3.5
> 0:00.38 kded 5282 paolo     23   0 92712  19m  12m S  0.1  3.9
> 0:00.36 kdesktop
> 
> 
> 	7) ingosched: bad, as already said in the original post
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5209 paolo     16   0  115m  18m 2428 R 72.0  3.7   0:22.13 transcode
>  5224 paolo     22   0 50348 4516 1912 R  8.4  0.9   0:02.44 tcdecode
>  5213 paolo     15   0  115m  18m 2428 S  4.2  3.7   0:01.24 transcode
>  5243 paolo     18   0  4948 1520  412 R  1.8  0.3   0:00.14 dd
>  5217 paolo     19   0 20356 1144  920 R  0.8  0.2   0:00.19 tcdemux
>  5108 root      15   0  165m  15m 2584 S  0.6  3.1   0:01.44 X
>  5226 paolo     15   0  115m  18m 2428 S  0.6  3.7   0:00.20 transcode
>  5216 paolo     18   0 22676 1268 1020 S  0.4  0.2   0:00.03 tccat
>  5219 paolo     18   0 47312 2540 1996 R  0.4  0.5   0:00.12 tcdecode
>  5222 paolo     18   0 20356 1144  920 S  0.4  0.2   0:00.10 tcdemux
>  5195 paolo     16   0 98488  37m 9392 S  0.2  7.5   0:01.41 perl
>  5198 paolo     16   0 86552  22m  15m R  0.2  4.4   0:00.66 konsole
> 
> paolo@tux /mnt $ mount space/; sync; sleep 1; time dd if=space/bigfile of=/dev/null bs=1M count=256; umount space/
> 256+0 records in
> 256+0 records out
> 
> real    0m23.393s	(instead of 8s)
> user    0m0.001s
> sys     0m0.418s
> 
> ------------------------------------------------------------------------
> 
> 
> So the winner for manifest superiority is "nicksched", it looks to me
> even better than 2.6.10-bk12 (ingosched) with
> "remove_interactive_credit" reverted.

Thanks for this data.  It will enable me to make some mods to the 
spa_xxx and zaphod schedulers.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
