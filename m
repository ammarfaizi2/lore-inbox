Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUG3EW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUG3EW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 00:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUG3EW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 00:22:26 -0400
Received: from pxy2allmi.all.mi.charter.com ([24.247.15.40]:53897 "EHLO
	proxy2-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S265074AbUG3EWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 00:22:24 -0400
Message-ID: <4109CCED.5020808@quark.didntduck.org>
Date: Fri, 30 Jul 2004 00:22:05 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [cleanup] do_general_protection doesn't disable irq
References: <20040730025349.GE30369@dualathlon.random>
In-Reply-To: <20040730025349.GE30369@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> A trap gate shouldn't affect the irq status at all.
> 
> This should be a valid cleanup that removes a slightly confusing noop:
> 
> Index: linux-2.5/arch/i386/kernel/traps.c
> ===================================================================
> RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/kernel/traps.c,v
> retrieving revision 1.77
> diff -u -p -r1.77 traps.c
> --- linux-2.5/arch/i386/kernel/traps.c	13 Jul 2004 18:02:33 -0000	1.77
> +++ linux-2.5/arch/i386/kernel/traps.c	30 Jul 2004 02:44:23 -0000
> @@ -431,9 +431,6 @@ DO_ERROR_INFO(17, SIGBUS, "alignment che
>  
>  asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
>  {
> -	if (regs->eflags & X86_EFLAGS_IF)
> -		local_irq_enable();
> - 
>  	if (regs->eflags & VM_MASK)
>  		goto gp_in_vm86;
>  
> 
> Thanks to Karsten for noticing a trap gate doesn't actually enable irq
> by default either (offtopic issue with the above patch, but while
> reading the 2.6 code I found the above bit which just confused me more
> since it's a noop, either that or you meant to use set_intr_gate, not
> set_trap_gate on the do_general_protection handler, but it seems not
> needed to use a trap gate since a trap gate shouldn't enable irqs by
> default). Please correct me if wrong.

This is there for vm86 mode.  See http://tinyurl.com/3m5nr

--
				Brian Gerst
