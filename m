Return-Path: <linux-kernel-owner+w=401wt.eu-S932270AbXAOMJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXAOMJa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 07:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbXAOMJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 07:09:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:36148 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932240AbXAOMJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 07:09:29 -0500
Date: Mon, 15 Jan 2007 13:09:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@zeniv.linux.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] mm: pagefault_{disable,enable}()
In-Reply-To: <Pine.LNX.4.64.0701101436370.3594@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0701111918480.787@scrub.home>
References: <200612071659.kB7GxGHa030259@hera.kernel.org>
 <Pine.LNX.4.64.0701102256410.4331@anakin> <Pine.LNX.4.64.0701101413130.3594@woody.osdl.org>
 <Pine.LNX.4.62.0701102324460.3855@pademelon.sonytel.be>
 <Pine.LNX.4.64.0701101436370.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Jan 2007, Linus Torvalds wrote:

> > > I think your "current_thread_info()" is broken.

No, it's not. What is broken are our header dependencies - we happily mix 
declarations with implementations.
Let's take a simple example like <linux/list.h>, which is practically 
included everywhere, but even that already includes 57 other files and 
depends on 49 config symbols (by comparison for <linux/types.h> it's 7 
other files and 7 symbols).

> > But struct task_struct is defined in <linux/sched.h>, which cannot be included
> > in <asm/thread_info.h> due to include recursion hell.
> 
> But why do you need "struct task_struct" at all?
> 
> The reason this doesn't happen on other platforms is that they don't use 
> "struct task_struct". They use "struct thread_info", which is where the 
> preemption counter is.
> 
> The problem on m68k i sthat broken indirection through "current", which is 
> unnecessary. Isn't the thread structure on the stack on m68k too? So you 
> could do what x86 does, and just do
> 
> 	movel %a7,%d0
> 	andl $STACK_MASK,%d0

That's exactly want I want to avoid, thread info and task struct can be 
accessed via a single register (pointer).

> Or, if worst comes to worst, you can just hardcode the offset of the 
> thread-info pointer in the "struct task_struct". It's the second word 
> after "state". Ugly, but less so than forcing everybody who does NOT want 
> to have that big <linux/sched.h> dependency to get it.

That still generates worse code, the best solution would be to leave the 
work to gcc, but that requires it can actually recognize that task struct 
and thread info need only a single pointer.
One possibility would be to do something like ia64 and abuse 
asm-offsets.h, but then one gets other funny build problems.

By far the cleanest solution would be to clean up our damned header 
dependencies, separating task_struct from sched.h is not that difficult 
and would give archs far more flexibility how to place task struct and 
thread info.

bye, Roman
