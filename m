Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbULGSL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbULGSL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbULGSL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:11:29 -0500
Received: from mail.nextweb.net ([216.237.6.33]:27410 "EHLO mail.nextweb.net")
	by vger.kernel.org with ESMTP id S261817AbULGSLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:11:19 -0500
Subject: PROBLEM: unchecked returns from kmalloc() in linux-2.6.10-rc2
From: Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>
Reply-To: katrina@fortifysoftware.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Fortify Software
Message-Id: <1102443607.3748.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 07 Dec 2004 10:20:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux developers,
                                                                                                                                                             
We -- Fortify Software engineering team -- have looked at
linux-2.6.10-rc2 and performed static analysis of the code. 
We have discovered several instances of the same potential 
vulnerability in the kernel code. Because these issues have 
been discovered at compile time rather than run time, our
bug report does not follow the format proposed here
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
completely.
Below we provide a more detailed description of the issues.
                                                                                                                                                             
[1.] We have found several instances of unchecked return values from
kmalloc().
[2.] Checking whether memory allocation succeeded is important,
especially in the kernel code. Failure might cause a kernel crash. 
We have noticed the same problem in 3 different places. Considering the
fact that in other cases, the return from kmalloc() is validated before
being use, these are definite bugs.
                                                                                                                                                             
1) kernel/module.c:
                                                                                                                                                             
...
331: static int percpu_modinit(void)
332: {
333:         pcpu_num_used = 2;
334:         pcpu_num_allocated = 2;
335:         pcpu_size = kmalloc(sizeof(pcpu_size[0]) *
pcpu_num_allocated,
336:                             GFP_KERNEL);
337:         /* Static in-kernel percpu data (used). */
338:         pcpu_size[0] = -ALIGN(__per_cpu_end-__per_cpu_start,
SMP_CACHE_BYTES);
339:         /* Free room. */
340:         pcpu_size[1] = PERCPU_ENOUGH_ROOM + pcpu_size[0];
341:         if (pcpu_size[1] < 0) {
342:                 printk(KERN_ERR "No per-cpu room for modules.\n");
343:                 pcpu_num_used = 1;
344:         }
345: 
346:         return 0;
347: }
...
                                                                                                                                                             
Here, memory is allocated for pcpu_size on line 335, and then
pcpu_size[0] is accessed on line 338 without prior validation of memory
allocation.
                                                                                                                                                             
Note that in the same file -- kernel/module.c -- there are several other
uses of kmalloc() -- lines 221, 419, 779, 974, 1055, 1546 -- where
appropriate checks are made, and appropriate actions are taken in case
of failure, e.g. an error code is returned.
                                                                                                                                                             
2,3) mm/slab.c:
                                                                                                                                                             
...
802:         /* 4) Replace the bootstrap head arrays */
803:         {
804:                 void * ptr;
805:
806:                 ptr = kmalloc(sizeof(struct arraycache_init),
GFP_KERNEL);
807:                 local_irq_disable();
808:                 BUG_ON(ac_data(&cache_cache) !=
&initarray_cache.cache);
809:                 memcpy(ptr, ac_data(&cache_cache), sizeof(struct
arraycache_init));
810:                 cache_cache.array[smp_processor_id()] = ptr;
811:                 local_irq_enable();
812:
813:                 ptr = kmalloc(sizeof(struct arraycache_init),
GFP_KERNEL);
814:                 local_irq_disable();
815:                 BUG_ON(ac_data(malloc_sizes[0].cs_cachep) !=
&initarray_generic.cache);
816:                 memcpy(ptr, ac_data(malloc_sizes[0].cs_cachep),
817:                                 sizeof(struct arraycache_init));
818:                
malloc_sizes[0].cs_cachep->array[smp_processor_id()] = ptr;
819:                 local_irq_enable();
820:         }
...
                                                                                                                                                             
Here, memory is allocated for ptr on lines 806 and 813, and then ptr is
used in memcpy() on lines 809 and 816, respectively, without prior
validation of memory allocation.
                                                                                                                                                             
Note that in the same file -- mm/slab.c -- there are several other uses
of kmalloc() -- lines 653, 2461, 2526 -- where appropriate checks are
made, and appropriate actions are taken in case of failure, e.g. NULL is
returned.
                                                                                                                                                             
[3.] Fixing the above issues should be trivial and quick. One just needs
to perform success / failure checks on the return from kmalloc() and
take appropriate actions depending on the situation: return an error
code, return NULL, panic, etc. One could even refer to other occurrences
of kmalloc() to see what actions should be taken in various cases. Some
line numbers are provided above.
                                                                                                                                                             
                                                                                                                                                             
                Sincerely,
                                                                                                                                                             
                        Fortify Software Team

