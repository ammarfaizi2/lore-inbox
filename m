Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUDIW5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUDIW5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:57:12 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:18336 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261236AbUDIW5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:57:02 -0400
Date: Fri, 09 Apr 2004 15:56:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <5220000.1081551411@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0404092247480.5269-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404092247480.5269-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > This anobjrmap 9 (or anon_mm9) patch adds Rajesh's radix priority search
>> > tree on top of Martin's 2.6.5-rc3-mjb2 tree, making a priority mjb tree!
>> > Approximately equivalent to Andrea's 2.6.5-aa1, but using anonmm instead
>> > of anon_vma, and of course each tree has its own additional features.
>> 
>> This slows down kernel compile a little, but worse, it slows down SDET
>> by about 25% (on the 16x). I think you did something horrible to sem
>> contention ... presumably i_shared_sem, which SDET was fighting with
>> as it was anyway ;-(
>> 
>> Diffprofile shows:
>> 
>>     122626    15.7% total
>>      44129   790.0% __down
>>      20988     4.1% default_idle
> 
> Many thanks for the good news, Martin ;)
> Looks like I've done something very stupid, perhaps a mismerge.
> Not found it yet, I'll carry on looking tomorrow.

I applied Andrew's high sophisticated proprietary semtrace technology.
The common ones are: 

Call Trace:
 [<c0105aee>] __down+0x96/0x10c
 [<c0118fb8>] default_wake_function+0x0/0x1c
 [<c0105cb8>] __down_failed+0x8/0xc
 [<c014314f>] .text.lock.mmap+0x39/0x12a
 [<c01421a7>] do_mmap_pgoff+0x4cf/0x60c
 [<c010cb74>] old_mmap+0x108/0x144
 [<c025c753>] syscall_call+0x7/0xb

Which is the vma_link call from do_mmap_pgoff here:

        /* Can addr have changed??
         *
         * Answer: Yes, several device drivers can do it in their
         *         f_op->mmap method. -DaveM
         */
        addr = vma->vm_start;

        if (!file || !rb_parent || !vma_merge(mm, prev, rb_parent, addr,
                                addr + len, vma->vm_flags, file, pgoff)) {
                vma_link(mm, vma, prev, rb_link, rb_parent);
                if (correct_wcount)
                        atomic_inc(&inode->i_writecount);

vma_link takes i_shared_sem.

Call Trace:
 [<c0105aee>] __down+0x96/0x10c
 [<c0118fb8>] default_wake_function+0x0/0x1c
 [<c0105cb8>] __down_failed+0x8/0xc
 [<c01431dd>] .text.lock.mmap+0xc7/0x12a
 [<c0142b4c>] do_munmap+0xbc/0x128
 [<c0141f91>] do_mmap_pgoff+0x2b9/0x60c
 [<c010cb74>] old_mmap+0x108/0x144
 [<c025c753>] syscall_call+0x7/0xb

Is the call to split_vma from do_munmap here:

        /*
         * If we need to split any vma, do it now to save pain later.
         *
         * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
         * unmapped vm_area_struct will remain in use: so lower split_vma
         * places tmp vma above, and higher split_vma places tmp vma below.
         */
        if (start > mpnt->vm_start) {
                if (split_vma(mm, mpnt, start, 0))
                        return -ENOMEM;
                prev = mpnt;
        }

split_vma takes i_shared_sem, then takes page_table_lock inside it
(which probably isn't helping either ;-)).

        if (mapping)
                down(&mapping->i_shared_sem);
        spin_lock(&mm->page_table_lock);

Call Trace:
 [<c0105aee>] __down+0x96/0x10c
 [<c0118fb8>] default_wake_function+0x0/0x1c
 [<c0105cb8>] __down_failed+0x8/0xc
 [<c014311b>] .text.lock.mmap+0x5/0x12a
 [<c0142f79>] exit_mmap+0x191/0x1d0
 [<c011ae84>] mmput+0x50/0x70
 [<c011ec6d>] do_exit+0x1b9/0x330
 [<c011eefa>] do_group_exit+0x9e/0xa0
 [<c011ef0a>] sys_exit_group+0xe/0x14
 [<c025c753>] syscall_call+0x7/0xb

That's remove_shared_vm_struct calling i_shared_sem

Call Trace:
 [<c0105aee>] __down+0x96/0x10c
 [<c0118fb8>] default_wake_function+0x0/0x1c
 [<c0105cb8>] __down_failed+0x8/0xc
 [<c014311b>] .text.lock.mmap+0x5/0x12a
 [<c0142694>] unmap_vma+0x44/0x78
 [<c01426dc>] unmap_vma_list+0x14/0x20
 [<c0142ba5>] do_munmap+0x115/0x128
 [<c0141f91>] do_mmap_pgoff+0x2b9/0x60c
 [<c010cb74>] old_mmap+0x108/0x144
 [<c025c753>] syscall_call+0x7/0xb

That's remove_shared_vm_struct again, but called from unmap_vma this time

Call Trace:
 [<c0105aee>] __down+0x96/0x10c
 [<c0118fb8>] default_wake_function+0x0/0x1c
 [<c0105cb8>] __down_failed+0x8/0xc
 [<c011c494>] .text.lock.fork+0x79/0x125
 [<c011be5c>] copy_process+0x61c/0xa6c
 [<c011c322>] do_fork+0x76/0x16f
 [<c0105619>] sys_clone+0x29/0x30
 [<c025c753>] syscall_call+0x7/0xb

That's dup_mmap taking i_shared_sem here:

                        /* insert tmp into the share list, just after mpnt */
                        down(&file->f_mapping->i_shared_sem);
                        __vma_prio_tree_add(tmp, mpnt);
                        up(&file->f_mapping->i_shared_sem);

