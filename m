Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUBHAMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 19:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUBHAMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 19:12:18 -0500
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:20178 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S261506AbUBHAMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 19:12:15 -0500
Message-ID: <40257EDC.9080508@jon-foster.co.uk>
Date: Sun, 08 Feb 2004 00:12:12 +0000
From: Jon Foster <jon@jon-foster.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 37/42]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kronos wrote:
> Comments on the patch?
> 
> diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/page.h linux-2.4/include/asm-i386/page.h
> --- linux-2.4-vanilla/include/asm-i386/page.h	Tue Nov 11 18:05:52 2003
> +++ linux-2.4/include/asm-i386/page.h	Wed Feb  4 14:43:00 2004
> @@ -95,14 +95,28 @@
>   * undefined" opcode for parsing in the trap handler.
>   */
>  
> +#ifdef __bug
> +static inline void __dummy_noreturn(void) __bug;
> +static inline void __dummy_noreturn(void) {
> +	while(1) {}
> +}

My first thought was "this obviously makes the kernel bigger".  GCC will
actually compile this loop - it's only a single jump instruction, possibly
with a nop for branch target alignment, but it's duplicated for every
call to BUG().

On the other hand, marking BUG() as noreturn means that GCC won't have
to generate the code following the BUG().  Even if that code is just
a jump, it's a similar size to the code that this patch adds.  So it's
not as obvious as I first thought, and does need measuring.

Tested with Linux 2.4.22-gentoo-r5 & my normal kernel config, by
measuring total uncompressed size of vmlinux:

Without patch:   3,475,213 bytes
With patch:      3,475,149 bytes
This patch saves:       64 bytes

OK, that saving is lost in the noise, but it seems that this patch
isn't going to change the kernel size much (if at all).  And it is
good to let the compiler know about BUG(), so it doesn't emit
spurious warnings and can catch unused code.  So I like this patch.

Obviously, the most elegent (and space-saving) solution would be
if GCC allowed you to mark a block of inline assembly as noreturn.
Any GCC folks out there able to help?

Kind regards,

Jon


> +#else
> +#define __dummy_noreturn() do {} while(0)
> +#endif
> +
> #if 1 /* Set to zero for a slightly smaller kernel */
> -#define BUG() \
> - __asm__ __volatile__( "ud2\n" \
> - "\t.word %c0\n" \
> - "\t.long %c1\n" \
> - : : "i" (__LINE__), "i" (__FILE__))
> +#define BUG() do { \
> + __asm__ __volatile__( "ud2\n" \
> + "\t.word %c0\n" \
> + "\t.long %c1\n" \
> + : : "i" (__LINE__), "i" (__FILE__)); \
> + __dummy_noreturn(); \
> + } while(0)
> #else
> -#define BUG() __asm__ __volatile__("ud2\n")
> +#define BUG() do { \
> + __asm__ __volatile__("ud2\n"); \
> + __dummy_noreturn(); \
> + } while(0)
> #endif
> 
> #define PAGE_BUG(page) do { \
> diff -Nru -X dontdiff linux-2.4-vanilla/include/linux/compiler.h linux-2.4/include/linux/compiler.h
> --- linux-2.4-vanilla/include/linux/compiler.h Tue Sep 18 23:12:45 2001
> +++ linux-2.4/include/linux/compiler.h Tue Feb 3 18:29:56 2004
> @@ -13,4 +13,11 @@
> #define likely(x) __builtin_expect((x),1)
> #define unlikely(x) __builtin_expect((x),0)
> 
> +#if __GNUC__ >= 3
> +/* __noreturn__ is implemented since gcc 2.5.
> + * __always_inline__ is not present in 2.9x
> + */
> +#define __bug __attribute__((__noreturn__, __always_inline__))
> +#endif
> +
> #endif /* __LINUX_COMPILER_H */


