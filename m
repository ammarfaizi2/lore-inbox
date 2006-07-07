Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWGGBo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWGGBo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWGGBoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:44:55 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52615
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750925AbWGGBoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:44:44 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Miniconfig revisited (2/3)
Date: Thu, 6 Jul 2006 21:44:52 -0400
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org
References: <200607061753.43518.rob@landley.net>
In-Reply-To: <200607061753.43518.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607062144.52505.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add scripts/shrinkconfig to create a miniconfig from an existing .config.

Signed-off-by: Rob Landley <rob@landley.net>

diff -ur linux-2.6.17.1/scripts/shrinkconfig linux-2.6.17.new/scripts/shrinkconfig
--- linux-2.6.17.1/scripts/shrinkconfig	2006-07-06 16:34:39.000000000 -0400
+++ linux-2.6.17.new/scripts/shrinkconfig	2006-07-06 15:54:40.000000000 -0400
@@ -0,0 +1,86 @@
+#!/bin/bash
+
+# shrinkconfig copyright 2006 by Rob Landley <rob@landley.net>
+# Licensed under the GNU General Public License version 2.
+
+if [ $# -ne 1 ]
+then
+  echo "Turns current .config into a miniconfig file."
+  echo "Usage: shrinkconfig mini.config"
+  exit 1
+fi
+
+if [ ! -f .config ]
+then
+  echo "Need a .config file to shrink."
+  exit 1
+fi
+LENGTH=$(cat .config | wc -l)
+
+OUTPUT="$1"
+cp .config "$OUTPUT"
+if [ $? -ne 0 ]
+then
+  echo "Couldn't create $OUTPUT"
+  exit 1
+fi
+
+# If we get interrupted, clean up the mess
+
+KERNELOUTPUT=""
+
+function cleanup
+{
+  echo
+  echo "Interrupted."
+  [ ! -z "$KERNELOUTPUT" ] && rm -rf "$KERNELOUTPUT"
+  rm "$OUTPUT"
+  exit 1
+}
+
+trap cleanup HUP INT QUIT TERM
+
+# Since the "O=" argument to make doesn't work recursively, we need to jump
+# through a few hoops to avoid overwriting the .config that we're shrinking.
+
+# If we're building out of tree, we'll have absolute paths to source and build
+# directories in the Makefile.
+
+KERNELSRC=$(sed -n -e 's/KERNELSRC[^/]*:=[^/]*//p' Makefile)
+[ -z "$KERNELSRC" ] && KERNELSRC=$(pwd)
+KERNELOUTPUT=`pwd`/.config.minitemp
+
+mkdir -p "$KERNELOUTPUT" || exit 1
+
+echo "Shrinking .config to $OUTPUT..."
+
+# Loop through all lines in the file 
+I=1
+while true
+do
+  if [ $I -gt $LENGTH ]
+  then
+    break
+  fi
+
+  echo -n -e "\r"$I/$LENGTH lines $(cat "$OUTPUT" | wc -c) bytes
+
+  sed -n "${I}!p" "$OUTPUT" > "$KERNELOUTPUT"/.config.test
+  # Do a config with this file
+  make -C "$KERNELSRC" O="$KERNELOUTPUT" allnoconfig KCONFIG_ALLCONFIG="$KERNELOUTPUT"/.config.test > /dev/null
+
+  # Compare.  The date changes, so expect a small difference each time.
+  D=$(diff "$KERNELOUTPUT"/.config .config | wc -l)
+  if [ $D -eq 4 ]
+  then
+    mv "$KERNELOUTPUT"/.config.test "$OUTPUT"
+    LENGTH=$[$LENGTH-1]
+  else
+    I=$[$I + 1]
+  fi
+done
+
+rm -rf "$KERNELOUTPUT"
+
+# One extra echo to preserve status line.
+echo

-- 
Never bet against the cheap plastic solution.
