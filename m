Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315415AbSHaAfb>; Fri, 30 Aug 2002 20:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSHaAfb>; Fri, 30 Aug 2002 20:35:31 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:62084 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315415AbSHaAf3>; Fri, 30 Aug 2002 20:35:29 -0400
Date: Sat, 31 Aug 2002 02:39:50 +0200
From: Diego Biurrun <diego@biurrun.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops after removing PCMCIA modem with low latency patch
Message-ID: <20020831003950.GA22460@silver>
References: <20020830223913.GB412@maxx> <3D6FF752.B2BDDC66@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <3D6FF752.B2BDDC66@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

On Fri, Aug 30, 2002 at 03:53:06PM -0700, Andrew Morton wrote:
> Diego Biurrun wrote:
> > 
> > I just tried your 2.4.19-low-latency patch on a stock 2.4.19 kernel and
> > my box oopses when I manually remove my PCMCIA modem.
> 
> Yup.  The pcmcia drivers like to call sleeping devfs functions
> from within a timer handler.  The kernel tries to perform a
> context switch in interrupt context and bugs out.  This can happen
> without the low-latency patch, but doesn't.
> 
> The fix for that is to change the (strange) deferred deregister thing
> in several of the CardServices drivers to punt the activity up to
> process context via schedule_task(), but nobody has done that yet.
> 
> Probably, you can add
> 
> 	if (in_interrupt())
> 		return;
> 
> to schedule() to make the BUGs go away.   Not using devfs makes
> them go away too - but it is not a devfs bug.

Thanks for the ultraquick reply.  I managed to get another oops trace
from within (shudder) Windows Hyperterminal, I am sending this along
just in case it may help you.  Adding the two lines you mention to
sched.c also fixed the problem.
Thank you!

Diego Biurrun

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=output

ksymoops 2.4.5 on i586 2.4.19.  Options used
     -V (default)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

kernel BUG at sched.c:577!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0112de9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000018   ebx: c024a000   ecx: c3446000   edx: 00000001
esi: 00000000   edi: c27fda00   ebp: c024be18   esp: c024bdf4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c024b000)
Stack: c01ed4de c024a000 00000000 c27fda00 c11f2ba0 00000001 00000000 c024a000 
       c0164127 c024be20 c0113d15 c364653c c013272f c27fda00 00000000 c0215860 
       c364653c c0142647 c27fda00 c27fda00 c0143046 c27fda00 c35d5620 c278b3a0 
Call Trace:    [<c0164127>] [<c0113d15>] [<c013272f>] [<c0142647>] [<c0143046>]
  [<c0165bad>] [<c0140cc3>] [<c01643b0>] [<c01649ba>] [<c0164a0f>] [<c016e1ef>]
  [<c0115aa3>] [<c01159e7>] [<c0181136>] [<c725cd4a>] [<c725cd1c>] [<c011c94f>]
  [<c0119482>] [<c01193b6>] [<c01191ca>] [<c0109b9d>] [<c0106d10>] [<c010bd28>]
  [<c0106d10>] [<c0106d33>] [<c0106d97>] [<c0105000>] [<c0105027>]
Code: 0f 0b 41 02 d6 d4 1e c0 83 c4 04 8b 4d f4 c1 e1 05 81 c1 40 


>>EIP; c0112de9 <schedule+4d/2f4>   <=====

>>ebx; c024a000 <init_task_union+0/2000>
>>ecx; c3446000 <_end+31b73ac/6f9f3ac>
>>edi; c27fda00 <_end+256edac/6f9f3ac>
>>ebp; c024be18 <init_task_union+1e18/2000>
>>esp; c024bdf4 <init_task_union+1df4/2000>

Trace; c0164127 <_devfs_walk_path+5f/d4>
Trace; c0113d15 <set_running_and_schedule+1d/24>
Trace; c013272f <invalidate_inode_buffers+1b/88>
Trace; c0142647 <clear_inode+b/b0>
Trace; c0143046 <iput+d6/1ac>
Trace; c0165bad <devfs_d_iput+59/68>
Trace; c0140cc3 <dput+c3/124>
Trace; c01643b0 <free_dentry+3c/44>
Trace; c01649ba <_devfs_unregister+36/74>
Trace; c0164a0f <devfs_unregister+17/24>
Trace; c016e1ef <tty_unregister_devfs+43/50>
Trace; c0115aa3 <release_console_sem+73/78>
Trace; c01159e7 <printk+ff/114>
Trace; c0181136 <unregister_serial+5e/7c>
Trace; c725cd4a <[serial_cs]serial_release+2e/80>
Trace; c725cd1c <[serial_cs]serial_release+0/80>
Trace; c011c94f <timer_bh+26b/384>
Trace; c0119482 <bh_action+1a/40>
Trace; c01193b6 <tasklet_hi_action+4a/70>
Trace; c01191ca <do_softirq+5a/ac>
Trace; c0109b9d <do_IRQ+a1/b4>
Trace; c0106d10 <default_idle+0/28>
Trace; c010bd28 <call_do_IRQ+5/d>
Trace; c0106d10 <default_idle+0/28>
Trace; c0106d33 <default_idle+23/28>
Trace; c0106d97 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>

Code;  c0112de9 <schedule+4d/2f4>
00000000 <_EIP>:
Code;  c0112de9 <schedule+4d/2f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0112deb <schedule+4f/2f4>
   2:   41                        inc    %ecx
Code;  c0112dec <schedule+50/2f4>
   3:   02 d6                     add    %dh,%dl
Code;  c0112dee <schedule+52/2f4>
   5:   d4 1e                     aam    $0x1e
Code;  c0112df0 <schedule+54/2f4>
   7:   c0 83 c4 04 8b 4d f4      rolb   $0xf4,0x4d8b04c4(%ebx)
Code;  c0112df7 <schedule+5b/2f4>
   e:   c1 e1 05                  shl    $0x5,%ecx
Code;  c0112dfa <schedule+5e/2f4>
  11:   81 c1 40 00 00 00         add    $0x40,%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!

--sm4nu43k4a2Rpi4c--
