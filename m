Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCTSdN>; Tue, 20 Mar 2001 13:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130721AbRCTSdD>; Tue, 20 Mar 2001 13:33:03 -0500
Received: from purgator.ipmce.su ([192.124.182.198]:36030 "HELO ipmce.su")
	by vger.kernel.org with SMTP id <S130686AbRCTSc7>;
	Tue, 20 Mar 2001 13:32:59 -0500
Message-ID: <3AB7A169.53F4E4BB@con.mcst.ru>
Date: Tue, 20 Mar 2001 21:28:57 +0300
From: Serge Orlov <sorlov@con.mcst.ru>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>, sorlov@mcst.ru
Subject: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,
I upgraded one of our computer happily running 2.2.13 kernel
to 2.4.2. Everything was OK, but compilation time of our C++
project greatly increased (1.4 times slower). I investigated the
issue and found that g++ spends 7 times more time in kernel.
The reason for this is big vm map:

cat /proc/15677/maps |wc -l
   2238

15677 -- is cc1plus process, the map looks like this:
.....
4014a000-4014b000 rw-p 00000000 00:00 0
4014b000-4014c000 rw-p 00000000 00:00 0
4014c000-4014d000 rw-p 00000000 00:00 0
4014d000-4014e000 rw-p 00000000 00:00 0
4014e000-4014f000 rw-p 00000000 00:00 0
4014f000-40150000 rw-p 00000000 00:00 0
40150000-40151000 rw-p 00000000 00:00 0
40151000-40152000 rw-p 00000000 00:00 0
......
strace:
.....
15677 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40019000
15677 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40019000
15677 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001a000
15677 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001b000
15677 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001c000
15677 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4001d000
.......

2.4.2:
time g++ -g -Wall -I. -c t_instr.cpp -o t_instr.o

real    0m3.434s
user    0m2.790s
sys     0m0.530s

2.2.13:
time g++ -g -Wall -I.  -c t_instr.cpp -o t_instr.o

real    0m3.167s
user    0m2.950s
sys     0m0.070s

I noticed a recent thread (Re: Kernel is unstable) in archives that
ended by Linus:
--- quote ---
Ehh.. If the merging doesn't actually happen, it's always a loss. We've
just spent CPU cycles on doing something useless. And in my tests, that
was the case a lot more than not.

Also, in the expense of taking a page fault, looking one or two levels
deeper in the AVL tree is pretty much not noticeable.

Show me numbers for real applications, and I might care. I saw barely
measurable speedups (and more importantly to me - real simplification)
by
removing it.

Don't bother arguing with "it might.."

                Linus
--- end of quote ----

OK, the numbers are here. g++ is 2.96 from RedHat 7.0.
Please, CC me, as I'm not on the list.

   Serge.


