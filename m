Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbWIRBiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbWIRBiU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWIRBiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:38:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:13787 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965212AbWIRBiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:18 -0400
Message-Id: <20060918013216.335200000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:41 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 1/8] extend make headers_check to detect more problems
Content-Disposition: inline; filename=headercheck-base.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the problem of including non-existant header
files, a number of other things can go wrong with header
files exported to user space. This adds checks for some
common problems:

- The header fails to include the files it needs, which
  results in build errors when a program tries to include
  it. Check this by doing a dummy compile.

- There is a declarations of a static variable or non-inline
  function in the header, which results in object code
  in every file including it. Check for symbols in the object
  with 'nm'.

- Part of the header is subject to conditional compilation
  based on CONFIG_*. Add a regex search for this.

I found many problems with this, which I then fixed for
powerpc, s390 and i386, in subsequent patches.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/scripts/hdrcheck.sh
===================================================================
--- linux-cg.orig/scripts/hdrcheck.sh	2006-09-18 02:04:44.000000000 +0200
+++ linux-cg/scripts/hdrcheck.sh	2006-09-18 02:04:45.000000000 +0200
@@ -1,8 +1,28 @@
 #!/bin/sh
 
+# check if all included files exist
 for FILE in `grep '^[ \t]*#[ \t]*include[ \t]*<' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
     if [ ! -r $1/$FILE ]; then
 	echo $2 requires $FILE, which does not exist in exported headers
 	exit 1
     fi
 done
+
+# try to compile in order to see CC warnings, show only the first few
+CHECK_CFLAGS=`grep @headercheck: $2 | sed -e 's/^.*@headercheck:\([^@]*\)@.*$/\1/'`
+CFLAGS="-Wall -std=gnu99 -xc -O2 -I$1 ${CHECK_CFLAGS}"
+tmpfile=`mktemp`
+${CC:-gcc} ${CFLAGS} -c $2 -o $tmpfile 2>&1 | sed -e "s:$1:include:g" >&2
+
+# check if object file is empty
+if [ "`nm $tmpfile`" ] ; then
+    echo include${2#$1}: warning: non-empty output >&2
+fi
+rm $tmpfile
+
+# check if we use a CONFIG_ symbol, which is not allowed in installed headers
+grep '^[ \t]*#[ \t]*if.*\<CONFIG_[[:alnum:]_]*\>' -n $2 |
+while read i ; do
+    echo include${2#$1}:${i%%:*}: warning: invalid use of `echo $i |
+	sed -e 's/.*\(\<CONFIG_[[:alnum:]_]*\>\).*/\1/g'` >&2
+done

--

