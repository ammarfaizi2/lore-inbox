Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWAOVY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWAOVY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWAOVY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:24:59 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:16145 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750898AbWAOVY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:24:59 -0500
Date: Sun, 15 Jan 2006 22:24:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: get rid of stray a.out, support ncursesw
Message-ID: <20060115212455.GA26627@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[It is pushed out at:
git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git]

scripts/kconfig/lxdialog/check-lxdialog.sh uses gcc to check for
what libraries are present. Redirect output to /dev/null
so we do not generate an a.out.
Also included support for ncursesw - so if present prefer that
instead of ncurses.
The order is now (first is preferred):
1) ncursesw
2) ncurses
3) curses

The latter is to support SunOS.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/kconfig/lxdialog/Makefile          |    6 +++---
 scripts/kconfig/lxdialog/check-lxdialog.sh |   23 ++++++++++++++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

60f33b80443a3e7e79e2a3ddc625ab6246a61d3d
diff --git a/scripts/kconfig/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
index 8f41d9a..fae3e29 100644
--- a/scripts/kconfig/lxdialog/Makefile
+++ b/scripts/kconfig/lxdialog/Makefile
@@ -1,9 +1,9 @@
 # Makefile to build lxdialog package
 #
 
-check-lxdialog   := $(srctree)/$(src)/check-lxdialog.sh
-HOST_EXTRACFLAGS := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
-HOST_LOADLIBES   := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags)
+check-lxdialog  := $(srctree)/$(src)/check-lxdialog.sh
+HOST_EXTRACFLAGS:= $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
+HOST_LOADLIBES  := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
  
 HOST_EXTRACFLAGS += -DLOCALE 
 
diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
index a3c141b..448e353 100644
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -4,11 +4,22 @@
 # What library to link
 ldflags()
 {
-	if [ `uname` == SunOS ]; then
-		echo '-lcurses'
-	else
+	echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo '-lncursesw'
+		exit
+	fi
+	echo "main() {}" | $cc -lncurses -xc - -o /dev/null 2> /dev/null
+	if [ $? -eq 0 ]; then
 		echo '-lncurses'
+		exit
 	fi
+	echo "main() {}" | $cc -lcurses -xc - -o /dev/null 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo '-lcurses'
+		exit
+	fi
+	exit 1
 }
 
 # Where is ncurses.h?
@@ -28,7 +39,7 @@ ccflags()
 compiler=""
 # Check if we can link to ncurses
 check() {
-	echo "main() {}" | $compiler -xc -
+	echo "main() {}" | $cc -xc - -o /dev/null 2> /dev/null
 	if [ $? != 0 ]; then
 		echo " *** Unable to find the ncurses libraries."          1>&2
 		echo " *** make menuconfig require the ncurses libraries"  1>&2
@@ -51,13 +62,15 @@ fi
 case "$1" in
 	"-check")
 		shift
-		compiler="$@"
+		cc="$@"
 		check
 		;;
 	"-ccflags")
 		ccflags
 		;;
 	"-ldflags")
+		shift
+		cc="$@"
 		ldflags
 		;;
 	"*")
-- 
1.0.GIT

