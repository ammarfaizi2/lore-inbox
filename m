Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753553AbWKRAMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbWKRAMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756070AbWKRAMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:12:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60328 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756075AbWKRALz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:11:55 -0500
Date: Sat, 18 Nov 2006 01:11:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 8/20] x86_64: Add EFER to the set registers saved by save_processor_state
Message-ID: <20061118001129.GA9188@elf.ucw.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117224411.GI15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117224411.GI15449@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> EFER varies like %cr4 depending on the cpu capabilities, and which cpu
> capabilities we want to make use of.  So save/restore it make certain
> we have the same EFER value when we are done.

I still think that comment is right: EFER is function(cpu
capabilities, kernel version, kernel cmdline); and that _should_ be
constant accross suspend.

Anyway saving it does not hurt and code is probably easier to
understand.

ACK.
								Pavel


>  	/* XMM0..XMM15 should be handled by kernel_fpu_begin(). */
> -	/* EFER should be constant for kernel version, no need to handle it. */
>  	/*
>  	 * segment registers
>  	 */
> @@ -50,6 +49,7 @@ void __save_processor_state(struct saved
>  	/*
>  	 * control registers 
>  	 */
> +	rdmsrl(MSR_EFER, ctxt->efer);
>  	asm volatile ("movq %%cr0, %0" : "=r" (ctxt->cr0));
>  	asm volatile ("movq %%cr2, %0" : "=r" (ctxt->cr2));
>  	asm volatile ("movq %%cr3, %0" : "=r" (ctxt->cr3));
> @@ -75,6 +75,7 @@ void __restore_processor_state(struct sa
>  	/*
>  	 * control registers
>  	 */
> +	wrmsrl(MSR_EFER, ctxt->efer);
>  	asm volatile ("movq %0, %%cr8" :: "r" (ctxt->cr8));
>  	asm volatile ("movq %0, %%cr4" :: "r" (ctxt->cr4));
>  	asm volatile ("movq %0, %%cr3" :: "r" (ctxt->cr3));
> --- linux-2.6.19-rc6-reloc/include/asm-x86_64/suspend.h~x86_64-Add-EFER-to-the-set-registers-saved-by-save_processor_state	2006-11-17 00:08:16.000000000 -0500
> @@ -17,6 +17,7 @@ struct saved_context {
>    	u16 ds, es, fs, gs, ss;
>  	unsigned long gs_base, gs_kernel_base, fs_base;
>  	unsigned long cr0, cr2, cr3, cr4, cr8;
> +	unsigned long efer;
>  	u16 gdt_pad;
>  	u16 gdt_limit;
>  	unsigned long gdt_base;
> _

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
