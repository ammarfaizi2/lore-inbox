Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbSKXHDQ>; Sun, 24 Nov 2002 02:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267177AbSKXHDP>; Sun, 24 Nov 2002 02:03:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:65298 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267175AbSKXHDO>;
	Sun, 24 Nov 2002 02:03:14 -0500
Date: Sun, 24 Nov 2002 08:09:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Separate obj dir [2]
Message-ID: <20021124070941.GA1121@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021123222259.GA10609@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021123222259.GA10609@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I the previous mail I forgot the kbuild script - sorry.
Here it comes (as a patch).

	Sam

--- /dev/null	2002-08-31 01:31:37.000000000 +0200
+++ kbuild	2002-11-24 08:06:33.000000000 +0100
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# This script is used to build a kernel from a directory
+# separate from the kernel src tree.
+# The location of this script is assumed to be the root of
+# the kernel src tree. Do not copy it elsewhere.
+# Usage: kbuild [Usual options provided to make]
+
+# kbuild prints out SRCTREE and OBJTREE when started, and then makes 
+# symlinks of relevant files from the kernelsrc.
+
+# Files we do not care about in the kernel src
+RCS_FIND_IGNORE="-name SCCS -o -name BitKeeper -o -name .svn -o -name CVS"
+
+# Obtain absolute paths for SRCTREE and OBJTREE
+OBJTREE=$PWD
+cd `dirname $0`
+SRCTREE=$PWD
+cd $OBJTREE
+echo OBJTREE $OBJTREE
+echo SRCTREE $SRCTREE
+
+# If kbuild is executed from the root of the kernel src tree just call make
+if [ "$SRCTREE" == "$OBJTREE" ]; then
+  rm -f .tmp_make_config
+  make $*
+else
+  # A directory separate from kernel src tree
+  # Test if make has been executed in kernel src tree already
+  if [ -f $SRCTREE/.config -o -d $SRCTREE/include/asm ]; then
+    echo '$SRCTREE contains generated files, please run "make mrproper" in the SRCTREE'
+  else
+    # Symlink relevant files
+    for a in `cd $SRCTREE; \
+      find \( $RCS_FIND_IGNORE \) -prune -o -name Makefile\*`; do
+      if [ ! -d `dirname $a` ]; then
+        mkdir -p $a
+      fi
+      ln -fs $SRCTREE/$a $a
+    done
+
+    ( echo "srctree := $SRCTREE";
+      echo "objtree := $OBJTREE";
+    ) > .tmp_make_config
+    echo "#Dummy file" > Rules.make
+    make $*
+  fi
+fi
