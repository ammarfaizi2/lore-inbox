Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbULQWaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbULQWaC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbULQWaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:30:02 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:34442 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262182AbULQW34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:29:56 -0500
Message-ID: <41C35DD6.1050804@colorfullife.com>
Date: Fri, 17 Dec 2004 23:29:42 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reimplementation of linux dynamic percpu memory allocator
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kiran,

>+ * 
>+ * Originally by Dipankar Sarma and Ravikiran Thirumalai,
>+ * This reimplements alloc_percpu to make it 
>+ * 1. Independent of slab/kmalloc
>  
>
Probably the right approach. slab should use per-cpu for it's internal 
head arrays, but I've never converted the slab code due to 
chicken-and-egg problems and due to the additional pointer dereference.

>+ * Allocator is slow -- expected to be called during module/subsytem
>+ * init. alloc_percpu can block.
>  
>
How slow is slow?
I think the block subsystem uses alloc_percpu for some statistics 
counters, i.e. one alloc during creation of a new disk. The slab 
implementation was really slow and that caused problems with LVM (or 
something like that) stress tests.

>+	/* Map pages for each cpu by splitting vm_struct for each cpu */
>+	for (i = 0; i < NR_CPUS; i++) {
>+		if (cpu_possible(i)) {
>+			tmppage = &blkp->pages[i*cpu_pages];
>+			tmp.addr = area->addr + i * PCPU_BLKSIZE;
>+			/* map_vm_area assumes a guard page of size PAGE_SIZE */
>+			tmp.size = PCPU_BLKSIZE + PAGE_SIZE; 
>+			if (map_vm_area(&tmp, PAGE_KERNEL, &tmppage))
>+				goto fail_map;
>  
>
That means no large pte entries for the per-cpu allocations, right?
I think that's a bad idea for non-numa systems. What about a fallback to 
simple getfreepages() for non-numa systems?

>+ * This allocator is slow as we assume allocs to come
>+ * by during boot/module init.
>+ * Should not be called from interrupt context 
>  
>
"Must not" - it contains down() and thus can sleep.

--
    Manfred


