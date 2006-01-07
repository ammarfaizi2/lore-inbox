Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWAGJIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWAGJIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 04:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWAGJIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 04:08:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030368AbWAGJIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 04:08:19 -0500
Date: Sat, 7 Jan 2006 01:07:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
Message-Id: <20060107010757.2e853f77.akpm@osdl.org>
In-Reply-To: <1136543914.2940.11.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<1136543914.2940.11.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> allow gcc4 compilers to optimize unit-at-a-time. 
> 
>  This flag enables gcc to "see" the entire C file before making optimisation
>  decisions such as inline, which results in gcc making better decisions. One
>  of the immediate effects of this is that static functions that are used only
>  once now get inlined.
> 
>  gcc 3.4 has this flag as well, however gcc 3.x have a problem with inlining
>  and stacks and as a result, enabling this flag there would cause excessive
>  and unacceptable stack use. This problem is fixed in the gcc 4.x series. 
>  The x86-64 architecture already enables this feature so it's well tested 
>  already.

bix:/usr/src/25> make vmlinux
/bin/sh: line 1: [: -lt: unary operator expected

Because GCC_VERSION hasn't been initialised at this stage.

<wonders about the testing status of this one>

Is there any reason why we can't do this?


From: Andrew Morton <akpm@osdl.org>

Set GCC_VERSION up-front rather than in arch Makefiles.  This reduces ordering
problems and generally consolidates things.

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Makefile              |    2 +-
 arch/ia64/Makefile    |    1 -
 arch/parisc/Makefile  |    4 ----
 arch/powerpc/Makefile |    2 --
 arch/ppc/Makefile     |    1 -
 5 files changed, 1 insertion(+), 9 deletions(-)

diff -puN arch/ia64/Makefile~kbuild-call-gcc_version-earlier arch/ia64/Makefile
--- devel/arch/ia64/Makefile~kbuild-call-gcc_version-earlier	2006-01-07 01:05:39.000000000 -0800
+++ devel-akpm/arch/ia64/Makefile	2006-01-07 01:05:39.000000000 -0800
@@ -25,7 +25,6 @@ cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -
 		   -falign-functions=32 -frename-registers -fno-optimize-sibling-calls
 CFLAGS_KERNEL	:= -mconstant-gp
 
-GCC_VERSION     := $(call cc-version)
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
 CPPFLAGS += $(shell $(srctree)/arch/ia64/scripts/toolchain-flags "$(CC)" "$(OBJDUMP)" "$(READELF)")
 
diff -puN arch/parisc/Makefile~kbuild-call-gcc_version-earlier arch/parisc/Makefile
--- devel/arch/parisc/Makefile~kbuild-call-gcc_version-earlier	2006-01-07 01:05:39.000000000 -0800
+++ devel-akpm/arch/parisc/Makefile	2006-01-07 01:05:39.000000000 -0800
@@ -35,10 +35,6 @@ FINAL_LD=$(CROSS_COMPILE)ld --warn-commo
 
 OBJCOPY_FLAGS =-O binary -R .note -R .comment -S
 
-GCC_VERSION     := $(call cc-version)
-ifneq ($(shell if [ -z $(GCC_VERSION) ] ; then echo "bad"; fi ;),)
-$(error Sorry, couldn't find ($(cc-version)).)
-endif
 ifneq ($(shell if [ $(GCC_VERSION) -lt 0303 ] ; then echo "bad"; fi ;),)
 $(error Sorry, your compiler is too old ($(GCC_VERSION)).  GCC v3.3 or above is required.)
 endif
diff -puN arch/powerpc/Makefile~kbuild-call-gcc_version-earlier arch/powerpc/Makefile
--- devel/arch/powerpc/Makefile~kbuild-call-gcc_version-earlier	2006-01-07 01:05:39.000000000 -0800
+++ devel-akpm/arch/powerpc/Makefile	2006-01-07 01:05:39.000000000 -0800
@@ -76,7 +76,6 @@ LINUXINCLUDE    += $(LINUXINCLUDE-y)
 CHECKFLAGS	+= -m$(SZ) -D__powerpc__ -D__powerpc$(SZ)__
 
 ifeq ($(CONFIG_PPC64),y)
-GCC_VERSION     := $(call cc-version)
 GCC_BROKEN_VEC	:= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "y"; fi)
 
 ifeq ($(CONFIG_POWER4_ONLY),y)
@@ -189,7 +188,6 @@ TOUT	:= .tmp_gas_check
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
 # instructions.
 # gcc-3.4 and binutils-2.14 are a fatal combination.
-GCC_VERSION	:= $(call cc-version)
 
 checkbin:
 	@if test "$(GCC_VERSION)" = "0304" ; then \
diff -puN arch/ppc/Makefile~kbuild-call-gcc_version-earlier arch/ppc/Makefile
--- devel/arch/ppc/Makefile~kbuild-call-gcc_version-earlier	2006-01-07 01:05:39.000000000 -0800
+++ devel-akpm/arch/ppc/Makefile	2006-01-07 01:05:39.000000000 -0800
@@ -128,7 +128,6 @@ TOUT	:= .tmp_gas_check
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
 # instructions.
 # gcc-3.4 and binutils-2.14 are a fatal combination.
-GCC_VERSION	:= $(call cc-version)
 
 checkbin:
 	@if test "$(GCC_VERSION)" = "0304" ; then \
diff -puN Makefile~kbuild-call-gcc_version-earlier Makefile
--- Makefile~kbuild-call-gcc_version-earlier	2006-01-07 01:05:39.000000000 -0800
+++ devel-akpm/Makefile	2006-01-07 01:05:39.000000000 -0800
@@ -300,7 +300,7 @@ cc-option-align = $(subst -functions=0,,
 # Usage gcc-ver := $(call cc-version $(CC))
 cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
               $(if $(1), $(1), $(CC)))
-
+GCC_VERSION	:= $(call cc-version)
 
 # Look for make include files relative to root of kernel src
 MAKEFLAGS += --include-dir=$(srctree)
_

