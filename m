Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSFTFzL>; Thu, 20 Jun 2002 01:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSFTFzL>; Thu, 20 Jun 2002 01:55:11 -0400
Received: from herald.cc.purdue.edu ([128.210.11.29]:59875 "EHLO
	herald.cc.purdue.edu") by vger.kernel.org with ESMTP
	id <S314101AbSFTFzJ>; Thu, 20 Jun 2002 01:55:09 -0400
Message-ID: <3D116E19.6060108@purdue.edu>
Date: Thu, 20 Jun 2002 00:54:33 -0500
From: "Christopher A. Baumbauer" <cbaumba1@purdue.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] - patch-kernel 2.4.18
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for patching in the pre-release patches (dept. of 
redundancy dept.) to the kernel tree.  Nothing major, but along the same 
lines as the -ac patch option (also works the same way, except for using 
-pre instead).  Finally, if there is a discussion, could you please cc 
me directly since I'm not on the list.

Ciao,
Chris Baumbauer

--- scripts/patch-kernel.orig    Thu Jun 20 00:37:30 2002
+++ scripts/patch-kernel    Thu Jun 20 00:45:25 2002
@@ -1,6 +1,6 @@
 #! /bin/sh
 # Script to apply kernel patches.
-#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx 
] ] ]
+#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx 
] [ -prexx ] ] ]
 #     The source directory defaults to /usr/src/linux, and the patch
 #     directory defaults to the current directory.
 # e.g.
@@ -41,18 +41,24 @@
 # Added -ac option, use -ac or -ac9 (say) to stop at a particular version
 #       Dave Gilbert <linux@treblig.org>, 29th September 2001.
 
+# Added -pre option to work similar to the -ac option.
+#    Chris Baumbauer <baumbaca@cs.purdue.edu>, 20th June 2002.
+
 # Set directories from arguments, or use defaults.
 sourcedir=${1-/usr/src/linux}
 patchdir=${2-.}
 stopvers=${3-imnotaversion}
 
-# See if we have any -ac options
+# See if we have any -ac or -pre options
 for PARM in $*
 do
   case $PARM in
       -ac*)
           gotac=$PARM;
-
+          ;;
+      -pre*)
+          gotpre=$PARM;
+          ;;
     esac;
 done
 
@@ -188,6 +194,50 @@
         }
         applyPatch patch-${CURRENTFULLVERSION}${gotac}
     fi
+elif [ x$gotpre != x ]; then
+  # Living dangerously with the -pre patches
+  # I know this is a direct rip from the -ac code, but it should be the 
same: in theory
+
+        # Lets determine if this is our first -pre patch or if we've 
already included some in the past
+        if [ -f $patchdir/patch-${CURRENTFULLVERSION}-pre*\.* ]
+      then
+          PREVERSION=$CURRENTFULLVERSION
+    else
+          PREVERSION=$FULLVERSION
+    fi
+
+    # They could have done -pre (get latest) or -prexx where xx=version 
they want
+    if [ $gotpre == "-pre" ]
+    then
+      # They want the latest version
+        HIGHESTPATCH=0
+        for PATCHNAMES in $patchdir/patch-${PREVERSION}-pre*\.*
+        do
+            ACVALUE=`echo $PATCHNAMES | sed -e 
's/^.*patch-[0-9.]*-pre\([0-9]*\).*/\1/'`
+            # Check it is actually a recognised patch type
+            findFile $patchdir/patch-${PREVERSION}-pre${ACVALUE} || break
+
+          if [ $ACVALUE -gt $HIGHESTPATCH ]
+            then
+              HIGHESTPATCH=$ACVALUE
+          fi
+        done
+
+        if [ $HIGHESTPATCH -ne 0 ]
+        then
+            findFile $patchdir/patch-${PREVERSION}-pre${HIGHESTPATCH} 
|| break
+            applyPatch patch-${PREVERSION}-pre${HIGHESTPATCH}
+        else
+          echo "No pre release patches found"
+        fi
+    else
+      # They want an exact version
+        findFile $patchdir/patch-${PREVERSION}${gotpre} || {
+          echo "Sorry, I couldn't find the $gotpre patch for 
$PREVERSION.  Hohum."
+            exit 1
+        }
+        applyPatch patch-${PREVERSION}${gotpre}
+    fi
 fi

-- 
-------
Christopher A. Baumbauer
cbaumba1@purdue.edu, cab105@yahoo.com

There are 10 types of people in the world:
Those who understand binary, and those who don't


