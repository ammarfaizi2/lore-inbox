Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272744AbTG1Igc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272745AbTG1Igc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:36:32 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:43793 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S272744AbTG1IgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:36:16 -0400
Message-Id: <200307280841.h6S8fkj21459@Port.imtp.ilyichevsk.odessa.ua>
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Need a meaningful memory measure out of /proc/meminfo
Date: Mon, 28 Jul 2003 11:51:09 +0300
X-Mailer: KMail [version 1.3.2]
Cc: thomasez@zelow.no
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9L8QD82TLX8HPJ74Y5D1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_9L8QD82TLX8HPJ74Y5D1
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8bit

Hi. I want to calculate and give to user a terse info
(one or just a couple of numbers) about current memory
consumption. Since today's kernels typically use almost
all RAM for cacheing it is useless to just report amount
of RAM in use, it's nearly always is $total_ram-10k.

As a first approximation I took amount of allocated RAM
which will survive oom. Look (zero swap/highmem snipped):

$ cat /proc/meminfo;./oom;cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  262057984 235958272 26099712        0  3977216 126554112
Swap:        0        0        0
MemTotal:       255916 kB
MemFree:         25488 kB
MemShared:           0 kB
Buffers:          3884 kB
Cached:         123588 kB
Active:          65148 kB
Inactive:       144760 kB
LowTotal:       255916 kB
LowFree:         25488 kB
./oom: Killed
        total:    used:    free:  shared: buffers:  cached:
Mem:  262057984 108625920 153432064        0   479232  9801728
Swap:        0        0        0               ^        ^
MemTotal:       255916 kB                      |        |
MemFree:        149836 kB                      |        |
MemShared:           0 kB                      |        |
Buffers:           468 kB <-------- less than 1M        |
Cached:           9572 kB <-------- a 10M---------------+
Active:          24220 kB
Inactive:        68248 kB
LowTotal:       255916 kB
LowFree:        149836 kB

Ok, so I use Used-Buffers-Cached as a memory measure.
It remains almost unchanged across oom.

Although I am worried that I can lie to user because above test
shows that some 10M of buffers+cached are not really freeable.
Also I run this box swapless, what to do with swap numbers?

Please share your thoughs.

----BEGIN SHAMELESS PLUG SECTION----
Why do I need this? I found a little cute utility, nanotop,
in floppyfw project. It shows cpu load, mem load and eth load,
one line every second.

I started to play with it. I improved ability to parse command line,
specify update period, cpu bar size, which interface(s) to report,
made output even more terse. And hopefully made mem output somewhat
more meaningful.

Code is reworked to completely avoid <stdio.h> and made modular.
You can add code to monitor something else real easy now, swap
is already planned for 0.2 ;)

This toy compiles to a static binary under 4k with dietlibc.

I renamed it to nanometer, it really has not much in common with top.
Source and precompiled binary is in attached tarball.

Compare for yourself:

# ./nanotop
CPU [          ] MEM 219.6MB eth0:  35.00B/s rcv  18.00B/s snd  0 err
CPU [-         ] MEM 219.6MB eth0:   6.7kB/s rcv   1.6kB/s snd  0 err
CPU [-         ] MEM 219.6MB eth0:   4.8kB/s rcv   4.0kB/s snd  0 err
CPU [-         ] MEM 219.6MB eth0:   5.3kB/s rcv   1.5kB/s snd  0 err
CPU [-         ] MEM 219.6MB eth0:   3.6kB/s rcv   2.4kB/s snd  0 err
CPU [=-        ] MEM 219.6MB eth0:  74.3kB/s rcv  62.5kB/s snd  0 err
CPU [-         ] MEM 219.6MB eth0:   3.4kB/s rcv   2.4kB/s snd  0 err

# ./nanometer c m ieth0 ilo ieth1
cpu [??????????] mem  78M eth0   0    0  lo   0    0  eth1 ???? ????
cpu [..........] mem  78M eth0 4.0k 2.4k lo   0    0  eth1 ???? ????
cpu [..........] mem  78M eth0 9.6k 2.6k lo   0    0  eth1 ???? ????
cpu [UU........] mem  78M eth0  78k  64k lo 140  140  eth1 ???? ????
cpu [U.........] mem  78M eth0 7.6k 4.8k lo   0    0  eth1 ???? ????
cpu [UU........] mem  78M eth0 4.7k 9.2k lo   0    0  eth1 ???? ????
cpu [..........] mem  78M eth0 1.6k 1.3k lo   0    0  eth1 ???? ????
cpu [U.........] mem  78M eth0  10k 3.7k lo   0    0  eth1 ???? ????
cpu [..........] mem  78M eth0 152k 129k lo 140  140  eth1 ???? ????
cpu [SUUU......] mem  78M eth0 257k 171k lo   0    0  eth1 ???? ????
cpu [UUUUU.....] mem  78M eth0 352k 303k lo   0    0  eth1 ???? ????
cpu [SUUUU.....] mem  78M eth0 236k 232k lo   0    0  eth1 ???? ????
----END SHAMELESS PLUG SECTION----
--
vda
--------------Boundary-00=_9L8QD82TLX8HPJ74Y5D1
Content-Type: application/x-gzip;
  name="nanometer-0.1.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nanometer-0.1.tar.gz"

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

--------------Boundary-00=_9L8QD82TLX8HPJ74Y5D1--
