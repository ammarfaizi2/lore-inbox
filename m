Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUJNXIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUJNXIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJNXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:06:57 -0400
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:55543 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S267497AbUJNWZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:25:23 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Bill Huey <bhuey@lnxw.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Adam Heath <doogie@debian.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFFD541C51.89BF854A-ON86256F2D.0077DF65@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 14 Oct 2004 17:24:53 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/14/2004 05:24:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>there wasnt all that much missing for SELINUX + PREEMPT_REALTIME
>support. Could you try the patch below - does it fix your box?
...

Alas no, it actually seemed to make things worse. After
  /etc/rc3.d/S10network start

I got a few dumps (too fast to see) and then the following BUG.
[top of screen]
Modules linked in: iptable_filter ip_tables 8139too mii dm_mod uhci_hcd
ext3 jbd
CPU:    1
EIP:    0060:[<c0316366>]    Not tainted VLI
EFLAGS: 00000002   (2.6.9-rc4-mm1-VP-U1a)  [only change is your patch...]
eax: 00000002   ebx: c1405820   ecx: 0104cf60   edx: 00000001
esi: c166a000   edi: 00000002   ebp: c166bf04   esp: c166bef8
ds: 007b   es: 007b   ss: 0068   preempt: 00010003
Process ksoftirqd/1 (pid: 5, threadinfo=c166a000 task=c1658000)
Stack: 00000001 c1405820 c1435820 c166bf18 c011bc30 c1436200 c1405820
c1436200
       c166bf48 c011c766 c1435820 c1405820 c166bf38 00000002 c1658000
c166bf48
       00000001 c1436200 00000001 0104cf60 c166bfa4 c0315433 00000001
c1435820
Call Trace:
 [<c011bc30>] double_lock_balance+0x40/0x50
 [<c011c766>] load_balance_newidle+0x66/0xc0
 [<c0315433>] schedule+0x733/0x830
 [<c0114b30>] mcount+0x14/0x18
 [<c01280b4>] ksoftirq+0xd4/0xf0
 [<c01382b0>] kthread+0x0/0xc0
 [<c0105b19>] kernel_thread_helper+0x5/0xc
Code: bf 00 00 00 00 55 89 e5 83 ec 0c 89 5d f8 89 75 fc e8 cb e7 df ff c7
04 24
 01 00 00 00 89 c3 e8 d1 3e e2 ff be 00 e0 ff ff 21 e6 <31> c0 86 03 84 c0
7e 0a
 8b 5d f8 8b 7f fc 89 ec 5d c3 c7

Rebooting to see if I was just "unlucky"...

Checking the log file after reboot, it appears I do have a trace to send
you
[next message...]. Trying again.

Different crash but at basically the same step. Getting tired of typing
these
in from the other screen...
EIP is at sub_preempt_count+0x5f+0xa0
...
preempt: 00010003

Call Trace:
 [<c0316384>] _spin_lock+0x44/0x70
 [<c011bc30>] double_lock_balance+0x40/0x50
 [<c011c766>] load_balance_newidle+0x66/0xc0
 [<c0315433>] schedule+0x733/0x830
 [<c0114b30>] mcount+0x14/0x18
 [<c01280b4>] ksoftirq+0xd4/0xf0
 [<c013836b>] kthread+0xbb/0xc0
 [<c0127fe0>] ksoftirq+0x0/0xf0
 [<c01382b0>] kthread+0x0/0xc0
 [<c0105b19>] kernel_thread_helper+0x5/0xc
... console shuts up ...

Try a third time with max_cpus=1

OK. Made it past S10network start, with just a couple messages about a
sleeping function called from invalid context; looks like a new cause
and will send you that in the next message too.

Did a couple other commands (less, ls) without problem. Tried
  ./S13portmap start
and the machine locked up (no response to Ctrl-C). Alt-SysRq-T did
display something. Alt-SysRq-S did an Emergency Sync (but also dumped
out...)

[top of screen]
in atomic():1 [00000001], irqs_disabled():0
 [<c011f26a>] __might_sleep+0xca/0xe0
 [<c0138de9>] _mutex_lock+0x29/0x70
 [<c0138e86>] _mutex_lock_irqsave+0x16/0x20
 [<c014c932>] pdflush_operation+0x32/0xd0
 [<c01691ad>] emergency_sync+0x1d/0x30
 [<c01690e0>] do_sync+0x0/0x90
 [<c0217456>] __handle_sysrq+0x76/0xf0
 [<c0210b1d>] kbd_event+0xad/0x110
 [<c028da8b>] input_event+0xfb/0x3f0
 [<c0114b30>] mcount+0x14/0x18
 [<c0291923>] atkbd_report_key+0x43/0xa0
 [<c0291ba6>] atkbd_interrupt+0x226/0x590
 [<c0225f54>] serio_interrupt+0x54/0xa3
 [<c0226681>] i8042_interrupt+0xc1/0x1a0
 [<c01440b6>] handle_IRQ_event+0x46/0x80
 [<c01448c0>] do_hardirq+0x70/0xf0
 [<c0144a41>] do_irqd+0x101/0x1d0
 [<c013836b>] kthread+0xbb/0xc0
 [<c0144940>] do_irqd+0x0/0x1d0
 [<c01382b0>] kthread+0x0/0xc0
 [<c0105b19>] kernel_thread_helper+0x5/0xc
Emergency Sync complete

So there's appears to be a problem in Alt-SysRq handling as well.
Alt-SysRq-P doesn't show anything, not sure why.
Alt-SysRq-M appears to work OK.
Alt-SysRq-B works too :-).

Will bring up -T3 soon and send the messages on disk in a separate
message.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

