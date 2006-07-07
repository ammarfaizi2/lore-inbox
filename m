Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWGGBnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWGGBnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWGGBnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:43:07 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51847
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750913AbWGGBnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:43:06 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Miniconfig revisited (1/3)
Date: Thu, 6 Jul 2006 21:43:12 -0400
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org
References: <200607061753.43518.rob@landley.net>
In-Reply-To: <200607061753.43518.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607062143.12669.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first attempt doesn't seem to have made it through to the list, so...

Add "make miniconfig" target.  Only touches the makefile, no C code.

Signed-off-by: Rob Landley <rob@landley.net>


diff -ur linux-2.6.17.1/scripts/kconfig/Makefile linux-2.6.17.new/scripts/kconfig/Makefile
--- linux-2.6.17.1/scripts/kconfig/Makefile	2006-06-20 05:31:55.000000000 -0400
+++ linux-2.6.17.new/scripts/kconfig/Makefile	2006-07-06 15:51:25.000000000 -0400
@@ -2,7 +2,7 @@
 # Kernel configuration targets
 # These targets are used from top-level makefile
 
-PHONY += oldconfig xconfig gconfig menuconfig config silentoldconfig update-po-config
+PHONY += oldconfig xconfig gconfig menuconfig config silentoldconfig miniconfig update-po-config
 
 xconfig: $(obj)/qconf
 	$< arch/$(ARCH)/Kconfig
@@ -23,6 +23,14 @@
 silentoldconfig: $(obj)/conf
 	$< -s arch/$(ARCH)/Kconfig
 
+MINICONFIG = mini.config
+miniconfig: $(obj)/conf $(MINICONFIG)
+	$(Q)KCONFIG_ALLCONFIG=$(MINICONFIG) $< -n arch/$(ARCH)/Kconfig > /dev/null 2> .config.result ; \
+	cat .config.result ; \
+	RESULT=`cat .config.result`; \
+	rm .config.result ; \
+	if [ ! -z "${RESULT}" ]; then exit 1; fi
+
 update-po-config: $(obj)/kxgettext
 	xgettext --default-domain=linux \
           --add-comments --keyword=_ --keyword=N_ \
@@ -79,6 +87,7 @@
 	@echo  '  allmodconfig	  - New config selecting modules when possible'
 	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
 	@echo  '  allnoconfig	  - New config where all options are answered with no'
+	@echo  '  miniconfig	  - New config unpacked from mini.config (or MINICONFIG=file)'
 
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:
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
