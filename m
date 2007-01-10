Return-Path: <linux-kernel-owner+w=401wt.eu-S965165AbXAJWoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbXAJWoH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbXAJWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:44:07 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59917 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965165AbXAJWoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:44:04 -0500
Date: Wed, 10 Jan 2007 14:43:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@zeniv.linux.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] mm: pagefault_{disable,enable}()
In-Reply-To: <Pine.LNX.4.62.0701102324460.3855@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0701101436370.3594@woody.osdl.org>
References: <200612071659.kB7GxGHa030259@hera.kernel.org>
 <Pine.LNX.4.64.0701102256410.4331@anakin> <Pine.LNX.4.64.0701101413130.3594@woody.osdl.org>
 <Pine.LNX.4.62.0701102324460.3855@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2007, Geert Uytterhoeven wrote:
>
> > The REAL problem seems to be that the m68k preempt.h (or rather, to be 
> > exact, asm/thread_info.h) doesn't do things right, and while it exposes 
> > "inc_preempt_count()", it doesn't expose enough information to actually 
> > use it.
> > 
> > I think your "current_thread_info()" is broken.
> 
> But struct task_struct is defined in <linux/sched.h>, which cannot be included
> in <asm/thread_info.h> due to include recursion hell.

But why do you need "struct task_struct" at all?

The reason this doesn't happen on other platforms is that they don't use 
"struct task_struct". They use "struct thread_info", which is where the 
preemption counter is.

The problem on m68k i sthat broken indirection through "current", which is 
unnecessary. Isn't the thread structure on the stack on m68k too? So you 
could do what x86 does, and just do

	movel %a7,%d0
	andl $STACK_MASK,%d0

or something, and thus go directly to the thread-info rather than load it 
off the task pointer.

Or, if worst comes to worst, you can just hardcode the offset of the 
thread-info pointer in the "struct task_struct". It's the second word 
after "state". Ugly, but less so than forcing everybody who does NOT want 
to have that big <linux/sched.h> dependency to get it.

		Linus
