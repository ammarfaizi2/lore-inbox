Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWGYHv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWGYHv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWGYHv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:51:57 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:993 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751395AbWGYHv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:51:57 -0400
Date: Tue, 25 Jul 2006 03:46:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH for 2.6.18rc2] [1/7] i386/x86-64: Don't randomize
  stack top when...
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
Message-ID: <200607250348_MC3-1-C5FB-CC80@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44c514a8.6HlRR82y133O2bd0%ak@suse.de>

On Mon, 24 Jul 2006 20:42:48 +0200, Andi Kleen wrote:
> 
> --- linux.orig/arch/i386/kernel/process.c
> +++ linux/arch/i386/kernel/process.c
> @@ -37,6 +37,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/ptrace.h>
>  #include <linux/random.h>
> +#include <linux/personality.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -905,7 +906,7 @@ asmlinkage int sys_get_thread_area(struc
>  
>  unsigned long arch_align_stack(unsigned long sp)
>  {
> -     if (randomize_va_space)
> +     if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
>               sp -= get_random_int() % 8192;
>       return sp & ~0xf;
>  }

I think this needs to be done always, at least on P4.  It really isn't
'randomization' at the same high level as the rest -- more like a small
adjustment.  And the offset should be a multiple of 128 and < 7K (not
8K.) Something like this:

        unsigned int r = get_random_int();
        sp &= ~0x7f;
        sp -= 128 * ((r % 32) + (r / 32 % 16));
        return sp;

-- 
Chuck

