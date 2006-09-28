Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWI1GfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWI1GfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWI1GfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:35:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751615AbWI1GfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:35:15 -0400
Date: Wed, 27 Sep 2006 23:35:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put the BUG __FILE__ and __LINE__ info out of line
Message-Id: <20060927233509.f675c02d.akpm@osdl.org>
In-Reply-To: <451B64E3.9020900@goop.org>
References: <451B64E3.9020900@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 23:00:03 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> When CONFIG_DEBUG_BUGVERBOSE is enabled, the embedded file and line
> information makes a disassembler very unhappy, because it tries to
> parse them as instructions (it probably makes the CPU's instruction
> decoder a little unhappy too).
> 
> This patch moves them out of line, and calls the ud2 from the code -
> the call makes sure the original %eip is available on the top of the
> stack.  The result is a happy disassembler, with no loss of debugging
> information.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
> 
> --
>  arch/i386/kernel/vmlinux.lds.S |    2 ++
>  include/asm-i386/bug.h         |   13 ++++++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff -r 1d29394927f3 arch/i386/kernel/vmlinux.lds.S
> --- a/arch/i386/kernel/vmlinux.lds.S	Tue Sep 26 01:20:38 2006 -0700
> +++ b/arch/i386/kernel/vmlinux.lds.S	Wed Sep 27 22:18:23 2006 -0700
> @@ -27,6 +27,8 @@ SECTIONS
>    _text = .;			/* Text and read-only data */
>    .text : AT(ADDR(.text) - LOAD_OFFSET) {
>  	*(.text)
> +	__bugs = .;
> +	*(.text.bugs)
>  	SCHED_TEXT
>  	LOCK_TEXT
>  	KPROBES_TEXT
> diff -r 1d29394927f3 include/asm-i386/bug.h
> --- a/include/asm-i386/bug.h	Tue Sep 26 01:20:38 2006 -0700
> +++ b/include/asm-i386/bug.h	Wed Sep 27 18:59:41 2006 -0700
> @@ -11,11 +11,14 @@
>  #ifdef CONFIG_BUG
>  #define HAVE_ARCH_BUG
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
> -#define BUG()				\
> - __asm__ __volatile__(	"ud2\n"		\
> -			"\t.word %c0\n"	\
> -			"\t.long %c1\n"	\
> -			 : : "i" (__LINE__), "i" (__FILE__))
> +#define BUG()								\
> +	__asm__ __volatile__("call 1f\n"				\
> +			     ".section .text.bugs\n"			\
> +			     "1:\tud2\n"					\
> +			     "\t.word %c0\n"				\
> +			     "\t.long %c1\n"				\
> +			     ".previous\n"				\
> +			     : : "i" (__LINE__), "i" (__FILE__))
>  #else
>  #define BUG() __asm__ __volatile__("ud2\n")
>  #endif

hm.  Bigger vmlinux, smaller .text.

It means that we'll hit handle_BUG with that extra EIP pushed on the stack.
 What does that do to the stack trace, and to the unwinder?

It'll also muck up the displayed EIP, not that that matters a lot (well, it
might matter a bit if the BUG is in an inlined function).

We could get the correct EIP by fishing it off the stack (and subtracting
five from it?)

Or we could assume that BUG doesn't return (it doesn't) and make that call
a jmp.  But then we'd really lose the EIP.


