Return-Path: <linux-kernel-owner+w=401wt.eu-S1751890AbWLOKyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbWLOKyH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 05:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWLOKyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 05:54:06 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:31188
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751890AbWLOKyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 05:54:05 -0500
Message-Id: <45828D19.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Fri, 15 Dec 2006 10:55:05 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19, more unwinder problems ...
References: <20061215101546.GA2296@elte.hu>
In-Reply-To: <20061215101546.GA2296@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I submitted a patch to replace __get_user() with probe_kernel_address(),
Andi told me he had done this conversion already. I had assumed that he had
included this in his final merge submission. As he hasn't I now have to conclude
that he has or will submit it for 2.6.20.

Also, there is extra checking being done right before the memory access:

				if ((state.regs[i].value * state.dataAlign)
				    % sizeof(unsigned long)
				    || addr < startLoc
				    || addr + sizeof(unsigned long) < addr
				    || addr + sizeof(unsigned long) > endLoc)
					return -EIO;

validating that the item read is between current and previous stack pointer,
which in turn are being derived from register state and unwind information.
A tighter register state check is also pending for 2.6.20 (or already in
2.6.19-gitX), but as I refuse to disallow the unwinder to follow stack
switches (as I view this one of its core features) I can't currently see how to
prevent the possibility of the cfa running wild in

	cfa = FRAME_REG(state.cfa.reg, unsigned long) + state.cfa.offs;
	startLoc = min((unsigned long)UNW_SP(frame), cfa);
	endLoc = max((unsigned long)UNW_SP(frame), cfa);
	if (STACK_LIMIT(startLoc) != STACK_LIMIT(endLoc)) {
		startLoc = min(STACK_LIMIT(cfa), cfa);
		endLoc = max(STACK_LIMIT(cfa), cfa);
	}

other than by adding a range check to disallow this pointing into user space.
But in my opinion such a range check wouldn't help at all, as it doesn't catch
all wrong cases, it should really be the probe_kernel_address() that should
prevent any blocking page fault processing.

Jan

>>> Ingo Molnar <mingo@elte.hu> 15.12.06 11:15 >>>
Jan,

i got the dump below on x86_64 (2.6.19 with the -rt patch applied but no 
changes to the unwinder). How on earth did we get a pagefault in 
unwind()? It seems we do:

0xffffffff8026127e is in unwind (kernel/unwind.c:1109).
1104                                            return -EIO;
1105                                    switch(reg_info[i].width) {
1106    #define CASE(n)     case sizeof(u##n): \
1107                                            __get_user(FRAME_REG(i, u##n), (u##n *)addr); \
1108                                            break
1109                                    CASES;
1110    #undef CASE
1111                                    default:
1112                                            return -EIO;
1113                                    }
(gdb)

now that looks quite wrong to me - why the __get_user() to begin with - 
you should really validate that the pointer is where you expect it - at 
which point __get_user() is not needed.

now, this dump was not fatal so the pagefault did eventually manage to 
extend the userspace stack - but it could have been fatal.

i thought we agreed that the unwinder would not be doing get_user() at 
all?

(gcc version 4.0.2, binutils 2.16.1)

	Ingo

------------>
BUG: sleeping function called from invalid context mount(489) at mm/rmap.c:78
in_atomic():0 [00000000], irqs_disabled():1
1 lock held by mount/489:
 #0:  ((struct rw_semaphore *)(&mm->mmap_sem)){----}, at: [<ffffffff804cade2>] do_page_fault+0x3de/0x848
irq event stamp: 861
hardirqs last  enabled at (861): [<ffffffff80285828>] __inc_zone_page_state+0x4d/0x58
hardirqs last disabled at (860): [<ffffffff80285805>] __inc_zone_page_state+0x2a/0x58
softirqs last  enabled at (0): [<ffffffff80235621>] copy_process+0x580/0x17c8
softirqs last disabled at (0): [<0000000000000000>] 0x0

Call Trace:
 [<ffffffff8020b5f3>] dump_trace+0xaa/0x406
 [<ffffffff8020b989>] show_trace+0x3a/0x60
 [<ffffffff8020bbcb>] dump_stack+0x15/0x17
 [<ffffffff8022d826>] __might_sleep+0x128/0x12d
 [<ffffffff8028ff95>] anon_vma_prepare+0x27/0xe1
 [<ffffffff8028c20d>] expand_stack+0x1e/0x140
 [<ffffffff804cae5c>] do_page_fault+0x458/0x848
 [<ffffffff804c8f4d>] error_exit+0x0/0x96
 [<ffffffff8026127e>] unwind+0xaca/0xb0d
 [<ffffffff8020b52e>] dump_trace_unwind+0x59/0x74
 [<ffffffff802602f2>] unwind_init_running+0x20/0x22
 [<ffffffff8020b5f3>] dump_trace+0xaa/0x406
 [<ffffffff80211da7>] save_stack_trace+0x1f/0x38
 [<ffffffff802538cb>] save_trace+0x46/0xa5
 [<ffffffff80253a1d>] add_lock_to_list+0x78/0xa7
 [<ffffffff80254e67>] __lock_acquire+0x906/0xa1f
 [<ffffffff802554d8>] lock_acquire+0x4c/0x66
 [<ffffffff804c78a9>] rt_spin_lock+0x3d/0x41
 [<ffffffff80240d6d>] lock_timer_base+0x23/0x4a
 [<ffffffff80240f27>] __mod_timer+0x40/0xd5
 [<ffffffff80241002>] mod_timer+0x46/0x4b
 [<ffffffff80440e37>] ledtrig_ide_activity+0x37/0x3b
 [<ffffffff803fe329>] ide_do_rw_disk+0x6a/0x4a4
 [<ffffffff803f535e>] ide_do_request+0x7e5/0x9ca
 [<ffffffff803f5881>] do_ide_request+0x1b/0x1d
 [<ffffffff8033a3b5>] __generic_unplug_device+0x27/0x2b
 [<ffffffff8033a532>] blk_start_queueing+0x1e/0x20
 [<ffffffff80344fc6>] cfq_insert_request+0x24e/0x3d9
 [<ffffffff80339042>] elv_insert+0x14c/0x1ff
 [<ffffffff8033918d>] __elv_add_request+0x98/0xa0
 [<ffffffff8033e1c0>] __make_request+0x41b/0x459
 [<ffffffff8033a74f>] generic_make_request+0x21b/0x236
 [<ffffffff8033c62c>] submit_bio+0x110/0x119
 [<ffffffff802cc47e>] mpage_bio_submit+0x22/0x26
 [<ffffffff802cca56>] do_mpage_readpage+0x466/0x4fe
 [<ffffffff802cd60e>] mpage_readpages+0xcf/0x165
 [<ffffffff802efb4b>] ext3_readpages+0x1a/0x1c
 [<ffffffff8028119d>] __do_page_cache_readahead+0x10b/0x1f0
 [<ffffffff802813bf>] do_page_cache_readahead+0x52/0x5f
 [<ffffffff8027c33e>] filemap_nopage+0x193/0x3dd
 [<ffffffff80289c55>] __handle_mm_fault+0x22e/0xcf8
 [<ffffffff804cae9e>] do_page_fault+0x49a/0x848
 [<ffffffff804c8f4d>] error_exit+0x0/0x96
 [<ffffffff8034c4ac>] __clear_user+0x3a/0x5c
 [<ffffffff8034c592>] clear_user+0x2b/0x33
 [<ffffffff802d7940>] load_elf_binary+0x7a1/0x1a76
 [<ffffffff802a9e74>] search_binary_handler+0x113/0x35d
 [<ffffffff802aa266>] do_execve+0x1a8/0x266
 [<ffffffff8020821b>] sys_execve+0x36/0x89
 [<ffffffff8020a407>] stub_execve+0x67/0xb0
 [<ffffffff8029eb5c>] kmem_cache_zalloc+0x52/0x110

