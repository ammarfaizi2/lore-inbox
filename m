Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSELKMI>; Sun, 12 May 2002 06:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSELKMH>; Sun, 12 May 2002 06:12:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:38156 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312381AbSELKMH>;
	Sun, 12 May 2002 06:12:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Axel H. Siebenwirth" <axel@hh59.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends 
In-Reply-To: Your message of "Sun, 12 May 2002 11:04:50 +0200."
             <20020512090450.GA481@neon> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 20:11:46 +1000
Message-ID: <22198.1021198306@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 11:04:50 +0200, 
"Axel H. Siebenwirth" <axel@hh59.org> wrote:
>make: *** No rule to make target .tmp_include_depends', needed by
>=1Fdir_kernel'.  Stop.

Missed one occurrence of .tmp_include_depends.  Edit Makefile, find
$(patsubst %, _dir_%, $(SUBDIRS)) and change .tmp_include_depends to
tmp_include_depends (no '.' at start).

Corrected patch against 2.4.19-pre8-ac2.

diff -ur 2.4.19-pre8-ac2/Makefile 2.4.19-pre8-ac2-test/Makefile
--- 2.4.19-pre8-ac2/Makefile	Sun May 12 20:02:13 2002
+++ 2.4.19-pre8-ac2-test/Makefile	Sun May 12 20:04:44 2002
@@ -226,6 +226,7 @@
 # files removed with 'make mrproper'
 MRPROPER_FILES = \
 	include/linux/autoconf.h include/linux/version.h \
+	tmp* \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
@@ -317,7 +318,7 @@
 
 linuxsubdirs: $(patsubst %, _dir_%, $(SUBDIRS))
 
-$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h .tmp_include_depends
+$(patsubst %, _dir_%, $(SUBDIRS)) : dummy include/linux/version.h tmp_include_depends
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" -C $(patsubst _dir_%, %, $@)
 
 $(TOPDIR)/include/linux/version.h: include/linux/version.h
@@ -353,13 +354,13 @@
 
 comma	:= ,
 
-init/version.o: init/version.c include/linux/compile.h .tmp_include_depends
+init/version.o: init/version.c include/linux/compile.h tmp_include_depends
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o init/version.o init/version.c
 
-init/main.o: init/main.c .tmp_include_depends
+init/main.o: init/main.c tmp_include_depends
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
 
-init/do_mounts.o: init/do_mounts.c .tmp_include_depends
+init/do_mounts.o: init/do_mounts.c tmp_include_depends
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
 
 fs lib mm ipc kernel drivers net: dummy
@@ -386,7 +387,7 @@
 modules: $(patsubst %, _mod_%, $(SUBDIRS))
 
 .PHONY: $(patsubst %, _mod_%, $(SUBDIRS))
-$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h .tmp_include_depends
+$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h tmp_include_depends
 	$(MAKE) -C $(patsubst _mod_%, %, $@) CFLAGS="$(CFLAGS) $(MODFLAGS)" MAKING_MODULES=1 modules
 
 .PHONY: modules_install
@@ -491,13 +492,13 @@
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
 endif
-	(find $(TOPDIR) \( -name .depend -o -name .hdepend \) -print | xargs $(AWK) -f scripts/include_deps) > .tmp_include_depends
-	sed -ne 's/^\([^ ].*\):.*/  \1 \\/p' .tmp_include_depends > .tmp_include_depends_1
-	(echo ""; echo "all: \\"; cat .tmp_include_depends_1; echo "") >> .tmp_include_depends
-	rm .tmp_include_depends_1
+	(find $(TOPDIR) \( -name .depend -o -name .hdepend \) -print | xargs $(AWK) -f scripts/include_deps) > tmp_include_depends
+	sed -ne 's/^\([^ ].*\):.*/  \1 \\/p' tmp_include_depends > tmp_include_depends_1
+	(echo ""; echo "all: \\"; cat tmp_include_depends_1; echo "") >> tmp_include_depends
+	rm tmp_include_depends_1
 
-.tmp_include_depends: include/config/MARKER dummy
-	$(MAKE) -r -f .tmp_include_depends all
+tmp_include_depends: include/config/MARKER dummy
+	$(MAKE) -r -f tmp_include_depends all
 
 ifdef CONFIG_MODVERSIONS
 MODVERFILE := $(TOPDIR)/include/linux/modversions.h

