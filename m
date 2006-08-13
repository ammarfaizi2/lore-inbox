Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWHMAxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWHMAxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWHMAxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:53:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932634AbWHMAxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:53:54 -0400
Date: Sat, 12 Aug 2006 17:53:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
Subject: Re: [PATCH for review] [43/145] i386: Redo semaphore and rwlock
 assembly helpers
Message-Id: <20060812175348.79175355.akpm@osdl.org>
In-Reply-To: <20060810193557.7E1F313B90@wotan.suse.de>
References: <20060810 935.775038000@suse.de>
	<20060810193557.7E1F313B90@wotan.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 21:35:57 +0200 (CEST)
Andi Kleen <ak@suse.de> wrote:

> - Move them to a pure assembly file. Previously they were in 
> a C file that only consisted of inline assembly. Doing it in pure
> assembler is much nicer.
> - Add a frame.i include with FRAME/ENDFRAME macros to easily
> add frame pointers to assembly functions 
> - Add dwarf2 annotation to them so that the new dwarf2 unwinder
> doesn't get stuck on them
> [TBD: needs review from someone who knows more about CFA than me, e.g. Jan]
> - Random cleanups

This patch causes the below crash after some seconds of disk stresstesting.


BUG: unable to handle kernel paging request at virtual address 4bf2e411
 printing eip:
e4111d00
*pde = 00000000
Oops: 0002 [#1]
SMP 
last sysfs file: 
Modules linked in:
CPU:    1
EIP:    0060:[<e4111d00>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18-rc4 #28) 
EIP is at 0xe4111d00
eax: e6ff89e4   ebx: e6ff89e4   ecx: 00000000   edx: e4110000
esi: e6ff89d4   edi: e6ff88fc   ebp: e4111cf4   esp: e4111cf8
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 2341, ti=e4110000 task=c1d40aa0 task.ti=e4110000)
Stack: c0271d0f 00000282 e4111d10 c03a4bf2 e6ff89e4 c129a900 e4111d38 c015543c 
       e6ff89e4 00000000 e4111d48 e6ff89e4 e6ff89d8 c129a900 00000000 e6ff88fc 
       e4111d48 c014e939 c129a900 d0a8a734 e4111d84 c01752d1 c129a900 c01c588e 
Call Trace:
 [<c01040d9>] show_stack_log_lvl+0xa9/0xd0
 [<c010430d>] show_registers+0x1bd/0x240
 [<c01044cc>] die+0x13c/0x300
 [<c0114ff2>] do_page_fault+0x2a2/0x5dc
 [<c0103bf9>] error_code+0x39/0x40
 [<c0271d0f>] _raw_write_lock+0x3f/0x80
Code: 88 ff e6 f4 1c 11 e4 e4 89 ff e6 7b 00 1c c0 7b 00 00 00 ff ff ff ff 00 1d 11 e4 60 00 00 00 46 00 01 00 0f 1d 27 c0 82 02 00 00 <10> 1d 11 e4 f2 4b 3a c0 e4 89 ff e6 00 a9 29 c1 38 1d 11 e4 3c 
EIP: [<e4111d00>] 0xe4111d00 SS:ESP 0068:e4111cf8
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():0, irqs_disabled():1
 [<c010414b>] show_trace+0x1b/0x20
 [<c01048e4>] dump_stack+0x24/0x30
 [<c0116fe6>] __might_sleep+0xa6/0xb0
 [<c0137e3f>] down_read+0x1f/0x2c
 [<c012db27>] blocking_notifier_call_chain+0x17/0x40
 [<c01203ef>] profile_task_exit+0x1f/0x30
 [<c0121efd>] do_exit+0x1d/0x940
 [<c0104685>] die+0x2f5/0x300
 [<c0114ff2>] do_page_fault+0x2a2/0x5dc
 [<c0103bf9>] error_code+0x39/0x40
 [<c0271d0f>] _raw_write_lock+0x3f/0x80
BUG: NMI Watchdog detected LOCKUP on CPU0, eip c03a47e6, registers:
Modules linked in:
