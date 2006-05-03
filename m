Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWECFES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWECFES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 01:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWECFES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 01:04:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10205 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965090AbWECFER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 01:04:17 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.17-rc3-mm1] i386: break out of recursion in stackframe walk 
In-reply-to: Your message of "Tue, 02 May 2006 11:50:34 +0200."
             <20060502095034.GA21063@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 May 2006 15:03:56 +1000
Message-ID: <16113.1146632636@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar (on Tue, 2 May 2006 11:50:34 +0200) wrote:
>if CONFIG_FRAME_POINTERS is enabled, and one does a dump_stack() during 
>early SMP init, an infinite stackdump and a bootup hang happens:
>
> [<c0104e7f>] show_trace+0xd/0xf
> [<c0104e96>] dump_stack+0x15/0x17
> [<c01440df>] save_trace+0xc3/0xce
> [<c014527d>] mark_lock+0x8c/0x4fe
> [<c0145df5>] __lockdep_acquire+0x44e/0xaa5
> [<c0146798>] lockdep_acquire+0x68/0x84
> [<c1048699>] _spin_lock+0x21/0x2f
> [<c010d918>] prepare_set+0xd/0x5d
> [<c010daa8>] generic_set_all+0x1d/0x201
> [<c010ca9a>] mtrr_ap_init+0x23/0x3b
> [<c010ada8>] identify_cpu+0x2a7/0x2af
> [<c01192a7>] smp_store_cpu_info+0x2f/0xb4
> [<c01197d0>] start_secondary+0xb5/0x3ec
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [<c104ec11>] end_of_stack_stop_unwind_function+0x1/0x4
> [...]
>
>due to "end_of_stack_stop_unwind_function" recursing back to itself in 
>the EBP stackframe-walker. So avoid this type of recursion when walking 
>the stack .
>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>
>Index: linux/arch/i386/kernel/traps.c
>===================================================================
>--- linux.orig/arch/i386/kernel/traps.c
>+++ linux/arch/i386/kernel/traps.c
>@@ -150,6 +150,12 @@ static inline unsigned long print_contex
> 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
> 		addr = *(unsigned long *)(ebp + 4);
> 		printed = print_addr_and_symbol(addr, log_lvl, printed);
>+		/*
>+		 * break out of recursive entries (such as
>+		 * end_of_stack_stop_unwind_function):
>+	 	 */
>+		if (ebp == *(unsigned long *)ebp)
>+			break;
> 		ebp = *(unsigned long *)ebp;
> 	}
> #else

KDB just limits kernel traces to a maximum of 200 entries, which
catches direct as well as indirect recursion.  IA64 is notorious for
getting loops in its unwind data, sometime looping over three or four
functions.  Checking for a maximum number of entries is a simple and
architecture independent check.

