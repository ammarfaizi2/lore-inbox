Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314120AbSDFKGn>; Sat, 6 Apr 2002 05:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314121AbSDFKGm>; Sat, 6 Apr 2002 05:06:42 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12552 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314120AbSDFKGl>;
	Sat, 6 Apr 2002 05:06:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Apr 2002 20:06:27 +1000
Message-ID: <17430.1018087587@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the makefiles for aic7xxx and aic7xxx/aicasm.
  Use standard kbuild 2.4 rules.
  Add missing dependencies for generated files.
  Remove .NOTPARALLEL, only required because the dependencies were missing.
  Add yet more generated aic7xxx files to clean list.

Correct drivers/scsi/Makefile for invocation of aic7xxx.

Remove $(MOD_TARGET) from Rules.make.  It was only used by the old
aic7xxx makefile and it breaks the placement rules for modules.

Index: 19-pre6.1/drivers/scsi/Makefile
--- 19-pre6.1/drivers/scsi/Makefile Tue, 05 Feb 2002 09:59:16 +1100 kaos (linux-2.4/U/b/31_Makefile 1.1.4.3.3.1.2.3.1.4 644)
+++ 19-pre6.1(w)/drivers/scsi/Makefile Sat, 06 Apr 2002 20:04:19 +1000 kaos (linux-2.4/U/b/31_Makefile 1.1.4.3.3.1.2.3.1.4 644)
@@ -69,7 +69,7 @@ ifeq ($(CONFIG_SCSI_AACRAID),y)
   obj-$(CONFIG_SCSI_AACRAID)	+= aacraid/aacraid.o
 endif
 ifeq ($(CONFIG_SCSI_AIC7XXX),y)
-obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx/aic7xxx_drv.o
+  obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx/aic7xxx.o
 endif
 obj-$(CONFIG_SCSI_AIC7XXX_OLD)	+= aic7xxx_old.o
 obj-$(CONFIG_SCSI_IPS)		+= ips.o
Index: 19-pre6.1/Rules.make
--- 19-pre6.1/Rules.make Fri, 05 Apr 2002 16:52:19 +1000 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2.3.3 644)
+++ 19-pre6.1(w)/Rules.make Sat, 06 Apr 2002 19:57:49 +1000 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2.3.3 644)
@@ -176,7 +176,7 @@ modules: $(ALL_MOBJS) dummy \
 _modinst__: dummy
 ifneq "$(strip $(ALL_MOBJS))" ""
 	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
-	cp $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
+	cp $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)
 endif
 
 .PHONY: modules_install
Index: 19-pre6.1/Makefile
--- 19-pre6.1/Makefile Fri, 05 Apr 2002 16:52:19 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.20 644)
+++ 19-pre6.1(w)/Makefile Sat, 06 Apr 2002 19:18:08 +1000 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.25.2.2.1.17.1.4.1.29.1.40.1.20 644)
@@ -204,10 +204,15 @@ CLEAN_FILES = \
 	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
 	drivers/sound/bin2hex drivers/sound/hex2hex \
 	drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
+	drivers/scsi/aic7xxx/aicasm/aicasm \
 	drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
+	drivers/scsi/aic7xxx/aicasm/aicasm_gram.h \
+	drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.c \
+	drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.h \
+	drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.c \
 	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
+	drivers/scsi/aic7xxx/aicasm/aicdb.h \
 	drivers/scsi/aic7xxx/aicasm/y.tab.h \
-	drivers/scsi/aic7xxx/aicasm/aicasm \
 	drivers/scsi/53c700_d.h \
 	net/khttpd/make_times_h \
 	net/khttpd/times.h \
Index: 19-pre6.1/drivers/scsi/aic7xxx/aicasm/Makefile
--- 19-pre6.1/drivers/scsi/aic7xxx/aicasm/Makefile Thu, 21 Mar 2002 10:50:19 +1100 kaos (linux-2.4/y/d/8_Makefile 1.2.1.1.2.2 644)
+++ 19-pre6.1(w)/drivers/scsi/aic7xxx/aicasm/Makefile Sat, 06 Apr 2002 19:24:16 +1000 kaos (linux-2.4/y/d/8_Makefile 1.2.1.1.2.2 644)
@@ -29,8 +29,6 @@ YFLAGS+= -t -v
 LFLAGS= -d
 endif
 
-.NOTPARALLEL:
-
 $(PROG):  ${GENHDRS} $(SRCS)
 	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG)
 
Index: 19-pre6.1/drivers/scsi/aic7xxx/Makefile
--- 19-pre6.1/drivers/scsi/aic7xxx/Makefile Thu, 21 Mar 2002 10:50:19 +1100 kaos (linux-2.4/y/d/24_Makefile 1.1.1.1.2.2 644)
+++ 19-pre6.1(w)/drivers/scsi/aic7xxx/Makefile Sat, 06 Apr 2002 18:19:04 +1000 kaos (linux-2.4/y/d/24_Makefile 1.1.1.1.2.2 644)
@@ -4,44 +4,36 @@
 # Makefile for the Linux aic7xxx SCSI driver.
 #
 
-O_TARGET := aic7xxx_drv.o
-
-list-multi	:= aic7xxx_mod.o aic79xx_mod.o
-
-ifeq (aic7xxx_core.c, $(wildcard aic7xxx_core.c))
-obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx.o
-endif
+O_TARGET := aic7xxx.o
+obj-m	 := $(O_TARGET)
 
 #EXTRA_CFLAGS += -g
 
 # Platform Specific Files
-AIC7XXX_OBJS = aic7xxx_osm.o 
-AIC7XXX_OBJS += aic7xxx_proc.o aic7770_osm.o
+obj-y			:= aic7xxx_osm.o aic7xxx_proc.o aic7770_osm.o
 #PCI Specific Platform Files
-ifeq ($(CONFIG_PCI),y)
-AIC7XXX_OBJS += aic7xxx_osm_pci.o
-endif
+obj-$(CONFIG_PCI)	+= aic7xxx_osm_pci.o
 # Core Files
-AIC7XXX_OBJS += aic7xxx_core.o aic7xxx_93cx6.o aic7770.o
+obj-y			+= aic7xxx_core.o aic7xxx_93cx6.o aic7770.o
 #PCI Specific Core Files
-ifeq ($(CONFIG_PCI),y)
-AIC7XXX_OBJS += aic7xxx_pci.o
-endif
-
-# Override our module desitnation
-MOD_DESTDIR = $(shell cd .. && $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
+obj-$(CONFIG_PCI)	+= aic7xxx_pci.o
 
 include $(TOPDIR)/Rules.make
 
-.NOPARALLEL:
-
-aic7xxx.o: aic7xxx_seq.h aic7xxx_reg.h $(AIC7XXX_OBJS)
-	$(LD) $(LD_RFLAG) -r -o $@ $(AIC7XXX_OBJS)
-
 ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
 aic7xxx_seq.h aic7xxx_reg.h: aic7xxx.seq aic7xxx.reg aicasm/aicasm
 	aicasm/aicasm -I. -r aic7xxx_reg.h -o aic7xxx_seq.h aic7xxx.seq
-endif
 
 aicasm/aicasm: aicasm/*.[chyl]
 	$(MAKE) -C aicasm
+
+# Only aic7xxx_core.c includes aic7xxx_seq.h.
+aic7xxx_core.o: aic7xxx_seq.h
+
+# aic7xxx_reg.h is messy.  It is included by aic7xxx.h which is included by
+# aic7xxx_osm.h which is included by several .c files.  Play safe and make all
+# object files depend on aic7xxx_reg.h.
+
+$(obj-y): aic7xxx_reg.h
+
+endif

