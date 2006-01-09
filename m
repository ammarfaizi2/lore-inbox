Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWAIViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWAIViV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWAIViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:38:21 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:22031 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750720AbWAIViU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:20 -0500
Subject: [PATCH 01/11] kconfig: factor out ncurses check in a shell script
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:04 +0100
Message-Id: <11368426843316@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleaning up the lxdialog Makefile by factoring out the
ncurses compatibility checks.
This made the checks much more obvious and easier to extend.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/kconfig/lxdialog/Makefile          |   48 +++++---------------
 scripts/kconfig/lxdialog/check-lxdialog.sh |   67 ++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 36 deletions(-)
 create mode 100644 scripts/kconfig/lxdialog/check-lxdialog.sh

ae215b14bdbd459afe5f371175765fae817062a8
diff --git a/scripts/kconfig/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
index a45a13f..8f41d9a 100644
--- a/scripts/kconfig/lxdialog/Makefile
+++ b/scripts/kconfig/lxdialog/Makefile
@@ -1,42 +1,18 @@
-HOST_EXTRACFLAGS := -DLOCALE 
-ifeq ($(shell uname),SunOS)
-HOST_LOADLIBES   := -lcurses
-else
-HOST_LOADLIBES   := -lncurses
-endif
+# Makefile to build lxdialog package
+#
 
-ifeq (/usr/include/ncurses/ncurses.h, $(wildcard /usr/include/ncurses/ncurses.h))
-        HOST_EXTRACFLAGS += -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>"
-else
-ifeq (/usr/include/ncurses/curses.h, $(wildcard /usr/include/ncurses/curses.h))
-        HOST_EXTRACFLAGS += -I/usr/include/ncurses -DCURSES_LOC="<ncurses/curses.h>"
-else
-ifeq (/usr/include/ncurses.h, $(wildcard /usr/include/ncurses.h))
-        HOST_EXTRACFLAGS += -DCURSES_LOC="<ncurses.h>"
-else
-	HOST_EXTRACFLAGS += -DCURSES_LOC="<curses.h>"
-endif
-endif
-endif
+check-lxdialog   := $(srctree)/$(src)/check-lxdialog.sh
+HOST_EXTRACFLAGS := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
+HOST_LOADLIBES   := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags)
+ 
+HOST_EXTRACFLAGS += -DLOCALE 
+
+.PHONY: dochecklxdialog
+$(obj)/dochecklxdialog:
+	$(Q)$(CONFIG_SHELL) $(check-lxdialog) -check $(HOSTCC) $(HOST_LOADLIBES)
 
 hostprogs-y	:= lxdialog
-always		:= ncurses $(hostprogs-y)
+always		:= $(hostprogs-y) dochecklxdialog
 
 lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
 		 util.o lxdialog.o msgbox.o
-
-.PHONY: $(obj)/ncurses
-$(obj)/ncurses:
-	@echo "main() {}" > lxtemp.c
-	@if $(HOSTCC) lxtemp.c  $(HOST_LOADLIBES); then \
-		rm -f lxtemp.c a.out; \
-	else \
-		rm -f lxtemp.c; \
-		echo -e "\007" ;\
-		echo ">> Unable to find the Ncurses libraries." ;\
-		echo ">>" ;\
-		echo ">> You must install ncurses-devel in order" ;\
-		echo ">> to use 'make menuconfig'" ;\
-		echo ;\
-		exit 1 ;\
-	fi
diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
new file mode 100644
index 0000000..a3c141b
--- /dev/null
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# Check ncurses compatibility
+
+# What library to link
+ldflags()
+{
+	if [ `uname` == SunOS ]; then
+		echo '-lcurses'
+	else
+		echo '-lncurses'
+	fi
+}
+
+# Where is ncurses.h?
+ccflags()
+{
+	if [ -f /usr/include/ncurses/ncurses.h ]; then
+		echo '-I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>"'
+	elif [ -f /usr/include/ncurses/curses.h ]; then
+		echo '-I/usr/include/ncurses -DCURSES_LOC="<ncurses/curses.h>"'
+	elif [ -f /usr/include/ncurses.h ]; then
+		echo '-DCURSES_LOC="<ncurses.h>"'
+	else
+		echo '-DCURSES_LOC="<curses.h>"'
+	fi
+}
+
+compiler=""
+# Check if we can link to ncurses
+check() {
+	echo "main() {}" | $compiler -xc -
+	if [ $? != 0 ]; then
+		echo " *** Unable to find the ncurses libraries."          1>&2
+		echo " *** make menuconfig require the ncurses libraries"  1>&2
+		echo " *** "                                               1>&2
+		echo " *** Install ncurses (ncurses-devel) and try again"  1>&2
+		echo " *** "                                               1>&2
+		exit 1
+	fi
+}
+
+usage() {
+	printf "Usage: $0 [-check compiler options|-header|-library]\n"
+}
+
+if [ $# == 0 ]; then
+	usage
+	exit 1
+fi
+
+case "$1" in
+	"-check")
+		shift
+		compiler="$@"
+		check
+		;;
+	"-ccflags")
+		ccflags
+		;;
+	"-ldflags")
+		ldflags
+		;;
+	"*")
+		usage
+		exit 1
+		;;
+esac
-- 
1.0.GIT

