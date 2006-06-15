Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWFOJU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWFOJU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFOJU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:20:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39911 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932466AbWFOJUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:20:25 -0400
Date: Thu, 15 Jun 2006 11:19:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] move do_suspend_lowlevel to correct segment
Message-ID: <20060615091934.GG9423@elf.ucw.cz>
References: <1150342766.21189.14.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150342766.21189.14.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Move do_suspend_lowlevel to correct segment. If it is in the same hugepage
> with ro data, mark_rodata_ro will make it unexecutable.

I guess I do not know enough about segments... Original code puts
saved_magic into .data (and probably puts save_registers there by
mistake, too -- so you are fixing things), but you put saved_magic
code into .data, too, so how does its read-only status change?

Does x86-64 need similar fix?
								Pavel


> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
> 
>  linux-2.6.17-rc5-root/arch/i386/kernel/acpi/wakeup.S |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff -puN arch/i386/kernel/acpi/wakeup.S~wakeup arch/i386/kernel/acpi/wakeup.S
> --- linux-2.6.17-rc5/arch/i386/kernel/acpi/wakeup.S~wakeup	2006-06-14 09:21:26.000000000 +0800
> +++ linux-2.6.17-rc5-root/arch/i386/kernel/acpi/wakeup.S	2006-06-14 09:21:57.000000000 +0800
> @@ -265,11 +265,6 @@ ENTRY(acpi_copy_wakeup_routine)
>  	movl	$0x12345678, saved_magic
>  	ret
>  
> -.data
> -ALIGN
> -ENTRY(saved_magic)	.long	0
> -ENTRY(saved_eip)	.long	0
> -
>  save_registers:
>  	leal	4(%esp), %eax
>  	movl	%eax, saved_context_esp
> @@ -304,7 +299,11 @@ ret_point:
>  	call	restore_processor_state
>  	ret
>  
> +.data
>  ALIGN
> +ENTRY(saved_magic)	.long	0
> +ENTRY(saved_eip)	.long	0
> +
>  # saved registers
>  saved_gdt:	.long	0,0
>  saved_idt:	.long	0,0
> _

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
