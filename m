Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266028AbRGFFyR>; Fri, 6 Jul 2001 01:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGFFyH>; Fri, 6 Jul 2001 01:54:07 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:13060 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266028AbRGFFxt>;
	Fri, 6 Jul 2001 01:53:49 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15173.20830.393732.478322@cargo.ozlabs.ibm.com>
Date: Fri, 6 Jul 2001 15:49:18 +1000 (EST)
To: mdaljeet@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: floating point problem
In-Reply-To: <CA256A80.005F1790.00@d73mta01.au.ibm.com>
In-Reply-To: <CA256A80.005F1790.00@d73mta01.au.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdaljeet@in.ibm.com writes:

> In Linux PPC, the MSR[FP] bit (that is floating point available bit) is off
> (atleast for non-SMP).
> 
> Due to this, whenever some floating point instruction is executed in 'user
> mode', it leads to a exception 'FPUnavailable'. The exception handler for

Yes, this is so that we don't have to save and restore the floating
point registers on every context switch.

> this exception apart from setting the MSR[FP] bit, also sets the MSR[FE0]
> and MSR[FE1] bits. These bits basically enables the floating point
> exceptions so that if there are some floating point exception conditions
> encountered while exeuting a floating point instruction, an appropriate
> exception is raised.

You have control at user-level over whether the cpu will take an
exception (leading to a SIGFPE signal) or not by means of the FPSCR
register.  The VE, OE, UE, ZE and XE bits in the FPSCR control whether
the cpu will take an exception on floating-point invalid operation,
overflow, underflow, divide by zero and inexact result respectively.

If the kernel cleared the FE0 and FE1 bits, there would be no way for
an application to get a signal when a floating-point error occurred.
With FE0 and FE1 set, the application can control this using the
FPSCR, and get a signal, or not, as it prefers.

> But whenever some floating point instruction is executed in 'kernel mode',
> 'FPUnavailabe' exception handler code does not set the 'MSR[FE0] and
> MSR[FE1]' bits.

Floating point is not intended to be used in the kernel except in a
couple of specific places.

> Problem is that we want to get the good results without changing the
> kernel. Either by having the user mode application to interact with some
> special module which can set the MSR[FP] bit before we execute the floating
> point instruction or by some other trick.....Is there any solution apart
> from changing the kernel?

Clear the appropriate bits in the FPSCR.  There is almost certainly a
glibc interface to do this but I don't know what it would be.

Paul.
