Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTAUAzL>; Mon, 20 Jan 2003 19:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbTAUAzL>; Mon, 20 Jan 2003 19:55:11 -0500
Received: from ca-tours-2-158.abo.wanadoo.fr ([80.8.7.158]:17029 "EHLO
	walhalla.agaha") by vger.kernel.org with ESMTP id <S266940AbTAUAzK>;
	Mon, 20 Jan 2003 19:55:10 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.4] Speedup 'make dep'
From: Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@Jaluna.com>
Organization: Jaluna
Date: 21 Jan 2003 02:03:42 +0100
In-Reply-To: <3E2BDF17.60501@namesys.com>
Message-ID: <lnlm1ffh5d.fsf@walhalla.agaha>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo,

During 'make dep', make spends most of its time (sometimes more
than 75%) uselessly analysing .hdepend. Delaying its production
makes 'make dep' much faster.
The following patch also builds .depend last, in order to make
the dependency information generation more resistant against
^C and other failures.

Regards,

  -- Benoit

diff -ru linux-2.4.20/Makefile linux-2.4.20-bpc/Makefile
--- linux-2.4.20/Makefile	2003-01-10 22:32:25.000000000 +0100
+++ linux-2.4.20-bpc/Makefile	2003-01-20 09:52:43.000000000 +0100
@@ -488,12 +488,13 @@
 	find . -type f -print | sort | xargs sum > .SUMS
 
 dep-files: scripts/mkdep archdep include/linux/version.h
-	scripts/mkdep -- init/*.c > .depend
-	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	rm -f .depend .hdepend
 	$(MAKE) $(patsubst %,_sfdep_%,$(SUBDIRS)) _FASTDEP_ALL_SUB_DIRS="$(SUBDIRS)"
 ifdef CONFIG_MODVERSIONS
 	$(MAKE) update-modverfile
 endif
+	scripts/mkdep -- `find $(FINDHPATH) \( -name SCCS -o -name .svn \) -prune -o -follow -name \*.h ! -name modversions.h -print` > .hdepend
+	scripts/mkdep -- init/*.c > .depend
 
 ifdef CONFIG_MODVERSIONS
 MODVERFILE := $(TOPDIR)/include/linux/modversions.h

