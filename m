Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTEHRvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTEHRvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:51:53 -0400
Received: from mail.coastside.net ([207.213.212.6]:31207 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP id S261918AbTEHRvw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:51:52 -0400
Mime-Version: 1.0
Message-Id: <p0521060abae04b745ea6@[207.213.214.37]>
In-Reply-To: <200305081009_MC3-1-37FA-2407@compuserve.com>
References: <200305081009_MC3-1-37FA-2407@compuserve.com>
Date: Thu, 8 May 2003 11:04:19 -0700
To: linux-kernel <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: top stack (l)users for 2.5.69
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:08am -0400 5/8/03, Chuck Ebbert wrote:
>  > I have no idea, what a 'typical processor' might look like. But the
>>  thing most CPU seem to have in common is that they save two registers
>>  either on the stack or into other registers that only exist for this
>>  purpose (SRR on PPC).
>>
>>  Once that has happened, the OS has the job to figure out where it's
>>  stack (or equivalent) is located, *without* clobbering the registers.
>>  Once that is done, it can save all the registern on the stack,
>>  including SRR.
>
>   On i386 the CPU automatically switches to the stack corresponding to
>the privilege level (PL) of the interrupt handler, then pushes the
>instruction pointer and flags onto that stack.  It is theoretically
>possible to write unprivileged interrupt handlers by using conforming
>code segments, in which case a stack switch will not occur, but such a
>handler cannot touch anything but registers and stack so it's not very
>useful.

In particular, the interrupt stack is the kernel stack of the current 
task. This is (in part) what leads to stack overflows. If the current 
task is running in the kernel, using a significant hunk of its stack, 
an interrupt is limited to the balance of that stack. And if that 
interrupt triggers a soft irq that runs, say, a network stack, and 
that softirq handler in turn gets interrupted, we've got, 
effectively, three processes sharing the stack. And of course hard 
interrupts can be nested, so it's pretty damn difficult to specify a 
safe upper limit for stack usage.
-- 
/Jonathan Lundell.
