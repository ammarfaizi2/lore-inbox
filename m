Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129837AbRCCXJJ>; Sat, 3 Mar 2001 18:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbRCCXI7>; Sat, 3 Mar 2001 18:08:59 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:2064 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129837AbRCCXIt>;
	Sat, 3 Mar 2001 18:08:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
cc: lkml <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] 2.4.3-pre1 dependencies are broken 
In-Reply-To: Your message of "Sun, 04 Mar 2001 05:16:37 +1100."
             <3AA13505.62109EEC@uow.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Mar 2001 10:08:42 +1100
Message-ID: <20642.983660922@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Mar 2001 05:16:37 +1100, 
Andrew Morton <andrewm@uow.edu.au> wrote:
>mkdep has got itself a new feature, but the makefiles haven't
>been updated.

Linus took the change to mkdep.c but missed the associated Makefile and
Rules.Make changes.  This patch brings 2.4.3-pre1 up to date with my
mkdep changes.

Index: 3-pre1.1/drivers/acpi/Makefile
--- 3-pre1.1/drivers/acpi/Makefile Tue, 23 Jan 2001 13:26:27 +1100 kaos (linux-2.4/s/b/51_Makefile 1.2 644)
+++ 3-pre1.1(w)/drivers/acpi/Makefile Sun, 04 Mar 2001 10:02:07 +1100 kaos (linux-2.4/s/b/51_Makefile 1.3 644)
@@ -20,14 +20,6 @@ EXTRA_CFLAGS += -I./include
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
 
-# genksyms only reads $(CFLAGS), it should really read $(EXTRA_CFLAGS) as well.
-# Without EXTRA_CFLAGS the gcc pass for genksyms fails, resulting in an empty
-# include/linux/modules/acpi_ksyms.ver.  Changing genkyms to use EXTRA_CFLAGS
-# will hit everything, too risky in 2.4.0-prerelease.  Bandaid by tweaking
-# CFLAGS only for .ver targets.  Review after 2.4.0 release.  KAO
-
-$(MODINCL)/%.ver: CFLAGS := -I./include $(CFLAGS)
-
 acpi-subdirs := common dispatcher events hardware \
 		interpreter namespace parser resources tables
 
Index: 3-pre1.1/Rules.make
--- 3-pre1.1/Rules.make Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1 644)
+++ 3-pre1.1(w)/Rules.make Sun, 04 Mar 2001 10:02:09 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.2 644)
@@ -123,7 +123,7 @@ endif
 # This make dependencies quickly
 #
 fastdep: dummy
-	$(TOPDIR)/scripts/mkdep $(wildcard *.[chS] local.h.master) > .depend
+	$(TOPDIR)/scripts/mkdep $(CFLAGS) $(EXTRA_CFLAGS) -- $(wildcard *.[chS]) > .depend
 ifdef ALL_SUB_DIRS
 	$(MAKE) $(patsubst %,_sfdep_%,$(ALL_SUB_DIRS)) _FASTDEP_ALL_SUB_DIRS="$(ALL_SUB_DIRS)"
 endif
@@ -222,9 +222,9 @@ endif
 
 $(MODINCL)/%.ver: %.c
 	@if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ]; then \
-		echo '$(CC) $(CFLAGS) -E -D__GENKSYMS__ $<'; \
+		echo '$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $<'; \
 		echo '| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp'; \
-		$(CC) $(CFLAGS) -E -D__GENKSYMS__ $< \
+		$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $< \
 		| $(GENKSYMS) $(genksyms_smp_prefix) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp; \
 		if [ -r $@ ] && cmp -s $@ $@.tmp; then echo $@ is unchanged; rm -f $@.tmp; \
 		else echo mv $@.tmp $@; mv -f $@.tmp $@; fi; \
Index: 3-pre1.1/Makefile
--- 3-pre1.1/Makefile Sun, 04 Mar 2001 09:56:10 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.15.1.2.2.1 644)
+++ 3-pre1.1(w)/Makefile Sun, 04 Mar 2001 10:03:18 +1100 kaos (linux-2.4/T/c/50_Makefile 1.1.2.16 644)
@@ -440,8 +440,8 @@ sums:
 	find . -type f -print | sort | xargs sum > .SUMS
 
 dep-files: scripts/mkdep archdep include/linux/version.h
-	scripts/mkdep init/*.c > .depend
-	scripts/mkdep `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	scripts/mkdep -- init/*.c > .depend
+	scripts/mkdep -- `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile

