Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752319AbVHGQqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbVHGQqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbVHGQqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:46:03 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:12241 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S1752317AbVHGQqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:46:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.13-rc5-mm1: oops when starting nscd on AMD64
Date: Sun, 7 Aug 2005 18:51:16 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ewj9CXgP3A1prng"
Message-Id: <200508071851.16864.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Ewj9CXgP3A1prng
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I get the following Oops after trying to start nscd from YaST on an Athlon64-based box
(compiled with CONFIG_DEBUG_SPINLOCK=y):

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff801664d8>{kmem_cache_alloc+232}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff801664d8>] <ffffffff801664d8>{kmem_cache_alloc+232}
RSP: 0018:ffff81001506de88  EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffffff8010eb3e RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8100292bdd68 RDI: ffff810001c3f6c0
RBP: ffff81001506deb8 R08: 0000000000000000 R09: ffff8100292bdd70
R10: 0000000000000006 R11: 0000000000000000 R12: ffff810001c3f6c0
R13: ffff8100292bdd68 R14: 00000000800000d0 R15: ffffffff801abe5c
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000246 0000000000000000 ffff81001569b5a0 ffff8100155fe980
       00000000fffffff4 000000000000000a ffff81001506df78 ffffffff801abe5c
       0000000040a05fff ffff81001569b5a0
Call Trace:<ffffffff801abe5c>{sys_epoll_create+604} <ffffffff80243579>{add_preempt_count+105}
       <ffffffff8010eb3e>{system_call+126}
BUG: spinlock trylock failure on UP on CPU#0, nscd/6570
 lock: ffffffff803bae80, .magic: dead4ead, .owner: nscd/6570, .owner_cpu: 0

Call Trace:<ffffffff80243579>{add_preempt_count+105} <ffffffff802431a3>{spin_bug+211}
       <ffffffff8011004b>{show_trace+571} <ffffffff8024328e>{_raw_spin_trylock+62}
       <ffffffff8035270e>{_spin_trylock+30} <ffffffff8010fc81>{oops_begin+17}
       <ffffffff803538ea>{do_page_fault+1722} <ffffffff801343de>{vprintk+830}
       <ffffffff801343de>{vprintk+830} <ffffffff801521f6>{kallsyms_lookup+246}
       <ffffffff8010f431>{error_exit+0} <ffffffff8011004b>{show_trace+571}
       <ffffffff80110047>{show_trace+567} <ffffffff80110168>{show_stack+216}
       <ffffffff80110207>{show_registers+135} <ffffffff8011050e>{__die+142}
       <ffffffff80353958>{do_page_fault+1832} <ffffffff802410c1>{vsnprintf+1393}
       <ffffffff801abe5c>{sys_epoll_create+604} <ffffffff8010f431>{error_exit+0}
       <ffffffff801abe5c>{sys_epoll_create+604} <ffffffff8010eb3e>{system_call+126}
       <ffffffff801664d8>{kmem_cache_alloc+232} <ffffffff801664c8>{kmem_cache_alloc+216}
       <ffffffff801abe5c>{sys_epoll_create+604} <ffffffff80243579>{add_preempt_count+105}
       <ffffffff8010eb3e>{system_call+126}
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<ffffffff80352706>] .... _spin_trylock+0x16/0x60
.....[<ffffffff8010fc81>] ..   ( <= oops_begin+0x11/0x60)
.. [<ffffffff80352706>] .... _spin_trylock+0x16/0x60
.....[<ffffffff8010fc81>] ..   ( <= oops_begin+0x11/0x60)

It causes other Oopses to appear in an infinite loop (some of them are attached).

This is 100% reproducible, and 2.6.13-rc5 is not affected.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_Ewj9CXgP3A1prng
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="oops-1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oops-1.log"

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [2] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506dbc8  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
RBP: ffff81001506dc08 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506dae8 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000024 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000092 000000001506dc08 ffff81001506ded8
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506dc48 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [3] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506d908  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
RBP: ffff81001506d948 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506d828 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000096 000000001506d948 ffff81001506dc18
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506d988 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [4] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506d648  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81001506d688 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506d568 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000096 000000001506d688 ffff81001506d958
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506d6c8 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [5] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506d388  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81001506d3c8 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506d2a8 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000092 000000001506d3c8 ffff81001506d698
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506d408 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [6] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506d0c8  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
RBP: ffff81001506d108 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506cfe8 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000092 000000001506d108 ffff81001506d3d8
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506d148 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [7] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506ce08  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
RBP: ffff81001506ce48 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506cd28 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000096 000000001506ce48 ffff81001506d118
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506ce88 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [8] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506cb48  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81001506cb88 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506ca68 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000096 000000001506cb88 ffff81001506ce58
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506cbc8 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [9] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0018:ffff81001506c888  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 000000000000002b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81001506c8c8 R08: 0000000000000000 R09: 0000000000000001
R10: ffff81001506c7a8 R11: 0000000000000000 R12: ffff81001506e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80463fc0
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: 0000000000000000 0000000000000092 000000001506c8c8 ffff81001506cb98
       000000000000000a ffffffff80463fc0 ffffffff8045ffc0 0000000000000000
       ffff81001506c908 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 1501a067 PUD 1501b067 PMD 0
Oops: 0000 [10] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "lib/preempt.c":68
invalid operand: 0000 [11] PREEMPT
CPU 0
Modules linked in: raw af_key usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97t
Pid: 6570, comm: nscd Not tainted 2.6.13-rc5-mm1
RIP: 0010:[<ffffffff802434e1>] <ffffffff802434e1>{sub_preempt_count+49}
RSP: 0018:ffff81001506c0d8  EFLAGS: 00010046
RAX: 00000000ffff8100 RBX: ffff81001506c1a8 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81001506c0d8 R08: 0000000000000000 R09: 0000000000000002
R10: ffff81001506c1a8 R11: 0000000000000000 R12: ffffffff8036c573
R13: ffffffff80476b62 R14: ffff81001506c5c8 R15: 0000000000000022
FS:  00002aaaab11cb00(0000) GS:ffffffff804f2840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000015019000 CR4: 00000000000006e0
Process nscd (pid: 6570, threadinfo ffff81001506c000, task ffff81001506b250)
Stack: ffff81001506c198 ffffffff801343de ffff81001506c128 0000000000000092
       0000001f00000000 ffffffff803e3d80 000000000000cc82 000000000000001f
       ffffffffffff7877 0000000000000022
Call Trace:<ffffffff801343de>{vprintk+830} <ffffffff80243579>{add_preempt_count+105}
       <ffffffff803528ad>{_spin_unlock_irqrestore+29} <ffffffff8011004b>{show_trace+571}
       <ffffffff801344b2>{printk+162} <ffffffff8011004b>{show_trace+571}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8011004b>{show_trace+571}
       <ffffffff8010fe02>{printk_address+162} <ffffffff801336cb>{print_tainted+187}
       <ffffffff8010db3f>{__show_regs+143} <ffffffff801101c2>{show_registers+66}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff801343de>{vprintk+830} <ffffffff801343de>{vprintk+830}
       <ffffffff801521f6>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80353958>{do_page_fault+1832}
       <ffffffff802410c1>{vsnprintf+1393} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010f431>{error_exit+0} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff8010eb3e>{system_call+126} <ffffffff801664d8>{kmem_cache_alloc+232}
       <ffffffff801664c8>{kmem_cache_alloc+216} <ffffffff801abe5c>{sys_epoll_create+604}
       <ffffffff80243579>{add_preempt_count+105} <ffffffff8010eb3e>{system_call+126}

--Boundary-00=_Ewj9CXgP3A1prng--
