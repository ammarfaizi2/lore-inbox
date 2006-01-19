Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbWASAPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbWASAPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWASAPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:15:05 -0500
Received: from alpha.polcom.net ([83.143.162.52]:7150 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1161064AbWASAPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:15:03 -0500
Date: Thu, 19 Jan 2006 01:14:56 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-kernel@vger.kernel.org
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: BUG in tmpfs
Message-ID: <Pine.LNX.4.63.0601190027320.8060@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I managed to get something like this:

kernel BUG at mm/shmem.c:836!
Jan 17 23:31:42 kangur [4312977.009000] CPU:    0
Jan 17 23:31:42 kangur [4312977.009000] EIP:    0060:[<b014a429>] 
Tainted: P      VLI
Jan 17 23:31:42 kangur [4312977.009000] EFLAGS: 00210206 
(2.6.15-rc6-git4-ck1)
Jan 17 23:31:42 kangur [4312977.009000] EIP is at 
shmem_writepage+0xa6/0x15a
Jan 17 23:31:42 kangur [4312977.009000] eax: e45a5778   ebx: e45a5778 
ecx: 00000000   edx: 00000001
Jan 17 23:31:42 kangur [4312977.009000] esi: b3641000   edi: b1644000 
ebp: e45a57bc   esp: b3641d40
Jan 17 23:31:42 kangur [4312977.009000] ds: 007b   es: 007b   ss: 0068
Jan 17 23:31:42 kangur [4312977.009000] Process cc1 (pid: 2054, 
threadinfo=b3641000 task=b4173050)
Jan 17 23:31:42 kangur [4312977.009000] Stack: e45a5760 00013b24 00013b24 
b1644000 b1644000 e45a585c b3641e1c b013e168
Jan 17 23:31:42 kangur [4312977.009000]        00000000 00000000 00000000 
00000020 00000000 00000000 00000000 00000000
Jan 17 23:31:42 kangur [4312977.009000]        00000000 00000009 00000060 
00200246 b1644000 e45a585c e45a585c b013e3d1
Jan 17 23:31:42 kangur [4312977.009000] Call Trace:
Jan 17 23:31:42 kangur [4312977.009000]  [<b013e168>] pageout+0xbd/0xfa
Jan 17 23:31:42 kangur [4312977.009000]  [<b013e3d1>] 
shrink_list+0x22c/0x439
Jan 17 23:31:42 kangur [4312977.009000]  [<b0110db3>] 
smp_apic_timer_interrupt+0x34/0x77
Jan 17 23:31:42 kangur [4312977.009000]  [<b0103590>] 
apic_timer_interrupt+0x1c/0x24
Jan 17 23:31:42 kangur [4312977.009000]  [<b013d5e4>] 
__pagevec_release+0x15/0x1d
Jan 17 23:31:42 kangur [4312977.009000]  [<b013e77f>] 
shrink_cache+0x108/0x262
Jan 17 23:31:42 kangur [4312977.009000]  [<b013ed4c>] 
shrink_zone+0xa6/0xbc
Jan 17 23:31:42 kangur [4312977.009000]  [<b013ee19>] 
shrink_caches+0x4c/0x57
Jan 17 23:31:42 kangur [4312977.009000]  [<b013ef15>] 
try_to_free_pages+0xf1/0x1b9
Jan 17 23:31:42 kangur [4312977.009000]  [<b0137cc6>] 
__alloc_pages+0x171/0x266
Jan 17 23:31:42 kangur [4312977.009000]  [<b0142041>] 
do_anonymous_page+0x3e/0x143
Jan 17 23:31:42 kangur [4312977.009000]  [<b0142436>] 
__handle_mm_fault+0xa4/0x17f
Jan 17 23:31:42 kangur [4312977.009000]  [<b01134b9>] 
do_page_fault+0x176/0x4c1
Jan 17 23:31:42 kangur [4312977.009000]  [<b011babe>] irq_exit+0x29/0x34
Jan 17 23:31:42 kangur [4312977.009000]  [<b0104ade>] do_IRQ+0x52/0x5c
Jan 17 23:31:42 kangur [4312977.009000]  [<b0113343>] 
do_page_fault+0x0/0x4c1
Jan 17 23:31:42 kangur [4312977.009000]  [<b010365b>] error_code+0x4f/0x54
Jan 17 23:31:42 kangur [4312977.009000] Code: 0b 3f 03 13 e2 28 b0 e9 a0 
00 00 00 8b 04 24 31 c9 89 da e8 61 f3 ff ff 85 c0 89 c3 75 08 0f 0b 43 03 
13 e2 28 b0 8
3 3b 00 74 08 <0f> 0b 44 03 13 e2 28 b0 8b 54 24 04 89 f8 e8 7e cd ff ff 
85 c0
Jan 17 23:31:42 kangur [4312977.009000]  <6>note: cc1[2054] exited with 
preempt_count 1


after about half an hour of compiling 4.1.0_beta20060113 (from Gentoo) 
with all compilation files at tmpfs.

It does not look like it is easily reproductible and takes long time so I 
don't know if I will be able to reproduce it again in any sane time. But 
maybe somebody who knows mm better than me will be able to do something 
with this or will be able to say - "Hey it is fixed already in ...".

This is on kernel 2.6.15-rc6-git4-ck1 (so ck list in CC but I am not 
saying that -ck is responsible - there are some patches like swap prefetch 
in it so maybe...?) on Athlon XP 2000MHz machine with 1GB of RAM and 4GB 
of SWAP (in file on ext3 partition). I am rather sure that the hardware is 
100% ok because it was build 5 weeks ago and tested with memtest and prime 
for hours. Also there were no such problems with this kernel. Of course 
(it is Gentoo) whole system was compiled from source (with all compilation 
files on this tmpfs). So I don't know what could cause this.

In case somebody wonders what this line looks like in my kernel, here it 
is:

         BUG_ON(!PageLocked(page));
         BUG_ON(page_mapped(page));

         mapping = page->mapping;
         index = page->index;
         inode = mapping->host;
         info = SHMEM_I(inode);
         if (info->flags & VM_LOCKED)
                 goto redirty;
         swap = get_swap_page();
         if (!swap.val)
                 goto redirty;

         spin_lock(&info->lock);
         shmem_recalc_inode(inode);
         if (index >= info->next_index) {
                 BUG_ON(!(info->flags & SHMEM_TRUNCATE));
                 goto unlock;
         }
         entry = shmem_swp_entry(info, index, NULL);
         BUG_ON(!entry);
THIS LINE =>=>=>        BUG_ON(entry->val);

         if (move_to_swap_cache(page, swap) == 0) {
                 shmem_swp_set(info, entry, swap.val);
                 shmem_swp_unmap(entry);
                 spin_unlock(&info->lock);
                 if (list_empty(&info->swaplist)) {
                         spin_lock(&shmem_swaplist_lock);
                         /* move instead of add in case we're racing */
                         list_move_tail(&info->swaplist, &shmem_swaplist);
                         spin_unlock(&shmem_swaplist_lock);
                 }
                 unlock_page(page);
                 return 0;
         }

         shmem_swp_unmap(entry);



Thanks in advance,

Grzegorz Kulewski

