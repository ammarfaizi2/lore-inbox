Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269368AbUHZTif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269368AbUHZTif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUHZTid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:38:33 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:22534 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269368AbUHZThG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:37:06 -0400
Date: Thu, 26 Aug 2004 21:38:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: use *.lds infrastructure in arch/i386/kernel/Makefile
Message-ID: <20040826193805.GD9539@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040826193614.GB9539@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826193614.GB9539@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/26 21:20:43+02:00 sam@mars.ravnborg.org 
#   kbuild: use *.lds infrastructure in arch/i386/kernel
#   
#   Rusty decided to preprocess a *.lds.S file in parallele with the new *.lds infrastructure
#   being added to kbuild. Fix that up.
#   Also added the file to targets so we do not see recompile each time the kernel is build.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# arch/i386/kernel/Makefile
#   2004/08/26 21:20:27+02:00 sam@mars.ravnborg.org +4 -3
#   Use new infrastructure for .lds files.
#   Rusty decided to preporocess a .lds file in parallel
#   with the new infrastructure being added.
# 
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2004-08-26 21:21:27 +02:00
+++ b/arch/i386/kernel/Makefile	2004-08-26 21:21:27 +02:00
@@ -41,20 +41,21 @@
 # Note: kbuild does not track this dependency due to usage of .incbin
 $(obj)/vsyscall.o: $(obj)/vsyscall-int80.so $(obj)/vsyscall-sysenter.so
 targets += $(foreach F,int80 sysenter,vsyscall-$F.o vsyscall-$F.so)
+targets += vsyscall.lds
 
 # The DSO images are built using a special linker script.
 quiet_cmd_syscall = SYSCALL $@
       cmd_syscall = $(CC) -nostdlib $(SYSCFLAGS_$(@F)) \
 		          -Wl,-T,$(filter-out FORCE,$^) -o $@
 
-export AFLAGS_vsyscall.lds.o += -P -C -U$(ARCH)
+export CPPFLAGS_vsyscall.lds += -P -C -U$(ARCH)
 
 vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1
 SYSCFLAGS_vsyscall-sysenter.so	= $(vsyscall-flags)
 SYSCFLAGS_vsyscall-int80.so	= $(vsyscall-flags)
 
 $(obj)/vsyscall-int80.so $(obj)/vsyscall-sysenter.so: \
-$(obj)/vsyscall-%.so: $(src)/vsyscall.lds.s $(obj)/vsyscall-%.o FORCE
+$(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
 	$(call if_changed,syscall)
 
 # We also create a special relocatable object that should mirror the symbol
@@ -65,5 +66,5 @@
 $(obj)/built-in.o: ld_flags += -R $(obj)/vsyscall-syms.o
 
 SYSCFLAGS_vsyscall-syms.o = -r
-$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds.s $(obj)/vsyscall-sysenter.o FORCE
+$(obj)/vsyscall-syms.o: $(src)/vsyscall.lds $(obj)/vsyscall-sysenter.o FORCE
 	$(call if_changed,syscall)
