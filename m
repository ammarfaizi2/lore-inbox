Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTECUjf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 16:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263416AbTECUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 16:39:35 -0400
Received: from are.twiddle.net ([64.81.246.98]:27026 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263415AbTECUje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 16:39:34 -0400
Date: Sat, 3 May 2003 13:51:59 -0700
From: Richard Henderson <rth@twiddle.net>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 vsyscall DSO implementation, take 2
Message-ID: <20030503205159.GA29384@twiddle.net>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <200305020033.h420XUi12295@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305020033.h420XUi12295@magilla.sf.frob.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 05:33:30PM -0700, Roland McGrath wrote:
> +	/* What follows are the instructions for the table generation.
> +	   We have to record all changes of the stack pointer.  */
> +	.byte 0x04		/* DW_CFA_advance_loc4 */
> +	.long .Lpush_ecx-.LSTART_vsyscall
> +	.byte 0x0e		/* DW_CFA_def_cfa_offset */
> +	.byte 0x08		/* RA at offset 8 now */
> +	.byte 0x04		/* DW_CFA_advance_loc4 */
> +	.long .Lpush_edx-.Lpush_ecx
> +	.byte 0x0e		/* DW_CFA_def_cfa_offset */
> +	.byte 0x0c		/* RA at offset 12 now */
> +	.byte 0x04		/* DW_CFA_advance_loc4 */
> +	.long .Lenter_kernel-.Lpush_edx
> +	.byte 0x0e		/* DW_CFA_def_cfa_offset */
> +	.byte 0x10		/* RA at offset 16 now */
> +	/* Finally the epilogue.  */
> +	.byte 0x04		/* DW_CFA_advance_loc4 */
> +	.long .Lpop_ebp-.Lenter_kernel
> +	.byte 0x0e		/* DW_CFA_def_cfa_offset */
> +	.byte 0x12		/* RA at offset 12 now */
> +	.byte 0x04		/* DW_CFA_advance_loc4 */

You lost the save/restore notes for ebp.

> +	.type __kernel_sigreturn,@function
> +__kernel_sigreturn:
> +.LSTART_kernel_sigreturn:
> +	popl %eax		/* XXX does this mean it needs unwind info? */

Well, yes, but not because of this per-se.  The unwind info
for sigreturn will be quite complex because it should expose
the state of the machine after the return.  I.e. it would 
replace the rather complex code in both gdb and libgcc that
fakes some knowledge of the signal stack frame.

I can try to write it for you if you like.


r~
