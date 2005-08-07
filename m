Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752383AbVHGRZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbVHGRZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbVHGRZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:25:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41868 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752383AbVHGRZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:25:04 -0400
Date: Sun, 7 Aug 2005 10:23:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-mm1: oops when starting nscd on AMD64
Message-Id: <20050807102329.006f7d95.akpm@osdl.org>
In-Reply-To: <200508071851.16864.rjw@sisk.pl>
References: <200508071851.16864.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> I get the following Oops after trying to start nscd from YaST on an Athlon64-based box
>  (compiled with CONFIG_DEBUG_SPINLOCK=y):
> 
>  Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
>  <ffffffff801664d8>{kmem_cache_alloc+232}
>  PGD 1501a067 PUD 1501b067 PMD 0
>  Oops: 0000 [1] PREEMPT
>  CPU 0
>  Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
>  Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
>  RIP: 0010:[<ffffffff801664d8>] <ffffffff801664d8>{kmem_cache_alloc+232}
>  RSP: 0018:ffff81001506de88  EFLAGS: 00010202
>  RAX: 0000000000000000 RBX: ffffffff8010eb3e RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffff8100292bdd68 RDI: ffff810001c3f6c0
>  RBP: ffff81001506deb8 R08: 0000000000000000 R09: ffff8100292bdd70
>  R10: 0000000000000006 R11: 0000000000000000 R12: ffff810001c3f6c0
>  R13: ffff8100292bdd68 R14: 00000000800000d0 R15: ffffffff801abe5c
>  FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
>  CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>  CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
>  Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
>  Stack: 0000000000000246 0000000000000000 ffff81001569b5a0 ffff8100155fe980
>         00000000fffffff4 000000000000000a ffff81001506df78 ffffffff801abe5c
>         0000000040a05fff ffff81001569b5a0
>  Call Trace:<ffffffff801abe5c>{sys_epoll_create+604} <ffffffff80243579>{add_preempt_count+105}
>         <ffffffff8010eb3e>{system_call+126}
>  BUG: spinlock trylock failure on UP on CPU#0, nscd/6570
>   lock: ffffffff803bae80, .magic: dead4ead, .owner: nscd/6570, .owner_cpu: 0
> 
>  Call Trace:<ffffffff80243579>{add_preempt_count+105} <ffffffff802431a3>{spin_bug+211}
>         <ffffffff8011004b>{show_trace+571} <ffffffff8024328e>{_raw_spin_trylock+62}
>         <ffffffff8035270e>{_spin_trylock+30} <ffffffff8010fc81>{oops_begin+17}
>         <ffffffff803538ea>{do_page_fault+1722} <ffffffff801343de>{vprintk+830}
>         <ffffffff801343de>{vprintk+830} <ffffffff801521f6>{kallsyms_lookup+246}
>         <ffffffff8010f431>{error_exit+0} <ffffffff8011004b>{show_trace+571}
>         <ffffffff80110047>{show_trace+567} <ffffffff80110168>{show_stack+216}
>         <ffffffff80110207>{show_registers+135} <ffffffff8011050e>{__die+142}
>         <ffffffff80353958>{do_page_fault+1832} <ffffffff802410c1>{vsnprintf+1393}
>         <ffffffff801abe5c>{sys_epoll_create+604} <ffffffff8010f431>{error_exit+0}
>         <ffffffff801abe5c>{sys_epoll_create+604} <ffffffff8010eb3e>{system_call+126}
>         <ffffffff801664d8>{kmem_cache_alloc+232} <ffffffff801664c8>{kmem_cache_alloc+216}
>         <ffffffff801abe5c>{sys_epoll_create+604} <ffffffff80243579>{add_preempt_count+105}
>         <ffffffff8010eb3e>{system_call+126}
>  ---------------------------
>  | preempt count: 00000002 ]
>  | 2 level deep critical section nesting:
>  ----------------------------------------
>  .. [<ffffffff80352706>] .... _spin_trylock+0x16/0x60
>  .....[<ffffffff8010fc81>] ..   ( <= oops_begin+0x11/0x60)
>  .. [<ffffffff80352706>] .... _spin_trylock+0x16/0x60
>  .....[<ffffffff8010fc81>] ..   ( <= oops_begin+0x11/0x60)

I don't think it was supposed to do that.

Quite possibly it's something to do with the new debugging code - could you
please take a copy of the offending config, send it over and then try
removing debug options, see if the crash goes away?  CONFIG_DEBUG_PREEMPT
would be the first to try..

Thanks.
