Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282926AbRLCIvx>; Mon, 3 Dec 2001 03:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282946AbRLCIs4>; Mon, 3 Dec 2001 03:48:56 -0500
Received: from webcon.net ([216.187.106.140]:47516 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S284711AbRLCD0D>;
	Sun, 2 Dec 2001 22:26:03 -0500
Date: Sun, 2 Dec 2001 22:25:56 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: David Hinds <dhinds@sonic.net>, <dhinds@zen.stanford.edu>
Subject: BUG() in spinlock.h loading ds.o
In-Reply-To: <20011201120541.B28295@sonic.net>
Message-ID: <Pine.LNX.4.40.0112022135520.1798-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, David Hinds wrote:

> On Sat, Dec 01, 2001 at 02:21:33PM -0500, Ian Morgan wrote:
>
> > (Some have said the kernel pcmcia stuff is still immature, but Hinds'
> > pcmcia-cs package doesn't work at all for me. It's ds.o keeps oopsing when
> > insmod'ed, so I can't even try it.)
>
> I did fix one major SMP bug in the pcmcia-cs drivers just a couple
> days ago; the beta at http://pcmcia-cs.sourceforge.net/ftp/NEW has the
> fix.  I'm not sure if it is really the same bug you describe, though,
> since no one else has reported the ds module causing an immediate
> oops.

Well, I've tried the new 30-Nov-01 package, but ds.o still keeps causing
oopses consistently, whether in UP or SMP. I've also turned on kernel BUG()
reporting, which seems to indicate a problem in spinlock.h. Hare are a
couple sample oopses:

ksymoops 2.4.3 on i686 2.4.17-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-pre2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

eip: c0114c40
kernel BUG at /usr/src/linux-2.4.17-pre2/include/asm/spinlock.h:133!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c0114c6d>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000004b ebx: 00000001 ecx: c028d1ac edx: 0000300a
esi: 00000004 edi: d5ae6260 ebp: c029fea0 esp: c029fe6c
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c029f000)
Stack: c0241060 00000085 00000000 00000004 d5ae6260 00000008 d7a212f0 00000002
       00000001 d7ff1f24 00000286 00000001 d5ae6274 c029feb4 d8bae3a6 d531dac0
       00000004 00000000 c029fec4 d8bae4a8 d5ae6260 00000004 c029fee4 d8b99766
Call Trace: [<d8bae3a6>] [<d8bae4a8>] [<d8b99766>] [<d8b996b2>] [<d8b99624>]
   [<c0121bbb>] [<c0121ca0>] [<c011dee2>] [<c011ddb9>] [<c011db3f>] [<c0108efd>]
   [<c0105290>] [<c0105290>] [<c0105290>] [<c0105290>] [<c01052bc>] [<c0105322>]
   [<c0105000>] [<c010509a>]
Code: 0f 0b 83 c4 08 8b 55 fc f0 fe 0a 0f 88 04 c2 11 00 89 5d f0

>>EIP; c0114c6c <__wake_up+50/1c8>   <=====
Trace; d8bae3a6 <.bss.end+3cd4/????>
Trace; d8bae4a8 <.bss.end+3dd6/????>
Trace; d8b99766 <[pcmcia_core].bss.end+f4e8/1ad82>
Trace; d8b996b2 <[pcmcia_core].bss.end+f434/1ad82>
Trace; d8b99624 <[pcmcia_core].bss.end+f3a6/1ad82>
Trace; c0121bba <timer_bh+2fe/3c4>
Trace; c0121ca0 <do_timer+20/50>
Trace; c011dee2 <bh_action+4e/108>
Trace; c011ddb8 <tasklet_hi_action+6c/a0>
Trace; c011db3e <do_softirq+6e/cc>
Trace; c0108efc <do_IRQ+1b8/1c8>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c01052bc <default_idle+2c/34>
Trace; c0105322 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c010509a <rest_init+9a/9c>
Code;  c0114c6c <__wake_up+50/1c8>
00000000 <_EIP>:
Code;  c0114c6c <__wake_up+50/1c8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0114c6e <__wake_up+52/1c8>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0114c70 <__wake_up+54/1c8>
   5:   8b 55 fc                  mov    0xfffffffc(%ebp),%edx
Code;  c0114c74 <__wake_up+58/1c8>
   8:   f0 fe 0a                  lock decb (%edx)
Code;  c0114c76 <__wake_up+5a/1c8>
   b:   0f 88 04 c2 11 00         js     11c215 <_EIP+0x11c215> c0230e80 <stext_lock+5f4/68b2>
Code;  c0114c7c <__wake_up+60/1c8>
  11:   89 5d f0                  mov    %ebx,0xfffffff0(%ebp)

 <0>Kernel Panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


ksymoops 2.4.3 on i686 2.4.17-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-pre2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

eip: c0114c40
kernel BUG at /usr/src/linux-2.4.17-pre2/include/asm/spinlock.h:133!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c0114c6d>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000004b ebx: 00000001 ecx: c028d1ac edx: 00003064
esi: 00000004 edi: d5f16220 ebp: c179be8c esp: c179be58
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c179b000)
Stack: c0241060 00000085 00000000 00000004 d5f16260 c1788000 c1789fe8 c02db800
       c01217d4 c179a000 00000282 00000001 d5f16234 c179bea0 d8bae3a6 d6339160
       00000004 00000000 c179beb0 d8bae4a8 d5f16220 00000004 c179bed0 d8b80766
Call Trace: [<c01217d4>] [<d8bae3a6>] [<d8bae4a8>] [<d8b80766>] [<d8b806b2>]
   [<d8b80624>] [<c0121bbb>] [<c0121ca0>] [<c011dee2>] [<c011ddb9>] [<c011db3f>]
   [<c0108efd>] [<c0105290>] [<c0105290>] [<c0105290>] [<c0105290>] [<c01052bc>]
   [<c0105322>] [<c0118f8a>]
Code: 0f 0b 83 c4 08 8b 55 fc f0 fe 0a 0f 88 04 c2 11 00 89 5d f0

>>EIP; c0114c6c <__wake_up+50/1c8>   <=====
Trace; c01217d4 <update_process_times+20/94>
Trace; d8bae3a6 <.bss.end+3cd4/????>
Trace; d8bae4a8 <.bss.end+3dd6/????>
Trace; d8b80766 <[pcmcia_core]send_event+32/4c>
Trace; d8b806b2 <[pcmcia_core]unreset_socket+8e/110>
Trace; d8b80624 <[pcmcia_core]unreset_socket+0/110>
Trace; c0121bba <timer_bh+2fe/3c4>
Trace; c0121ca0 <do_timer+20/50>
Trace; c011dee2 <bh_action+4e/108>
Trace; c011ddb8 <tasklet_hi_action+6c/a0>
Trace; c011db3e <do_softirq+6e/cc>
Trace; c0108efc <do_IRQ+1b8/1c8>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c01052bc <default_idle+2c/34>
Trace; c0105322 <cpu_idle+3e/54>
Trace; c0118f8a <release_console_sem+14a/150>
Code;  c0114c6c <__wake_up+50/1c8>
00000000 <_EIP>:
Code;  c0114c6c <__wake_up+50/1c8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0114c6e <__wake_up+52/1c8>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0114c70 <__wake_up+54/1c8>
   5:   8b 55 fc                  mov    0xfffffffc(%ebp),%edx
Code;  c0114c74 <__wake_up+58/1c8>
   8:   f0 fe 0a                  lock decb (%edx)
Code;  c0114c76 <__wake_up+5a/1c8>
   b:   0f 88 04 c2 11 00         js     11c215 <_EIP+0x11c215> c0230e80 <stext_lock+5f4/68b2>
Code;  c0114c7c <__wake_up+60/1c8>
  11:   89 5d f0                  mov    %ebx,0xfffffff0(%ebp)

 <0>Kernel Panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------

