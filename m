Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWEaVDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWEaVDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWEaVDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:03:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964983AbWEaVDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:03:24 -0400
Date: Wed, 31 May 2006 14:06:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1 panic on p-series
Message-Id: <20060531140621.2dabe7fb.akpm@osdl.org>
In-Reply-To: <447DEE53.2010301@mbligh.org>
References: <447DEE53.2010301@mbligh.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@mbligh.org> wrote:
>
> Get a different panic on -mm1 from mainline (and much
> earlier)
> 
> http://test.kernel.org/abat/33808/debug/console.log
> 
> Badness in local_bh_disable at kernel/softirq.c:86

That's a WARN_ON which should be removed.

--- devel/kernel/softirq.c~lock-validator-irqtrace-core-remove-softirqc-warn_on	2006-05-30 14:35:53.000000000 -0700
+++ devel-akpm/kernel/softirq.c	2006-05-30 14:35:53.000000000 -0700
@@ -83,7 +83,6 @@ static void __local_bh_disable(unsigned 
 
 void local_bh_disable(void)
 {
-	WARN_ON_ONCE(irqs_disabled());
 	__local_bh_disable((unsigned long)__builtin_return_address(0));
 }
 

> Call Trace:
> [C00000000051F280] [C00000000000EEC8] .show_stack+0x74/0x1b4 (unreliable)
> [C00000000051F330] [C000000000338664] .program_check_exception+0x1f4/0x65c
> [C00000000051F410] [C0000000000044EC] program_check_common+0xec/0x100
> --- Exception: 700 at .local_bh_disable+0x34/0x4c

But what's up with that?  Does it mean that local_bh_disable() went BUG(),
or what?

>      LR = .do_softirq+0x64/0xd0
> [C00000000051F790] [C000000000063B64] .irq_exit+0x64/0x7c
> [C00000000051F810] [C0000000000228E0] .timer_interrupt+0x464/0x48c
> [C00000000051F8E0] [C0000000000034EC] decrementer_common+0xec/0x100
> --- Exception: 901 at .memset+0x80/0xfc
>      LR = .__alloc_bootmem_core+0x39c/0x3dc
> [C00000000051FBD0] [C0000000004460E8] 0xc0000000004460e8 (unreliable)
> [C00000000051FC90] [C0000000003D51B0] .__alloc_bootmem_nopanic+0x44/0xb0
> [C00000000051FD30] [C0000000003D523C] .__alloc_bootmem+0x20/0x5c
> [C00000000051FDB0] [C0000000003D6124] .alloc_large_system_hash+0x130/0x268
> [C00000000051FE70] [C0000000003D78D4] .vfs_caches_init_early+0x5c/0xd4
> [C00000000051FEF0] [C0000000003BD718] .start_kernel+0x220/0x320
> [C00000000051FF90] [C000000000008594] .start_here_common+0x88/0x8c

I don't know if this is a consequence of earlier happenings or a
consequence of Andy ;)

