Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVCOLDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVCOLDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVCOLDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:03:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58839 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261729AbVCOLDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:03:34 -0500
Date: Tue, 15 Mar 2005 12:03:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, rjw@sisk.pl
Subject: Re: swsusp_restore crap
Message-ID: <20050315110309.GA1344@elf.ucw.cz>
References: <1110857069.29123.5.camel@gaston> <1110857516.29138.9.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1110857516.29138.9.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 15-03-05 14:31:56, Benjamin Herrenschmidt wrote:
> On Tue, 2005-03-15 at 14:24 +1100, Benjamin Herrenschmidt wrote:
> > Hi Pavel !
> > 
> > Please kill that swsusp_restore() call that itself calls
> > flush_tlb_global(), it's junk. First, the flush_tlb_global() thing is
> > arch specific, and that's all swsusp_restore() does. Then, the asm just
> > calls this before returning to C code, so it makes no sense to have a
> > hook there. The x86 asm can have it's own call to some arch stuff if it
> > wants or just do the tlb flush in asm...
> 
> Better, here is a patch... (note: flush_tlb_global() is an x86'ism,
> doesn't exist on ppc, thus breaks compile, and that has nothing to do in
> the generic code imho, it should be clearly defined as the
> responsibility of the asm code).

x86-64 needs this, too.... Otherwise it looks okay.



> --
> 
> This patch removes the quite x86-specific swsusp_restore() hook from the
> generic swsusp code and moves it to arch/i386. This also fixes build on
> ppc with swsusp enabled.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Index: linux-work/arch/i386/power/swsusp.S
> ===================================================================
> --- linux-work.orig/arch/i386/power/swsusp.S	2005-03-15 11:56:17.000000000 +1100
> +++ linux-work/arch/i386/power/swsusp.S	2005-03-15 14:29:09.000000000 +1100
> @@ -58,5 +58,5 @@
>  	movl saved_context_edi, %edi
>  
>  	pushl saved_context_eflags ; popfl
> -	call swsusp_restore
> +	call __swsusp_flush_tlb
>  	ret
> Index: linux-work/arch/i386/power/cpu.c
> ===================================================================
> --- linux-work.orig/arch/i386/power/cpu.c	2005-03-15 11:56:17.000000000 +1100
> +++ linux-work/arch/i386/power/cpu.c	2005-03-15 14:28:26.000000000 +1100
> @@ -147,6 +147,15 @@
>  	__restore_processor_state(&saved_context);
>  }
>  
> +asmlinkage int __swsusp_flush_tlb(void)
> +{
> +	BUG_ON (nr_copy_pages_check != nr_copy_pages);
> +	
> +	/* Even mappings of "global" things (vmalloc) need to be fixed */
> +	__flush_tlb_global();
> +	return 0;
> +}
> +
>  /* Needed by apm.c */
>  EXPORT_SYMBOL(save_processor_state);
>  EXPORT_SYMBOL(restore_processor_state);
> Index: linux-work/kernel/power/swsusp.c
> ===================================================================
> --- linux-work.orig/kernel/power/swsusp.c	2005-03-15 12:00:13.000000000 +1100
> +++ linux-work/kernel/power/swsusp.c	2005-03-15 14:29:19.000000000 +1100
> @@ -907,15 +907,6 @@
>  }
>  
>  
> -asmlinkage int swsusp_restore(void)
> -{
> -	BUG_ON (nr_copy_pages_check != nr_copy_pages);
> -	
> -	/* Even mappings of "global" things (vmalloc) need to be fixed */
> -	__flush_tlb_global();
> -	return 0;
> -}
> -
>  int swsusp_resume(void)
>  {
>  	int error;
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
