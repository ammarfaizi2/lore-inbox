Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWECGqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWECGqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWECGqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:46:17 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:52693
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965107AbWECGqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:46:17 -0400
Message-Id: <44586E0E.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Wed, 03 May 2006 08:47:10 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Martin Bligh" <mbligh@google.com>, "Andrew Morton" <akpm@osdl.org>,
       <apw@shadowen.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <200605012034.26763.ak@suse.de> <4457BA59.8030901@google.com> <200605022209.37205.ak@suse.de>
In-Reply-To: <200605022209.37205.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 02.05.06 22:09 >>>
>On Tuesday 02 May 2006 22:00, Martin Bligh wrote:
>
>> > Index: linux/arch/x86_64/kernel/traps.c
>> > ===================================================================
>> > --- linux.orig/arch/x86_64/kernel/traps.c
>> > +++ linux/arch/x86_64/kernel/traps.c
>> > @@ -238,6 +238,7 @@ void show_trace(unsigned long *stack)
>> >  			HANDLE_STACK (stack < estack_end);
>> >  			i += printk(" <EOE>");
>> >  			stack = (unsigned long *) estack_end[-2];
>> > +			printk("new stack %lx (%lx %lx %lx %lx %lx)\n", stack, estack_end[0], estack_end[-1],
estack_end[-2], estack_end[-3], estack_end[-4]);
>> >  			continue;
>> >  		}
>> >  		if (irqstack_end) {
>> 
>> Thanks for running this Andy:
>> 
>> http://test.kernel.org/abat/30183/debug/console.log 
>
>
><EOE>new stack 0 (0 0 0 10082 10)

Looks like <rubbish> <SS> <RSP> <RFLAGS> <CS> to me, ...

>Hmm weird. There isn't anything resembling an exception frame at the top of the
>stack.  No idea how this could happen.

... which is a valid frame where the stack pointer was corrupted before the exception occurred. One more printed item
(or rather, starting items at estack_end[-1]) would allow at least seeing what RIP this came from.

This actually points out another weakness of that code: if you pick up a mis-aligned stack pointer then the conditions
in both the exception and interrupt stack invocations of HANDLE_STACK() won't prevent you from accessing an item
crossing a page boundary, and hence potentially faulting. Similarly, obtaining an entirely bad stack pointer anywhere in
that code will result in a fault. I guess the stack reads should really be done using get_user() or some other code
having recovery attached.

Jan
