Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTEHStD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 14:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTEHStD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 14:49:03 -0400
Received: from watch.techsource.com ([209.208.48.130]:26804 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261927AbTEHStC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 14:49:02 -0400
Message-ID: <3EBAAA8B.4060001@techsource.com>
Date: Thu, 08 May 2003 15:05:47 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Lundell <linux@lundell-bros.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <200305081009_MC3-1-37FA-2407@compuserve.com> <p0521060abae04b745ea6@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jonathan Lundell wrote:
> 
> 
> In particular, the interrupt stack is the kernel stack of the current 
> task. This is (in part) what leads to stack overflows. If the current 
> task is running in the kernel, using a significant hunk of its stack, an 
> interrupt is limited to the balance of that stack. And if that interrupt 
> triggers a soft irq that runs, say, a network stack, and that softirq 
> handler in turn gets interrupted, we've got, effectively, three 
> processes sharing the stack. And of course hard interrupts can be 
> nested, so it's pretty damn difficult to specify a safe upper limit for 
> stack usage.

This is the sort of things that would severely limit our ability to 
shrink the kernel stack.  While it's perhaps feasible to shrink kernel 
stack usage for typical syscalls, exactly the situation you describe is 
unpredictable and very difficult to avoid.

My suggestion would be that if we do manage to get typical stack usage 
down to the point where we can go to a 4K stack, then interrupt handlers 
would have to be rewritten to recognize whether or not the interrupt 
arrived on a user process kernel stack and then move the context over to 
the "interrupt stack".  The overhead would be low enough that it's worth 
doing so that we could reduce process kernel stack size.  Whenever an 
interrupt service routine is itself interrupted, the interrupt stack 
check code would realize that it is already using the interrupt stack 
and not move the context.  Here, then, we would need only one single 
interrupt stack which we would size for worst case; so if we made it 8 
or 12K, that's 8 or 12K once for each CPU which is allowed to receive 
interrupts, not once per process.

You like?  :)

