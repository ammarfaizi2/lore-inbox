Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWAGMAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWAGMAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWAGMAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:00:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51463 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030419AbWAGMAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:00:20 -0500
Date: Sat, 7 Jan 2006 13:00:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
Message-ID: <20060107120003.GA17957@mars.ravnborg.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136543914.2940.11.camel@laptopd505.fenrus.org> <20060107010757.2e853f77.akpm@osdl.org> <20060107100356.GA15664@mars.ravnborg.org> <20060107021310.6153e9b5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107021310.6153e9b5.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 02:13:10AM -0800, Andrew Morton wrote:
> 
> Only sparc64 appears to do that now.  If someone wants to reintroduce such
> a dopey thing then they need to remember to reevaluate GCC_VERSION
> afterwards?  Like:

Dropping GCC_VERSION is cleaner. In a few cases we do one extra call to
gcc during first phase of compilation. That does not matter.
Like this:

 Documentation/kbuild/makefiles.txt |    4 ++--
 arch/i386/Makefile                 |    4 ++--
 arch/ia64/Makefile                 |    5 ++---
 arch/powerpc/Makefile              |    6 ++----
 arch/ppc/Makefile                  |    3 +--
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index d802ce8..443230b 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -1033,9 +1033,9 @@ When kbuild executes the following steps
 
 	Example:
 		#arch/i386/Makefile
-		GCC_VERSION := $(call cc-version)
 		cflags-y += $(shell \
-		if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
+		if [ $(call cc-version) -ge 0300 ] ; then \
+			echo "-mregparm=3"; fi ;)
 
 	In the above example -mregparm=3 is only used for gcc version greater
 	than or equal to gcc 3.0.
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index d121ea1..76fcf7c 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -39,8 +39,8 @@ include $(srctree)/arch/i386/Makefile.cp
 
 # -mregparm=3 works ok on gcc-3.0 and later
 #
-GCC_VERSION			:= $(call cc-version)
-cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
+cflags-$(CONFIG_REGPARM) += $(shell if [ $(call cc-version) -ge 0300 ] ; then \
+                                    echo "-mregparm=3"; fi ;)
 
 # Disable unit-at-a-time mode, it makes gcc use a lot more stack
 # due to the lack of sharing of stacklots.
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 67932ad..88a134e 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -25,7 +25,6 @@ cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -
 		   -falign-functions=32 -frename-registers -fno-optimize-sibling-calls
 CFLAGS_KERNEL	:= -mconstant-gp
 
-GCC_VERSION     := $(call cc-version)
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
 CPPFLAGS += $(shell $(srctree)/arch/ia64/scripts/toolchain-flags "$(CC)" "$(OBJDUMP)" "$(READELF)")
 
@@ -37,11 +36,11 @@ $(error Sorry, you need a newer version 
 		ftp://ftp.hpl.hp.com/pub/linux-ia64/gas-030124.tar.gz)
 endif
 
-ifneq ($(shell if [ $(GCC_VERSION) -lt 0300 ] ; then echo "bad"; fi ;),)
+ifneq ($(shell if [ $(call cc-version) -lt 0300 ] ; then echo "bad"; fi ;),)
 $(error Sorry, your compiler is too old.  GCC v2.96 is known to generate bad code.)
 endif
 
-ifeq ($(GCC_VERSION),0304)
+ifeq ($(call cc-version),0304)
 	cflags-$(CONFIG_ITANIUM)	+= -mtune=merced
 	cflags-$(CONFIG_MCKINLEY)	+= -mtune=mckinley
 endif
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a13eb57..b98f11b 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -76,8 +76,7 @@ LINUXINCLUDE    += $(LINUXINCLUDE-y)
 CHECKFLAGS	+= -m$(SZ) -D__powerpc__ -D__powerpc$(SZ)__
 
 ifeq ($(CONFIG_PPC64),y)
-GCC_VERSION     := $(call cc-version)
-GCC_BROKEN_VEC	:= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "y"; fi)
+GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi)
 
 ifeq ($(CONFIG_POWER4_ONLY),y)
 ifeq ($(CONFIG_ALTIVEC),y)
@@ -189,10 +188,9 @@ TOUT	:= .tmp_gas_check
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
 # instructions.
 # gcc-3.4 and binutils-2.14 are a fatal combination.
-GCC_VERSION	:= $(call cc-version)
 
 checkbin:
-	@if test "$(GCC_VERSION)" = "0304" ; then \
+	@if test "$(call cc-version)" = "0304" ; then \
 		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
 			echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '; \
 			echo 'correctly with gcc-3.4 and your version of binutils.'; \
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index e719a49..98e940b 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -128,10 +128,9 @@ TOUT	:= .tmp_gas_check
 # Ensure this is binutils 2.12.1 (or 2.12.90.0.7) or later for altivec
 # instructions.
 # gcc-3.4 and binutils-2.14 are a fatal combination.
-GCC_VERSION	:= $(call cc-version)
 
 checkbin:
-	@if test "$(GCC_VERSION)" = "0304" ; then \
+	@if test "$(call cc-version)" = "0304" ; then \
 		if ! /bin/echo mftb 5 | $(AS) -v -mppc -many -o $(TOUT) >/dev/null 2>&1 ; then \
 			echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build '; \
 			echo 'correctly with gcc-3.4 and your version of binutils.'; \
