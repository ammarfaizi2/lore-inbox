Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWAKQzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWAKQzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWAKQzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:55:33 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51730 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751354AbWAKQzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:55:32 -0500
Date: Wed, 11 Jan 2006 17:55:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] kconfig: factor out ncurses check in a shell script
Message-ID: <20060111165513.GA18184@mars.ravnborg.org>
References: <11368426843316@foobar.com> <Pine.LNX.4.61.0601102127230.16049@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601102127230.16049@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:27:42PM +0100, Jan Engelhardt wrote:
> >
> >Cleaning up the lxdialog Makefile by factoring out the
> >ncurses compatibility checks.
> >This made the checks much more obvious and easier to extend.
> 
> BTW, do you know a nice way to detect ncursesw?
Something like this?

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
index a3c141b..3f172f1 100644
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -4,11 +4,22 @@
 # What library to link
 ldflags()
 {
-	if [ `uname` == SunOS ]; then
-		echo '-lcurses'
-	else
+	echo "main() {}" | $compiler -lncursesw -xc - 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo '-lncursesw'
+		exit
+	fi
+	echo "main() {}" | $compiler -lncurses -xc - 2> /dev/null
+	if [ $? -eq 0 ]; then
 		echo '-lncurses'
+		exit
+	fi
+	echo "main() {}" | $compiler -lcurses -xc - 2> /dev/null
+	if [ $? -eq 0 ]; then
+		echo '-lcurses'
+		exit
 	fi
+	exit 1
 }
 
 # Where is ncurses.h?
@@ -58,6 +69,8 @@ case "$1" in
 		ccflags
 		;;
 	"-ldflags")
+		shift
+		compiler="$@"
 		ldflags
 		;;
 	"*")
