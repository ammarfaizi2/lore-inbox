Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbUCNM6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 07:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbUCNM6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 07:58:44 -0500
Received: from witte.sonytel.be ([80.88.33.193]:38872 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263353AbUCNM6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 07:58:42 -0500
Date: Sun, 14 Mar 2004 13:58:36 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] out-of-tree builds
Message-ID: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Although I like the feature to build a kernel in a different directory a lot, I
don't like its syntax. I prefer to just have a build directory where I can run
`make whatever'.

The following patch adds a configure script to the kernel. If you run

    /path/to/kernel/source/tree/configure

it will create a Makefile in the current directory, after which you can just do
`make whatever', just like in the source directory.

The configure script contains a simple protection for when run in the source
directory, but this may be approved (I'm not a configure script guru).

Comments?

--- /dev/null	2004-02-08 10:50:36.000000000 +0100
+++ linux-2.6.4/Makefile.in	2004-03-14 13:00:40.000000000 +0100
@@ -0,0 +1,11 @@
+
+srcdir = @srcdir@
+
+dstdir = $(shell pwd)
+
+all:
+	make -C $(srcdir) O=$(dstdir)
+
+%:
+	make -C $(srcdir) O=$(dstdir) $@
+
--- /dev/null	2004-02-08 10:50:36.000000000 +0100
+++ linux-2.6.4/configure	2004-03-14 13:03:35.000000000 +0100
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+srcdir=$(dirname $0)
+dstdir=$(pwd)
+
+if [ $srcdir = . -o $srcdir = $dstdir ]; then
+    echo Building in Linux kernel source tree, nothing changed
+else
+    if [ -e Makefile ]; then
+	/bin/mv Makefile Makefile.bak
+    fi
+    echo '# Generated automatically from Makefile.in by configure.' > Makefile
+    /bin/sed -e s+@srcdir@+$srcdir+ < $srcdir/Makefile.in >> Makefile
+    echo Linux kernel source tree in directory $srcdir
+    echo Building in directory $dstdir
+fi
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
