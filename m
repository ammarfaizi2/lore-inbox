Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTENMwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTENMwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:52:14 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:45207 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262066AbTENMwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:52:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.16102.618836.204556@gargle.gargle.HOWL>
Date: Wed, 14 May 2003 15:04:38 +0200
From: mikpe@csd.uu.se
To: alexander.riesen@synopsys.COM
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-laptop@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: 2.5.69+bk: oops in apmd after waking up from suspend mode
In-Reply-To: <20030514094813.GA14904@Synopsys.COM>
References: <20030514094813.GA14904@Synopsys.COM>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen writes:
 > Hi,
 > 
 > I have an old Compaq Armada 1592DT. The thing goes automagically into
 > suspend mode after being forgotten for a while. And there is this button
 > to wake it up (the blue one, above the keyboard).
 > 
 > Last time i tried to wake it up it produced the attached oops.
 > "Unknown key"s are probable the blue button.
 > After printing out the oops, the system went back into suspend.
 > 
 > -alex
 > 
 > Suspending devices
 > Suspending device c03219ac
 > Unable to handle kernel NULL pointer dereference at virtual address 00000090
 >  printing eip:
 > c011459f
 > *pde = 00000000
 > Oops: 0000 [#1]
 > CPU:    0
 > EIP:    0060:[<c011459f>]    Not tainted
 > EFLAGS: 00010202
 > EIP is at fix_processor_context+0x5f/0x100
 > eax: 0000007c   ebx: c5f0e000   ecx: 00000002   edx: 00000000
 > esi: 00000060   edi: 00000000   ebp: c5f0ff5c   esp: c5f0ff54
 > ds: 007b   es: 007b   ss: 0068
 > Process kapmd (pid: 4, threadinfo=c5f0e000 task=c5fbc640)
 > Stack: c5f0e000 00000060 c5f0ff64 c0114529 c5f0ff78 c01135c8 00000002 00000000 
 >        00000002 c5f0ff8c c0113845 00000001 c5f0e000 c5f0ffb4 c5f0ffdc c0113aa4 
 >        00000000 c5fbc640 c0117950 00000000 00000000 c0290000 c030f6b4 00000000 
 > Call Trace:
 >  [<c0114529>] restore_processor_state+0x69/0x80
 >  [<c01135c8>] suspend+0x138/0x200
 >  [<c0113845>] check_events+0xf5/0x230
 >  [<c0113aa4>] apm_mainloop+0x94/0xb0
 >  [<c0117950>] default_wake_function+0x0/0x20
 >  [<c0117950>] default_wake_function+0x0/0x20
 >  [<c01141a0>] apm+0x0/0x280
 >  [<c0114262>] apm+0xc2/0x280
 >  [<c0107255>] kernel_thread_helper+0x5/0x10
 > 
 > Code: 8b 48 14 8b 42 7c 85 c0 75 0a b9 00 10 29 c0 b8 05 00 00 00 

Since 2.5.69-bk8 or so, apm.c will invoke restore_processor_state()
at resume-time. This is needed to reinitialise the SYSENTER MSRs
used by 2.5's new system call mechanism.

 >  <6>note: kapmd[4] exited with preempt_count 2

This I don't like. I'm not convinced the resume path is preempt-safe.
Please try again, either with CONFIG_PREEMPT disabled, or with a
preempt_disable() / preempt_enable() pair around apm.c's suspend code,
like in the patch below. (Untested, you may need to stick an #include
<preempt.h> somewhere in apm.c to make it compile.)

/Mikael

--- linux-2.5.69-bk8/arch/i386/kernel/apm.c.~1~	2003-05-14 14:31:31.000000000 +0200
+++ linux-2.5.69-bk8/arch/i386/kernel/apm.c	2003-05-14 15:01:03.000000000 +0200
@@ -1213,9 +1213,11 @@
 	spin_unlock(&i8253_lock);
 	write_sequnlock_irq(&xtime_lock);
 
+	preempt_disable();
 	save_processor_state();
 	err = set_system_power_state(APM_STATE_SUSPEND);
 	restore_processor_state();
+	preempt_enable();
 
 	write_seqlock_irq(&xtime_lock);
 	spin_lock(&i8253_lock);
