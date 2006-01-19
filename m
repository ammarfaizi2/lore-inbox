Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161290AbWASJxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161290AbWASJxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161296AbWASJxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:53:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:12809 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161290AbWASJxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:53:20 -0500
Date: Thu, 19 Jan 2006 10:53:10 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: fix /dev/null breakage
Message-ID: <20060119095310.GA11323@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch should fix all issues with /dev/null changing
permissions and becoming a rugulary file.
Thanks to Bryan for the gcc -print-file-name=libxxx.so idea!

To do the final check I still use a link. Just to make sure everything
is OK.
That may prove overkill, but left it as is for now.

Jan, Eyal, Jean, Bryan - thanks for testing/inputs!

PS. Feeling shitty, will push out after some sleep.

	Sam
	
diff --git a/scripts/kconfig/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
index fae3e29..bbf4887 100644
--- a/scripts/kconfig/lxdialog/Makefile
+++ b/scripts/kconfig/lxdialog/Makefile
@@ -2,8 +2,11 @@
 #
 
 check-lxdialog  := $(srctree)/$(src)/check-lxdialog.sh
-HOST_EXTRACFLAGS:= $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
-HOST_LOADLIBES  := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
+
+# Use reursively expanded variables so we do not call gcc unless
+# we really need to do so. (Do not call gcc as part of make mrproper)
+HOST_EXTRACFLAGS = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
+HOST_LOADLIBES   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
  
 HOST_EXTRACFLAGS += -DLOCALE 
 
diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
index 448e353..120d624 100644
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -4,17 +4,17 @@
 # What library to link
 ldflags()
 {
-	echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
+	$cc -print-file-name=libncursesw.so | grep -q /
 	if [ $? -eq 0 ]; then
 		echo '-lncursesw'
 		exit
 	fi
-	echo "main() {}" | $cc -lncurses -xc - -o /dev/null 2> /dev/null
+	$cc -print-file-name=libncurses.so | grep -q /
 	if [ $? -eq 0 ]; then
 		echo '-lncurses'
 		exit
 	fi
-	echo "main() {}" | $cc -lcurses -xc - -o /dev/null 2> /dev/null
+	$cc -print-file-name=libcurses.so | grep -q /
 	if [ $? -eq 0 ]; then
 		echo '-lcurses'
 		exit
@@ -36,10 +36,13 @@ ccflags()
 	fi
 }
 
-compiler=""
+# Temp file, try to clean up after us
+tmp=.lxdialog.tmp
+trap "rm -f $tmp" 0 1 2 3 15
+
 # Check if we can link to ncurses
 check() {
-	echo "main() {}" | $cc -xc - -o /dev/null 2> /dev/null
+	echo "main() {}" | $cc -xc - -o $tmp 2> /dev/null
 	if [ $? != 0 ]; then
 		echo " *** Unable to find the ncurses libraries."          1>&2
 		echo " *** make menuconfig require the ncurses libraries"  1>&2
@@ -59,6 +62,7 @@ if [ $# == 0 ]; then
 	exit 1
 fi
 
+cc=""
 case "$1" in
 	"-check")
 		shift
