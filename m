Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbSJJTro>; Thu, 10 Oct 2002 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262160AbSJJTro>; Thu, 10 Oct 2002 15:47:44 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38416 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262154AbSJJTrj>;
	Thu, 10 Oct 2002 15:47:39 -0400
Date: Thu, 10 Oct 2002 21:52:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: scsi+aic7xxx: Utilise distributed clean
Message-ID: <20021010215210.B577@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021010213440.A508@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021010213440.A508@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 10, 2002 at 09:34:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.748.1.1 -> 1.748.1.2
#	            Makefile	1.319   -> 1.320  
#	drivers/scsi/Makefile	1.26    -> 1.27   
#	drivers/scsi/aic7xxx/aicasm/Makefile	1.4     -> 1.5    
#	drivers/scsi/aic7xxx/Makefile	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	sam@mars.ravnborg.org	1.748.1.2
# scsi+aic7xxx: Utilise distributed clean
# List files to be deleted during make clean where they are created
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Oct 10 21:22:19 2002
+++ b/Makefile	Thu Oct 10 21:22:19 2002
@@ -681,15 +681,6 @@
 	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
 	sound/oss/bin2hex sound/oss/hex2hex \
 	drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
-	drivers/scsi/aic7xxx/aic7xxx_seq.h \
-	drivers/scsi/aic7xxx/aic7xxx_reg.h \
-	drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
-	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
-	drivers/scsi/aic7xxx/aicasm/y.tab.h \
-	drivers/scsi/aic7xxx/aicasm/aicasm \
-	drivers/scsi/53c700_d.h drivers/scsi/sim710_d.h \
-	drivers/scsi/53c7xx_d.h drivers/scsi/53c7xx_u.h \
-	drivers/scsi/53c8xx_d.h drivers/scsi/53c8xx_u.h \
 	net/802/cl2llc.c net/802/transit/pdutr.h net/802/transit/timertr.h \
 	net/802/pseudo/pseudocode.h \
 	net/khttpd/make_times_h net/khttpd/times.h \
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	Thu Oct 10 21:22:19 2002
+++ b/drivers/scsi/Makefile	Thu Oct 10 21:22:19 2002
@@ -132,6 +132,10 @@
 cpqfc-objs	:= cpqfcTSinit.o cpqfcTScontrol.o cpqfcTSi2c.o \
 		   cpqfcTSworker.o cpqfcTStrigger.o
 
+# Files generated that shall be removed upon make clean
+clean-files :=	53c8xx_d.h  53c7xx_d.h sim710_d.h  53c700_d.h	\
+		53c8xx_u.h  53c7xx_u.h sim710_u.h 53c700_u.h
+
 include $(TOPDIR)/Rules.make
 
 $(obj)/53c7,8xx.o: $(obj)/53c8xx_d.h $(obj)/53c8xx_u.h
@@ -162,4 +166,4 @@
 $(obj)/53c700_d.h: $(src)/53c700.scr $(src)/script_asm.pl
 	$(PERL) -s $(src)/script_asm.pl -ncr7x0_family $@ $(@:_d.h=_u.h) < $<
 
-endif
\ No newline at end of file
+endif
diff -Nru a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
--- a/drivers/scsi/aic7xxx/Makefile	Thu Oct 10 21:22:19 2002
+++ b/drivers/scsi/aic7xxx/Makefile	Thu Oct 10 21:22:19 2002
@@ -20,6 +20,13 @@
 
 #EXTRA_CFLAGS += -g
 
+# Files generated that shall be removed upon make clean
+clean-files := aic7xxx_seq.h aic7xxx_reg.h
+
+# Command to be executed upon make clean
+# Note: Assignment without ':' to force late evaluation of $(src)
+clean-rule = @$(MAKE) -C $(src)/aicasm clean
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies for generated files need to be listed explicitly
@@ -30,11 +37,12 @@
 
 ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
 
-$(obj)/aic7xxx_seq.h $(obj)/aic7xxx_reg.h: $(src)/aic7xxx.seq \
-					   $(src)/aic7xxx.reg \
-					   $(obj)/aicasm/aicasm
+$(obj)/aic7xxx_seq.h: $(src)/aic7xxx.seq $(src)/aic7xxx.reg \
+		      $(obj)/aicasm/aicasm
 	$(obj)/aicasm/aicasm -I. -r $(obj)/aic7xxx_reg.h \
 				 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
+
+$(obj)/aic7xxx_reg.h: $(obj)/aix7xxx_seq.h
 
 $(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]
 	$(MAKE) -C $(src)/aicasm
diff -Nru a/drivers/scsi/aic7xxx/aicasm/Makefile b/drivers/scsi/aic7xxx/aicasm/Makefile
--- a/drivers/scsi/aic7xxx/aicasm/Makefile	Thu Oct 10 21:22:19 2002
+++ b/drivers/scsi/aic7xxx/aicasm/Makefile	Thu Oct 10 21:22:19 2002
@@ -43,7 +43,7 @@
 	 fi
 
 clean:
-	rm -f $(CLEANFILES) $(PROG)
+	@rm -f $(CLEANFILES) $(PROG)
 
 y.tab.h aicasm_gram.c: aicasm_gram.y
 	$(YACC) $(YFLAGS) aicasm_gram.y
