Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUEFMSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUEFMSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUEFMSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:18:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55301 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262026AbUEFMSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:18:50 -0400
Date: Thu, 6 May 2004 13:18:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get rid of "+m" constraint in i386 rwsems
Message-ID: <20040506131846.A29621@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <4955.1083844733@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4955.1083844733@redhat.com>; from dhowells@redhat.com on Thu, May 06, 2004 at 12:58:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 12:58:53PM +0100, David Howells wrote:
> Here's a patch to remove the usage of a "+m" constraint in the i386 optimised
> rwsem implementation.

Doesn't the assembly assume that %0 is the same as %4, though because
they're memory operands, the chances of them not being so is pretty
slim?  From the gcc manual, it appears that this may not always be
the case:

|    The ordinary output operands must be write-only; GCC will assume that
| the values in these operands before the instruction are dead and need
| not be generated.  Extended asm supports input-output or read-write
| operands.  Use the constraint character `+' to indicate such an operand
| and list it with the output operands.
| 
|    When the constraints for the read-write operand (or the operand in
| which only some of the bits are to be changed) allows a register, you
| may, as an alternative, logically split its function into two separate
| operands, one input operand and one write-only output operand.  The
| connection between them is expressed by constraints which say they need
| to be in the same location when the instruction executes.  You can use
| the same C expression for both operands, or different expressions.  For
| example, here we write the (fictitious) `combine' instruction with
| `bar' as its read-only source operand and `foo' as its read-write
| destination:
| 
|      asm ("combine %2,%0" : "=r" (foo) : "0" (foo), "g" (bar));
| 
| The constraint `"0"' for operand 1 says that it must occupy the same
| location as operand 0.  A number in constraint is allowed only in an
| input operand and it must refer to an output operand.
| 
|    Only a number in the constraint can guarantee that one operand will
| be in the same place as another.  The mere fact that `foo' is the value
| of both operands is not enough to guarantee that they will be in the
| same place in the generated assembler code.  The following would not
| work reliably:
| 
|      asm ("combine %2,%0" : "=r" (foo) : "r" (foo), "g" (bar));

Can you explain the need for the change?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
