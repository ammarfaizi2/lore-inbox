Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVAYQrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVAYQrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVAYQrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:47:36 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:63388 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262009AbVAYQre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:47:34 -0500
Date: Tue, 25 Jan 2005 08:46:42 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       spyro@f2s.com
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
Message-ID: <20050125164642.GA17927@taniwha.stupidest.org>
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 01:22:10AM +1100, Anton Blanchard wrote:

> The 4 level pagetable code changed the exit_mmap code to rely on
> TASK_SIZE. On some architectures (eg ppc64 and ia64), this is a per
> task property and bad things can happen in certain circumstances
> when using it.

I don't really like it in general when we do

#define MAYBE_CONST_LOOKING_THING      (some_func())

I would almost rather see something like task_size(current) used.

> MM_VM_SIZE() was created for this purpose (and is used in the next
> line for tlb_finish_mmu), so use it. I moved the PGD round up of
> TASK_SIZE into the default MM_VM_SIZE.



> ===== include/linux/mm.h 1.212 vs edited =====
> +++ edited/include/linux/mm.h	2005-01-26 01:20:12 +11:00
> @@ -38,7 +38,7 @@
>  #include <asm/atomic.h>
>  
>  #ifndef MM_VM_SIZE
> -#define MM_VM_SIZE(mm)	TASK_SIZE
> +#define MM_VM_SIZE(mm)	((TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK)
>  #endif
>  
>  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
ia64 asm/processor.h already has:

#define DEFAULT_TASK_SIZE       __IA64_UL_CONST(0xa000000000000000)
[...]
#define MM_VM_SIZE(mm)          DEFAULT_TASK_SIZE

So I think this will generate a warning there?
