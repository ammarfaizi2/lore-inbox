Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWAIVlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWAIVlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWAIVix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:38:53 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:528 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750737AbWAIViv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:51 -0500
Subject: [PATCH 07/11] kbuild: remove GCC_VERSION
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:34 +0100
Message-Id: <11368427143913@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was causing some ordering problems.  Remove the up-front evaluation
and just revaluate the compiler version each time we need it.

(The up-front evaluation was problematic because some architectures modify
the value of $(CC)).

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/kbuild/makefiles.txt |    4 ++--
 arch/i386/Makefile                 |    4 ++--
 arch/ia64/Makefile                 |    7 +------
 arch/powerpc/Makefile              |    6 ++----
 arch/ppc/Makefile                  |    3 +--
 5 files changed, 8 insertions(+), 16 deletions(-)

ad14336de8e9cddae9ed29d45bd2e97abb72eaf9
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
index d121ea1..8f6b90e 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -39,8 +39,8 @@ include $(srctree)/arch/i386/Makefile.cp
 
 # -mregparm=3 works ok on gcc-3.0 and later
 #
-GCC_VERSION			:= $(call cc-version)
-cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)
+cflags-$(CONFIG_REGPARM) += $(shell if [ $(call cc-version) -ge 0300 ] ; then \
+                            echo "-mregparm=3"; fi ;)
 
 # Disable unit-at-a-time mode, it makes gcc use a lot more stack
 # due to the lack of sharing of stacklots.
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 67932ad..f722e1a 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -25,7 +25,6 @@ cflags-y	:= -pipe $(EXTRA) -ffixed-r13 -
 		   -falign-functions=32 -frename-registers -fno-optimize-sibling-calls
 CFLAGS_KERNEL	:= -mconstant-gp
 
-GCC_VERSION     := $(call cc-version)
 GAS_STATUS	= $(shell $(srctree)/arch/ia64/scripts/check-gas "$(CC)" "$(OBJDUMP)")
 CPPFLAGS += $(shell $(srctree)/arch/ia64/scripts/toolchain-flags "$(CC)" "$(OBJDUMP)" "$(READELF)")
 
@@ -37,11 +36,7 @@ $(error Sorry, you need a newer version 
 		ftp://ftp.hpl.hp.com/pub/linux-ia64/gas-030124.tar.gz)
 endif
 
-ifneq ($(shell if [ $(GCC_VERSION) -lt 0300 ] ; then echo "bad"; fi ;),)
-$(error Sorry, your compiler is too old.  GCC v2.96 is known to generate bad code.)
-endif
-
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
-- 
1.0.GIT

