Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSCUFFW>; Thu, 21 Mar 2002 00:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCUFFN>; Thu, 21 Mar 2002 00:05:13 -0500
Received: from rj.SGI.COM ([204.94.215.100]:54496 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293306AbSCUFE4>;
	Thu, 21 Mar 2002 00:04:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: hirao <hirao@estartu.open.nm.fujitsu.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] enhance kernel profiling to loadable modules 
In-Reply-To: Your message of "Wed, 20 Mar 2002 17:04:08 +0900."
             <20020320165324.E98F.HIRAO@estartu.open.nm.fujitsu.co.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Mar 2002 16:02:48 +1100
Message-ID: <2761.1016686968@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002 17:04:08 +0900, 
hirao <hirao@estartu.open.nm.fujitsu.co.jp> wrote:
>These are a kernel patch I wrote to enhance kernel profiling to loadable modules and
>a patch which adds a new command READPROFILE to util-linux.
>diff -Naur linux-2.4.18/kernel/module.c linux-2.4.18new/kernel/module.c
>--- linux-2.4.18/kernel/module.c	Mon Nov 12 04:23:14 2001
>+++ linux-2.4.18new/kernel/module.c	Mon Mar 18 11:31:24 2002
>@@ -10,6 +10,7 @@
> #include <linux/slab.h>
> #include <linux/kmod.h>
> #include <linux/seq_file.h>
>+#include <linux/profile.h>
> 
> /*
>  * Originally by Anonymous (as far as I know...)
>@@ -530,6 +531,13 @@
> 		}
> 	}
> 
>+#ifdef CONFIG_MODULE_PROFILE
>+	if (create_module_profile(mod)) {
>+		printk(KERN_WARNING "init_module: creation of module "
>+			"profiling buffer failed for module(%s).\n", mod->name);
>+	}
>+#endif

Instead of patching kernel/module.c and maintaining a separate list of
module related profiling data, use the kernel_data field in struct
module.  I added that field specificially so to track any kernel data
that relates to each module.

Change the module_arch_init() and free_module() functions in
include/asm-i386/module.h to allocate and free the kernel_data
structure during module load and unload.  Take the profile lock in
those routines (disabling interrupts) when you update kernel_data.

To map a profile eip to a module, run the module list looking for the
address, see kernel_text_address() in arch/i386/kernel/traps.c for
example code.

With this approach, the mainline module code is unchanged, all arch
specific profile code is in include/asm-$(ARCH)/module.h.

Your srch_prof_buffer() algorithm is ix86 specific, you assume that
modules are always above the end of the kernel.  That is not true on
all architectures.  The correct method is to treat the kernel as just
another module and store the profile data for the kernel in
kernel_module.kernel_data, using arch_init_modules().  Running the
module list (which includes the kernel itself) will find the correct
address range in an architecture portable way.  Add one extra slot to
the kernel profile table for out of range addresses.

