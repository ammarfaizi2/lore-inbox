Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVARNIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVARNIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVARNHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:07:53 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:52678 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261290AbVARNHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:07:40 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 0/3] kallsyms: Add gate page and all symbols support 
In-reply-to: Your message of "Tue, 18 Jan 2005 18:52:55 +1100."
             <1106034775.4499.86.camel@gaston> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Jan 2005 00:07:31 +1100
Message-ID: <15379.1106053651@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005 18:52:55 +1100, 
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>On Tue, 2004-12-28 at 22:17 +0100, Sam Ravnborg wrote:
>
>> > 2 Add in_gate_area_no_task() for use from places where no task is valid.
>
>Can you back that out ? Or at least explain why you need to add this
>"no_task" thing and not just use "current" where no task is available ?

kallsyms is used to look up a symbol for any task, e.g. to do a
backtrace with symbol lookup of all running tasks, not just the current
one.  None of the kallsym interfaces allow you to specify which task
you are making the query against, and the change to do so is too messy
and intrusive for far too little return.  The no_task variant asks "is
this a possible gate address for any task?", at the small risk of
getting false positives in kallsyms lookup.

> - Since you unconditionally #define in_gate_area() to use
>in_gate_area_no_task(), what is the point of having in_gate_area() at
>all ? Which rather means, what is the point of adding that "_no_task"
>version and not just change in_gate_area to not take a task ?

x86-64 needs both variants.  in_gate_area() is sometimes called in a
context where you know the required task (mm/memory.c), sometimes when
any task is implied (kernel/kallsyms.c).  x86-64 makes it more
complicated by using different gate pages depending on whether the
specified task is in 32 bit emulation mode or not.

> - I dislike the fact that you now define the prototype of the function
>in the __HAVE_ARCH_GATE_AREA case. I want my arch .h to be the one doing
>so, since i want to inline it

Maybe.  I dislike copying definitions to multiple asm headers.  If you
think that the win of inlining the ppc64 version of these functions
outweighs the header duplication then send a patch.  Don't forget to
duplicate the definition in include/asm-x86_64 as well.

>(to nothing in the ppc64 case since the
>vDSO I'm implementing doesn't need any special treatement of the gate
>area, it's a normal VMA added to the mm's at exec time).

Added to specific task's mm or to all tasks?  If the gate VMA varies
according to the task then you have to support the kallsyms "is this a
possible gate address for any task?" question, like x86-64.

