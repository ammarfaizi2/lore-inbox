Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSL0XEZ>; Fri, 27 Dec 2002 18:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSL0XEZ>; Fri, 27 Dec 2002 18:04:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21771 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265222AbSL0XEU>;
	Fri, 27 Dec 2002 18:04:20 -0500
Date: Sat, 28 Dec 2002 00:12:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Andi Kleen <ak@suse.de>,
       sparclinux@vger.kernel.org
Subject: kbuild: archhelp update and $(build)+$(clean)
Message-ID: <20021227231236.GA24461@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
	Andi Kleen <ak@suse.de>, sparclinux@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moving archhelp to arch/$(ARCH)/Makefile allow us to use this for
all architectures. Not all architecture had a boot directory.
The following patch implement the common bits, and moved archhelp for i386.
Patches for other architectures (arm,sparc64,x86_64) will follow.

The defines $(build) and $(clean) simplify recursive make invocations.
$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/i386/boot bzImage
is reduced to
$(Q)$(MAKE) $(build)=arch/i386/boot bzImage

It keeps the commandlines sorter than 80 characters in common case.
Made it possible to use in all makefiles, and introduced usage
for i386.
Updates to a few architectures will follow (same list as before for now).

	Sam

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.959, 2002-12-27 21:15:49+01:00, sam@mars.ravnborg.org
  kbuild: Move archhelp to arch/$(ARCH)/Makefile
  
  arch/$(ARCH)/Makefile already contains the kbuild required additions
  to allow the kernel to be built for the architecture in question.
  Moving archhelp centralise this information, and no longer require a
  boot directory to exist to utilise this feature.
  
  Update i386 to define archhelp in arch/$(ARCH)/Makefile
  Other architectures will be updated in next cset.

ChangeSet@1.958, 2002-12-27 20:50:55+01:00, sam@mars.ravnborg.org
  kbuild: $(build) and $(clean) macros for make invocation
  
  The former macro $(descend ...) hide for make the fact that a recursively make was
  invoked. The replacement $(Q)$(MAKE) -f scripts/Makefile.build obj=dir was too verbose.
  
  Introduced $(build) and $(clean) allowing the following syntax:
  $(Q)$(MAKE) $(build)=arch/i386/boot target
  and similar for clean.
  
  Introduced $(build) and $(clean) in general, and for i386 architecture.


 Makefile                |    3 ++-
 arch/i386/Makefile      |    9 +++++++++
 arch/i386/boot/Makefile |    8 --------
 3 files changed, 11 insertions(+), 9 deletions(-)


diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Dec 28 00:04:01 2002
+++ b/Makefile	Sat Dec 28 00:04:01 2002
@@ -821,7 +821,8 @@
 	@$(MAKE) --no-print-directory -f Documentation/DocBook/Makefile dochelp
 	@echo  ''
 	@echo  'Architecture specific targets ($(ARCH)):'
-	@$(MAKE) --no-print-directory -f arch/$(ARCH)/boot/Makefile archhelp
+	@$(if $(archhelp),$(archhelp),\
+		echo '  No architecture specific help defined for $(ARCH)')
 	@echo  ''
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
 	@echo  'For further info browse Documentation/kbuild/*'
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Sat Dec 28 00:04:01 2002
+++ b/arch/i386/Makefile	Sat Dec 28 00:04:01 2002
@@ -104,3 +104,12 @@
 
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/i386/boot
+
+define archhelp
+  echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
+  echo  '  install	- Install kernel using'
+  echo  '		   (your) ~/bin/installkernel or'
+  echo  '		   (distribution) /sbin/installkernel or'
+  echo  '		   install to $$(INSTALL_PATH) and run lilo'
+endef
+
diff -Nru a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	Sat Dec 28 00:04:01 2002
+++ b/arch/i386/boot/Makefile	Sat Dec 28 00:04:01 2002
@@ -74,11 +74,3 @@
 
 install: $(BOOTIMAGE)
 	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
-
-archhelp:
-	@echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
-	@echo  '  install	- Install kernel using'
-	@echo  '                  (your) ~/bin/installkernel or'
-	@echo  '                  (distribution) /sbin/installkernel or'
-	@echo  '        	  install to $$(INSTALL_PATH) and run lilo'
-

===================================================================


This BitKeeper patch contains the following changesets:
1.958..1.959
## Wrapped with gzip_uu ##


begin 664 bkpatch24452
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
C;>7'L#^D*\'RO^7$8Q[?%M7D8FC:'@N\P/@O>.ISS04D````
`
end
