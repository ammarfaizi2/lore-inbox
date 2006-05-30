Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWE3EuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWE3EuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 00:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWE3EuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 00:50:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:47778 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932138AbWE3EuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 00:50:14 -0400
X-Authenticated: #14349625
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060529212109.GA2058@elte.hu>
References: <20060529212109.GA2058@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 06:52:21 +0200
Message-Id: <1148964741.7704.10.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 23:21 +0200, Ingo Molnar wrote:
> The easiest way to try lockdep on a testbox is to apply the combo patch 
> to 2.6.17-rc4-mm3. The patch order is:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.17-rc4.tar.bz2
>   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm3/2.6.17-rc4-mm3.bz2
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo.patch
> 
> do 'make oldconfig' and accept all the defaults for new config options - 
> reboot into the kernel and if everything goes well it should boot up 
> fine and you should have /proc/lockdep and /proc/lockdep_stats files.

Darn.  It said all tests passed, then oopsed.

(have .config all gzipped up if you want it)

	-Mike

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
b103a872
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<b103a872>]    Not tainted VLI
EFLAGS: 00010083   (2.6.17-rc4-mm3-smp #157)
EIP is at count_matching_names+0x5b/0xa2
eax: b15074a8   ebx: 00000000   ecx: b165c430   edx: b165b320
esi: 00000000   edi: b1410423   ebp: dfe20e74   esp: dfe20e68
ds: 007b   es: 007b   ss: 0068
Process idle (pid: 1, threadinfo=dfe20000 task=effc1470)
Stack: 000139b0 b165c430 00000000 dfe20ec8 b103d442 b1797a6c b1797a64 effc1470
       b1797a64 00000004 b1797a50 00000000 b15074a8 effc1470 dfe20ef8 b106da88
       b169d0a8 b1797a64 dfe20f52 0000000a b106dec7 00000282 dfe20000 00000000
Call Trace:
 <b1003d73> show_stack_log_lvl+0x9e/0xc3  <b1003f80> show_registers+0x1ac/0x237
 <b100413d> die+0x132/0x2fb  <b101a083> do_page_fault+0x5cf/0x656
 <b10038a7> error_code+0x4f/0x54  <b103d442> __lockdep_acquire+0xa6f/0xc32
 <b103d9f8> lockdep_acquire+0x61/0x77  <b13d27f3> _spin_lock+0x2e/0x42
 <b102b03a> register_sysctl_table+0x4e/0xaa  <b15a463a> sched_init_smp+0x411/0x41e
 <b100035d> init+0xbd/0x2c6  <b1001005> kernel_thread_helper+0x5/0xb
Code: 92 50 b1 74 5d 8b 41 10 2b 41 14 31 db 39 42 10 75 0d eb 53 8b 41 10 2b 41 14 3b 42 10 74 48 8b b2 a0 00 00 00 8b b9 a0 00 00 00 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 0b 8b

1151            list_for_each_entry(type, &all_lock_types, lock_entry) {
1152                    if (new_type->key - new_type->subtype == type->key)
1153                            return type->name_version;
1154                    if (!strcmp(type->name, new_type->name))  <--kaboom
1155                            count = max(count, type->name_version);
1156            }

EIP: [<b103a872>] count_matching_names+0x5b/0xa2 SS:ESP 0068:dfe20e68
 Kernel panic - not syncing: Attempted to kill init!
 BUG: warning at arch/i386/kernel/smp.c:537/smp_call_function()
 <b1003dd2> show_trace+0xd/0xf  <b10044c0> dump_stack+0x17/0x19
 <b10129ff> smp_call_function+0x11d/0x122  <b1012a22> smp_send_stop+0x1e/0x31
 <b1022f4b> panic+0x60/0x1d5  <b10267fa> do_exit+0x613/0x94f
 <b1004306> do_trap+0x0/0x9e  <b101a083> do_page_fault+0x5cf/0x656
 <b10038a7> error_code+0x4f/0x54  <b103d442> __lockdep_acquire+0xa6f/0xc32
 <b103d9f8> lockdep_acquire+0x61/0x77  <b13d27f3> _spin_lock+0x2e/0x42
 <b102b03a> register_sysctl_table+0x4e/0xaa  <b15a463a> sched_init_smp+0x411/0x41e
 <b100035d> init+0xbd/0x2c6  <b1001005> kernel_thread_helper+0x5/0xb
BUG: NMI Watchdog detected LOCKUP on CPU1, eip b103cc64, registers:
Modules linked in:
CPU:    1
EIP:    0060:[<b103cc64>]    Not tainted VLI
EFLAGS: 00000086   (2.6.17-rc4-mm3-smp #157)
EIP is at __lockdep_acquire+0x291/0xc32
eax: 00000000   ebx: 000001d7   ecx: b16bf938   edx: 00000000
esi: 00000000   edi: b16bf938   ebp: effc4ea4   esp: effc4e58
ds: 007b   es: 007b   ss: 0068
Process idle (pid: 0, threadinfo=effc4000 task=effc0a50)
Stack: b101d4ce 00000000 effc0fb8 000001d7 effc0a50 b16bf938 00000000 b29b38c8
       effc0a50 effc0fb8 00000001 00000000 00000005 00000000 00000000 00000000
       00000096 effc4000 00000000 effc4ecc b103d9f8 00000000 00000001 b101d4ce
Call Trace:
 <b1003d73> show_stack_log_lvl+0x9e/0xc3  <b1003f80> show_registers+0x1ac/0x237
 <b10050d9> die_nmi+0x93/0xeb  <b1015af1> nmi_watchdog_tick+0xff/0x20e
 <b1004542> do_nmi+0x80/0x249  <b1003912> nmi_stack_correct+0x1d/0x22
 <b103d9f8> lockdep_acquire+0x61/0x77  <b13d27f3> _spin_lock+0x2e/0x42
 <b101d4ce> scheduler_tick+0xd0/0x381  <b102d47e> update_process_times+0x42/0x61
 <b1014f9f> smp_apic_timer_interrupt+0x67/0x78  <b10037ba> apic_timer_interrupt+0x2a/0x30
 <b1001e5b> cpu_idle+0x71/0xb8  <b1013c6e> start_secondary+0x3e5/0x46b
 <00000000> _stext+0x4efffd68/0x8  <effc4fb4> 0xeffc4fb4
Code: 18 01 90 39 c7 0f 84 2e 02 00 00 8b 50 0c 31 f2 8b 40 08 31 d8 09 c2 75 e2 f0 ff 05 08 8a 61 b1 f0 fe 0d e4 92 50 b1 79 0d f3 90 <80> 3d e4 92 50 b1 00 7e f5 eb ea 8b 55 d4 8b b2 64 05 00 00 85
console shuts up ...


