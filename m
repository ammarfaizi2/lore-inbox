Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTKSUcp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 15:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTKSUcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 15:32:45 -0500
Received: from waste.org ([209.173.204.2]:36331 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263903AbTKSUcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 15:32:43 -0500
Date: Wed, 19 Nov 2003 14:32:10 -0600
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
Message-ID: <20031119203210.GC22139@waste.org>
References: <Pine.LNX.4.53.0311181113150.11537@montezuma.fsmlabs.com> <Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311180830050.18739-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 08:37:25AM -0800, Linus Torvalds wrote:
> 
> On Tue, 18 Nov 2003, Zwane Mwaikambo wrote:
> > 
> > Here are diffs from the do_sys_vm86 only.
> 
> Ok. Much more readable.
> 
> And there is something very suspicious there.
> 
> The code with and without the printk() looks _identical_ apart from some 
> trivial label renumbering, and the added
> 
> 	pushl   $.LC6
> 	call    printk
> 	.. asm ..
> 	popl %esi
> 
> which all looks fine (esi is dead at that point, so the compiler is just
> using a "popl" as a shorter form of "addl $4,%esp").
> 
> Btw, you seem to compile with debugging, which makes the assembly 
> language pretty much unreadable and accounts for most of the 
> differences: the line numbers change. If you compile a kernel where the 
> line numbers don't change (by commenting _out_ the printk rather than 
> removing the whole line), your diff would be more readable.
> 
> Anyway, there are _zero_ differences.
> 
> Just for fun, try this: move the "printk()" to _below_ the "asm"  
> statement. It will never actually get executed, but if it's an issue of
> some subtle code or data placement things (cache lines etc), maybe that
> also hides the oops, since all the same code and data will be generated, 
> just not run...

Zwane's got a K6-2 500MHz. I've just managed to reproduce this on my
1.4GHz Opteron box (with Debian gcc 3.2). Here, the "ooh la la" bit
doesn't help. So my suspicion is that the printk is changing the
timing just enough on Zwane's box that he's getting a timer interrupt
knocking him out of vm86 mode before he hits a fatal bit in the fault
handling path for 4/4. Printks in handle_vm86_trap, handle_vm86_fault,
do_trap:vm86_trap, and do_general_protection:gp_in_vm86 never fire so
there's probably something amiss in the trampoline code.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
