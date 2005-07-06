Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVGFS6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVGFS6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVGFSzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:55:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48299 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262167AbVGFNtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:49:51 -0400
Date: Wed, 6 Jul 2005 15:49:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: rt-preempt build failure
Message-ID: <20050706134950.GC19467@elte.hu>
References: <200507052308.43970.kernel@kolivas.org> <20050705135143.GA13614@elte.hu> <200507062304.03944.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507062304.03944.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> > thanks, i have fixed this and have uploaded the -51-00 patch.
> 
> Thanks. boots and runs stable after a swag of these initially 
> (?netconsole related):
> 
> BUG: scheduling with irqs disabled: swapper/0x00000000/1
> caller is __down_mutex+0x143/0x200
>  [<c02dd908>] schedule+0x95/0xf5 (8)
>  [<c02de5b6>] __down_mutex+0x143/0x200 (28)
>  [<c02422c3>] b44_start_xmit+0x23/0x3ee (84)
>  [<c0292beb>] find_skb+0xa4/0xe4 (8)
>  [<c0292c3e>] netpoll_send_skb+0x13/0xb0 (48)
>  [<c0243dcb>] write_msg+0x5f/0xb6 (16)
>  [<c0243d6c>] write_msg+0x0/0xb6 (12)
>  [<c011c3e1>] __call_console_drivers+0x41/0x4d (8)
>  [<c011c551>] call_console_drivers+0xec/0x109 (20)
>  [<c011c973>] release_console_sem+0x24/0xd4 (32)
>  [<c0243e7e>] init_netconsole+0x40/0x74 (24)
>  [<c03fa9ac>] do_initcalls+0x55/0xc7 (12)
>  [<c010038b>] init+0x8a/0x1b3 (32)
>  [<c0100301>] init+0x0/0x1b3 (16)
>  [<c0100f71>] kernel_thread_helper+0x5/0xb (8)

ok, the patch below (or -51-04 and later kernels) should fix this one.  
printk is fully preemptible from now on - lets see how it works out in 
practice. (i kept it under irqs-off to make sure we get all crash 
messages out. Perhaps we could disable irqs/preemption if 
oops_in_progress?) This patch should also fix similar, fbcon related 
messages.

	Ingo

Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -738,9 +738,8 @@ void release_console_sem(void)
 		_con_start = con_start;
 		_log_end = log_end;
 		con_start = log_end;		/* Flush */
-		spin_unlock(&logbuf_lock);
+		spin_unlock_irq(&logbuf_lock);
 		call_console_drivers(_con_start, _log_end);
-		raw_local_irq_restore(flags);
 	}
 	console_locked = 0;
 	console_may_schedule = 0;
