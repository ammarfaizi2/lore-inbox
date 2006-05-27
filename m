Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWE0PSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWE0PSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWE0PSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 11:18:21 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:55216 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751553AbWE0PSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 11:18:21 -0400
Message-ID: <44786EBB.50300@cs.wisc.edu>
Date: Sat, 27 May 2006 10:22:35 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: James Lamanna <jlamanna@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [OOPS] amrestore dies in kmem_cache_free 2.6.16.18 -  cannot
 restore backups!
References: <200605260029_MC3-1-C0CF-C67C@compuserve.com>
In-Reply-To: <200605260029_MC3-1-C0CF-C67C@compuserve.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <aa4c40ff0605231824j55c998c3oe427dec2404afba0@mail.gmail.com>
> 
> On Tue, 23 May 2006 18:24:14 -0700, James Lamanna wrote:
> 
>> So I was able to recreate this problem on a vanilla 2.6.16.18 with the
>> following oops..
>> I'd say this is a serious regression since I cannot restore backups
>> anymore (I could with 2.6.14.x, but that kernel series had other
>> issues...)
> 
>> Unable to handle kernel paging request at ffff82bc81000030 RIP: <ffffffff801657d9>{kmem_cache_free+82}
>> PGD 0
>> Oops: 0000 [1] SMP
>> CPU 1
>> Modules linked in:
>> Pid: 5814, comm: amrestore Not tainted 2.6.16.18 #2
>> RIP: 0010:[<ffffffff801657d9>] <ffffffff801657d9>{kmem_cache_free+82}
>> RSP: 0018:ffff81007d4afcd8  EFLAGS: 00010086
>> RAX: ffff82bc81000000 RBX: ffff81004119d800 RCX: 000000000000001e
>> RDX: ffff81000000c000 RSI: 0000000000000000 RDI: 00000007f0000000
>> RBP: ffff81007ff0c800 R08: 0000000000000000 R09: 0000000000000400
>> R10: 0000000000000000 R11: ffffffff8014b3d6 R12: ffff810041311480
>> R13: 0000000000000400 R14: 0000000000000400 R15: ffff81007e676748
>> FS:  00002b7f39708020(0000) GS:ffff810041173bc0(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> CR2: ffff82bc81000030 CR3: 000000007de09000 CR4: 00000000000006e0
>> Process amrestore (pid: 5814, threadinfo ffff81007d4ae000, task ffff81007e2f8ae0)
>> Stack: 0000000000000000 0000000000000246 ffff8100413c9bc0 ffff81007ff0c800
>>        ffff8100413c9bc0 ffffffff8016dfdc ffff8100413c9bc0 ffff81007fe25408
>>        00000000ffffffea ffffffff803187e7
>> Call Trace: <ffffffff8016dfdc>{bio_free+48} <ffffffff803187e7>{scsi_execute_async+640}
>>        <ffffffff8035d8d2>{st_do_scsi+422} <ffffffff8035d6e2>{st_sleep_done+0}
>>        <ffffffff80362950>{st_read+855} <ffffffff8013e1ca>{autoremove_wake_function+0}
>>        <ffffffff80169d7c>{vfs_read+171} <ffffffff8016a0af>{sys_read+69}
>>        <ffffffff8010a93e>{system_call+126}
>>
>> Code: 48 8b 48 30 0f b7 51 28 65 8b 04 25 30 00 00 00 39 c2 0f 84
>> RIP <ffffffff801657d9>{kmem_cache_free+82} RSP <ffff81007d4afcd8>
>> CR2: ffff82bc81000030
> 
> First of all, to really see what is happening you need to recompile your kernel
> after adding some debug options:
> 
> Kernel Hacking --->
>    [*] Kernel debugging
>    [*]   Debug memory allocations
>    [*]   Compile the kernel with frame pointers
> 
> (Frame pointers won't give an exact trace but they'll prevent the tail merging
> that makes it so hard to follow.)
> 
> Then reproduce the error and send the oops and any new error messages you see.
> Don't send the whole boot log and .config again -- we have them already.
> 
> The bug is happening here, in __cache_free, in code that's only included
> on NUMA machines:
> 
> static inline void __cache_free(struct kmem_cache *cachep, void *objp)
> {
>         struct array_cache *ac = cpu_cache_get(cachep);
> 
>         check_irq_off();
>         objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
> 
>         /* Make sure we are not freeing a object from another
>          * node to the array cache on this cpu.
>          */
> #ifdef CONFIG_NUMA
>         {
>                 struct slab *slabp;
>                 slabp = virt_to_slab(objp);                      <==== OOPS
>                 if (unlikely(slabp->nodeid != numa_node_id())) {
>                         struct array_cache *alien = NULL;
>                         int nodeid = slabp->nodeid;
> 
> 
> Tracing through the nested inline functions, we have:
> 
> static inline struct slab *virt_to_slab(const void *obj)
> {
>         struct page *page = virt_to_page(obj);
>         return page_get_slab(page);                              <==== OOPS
> }
> 
> static inline struct slab *page_get_slab(struct page *page)
> {
>         return (struct slab *)page->lru.prev;                    <==== OOPS
> }
> 
> 
> virt_to_page() returned a struct page * that pointed to unmapped memory.
> 
> 
> This all came from scsi_execute_async, possibly through this path:
> 
> scsi_execute_async
>     scsi_rq_map_sg: some kind of error occurred?
>         bio_endio
>             bio->bi_end_io ==> scsi_bi_end_io
>                 bio_put
>                     bio->bi_destructor ==> bio_fs_destructor
>                         bio_free
>                             mempool_free
>                                 kmem_cache_free
> 
> scsi_execute_async and scsi_rq_map_sg were rewritten last December, so may have
> new bugs.
> 
> 

Sorry for the late reply. I have been traveling.

Maybe I messed up on the bounce code usage. Are you using st's direct IO
feature?
