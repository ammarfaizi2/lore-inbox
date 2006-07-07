Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWGGBps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWGGBps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWGGBps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:45:48 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:53383
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751141AbWGGBpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:45:47 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Miniconfig revisited (3/3)
Date: Thu, 6 Jul 2006 21:45:54 -0400
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org
References: <200607061753.43518.rob@landley.net>
In-Reply-To: <200607061753.43518.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200607062145.54707.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for miniconfig.

Signed-off-by: Rob Landley <rob@landley.net>

diff -ur linux-2.6.17.1/Documentation/kbuild/00-INDEX linux-2.6.17.new/Documentation/kbuild/00-INDEX
--- linux-2.6.17.1/Documentation/kbuild/00-INDEX	2006-06-20 05:31:55.000000000 -0400
+++ linux-2.6.17.new/Documentation/kbuild/00-INDEX	2006-07-06 13:50:35.000000000 -0400
@@ -4,5 +4,7 @@
 	- specification of Config Language, the language in Kconfig files
 makefiles.txt
 	- developer information for linux kernel makefiles
+miniconfig.txt
+	- how to use miniature configuration files.
 modules.txt
 	- how to build modules and to install them
diff -ur linux-2.6.17.1/Documentation/kbuild/miniconfig.txt linux-2.6.17.new/Documentation/kbuild/miniconfig.txt
--- linux-2.6.17.1/Documentation/kbuild/miniconfig.txt	2006-07-06 16:37:21.000000000 -0400
+++ linux-2.6.17.new/Documentation/kbuild/miniconfig.txt	2006-07-06 13:50:57.000000000 -0400
@@ -0,0 +1,103 @@
+Miniconfig documentation
+June 19, 2006
+Rob Landley <rob@landley.net>
+=============================
+
+What is a miniconfig?
+---------------------
+
+Current Linux kernels support miniature configuration files, listing just
+the symbols you want to enable and letting the configurator enable any
+dependencies needed to give you a valid configuration.
+
+The "make miniconfig" command will expand a mini.config file into a full-sized
+.config for use by the build process.  By default this expects to read
+configuration data from "mini.config" in the current directory.  Add the
+argument "MINICONFIG=/path/to/filename" to specify a different file.  Either
+way, it creates a new ".config" file.
+
+Advantages of miniconfig:
+-------------------------
+
+Miniconfigs have several advantages over conventional configuration files:
+
+ * They're more portable between versions.  A miniconfig from linux 2.6.15 will
+   most likely build an equivalent 2.6.18 kernel.
+
+ * It's easy to see exactly what features have been specified.
+
+ * Miniconfigs are human editable, human readable, and provide informative
+   error messages identifying any unrecognized (typoed) symbols.
+
+Creating a mini.config automatically:
+-------------------------------------
+
+Configure your kernel as usual, then run "scripts/shrinkconfig filename"
+to create a new miniconfig file (called "filename") from that .config file.
+
+This will take a long time; the current script reloads the config file once
+for each line in the file to determine if that line is needed in the resulting
+output.
+
+To specify an architecture other than x86, set the ARCH environment variable
+before running the script, ala:
+
+  ARCH=arm script/shrinkconfig mini.config
+
+Creating a mini.config by hand:
+-------------------------------
+
+Open your favorite text editor starting with a blank file, and also open a
+command line window.  At the command line run "make allnoconfig" followed by
+"make menuconfig".  Go through menuconfig enabling each feature you want, and
+for each feature you enable look at the help entry to find the symbol name for
+that feature, and add a line to mini.config setting that symbol to the
+appropriate value, such as:
+
+  CONFIG_THINGY=y
+
+When you've got your list of symbols, save the file and run "make miniconfig"
+on it to make sure you get the results you want.
+
+Real-world example:
+-------------------
+
+Here's the mini.config I use to build User Mode Linux:
+
+  CONFIG_MODE_SKAS=y
+  CONFIG_BINFMT_ELF=y
+  CONFIG_HOSTFS=y
+  CONFIG_SYSCTL=y
+  CONFIG_STDERR_CONSOLE=y
+  CONFIG_UNIX98_PTYS=y
+  CONFIG_BLK_DEV_LOOP=y
+  CONFIG_BLK_DEV_UBD=y
+  CONFIG_TMPFS=y
+  CONFIG_SWAP=y
+  CONFIG_LBD=y
+  CONFIG_EXT2_FS=y
+  CONFIG_PROC_FS=y
+
+And here's how I build and test it (as a normal user, not as root):
+
+# Configure, building in an external directory and using a mini.config file in
+# my home directory.
+
+  make miniconfig MINICONFIG=~/uml-config ARCH=um O=../linux-umlbuild
+
+# change to build directory and build User Mode Linux
+
+  cd ../linux-umlbuild
+  make ARCH=um
+
+# Test run
+
+  ./linux rootfstype=hostfs rw init=/bin/sh
+  $ whoami
+  $ mount -t proc /proc /proc
+  $ cat /proc/cpuinfo
+  $ halt -f
+
+# And if I want to regenerate the mini.config from the .config, I do this.
+
+  ARCH=um scripts/shrinkconfig uml-config


-- 
Never bet against the cheap plastic solution.
