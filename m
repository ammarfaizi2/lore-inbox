Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUCIFJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUCIFJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:09:24 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:24813 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261564AbUCIFJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:09:13 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Tue, 9 Mar 2004 10:38:55 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org, pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081714.05521.amitkale@emsyssoft.com> <404CF165.1010402@mvista.com>
In-Reply-To: <404CF165.1010402@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403091038.55749.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 Mar 2004 3:49 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Monday 08 Mar 2004 4:50 pm, Amit S. Kale wrote:
> >>On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
> >>>"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> >>>>On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> >>>> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> >>>> > > Here are features that are present only in full kgdb:
> >>>> > >  1. Thread support  (aka info threads)
> >>>> >
> >>>> > argh, disaster.  I discussed this with Tom a week or so ago when it
> >>>> > looked like this it was being chopped out and I recall being told
> >>>> > that the discussion was referring to something else.
> >>>> >
> >>>> > Ho-hum, sorry.  Can we please put this back in?
> >>>>
> >>>> Err., well this is one of the particularly dirty parts of kgdb. That's
> >>>>why it's been kept away. It takes care of correct thread backtraces in
> >>>>some rare cases.
> >>>
> >>>Let me just make sure we're taking about the same thing here.  Are you
> >>>saying that with kgdb-lite, `info threads' is completely missing, or
> >>> does it just not work correctly with threads (as opposed to heavyweight
> >>> processes)?
> >>
> >>info threads shows a list of threads. Heavy/light weight processes
> >> doesn't matter. Thread frame shown is incorrect.
> >>
> >>I looked at i386 dependent code again. Following code in it is incorrect.
> >> I never noticed it because this code is rarely used in full version of
> >> kgdb:
> >>
> >>+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
> >>task_struct *p)
> >>....
> >>+	gdb_regs[_EBP] = *(int *)p->thread.esp;
> >>
> >>We can't guss ebp this way. This line should be removed.
> >>
> >>+	gdb_regs[_DS] = __KERNEL_DS;
> >>+	gdb_regs[_ES] = __KERNEL_DS;
> >>+	gdb_regs[_PS] = 0;
> >>+	gdb_regs[_CS] = __KERNEL_CS;
> >>+	gdb_regs[_PC] = p->thread.eip;
> >>+	gdb_regs[_ESP] = p->thread.esp;
> >>
> >>This should be gdb_regs[_ESP] = &p->thread.esp
> >
> > That's not correct it. It should be gdb_regs[_ESP] = p->thread.esp;
> > Even with these changes I can't get thread listing correctly.
> >
> > Here is the intrusive piece of code that helps get thread state
> > correctly. Any ideas on cleaning it?
>
> I wonder what version of gdb you are using.  What is it that you see?

I am pasting below the output I see with 
gdb_regs[_PC] = p->thread.eip;
gdb_regs[_ESP] = p->thread.esp;
providing thread state information.

>
> You really do need a gdb that handles the dwarft2 frames.  This is a rather
> new gdb (I use the CVS version).

Let's just stick to gdb 6.0 and binutils 2.14. CVS versions of gdb and 
binutils are too risky for someone who is trying to learn linux kernel by 
using kgdb.

Let's face it, more people use kgdb to _learn_ some part of the kernel than 
kernel gurus :-)

-Amit

(gdb) info thr
  42 Thread 32768 (Shadow task 0 for pid 0)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  41 Thread 1129 (cupsd)  0xc1146000 in ?? ()
  40 Thread 1128 (initlog)  0xc1146000 in ?? ()
  39 Thread 1123 (S90cups)  0xc1146000 in ?? ()
  38 Thread 1119 (crond)  0xc1146000 in ?? ()
  37 Thread 1110 (gpm)  0xc1146000 in ?? ()
  36 Thread 1100 (sendmail)  0xc1146000 in ?? ()
  35 Thread 1090 (sendmail)  0xc1146000 in ?? ()
  34 Thread 1068 (rpc.mountd)  0xc1146000 in ?? ()
  33 Thread 1062 (rpciod)  0xc1146000 in ?? ()
  32 Thread 1061 (lockd)  0xc1146000 in ?? ()
  31 Thread 1060 (nfsd)  0xc1146000 in ?? ()
  30 Thread 1059 (nfsd)  0xc1146000 in ?? ()
  29 Thread 1058 (nfsd)  0xc1146000 in ?? ()
  28 Thread 1057 (nfsd)  0xc1146000 in ?? ()
  27 Thread 1056 (nfsd)  0xc1146000 in ?? ()
  26 Thread 1055 (nfsd)  0xc1146000 in ?? ()
  25 Thread 1054 (nfsd)  0xc1146000 in ?? ()
  24 Thread 1053 (nfsd)  0xc1146000 in ?? ()
  23 Thread 1049 (rpc.rquotad)  0xc1146000 in ?? ()
  22 Thread 1036 (xinetd)  0xc1146000 in ?? ()
  21 Thread 1021 (sshd)  0xc1146000 in ?? ()
---Type <return> to continue, or q <return> to quit---
  20 Thread 925 (rpc.statd)  0xc1146000 in ?? ()
  19 Thread 906 (portmap)  0xc1146000 in ?? ()
  18 Thread 888 (klogd)  0xc1146000 in ?? ()
  17 Thread 884 (syslogd)  0xc1146000 in ?? ()
  16 Thread 706 (rc)  0xc1146000 in ?? ()
  15 Thread 626 (kjournald)  0xc1146000 in ?? ()
  14 Thread 625 (kjournald)  0xc1146000 in ?? ()
  13 Thread 624 (kjournald)  0xc1146000 in ?? ()
  12 Thread 11 (kjournald)  0xc1146000 in ?? ()
  11 Thread 10 (kseriod)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  10 Thread 9 (aio/0)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  9 Thread 8 (kswapd0)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  8 Thread 7 (pdflush)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  7 Thread 6 (pdflush)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  6 Thread 5 (khubd)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  5 Thread 4 (kblockd/0)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
---Type <return> to continue, or q <return> to quit---
  4 Thread 3 (events/0)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  3 Thread 2 (ksoftirqd/0)  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
  2 Thread 1 (init)  0xc1146000 in ?? ()
* 1 Thread 1130 (cupsd)  breakpoint ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/kgdb.c:1088
(gdb) thr 11
[Switching to thread 11 (Thread 10)]#0  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
920             switch_to(prev, next, prev);
(gdb) bt
#0  0xc011a27f in schedule ()
    at /home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920
Cannot access memory at address 0x4
(gdb) info fr
Stack level 0, frame at 0x8:
 eip = 0xc011a27f in schedule
    (/home/amitkale/work/linux-2.6.4-rc2-bk3-kgdb/kernel/sched.c:920);
    saved eip Cannot access memory at address 0x4
(gdb) info regi
eax            0x0      0
ecx            0x0      0
edx            0x0      0
ebx            0x0      0
esp            0xc7da3f5c       0xc7da3f5c
ebp            0x0      0x0
esi            0x0      0
edi            0x0      0
eip            0xc011a27f       0xc011a27f
eflags         0x0      0
cs             0x60     96
ss             0x68     104
ds             0x68     104
es             0x68     104
fs             0xffff   65535
gs             0xffff   65535
(gdb) disas 0xc011a270 0xc011a288
Dump of assembler code from 0xc011a270 to 0xc011a288:
0xc011a270 <schedule+784>:      jg     0xc011a214 <schedule+692>
0xc011a272 <schedule+786>:      adc    %eax,%eax
0xc011a274 <schedule+788>:      pushl  0x350(%esi)
0xc011a27a <schedule+794>:      jmp    0xc01079d0 <__switch_to>
0xc011a27f <schedule+799>:      pop    %ebp
0xc011a280 <schedule+800>:      popf
0xc011a281 <schedule+801>:      mov    %eax,0xffffffd0(%ebp)
0xc011a284 <schedule+804>:      xor    %edx,%edx
0xc011a286 <schedule+806>:      mov    0xc04b8edc,%esi
End of assembler dump.
(gdb)

