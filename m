Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbTCZPHE>; Wed, 26 Mar 2003 10:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbTCZPHE>; Wed, 26 Mar 2003 10:07:04 -0500
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:22454 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261708AbTCZPG7> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:06:59 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update (3/9): listing & kerntypes.
Date: Wed, 26 Mar 2003 16:07:31 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261607.31310.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rule to generate kernel listing. Add code to generate kerntypes for
use with the lkcd utils.

diffstat:
 s390/Makefile          |    6 ++---
 s390/boot/Makefile     |   18 +++++++---------
 s390/boot/kerntypes.c  |   53 +++++++++++++++++++++++++++++++++++++++++++++++++
 s390x/Makefile         |    6 ++---
 s390x/boot/Makefile    |   17 ++++++---------
 s390x/boot/kerntypes.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 127 insertions(+), 26 deletions(-)

diff -urN linux-2.5.66/arch/s390/Makefile linux-2.5.66-s390/arch/s390/Makefile
--- linux-2.5.66/arch/s390/Makefile	Mon Mar 24 23:00:08 2003
+++ linux-2.5.66-s390/arch/s390/Makefile	Wed Mar 26 15:45:11 2003
@@ -18,7 +18,7 @@
 LDFLAGS_vmlinux := -e start
 LDFLAGS_BLOB	:= --format binary --oformat elf32-s390
 
-CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
+CFLAGS += -pipe -fno-strength-reduce -finline-limit-10000 -Wno-sign-compare
 
 head-y := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
@@ -30,9 +30,9 @@
 
 makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/$(ARCH)/boot $(1)
 
-all: image listing
+all: image kerntypes.o
 
-listing image: vmlinux
+image kerntypes.o: vmlinux
 	$(call makeboot,arch/$(ARCH)/boot/$@)
 
 install: vmlinux
diff -urN linux-2.5.66/arch/s390/boot/Makefile linux-2.5.66-s390/arch/s390/boot/Makefile
--- linux-2.5.66/arch/s390/boot/Makefile	Mon Mar 24 23:01:53 2003
+++ linux-2.5.66-s390/arch/s390/boot/Makefile	Wed Mar 26 15:45:11 2003
@@ -2,19 +2,17 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-targets		:= image listing
-EXTRA_AFLAGS	:= -traditional
-quiet_cmd_listing = OBJDUMP $@
-      cmd_listing = $(OBJDUMP) --disassemble --disassemble-all \
-			       --disassemble-zeroes --reloc vmlinux > $@
+COMPILE_VERSION := __linux_compile_version_id__`hostname`__`date | \
+			tr -c '[0-9A-Za-z]' '_'`_t
 
-$(obj)/image: vmlinux FORCE
-	$(call if_changed,objcopy)
+EXTRA_CFLAGS  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I .
+EXTRA_AFLAGS  := -traditional
 
-$(obj)/listing: vmlinux FORCE
-	$(call if_changed,listing)
+targets := image kerntypes.o
 
+$(obj)/image: vmlinux FORCE
+	$(call if_changed,objcopy)
 
 install: $(CONFIGURE) $(obj)/image
 	sh -x $(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
-	      System.map Kerntypes "$(INSTALL_PATH)"
+	      System.map "$(INSTALL_PATH)"
diff -urN linux-2.5.66/arch/s390/boot/kerntypes.c linux-2.5.66-s390/arch/s390/boot/kerntypes.c
--- linux-2.5.66/arch/s390/boot/kerntypes.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.66-s390/arch/s390/boot/kerntypes.c	Wed Mar 26 15:45:11 2003
@@ -0,0 +1,53 @@
+/*
+ * kerntypes.c
+ *
+ * Dummy module that includes headers for all kernel types of interest.
+ * The kernel type information is used by the lcrash utility when
+ * analyzing system crash dumps or the live system. Using the type
+ * information for the running system, rather than kernel header files,
+ * makes for a more flexible and robust analysis tool.
+ *
+ * This source code is released under the GNU GPL.
+ */
+
+/* generate version for this file */
+typedef char *COMPILE_VERSION;
+
+/* General linux types */
+
+#include <linux/autoconf.h>
+#include <linux/compile.h>
+#include <linux/config.h>
+#include <linux/utsname.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include <asm/lowcore.h>
+#include <asm/debug.h>
+#include <asm/ccwdev.h>
+#include <asm/qdio.h>
+
+/* channel subsystem driver */
+#include "drivers/s390/cio/cio.h"
+#include "drivers/s390/cio/chsc.h"
+#include "drivers/s390/cio/css.h"
+#include "drivers/s390/cio/device.h"
+#include "drivers/s390/cio/qdio.h"
+
+/* dasd device driver */
+#include "drivers/s390/block/dasd_int.h"
+#include "drivers/s390/block/dasd_diag.h"
+#include "drivers/s390/block/dasd_eckd.h"
+#include "drivers/s390/block/dasd_fba.h"
+
+/* networking drivers */
+#include "drivers/s390/net/fsm.h"
+#include "drivers/s390/net/iucv.h"
+#include "drivers/s390/net/lcs.h"
+
+/* include sched.c for types: 
+ *    - struct prio_array 
+ *    - struct runqueue
+ */
+#include "kernel/sched.c"
diff -urN linux-2.5.66/arch/s390x/Makefile linux-2.5.66-s390/arch/s390x/Makefile
--- linux-2.5.66/arch/s390x/Makefile	Mon Mar 24 23:00:39 2003
+++ linux-2.5.66-s390/arch/s390x/Makefile	Wed Mar 26 15:45:11 2003
@@ -19,7 +19,7 @@
 MODFLAGS += -fpic -D__PIC__
 LDFLAGS_BLOB	:= --format binary --oformat elf64-s390
 
-CFLAGS += -pipe -fno-strength-reduce -finline-limit=10000 -Wno-sign-compare
+CFLAGS += -pipe -fno-strength-reduce -finline-limit-10000 -Wno-sign-compare
 
 head-y := arch/$(ARCH)/kernel/head.o arch/$(ARCH)/kernel/init_task.o
 
@@ -30,9 +30,9 @@
 
 makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/$(ARCH)/boot $(1)
 
-all: image listing
+all: image kerntypes.o
 
-listing image: vmlinux
+image kerntypes.o: vmlinux
 	$(call makeboot,arch/$(ARCH)/boot/$@)
 
 install: vmlinux
diff -urN linux-2.5.66/arch/s390x/boot/Makefile linux-2.5.66-s390/arch/s390x/boot/Makefile
--- linux-2.5.66/arch/s390x/boot/Makefile	Mon Mar 24 23:00:39 2003
+++ linux-2.5.66-s390/arch/s390x/boot/Makefile	Wed Mar 26 15:45:11 2003
@@ -2,20 +2,17 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-targets		:= image listing
-EXTRA_AFLAGS	:= -traditional
+COMPILE_VERSION := __linux_compile_version_id__`hostname`__`date | \
+			tr -c '[0-9A-Za-z]' '_'`_t
 
-quiet_cmd_listing = OBJDUMP $@
-      cmd_listing = $(OBJDUMP) --disassemble --disassemble-all \
-			       --disassemble-zeroes --reloc vmlinux > $@
+EXTRA_CFLAGS  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I .
+EXTRA_AFLAGS  := -traditional
+
+targets := image kerntypes.o
 
 $(obj)/image: vmlinux FORCE
 	$(call if_changed,objcopy)
 
-$(obj)/listing: vmlinux FORCE
-	$(call if_changed,listing)
-
-
 install: $(CONFIGURE) $(obj)/image
 	sh -x $(obj)/install.sh $(KERNELRELEASE) $(obj)/image \
-	      System.map Kerntypes "$(INSTALL_PATH)"
+	      System.map "$(INSTALL_PATH)"
diff -urN linux-2.5.66/arch/s390x/boot/kerntypes.c linux-2.5.66-s390/arch/s390x/boot/kerntypes.c
--- linux-2.5.66/arch/s390x/boot/kerntypes.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.66-s390/arch/s390x/boot/kerntypes.c	Wed Mar 26 15:45:11 2003
@@ -0,0 +1,53 @@
+/*
+ * kerntypes.c
+ *
+ * Dummy module that includes headers for all kernel types of interest.
+ * The kernel type information is used by the lcrash utility when
+ * analyzing system crash dumps or the live system. Using the type
+ * information for the running system, rather than kernel header files,
+ * makes for a more flexible and robust analysis tool.
+ *
+ * This source code is released under the GNU GPL.
+ */
+
+/* generate version for this file */
+typedef char *COMPILE_VERSION;
+
+/* General linux types */
+
+#include <linux/autoconf.h>
+#include <linux/compile.h>
+#include <linux/config.h>
+#include <linux/utsname.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+
+#include <asm/lowcore.h>
+#include <asm/debug.h>
+#include <asm/ccwdev.h>
+#include <asm/qdio.h>
+
+/* channel subsystem driver */
+#include "drivers/s390/cio/cio.h"
+#include "drivers/s390/cio/chsc.h"
+#include "drivers/s390/cio/css.h"
+#include "drivers/s390/cio/device.h"
+#include "drivers/s390/cio/qdio.h"
+
+/* dasd device driver */
+#include "drivers/s390/block/dasd_int.h"
+#include "drivers/s390/block/dasd_diag.h"
+#include "drivers/s390/block/dasd_eckd.h"
+#include "drivers/s390/block/dasd_fba.h"
+
+/* networking drivers */
+#include "drivers/s390/net/fsm.h"
+#include "drivers/s390/net/iucv.h"
+#include "drivers/s390/net/lcs.h"
+
+/* include sched.c for types: 
+ *    - struct prio_array 
+ *    - struct runqueue
+ */
+#include "kernel/sched.c"

