Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTIVWAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTIVWA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:00:29 -0400
Received: from ns.guardiandigital.com ([209.11.107.5]:12561 "EHLO
	juggernaut.guardiandigital.com") by vger.kernel.org with ESMTP
	id S261342AbTIVWA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:00:26 -0400
Date: Mon, 22 Sep 2003 18:00:23 -0400 (EDT)
From: "Ryan W. Maple" <ryan@guardiandigital.com>
X-X-Sender: ryan@mastermind.inside.guardiandigital.com
To: linux-kernel@vger.kernel.org
Subject: Reproducable networking Oops with vanilla 2.4.22
Message-ID: <Pine.LNX.4.53.0309221759300.30821@mastermind.inside.guardiandigital.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

(I sent this message to linux-net a week or two ago and never got a
response... giving it a go here.)

I've hit a reproducible networking Oops with vanilla 2.4.22; decoded Oops
below.  I'm able to reproduce the Oops using httperf:

  httperf --hog \
          --server ryantest \
          --uri /speed_test \
          --num-conn 500 \
          --timeout 5

Where speed_test is a 76M file.  Any input is greatly appreciated, and
I'm available to test any patches.

ver_linux:
  Gnu C                  2.96
  Gnu make               3.79.1
  util-linux             2.10q
  mount                  2.10q
  modutils               2.4.22
  e2fsprogs              1.32
  PPP                    2.4.1
  Linux C Library        2.2.5
  Dynamic linker (ldd)   2.2.5
  Procps                 2.0.7
  Net-tools              1.57
  Console-tools          0.3.3
  Sh-utils               2.0
  Modules Loaded         iptable_filter ip_tables e100 sd_mod scsi_mod

cpuinfo:
  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 8
  model name      : Pentium III (Coppermine)
  stepping        : 3
  cpu MHz         : 666.457
  cache size      : 256 KB
  fdiv_bug        : no
  hlt_bug         : no
  f00f_bug        : no
  coma_bug        : no
  fpu             : yes
  fpu_exception   : yes
  cpuid level     : 2
  wp              : yes
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
  bogomips        : 1330.38

Thanks,
Ryan

--------------------------------------------------------------------------
ksymoops 2.4.9 on i686 2.4.20-1.5.0.  Options used
     -v /tmp/linux-2.4.22/vmlinux (specified)
     -k ksyms-2.4.22 (specified)
     -l lsmod-2.4.22 (specified)
     -o /tmp/linux-2.4.22/root/lib/modules/2.4.22/ (specified)
     -m /tmp/linux-2.4.22/System.map (specified)

Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Oops: 0000
CPU:    0
EIP:    0010:[<c02031c3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: eac9f3d7   ebx: cface1d0   ecx: 00000000   edx: cf6328e0
esi: 00000d68   edi: c9e06bfc   ebp: cface1d0   esp: cf1c9e4c
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 301, stackpage=cf1c9000)
Stack: cf1c9e9c 00000000 c02d9ed0 fffffffb 00000000 c011e7cf 00000046 00000046
       00000000 cfa508d0 cf1c8000 bfffe7e8 00001298 00000d68 00000000 000005a8
       00000000 00000000 cf1c9f54 00001000 00000000 7fffffff ccb9eb20 bffff5a0
Call Trace:    [<c011e7cf>] [<c012ccb0>] [<c021fa86>] [<c01df8af>] [<c012c9b2>]
  [<c011e7cf>] [<c01dfaa4>] [<c013b5f5>] [<c010a2b8>] [<c0108927>]
Code: 3a 20 7f ed 65 e1 01 89 87 00 01 00 00 74 11 c6 87 7f 01 00


>>EIP; c02031c3 <tcp_sendmsg+b2b/1178>   <=====

>>ebx; cface1d0 <_end+f7924bc/104c42ec>
>>edx; cf6328e0 <_end+f2f6bcc/104c42ec>
>>edi; c9e06bfc <_end+9acaee8/104c42ec>
>>ebp; cface1d0 <_end+f7924bc/104c42ec>
>>esp; cf1c9e4c <_end+ee8e138/104c42ec>

Trace; c011e7cf <do_softirq+63/c0>
Trace; c012ccb0 <file_read_actor+74/e8>
Trace; c021fa86 <inet_sendmsg+36/3c>
Trace; c01df8af <sock_sendmsg+6b/8c>
Trace; c012c9b2 <do_generic_file_read+442/44c>
Trace; c011e7cf <do_softirq+63/c0>
Trace; c01dfaa4 <sock_write+a0/ac>
Trace; c013b5f5 <sys_write+95/110>
Trace; c010a2b8 <do_IRQ+fc/108>
Trace; c0108927 <system_call+33/38>

Code;  c02031c3 <tcp_sendmsg+b2b/1178>
00000000 <_EIP>:
Code;  c02031c3 <tcp_sendmsg+b2b/1178>   <=====
   0:   3a 20                     cmp    (%eax),%ah   <=====
Code;  c02031c5 <tcp_sendmsg+b2d/1178>
   2:   7f ed                     jg     fffffff1 <_EIP+0xfffffff1> c02031b4 <tcp_sendmsg+b1c/1178>
Code;  c02031c7 <tcp_sendmsg+b2f/1178>
   4:   65                        gs
Code;  c02031c8 <tcp_sendmsg+b30/1178>
   5:   e1 01                     loope  8 <_EIP+0x8> c02031cb <tcp_sendmsg+b33/1178>
Code;  c02031ca <tcp_sendmsg+b32/1178>
   7:   89 87 00 01 00 00         mov    %eax,0x100(%edi)
Code;  c02031d0 <tcp_sendmsg+b38/1178>
   d:   74 11                     je     20 <_EIP+0x20> c02031e3 <tcp_sendmsg+b4b/1178>
Code;  c02031d2 <tcp_sendmsg+b3a/1178>
   f:   c6 87 7f 01 00 00 00      movb   $0x0,0x17f(%edi)


2 errors issued.  Results may not be reliable.

