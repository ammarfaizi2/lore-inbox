Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUFXURt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUFXURt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUFXURt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:17:49 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:4761 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265508AbUFXURp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:17:45 -0400
Date: Thu, 24 Jun 2004 22:30:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: RFC: Testing for kernel features in external modules
Message-ID: <20040624203043.GA4557@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last couple of kbuild patches has put attention to testing for
features in the kernel so an external modules can stay compatible
with a broad range of kernels.
Since vendors backport patches then testing for the kernel version is not
an option, so other means are reqired.

Two approaches are in widespread use:
a) grep kernel headers
b) Try to compile a small .c file (nvidia is a good example)

The a) approach is not robust for changes in .h files, mainly when contant
is moved from one file to another. This will happen when the linuxabi
project is kicked off.

The b) approach required glibc headers to be in full sync with the kernel,
this cannot be guaranteed. And will fail when building for another kernel
version than the running one.


How about the following approach where the kbuild system is used to compile
a few sample programs? 
If compile succeeeds -> feature is present.
If compile fails -> feature not implemented.

The files needs to be in a separate directory.
Use: dir/feature.sh /lib/modules/`uname -r`/build ../feature.h

The script usually used to build the module can call feature.sh, and afterwards
the module can include the feature.h file.

Comments welcome...

	Sam


--- /dev/null	2003-09-23 19:59:22.000000000 +0200
+++ features.sh	2004-06-24 22:23:10.475441120 +0200
@@ -0,0 +1,19 @@
+# Check for presence of certain kernel features
+# $1 = kernel dir
+# $2 = output file
+
+# 
+dir=`dirname $0`
+cd $dir
+
+
+make -C $1 M=`pwd`
+
+if [ -f remap4.o ]; then
+	echo "#define REMAP4 1" > $2
+elif [ -f remap5.o ]; then
+	echo "#define REMAP5 1" > $2
+fi
+
+make -C $1 M=`pwd` clean
+
--- /dev/null	2003-09-23 19:59:22.000000000 +0200
+++ Makefile	2004-06-24 21:55:45.071580528 +0200
@@ -0,0 +1,5 @@
+MAKEFLAGS += -k
+
+obj-y := remap4.o remap5.o
+
+
--- /dev/null	2003-09-23 19:59:22.000000000 +0200
+++ remap4.c	2004-06-24 21:44:28.022507632 +0200
@@ -0,0 +1,7 @@
+#include <linux/mm.h>
+        
+int do_test_remap_page_range(void)
+{
+           pgprot_t pgprot;
+           remap_page_range(0L, 0L, 0L, pgprot);
+}
--- /dev/null	2003-09-23 19:59:22.000000000 +0200
+++ remap5.c	2004-06-24 21:44:10.033242416 +0200
@@ -0,0 +1,7 @@
+#include <linux/mm.h>
+        
+int do_test_remap_page_range(void)
+{
+           pgprot_t pgprot;
+           remap_page_range(NULL, 0L, 0L, 0L, pgprot);
+}
