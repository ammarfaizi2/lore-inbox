Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVDMCQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVDMCQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVDMCNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:13:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:53945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbVDMCKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:10:00 -0400
Date: Tue, 12 Apr 2005 19:09:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: petkov@uni-muenster.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3]: entry.S trap return fixes
Message-Id: <20050412190940.066be192.akpm@osdl.org>
In-Reply-To: <425C25D3.7010703@aknet.ru>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<1113209793l.7664l.1l@werewolf.able.es>
	<20050411024322.786b83de.akpm@osdl.org>
	<200504112359.40487.petkov@uni-muenster.de>
	<20050411152243.22835d96.akpm@osdl.org>
	<425B4C92.1070507@aknet.ru>
	<20050411212712.0dbd821d.akpm@osdl.org>
	<425C25D3.7010703@aknet.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> do_debug() returns void, do_int3() too when
>  !CONFIG_KPROBES.
>  This patch fixes the CONFIG_KPROBES variant
>  of do_int3() to return void too and adjusts
>  the entry.S accordingly.
> 

This patch is applicable to the mainline kernel, is it not?


> 
> 
> 
> [kgdbfix1.diff  text/x-patch (1297 bytes)]
>  --- linux/arch/i386/kernel/entry.S.old	2005-04-12 09:47:38.000000000 +0400
>  +++ linux/arch/i386/kernel/entry.S	2005-04-12 11:13:03.000000000 +0400
>  @@ -550,8 +550,6 @@
>   	xorl %edx,%edx			# error code 0
>   	movl %esp,%eax			# pt_regs pointer
>   	call do_debug
>  -	testl %eax,%eax
>  -	jnz restore_all
>   	jmp ret_from_exception
>   
>   /*
>  @@ -632,8 +630,6 @@
>   	xorl %edx,%edx		# zero error code
>   	movl %esp,%eax		# pt_regs pointer
>   	call do_int3
>  -	testl %eax,%eax
>  -	jnz restore_all
>   	jmp ret_from_exception
>   
>   ENTRY(overflow)
>  --- linux/arch/i386/kernel/traps.c.old	2005-04-12 09:47:38.000000000 +0400
>  +++ linux/arch/i386/kernel/traps.c	2005-04-12 10:59:54.000000000 +0400
>  @@ -695,16 +695,15 @@
>   }
>   
>   #ifdef CONFIG_KPROBES
>  -fastcall int do_int3(struct pt_regs *regs, long error_code)
>  +fastcall void do_int3(struct pt_regs *regs, long error_code)
>   {
>   	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
>   			== NOTIFY_STOP)
>  -		return 1;
>  +		return;
>   	/* This is an interrupt gate, because kprobes wants interrupts
>   	disabled.  Normal trap handlers don't. */
>   	restore_interrupts(regs);
>   	do_trap(3, SIGTRAP, "int3", 1, regs, error_code, NULL);
>  -	return 0;
>   }
>   #endif
