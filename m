Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312378AbSCUPy4>; Thu, 21 Mar 2002 10:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312380AbSCUPyr>; Thu, 21 Mar 2002 10:54:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:25966 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312378AbSCUPyg>; Thu, 21 Mar 2002 10:54:36 -0500
Date: Thu, 21 Mar 2002 15:57:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Matt Robinson <yakker@aparity.com>, "Amit S. Kale" <akale@veritas.com>,
        binutils@sources.redhat.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] x86 BUG handling
In-Reply-To: <3C982505.F340B421@zip.com.au>
Message-ID: <Pine.LNX.4.21.0203211518290.1502-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andrew Morton wrote:
> This has been in 2.5 for a few weeks, no problems reported.

Please, let's at least warn the x86 disassembler opcode folks...

> We embed the file-and-line info inline after the invalid opcode
> in the program text.  This means that when we hit the invalid
> opcode handler, the stacked machine register info is correct.
> Fixes the problem where the printk() wrecks the non-call-preserved
> registers.
> 
> CONFIG_DEBUG_BUGVERBOSE goes away.  Fixes the problem where kernel
> developers don't know where their BUGs are.
> 
> On my fairly lean kernel build, kernel size is reduced by 90 kbytes
> relative to a CONFIG_DEBUG_BUGVERBOSE=y build, due to all the do_BUG()
> calls which aren't there any more.

This patch already went into Linux 2.5.5 and 2.4.19-pre3-ac4, sounds
like it may be heading for 2.4.19-pre5.  It's good for kernel debug,
and good for kernel space-saving, but... it confuses disassemblers
which think that "ud2" is a 2-byte instruction: they need to pretend
it's an 8-byte instruction when dealing with the new kernel objects.
I suspect it could be transparent if we used one more byte per BUG, but
that's not how it is, so may affect gdb, kdb, ksymoops, lcrash, objdump...

Hugh

> --- 2.4.19-pre3/include/asm-i386/page.h~BUG	Tue Mar 19 21:11:43 2002
> +++ 2.4.19-pre3-akpm/include/asm-i386/page.h	Tue Mar 19 21:11:43 2002
> @@ -91,16 +91,18 @@ typedef struct { unsigned long pgprot; }
>  /*
>   * Tell the user there is some problem. Beep too, so we can
>   * see^H^H^Hhear bugs in early bootup as well!
> + * The offending file and line are encoded after the "officially
> + * undefined" opcode for parsing in the trap handler.
>   */
>  
> -#ifdef CONFIG_DEBUG_BUGVERBOSE
> -extern void do_BUG(const char *file, int line);
> -#define BUG() do {					\
> -	do_BUG(__FILE__, __LINE__);			\
> -	__asm__ __volatile__("ud2");			\
> -} while (0)
> +#if 1	/* Set to zero for a slightly smaller kernel */
> +#define BUG()				\
> + __asm__ __volatile__(	"ud2\n"		\
> +			"\t.word %c0\n"	\
> +			"\t.long %c1\n"	\
> +			 : : "i" (__LINE__), "i" (__FILE__))
>  #else
> -#define BUG() __asm__ __volatile__(".byte 0x0f,0x0b")
> +#define BUG() __asm__ __volatile__("ud2\n")
>  #endif
>  
>  #define PAGE_BUG(page) do { \
[ remainder of patch irrelevant to disassembly issue ]

