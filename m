Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbQJaKz7>; Tue, 31 Oct 2000 05:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129797AbQJaKzk>; Tue, 31 Oct 2000 05:55:40 -0500
Received: from lsne-cable-1-p21.vtxnet.ch ([212.147.5.21]:43281 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129789AbQJaKzc>;
	Tue, 31 Oct 2000 05:55:32 -0500
Date: Tue, 31 Oct 2000 11:55:24 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make updateconfig (for recent 2.4.0-test* kernels)
Message-ID: <20001031115524.B8753@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a little patch I've been using for a while, and which some
people may find useful. It's mainly good for helping with that feeling
that you might miss something when you simply make oldconfig. Any
self-respecting control freak will understand why this is
important ;-)

What this patch does:
 - adds -D option to scripts/Configure.
 - adds  make updateconfig  and synonymous  make updconfig  targets to
   invoke scripts/Configure with -D

Configure -D works like -d (i.e. like  make oldconfig ) but prints all
options referenced in the old .config, but missing in the new .config.
So you'll know if something that used to be configurable at build time
now is configured at run time, auto-configures, or such, or if a whole
set of options has disappeared, e.g. because of an added dependency or
a new option where you gave the wrong answer.

Known problems: also reports certain options which were written to the
old .config by mistake (or, rather, by a configurator using different
visibility rules), e.g. xconfig adds CONFIG_JFFS_FS_VERBOSE even if
CONFIG_JFFS_FS is not set.

Q: Why don't you just use  diff .config.old .config  ?
A: This would work if the previous .config file was obtained from
   Configure, but menuconfig already leaves some clutter, and a diff
   for a .config obtained from xconfig wouldn't be useful without
   serious post-processing. Also, a diff repeats new options, which
   were already handled by Configure.

- Werner

---------------------------------- cut here -----------------------------------

--- linux/Makefile.orig	Thu Aug 31 18:09:34 2000
+++ linux/Makefile	Thu Aug 31 18:09:51 2000
@@ -220,6 +220,9 @@
 oldconfig: symlinks
 	$(CONFIG_SHELL) scripts/Configure -d arch/$(ARCH)/config.in
 
+updconfig updateconfig: symlinks
+	$(CONFIG_SHELL) scripts/Configure -D arch/$(ARCH)/config.in
+
 xconfig: symlinks
 	$(MAKE) -C scripts kconfig.tk
 	wish -f scripts/kconfig.tk
--- linux/scripts/Configure.orig	Thu Aug 31 17:55:44 2000
+++ linux/scripts/Configure	Thu Aug 31 18:09:10 2000
@@ -115,7 +115,7 @@
 #	readln prompt default oldval
 #
 function readln () {
-	if [ "$DEFAULT" = "-d" -a -n "$3" ]; then
+	if [ ! -z "$DEFAULT" -a -n "$3" ]; then
 		echo "$1"
 		ans=$2
 	else
@@ -526,8 +526,8 @@
 echo "#define AUTOCONF_INCLUDED" >> $CONFIG_H
 
 DEFAULT=""
-if [ "$1" = "-d" ] ; then
-	DEFAULT="-d"
+if [ "$1" = "-d" -o "$1" = "-D" ] ; then
+	DEFAULT=$1
 	shift
 fi
 
@@ -557,10 +557,24 @@
 
 . $CONFIG_IN
 
+if [ "$DEFAULT" = -D -a -f $DEFAULTS ]; then
+    sed 's/^# CONFIG_/CONFIG_/;p' <.tmpconfig | cat $DEFAULTS - |
+      sed 's/[#=].*//' | sort | uniq -u >.tmpmissing
+    if [ -s .tmpmissing ]; then
+	echo
+	echo "#"
+	echo "# Unused variables (found in $DEFAULTS)"
+	echo "#"
+	cat .tmpmissing
+    fi
+    rm -f .tmpmissing
+fi
+
 rm -f .config.old
 if [ -f .config ]; then
 	mv .config .config.old
 fi
+
 mv .tmpconfig .config
 mv .tmpconfig.h include/linux/autoconf.h
 

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
