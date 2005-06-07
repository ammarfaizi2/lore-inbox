Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVFGBQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVFGBQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 21:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVFGBQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 21:16:24 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:5464 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261804AbVFGBPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 21:15:50 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML binary
Date: Tue, 7 Jun 2005 03:18:48 +0200
User-Agent: KMail/1.7.2
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org> <200506070256.43104.blaisorblade@yahoo.it> <20050607005958.GK29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050607005958.GK29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6XPpCFwtDUdIk4g"
Message-Id: <200506070318.50734.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_6XPpCFwtDUdIk4g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 07 June 2005 02:59, Al Viro wrote:
> On Tue, Jun 07, 2005 at 02:56:36AM +0200, Blaisorblade wrote:
> > > Per-subarch - perhaps not.  Per-glibc-type - definitely needed.
> >
> > No, because the setup for NPTL glibc works also on non-NPTL one.
> > Actually, to be exact, I've tested it *only* on normal glibc. I'm still
> > waiting to get some testing in NPTL environments, but I expect it to
> > work.
>
> Now, that is interesting.  Which script are you using for i386 and which
> libc version does it work with?
The one I sent originally didn't work because I had been lazy (used .data 
instead of .bss), but only for that. Well, there were another zillion of 
problems, but now it works.

> > P.S: is it only me or you've sent about 20 copies of your last message?
>
> Headers?
The Message-ID seem to match, so guess it's my Kmail (never seen such a 
problem, though).

Message-ID: <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org> 
<200506070105.20422.blaisorblade@yahoo.it>

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_6XPpCFwtDUdIk4g
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-link-tt-mode-against-nptl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-link-tt-mode-against-nptl.patch"


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

To make sure switcheroo() can execute when we remap all the executable image,
we used a trick to make it use a local copy of errno... this trick does not
work with NPTL glibc, only with LinuxThreads, so use another (simpler) one to
make it work anyway.

Hopefully, a lot improved thanks to merging with the version of Al Viro (which
had his part of problems, though, i.e. removing a fix to another bug and not
fixing the problem on i386).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/Makefile               |    2 -
 linux-2.6.git-paolo/arch/um/kernel/tt/Makefile     |   15 ----------
 linux-2.6.git-paolo/arch/um/kernel/uml.lds.S       |   15 ++--------
 linux-2.6.git-paolo/arch/um/scripts/Makefile.rules |    6 ++++
 linux-2.6.git-paolo/arch/um/scripts/Makefile.unmap |   22 ++++++++++++++
 linux-2.6.git-paolo/arch/um/sys-i386/Makefile      |    2 +
 linux-2.6.git-paolo/arch/um/sys-i386/unmap.c       |   25 ++++++++++++++++
 linux-2.6.git-paolo/arch/um/sys-x86_64/Makefile    |    2 +
 linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c     |   25 ++++++++++++++++
 linux-2.6.git/arch/um/kernel/tt/unmap.c            |   31 ---------------------
 10 files changed, 86 insertions(+), 59 deletions(-)

diff -L arch/um/kernel/tt/unmap.c -puN arch/um/kernel/tt/unmap.c~uml-link-tt-mode-against-nptl /dev/null
--- linux-2.6.git/arch/um/kernel/tt/unmap.c
+++ /dev/null	2005-03-04 21:12:55.000000000 +0100
@@ -1,31 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <sys/mman.h>
-
-int switcheroo(int fd, int prot, void *from, void *to, int size)
-{
-	if(munmap(to, size) < 0){
-		return(-1);
-	}
-	if(mmap(to, size, prot,	MAP_SHARED | MAP_FIXED, fd, 0) != to){
-		return(-1);
-	}
-	if(munmap(from, size) < 0){
-		return(-1);
-	}
-	return(0);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/uml.lds.S~uml-link-tt-mode-against-nptl arch/um/kernel/uml.lds.S
--- linux-2.6.git/arch/um/kernel/uml.lds.S~uml-link-tt-mode-against-nptl	2005-06-07 02:48:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/uml.lds.S	2005-06-07 02:48:03.000000000 +0200
@@ -14,19 +14,10 @@ SECTIONS
   /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
    * is remapped.*/
   __binary_start = .;
-#ifdef MODE_TT
-  .thread_private : {
-    __start_thread_private = .;
-    errno = .;
-    . += 4;
-    arch/um/kernel/tt/unmap_fin.o (.data)
-    __end_thread_private = .;
-  }
-  . = ALIGN(4096);
-  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
 
-  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
-   * is off the resulting binary segfaults.*/
+#ifdef MODE_TT
+  .remap_data : { arch/um/sys-SUBARCH/unmap_fin.o (.data .bss) }
+  .remap : { arch/um/sys-SUBARCH/unmap_fin.o (.text) }
 
   . = ALIGN(4096);		/* Init code and data */
 #endif
diff -puN /dev/null arch/um/sys-i386/unmap.c
--- /dev/null	2005-03-04 21:12:55.000000000 +0100
+++ linux-2.6.git-paolo/arch/um/sys-i386/unmap.c	2005-06-07 02:48:03.000000000 +0200
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/mman.h>
+#include <asm/unistd.h>
+
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+int switcheroo(int fd, int prot, void *from, void *to, int size)
+{
+	if(munmap(to, size) < 0){
+		return(-1);
+	}
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+		return(-1);
+	}
+	if(munmap(from, size) < 0){
+		return(-1);
+	}
+	return(0);
+}
diff -puN /dev/null arch/um/sys-x86_64/unmap.c
--- /dev/null	2005-03-04 21:12:55.000000000 +0100
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/unmap.c	2005-06-07 02:48:03.000000000 +0200
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/mman.h>
+#include <asm/unistd.h>
+
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+int switcheroo(int fd, int prot, void *from, void *to, int size)
+{
+	if(munmap(to, size) < 0){
+		return(-1);
+	}
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+		return(-1);
+	}
+	if(munmap(from, size) < 0){
+		return(-1);
+	}
+	return(0);
+}
diff -puN arch/um/kernel/tt/Makefile~uml-link-tt-mode-against-nptl arch/um/kernel/tt/Makefile
--- linux-2.6.git/arch/um/kernel/tt/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 02:48:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/Makefile	2005-06-07 02:48:03.000000000 +0200
@@ -3,10 +3,6 @@
 # Licensed under the GPL
 #
 
-extra-y := unmap_fin.o
-targets := unmap.o
-clean-files := unmap_tmp.o
-
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o \
 	uaccess.o uaccess_user.o
@@ -16,14 +12,3 @@ obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptp
 USER_OBJS := gdb.o time.o tracer.o
 
 include arch/um/scripts/Makefile.rules
-
-UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
-UNMAP_CFLAGS := $(patsubst -fprofile-arcs -ftest-coverage,,$(UNMAP_CFLAGS))
-
-#XXX: partially copied from arch/um/scripts/Makefile.rules
-$(obj)/unmap.o: c_flags = -Wp,-MD,$(depfile) $(UNMAP_CFLAGS)
-
-$(obj)/unmap_fin.o : $(obj)/unmap.o
-	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a)
-	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
-
diff -puN arch/um/sys-i386/Makefile~uml-link-tt-mode-against-nptl arch/um/sys-i386/Makefile
--- linux-2.6.git/arch/um/sys-i386/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 02:48:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/Makefile	2005-06-07 02:48:03.000000000 +0200
@@ -17,3 +17,5 @@ highmem.c-dir = mm
 module.c-dir = kernel
 
 subdir- := util
+
+include arch/um/scripts/Makefile.unmap
diff -puN arch/um/sys-x86_64/Makefile~uml-link-tt-mode-against-nptl arch/um/sys-x86_64/Makefile
--- linux-2.6.git/arch/um/sys-x86_64/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 02:48:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/Makefile	2005-06-07 02:48:03.000000000 +0200
@@ -29,3 +29,5 @@ thunk.S-dir = lib
 module.c-dir = kernel
 
 subdir- := util
+
+include arch/um/scripts/Makefile.unmap
diff -puN /dev/null arch/um/scripts/Makefile.unmap
--- /dev/null	2005-03-04 21:12:55.000000000 +0100
+++ linux-2.6.git-paolo/arch/um/scripts/Makefile.unmap	2005-06-07 03:05:56.000000000 +0200
@@ -0,0 +1,22 @@
+clean-files += unmap_tmp.o unmap_fin.o unmap.o
+
+ifdef CONFIG_MODE_TT
+
+#Always build unmap_fin.o
+extra-y += unmap_fin.o
+#Do dependency tracking for unmap.o (it will be always built, but won't get the tracking unless we use this).
+targets += unmap.o
+
+#XXX: partially copied from arch/um/scripts/Makefile.rules
+$(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
+
+quiet_cmd_wrapld = LD      $@
+define cmd_wrapld
+	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a); \
+	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
+endef
+
+$(obj)/unmap_fin.o : $(obj)/unmap.o FORCE
+	$(call if_changed,wrapld)
+
+endif
diff -puN arch/um/Makefile~uml-link-tt-mode-against-nptl arch/um/Makefile
--- linux-2.6.git/arch/um/Makefile~uml-link-tt-mode-against-nptl	2005-06-07 02:48:03.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/Makefile	2005-06-07 02:48:03.000000000 +0200
@@ -118,7 +118,7 @@ endif
 CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE-y) \
-	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
+	-DKERNEL_STACK_SIZE=$(STACK_SIZE) -DSUBARCH=$(SUBARCH))
 
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
diff -puN arch/um/scripts/Makefile.rules~uml-link-tt-mode-against-nptl arch/um/scripts/Makefile.rules
--- linux-2.6.git/arch/um/scripts/Makefile.rules~uml-link-tt-mode-against-nptl	2005-06-07 03:03:42.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/scripts/Makefile.rules	2005-06-07 03:08:55.000000000 +0200
@@ -10,6 +10,12 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
 $(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	$(CFLAGS_$(notdir $@))
 
+# The stubs and unmap.o can't try to call mcount or update basic block data
+define unprofile
+	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
+endef
+
+
 quiet_cmd_make_link = SYMLINK $@
 cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
 
_

--Boundary-00=_6XPpCFwtDUdIk4g--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
