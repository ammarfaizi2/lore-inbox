Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWARMmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWARMmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWARMmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:42:51 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:41746 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932390AbWARMmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:42:50 -0500
Date: Wed, 18 Jan 2006 13:42:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Jean Delvare <khali@linux-fr.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060118124242.GA12752@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org> <43CE2556.9070700@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43CE2556.9070700@eyal.emu.id.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eyal, Jean.


> 
> content of /tmp/xxx
> ===================
> 
> ldflags 1
> crw-rw-rw-  1 root root 1, 3 Jan 18 22:20 /dev/null
> ldflags 3
> ls: /dev/null: No such file or directory
> ldflags 4
> -rwxr-xr-x  1 root root 11650 Jan 18 22:20 /dev/null

Following patch fix it.
We now evaluate the value of the variabls only when needed.
And gcc do not use '-o /dev/null' since this is not good.

	Sam

diff --git a/scripts/kconfig/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
index fae3e29..3441b56 100644
--- a/scripts/kconfig/lxdialog/Makefile
+++ b/scripts/kconfig/lxdialog/Makefile
@@ -2,8 +2,11 @@
 #
 
 check-lxdialog  := $(srctree)/$(src)/check-lxdialog.sh
-HOST_EXTRACFLAGS:= $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
-HOST_LOADLIBES  := $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
+
+#¤ Use reursively expanded variables so we do not call gcc unless
+# we really need to do so. (Do not call gcc as part of make mrproper)
+HOST_EXTRACFLAGS = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags)
+HOST_LOADLIBES   = $(shell $(CONFIG_SHELL) $(check-lxdialog) -ldflags $(HOSTCC))
  
 HOST_EXTRACFLAGS += -DLOCALE 
 
diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
index 448e353..0ec6552 100644
--- a/scripts/kconfig/lxdialog/check-lxdialog.sh
+++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
@@ -1,20 +1,24 @@
 #!/bin/sh
 # Check ncurses compatibility
 
+# Temp file, try to clean up after us
+tmp=.lxdialog.tmp
+trap "rm -f $tmp" 0 1 2 3 15
+
 # What library to link
 ldflags()
 {
-	echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
+	echo "main() {}" | $cc -lncursesw -xc - -o $tmp 2> /dev/null
 	if [ $? -eq 0 ]; then
 		echo '-lncursesw'
 		exit
 	fi
-	echo "main() {}" | $cc -lncurses -xc - -o /dev/null 2> /dev/null
+	echo "main() {}" | $cc -lncurses -xc - -o $tmp 2> /dev/null
 	if [ $? -eq 0 ]; then
 		echo '-lncurses'
 		exit
 	fi
-	echo "main() {}" | $cc -lcurses -xc - -o /dev/null 2> /dev/null
+	echo "main() {}" | $cc -lcurses -xc - -o $tmp 2> /dev/null
 	if [ $? -eq 0 ]; then
 		echo '-lcurses'
 		exit
@@ -39,7 +43,7 @@ ccflags()
 compiler=""
 # Check if we can link to ncurses
 check() {
-	echo "main() {}" | $cc -xc - -o /dev/null 2> /dev/null
+	echo "main() {}" | $cc -xc - -o $tmp 2> /dev/null
 	if [ $? != 0 ]; then
 		echo " *** Unable to find the ncurses libraries."          1>&2
 		echo " *** make menuconfig require the ncurses libraries"  1>&2
