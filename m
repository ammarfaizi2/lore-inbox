Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbTDMU6p (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 16:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTDMU6p (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 16:58:45 -0400
Received: from are.twiddle.net ([64.81.246.98]:10193 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261945AbTDMU6o (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 16:58:44 -0400
Date: Sun, 13 Apr 2003 14:10:28 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: unwinding for vsyscall code
Message-ID: <20030413141028.A3683@twiddle.net>
Mail-Followup-To: Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3E98E01C.3070103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E98E01C.3070103@redhat.com>; from drepper@redhat.com on Sat, Apr 12, 2003 at 08:57:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 08:57:16PM -0700, Ulrich Drepper wrote:
> +	/* What follows are the instructions for the table generation.
> +	   We have to record all changes of the stack pointer.  */
> +		0x04,			/* DW_CFA_advance_loc4 */
> +		0x01, 0x00, 0x00, 0x00,	/* Size of push %ecx */
> +		0x0e,			/* DW_CFA_def_cfa_offset */
> +		0x08,			/* RA at offset 8 now */
> +		0x04,			/* DW_CFA_advance_loc4 */
> +		0x01, 0x00, 0x00, 0x00,	/* Size of push %edx */
> +		0x0e,			/* DW_CFA_def_cfa_offset */
> +		0x0c,			/* RA at offset 12 now */
> +		0x04,			/* DW_CFA_advance_loc4 */
> +		0x01, 0x00, 0x00, 0x00,	/* Size of push %ebp */
> +		0x0e,			/* DW_CFA_def_cfa_offset */
> +		0x10,			/* RA at offset 16 now */

Not only changes to the stack pointer, but also changes to call-saved
registers, such as %ebp.  You're intending to be able to unwind through
asynchronous signals here, which means that you can't leave even a single
insn window with a register modified but not recorded.

So you also need a

	0x85 0x04			DW_CFA_offset %ebp -16

there at the end of the prologue.

> +	/* Finally the epilogue.  */
> +		0x04,			/* DW_CFA_advance_loc4 */
> +		0x0e, 0x00, 0x00, 0x00,	/* Offset til pop %edx */
> +		0x0e,			/* DW_CFA_def_cfa_offset */
> +		0x12,			/* RA at offset 12 now */

And of course you need a corresponding bit here, since once we
pop off the slot in which we stored %ebp, we can't restore it
from there, because we will have clobbered that slot in the
signal handler.

(Btw, typo here in comment; it's "%ebp" not "%edx".)

So here we also need a 

	0xc5				DW_CFA_restore %ebp

here before the next DW_CFA_advance_loc.

Oh, and you don't need to use DW_CFA_advance_loc4.  You should
be using

	DW_CFA_advance_loc+N		N <= 0x3f
	DW_CFA_advance_loc1 N		N <= 0xff

We have to use DW_CFA_advance_loc4 in GCC because we don't know
the true sizes of instructions.  This gets fixed for us in GAS
through some truely disgusting magic based on section names.



r~
