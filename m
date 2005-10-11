Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVJKIBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVJKIBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVJKIBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:01:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:57049 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751410AbVJKIBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:01:18 -0400
Date: Tue, 11 Oct 2005 10:01:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051011080151.GA27401@elte.hu>
References: <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> <1128458707.13057.68.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu> <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510061122530.418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510061122530.418@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo, the following bug popped up.
> 
> BUG: scheduling while atomic: modprobe/0x00000001/3083
> caller is schedule+0x84/0x111
>  [<c0103fe2>] dump_stack+0x1e/0x20 (20)
>  [<c0323402>] __schedule+0x742/0xa94 (84)
>  [<c03237d8>] schedule+0x84/0x111 (28)
>  [<c0324a7b>] __down_mutex+0x56b/0x83a (116)
>  [<c0326bcf>] _spin_lock+0x1f/0x44 (28)
>  [<c0155070>] __kmalloc+0x6c/0x11d (36)
>  [<c021e989>] soft_cursor+0x61/0x1a8 (76)
>  [<c02175c4>] bit_cursor+0x2d3/0x588 (164)
>  [<c0212b4e>] fbcon_cursor+0x1be/0x307 (76)
>  [<c0213529>] fbcon_scroll+0x84/0xf5d (80)
>  [<c026bafd>] scrup+0xce/0xd8 (40)
>  [<c026d1a5>] lf+0x50/0x5d (28)
>  [<c026f3ad>] vt_console_print+0x116/0x2bb (56)
>  [<c011e9c4>] __call_console_drivers+0x47/0x56 (32)
>  [<c011ea4a>] _call_console_drivers+0x77/0x7e (24)
>  [<c011eaf6>] call_console_drivers+0xa5/0x183 (44)
>  [<c011f0af>] release_console_sem+0x2e/0xeb (32)
>  [<c011ef85>] vprintk+0x2aa/0x312 (108)
>  [<c011ecd9>] printk+0x1b/0x1d (20)
>  [<f8c2f04a>] usb_register_bus+0xf1/0x137 [usbcore] (36)

> I didn't know that down_mutex could cause the scheduling while atomic.  
> It seems that the driver inside the vt_console failed to grab a lock, 
> and this will output, since printk does a raw_spin_lock_irqsave that 
> seems to also do a preempt_disable. (the kmallocs are GFP_ATOMIC).

it's vprintk keeping preemption disabled, and then calling the console 
drivers, which may reschedule. The patch below should solve this.

	Ingo

Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -545,6 +545,7 @@ asmlinkage int vprintk(const char *fmt, 
 	/* This stops the holder of console_sem just where we want him */
 	spin_lock_irqsave(&logbuf_lock, flags);
 	printk_cpu = smp_processor_id();
+	preempt_enable();
 
 	/* Emit the output into the temporary buffer */
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
@@ -637,7 +638,6 @@ asmlinkage int vprintk(const char *fmt, 
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 out:
-	preempt_enable();
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
