Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWJMULe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWJMULe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWJMULe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:11:34 -0400
Received: from [198.99.130.12] ([198.99.130.12]:25525 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751847AbWJMULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:11:32 -0400
Date: Fri, 13 Oct 2006 16:10:10 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 01/14] uml: fix compilation options for USER_OBJS
Message-ID: <20061013201010.GC5517@ccure.user-mode-linux.org>
References: <20061009163208.GA4931@ccure.user-mode-linux.org> <20061011110828.43576.qmail@web25221.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011110828.43576.qmail@web25221.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 01:08:27PM +0200, Paolo Giarrusso wrote:
> Ok, at a first glance this alternative solution is ok. Make sure (run
> gdb on an userspace object file and saying list <function>) that it
> works and we'll be ok.

After discovering that the original patch broke UML/i386 and broke the
UML/x86_64 build, I now have the patch below.

Listing userspace functions is fine.

				Jeff


Index: linux-2.6.18-mm/arch/um/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile	2006-10-13 10:20:51.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile	2006-10-13 10:21:50.000000000 -0400
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
@@ -74,15 +79,11 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
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
 
Index: linux-2.6.18-mm/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile-x86_64	2006-10-13 10:20:51.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile-x86_64	2006-10-13 10:21:50.000000000 -0400
@@ -8,8 +8,8 @@ _extra_flags_ = -fno-builtin -m64
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ $(_extra_flags_)
-USER_CFLAGS += $(_extra_flags_)
+ARCH_KERNEL_DEFINES = -U__$(SUBARCH)__
+CFLAGS += $(_extra_flags_)
 
 CHECKFLAGS  += -m64
 AFLAGS += -m64
Index: linux-2.6.18-mm/arch/um/Makefile-i386
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile-i386	2006-10-10 09:10:21.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile-i386	2006-10-13 10:28:43.000000000 -0400
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
@@ -38,4 +37,3 @@ cflags-y += $(call cc-option,-mpreferred
 cflags-y += -ffreestanding
 
 CFLAGS += $(cflags-y)
-USER_CFLAGS += $(cflags-y)
