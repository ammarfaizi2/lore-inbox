Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVGCLJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVGCLJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 07:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVGCLIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 07:08:25 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:5533 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261302AbVGCLH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 07:07:57 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       "cutaway@bellsouth.net" <cutaway@bellsouth.net>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
Date: Sat, 2 Jul 2005 14:56:40 +0300
User-Agent: KMail/1.5.4
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Coywolf Qi Hunt" <coywolf@gmail.com>
References: <200507012258_MC3-1-A340-3A81@compuserve.com>
In-Reply-To: <200507012258_MC3-1-A340-3A81@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507021456.40667.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 July 2005 05:57, Chuck Ebbert wrote:
> On Wed, 22 Jun 2005 at 04:41:47 -0400, cutaway wrote:
> 
> > The compilers got tweaked to be able to emit
> > function code to different text sections and a massive system wide code
> > triage was undertaken based on "common usage scenario" profiling run data
> > from the perf analysis group.
> 
>   Linux scheduler code is in its own text section already, but
> that might be for profiling the code instead of for performance.
> (Look for "__sched" in the source code.)
> 
>   The gains may not be as much as you think since on X86 and at least
> some other archs the entire kernel is in one large page.  Still, it's
> got to make some kind of sense to put infrequently-used code in its
> own section just to reduce cache pollution.
> 
>   I came up with this

Nice.

> but only the "__slow" part really makes sense:

80/20 rule says that 80% of code runs 20% of time,
thus we need only __fast. Everything else will be by default __slow.
(IOW: normal .text section is __slow, no need to add another one).

If gcc will someday get per-function support for using -O2 / -Os
like optimizations, they could be added to the __fast macro.

> --- 2.6.12.1/arch/i386/kernel/vmlinux.lds.S     2004-09-03 19:55:27.000000000 -0400
> +++ 2.6.12.1-ce1/arch/i386/kernel/vmlinux.lds.S 2005-06-26 01:48:23.770212000 -0400
> @@ -16,9 +16,11 @@ SECTIONS
>    /* read-only */
>    _text = .;                   /* Text and read-only data */
>    .text : {
> +       *(.fast.text)
>         *(.text)
>         SCHED_TEXT
>         LOCK_TEXT
> +       *(.slow.text)
>         *(.fixup)
>         *(.gnu.warning)
>         } = 0x9090
> --- 2.6.12.1/arch/x86_64/kernel/vmlinux.lds.S   2005-06-24 00:50:21.180212000 -0400
> +++ 2.6.12.1-ce1/arch/x86_64/kernel/vmlinux.lds.S       2005-06-26 01:50:09.100212000 -0400
> @@ -15,9 +15,11 @@ SECTIONS
>    phys_startup_64 = startup_64 - LOAD_OFFSET;
>    _text = .;                   /* Text and read-only data */
>    .text : {
> +       *(.fast.text)
>         *(.text)
>         SCHED_TEXT
>         LOCK_TEXT
> +       *(.slow.text)
>         *(.fixup)
>         *(.gnu.warning)
>         } = 0x9090
> --- 2.6.12.1/include/linux/init.h       2005-01-04 21:48:02.000000000 -0500
> +++ 2.6.12.1-ce1/include/linux/init.h   2005-06-26 01:59:29.580212000 -0400
> @@ -46,6 +46,17 @@
>  #define __exitdata     __attribute__ ((__section__(".exit.data")))
>  #define __exit_call    __attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
>  
> +/*
> + * Probably belongs in some other header (compiler.h?)
> + */
> +#ifdef CONFIG_X86
> +#define __fast         __attribute__ ((__section__(".fast.text")))
> +#define __slow         __attribute__ ((__section__(".slow.text")))
> +#else
> +#define __fast
> +#define __slow
> +#endif
> +
>  #ifdef MODULE
>  #define __exit         __attribute__ ((__section__(".exit.text")))
>  #else
--
vda

