Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265628AbUEZPvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUEZPvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 11:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbUEZPvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 11:51:12 -0400
Received: from 62-15-228-226.inversas.jazztel.es ([62.15.228.226]:53136 "EHLO
	servint.tedial.com") by vger.kernel.org with ESMTP id S265629AbUEZPuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 11:50:39 -0400
From: Antonio Larrosa =?iso-8859-1?q?Jim=E9nez?= <antlarr@tedial.com>
Organization: Tedial
Subject: iowait problems on 2.6, not on 2.4
Date: Wed, 26 May 2004 17:43:28 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405261743.28111.antlarr@tedial.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm doing some benchmarking for my company with our own applications, and I 
got some unexpected results (sorry for the long mail, but I think it's faster 
to provide as much feedback as I can on the first mail).

The machine is a 4 cpu Pentium III (Cascades) system with 
four SCSI SEAGATE ST336704 hard disks connected to an Adaptec AIC-7899P 
U160/m, and a external RAID connected to a QLA2200/QLA2xxx FC-SCSI Host Bus 
Adapter. The machine has 1Gb RAM.

I did two fresh test installations on that machine:

1. SuSE 9.0    (kernel 2.4.21 smp)

Using one partition on the first HD for the root partition,
the second HD for oracle
first half of the RAID device for the data storage
all the filesystems use ext3 (with defaults option in fstab)

2. SuSE 9.1   (kernel 2.6.4 smp)

Using another partition on the first HD for the root partition,
the third HD for oracle
the second partition on the RAID device for the data storage
all the filesystems use reiserfs (with acl,user_xattr,notail options in fstab)

Only the swap partition (on the first HD) is shared between both 
installations.

The application I'm benchmarking forks 4 childs who read a big file (all read 
the same 1Gb file in these tests), they analyse it, and write the result eacg 
child to a different file (also on the same partition) while they analyse, 
when one of this childs finishes (they take some seconds when running in 
solitaire) the parent forks another one, until it does 500 analysis.

The problem I have is that the application takes twice as long to finish on 
2.6.4 than on 2.4.21.

Looking at top, I can see that on the 2.4.21 system, the 4 processes that 
actually do the work at once are getting nearly 90% of the cpu, and the whole 
500 tasks finishes in around 53 minutes.

But on the 2.6.4 system, the 4 processes rarely go over 10% of cpu usage each, 
while io-wait is usually between 80% and 98%. The result is that the same 
operation now takes over 2 hours (2h 10m). I know that previously "io-wait" 
was just inside "idle", but why then the 2.4 kernel had idle so low compared 
to io-wait ?

Would that mean I have some problem with the kernel? I've tried to use noapic 
and acpi=off but got the same results (once I found a hyperthreading machine 
were cpu usage was constantly at 25% unless I used noapic, so I first thought 
this was related). I also tried to use the ext3 data partition instead of the 
reiserfs one on suse 9.1 (just to check that it wasn't a filesystem issue), 
and still the same result (over 2 hours to complete the task).

The cpu usage was something like this on 2.4 while the 4 processes were 
running:
load average: 4.62, 2.46, 0.98
Cpu(s):   0.2% user,  73.7% system,   0.2% nice,  25.9% idle
with some oscillation of idle and system (but idle almost never got over 30%)

While on 2.6 it was basically like this all the time:
load average: 13.66, 9.75, 5.01
Cpu(s):  0.3% us,  6.2% sy,  0.0% ni,  3.0% id, 90.0% wa,  0.1% hi,  0.3% si

I've seen other people getting slower performance on 2.6 than on 2.4 under 
special situations with some raids, so I wondered if it's because of some 
kernel/raid issue.

There have been other people with similar problems, and this case took my 
attention:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-11/417index.html
(althought it doesn't seem to be exactly the same problem)

I've done similar tests than those that were requested to the person who 
had that problem, both on 2.4 and 2.6 systems, I can provide the actual 
results if requested, but I'll just briefly comment them for brevity.
Note that from now on, I'm just doing some tests that are different from those 
for which I need some help for, but I hope they help to identify the problem.

On 2.6.4 with reiserfs, a "dd if=/dev/zero of=x bs=1M count=2048 ; sync" took 
23 seconds, and io/bo was mostly around 97000 blocks/s, the same on 2.6.4 
with the ext3 data partition got around 85000 (and took 29 seconds). The same 
test on 2.4.21 (ext3) took 30 seconds, but curiously, but io/bo wasn't 
anything like stable. Sometimes it was over 99000 and sometimes it only got 
24 blocks out, just to get 68000 on the next second (it always did that 
between running dd and sync, but I'm talking about doing it while dd is 
running).

On 2.6.4 with reiserfs, running "dd if=x of=/dev/null bs=1M count=2048 ; sync" 
takes 1m 26s, which is basically, the same than with ext3, both taking around 
24000 blocks/s on io/bi .
On this case, 2.4.21 (ext3) did much better than both, taking just 48s, and 
with an average of 43000 blocks/s on io/bi . This is nearly 1.8 times the 
speed of 2.6.4 on this RAID.

Finally, I tried benchmarking "dd if=x of=y bs=1M count=2048 ; sync"
and the result was: on 2.6.4, it took 1m57s, and in 2.4.21, just 1m30s on the 
same reiserfs partition.
In this case, the main difference I noticed on vmstat was that on 2.4.21, it 
seemed it was either reading or writing, with vmstat data like this:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  1 101740  13872  18328 892068    0    0 27648    28 1076   219  0 15 84  0
 2  1 101740  12492  18348 893476    0    0  9732 81540 1201   235  0  8 92  0
 0  1 101740  12956  18356 894964    0    0 10240 65296 1175   224  0 10 89  0
 1  0 101740  12944  18352 895116    0    0 32256    24 1087   231  0 18 82  0
 1  0 101740  12972  18352 895116    0    0 32768     0 1084   229  0 18 82  0
 0  1 101740  13020  17928 895412    0    0 31744     0 1080   222  0 18 82  0
 0  1 101740  13348  17932 894772    0    0 25092    24 1070   228  0 14 86  0
 0  2 101740  13516  17948 894528    0    0  9216 86992 1198   250  0  8 92  0
 1  0 101740  12744  17956 895752    0    0 14848 54060 1164   206  0 13 87  0
 1  0 101740  12636  17956 895624    0    0 33792    24 1089   242  0 18 82  0
 1  0 101740  13396  17956 894476    0    0 34304     0 1088   231  0 19 81  0
 0  1 101740  13108  17932 894384    0    0 34160     0 1090   261  0 19 81  0
 1  0 101740  13460  17932 893724    0    0 28308    24 1077   257  0 15 84  0
 0  2 101740  12552  17948 899252    0    0  5632 95664 1212   195  0  6 94  0
 1  0 101740  13484  17956 898180    0    0 13824 56456 1164   204  0 11 89  0

while on 2.6.4, it was more stable, writing and reading nearly in parallel:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  3 100064   6056  19260 936356    0    0 15232 24576 1254   576  0  6 51 42
 0  3 100064   5468  19272 936752    0    0 16000 20480 1263   612  0  7 50 44
 0  2 100064   5140  19288 938028    0    0 16640  2956 1253  1094  0  8 59 32
 1  1 100064   4564  19452 938272    0    0 20096 24280 1213   728  0  8 54 38
 0  2 100064   5844  19464 936900    0    0 13696 32716 1286   530  0  6 63 30
 1  1 100064   5844  19476 937500    0    0 11904 21704 1310   841  0  6 62 32
 0  2 100064   5964  19620 937016    0    0 20868 24444 1245   877  0  8 51 40
 0  2 100064   5396  19636 937408    0    0 16000 16384 1223   572  0  7 51 43
 0  2 100064   5012  19652 938140    0    0 15488  9852 1263   887  0  6 59 35
 0  2 100064   5716  19768 937208    0    0 19712 24512 1238   880  0  8 55 37
 0  2 100064   4692  19788 938072    0    0 17024 20424 1243   619  0  7 67 27
 0  3 100064   4628  19908 938224    0    0 14340 25860 1287  1372  0  9 59 32

I guess that for desktop systems, the 2.6.4 behaviour is better, but for a 
server, I'd prefer to improve long-term performance, so, any idea of what can 
I try in order to improve it?

In all the tests, "cron" and "at" were stopped.

My next test will be to do the "dd tests" on one of the internal hard disks 
and use it for the data instead of the external raid. If someone wants the 
result of those, please ask. I won't send them to the list unless someone 
asks for them or I find something of relevance.

Btw, our application doesn't use threads (just processes), and oracle is 
running, but it's not a critical part of the system (just handles a couple of 
queries for each working process on a very small table).

If really needed, I could try testing the latest kernel, or some patches, but 
since I've had a look at changelogs and didn't find anything related to this 
mentioned and I'd need a "certified kernel" for Oracle, I'd prefer to find a 
solution that works with the unmodified SuSE's kernel. 

Thanks for any help,

Even a "I've thought about it but cannot find a solution" will be welcomed.

Greetings,

--
Antonio Larrosa
Tecnologias Digitales Audiovisuales, S.L.
http://www.tedial.com
Parque Tecnologico de Andalucia . Málaga (Spain)
