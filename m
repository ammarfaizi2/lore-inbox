Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSIJVG6>; Tue, 10 Sep 2002 17:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSIJVGw>; Tue, 10 Sep 2002 17:06:52 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:44045 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318131AbSIJVGp>;
	Tue, 10 Sep 2002 17:06:45 -0400
Date: Tue, 10 Sep 2002 23:11:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Distibuted clean and mrproper handling 6/6
Message-ID: <20020910231125.F18386@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910225530.A17094@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 10, 2002 at 10:55:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The makefiles that know what files to be deleted does now 
specify them using
clean := files
and
mrproper := files

Additionally all programs build using host-progs are deleted as well.
This allowed us to remove a central list of files in the top-level makefile,
and by moving the responsibility out to the makefiles that has the knowledge
there is a good chance the information will stay updated.

	Sam

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Sep 10 22:38:08 2002
+++ b/Makefile	Tue Sep 10 22:38:08 2002
@@ -604,41 +604,11 @@
 CLEAN_FILES += \
 	include/linux/compile.h \
 	vmlinux System.map \
-	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
-	drivers/char/conmakehash \
-	drivers/char/drm/*-mod.c \
-	drivers/char/defkeymap.c drivers/char/qtronixmap.c \
-	drivers/pci/devlist.h drivers/pci/classlist.h drivers/pci/gen-devlist \
-	drivers/zorro/devlist.h drivers/zorro/gen-devlist \
-	sound/oss/bin2hex sound/oss/hex2hex \
-	drivers/atm/fore200e_mkfirm drivers/atm/{pca,sba}*{.bin,.bin1,.bin2} \
-	drivers/scsi/aic7xxx/aic7xxx_seq.h \
-	drivers/scsi/aic7xxx/aic7xxx_reg.h \
-	drivers/scsi/aic7xxx/aicasm/aicasm_gram.c \
-	drivers/scsi/aic7xxx/aicasm/aicasm_scan.c \
-	drivers/scsi/aic7xxx/aicasm/y.tab.h \
-	drivers/scsi/aic7xxx/aicasm/aicasm \
-	drivers/scsi/53c700_d.h drivers/scsi/sim710_d.h \
-	drivers/scsi/53c7xx_d.h drivers/scsi/53c7xx_u.h \
-	drivers/scsi/53c8xx_d.h drivers/scsi/53c8xx_u.h \
-	net/802/cl2llc.c net/802/transit/pdutr.h net/802/transit/timertr.h \
-	net/802/pseudo/pseudocode.h \
-	net/khttpd/make_times_h net/khttpd/times.h \
 	submenu*
 
 # 	files removed with 'make mrproper'
 MRPROPER_FILES += \
 	include/linux/autoconf.h include/linux/version.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
-	drivers/net/hamradio/soundmodem/gentbl \
-	sound/oss/*_boot.h sound/oss/.*.boot \
-	sound/oss/msndinit.c \
-	sound/oss/msndperm.c \
-	sound/oss/pndsperm.c \
-	sound/oss/pndspini.c \
-	drivers/atm/fore200e_*_fw.c drivers/atm/.fore200e_*.fw \
 	.version .config* config.in config.old \
 	.menuconfig.log \
 	include/asm \
@@ -658,6 +628,8 @@
 
 clean:	archclean
 	@echo 'Cleaning up'
+	@if [ -f $(obj)/.$@ ]; then rm -f `cat $(obj)/.$@`; fi;
+	@rm -f $(obj)/.$@
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
 		-name .\*.tmp -o -name .\*.d \) -type f -print \
@@ -667,12 +639,13 @@
 
 mrproper: clean archmrproper
 	@echo 'Making mrproper'
+	@if [ -f $(obj)/.$@ ]; then rm -f `cat $(obj)/.$@`; fi;
+	@rm -f .$@
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name .depend -o -name .\*.cmd \) \
 		-type f -print | xargs rm -f
 	@rm -f $(MRPROPER_FILES)
 	@rm -rf $(MRPROPER_DIRS)
-	@$(MAKE) -C scripts mrproper
 	@$(MAKE) -f Documentation/DocBook/Makefile mrproper
 
 distclean: mrproper
