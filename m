Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTEWT23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbTEWT23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 15:28:29 -0400
Received: from ns.suse.de ([213.95.15.193]:62476 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264152AbTEWT21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 15:28:27 -0400
Date: Fri, 23 May 2003 21:41:31 +0200
From: Andi Kleen <ak@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       rmk@arm.linux.org.uk, davidm@napali.hpl.hp.com, akpm@digeo.com
Subject: Re: /proc/kcore - how to fix it
Message-Id: <20030523214131.588b0645.ak@suse.de>
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B00E04@fmsmsx404.fm.intel.com>
References: <DD755978BA8283409FB0087C39132BD101B00E04@fmsmsx404.fm.intel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003 12:13:04 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:


> Here's how it works.  The default code in fs/proc/kcore.c doesn't
> set up any "elf_phdr" sections ... it is left to each architecture
> to make appropriate calls to "kclist_add()" to specify a base
> address and size for each piece of kernel virtual address space
> that needs to be made accessible through /proc/kcore.  To get the
> old functionality, you'll need two calls that look something like:
> 
>  kclist_add(&kcore_mem, __va(0),
>              max_low_pfn * PAGE_SIZE);
>  kclist_add(&kcore_vmem, (void *)VMALLOC_START,
>              VMALLOC_END-VMALLOC_START);

Looks good to me.

/dev/mem / dev/kmem has the same problem, it could use that too.

> 
> The first makes all of memory visible (__i386__, __mc68000__ and
> __x86_64__ should use __va(PAGE_SIZE) to duplicate the original
> lack of access to page 0).  The second provides a single map for
> all "vmalloc" space (the code still searches the vmlist to see
> what actually exists before accessing it).
> 
> Other blocks of kernel virtual space can be added as needed, and
> removed again (with kclist_del()).  E.g. discontiguous memory

Remove could get racy - /proc/kcore can sleep while accessing such
a block. You would need a sleeping lock hold all the time.

What would you need remove for?

> The second piece of abstraction is the kc_vaddr_to_offset() and
> kc_offset_to_vaddr() macros.  These provide mappings from kernel
> virtual addresses to offsets in the virtual file that /proc/kcore
> instantiates.  I hope they are sufficient to avoid negative offset
> problems that plagued the old /proc/kcore.  Default versions are
> provided for the old behaviour (mapping simply adds/subtracts
> PAGE_OFFSET).  For ia64 I just need to use a different offset
> as all kernel virtual allocations are in the high 37.5% of the
> 64-bit virtual address space.

I'm not sure it is a good idea from the interface standpoint, especially
for /dev/kmem.  It would surely be confusing for the user. Yes, a few applications and even some kernel code has signedness problems, but I would
better fix them instead of adding such a weird interface. 1:1 mapping would 
be a lot cleaner. It should not be that bad because on i386 the kernel
is also in negative space.

[i still have some 2.4 patches to fix a few 64bit signedness problems in /proc,
perhaps I should dust them off and port to 2.5]


> But if you have interesting stuff scattered across *every* part of
> the unsigned address range, then you won't be able to squeeze it all
> into a signed file offset.

The memory map on x86-64 is rather clean, that's no problem

Thanks for doing this work,
-Andi
