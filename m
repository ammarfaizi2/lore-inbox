Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSIKIBL>; Wed, 11 Sep 2002 04:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSIKIBK>; Wed, 11 Sep 2002 04:01:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:3968 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318488AbSIKIBJ>; Wed, 11 Sep 2002 04:01:09 -0400
Date: Wed, 11 Sep 2002 12:05:51 +0400
From: Oleg Drokin <green@namesys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org, axboe@suse.de, andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911120551.A937@namesys.com>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 09:38:25AM +0200, Ingo Molnar wrote:

> > I have preemption disabled.
> nevertheless please print out preempt_count() in sched.c - since the big
> IRQ cleanups we use the preemption count even if preemption is disabled.
> this way we'll know what kind of problem happened - a stuck softirq count, 
> a stuck hardirq count or an underflow?

You was exactly right.
preemption count is -1.
I inserted chack in dec_preempt_count() and here is updated correct stacktrace.
Seems like ide_unmap_buffer is called with some bogus data or something like
that. Also I guess the bug is only visible with debug highmem = ON and highmem
enabled.

ksymoops 2.4.2 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m System.map (specified)

 hdb:kernel BUG at /home/green/bk_work/reiser3-linux-2.5-work-t/include/asm/highmem.h:107!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c01bd571>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010016
eax: 00010000   ebx: f7dda000   ecx: c1c5c000   edx: 0000ffff
esi: 00000022   edi: f7de6b44   ebp: 00000008   esp: c1c5def0
ds: 0068   es: 0068   ss: 0068
Stack: c033ff6c f7dfed04 c02ea080 00000296 c1c5df0c c1c5df0c 00000008 00000082 
       c01b5fd7 c033ff6c c1c3ccdc 04000001 0000000e c1c5df80 00000000 c01bd390 
       c033fda0 c010957d 0000000e f7dfed04 c1c5df80 c02cdb90 c02cdb80 c02cdb90 
Call Trace: [<c01b5fd7>] [<c01bd390>] [<c010957d>] [<c0109819>] [<c01053a0>] 
   [<c01080a8>] [<c01053a0>] [<c01053c9>] [<c0105472>] [<c011ad5b>] 
Code: 0f 0b 6b 00 a0 ee 24 c0 eb 55 90 8d 74 26 00 83 c2 14 c1 e2 

>>EIP; c01bd570 <read_intr+1e0/2d0>   <=====
Trace; c01b5fd6 <ide_intr+1b6/280>
Trace; c01bd390 <read_intr+0/2d0>
Trace; c010957c <handle_IRQ_event+2c/50>
Trace; c0109818 <do_IRQ+d8/190>
Trace; c01053a0 <default_idle+0/40>
Trace; c01080a8 <common_interrupt+18/20>
Trace; c01053a0 <default_idle+0/40>
Trace; c01053c8 <default_idle+28/40>
Trace; c0105472 <cpu_idle+42/50>
Trace; c011ad5a <release_console_sem+10a/120>
Code;  c01bd570 <read_intr+1e0/2d0>
00000000 <_EIP>:
Code;  c01bd570 <read_intr+1e0/2d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01bd572 <read_intr+1e2/2d0>
   2:   6b 00 a0                  imul   $0xffffffa0,(%eax),%eax
Code;  c01bd574 <read_intr+1e4/2d0>
   5:   ee                        out    %al,(%dx)
Code;  c01bd576 <read_intr+1e6/2d0>
   6:   24 c0                     and    $0xc0,%al
Code;  c01bd578 <read_intr+1e8/2d0>
   8:   eb 55                     jmp    5f <_EIP+0x5f> c01bd5ce <read_intr+23e/2d0>
Code;  c01bd57a <read_intr+1ea/2d0>
   a:   90                        nop    
Code;  c01bd57a <read_intr+1ea/2d0>
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01bd57e <read_intr+1ee/2d0>
   f:   83 c2 14                  add    $0x14,%edx
Code;  c01bd582 <read_intr+1f2/2d0>
  12:   c1 e2 00                  shl    $0x0,%edx

 <0>Kernel panic: Aiee, killing interrupt handler!

1143 warnings issued.  Results may not be reliable.
