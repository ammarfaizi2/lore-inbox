Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVJTX4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVJTX4Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVJTX4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:56:25 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:20634 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932543AbVJTX4Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:56:24 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>,
       cc@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <20051020191620.GA21367@elte.hu>
References: <20051017160536.GA2107@elte.hu>
	 <1129576885.4720.3.camel@cmn3.stanford.edu>
	 <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 16:55:31 -0700
Message-Id: <1129852531.5227.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-20 at 21:16 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > > indeed - and this could explain some of the lockups reported. I've 
> > > uploaded -rt10 with your fix included.
> > 
> > No lockups so far with -rt12 (running for 1/2 a day already). 
> > 
> > I'm getting BUG messages again, some examples below...
> 
> would be interesting to check whether the cycle_t u64 fix in -rt14 gets 
> rid of these BUG messages.

Found this on the logs:

Oct 20 15:52:57 cmn3 kernel: BUG in hydrogen:4810, ktimer expired short
without user signal!:
Oct 20 15:52:57 cmn3 kernel: expires:   2289/357933580
Oct 20 15:52:57 cmn3 kernel: expired:   2289/357891080
Oct 20 15:52:57 cmn3 kernel: at line:   942
Oct 20 15:52:57 cmn3 kernel: interval:  0/0
Oct 20 15:52:57 cmn3 kernel: now:       2289/357891595
Oct 20 15:52:57 cmn3 kernel: rem:       0/42500
Oct 20 15:52:57 cmn3 kernel: overrun:   0
Oct 20 15:52:57 cmn3 kernel: getoffset: 00000000
Oct 20 15:52:57 cmn3 kernel: hydrogen/4810[CPU#1]: BUG in
check_ktimer_signal at kernel/ktimers.c:1305
Oct 20 15:52:57 cmn3 kernel:  [<c01280a7>] __WARN_ON+0x67/0x90 (8)
Oct 20 15:52:57 cmn3 kernel:  [<c0141fac>] check_ktimer_signal
+0x17c/0x190 (48)
Oct 20 15:52:57 cmn3 kernel:  [<c0142069>] __ktimer_nanosleep+0xa9/0xf0
(56)
Oct 20 15:52:57 cmn3 kernel:  [<c01420eb>] ktimer_nanosleep+0x3b/0x50
(56)
Oct 20 15:52:57 cmn3 kernel:  [<c0375480>] nanosleep_restart_mono
+0x0/0x30 (8)
Oct 20 15:52:57 cmn3 kernel:  [<c0141e20>] ktimer_wake_up+0x0/0x10 (64)
Oct 20 15:52:57 cmn3 kernel:  [<c014219c>] sys_nanosleep+0x4c/0x50 (32)
Oct 20 15:52:57 cmn3 kernel:  [<c0103481>] syscall_call+0x7/0xb (16)

...left for a while and came back to find the machine catatonic. No hard
lock but not much I could do (would ping back but could not ssh, managed
to switch to a text console but login did not work). I found this in the
logs:

Oct 20 15:58:49 cmn3 kernel: BUG: swapper:0, possible softlockup
detected on CPU#1!
Oct 20 15:58:49 cmn3 kernel:  [<c01532c6>] softlockup_detected+0x36/0x50
(8)
Oct 20 15:58:49 cmn3 kernel:  [<c011913f>] smp_apic_timer_interrupt
+0x3f/0x50 (20)
Oct 20 15:58:49 cmn3 kernel:  [<c0103f54>] apic_timer_interrupt
+0x1c/0x24 (8)
Oct 20 15:58:49 cmn3 kernel:  [<c023c70d>] acpi_processor_idle+0x0/0x2a7
(8)
Oct 20 15:58:49 cmn3 kernel:  [<c023c801>] acpi_processor_idle
+0xf4/0x2a7 (36)
Oct 20 15:58:49 cmn3 kernel:  [<c0101134>] cpu_idle+0x84/0xf0 (48)
Oct 20 15:58:49 cmn3 kernel:  [<c0376582>] _raw_spin_unlock_irq
+0x12/0x20 (4)

-- Fernando


