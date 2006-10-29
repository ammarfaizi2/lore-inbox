Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWJ2SeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWJ2SeL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 13:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWJ2SeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 13:34:11 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:43089 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932388AbWJ2SeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 13:34:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=Evqk5k9XfRQ+s0MIzsySY5sKDxawYM0D4jgu3U1PjkiGTQ5ZunuzOzKDh2ic1v/o+ROoaCS7nyQkJV93HmOqUhkGi3/BXFt6h3KMjIdU2v7nsJG518eU+g+YFa19imEzZHKfp2Tbjk3AVs7LBsXeepSq50F0QHTSDv/+WJho3yQ=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] uml: fix compilation options for USER_OBJS
Date: Sun, 29 Oct 2006 19:34:09 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029183409.31657.10144.stgit@americanbeauty.home.lan>
In-Reply-To: <20061029183405.31657.44335.stgit@americanbeauty.home.lan>
References: <20061029183405.31657.44335.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <blaisorblade@yahoo.it>

Make sure that when compiling USER_OBJS the correct compilation options are
passed; since they are compiled with USER_CFLAGS which is derived from CFLAGS,
make sure it is a recursively evaluated variable, so that changes to CFLAGS done
afterwards the inclusion of arch/$(ARCH)/Makefile are reflected in USER_CFLAGS.

For instance, without this patch userspace objects are never compiled with debug
info active.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile        |   21 +++++++++++----------
 arch/um/Makefile-i386   |    4 +---
 arch/um/Makefile-x86_64 |    4 ++--
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index c8016a9..5d5ed72 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -64,9 +64,14 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
-USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
+USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -D__KERNEL__,,\
+	$(patsubst -I%,,$(CFLAGS)))) $(ARCH_INCLUDE) $(MODE_INCLUDE) \
+	-D_FILE_OFFSET_BITS=64
+
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+
+#This will adjust *FLAGS accordingly to the platform.
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
@@ -74,15 +79,11 @@ # in CFLAGS.  Otherwise, it would cause
 # errnos.
 # These apply to kernelspace only.
 
-CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
-	-Dmktime=kernel_mktime
+KERNEL_DEFINES = -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
+	-Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES)
+CFLAGS += $(KERNEL_DEFINES)
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
-include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
-
-#This will adjust *FLAGS accordingly to the platform.
-include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
-
 # These are needed for clean and mrproper, since in that case .config is not
 # included; the values here are meaningless
 
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index b65ca11..c9f1c5b 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -16,7 +16,6 @@ OBJCOPYFLAGS  		:= -O binary -R .note -R
 ifeq ("$(origin SUBARCH)", "command line")
 ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
 CFLAGS			+= $(call cc-option,-m32)
-USER_CFLAGS		+= $(call cc-option,-m32)
 AFLAGS			+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)
@@ -25,7 +24,7 @@ export LDFLAGS HOSTCFLAGS HOSTLDFLAGS UM
 endif
 endif
 
-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
+ARCH_KERNEL_DEFINES += -U__$(SUBARCH)__ -U$(SUBARCH)
 
 # First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
 include $(srctree)/arch/i386/Makefile.cpu
@@ -38,4 +37,3 @@ # an unresolved reference.
 cflags-y += -ffreestanding
 
 CFLAGS += $(cflags-y)
-USER_CFLAGS += $(cflags-y)
diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index d278682..69ecea6 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -8,8 +8,8 @@ _extra_flags_ = -fno-builtin -m64
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ $(_extra_flags_)
-USER_CFLAGS += $(_extra_flags_)
+ARCH_KERNEL_DEFINES = -U__$(SUBARCH)__
+CFLAGS += $(_extra_flags_)
 
 CHECKFLAGS  += -m64
 AFLAGS += -m64
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
