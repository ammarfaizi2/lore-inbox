Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277369AbRJJVWw>; Wed, 10 Oct 2001 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277127AbRJJVWm>; Wed, 10 Oct 2001 17:22:42 -0400
Received: from a29102.upc-a.chello.nl ([62.163.29.102]:18569 "EHLO
	nerys.ehv.lx") by vger.kernel.org with ESMTP id <S276075AbRJJVWb>;
	Wed, 10 Oct 2001 17:22:31 -0400
Date: Wed, 10 Oct 2001 23:22:59 +0200
Message-Id: <200110102122.f9ALMx424058@nerys.ehv.lx>
From: Rudi Sluijtman <rudi@sluijtman.com>
To: linux-kernel@vger.kernel.org
X-Mailer: GNU Emacs 20.7.1
Subject: [patch] .version, newversion in Makefile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Due to a change in the main Makefile the .version file is overwritten
by a new empty one since at least 2.4.10-pre12, so the version becomes
or remains 1 after each recompile.

>From the xfs cvs tree (http://oss.sgi.com/cgi-bin/cvsweb.cgi/linux-2.4-xfs/):

> --- linux-2.4-xfs/linux/Makefile        2001/09/17 02:09:52     1.123
> +++ linux-2.4-xfs/linux/Makefile        2001/09/21 16:28:50     1.124
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 4
>  SUBLEVEL = 10
> -EXTRAVERSION =-pre10-xfs
> +EXTRAVERSION =-pre12-xfs
>   .
>   .
>  newversion:
> -       @if [ ! -f .version ]; then \
> -               echo 1 > .version; \
> -       else \
> -               expr 0`cat .version` + 1 > .version; \
> -       fi
> +       . scripts/mkversion > .version

The script does the same as the lines in the Makefile, except that it does
not specify stdout.

The script cats .version, but, this has just been overwritten because of
the redirection: "scripts/mkversion > .version", so it is empty before
the script can read it.

I do no know why the lines in the Makefile have been moved to a script,
but this is obviously not the way to do it.

A small change to mkversion and leaving out the "> .version" in the
Makefile for instance can do the trick:

A patch for this against linux-2.4.11:

diff -u --recursive --new-file linux-2.4.11/Makefile linux/Makefile
--- linux-2.4.11/Makefile	Wed Oct 10 22:59:03 2001
+++ linux/Makefile	Wed Oct 10 23:01:58 2001
@@ -300,7 +300,7 @@
 $(TOPDIR)/include/linux/compile.h: include/linux/compile.h
 
 newversion:
-	. scripts/mkversion > .version
+	. scripts/mkversion
 
 include/linux/compile.h: $(CONFIGURATION) include/linux/version.h newversion
 	@echo -n \#define UTS_VERSION \"\#`cat .version` > .ver
@@ -530,6 +530,6 @@
 	tar -cvz --exclude CVS -f $(KERNELPATH).tar.gz $(KERNELPATH)/. ; \
 	rm $(KERNELPATH) ; \
 	cd $(TOPDIR) ; \
-	. scripts/mkversion > .version ; \
+	. scripts/mkversion ; \
 	rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
 	rm $(TOPDIR)/../$(KERNELPATH).tar.gz
diff -u --recursive --new-file linux-2.4.11/scripts/mkversion linux/scripts/mkversion
--- linux-2.4.11/scripts/mkversion	Wed Oct 10 22:59:34 2001
+++ linux/scripts/mkversion	Wed Oct 10 23:03:30 2001
@@ -1,6 +1,6 @@
 if [ ! -f .version ]
 then
-    echo 1
+    echo 1 > .version
 else
-    expr 0`cat .version` + 1
+    expr 0`cat .version` + 1 > .version
 fi

