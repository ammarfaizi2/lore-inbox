Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUAOJVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 04:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUAOJVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 04:21:37 -0500
Received: from colin2.muc.de ([193.149.48.15]:21004 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266502AbUAOJVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 04:21:21 -0500
Date: 15 Jan 2004 10:22:19 +0100
Date: Thu, 15 Jan 2004 10:22:19 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040115092219.GA70884@colin2.muc.de>
References: <20040114090603.GA1935@averell> <20040115114011.204da83f.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115114011.204da83f.rusty@rustcorp.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 11:40:11AM +1100, Rusty Russell wrote:
> On Wed, 14 Jan 2004 10:06:03 +0100
> Andi Kleen <ak@muc.de> wrote:
> > I didn't make it the default because it will break all binary only
> > modules (although they can be fixed by adding a wrapper that 
> > calls them with "asmlinkage"). Actually it may be a good idea to 
> > make this default with 2.7.1 or somesuch.
> 
> Who cares.  Anyway, if kept as a config option, this should probably be
> added to MODULE_ARCH_VERMAGIC in include/asm-i386/module.h.

Ok. Good point.

On second thought I'm actually not opposed to make it the default,
but Linus/Andrew have to decide if they want this. It certainly
would be a good strategy longer term (even though it would eliminate
some of the advantages x86-64 currently enjoys over i386 ;-)

New patch appended.

-Andi

----------------------------------------

Add CONFIG_REGPARM option to enable compilation with -mregparm=3.
This shrinks the kernel .text considerably. 

This could be made default later when it has been more tested.


diff -u linux-34/arch/i386/Kconfig-o linux-34/arch/i386/Kconfig
--- linux-34/arch/i386/Kconfig-o	2004-01-09 09:27:09.000000000 +0100
+++ linux-34/arch/i386/Kconfig	2004-01-14 08:43:29.000000000 +0100
@@ -820,6 +820,14 @@
 	depends on (((X86_SUMMIT || X86_GENERICARCH) && NUMA) || (X86 && EFI))
 	default y
 
+config REGPARM
+	bool "Use register arguments (EXPERIMENTAL)"
+	default n
+	help
+	Compile the kernel with -mregparm=3. This uses an different ABI
+	and passes the first three arguments of a function call in registers.
+	This will probably break binary only modules.	
+	
 endmenu
 
 
diff -u linux-34/arch/i386/Makefile-o linux-34/arch/i386/Makefile
--- linux-34/arch/i386/Makefile-o	2003-09-28 10:53:14.000000000 +0200
+++ linux-34/arch/i386/Makefile	2004-01-13 20:16:32.000000000 +0100
@@ -47,6 +47,8 @@
 cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486) $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
 cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)
 
+cflags-$(CONFIG_REGPARM) 	+= -mregparm=3
+
 CFLAGS += $(cflags-y)
 
 # Default subarch .c files
diff -u linux-34/include/asm-i386/module.h-o linux-34/include/asm-i386/module.h
--- linux-34/include/asm-i386/module.h-o	2003-05-27 03:00:24.000000000 +0200
+++ linux-34/include/asm-i386/module.h	2004-01-15 10:15:15.686788608 +0100
@@ -52,6 +52,12 @@
 #error unknown processor family
 #endif
 
-#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
+#ifdef CONFIG_REGPARM
+#define MODULE_REGPARM "REGPARM "
+#else
+#define MODULE_REGPARM "" 
+#endif
+
+#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM
 
 #endif /* _ASM_I386_MODULE_H */



