Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFFLTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 07:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTFFLTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 07:19:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64128 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261180AbTFFLTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 07:19:49 -0400
Date: Fri, 6 Jun 2003 07:34:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Richard Henderson <rth@twiddle.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shared Library starter, ld.so
In-Reply-To: <20030606101313.GA28939@twiddle.net>
Message-ID: <Pine.LNX.4.53.0306060721400.4852@chaos>
References: <Pine.LNX.4.53.0306051045180.6171@chaos> <20030606101313.GA28939@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003, Richard Henderson wrote:

> On Thu, Jun 05, 2003 at 10:46:18AM -0400, Richard B. Johnson wrote:
> > The dynamic linker, provided with RedHat 9 no longer
> > compiles with the de facto standard of having register
> > EDX point to function to be called before exit.
>
> You're wrong.  Indeed, the rh9 crt1.o still expects the value:
>
>
>    8:   50                      push   %eax
>    9:   54                      push   %esp
>    a:   52                      push   %edx		<<==== HERE
>    b:   68 00 00 00 00          push   $0x0
>                         c: R_386_32     __libc_csu_fini
>   10:   68 00 00 00 00          push   $0x0
>                         11: R_386_32    __libc_csu_init
>   15:   51                      push   %ecx
>   16:   56                      push   %esi
>   17:   68 00 00 00 00          push   $0x0
>                         18: R_386_32    main
>   1c:   e8 fc ff ff ff          call   1d <_start+0x1d>
>                         1d: R_386_PC32  __libc_start_main
>
> and ld.so provides the value here:
>
>         # Pass our finalizer function to the user in %edx, as per ELF ABI.\n\
>         leal _dl_fini@GOTOFF(%ebx), %edx\n\
>

I am NOT wrong. I have crt startup code and if you actually CALL
the value in %edx, you __will__ segfault. So do a bit of research
before you claim that I'm wrong. Newer versions of the 'C' runtime
library simply fail to call that pointer in atexit(), before exit()
is called.

These things are so easily checked. Just assemble and link this code
against your favorite shared library.

#
#	This is the entry point, usually the first thing in the text
#	segment. The SVR4/i386 ABI (pages 3-31, 3-32) says that upon
#	entry most registers' values are unspecified, except for:
#
#   %edx	Contains a function pointer to be registered with `atexit'.
#   		This is how the dynamic linker arranges to have DT_FINI
#		functions called for shared libraries that have been loaded
#		before this code runs.
#
#   %esp	The stack contains the arguments and environment:
#   		0(%esp)			argc
#		4(%esp)			argv[0]
#		...
#		(4*argc)(%esp)		NULL
#		(4*(argc+1))(%esp)	envp[0]
#		...
#					NULL
#


.section .text
.global _start
.type	_start,@function
_start:	call	*%edx
	pushl	$0
	call	exit
.end



It works, i.e., exits without any errors with the ld-linux.so that
exists on all my systems except the Red Hat 9 system.

On the Red Hat 9 system, it will segfault.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

