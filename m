Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161371AbWASUE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbWASUE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161377AbWASUE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:04:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:10251 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161371AbWASUE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:04:26 -0500
Date: Thu, 19 Jan 2006 21:04:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] kconfig: fix /dev/null breakage
Message-ID: <20060119200418.GB3557@mars.ravnborg.org>
References: <20060119200216.GA3557@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119200216.GA3557@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 1/3] kconfig: fix /dev/null breakage

While running "make menuconfig" and "make mrproper"
some people experienced that /dev/null suddenly changed
permissions or suddenly became a regular file.
The main reason was that /dev/null was used as output
to gcc in the check-lxdialog.sh script and gcc did
some strange things with the output file; in this
case /dev/null when it errorred out.

Following patch implements a suggestion
from Bryan O'Sullivan <bos@serpentine.com> to
use gcc -print-file-name=libxxx.so.

Also the Makefile is adjusted to not resolve value of
HOST_EXTRACFLAGS and HOST_LOADLIBES until they are actually used.
This prevents us from calling gcc when running make *clean/mrproper

Thanks to Eyal Lebedinsky <eyal@eyal.emu.id.au> and
Jean Delvare <khali@linux-fr.org> for the first error reports.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/kconfig/lxdialog/Makefile          |    7 +++++--
 scripts/kconfig/lxdialog/check-lxdialog.sh |   14 +++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

ec29b10f689f292accf9af0bc1c00e7815f6be7b
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
-- 
1.0.GIT
