Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUBMVIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267217AbUBMVIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:08:05 -0500
Received: from intra.cyclades.com ([64.186.161.6]:42438 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S267214AbUBMVHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:07:09 -0500
Date: Fri, 13 Feb 2004 18:50:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4: Problems with dead code/data with gcc 3.4
In-Reply-To: <Pine.LNX.4.55.0402121613510.22119@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58L.0402131848050.6713@logos.cnet>
References: <Pine.LNX.4.55.0402121613510.22119@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Maciej W. Rozycki wrote:

> Hello,
>
>  After upgrading gcc to 3.4 I've discovered the compiler is now more
> serious about discarding dead code or data.  As a result parts of the
> kernel that appear unused, such as the ".setup.init" or ".modinfo"
> sections, get removed, and the "unused" attribute only masks the problem
> by quieting warnings.  However, gcc currently provides another attribute,
> "used", that instead of removing warnings, actually tells the compiler
> that whatever it's attached to is indeed used, perhaps in a way that
> cannot be observed by the compiler.  There's code in init/main.c that
> assumes a non-empty ".setup.init" section and failing that leads to
> unpredictable behavior (it just hangs for me on a MIPSel/Linux box).
>
>  Here's a patch that makes the kernel work for me for i386/Linux.  It's
> based on similar changes that are already present in 2.6 and leaves the
> setup as is for gcc versions before 3.3 and using the new attribute for
> newer versions, by defining an "__attribute_used__" macro appropriately.
>
>  Marcelo, would consider such a change for past 2.4.25?
>
>  Ralf, for MIPS/Linux the change is insufficient -- due to fragile
> constructs in arch/mips/kernel/syscall.c some code is removed, but using
> the "used" attribute does not help.  While the code is back again, it's
> reordered compared to what's emitted by older compilers and it's enough to
> stop it working.  I'm currently investigating a solution, or have you
> perhaps looked at the problem already?  It's there for 2.6 as well.

Hi Maciej,

For me your patch looks alright to be included in 2.4.26-pre.

Please resend me it when .26 gets started.

Thanks!

> patch-2.4.24-gcc3-0.1
> diff -up --recursive --new-file linux-2.4.24.macro/include/linux/compiler.h linux-2.4.24/include/linux/compiler.h
> --- linux-2.4.24.macro/include/linux/compiler.h	2001-09-18 14:12:45.000000000 +0000
> +++ linux-2.4.24/include/linux/compiler.h	2004-02-12 14:57:06.000000000 +0000
> @@ -13,4 +13,10 @@
>  #define likely(x)	__builtin_expect((x),1)
>  #define unlikely(x)	__builtin_expect((x),0)
>
> +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
> +#define __attribute_used__	__attribute__((__used__))
> +#else
> +#define __attribute_used__	__attribute__((__unused__))
> +#endif
> +
>  #endif /* __LINUX_COMPILER_H */
> diff -up --recursive --new-file linux-2.4.24.macro/include/linux/init.h linux-2.4.24/include/linux/init.h
> --- linux-2.4.24.macro/include/linux/init.h	2004-02-12 12:48:26.000000000 +0000
> +++ linux-2.4.24/include/linux/init.h	2004-02-12 14:57:06.000000000 +0000
> @@ -2,6 +2,7 @@
>  #define _LINUX_INIT_H
>
>  #include <linux/config.h>
> +#include <linux/compiler.h>
>
>  /* These macros are used to mark some functions or
>   * initialized data (doesn't apply to uninitialized data)
> @@ -67,7 +68,7 @@ extern struct kernel_param __setup_start
>
>  #define __setup(str, fn)								\
>  	static char __setup_str_##fn[] __initdata = str;				\
> -	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
> +	static struct kernel_param __setup_##fn __attribute_used__ __initsetup = { __setup_str_##fn, fn }
>
>  #endif /* __ASSEMBLY__ */
>
> @@ -76,12 +77,12 @@ extern struct kernel_param __setup_start
>   * or exit time.
>   */
>  #define __init		__attribute__ ((__section__ (".text.init")))
> -#define __exit		__attribute__ ((unused, __section__(".text.exit")))
> +#define __exit		__attribute_used__ __attribute__ ((__section__ (".text.exit")))
>  #define __initdata	__attribute__ ((__section__ (".data.init")))
> -#define __exitdata	__attribute__ ((unused, __section__ (".data.exit")))
> -#define __initsetup	__attribute__ ((unused,__section__ (".setup.init")))
> -#define __init_call	__attribute__ ((unused,__section__ (".initcall.init")))
> -#define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
> +#define __exitdata	__attribute_used__ __attribute__ ((__section__ (".data.exit")))
> +#define __initsetup	__attribute_used__ __attribute__ ((__section__ (".setup.init")))
> +#define __init_call	__attribute_used__ __attribute__ ((__section__ (".initcall.init")))
> +#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
>
>  /* For assembly routines */
>  #define __INIT		.section	".text.init","ax"
> diff -up --recursive --new-file linux-2.4.24.macro/include/linux/module.h linux-2.4.24/include/linux/module.h
> --- linux-2.4.24.macro/include/linux/module.h	2004-02-12 13:12:17.000000000 +0000
> +++ linux-2.4.24/include/linux/module.h	2004-02-12 15:08:00.000000000 +0000
> @@ -8,6 +8,7 @@
>  #define _LINUX_MODULE_H
>
>  #include <linux/config.h>
> +#include <linux/compiler.h>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
>
> @@ -202,19 +203,22 @@ extern int try_inc_mod_count(struct modu
>
>  /* For documentation purposes only.  */
>
> -#define MODULE_AUTHOR(name)						   \
> -const char __module_author[] __attribute__((section(".modinfo"))) = 	   \
> -"author=" name
> -
> -#define MODULE_DESCRIPTION(desc)					   \
> -const char __module_description[] __attribute__((section(".modinfo"))) =   \
> -"description=" desc
> +#define MODULE_AUTHOR(name)						\
> +const char __module_author[]						\
> +  __attribute_used__							\
> +  __attribute__((section(".modinfo"))) = "author=" name
> +
> +#define MODULE_DESCRIPTION(desc)					\
> +const char __module_description[]					\
> +  __attribute_used__							\
> +  __attribute__((section(".modinfo"))) = "description=" desc
>
>  /* Could potentially be used by kmod...  */
>
> -#define MODULE_SUPPORTED_DEVICE(dev)					   \
> -const char __module_device[] __attribute__((section(".modinfo"))) = 	   \
> -"device=" dev
> +#define MODULE_SUPPORTED_DEVICE(dev)					\
> +const char __module_device[]						\
> +  __attribute_used__							\
> +  __attribute__((section(".modinfo"))) = "device=" dev
>
>  /* Used to verify parameters given to the module.  The TYPE arg should
>     be a string in the following format:
> @@ -229,15 +233,17 @@ const char __module_device[] __attribute
>  	s	string
>  */
>
> -#define MODULE_PARM(var,type)			\
> -const char __module_parm_##var[]		\
> -__attribute__((section(".modinfo"))) =		\
> -"parm_" __MODULE_STRING(var) "=" type
> -
> -#define MODULE_PARM_DESC(var,desc)		\
> -const char __module_parm_desc_##var[]		\
> -__attribute__((section(".modinfo"))) =		\
> -"parm_desc_" __MODULE_STRING(var) "=" desc
> +#define MODULE_PARM(var,type)						\
> +const char __module_parm_##var[]					\
> +  __attribute_used__							\
> +  __attribute__((section(".modinfo"))) =				\
> +  "parm_" __MODULE_STRING(var) "=" type
> +
> +#define MODULE_PARM_DESC(var,desc)					\
> +const char __module_parm_desc_##var[]					\
> +  __attribute_used__							\
> +  __attribute__((section(".modinfo"))) =				\
> +  "parm_desc_" __MODULE_STRING(var) "=" desc
>
>  /*
>   * MODULE_DEVICE_TABLE exports information about devices
> @@ -283,9 +289,10 @@ static const struct gtype##_id * __modul
>   * 3.	So vendors can do likewise based on their own policies
>   */
>
> -#define MODULE_LICENSE(license) 	\
> -static const char __module_license[] __attribute__((section(".modinfo"))) =   \
> -"license=" license
> +#define MODULE_LICENSE(license) 					\
> +static const char __module_license[]					\
> +  __attribute_used__							\
> +  __attribute__((section(".modinfo"))) = "license=" license
>
>  /* Define the module variable, and usage macros.  */
>  extern struct module __this_module;
> @@ -296,11 +303,11 @@ extern struct module __this_module;
>  #define MOD_IN_USE		__MOD_IN_USE(THIS_MODULE)
>
>  #include <linux/version.h>
> -static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
> -"kernel_version=" UTS_RELEASE;
> +static const char __module_kernel_version[] __attribute_used__
> +	__attribute__((section(".modinfo"))) = "kernel_version=" UTS_RELEASE;
>  #ifdef MODVERSIONS
> -static const char __module_using_checksums[] __attribute__((section(".modinfo"))) =
> -"using_checksums=1";
> +static const char __module_using_checksums[] __attribute_used__
> +	__attribute__((section(".modinfo"))) = "using_checksums=1";
>  #endif
>
>  #else /* MODULE */
