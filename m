Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUJATaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUJATaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUJATaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:30:22 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50181 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266250AbUJAT0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:26:34 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] Make gcc -align options .config-settable
Date: Fri, 1 Oct 2004 22:26:23 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f9aXB7k5EAJtZBi"
Message-Id: <200410012226.23565.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_f9aXB7k5EAJtZBi
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Resend.

With all alignment options set to 1 (minimum alignment),
I've got 5% smaller vmlinux compared to one built with
default code alignment.

Rediffed against 2.6.9-rc3.
Please apply.
--
vda

--Boundary-00=_f9aXB7k5EAJtZBi
Content-Type: text/x-diff;
  charset="koi8-r";
  name="align269r3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="align269r3.patch"

diff -urp linux-2.6.9-rc3.src/Makefile linux-2.6.9-rc3_align.src/Makefile
--- linux-2.6.9-rc3.src/Makefile	Fri Oct  1 21:29:57 2004
+++ linux-2.6.9-rc3_align.src/Makefile	Fri Oct  1 21:45:20 2004
@@ -334,6 +334,8 @@ LDFLAGS_MODULE  = -r
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
 
+GCC_VERSION	= $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
+
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
 # Use LINUXINCLUDE when you must reference the include/ directory.
@@ -484,6 +486,22 @@ ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS		+= -Os
 else
 CFLAGS		+= -O2
+endif
+
+GCC3		= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "1"; else echo "0"; fi ;)
+ifeq ($(GCC3),1)
+ifneq ($(CONFIG_CC_ALIGN_FUNCTIONS),0)
+CFLAGS		+= -falign-functions=$(CONFIG_CC_ALIGN_FUNCTIONS)
+endif
+ifneq ($(CONFIG_CC_ALIGN_LABELS),0)
+CFLAGS		+= -falign-labels=$(CONFIG_CC_ALIGN_LABELS)
+endif
+ifneq ($(CONFIG_CC_ALIGN_LOOPS),0)
+CFLAGS		+= -falign-loops=$(CONFIG_CC_ALIGN_LOOPS)
+endif
+ifneq ($(CONFIG_CC_ALIGN_JUMPS),0)
+CFLAGS		+= -falign-jumps=$(CONFIG_CC_ALIGN_JUMPS)
+endif
 endif
 
 ifndef CONFIG_FRAME_POINTER
diff -urp linux-2.6.9-rc3.src/init/Kconfig linux-2.6.9-rc3_align.src/init/Kconfig
--- linux-2.6.9-rc3.src/init/Kconfig	Fri Oct  1 21:30:19 2004
+++ linux-2.6.9-rc3_align.src/init/Kconfig	Fri Oct  1 21:45:20 2004
@@ -303,6 +303,43 @@ config SHMEM
 	  option replaces shmem and tmpfs with the much simpler ramfs code,
 	  which may be appropriate on small systems without swap.
 
+config CC_ALIGN_FUNCTIONS
+	int "Function alignment"
+	default 0
+	help
+	  Align the start of functions to the next power-of-two greater than n,
+	  skipping up to n bytes.  For instance, 32 aligns functions
+	  to the next 32-byte boundary, but 24 would align to the next
+	  32-byte boundary only if this can be done by skipping 23 bytes or less.
+	  Zero means use compiler's default.
+
+config CC_ALIGN_LABELS
+	int "Label alignment"
+	default 0
+	help
+	  Align all branch targets to a power-of-two boundary, skipping
+	  up to n bytes like ALIGN_FUNCTIONS.  This option can easily
+	  make code slower, because it must insert dummy operations for
+	  when the branch target is reached in the usual flow of the code.
+	  Zero means use compiler's default.
+
+config CC_ALIGN_LOOPS
+	int "Loop alignment"
+	default 0
+	help
+	  Align loops to a power-of-two boundary, skipping up to n bytes.
+	  Zero means use compiler's default.
+
+config CC_ALIGN_JUMPS
+	int "Jump alignment"
+	default 0
+	help
+	  Align branch targets to a power-of-two boundary, for branch
+	  targets where the targets can only be reached by jumping,
+	  skipping up to n bytes like ALIGN_FUNCTIONS.  In this case,
+	  no dummy operations need be executed.
+	  Zero means use compiler's default.
+
 endmenu		# General setup
 
 config TINY_SHMEM

--Boundary-00=_f9aXB7k5EAJtZBi--

