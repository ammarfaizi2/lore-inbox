Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284206AbRLATVw>; Sat, 1 Dec 2001 14:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284204AbRLATVm>; Sat, 1 Dec 2001 14:21:42 -0500
Received: from webcon.net ([216.187.106.140]:18568 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S284207AbRLATVg>;
	Sat, 1 Dec 2001 14:21:36 -0500
Date: Sat, 1 Dec 2001 14:21:33 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: dhinds@zen.stanford.edu
Subject: in-kernel pcmcia oopsing in SMP
Message-ID: <Pine.LNX.4.40.0112011406040.2329-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a few SMP boxes here, with kernels from about 2.4.14 though 2.4.17-pre2,
the system locks up hard during heavy wireless I/O.

Using in-kernel yenta_socket and orinoco drivers. Everything works 100%
with a UP kernel, or an SMP kernel with max_cpus=1, but with 2 cpus, the
system will lock up hard after just a few minutes of I/O.

(Some have said the kernel pcmcia stuff is still immature, but Hinds'
pcmcia-cs package doesn't work at all for me. It's ds.o keeps oopsing when
insmod'ed, so I can't even try it.)

With nmi_watchdog=2, I'm able to get an oops:

ksymoops 2.4.3 on i686 2.4.16-pre1-smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16-pre1-smp/ (default)
     -m /usr/src/linux/System.map (default)

Oops: 0000
EIP: 0010:[<c011ea18>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00012800 ebx: 4c15ff51 ecx: c03052d4 edx: ffffffff
esi: 00100000 edi: 4c15ff51 ebp: c02dd060 esp: c179bf28
ds: 0018 es: 0018 ss: 0018
Process (pid: -2147450880, stackpage=c179b000)
Stack: c02dd460 00000001 fffffffe 00100000 c011e7df c02dd460 c02d9800 c02d9810
       c02d9810 c179bf74 00000046 c0108efd c0105290 c179a000 c0105290 00000000
       00100000 c028df48 80008000 00000000 c023a990 c0105290 c179a000 c179a000
Call Trace: [<c011e7df>] [<c0108efd>] [<c0105290>] [<c0105290>] [<c0105290>]
   [<c0105290>] [<c01052bc>] [<c0105322>] [<c0119c28>]
Code: 8b 3f f0 0f ba 6b 04 01 19 c0 85 c0 75 44 8b 43 08 85 c0 75

>>EIP; c011ea18 <tasklet_hi_action+2c/a0>   <=====
Trace; c011e7de <do_softirq+6e/cc>
Trace; c0108efc <do_IRQ+1b8/1c8>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c0105290 <default_idle+0/34>
Trace; c01052bc <default_idle+2c/34>
Trace; c0105322 <cpu_idle+3e/54>
Trace; c0119c28 <release_console_sem+148/150>
Code;  c011ea18 <tasklet_hi_action+2c/a0>
00000000 <_EIP>:
Code;  c011ea18 <tasklet_hi_action+2c/a0>   <=====
   0:   8b 3f                     mov    (%edi),%edi   <=====
Code;  c011ea1a <tasklet_hi_action+2e/a0>
   2:   f0 0f ba 6b 04 01         lock btsl $0x1,0x4(%ebx)
Code;  c011ea20 <tasklet_hi_action+34/a0>
   8:   19 c0                     sbb    %eax,%eax
Code;  c011ea22 <tasklet_hi_action+36/a0>
   a:   85 c0                     test   %eax,%eax
Code;  c011ea24 <tasklet_hi_action+38/a0>
   c:   75 44                     jne    52 <_EIP+0x52> c011ea6a <tasklet_hi_action+7e/a0>
Code;  c011ea26 <tasklet_hi_action+3a/a0>
   e:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c011ea28 <tasklet_hi_action+3c/a0>
  11:   85 c0                     test   %eax,%eax
Code;  c011ea2a <tasklet_hi_action+3e/a0>
  13:   75 00                     jne    15 <_EIP+0x15> c011ea2c <tasklet_hi_action+40/a0>


Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------

