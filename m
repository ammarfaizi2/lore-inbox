Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753152AbVHHAlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbVHHAlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbVHHAlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:41:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9862 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753152AbVHHAlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:41:44 -0400
Subject: Re: [PATCH] abstract out bits of ldt.c
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <372830000.1123456808@[10.10.2.4]>
References: <372830000.1123456808@[10.10.2.4]>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 01:41:36 -0700
Message-Id: <1123490496.10337.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 16:20 -0700, Martin J. Bligh wrote: 
> Starting on the work to merge xen cleanly as a subarch.
> Introduce make_pages_readonly and make_pages_writable where appropriate 
> for Xen, defined as a no-op on other subarches. Same for 
> add_context_to_unpinned and del_context_from_unpinned.
> Abstract out install_ldt_entry()
... 
>  		cpumask_t mask;
>  		preempt_disable();
> +		make_pages_readonly(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / 
> +								PAGE_SIZE);
>  		load_LDT(pc);
>  		mask = cpumask_of_cpu(smp_processor_id());
>  		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
>  			smp_call_function(flush_ldt, NULL, 1, 1);
>  		preempt_enable();
>  #else
> +		make_pages_readonly(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / 
> +								PAGE_SIZE);

You do that (size * LDT_ENTRY_SIZE / PAGE_SIZE) operation an awfully
large number of times.  Could you consider introducing a little helper,
say ldt_size_pages()?  

Or, could you have a helper like make_ldt_readonly()?  You don't have to
export it, just use it in that one file.

> This will do have no effect whatsover on platforms other than xen.
...
> +       memset(&mm->context, 0, sizeof(mm->context));
>         init_MUTEX(&mm->context.sem);
> -       mm->context.size = 0;

Could you please explain what this is for?  It doesn't appear to be part
of the abstraction.  

Every call path I can see to init_new_context() is immediately preceded
by mm_alloc(), which memsets the entire mm.  The context is a direct
member of mm_struct, and should be zeroed along with the mm_alloc()
memset.  So, this seems a bit superfluous.

In any future patches that you might post, please do one thing per
patch, it makes them much easier to audit.

-- Dave

