Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264336AbRF2Xdl>; Fri, 29 Jun 2001 19:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263675AbRF2Xdc>; Fri, 29 Jun 2001 19:33:32 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:48688 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264303AbRF2XdS>; Fri, 29 Jun 2001 19:33:18 -0400
Date: Sat, 30 Jun 2001 01:28:38 +0200
From: thomas <list@huno.net>
X-Mailer: The Bat! (v1.52)
Reply-To: thomas <list@huno.net>
X-Priority: 3 (Normal)
Message-ID: <9427970950.20010630012838@huno.net>
To: linux-kernel@vger.kernel.org
Subject: [oops] ipppd/isdn
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have a very nasty bug that is troubling me for months now and it took
me till today to find out whats really causing the crashes and to
reproduce it. before i go on, the bug only appears with MPPP (two isdn
lines) enabled. so what happens is:

i connect to my ISP with MPPP enabled. no problem some far. after about
12hours my ISP will disconnect me (to enforce changing IPs). my isdn
connection will quit, but since i'm downloading something most of the
time it will try to reconnect immediately. but this reconnect will never
happen because the kernel will oops just at this postion:

Jun 29 23:30:21 knecht ipppd[237]: PHASE_WAIT -> PHASE_ESTABLISHED, ifunit: 0, l
Jun 29 23:30:21 knecht ipppd[237]: Remote message:
Jun 29 23:30:21 knecht ipppd[237]: MPPP negotiation, He: Yes We: Yes

every time. so i can reproduce it by just pulling the isdn cable out of
the isdn-card and the connection will timeout after a while. then i put
the cable back in, the isdn-card dials out and the kernel will ooops
again. i temporarely "fixed" it by disconneting/reconnecting the
connection via cron every 10 hours. so the bug only appears when ipppd
doesn't expect a disconnect and is kinda "surprised".

i've atached the unmodified oops, the oops through ksymoops and the
important stuff from syslog. i will provide more info if needed.

[1]the original oops:

isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_mp_receive: lpq->ppp_slot -1
isdn_ppp_xmit: lpq->ppp_slot -1
Unable to handle kernel paging request at virtual address 08066da0
 printing eip:
0804b232
*pde = 03634067
*pte = 01f3b065
Oops: 0007
CPU:    0
EIP:    0023:[<0804b232>]
EFLAGS: 00010202
eax: 0000033d   ebx: bffff5f4   ecx: 0806b718   edx: 00000000
esi: bffff614   edi: 08060b13   ebp: 080b70c0   esp: bffff594
ds: 002b   es: 002b   ss: 002b
Process ipppd (pid: 237, stackpage=c3711000)
 <0>Kernel panic: aiee, killing interrupt handler!
In interrupt handler - not syncing
 <6>SysRq: Emergency Sync
Syncing device 03:01 ... Scheduling in interrupt
kernel BUG at sched.c:714!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c010e33f>]
EFLAGS: 00010286
eax: 0000001b   ebx: c3711e74   ecx: c027a41c   edx: 00002075
esi: c1e7d660   edi: c3710000   ebp: c3711e60   esp: c3711e34
ds: 0018   es: 0018   ss: 0018
Process ipppd (pid: 237, stackpage=c3711000)
Stack: c022b456 000002ca c3711e74 c1e7d660 c3710000 c011415c c02efba0 c3711e74
       c1e7d660 00000000 c02efc04 00000001 c012b47a 000000ba c3877140 00000301
       00000000 c3710000 c1e7d6ac c1e7d6ac c012b61e c1e7d660 00000301 00000000
Call Trace: [<c011415c>] [<c012b47a>] [<c012b61e>] [<c012b73a>] [<c0192d1c>]
   [<c0192d7a>] [<c011018e>] [<c0112c6b>] [<c010d658>] [<c01070be>] [<c010d9a7>]

   [<c010d658>] [<c010f389>] [<c010fd59>] [<c01057c0>] [<c0106c58>]

Code: 0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 90 55 89 e5 83 ec 0c 57
 <0>Kernel panic: aiee, killing interrupt handler!
In interrupt handler - not syncing

[2]the oops through ksymoops:

ksymoops 2.3.4 on i586 2.4.5-ac21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac21/ (default)
     -m /boot/System.map-2.4.5-ac21 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01ddf20, System.map says c0146b60.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 08066da0
0804b232
*pde = 03634067
Oops: 0007
CPU:    0
EIP:    0023:[<0804b232>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 0000033d   ebx: bffff5f4   ecx: 0806b718   edx: 00000000
esi: bffff614   edi: 08060b13   ebp: 080b70c0   esp: bffff594
ds: 002b   es: 002b   ss: 002b
Process ipppd (pid: 237, stackpage=c3711000)
 <0>Kernel panic: aiee, killing interrupt handler!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c010e33f>]
EFLAGS: 00010286
eax: 0000001b   ebx: c3711e74   ecx: c027a41c   edx: 00002075
esi: c1e7d660   edi: c3710000   ebp: c3711e60   esp: c3711e34
ds: 0018   es: 0018   ss: 0018
Process ipppd (pid: 237, stackpage=c3711000)
Stack: c022b456 000002ca c3711e74 c1e7d660 c3710000 c011415c c02efba0 c3711e74
       c1e7d660 00000000 c02efc04 00000001 c012b47a 000000ba c3877140 00000301
       00000000 c3710000 c1e7d6ac c1e7d6ac c012b61e c1e7d660 00000301 00000000
Call Trace: [<c011415c>] [<c012b47a>] [<c012b61e>] [<c012b73a>] [<c0192d1c>]
   [<c0192d7a>] [<c011018e>] [<c0112c6b>] [<c010d658>] [<c01070be>] [<c010d9a7>]
   [<c010d658>] [<c010f389>] [<c010fd59>] [<c01057c0>] [<c0106c58>]
Code: 0f 0b 8d 65 dc 5b 5e 5f 89 ec 5d c3 90 55 89 e5 83 ec 0c 57

>>EIP; 0804b232 Before first symbol   <=====
>>EIP; c010e33f <schedule+363/370>   <=====
Trace; c011415c <__run_task_queue+50/64>
Trace; c012b47a <__wait_on_buffer+6a/8c>
Trace; c012b61e <sync_buffers+182/1e0>
Trace; c012b73a <fsync_dev+2a/30>
Trace; c0192d1c <go_sync+120/138>
Trace; c0192d7a <do_emergency_sync+46/b4>
Trace; c011018e <panic+de/e0>
Trace; c0112c6b <do_exit+27/1f0>
Trace; c010d658 <do_page_fault+0/458>
Trace; c01070be <die+52/54>
Trace; c010d9a7 <do_page_fault+34f/458>
Trace; c010d658 <do_page_fault+0/458>
Trace; c010f389 <copy_mm+125/178>
Trace; c010fd59 <do_fork+61d/6d4>
Trace; c01057c0 <sys_fork+14/1c>
Trace; c0106c58 <error_code+38/40>
Code;  c010e33f <schedule+363/370>
00000000 <_EIP>:
Code;  c010e33f <schedule+363/370>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c010e341 <schedule+365/370>
   2:   8d 65 dc                  lea    0xffffffdc(%ebp),%esp
Code;  c010e344 <schedule+368/370>
   5:   5b                        pop    %ebx
Code;  c010e345 <schedule+369/370>
   6:   5e                        pop    %esi
Code;  c010e346 <schedule+36a/370>
   7:   5f                        pop    %edi
Code;  c010e347 <schedule+36b/370>
   8:   89 ec                     mov    %ebp,%esp
Code;  c010e349 <schedule+36d/370>
   a:   5d                        pop    %ebp
Code;  c010e34a <schedule+36e/370>
   b:   c3                        ret
Code;  c010e34b <schedule+36f/370>
   c:   90                        nop
Code;  c010e34c <__wake_up+0/90>
   d:   55                        push   %ebp
Code;  c010e34d <__wake_up+1/90>
   e:   89 e5                     mov    %esp,%ebp
Code;  c010e34f <__wake_up+3/90>
  10:   83 ec 0c                  sub    $0xc,%esp
Code;  c010e352 <__wake_up+6/90>
  13:   57                        push   %edi

 <0>Kernel panic: aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.


[3] syslog:

Jun 29 23:28:49 knecht ipppd[237]: Modem hangup
Jun 29 23:28:49 knecht ipppd[237]: Connection terminated.
Jun 29 23:28:49 knecht ipppd[237]: taking down PHASE_DEAD link 0, linkunit: 0
Jun 29 23:28:49 knecht ipppd[237]: closing fd 8 from unit 0
Jun 29 23:28:49 knecht ipppd[237]: link 0 closed , linkunit: 0
Jun 29 23:28:49 knecht ipppd[237]: reinit_unit: 0
Jun 29 23:28:49 knecht ipppd[237]: Connect[0]: /dev/ippp0, fd: 8
Jun 29 23:28:49 knecht kernel: ippp_ccp: freeing reset data structure c352c000
Jun 29 23:28:49 knecht kernel: ippp, open, slot: 0, minor: 0, state: 0000
Jun 29 23:28:49 knecht kernel: ippp_ccp: allocated reset data structure c352c000
Jun 29 23:28:49 knecht ipppd[237]: Modem hangup
Jun 29 23:28:49 knecht ipppd[237]: Connection terminated.
Jun 29 23:28:49 knecht ipppd[237]: taking down PHASE_DEAD link 1, linkunit: 1
Jun 29 23:28:49 knecht ipppd[237]: closing fd 9 from unit 1
Jun 29 23:28:49 knecht ipppd[237]: link 1 closed , linkunit: 1
Jun 29 23:28:49 knecht ipppd[237]: reinit_unit: 1
Jun 29 23:28:49 knecht ipppd[237]: Connect[1]: /dev/ippp1, fd: 9
Jun 29 23:28:49 knecht kernel: ippp_ccp: freeing reset data structure c352c800
Jun 29 23:28:49 knecht kernel: ippp, open, slot: 1, minor: 1, state: 0000
Jun 29 23:28:49 knecht kernel: ippp_ccp: allocated reset data structure c352c800
Jun 29 23:30:21 knecht ipppd[237]: Local number: x, Remote number: x,
Jun 29 23:30:21 knecht ipppd[237]: PHASE_WAIT -> PHASE_ESTABLISHED, ifunit: 0, l
Jun 29 23:30:21 knecht ipppd[237]: Remote message:
Jun 29 23:30:21 knecht ipppd[237]: MPPP negotiation, He: Yes We: Yes


thx,
 thomas

