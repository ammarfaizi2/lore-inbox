Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWGIDIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWGIDIF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWGIDIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:08:05 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:50475 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S964918AbWGIDIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:08:04 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile' 
In-reply-to: Your message of "Thu, 06 Jul 2006 13:34:14 MST."
             <Pine.LNX.4.64.0607061333190.3869@g5.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Jul 2006 13:07:49 +1000
Message-ID: <31410.1152414469@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds (on Thu, 6 Jul 2006 13:34:14 -0700 (PDT)) wrote:
>
>
>On Thu, 6 Jul 2006, Linus Torvalds wrote:
>> 
>> So I _think_ that we should change the "=m" to the much more correct "+m" 
>> at the same time (or before - it's really a bug-fix regardless) as 
>> removing the "volatile".
>
>Here's a first cut (UNTESTED!) for x86. I didn't check any other 
>architectures, I bet they have similar problems.
>
>		Linus
>
>----
>diff --git a/include/asm-i386/atomic.h b/include/asm-i386/atomic.h
>index 4f061fa..51a1662 100644
>--- a/include/asm-i386/atomic.h
>+++ b/include/asm-i386/atomic.h
>@@ -46,8 +46,8 @@ static __inline__ void atomic_add(int i,
> {
> 	__asm__ __volatile__(
> 		LOCK_PREFIX "addl %1,%0"
>-		:"=m" (v->counter)
>-		:"ir" (i), "m" (v->counter));
>+		:"+m" (v->counter)
>+		:"ir" (i));
> }

This disagrees with the gcc (4.1.0) docs.  info --index-search='Extended Asm' gcc

  The ordinary output operands must be write-only; GCC will assume
  that the values in these operands before the instruction are dead and
  need not be generated.  Extended asm supports input-output or
  read-write operands.  Use the constraint character `+' to indicate
  such an operand and list it with the output operands.  You should
  only use read-write operands when the constraints for the operand (or
  the operand in which only some of the bits are to be changed) allow a
  register.

All spinlocks must be in memory, which conflicts with the "allow a
register" above.  I hope that the gcc docs are wrong, and read/write
operands can be used on memory as well as registers.  I would hate for
a future gcc to be more strict about this check and break the spinlock
code.  It is interesting that the next paragraph has no such
restriction.

  You may, as an alternative, logically split its function into two
  separate operands, one input operand and one write-only output
  operand.  The connection between them is expressed by constraints
  which say they need to be in the same location when the instruction
  executes.  You can use the same C expression for both operands, or
  different expressions.  For example, here we write the (fictitious)
  `combine' instruction with `bar' as its read-only source operand and
  `foo' as its read-write destination:

     asm ("combine %2,%0" : "=r" (foo) : "0" (foo), "g" (bar));

  The constraint `"0"' for operand 1 says that it must occupy the same
  location as operand 0.  A number in constraint is allowed only in an
  input operand and it must refer to an output operand.

