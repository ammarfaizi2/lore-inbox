Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVCaTVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVCaTVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVCaTVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:21:05 -0500
Received: from ns2.suse.de ([195.135.220.15]:51140 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261647AbVCaTUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:20:54 -0500
Date: Thu, 31 Mar 2005 21:20:53 +0200
From: Andi Kleen <ak@suse.de>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Ian.Pratt@cl.cam.ac.uk
Subject: Re: Incorrect comment in leave_mm()?
Message-ID: <20050331192053.GD22855@wotan.suse.de>
References: <E1DH2JS-00021o-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DH2JS-00021o-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 05:14:30PM +0100, Keir Fraser wrote:
> 
> Hi,
> 
> I have a question regarding the per-cpu tlbstate logic that is used to
> lazily switch to the swapper_pgdir when running a process with no
> mm_struct of its own.
> 
> There is a comment in arch/i386/kernel/smp.c:leave_mm() that
> states 'We need to reload %cr3 since the page tables may be going away
> from under us'. AFAICT this is not true -- the currently-running task
> holds a reference on the active_mm until it is context-switched off
> the CPU, at which point the reference is dropped in
> sched.c:finish_task_switch(). Until that point the pgd cannot be
> freed and so kernel mappings should remain valid to use. 

The PTE pages get freed earlier.  On x86-64 also PMD/PGD. 
The code is needed to prevent a CPU from ever seeing any partially 
freed page tables. After the flush IPI happened the PTE pages
get freed, and if you dont reload to init_mm the CPU has
already freed page tables in its TLB.

Modern x86 do an awful lot of prefetching behind your back, doing
MMU lookup on adresses you never touched etc. and you have to 
be extremly careful to only ever have fully valid page tables
in CR3 all the time.

I had this code disabled on x86-64, but I have several open bugs 
because of this I thin (there were some other bugs in this logic too 
which I only recently fixed, but they were all 64bit specific). 

I can only advise against touching this! It is very easy to break
and very subtle.


> Although the corresponding function in arch/x86_64 doesn't include
> this comment, Andi Kleen recently modified it to switch to the
> swapper_pg_dir, instead of doing a simple __flush_tlb. Does this mean 
> that I am missing something, and the comment in arch/i386 is in fact
> correct? 

It is correct.

-Andi
