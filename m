Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272547AbSKECbF>; Mon, 4 Nov 2002 21:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbSKECbF>; Mon, 4 Nov 2002 21:31:05 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52614 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S272547AbSKECbC>; Mon, 4 Nov 2002 21:31:02 -0500
Date: Mon, 4 Nov 2002 20:37:31 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: george anzinger <george@mvista.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
In-Reply-To: <3DC71BBF.5BBDCECF@mvista.com>
Message-ID: <Pine.LNX.4.44.0211042035330.20254-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, george anzinger wrote:

> I think we need a newer objcopy :(

Alternatively, use this patch. (It's not really needed to force people to 
upgrade binutils when ld can do the job, as it e.g. does in 
arch/i386/boot/compressed/Makefile already).

--Kai


Pull from http://linux-isdn.bkbits.net/linux-2.5.make

(Merging changesets omitted for clarity)

-----------------------------------------------------------------------------
ChangeSet@1.897, 2002-11-04 16:04:44-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: initramfs updates
  
  Use ld to link the cpio archive into the image, build was broken
  due to requiring a recent version of objcopy before, plus assorted
  cleanups:
  
  o Don't include arch/$(ARCH)/Makefile, export the needed arch-specific
    flags instead.
  o Name the generated section consistently .init.ramfs everywhere.

 ----------------------------------------------------------------------------
 Makefile                |    2 +-
 arch/i386/Makefile      |    2 +-
 arch/i386/vmlinux.lds.S |    2 +-
 usr/Makefile            |   14 ++++++--------
 usr/initramfs_data.scr  |    4 ++++
 5 files changed, 13 insertions(+), 11 deletions(-)





=============================================================================
unified diffs follow for reference
=============================================================================

-----------------------------------------------------------------------------
ChangeSet@1.897, 2002-11-04 16:04:44-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild: initramfs updates
  
  Use ld to link the cpio archive into the image, build was broken
  due to requiring a recent version of objcopy before, plus assorted
  cleanups:
  
  o Don't include arch/$(ARCH)/Makefile, export the needed arch-specific
    flags instead.
  o Name the generated section consistently .init.ramfs everywhere.

  ---------------------------------------------------------------------------

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Mon Nov  4 16:05:19 2002
+++ b/Makefile	Mon Nov  4 16:05:19 2002
@@ -175,7 +175,7 @@
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
 	CONFIG_SHELL TOPDIR HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
-	HOSTCXX HOSTCXXFLAGS
+	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB
 
 export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Nov  4 16:05:19 2002
+++ b/arch/i386/Makefile	Mon Nov  4 16:05:19 2002
@@ -18,8 +18,8 @@
 
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
-ARCHBLOBLFLAGS	:= -I binary -O elf32-i386 -B i386
 LDFLAGS_vmlinux := -e stext
+LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
 CFLAGS += -pipe
 
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Mon Nov  4 16:05:19 2002
+++ b/arch/i386/vmlinux.lds.S	Mon Nov  4 16:05:19 2002
@@ -79,7 +79,7 @@
   __initcall_end = .;
   . = ALIGN(4096);
   __initramfs_start = .;
-  .init.ramfs : { *(.init.initramfs) }
+  .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
   . = ALIGN(32);
   __per_cpu_start = .;
diff -Nru a/usr/Makefile b/usr/Makefile
--- a/usr/Makefile	Mon Nov  4 16:05:19 2002
+++ b/usr/Makefile	Mon Nov  4 16:05:19 2002
@@ -1,18 +1,16 @@
 
-include arch/$(ARCH)/Makefile
-
 obj-y := initramfs_data.o
 
 host-progs := gen_init_cpio
 
 clean-files := initramfs_data.cpio.gz
 
-$(obj)/initramfs_data.o: $(obj)/initramfs_data.cpio.gz
-	$(OBJCOPY) $(ARCHBLOBLFLAGS) \
-		--rename-section .data=.init.initramfs \
-		$(obj)/initramfs_data.cpio.gz $(obj)/initramfs_data.o
-	$(STRIP) -s $(obj)/initramfs_data.o
+LDFLAGS_initramfs_data.o := $(LDFLAGS_BLOB) -r -T
+
+$(obj)/initramfs_data.o: $(src)/initramfs_data.scr $(obj)/initramfs_data.cpio.gz FORCE
+	$(call if_changed,ld)
 
 $(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio
-	( cd $(obj) ; ./gen_init_cpio | gzip -9c > initramfs_data.cpio.gz )
+	( cd $(obj) ; ./$< | gzip -9c > $@ )
+
 
diff -Nru a/usr/initramfs_data.scr b/usr/initramfs_data.scr
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/usr/initramfs_data.scr	Mon Nov  4 16:05:19 2002
@@ -0,0 +1,4 @@
+SECTIONS
+{
+	.init.ramfs : { *(.data) }
+}


