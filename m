Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318157AbSGQAFc>; Tue, 16 Jul 2002 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSGQAFb>; Tue, 16 Jul 2002 20:05:31 -0400
Received: from bitmover.com ([192.132.92.2]:28853 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318157AbSGQAF3>;
	Tue, 16 Jul 2002 20:05:29 -0400
Date: Tue, 16 Jul 2002 17:08:21 -0700
From: Larry McVoy <lm@bitmover.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH for 2.4] fix find to not stumble over BK
Message-ID: <20020716170821.A8462@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

here's a backport of the patch I did for 2.5 which fixes up all the targets
in the top level Makefile which do things like 

	find dir dir2 -name '*.h' | xargs etags -

Note that common usage

	find . -name '*.[chS]' | whatever

becomes

	find . -name SCCS -prune -o -name BitKeeper -prune -o \
		-name '*.[chS]' -print | whatever
		                ^^^^^^

The -print is needed or find will produce nothing, it's now multiple clauses.

Please pull

	bk pull bk://linux.bkbits.net/lm-2.4

Here are the diffs:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.620   -> 1.621  
#	            Makefile	1.174   -> 1.175  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/16	lm@disks.bitmover.com	1.621
# Do not descend into BitKeeper/SCCS directories when running find
# to generate lists of files.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Jul 16 16:57:21 2002
+++ b/Makefile	Tue Jul 16 16:57:21 2002
@@ -367,16 +367,25 @@
 	$(MAKE) CFLAGS="$(CFLAGS) $(CFLAGS_KERNEL)" $(subst $@, _dir_$@, $@)
 
 TAGS: dummy
-	{ find include/asm-${ARCH} -name '*.h' -print ; \
-	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print ; \
-	find $(SUBDIRS) init arch/${ARCH} -name '*.[chS]' ; } | grep -v SCCS | etags -
+	{ find include/asm-${ARCH} \
+		-name SCCS -prune -o -name BitKeeper -prune -o \
+		-name '*.h' -print ; \
+	find include -name SCCS -prune -o -name BitKeeper -prune -o \
+		-type d \( -name "asm-*" -o -name config \) -prune -o \
+		-name '*.h' -print ; \
+	find $(SUBDIRS) init arch/${ARCH} \
+		-name SCCS -prune -o -name BitKeeper -prune -o \
+		-name '*.[chS]' -print ; } | etags -
 
 # Exuberant ctags works better with -I
 tags: dummy
 	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
-	ctags $$CTAGSF `find include/asm-$(ARCH) -name '*.h'` && \
-	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print | xargs ctags $$CTAGSF -a && \
-	find $(SUBDIRS) init -name '*.[ch]' | xargs ctags $$CTAGSF -a
+	ctags $$CTAGSF `find include/asm-$(ARCH) -name SCCS -prune -o -name BitKeeper -prune -o -name '*.h' -print` && \
+	find include -name SCCS -prune -o -name BitKeeper -prune -o \
+		-type d \( -name "asm-*" -o -name config \) -prune -o \
+		-name '*.h' -print | xargs ctags $$CTAGSF -a && \
+	find $(SUBDIRS) init -name SCCS -prune -o -name BitKeeper -prune -o \
+		-name '*.[ch]' -print | xargs ctags $$CTAGSF -a
 
 ifdef CONFIG_MODULES
 ifdef CONFIG_MODVERSIONS
@@ -440,23 +449,29 @@
 endif
 
 clean:	archclean
-	find . \( -name '*.[oas]' -o -name core -o -name '.*.flags' \) -type f -print \
+	find . -name SCCS -prune -o -name BitKeeper -prune -o \
+		\( -name '*.[oas]' -o -name core -o -name '.*.flags' \) \
+		-type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	rm -f $(CLEAN_FILES)
 	rm -rf $(CLEAN_DIRS)
 	$(MAKE) -C Documentation/DocBook clean
 
 mrproper: clean archmrproper
-	find . \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
+	find . -name SCCS -prune -o -name BitKeeper -prune -o \
+		\( -size 0 -o -name .depend \) \
+		-type f -print | xargs rm -f
 	rm -f $(MRPROPER_FILES)
 	rm -rf $(MRPROPER_DIRS)
 	$(MAKE) -C Documentation/DocBook mrproper
 
 distclean: mrproper
-	rm -f core `find . \( -not -type d \) -and \
+	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
+		\( -not -type d \) -and \
 		\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
-		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f -print` TAGS tags
+		-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f \
+		-print | xargs rm -f
 
 backup: mrproper
 	cd .. && tar cf - linux/ | gzip -9 > backup.gz
@@ -483,11 +498,12 @@
 	$(MAKE) -C Documentation/DocBook man
 
 sums:
-	find . -type f -print | sort | xargs sum > .SUMS
+	find . -name SCCS -prune -o -name BitKeeper -prune -o \
+		-type f -print | sort | xargs sum > .SUMS
 
 dep-files: scripts/mkdep archdep include/linux/version.h
 	scripts/mkdep -- init/*.c > .depend
-	scripts/mkdep -- `find $(FINDHPATH) -name SCCS -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	scripts/mkdep -- `find $(FINDHPATH) -name SCCS -prune -o -name BitKeeper -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
@@ -503,13 +519,19 @@
 depend dep: dep-files
 
 checkconfig:
-	find * -name '*.[hcS]' -type f -print | sort | xargs $(PERL) -w scripts/checkconfig.pl
+	find * -name SCCS -prune -o -name BitKeeper -prune -o \
+		-name '*.[hcS]' -type f -print \
+		| sort | xargs $(PERL) -w scripts/checkconfig.pl
 
 checkhelp:
-	find * -name [cC]onfig.in -print | sort | xargs $(PERL) -w scripts/checkhelp.pl
+	find * -name SCCS -prune -o -name BitKeeper -prune -o \
+		-name [cC]onfig.in -print \
+		| sort | xargs $(PERL) -w scripts/checkhelp.pl
 
 checkincludes:
-	find * -name '*.[hcS]' -type f -print | sort | xargs $(PERL) -w scripts/checkincludes.pl
+	find * -name SCCS -prune -o -name BitKeeper -prune -o \
+		-name '*.[hcS]' -type f -print \
+		| sort | xargs $(PERL) -w scripts/checkincludes.pl
 
 ifdef CONFIGURATION
 ..$(CONFIGURATION):
@@ -559,7 +581,9 @@
 #	   will become invalid
 #
 rpm:	clean spec
-	find . \( -size 0 -o -name .depend -o -name .hdepend \) -type f -print | xargs rm -f
+	find . -name SCCS -prune -o -name BitKeeper -prune -o \
+		\( -size 0 -o -name .depend -o -name .hdepend \) \
+		-type f -print | xargs rm -f
 	set -e; \
 	cd $(TOPDIR)/.. ; \
 	ln -sf $(TOPDIR) $(KERNELPATH) ; \
