Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSGXUAh>; Wed, 24 Jul 2002 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSGXUAh>; Wed, 24 Jul 2002 16:00:37 -0400
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:17338 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S317500AbSGXT7w>; Wed, 24 Jul 2002 15:59:52 -0400
Date: Wed, 24 Jul 2002 16:02:57 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
cc: rml@tech9.net
Subject: 2.5.27: PREEMPT + DEBUG_SLAB = 100% reproducable oops
Message-ID: <Pine.LNX.4.43.0207241554360.1846-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.5.26/27, if I compile in PREEMPT=y and CONFIG_DEBUG_SLAB=y,
I can oops the machine at will by running a small shell script as a normal
user. If I undef either of those, the machine is fine. It always oops in
the same place.

(gdb) list *0xc010e88f
0xc010e88f is in schedule
(/biggie/kernel/linux-2.5.27/include/asm/bitops.h:39).
34       * Note that @nr may be almost arbitrarily large; this function is not
35       * restricted to acting on a single-word quantity.
36       */
37      static __inline__ void set_bit(int nr, volatile unsigned long * addr)
38      {
39              __asm__ __volatile__( LOCK_PREFIX
40                      "btsl %1,%0"
41                      :"=m" (ADDR)
42                      :"Ir" (nr));
43      }


Unable to handle kernel paging request at virtual address 5a5a5ace
c010e88f
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c010e88f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010813
eax: c11ce000   ebx: c4b55580   ecx: c11d0040   edx: 5a5a5a5a
esi: c4e51084   edi: c11d0040   ebp: c11cfed8   esp: c11cfec8
ds: 0018   es: 0018   ss: 0018
Stack: 7fffffff c4e560a4 c11cff60 c11d0040 c4e55000 c0119100 00000008 c4e560a4
       00000000 00000246 c4e55980 c4e560a4 c01aefe4 c01af034 c4e55000 c4e560a4
       c4e845e0 c4e560c4 c4e55bfc c4e55980 080df014 c4e55974 7fffffff 00000000
Call Trace: [<c0119100>] [<c01aefe4>] [<c01af034>] [<c010e9c4>] [<c010e9c4>]
   [<c01aada4>] [<c0132d40>] [<c0132ef6>] [<c0106c9f>]
Code: 0f ba 6a 74 00 8b 42 0c 05 00 00 00 40 0f 22 d8 8b 8a 80 00


>>EIP; c010e88f <schedule+1b7/2b4>   <=====

>>eax; c11ce000 <END_OF_CODE+e8d604/????>
>>ebx; c4b55580 <END_OF_CODE+4814b84/????>
>>ecx; c11d0040 <END_OF_CODE+e8f644/????>
>>edx; 5a5a5a5a Before first symbol
>>esi; c4e51084 <END_OF_CODE+4b10688/????>
>>edi; c11d0040 <END_OF_CODE+e8f644/????>
>>ebp; c11cfed8 <END_OF_CODE+e8f4dc/????>
>>esp; c11cfec8 <END_OF_CODE+e8f4cc/????>

Trace; c0119100 <schedule_timeout+14/a4>
Trace; c01aefe4 <change_termios+90/180>
Trace; c01af034 <change_termios+e0/180>
Trace; c010e9c4 <default_wake_function+0/34>
Trace; c010e9c4 <default_wake_function+0/34>
Trace; c01aada4 <release_dev+16c/50c>
Trace; c0132d40 <register_chrdev+54/dc>
Trace; c0132ef6 <chrdev_open+7e/94>
Trace; c0106c9f <syscall_call+7/b>

Code;  c010e88f <schedule+1b7/2b4>
00000000 <_EIP>:
Code;  c010e88f <schedule+1b7/2b4>   <=====
   0:   0f ba 6a 74 00            btsl   $0x0,0x74(%edx)   <=====
Code;  c010e894 <schedule+1bc/2b4>
   5:   8b 42 0c                  mov    0xc(%edx),%eax
Code;  c010e897 <schedule+1bf/2b4>
   8:   05 00 00 00 40            add    $0x40000000,%eax
Code;  c010e89c <schedule+1c4/2b4>
   d:   0f 22 d8                  mov    %eax,%cr3
Code;  c010e89f <schedule+1c7/2b4>
  10:   8b 8a 80 00 00 00         mov    0x80(%edx),%ecx


Oddily enough, running this on the command prompt won't cause problems,
but running it at a shell script will causes an oops every single time.

#!/bin/sh
start-stop-daemon --start --quiet --pidfile /tmp/xfs.pid --exec /home/bwindle/xfs-bin -- -daemon

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461



