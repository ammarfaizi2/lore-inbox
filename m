Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265746AbSKAVCZ>; Fri, 1 Nov 2002 16:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265747AbSKAVCZ>; Fri, 1 Nov 2002 16:02:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1554 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265746AbSKAVCX>;
	Fri, 1 Nov 2002 16:02:23 -0500
Date: Fri, 1 Nov 2002 21:10:14 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] aic7xxx/docbook Makefile fixes
Message-ID: <20021101201014.GA1937@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes to aic7xxx:
- Get rid of clean-rule
- Fix firmware build

Fixes to docbook:
- Make the *docs target work againg after Rules.make got lethal
- Fix cleaning when htmldocs has been executed

Please apply,
	Sam


 drivers/scsi/aic7xxx/Makefile        |    9 +++------
 drivers/scsi/aic7xxx/aicasm/Makefile |    7 +++----
 2 files changed, 6 insertions(+), 10 deletions(-)

 Documentation/DocBook/Makefile |    6 ++----
 Makefile                       |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.855   -> 1.856  
#	drivers/scsi/aic7xxx/aicasm/Makefile	1.5     -> 1.6    
#	drivers/scsi/aic7xxx/Makefile	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	sam@mars.ravnborg.org	1.856
# scsi/aic7xxx: Avoid clean-rule usage in Makefile
# --------------------------------------------
#
diff -Nru a/drivers/scsi/aic7xxx/Makefile b/drivers/scsi/aic7xxx/Makefile
--- a/drivers/scsi/aic7xxx/Makefile	Fri Nov  1 21:04:53 2002
+++ b/drivers/scsi/aic7xxx/Makefile	Fri Nov  1 21:04:53 2002
@@ -1,6 +1,8 @@
 #
 # Makefile for the Linux aic7xxx SCSI driver.
 #
+# Let kbuild descend into aicasm when cleaning
+subdir-				+= aicasm
 
 obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx.o
 
@@ -23,11 +25,6 @@
 # Files generated that shall be removed upon make clean
 clean-files := aic7xxx_seq.h aic7xxx_reg.h
 
-# Command to be executed upon make clean
-clean-rule := $(MAKE) -C $(src)/aicasm clean
-
-include $(TOPDIR)/Rules.make
-
 # Dependencies for generated files need to be listed explicitly
 
 $(obj)/aic7xxx_core.o: $(obj)/aic7xxx_seq.h
@@ -41,7 +38,7 @@
 	$(obj)/aicasm/aicasm -I$(obj) -r $(obj)/aic7xxx_reg.h \
 				 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
 
-$(obj)/aic7xxx_reg.h: $(obj)/aix7xxx_seq.h
+$(obj)/aic7xxx_reg.h: $(obj)/aic7xxx_seq.h
 
 $(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]
 	$(MAKE) -C $(src)/aicasm
diff -Nru a/drivers/scsi/aic7xxx/aicasm/Makefile b/drivers/scsi/aic7xxx/aicasm/Makefile
--- a/drivers/scsi/aic7xxx/aicasm/Makefile	Fri Nov  1 21:04:53 2002
+++ b/drivers/scsi/aic7xxx/aicasm/Makefile	Fri Nov  1 21:04:53 2002
@@ -7,7 +7,9 @@
 GENHDRS= y.tab.h aicdb.h
 
 SRCS=	${GENSRCS} ${CSRCS}
-CLEANFILES= ${GENSRCS} ${GENHDRS} y.output
+
+# Cleaned up by make clean
+clean-files := $(GENSRCS) $(GENHDRS) y.output $(PROG)
 # Override default kernel CFLAGS.  This is a userland app.
 AICASM_CFLAGS:= -I/usr/include -I. -ldb
 YFLAGS= -d
@@ -41,9 +43,6 @@
 	 else							\
 		echo "*** Install db development libraries";	\
 	 fi
-
-clean:
-	@rm -f $(CLEANFILES) $(PROG)
 
 y.tab.h aicasm_gram.c: aicasm_gram.y
 	$(YACC) $(YFLAGS) aicasm_gram.y

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.856   -> 1.857  
#	            Makefile	1.337   -> 1.338  
#	Documentation/DocBook/Makefile	1.36    -> 1.37   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	sam@mars.ravnborg.org	1.857
# docbook: *docs targets fixed, make clean works for docbook again
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Fri Nov  1 21:05:12 2002
+++ b/Documentation/DocBook/Makefile	Fri Nov  1 21:05:12 2002
@@ -160,8 +160,6 @@
 	$(patsubst %.fig,%.png, $(IMG-parportbook)) \
 	$(C-procfs-example)
 
-ifneq ($(wildcard $(BOOKS)),)
-clean-rule := rm -rf $(wildcard $(BOOKS))
+ifneq ($(wildcard $(patsubst %.html,%,$(HTML))),)
+clean-rule := rm -rf $(wildcard $(patsubst %.html,%,$(HTML)))
 endif
-
-include $(TOPDIR)/Rules.make
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Fri Nov  1 21:05:12 2002
+++ b/Makefile	Fri Nov  1 21:05:12 2002
@@ -798,7 +798,7 @@
 # Documentation targets
 # ---------------------------------------------------------------------------
 sgmldocs psdocs pdfdocs htmldocs: scripts
-	$(Q)$(MAKE) -f Documentation/DocBook/Makefile $@
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=Documentation/DocBook $@
 
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
