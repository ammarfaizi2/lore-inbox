Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289193AbSAQQGK>; Thu, 17 Jan 2002 11:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSAQQGD>; Thu, 17 Jan 2002 11:06:03 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:60434 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S289193AbSAQQFu>; Thu, 17 Jan 2002 11:05:50 -0500
Message-ID: <3C46F753.35F7BB59@loewe-komp.de>
Date: Thu, 17 Jan 2002 17:09:55 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Oopses in scheduler on Linux-2.4.17-xfs
In-Reply-To: <3C44B260.D1FA47BF@loewe-komp.de> <3C44B40E.FEDE24C8@zip.com.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton schrieb:
> 
> Peter Wächtler wrote:
> >
> > I recently get oopses on 2.4.14-xfs and 2.4.17-xfs.
> > box is SMP with old Pentium Pro
> 
> Could I please have a description of your hardware?  lspci output,
> lsmod, .config?
> 
> Thanks.

The machins crashed again in the morning:
To me it seems that a process lost its stack?

Hmh, now I missed to dump the task_struct, right?
How can I better track this bug next time?

would a memory dump of the task_struct help? How to do this?
md <what_address>?


[0]kdb> bt
    EBP       EIP         Function(args)
0xcdc9dfbc 0xc0113db0 schedule+0x248 (0xf, 0x20, 0x27, 0x809e780, 0x1b)
                               kernel .text 0xc0100000 0xc0113b68 0xc01140e8
           0xc0106f29 reschedule+0x5
                               kernel .text 0xc0100000 0xc0106f24 0xc0106f30

[0]kdb> bta
Stack traceback for pid 1
[...]
Stack traceback for pid 787
    EBP       EIP         Function(args)
0xcdc9c000 0xc0113db0 schedule+0x248 (0xf, 0x20, 0x27, 0x809e780, 0x1b)
                               kernel .text 0xc0100000 0xc0113b68 0xc01140e8
           0xc0106f29 reschedule+0x5
                               kernel .text 0xc0100000 0xc0106f24 0xc0106f30
Enter <q> to end, <cr> to continue:

Stack traceback for pid 2093
Stack is not in task_struct, backtrace not available
Enter <q> to end, <cr> to continue:
Stack traceback for pid 2095
    EBP       EIP         Function(args)
[...]

Enter <q> to end, <cr> to continue:
[0]kdb> ps
Task Addr  Pid      Parent   [*] cpu  State Thread     Command
[..]
0xcdc9c000 00000787 00000777  1  000  run   0xcdc9c370*setiathome
[..]
0xc4248000 00002093 00001978  1  001  run   0xc4248370 setiathome


[0]kdb> go
Oops: 0000
CPU:    0
EIP:    0010:[<c0113db0>]    Not tainted
EFLAGS: 00010207
eax: f9647971   ebx: 00000014   ecx: 1a6e124d   edx: 069b8298
esi: cdc9c000   edi: 0000001b   ebp: cdc9dfbc   esp: cdc9df88
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 787, stackpage=cdc9d000)
Stack: cdc9c000 0809e780 0000001b cffeef44 c02c11c0 cdc9c000 00000000 00000001
       00000001 00000000 00000000 cdc9c000 c03148e0 bfffedec c0106f29 0000000f
       00000020 00000027 0809e780 0000001b bfffedec 00000001 0000002b 0000002b
Call Trace: [<c0106f29>]

Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20
 <6>SysRq : Emergency Sync
SysRq : Emergency Remount R/O
SysRq : Resetting


ksymoops 2.4.2 on i686 2.4.17-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs/ (default)
     -m /boot/System.map-2.4.17-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oops: 0000
CPU:    0
EIP:    0010:[<c0113db0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: f9647971   ebx: 00000014   ecx: 1a6e124d   edx: 069b8298
esi: cdc9c000   edi: 0000001b   ebp: cdc9dfbc   esp: cdc9df88
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 787, stackpage=cdc9d000)
Stack: cdc9c000 0809e780 0000001b cffeef44 c02c11c0 cdc9c000 00000000 00000001
       00000001 00000000 00000000 cdc9c000 c03148e0 bfffedec c0106f29 0000000f
       00000020 00000027 0809e780 0000001b bfffedec 00000001 0000002b 0000002b
Call Trace: [<c0106f29>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

>>EIP; c0113db0 <schedule+248/580>   <=====
Trace; c0106f28 <reschedule+4/c>
Code;  c0113db0 <schedule+248/580>
00000000 <_EIP>:
Code;  c0113db0 <schedule+248/580>   <=====
   0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0113db2 <schedule+24a/580>
   3:   d1 fa                     sar    %edx
Code;  c0113db4 <schedule+24c/580>
   5:   89 d8                     mov    %ebx,%eax
Code;  c0113db6 <schedule+24e/580>
   7:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0113dba <schedule+252/580>
   a:   c1 f8 02                  sar    $0x2,%eax
Code;  c0113dbc <schedule+254/580>
   d:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0113dc0 <schedule+258/580>
  11:   89 51 20                  mov    %edx,0x20(%ecx)


1 warning issued.  Results may not be reliable.
