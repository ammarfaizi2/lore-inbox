Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269587AbUJFWgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269587AbUJFWgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUJFWeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:34:13 -0400
Received: from gprs214-192.eurotel.cz ([160.218.214.192]:14464 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269589AbUJFWcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:32:21 -0400
Date: Thu, 7 Oct 2004 00:32:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] S3 suspend/resume with noexec
Message-ID: <20041006223203.GE2630@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60030A4229@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60030A4229@scsmsx403.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> @@ -62,6 +62,10 @@ void __save_processor_state(struct saved
> >>  	asm volatile ("movl %%cr0, %0" : "=r" (ctxt->cr0));
> >>  	asm volatile ("movl %%cr2, %0" : "=r" (ctxt->cr2));
> >>  	asm volatile ("movl %%cr3, %0" : "=r" (ctxt->cr3));
> >> +#ifdef CONFIG_X86_PAE
> >> +	if (cpu_has_pae && cpu_has_nx)
> >> +		rdmsr(MSR_EFER, ctxt->efer_lo, ctxt->efer_hi);
> >> +#endif
> >>  	asm volatile ("movl %%cr4, %0" : "=r" (ctxt->cr4));
> >>  }
> >
> >Are those #ifdefs good idea?
> 
> That CONFIG is required. Cpu_has_pae and cpu_has_nx doesn't 
> imply that we are using nx. Only when PAE kernel is configured 
> and these features are available, we use it.
> 
> Looking at the code again, I can remove that CONFIG_X86_PAE,
> if I use an additional check for nx_enabled.

Yes, that would be better.

> >> @@ -59,6 +59,20 @@ wakeup_code:
> >>  	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
> >>  	movl	%eax, %cr3
> >>  
> >> +	testl	$1, real_efer_save_restore - wakeup_code
> >> +	jz	4f
> >> +	# restore efer setting
> >> +	pushl    %eax
> >> +	pushl    %ecx
> >> +	pushl    %edx
> >> +	movl	real_save_efer_edx - wakeup_code, %edx
> >> +	movl	real_save_efer_eax - wakeup_code, %eax
> >> +	mov     $0xc0000080, %ecx
> >> +	wrmsr
> >> +	popl    %edx
> >> +	popl    %ecx
> >> +	popl    %eax
> >> +4:
> >>  	# make sure %cr4 is set correctly (features, etc)
> >>  	movl	real_save_cr4 - wakeup_code, %eax
> >>  	movl	%eax, %cr4
> >
> >Please analyse surrounding code a bit more. You certainly do not need
> >to push %eax, because it is scratch register.
> 
> Yes. I saw that eax was not used. But, I thought it is clean to save 
> and restore every register that is being touched here. Just in case some
> 
> other code around these place starts using those registers in future.
> 
> If you think that is unnecessary, I will resend the patch with minimal 
> push/pops.

I'd like minimal push/pops. If we pushed/poped at every possible
place, it would get too long and too unreadable too quickly.

> >Is it neccessary to restore efer this soon, btw? We should be running
> >from swapper_pg_dir. Does that use nx?
> 
> It seems necessary for swapper_pg_dir too as we use nx even for kernel
> pages (stack, module, etc).

Ahha, ok.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
