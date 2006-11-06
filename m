Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423732AbWKFKCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423732AbWKFKCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423715AbWKFKCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:02:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:9947 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423734AbWKFKCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:02:39 -0500
X-Authenticated: #14349625
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>
In-Reply-To: <20061106093815.GB14388@elte.hu>
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org>
	 <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org>
	 <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org>
	 <454E0976.8030303@rncbc.org> <454E15B0.2050008@rncbc.org>
	 <1162742535.2750.23.camel@localhost.localdomain>
	 <454E2FC1.4040700@rncbc.org> <1162797896.6126.5.camel@Homer.simpson.net>
	 <20061106093815.GB14388@elte.hu>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 11:02:51 +0100
Message-Id: <1162807371.13579.4.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 10:38 +0100, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > I just reproduced it running glibc make check.  I had just enabled 
> > kprobes and recompiled with the stock SuSE-10.1 compiler while waiting 
> > for you to send me your .config (nevermind that request) so I could 
> > try to reproduce it here.
> 
> hm, so kprobe_flush_task() is likely PREEMPT_RT-unsafe.
> 
> could you try the patch below, does it help? (a quick review seems to 
> suggest that all codepaths protected by kretprobe_lock are atomic)

Ah, so I did do the right thing.  Besides the oops, I was getting a
pretty frequent non-deadly...

BUG: scheduling while atomic: ld-linux.so.2/0x00000001/11803, CPU#1
 [<b10041fb>] show_trace_log_lvl+0x179/0x18f
 [<b1004803>] show_trace+0x12/0x14
 [<b1004924>] dump_stack+0x19/0x1b
 [<b13aaf02>] __schedule+0x63b/0xea5
 [<b13ab8a6>] schedule+0x30/0xf9
 [<b13ac53a>] rt_spin_lock_slowlock+0x90/0x17a
 [<b13acc67>] rt_spin_lock+0x22/0x24
 [<b13af28b>] kprobe_flush_task+0x11/0x48
 [<b13ab43e>] __schedule+0xb77/0xea5
 [<b13ab8a6>] schedule+0x30/0xf9
 [<b13ac53a>] rt_spin_lock_slowlock+0x90/0x17a
 [<b13acccb>] __rt_spin_lock+0x22/0x28
 [<b13acd64>] rt_write_lock+0x8/0xa
 [<b1024cc5>] do_exit+0x2ae/0x96e
 [<b102541a>] complete_and_exit+0x0/0x16
 [<c90ad000>] 0xc90ad000

...so turned it back into a non-sleeping lock.

You forgot kprobes.h

> 
> 	Ingo
> 
> Index: linux/kernel/kprobes.c
> ===================================================================
> --- linux.orig/kernel/kprobes.c
> +++ linux/kernel/kprobes.c
> @@ -50,7 +50,7 @@ static struct hlist_head kretprobe_inst_
>  static atomic_t kprobe_count;
>  
>  DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
> -DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
> +DEFINE_RAW_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
>  
>  static struct notifier_block kprobe_page_fault_nb = {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

