Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUJDTf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUJDTf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268568AbUJDTcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:32:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:5053 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268486AbUJDTUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:20:24 -0400
Date: Mon, 4 Oct 2004 12:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004121805.2bffcd99.akpm@osdl.org>
In-Reply-To: <4161462A.5040806@gts.it>
References: <20041004020207.4f168876.akpm@osdl.org>
	<4161462A.5040806@gts.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/
> > 
> > 
> > - Hopefully those x86 compile errors are fixed up.
> > 
> > - Various fairly minor updates
> 
> (#ifdef around is_irq_stack_ptr already applied)
> 
> Kernel BUGs at boot time, here is what I see (copied by hand, I hope 
> Stack and Code hex values are not that important :)):
> 
> [...]
> IP: routing cache hash table of 4096 buckets, 32KBytes
> kmem_cache_create: Early error in slab ip_fib_hash
> -----[ cut here ] -----
> kernel BUG at mm/slab.c:1185!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in:
> CPU:	0
> EIP:	0060:[<c01348f6>]	Not tainted VLI
> EFLAGS: 00010282 (2.6.9-rc3-mm2)
> EIP is at kmem_cache_create+0x51d/0x53e
> eax: 00000036  ebx: 00000000  ecx: c02b7f04  edx: 00001d9f
> esi: 00000000  edi: 000000ff  ebp: c15fe3c0  esp: dff83f30
> ds: 007b    es: 007b    ss: 0068
> Process swapper: (pid: 1, threadinfo=dff82000 task=dff815f0)
> Stack: (stripped, hope you don't need this :)
> Call trace:
>   [<>] fib_hash_init+0xd8/0xe2
>   [<>] ip_fib_init+0xa/0x32
>   [<>] ip_rt_init+0x1cc/0x2e3
>   [<>] ip_init+0xf/0x14
>   [<>] inet_init+0xd0/0x1b3
>   [<>] do_initcalls+0x27/0xad
>   [<>] init+0x0/0xf8
>   [<>] init+0x0/0xf8
>   [<>] init+0x2a/0xf8
>   [<>] kernel_thread_helper+0x0/0xb
>   [<>] kernel_thread_helper+0x5/0xb

That's odd.  I'd be suspecting that in_interrupt() is falsely returning true.

Can you try this patch, see what it says?

And can you send the .config along?


diff -puN mm/slab.c~a mm/slab.c
--- 25/mm/slab.c~a	2004-10-04 12:16:00.808822288 -0700
+++ 25-akpm/mm/slab.c	2004-10-04 12:17:25.822898184 -0700
@@ -1180,6 +1180,9 @@ kmem_cache_create (const char *name, siz
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
 		(dtor && !ctor)) {
+			printk("in_interrupt(): %ld\n", in_interrupt());
+			printk("preempt_count(): %x\n", preempt_count());
+			printk("size: %zd\n", size);
 			printk(KERN_ERR "%s: Early error in slab %s\n",
 					__FUNCTION__, name);
 			BUG();
_

