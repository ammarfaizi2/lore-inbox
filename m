Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVFPPH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVFPPH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVFPPH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:07:58 -0400
Received: from unicorn.rentec.com ([216.223.240.9]:4856 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S261669AbVFPPHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:07:49 -0400
X-Rentec: external
From: Wolfgang Wander <wwc@rentec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17073.38338.924758.578274@gargle.gargle.HOWL>
Date: Thu, 16 Jun 2005 11:07:46 -0400
To: linux-kernel@vger.kernel.org
Subject: problem with gdb back-traces on AMD64 (32 bit executables)
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
X-Logged: Logged by unicorn.rentec.com as j5GF7lZh020385 at Thu Jun 16 11:07:48 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is regarding a gdb problem regarding stack back-traces with
AMD64 and -m32 compiled executables.  When the program receives
a signal inside a shared library of an m32 executable (or if 
one attaches to such a program and it executes a shared library
function) back traces are useless.

I'm sending this to the kernel list for two reasons:

  a) the gdb maintainers have not shown any interest in the issue, yet
     ;-), maybe because of b)
  b) the problem only affects 2.6 kernels, 2.4 kernels are fine.

How to reproduce:  Compile the following test code on an AMD64 machine

---------test.c-----------------
#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
  alarm(1);
  sleep(5);
  return 0;
}
--------------------------------
into

gcc -m32 test.c -o test-32-shared
gcc test.c -o test-64-shared
gcc -m32 -static test.c -o test-32-static
gcc -static test.c -o test-64-static

If this is done on a 2.4 machine, everything works as expected.
Furthermore on a 2.6 machine all but the first (test-32-shared)
executable can be debugged as expected.

$  uname -a
Linux monstert08.rentec.com 2.6.12-rc6-mm1 #2 SMP Tue Jun 7 10:32:52 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
$
$
$ /usr/bin/gdb test-64-static
GNU gdb 6.2.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "x86_64-suse-linux"...Using host libthread_db library "/lib64/tls/libthread_db.so.1".

(gdb) handle SIGALRM stop print 
Signal        Stop      Print   Pass to program Description
SIGALRM       Yes       Yes     Yes             Alarm clock
(gdb) run
Starting program: /home/wwc/src/test-64-static 

Program received signal SIGALRM, Alarm clock.
0x0000000000406662 in nanosleep ()
(gdb) where
#0  0x0000000000406662 in nanosleep ()
#1  0x0000000000406593 in __sleep (seconds=0) at sleep.c:137
#2  0x00000000004002d7 in main ()
...



However the shared 32 bit executable generates a faulty back-trace:

$ /usr/bin/gdb test-32-shared 
GNU gdb 6.2.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "x86_64-suse-linux"...Using host libthread_db library "/lib64/tls/libthread_db.so.1".

(gdb) handle SIGALRM stop print 
Signal        Stop      Print   Pass to program Description
SIGALRM       Yes       Yes     Yes             Alarm clock
(gdb) run
Starting program: /home/wwc/src/test-32-shared 

Program received signal SIGALRM, Alarm clock.
0xffffe405 in ?? ()
(gdb) where
#0  0xffffe405 in ?? ()
#1  0xffffaa48 in ?? ()
#2  0x55615b30 in __nanosleep_nocancel () from /lib/tls/libc.so.6
#3  0x55615933 in sleep () from /lib/tls/libc.so.6
#4  0x0005faa8 in ?? ()
#5  0x00000000 in ?? ()
#6  0x00000000 in ?? ()
#7  0x00000000 in ?? ()
#8  0x00000000 in ?? ()
#9  0x080495fc in _DYNAMIC ()
#10 0x5556c3a0 in ?? ()
#11 0x00000000 in ?? ()
#12 0x00000000 in ?? ()
#13 0x00000000 in ?? ()
#14 0x00000000 in ?? ()
#15 0x00000000 in ?? ()
#16 0x00000000 in ?? ()
#17 0x5558e780 in ?? ()
#18 0xda9c7c76 in ?? ()
#19 0x00052bfa in ?? ()
#20 0x01000000 in ?? ()
#21 0x00000000 in ?? ()
#22 0x00000000 in ?? ()
#23 0x00000000 in ?? ()
#24 0x00000000 in ?? ()
#25 0x00000000 in ?? ()
#26 0x00000000 in ?? ()
#27 0x00000001 in ?? ()
#28 0x00000000 in ?? ()
#29 0x00000000 in ?? ()
#30 0x00000000 in ?? ()
#31 0x00000000 in ?? ()
#32 0x00000000 in ?? ()
#33 0x00000000 in ?? ()
#34 0x00000000 in ?? ()
#35 0x00000000 in ?? ()
#36 0xffffab88 in ?? ()
#37 0x00000000 in ?? ()
#38 0x00000000 in ?? ()
#39 0xab095750 in ?? ()
#40 0x00000000 in ?? ()
#41 0x00000000 in ?? ()
#42 0x00000000 in ?? ()
#43 0xffffa9ac in ?? ()
#44 0x5556c4f0 in ?? ()
#45 0x00000001 in ?? ()
#46 0x5558e2e0 in ?? ()
#47 0x00000001 in ?? ()
#48 0x00000000 in ?? ()
#49 0x00000001 in ?? ()
#50 0x00000000 in ?? ()
#51 0x00000000 in ?? ()
#52 0xffffa9bc in ?? ()
#53 0x5555cd5f in do_lookup_x () from /lib/ld-linux.so.2
Previous frame inner to this frame (corrupt stack?)

----------------------------------------------------------------------

Different versions of gdb (5.3...6.3)/gcc(2.95...4.0) are not
affecting the outcome.  Different 2.6 kernels behave similarly, 2.4
kernels do not exhibit this problem.

Does anyone have a hint as to why 2.6 shows a regression here?

                    Wolfgang
