Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTDDUTs (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDDUTs (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:19:48 -0500
Received: from [204.60.70.248] ([204.60.70.248]:2056 "EHLO sedum.tommyk.com")
	by vger.kernel.org with ESMTP id S261283AbTDDUTn (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 15:19:43 -0500
From: flake@sedum.tommyk.com
Date: Fri, 04 Apr 2003 15:31:12 -0500
To: linux-kernel@vger.kernel.org
Subject: Patch to add -pre support to scripts/patch-kernel
Message-ID: <3E8DEB90.nail3XN1CAUHF@sedum.tommyk.com>
User-Agent: nail 9.27 5/13/01
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1MZ8QO3W0F-=-12M491RU5U-CUT-HERE-ZW5KC1KPDW-=-1DIZTAWTGX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--1MZ8QO3W0F-=-12M491RU5U-CUT-HERE-ZW5KC1KPDW-=-1DIZTAWTGX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hope someone finds it usefull.
This is diffed from the script in 2.4.20

flames to jason(at)jasongurtz(dot)com

Cheers,

Jason

-- 

--1MZ8QO3W0F-=-12M491RU5U-CUT-HERE-ZW5KC1KPDW-=-1DIZTAWTGX
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch-kernel--with-pre.diff"

--- patch-kernel	Fri Aug  2 20:39:46 2002
+++ patch-kernel--with-pre	Fri Apr  4 14:41:22 2003
@@ -1,6 +1,7 @@
 #! /bin/sh
 # Script to apply kernel patches.
-#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
+#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ]...
+#	                    ...[[ -ac[xx] ] || [ -pre[xx] ]] ]
 #     The source directory defaults to /usr/src/linux, and the patch
 #     directory defaults to the current directory.
 # e.g.
@@ -18,6 +19,11 @@
 #   Note: It uses the patches relative to the Linus kernels, not the
 #   ac to ac relative patches
 #
+#   scripts/patch-kernel . .. -pre
+#      Gets latest kernel and patch it with the latest testing patch
+#	Note: testing patches are not incremental. e.g to get 2.4.21-pre6
+#	      you need linux-2.4.20 and patch-2.4.21-pre6
+#
 # It determines the current kernel version from the top-level Makefile.
 # It then looks for patches for the next sublevel in the patch directory.
 # This is applied using "patch -p1 -s" from within the kernel directory.
@@ -40,6 +46,9 @@
 #
 # Added -ac option, use -ac or -ac9 (say) to stop at a particular version
 #       Dave Gilbert <linux@treblig.org>, 29th September 2001.
+#
+# Added -pre option, use like -ac option above
+#		Jason Gurtz <jason@jasongurtz.com>, 4th April 2003.
 
 # Set directories from arguments, or use defaults.
 sourcedir=${1-/usr/src/linux}
@@ -48,20 +57,29 @@
 
 if [ "$1" = -h -o "$1" = --help -o ! -r "$sourcedir/Makefile" ]; then
 cat << USAGE
-usage: patch-kernel [-h] [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
-  The source directory defaults to /usr/src/linux, and
-  the patch directory defaults to the current directory.
+--------------------------------------------------------------------------------
+usage: patch-kernel [-h] [ sourcedir [ patchdir [ stopversion ]...
+                    ...[[ -ac[xx] ] || [ -pre[xx] ]] ]
+
+	- The source directory defaults to /usr/src/linux, and
+	  the patch directory defaults to the current directory.
+	  
+	- For -ac and -pre, optional "xx" is patch version number to stop at
+--------------------------------------------------------------------------------
 USAGE
 exit 1
 fi
 
-# See if we have any -ac options
+# See if we have any -ac or -pre options
 for PARM in $*
 do
-  case $PARM in
-	  -ac*)
-		  gotac=$PARM;
-
+	case $PARM in
+		-ac*)
+			gotac=$PARM;
+		;;	
+		-pre*)
+			gotpre=$PARM;
+		;;
 	esac;
 done
 
@@ -77,7 +95,7 @@
 		uncomp="gunzip -dc"
   elif [ -r ${filebase}.bz  ]; then
 		ext=".bz"
-    name="bzip"
+	    name="bzip"
 		uncomp="bunzip -dc"
   elif [ -r ${filebase}.bz2 ]; then
 		ext=".bz2"
@@ -128,6 +146,14 @@
 
 # set current VERSION, PATCHLEVEL, SUBLEVEL, EXTERVERSION
 eval `sed -n -e 's/^\([A-Z]*\) = \([0-9]*\)$/\1=\2/p' -e 's/^\([A-Z]*\) = \(-[-a-z0-9]*\)$/\1=\2/p' $sourcedir/Makefile`
+
+# In the case of -pre, we need to pretend we have the next CURRENTFULLVERSION :)
+if [ $gotpre ]
+then
+	echo "Faking Kernel Version so -pre patches work.  Don't be alarmed ;)"
+	(( SUBLEVEL++ ))
+fi
+
 if [ -z "$VERSION" -o -z "$PATCHLEVEL" -o -z "$SUBLEVEL" ]
 then
     echo "unable to determine current kernel version" >&2
@@ -145,7 +171,8 @@
 while :
 do
     CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
-    if [ $stopvers = $CURRENTFULLVERSION ]
+
+    if [ $stopvers = $CURRENTFULLVERSION ];
     then
         echo "Stoping at $CURRENTFULLVERSION base as requested."
         break
@@ -163,12 +190,13 @@
     applyPatch $patch || break
 done
 
-if [ x$gotac != x ]; then
-  # Out great user wants the -ac patches
-	# They could have done -ac (get latest) or -acxx where xx=version they want
-	if [ $gotac == "-ac" ]
+if [ "$gotac" != "x" ] || [ "$gotpre" != "x" ]
+then
+	# Our great user wants the -ac or -pre patches
+	# They could have done -ac or -pre (get latest) or -acxx or -prexx where xx=version they want
+	if [ "$gotac" == "-ac" ]
 	then
-	  # They want the latest version
+	  # They want the latest -ac version
 		HIGHESTPATCH=0
 		for PATCHNAMES in $patchdir/patch-${CURRENTFULLVERSION}-ac*\.*
 		do
@@ -176,10 +204,10 @@
 			# Check it is actually a recognised patch type
 			findFile $patchdir/patch-${CURRENTFULLVERSION}-ac${ACVALUE} || break
 
-		  if [ $ACVALUE -gt $HIGHESTPATCH ]
+			if [ $ACVALUE -gt $HIGHESTPATCH ]
 			then
-			  HIGHESTPATCH=$ACVALUE
-		  fi
+				HIGHESTPATCH=$ACVALUE
+			fi
 		done
 
 		if [ $HIGHESTPATCH -ne 0 ]
@@ -187,16 +215,46 @@
 			findFile $patchdir/patch-${CURRENTFULLVERSION}-ac${HIGHESTPATCH} || break
 			applyPatch patch-${CURRENTFULLVERSION}-ac${HIGHESTPATCH}
 		else
-		  echo "No ac patches found"
+			echo "No ac patches found"
+		fi
+	elif [ "$gotpre" == "-pre" ]
+	then
+		# They want the latest -pre version
+		HIGHESTPATCH=0
+		for PATCHNAMES in $patchdir/patch-${CURRENTFULLVERSION}-pre*\.*
+		do
+			PREVALUE=`echo $PATCHNAMES | sed -e 's/^.*patch-[0-9.]*-pre\([0-9]*\).*/\1/'`
+			# Check it is actually a recognised patch type
+			findFile $patchdir/patch-${CURRENTFULLVERSION}-pre${PREVALUE} || break
+
+			if [ $PREVALUE -gt $HIGHESTPATCH ]
+			then
+				HIGHESTPATCH=$PREVALUE
+			fi
+		done
+		if [ $HIGHESTPATCH -ne 0 ]
+		then
+			findFile $patchdir/patch-${CURRENTFULLVERSION}-pre${HIGHESTPATCH} || break
+			applyPatch patch-${CURRENTFULLVERSION}-pre${HIGHESTPATCH}
+		else
+		  echo "No pre patches found"
 		fi
-	else
-	  # They want an exact version
+	elif [ $gotac ]
+	then
+		# They want an exact -ac version
 		findFile $patchdir/patch-${CURRENTFULLVERSION}${gotac} || {
-		  echo "Sorry, I couldn't find the $gotac patch for $CURRENTFULLVERSION.  Hohum."
+			echo "Sorry, I couldn't find the $gotac patch for $CURRENTFULLVERSION.  Hohum."
 			exit 1
 		}
 		applyPatch patch-${CURRENTFULLVERSION}${gotac}
+	elif [ $gotpre ]
+	then
+		# They want an exact -pre version
+		findFile $patchdir/patch-${CURRENTFULLVERSION}${gotpre} || {
+			echo "Sorry, I couldn't find the $gotpre patch for $CURRENTFULLVERSION.  Hohum."
+			exit 1
+		}
+		applyPatch patch-${CURRENTFULLVERSION}${gotpre}
 	fi
 fi
-
-
+# EOF

--1MZ8QO3W0F-=-12M491RU5U-CUT-HERE-ZW5KC1KPDW-=-1DIZTAWTGX--
