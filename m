Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUG3V7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUG3V7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUG3V7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:59:15 -0400
Received: from alhambra.mulix.org ([192.117.103.203]:3749 "EHLO
	granada.merseine.nu") by vger.kernel.org with ESMTP id S267689AbUG3V7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:59:08 -0400
Date: Sat, 31 Jul 2004 01:00:06 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-mm1-M5
Message-ID: <20040730220006.GA6340@granada.merseine.nu>
References: <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040730081326.GA6384@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730081326.GA6384@elte.hu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 10:13:26AM +0200, Ingo Molnar wrote:
> 
> Upon popular request i've merged the latest voluntary-preempt patch to
> the latest -mm kernel:
> 
>
http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-mm1-M5

Works fairly nicely for me (nice job!), except the mouse does not work
in both console (gpm) and X. This is on a thinkpad T21, 2.6.8-rc2-mm2
with the M5 patch. Doing 'echo 0 > /proc/irq/{1|12}/i8042/threaded'
does not work. This trivial workaround fixes it for me:

--- 2.6.8-rc2-mm1/drivers/input/serio/i8042.c	2004-07-30 14:49:14.018816320 +0000
+++ 2.6.8-rc2-mm1-mx/drivers/input/serio/i8042.c	2004-07-30 14:48:35.274706320 +0000
@@ -302,8 +302,9 @@
 		if (i8042_mux_open++)
 			return 0;
 
+	printk(KERN_INFO "i8042 requesting IRQ %d\n", values->irq);
 	if (request_irq(values->irq, i8042_interrupt,
-			SA_SHIRQ, "i8042", i8042_request_irq_cookie)) {
+			SA_SHIRQ | SA_NOTHREAD, "i8042", i8042_request_irq_cookie)) {
 		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
 		goto irq_fail;
 	}

Other things that might be relevant

- both with and without the workaround, I get this:
"Jul 30 08:42:40 hydra kernel: atkbd.c: Spurious ACK on
isa0060/serio0. Some program, like XFree86, might be trying access
hardware directly."

- both with and without the workaround, I get this:
Jul 30 08:42:27 hydra kernel: Badness in free_irq at arch/i386/kernel/irq.c:721
Jul 30 08:42:27 hydra kernel:  [<c010895d>] free_irq+0x190/0x1aa
Jul 30 08:42:27 hydra kernel:  [<c02632d6>] floppy_release_irq_and_dma+0x259/0x272
Jul 30 08:42:27 hydra kernel:  [<c025cb48>] set_dor+0xe0/0x16f
Jul 30 08:42:27 hydra kernel:  [<c025ceac>] motor_off_callback+0x0/0x36
Jul 30 08:42:27 hydra kernel:  [<c025cede>] motor_off_callback+0x32/0x36
Jul 30 08:42:27 hydra kernel:  [<c0128a42>] run_timer_softirq+0xee/0x1e4
Jul 30 08:42:27 hydra kernel:  [<c0124884>] ksoftirqd+0x0/0xd7
Jul 30 08:42:27 hydra kernel:  [<c0124481>] ___do_softirq+0x83/0x8a
Jul 30 08:42:27 hydra kernel:  [<c01244b9>] _do_softirq+0x6/0x8
Jul 30 08:42:27 hydra kernel:  [<c012490c>] ksoftirqd+0x88/0xd7
Jul 30 08:42:27 hydra kernel:  [<c01341cd>] kthread+0xb7/0xbd
Jul 30 08:42:27 hydra kernel:  [<c0134116>] kthread+0x0/0xbd
Jul 30 08:42:27 hydra kernel:  [<c0103e41>] kernel_thread_helper+0x5/0xb

- with the workaround, I see this
"Jul 30 08:42:33 hydra kernel: psmouse.c: Mouse at
isa0060/serio1/input0 lost synchronization, throwing 1 bytes away."

Cheers, 
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

