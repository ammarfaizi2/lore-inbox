Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288599AbSADLNs>; Fri, 4 Jan 2002 06:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288598AbSADLN3>; Fri, 4 Jan 2002 06:13:29 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:45556 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288597AbSADLN2>; Fri, 4 Jan 2002 06:13:28 -0500
Date: Fri, 4 Jan 2002 06:16:50 -0500
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020104061650.A22264@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I tried the new scheduler with the kdev_t patch you mentioned and it
went very well for a long time.  dbench 64, 128, 192 all completed,
3 iterations of bonnie++ were fine too.

When I ran the syscalls test from the http://ltp.sf.net/ I had a 
few problems.

The first time the machine rebooted.  The last thing in the logfile
was that pipe11 test was running.  I believe it got past that point.
(the syscall tests run in alphabetic order).

The second time I ran it, when I was tailing the output the 
machine seemed to freeze.  (Usually the syscall tests complete
very quickly).  I got the oops below on a serial console, it
scrolled much longer and didn't seem to like the call trace
would ever complete, so i rebooted.

I ran it a third time trying to isolate which test triggered the oops,
but the behavior was different again.  The machine got very very
slow, but tests would eventually print their output.  The test that 
triggered the behavior was apparently between pipe11 and the setrlimit01 
command below.

Here is top in the locked state:

33 processes: 23 sleeping, 4 running, 6 zombie, 0 stopped
CPU states:  0.3% user,  0.0% system,  0.0% nice, 99.6% idle
Mem:   385344K av,   83044K used,  302300K free,       0K shrd,   51976K buff
Swap:  152608K av,       0K used,  152608K free                   16564K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
   50 root      55   0  1620 1620  1404 R     0.1  0.4   0:05 sshd
 8657 root      47   0   948  948   756 R     0.1  0.2   0:00 top
    1 root      46   0   524  524   452 S     0.0  0.1   0:06 init
    2 root      63   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      63  19     0    0     0 RWN   0.0  0.0   0:00 ksoftirqd_CPU0
    4 root      63   0     0    0     0 SW    0.0  0.0   0:00 kswapd
    5 root      63   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    6 root      47   0     0    0     0 SW    0.0  0.0   0:00 kupdated
    7 root      45   0     0    0     0 SW    0.0  0.0   0:00 kreiserfsd
   28 root      45   0   620  620   516 S     0.0  0.1   0:00 syslogd
   31 root      46   0   480  480   404 S     0.0  0.1   0:00 klogd
   35 root      47   0     0    0     0 SW    0.0  0.0   0:00 eth0
   40 root      49   0   816  816   664 S     0.0  0.2   0:00 iplog
   41 root      46   0   816  816   664 S     0.0  0.2   0:00 iplog
   42 root      45   0   816  816   664 S     0.0  0.2   0:00 iplog
   43 root      45   0   816  816   664 S     0.0  0.2   0:00 iplog
   44 root      58   0   816  816   664 S     0.0  0.2   0:01 iplog
   46 root      53   0  1276 1276  1156 S     0.0  0.3   0:00 sshd
   48 root      46   0   472  472   396 S     0.0  0.1   0:00 agetty
   51 hrandoz   49   0  1164 1164   892 S     0.0  0.3   0:00 bash
   59 root      46   0  1184 1184  1028 S     0.0  0.3   0:00 bash
  702 root      45   0  1224 1224  1028 S     0.0  0.3   0:01 bash
 8564 root      63   0  1596 1596  1404 S     0.0  0.4   0:00 sshd
 8602 root      46   0   472  472   396 S     0.0  0.1   0:00 agetty
 8616 hrandoz   63   0  1164 1164   892 S     0.0  0.3   0:00 bash
 8645 root      49   0  1152 1152   888 S     0.0  0.2   0:00 bash
 8647 root      46   0   468  468   388 R     0.0  0.1   0:00 setrlimit01
 8649 root      46   0     0    0     0 Z     0.0  0.0   0:00 setrlimit01 <defunct>
 8650 root      46   0     0    0     0 Z     0.0  0.0   0:00 setrlimit01 <defunct>
 8651 root      46   0     0    0     0 Z     0.0  0.0   0:00 setrlimit01 <defunct>
 8658 root      46   0     0    0     0 Z     0.0  0.0   0:00 setrlimit01 <defunct>
 8659 root      46   0     0    0     0 Z     0.0  0.0   0:00 setrlimit01 <defunct>
 8660 root      46   0     0    0     0 Z     0.0  0.0   0:00 setrlimit01 <defunct>

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
 Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = c024be44
Oops: 0002
CPU:    0
EIP:    0010:[<c024c06d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: d6184000   ecx: d6184290   edx: d6184290
esi: c024be3c   edi: d6184001   ebp: d6185f98   esp: c024c06c
ds: 0018   es: 0018   ss: 0018
Process  (pid: 0, stackpage=c024b000)
Stack: c024c06c c024c06c c024c074 c024c074 c024c07c c024c07c c024c084 c024c084
       c024c08c c024c08c c024c094 c024c094 c024c09c c024c09c c024c0a4 c024c0a4
       c024c0ac c024c0ac c024c0b4 c024c0b4 c024c0bc c024c0bc c024c0c4 c024c0c4
Code: c0 24 c0 6c c0 24 c0 74 c0 24 c0 74 c0 24 c0 7c c0 24 c0 7c

>>EIP; c024c06c <rt_array+28c/340>   <=====
Code;  c024c06c <rt_array+28c/340>
00000000 <_EIP>:
Code;  c024c06c <rt_array+28c/340>   <=====
   0:   c0 24 c0 6c               shlb   $0x6c,(%eax,%eax,8)   <=====
Code;  c024c070 <rt_array+290/340>
   4:   c0 24 c0 74               shlb   $0x74,(%eax,%eax,8)
Code;  c024c074 <rt_array+294/340>
   8:   c0 24 c0 74               shlb   $0x74,(%eax,%eax,8)
Code;  c024c078 <rt_array+298/340>
   c:   c0 24 c0 7c               shlb   $0x7c,(%eax,%eax,8)
Code;  c024c07c <rt_array+29c/340>
  10:   c0 24 c0 7c               shlb   $0x7c,(%eax,%eax,8)

CPU:    0
EIP:    0010:[<c01110b5>]    Not tainted
EFLAGS: 00010086
eax: c0000000   ebx: c0248000   ecx: c024ca58   edx: 01400000
esi: 00000000   edi: c0110c48   ebp: c1400000   esp: c0247fb8
ds: 0018   es: 0018   ss: 0018
Process $.#. (pid: 5373, stackpage=c0247000)
Stack: c0248000 00000000 c0110c48 c1400000 00000000 00000000 c0246000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000000
Call Trace: [<c0110c48>]
Code: f6 04 10 81 0f 84 02 fe ff ff 5b 5e 5f 5d 81 c4 8c 00 00 00

>>EIP; c01110b4 <do_page_fault+46c/488>   <=====
Trace; c0110c48 <do_page_fault+0/488>
Code;  c01110b4 <do_page_fault+46c/488>
00000000 <_EIP>:
Code;  c01110b4 <do_page_fault+46c/488>   <=====
   0:   f6 04 10 81               testb  $0x81,(%eax,%edx,1)   <=====
Code;  c01110b8 <do_page_fault+470/488>
   4:   0f 84 02 fe ff ff         je     fffffe0c <_EIP+0xfffffe0c> c0110ec0 <do_page_fault+278/488>
Code;  c01110be <do_page_fault+476/488>
   a:   5b                        pop    %ebx
Code;  c01110be <do_page_fault+476/488>
   b:   5e                        pop    %esi
Code;  c01110c0 <do_page_fault+478/488>
   c:   5f                        pop    %edi
Code;  c01110c0 <do_page_fault+478/488>
   d:   5d                        pop    %ebp
Code;  c01110c2 <do_page_fault+47a/488>
   e:   81 c4 8c 00 00 00         add    $0x8c,%esp

CPU:    0
EIP:    0010:[<c0180e93>]    Not tainted
EFLAGS: 00010002
eax: c1604120   ebx: 00000000   ecx: c0203cc0   edx: 00000000
esi: 00000000   edi: c0108e1c   ebp: c1400000   esp: c0247f30
ds: 0018   es: 0018   ss: 0018
Process $.#. (pid: 5373, stackpage=c0247000)
Stack: 0000000f 00000000 c0110bfb 00000000 c0108afe 00000000 c0247f84 c01dcccd
       c01dcd1f 00000000 00000001 c0247f84 c0108e70 c01dcd1f c0247f84 00000000
       c0246000 00000000 c0108684 c0247f84 00000000 c0248000 c024ca58 01400000
Call Trace: [<c0110bfb>] [<c0108afe>] [<c0108e70>] [<c0108684>] [<c0110c48>]
   [<c01110b5>] [<c0110c48>]
Code: 80 78 04 00 75 7f 8b 15 a0 90 20 c0 c7 05 44 1c 26 c0 1c 0f

>>EIP; c0180e92 <unblank_screen+4e/d8>   <=====
Trace; c0110bfa <bust_spinlocks+22/4c>
Trace; c0108afe <die+42/50>
Trace; c0108e70 <do_double_fault+54/5c>
Trace; c0108684 <error_code+34/40>
Trace; c0110c48 <do_page_fault+0/488>
Trace; c01110b4 <do_page_fault+46c/488>
Trace; c0110c48 <do_page_fault+0/488>
Code;  c0180e92 <unblank_screen+4e/d8>
00000000 <_EIP>:
Code;  c0180e92 <unblank_screen+4e/d8>   <=====
   0:   80 78 04 00               cmpb   $0x0,0x4(%eax)   <=====
Code;  c0180e96 <unblank_screen+52/d8>
   4:   75 7f                     jne    85 <_EIP+0x85> c0180f16 <unblank_screen+d2/d8>
Code;  c0180e98 <unblank_screen+54/d8>
   6:   8b 15 a0 90 20 c0         mov    0xc02090a0,%edx
Code;  c0180e9e <unblank_screen+5a/d8>
   c:   c7 05 44 1c 26 c0 1c      movl   $0xf1c,0xc0261c44
Code;  c0180ea4 <unblank_screen+60/d8>
  13:   0f 00 00 

CPU:    0
EIP:    0010:[<c0180e93>]    Not tainted
EFLAGS: 00010002
eax: c1604120   ebx: 00000000   ecx: c0203cc0   edx: 00000000
esi: 00000000   edi: c0108e1c   ebp: c1400000   esp: c0247ea8
ds: 0018   es: 0018   ss: 0018
Process $.#. (pid: 5373, stackpage=c0247000)
Stack: 0000000f 00000000 c0110bfb 00000000 c0108afe 00000000 c0247efc c01dcccd
       c01dcd1f 00000000 00000001 c0247efc c0108e70 c01dcd1f c0247efc 00000000
       c0246000 00000000 c0108684 c0247efc 00000000 00000000 c0203cc0 00000000
Call Trace: [<c0110bfb>] [<c0108afe>] [<c0108e70>] [<c0108684>] [<c0108e1c>]
   [<c0180e93>] [<c0110bfb>] [<c0108afe>] [<c0108e70>] [<c0108684>] [<c0110c48>]
   [<c01110b5>] [<c0110c48>]
Code: 80 78 04 00 75 7f 8b 15 a0 90 20 c0 c7 05 44 1c 26 c0 1c 0f


It looks like you already have an idea where the problem is.
Looking forward to the next patch.  :)
-- 
Randy Hron

