Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUCWWEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUCWWEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:04:01 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:42756 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262870AbUCWWD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:03:56 -0500
Subject: [PATCH][Documentation]Add BINFMT_MISC support for Mono .NET-based
	binaries
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-HizFsbYBMWLCqh2VaznR"
Message-Id: <1080079353.868.13.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Tue, 23 Mar 2004 23:02:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HizFsbYBMWLCqh2VaznR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Just as there is documentation for BINFMT_MISC and Java bytecodes
support, I thought it could be interesting to add documentation on how
to add BINFMT_MISC support for directly running .NET ".exe" binaries
using the Mono CLR.

Attached is patch against 2.6.5-rc2-bk3 but should apply against
2.6.5-rc2-mm1.

Please, consider it for inclusion. Thanks!

--=-HizFsbYBMWLCqh2VaznR
Content-Disposition: attachment; filename=mono-binfmt-documentation.patch
Content-Type: text/x-diff; name=mono-binfmt-documentation.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.5-rc2-bk3.old/Documentation/java.txt linux-2.6.5-rc2-bk3/Documentation/java.txt
--- linux-2.6.5-rc2-bk3.old/Documentation/java.txt	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.5-rc2-bk3/Documentation/java.txt	2004-03-23 22:46:42.323851618 +0100
@@ -22,7 +22,7 @@
    the kernel (CONFIG_BINFMT_MISC) and set it up properly.
    If you choose to compile it as a module, you will have
    to insert it manually with modprobe/insmod, as kmod
-   can not easy be supported with binfmt_misc. 
+   can not easily be supported with binfmt_misc. 
    Read the file 'binfmt_misc.txt' in this directory to know
    more about the configuration process.
 
diff -uNr linux-2.6.5-rc2-bk3.old/Documentation/mono.txt linux-2.6.5-rc2-bk3/Documentation/mono.txt
--- /dev/null					1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5-rc2-bk3/Documentation/mono.txt	2004-03-23 22:51:02.498954581 +0100
@@ -0,0 +1,66 @@
+               Mono(tm) Binary Kernel Support for Linux
+               -----------------------------------------
+
+To configure Linux to automatically execute Mono-based .NET binaries
+(in the form of .exe files) without the need to use the mono CLR
+wrapper, you can use the BINFMT_MISC kernel support.
+
+This will allow you to execute Mono-based .NET binaries just like any
+other program after you have done the following:
+
+1) You MUST FIRST install the Mono CLR support, either by downloading
+   a binary package, a source tarball or by installing from CVS. Binary
+   packages for several distributions can be found at:
+
+	http://go-mono.com/download.html
+
+   Instructions for compiling Mono can be found at:
+
+	http://www.go-mono.com/compiling.html
+
+   Once the Mono CLR support has been installed, just check that
+   /usr/bin/mono (which could be located elsewhere, for example
+   /usr/local/bin/mono) is working.
+
+2) You have to compile BINFMT_MISC either as a module or into
+   the kernel (CONFIG_BINFMT_MISC) and set it up properly.
+   If you choose to compile it as a module, you will have
+   to insert it manually with modprobe/insmod, as kmod
+   can not be easily supported with binfmt_misc. 
+   Read the file 'binfmt_misc.txt' in this directory to know
+   more about the configuration process.
+
+3) Add the following enries to /etc/rc.local or similar script
+   to be run at system startup:
+
+# Insert BINFMT_MISC module into the kernel
+if [ ! -e /proc/sys/fs/binfmt_misc/register ]; then
+        /sbin/modprobe binfmt_misc
+	# Some distributions, like Fedora Core, perform
+	# the following command automatically when the
+	# binfmt_misc module is loaded into the kernel.
+	# Thus, it is possible that the following line
+	# is not needed at all. Look at /etc/modprobe.conf
+	# to check whether this is applicable or not.
+        mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
+fi
+
+# Register support for .NET CLR binaries
+if [ -e /proc/sys/fs/binfmt_misc/register ]; then
+	# Replace /usr/bin/mono with the correct pathname to
+	# the Mono CLR runtime (usually /usr/local/bin/mono
+	# when compiling from sources or CVS).
+        echo ':CLR:M::MZ::/usr/bin/mono:' > /proc/sys/fs/binfmt_misc/register
+else
+        echo "No binfmt_misc support"
+        exit 1
+fi
+
+4) Check that .exe binaries can be ran without the need of a
+   wrapper script, simply by launching the .exe file directly
+   from a command prompt, for example:
+
+	/usr/bin/xsd.exe
+
+   NOTE: If this fails with a permission denied error, check
+         that the .exe file has execute permissions.
diff -uNr linux-2.6.5-rc2-bk3.old/fs/Kconfig.binfmt linux-2.6.5-rc2-bk3/fs/Kconfig.binfmt
--- linux-2.6.5-rc2-bk3.old/fs/Kconfig.binfmt	2004-03-23 22:42:51.097554452 +0100
+++ linux-2.6.5-rc2-bk3/fs/Kconfig.binfmt	2004-03-23 22:54:31.191339272 +0100
@@ -99,7 +99,7 @@
 	---help---
 	  If you say Y here, it will be possible to plug wrapper-driven binary
 	  formats into the kernel. You will like this especially when you use
-	  programs that need an interpreter to run like Java, Python or
+	  programs that need an interpreter to run like Java, Python, .NET or
 	  Emacs-Lisp. It's also useful if you often run DOS executables under
 	  the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>). Once you have
@@ -109,8 +109,9 @@
 
 	  You can do other nice things, too. Read the file
 	  <file:Documentation/binfmt_misc.txt> to learn how to use this
-	  feature, and <file:Documentation/java.txt> for information about how
-	  to include Java support.
+	  feature, <file:Documentation/java.txt> for information about how
+	  to include Java support. and <file:Documentation/mono.txt> for
+          information about how to include Mono-based .NET support.
 
           To use binfmt_misc, you will need to mount it:
 		mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc

--=-HizFsbYBMWLCqh2VaznR--

