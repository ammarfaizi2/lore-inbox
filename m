Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVKNXvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVKNXvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVKNXvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:51:32 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:28125 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932249AbVKNXvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:51:31 -0500
Subject: 2.6.14 X spinning in the kernel
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, hugh@veritas.com
Content-Type: text/plain
Date: Mon, 14 Nov 2005 15:51:21 -0800
Message-Id: <1132012281.24066.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My 2-cpu EM64T machine started showing this problem again on 2.6.14.
On some reboots, X seems to spin in the kernel forever.

sysrq-t output shows nothing.

X             R  running task       0  3607   3589          3903
(L-TLB)

top shows:
 3607 root      25   0     0    0    0 R 99.1  0.0 262:04.69 X


So, I wrote a module to do smp_call_function() on all CPUs
to show stacks on them. CPU0 seems to be spinning in exit_mmap().
I did this multiple times to collect stacks few times.

Is this a known issue ?

Thanks,
Badari

1st time:
---------
CPU1:

Call Trace:<ffffffff880ed02b>{:mod:showacpu+43}
<ffffffff880ed04b>{:mod:init_mod+11}
       <ffffffff80154162>{sys_init_module+306}
<ffffffff8010dc26>{system_call+126}

CPU0:

Call Trace: <IRQ> <ffffffff880ed02b>{:mod:showacpu+43}
<ffffffff80119399>{smp_call_function_interrupt+73}
       <ffffffff8010e8f0>{call_function_interrupt+132}  <EOI>
<ffffffff8016eb1a>{unmap_vmas+1114}
       <ffffffff8016ec1c>{unmap_vmas+1372} <ffffffff801749f6>{exit_mmap
+166}
       <ffffffff80134014>{mmput+52} <ffffffff8018f2ca>{flush_old_exec
+2474}
       <ffffffff801833d5>{vfs_read+341}
<ffffffff801b4933>{load_elf_binary+1507}
       <ffffffff80162131>{buffered_rmqueue+529}
<ffffffff8017c99b>{alloc_page_interleave+59}
       <ffffffff8018e284>{copy_strings+516}
<ffffffff801b4350>{load_elf_binary+0}
       <ffffffff8018f8f9>{search_binary_handler+201}
<ffffffff8018fc5f>{do_execve+415}
       <ffffffff8010dc26>{system_call+126} <ffffffff8010c6e4>{sys_execve
+68}
       <ffffffff8010e046>{stub_execve+106}


2nd time:
----------

CPU1:

Call Trace:<ffffffff880ed02b>{:mod:showacpu+43}
<ffffffff880ed04b>{:mod:init_mod+11}
       <ffffffff80154162>{sys_init_module+306}
<ffffffff8010dc26>{system_call+126}

CPU0:

Call Trace: <IRQ> <ffffffff880ed02b>{:mod:showacpu+43}
<ffffffff80119399>{smp_call_function_interrupt+73}
       <ffffffff8010e8f0>{call_function_interrupt+132}  <EOI>
<ffffffff8017245f>{remove_vm_struct+63}
       <ffffffff80172453>{remove_vm_struct+51}
<ffffffff80174ac7>{exit_mmap+375}
       <ffffffff80134014>{mmput+52} <ffffffff8018f2ca>{flush_old_exec
+2474}
       <ffffffff801833d5>{vfs_read+341}
<ffffffff801b4933>{load_elf_binary+1507}
       <ffffffff80162131>{buffered_rmqueue+529}
<ffffffff8017c99b>{alloc_page_interleave+59}
       <ffffffff8018e284>{copy_strings+516}
<ffffffff801b4350>{load_elf_binary+0}
       <ffffffff8018f8f9>{search_binary_handler+201}
<ffffffff8018fc5f>{do_execve+415}
       <ffffffff8010dc26>{system_call+126} <ffffffff8010c6e4>{sys_execve
+68}
       <ffffffff8010e046>{stub_execve+106}


3rd time:
---------
CPU1:

Call Trace:<ffffffff880ed02b>{:mod:showacpu+43}
<ffffffff880ed04b>{:mod:init_mod+11}
       <ffffffff80154162>{sys_init_module+306}
<ffffffff8010dc26>{system_call+126}

CPU0:

Call Trace: <IRQ> <ffffffff880ed02b>{:mod:showacpu+43}
<ffffffff80119399>{smp_call_function_interrupt+73}
       <ffffffff8010e8f0>{call_function_interrupt+132}  <EOI>
<ffffffff801618b4>{__mod_page_state+36}
       <ffffffff80161e09>{free_hot_cold_page+41}
<ffffffff80161ef5>{__pagevec_free+37}
       <ffffffff801699df>{release_pages+367}
<ffffffff80178c0b>{free_pages_and_swap_cache+123}
       <ffffffff80174a62>{exit_mmap+274} <ffffffff80134014>{mmput+52}
       <ffffffff8018f2ca>{flush_old_exec+2474}
<ffffffff801833d5>{vfs_read+341}
       <ffffffff801b4933>{load_elf_binary+1507}
<ffffffff80162131>{buffered_rmqueue+529}
       <ffffffff8017c99b>{alloc_page_interleave+59}
<ffffffff8018e284>{copy_strings+516}
       <ffffffff801b4350>{load_elf_binary+0}
<ffffffff8018f8f9>{search_binary_handler+201}
       <ffffffff8018fc5f>{do_execve+415} <ffffffff8010dc26>{system_call
+126}
       <ffffffff8010c6e4>{sys_execve+68} <ffffffff8010e046>{stub_execve
+106}




