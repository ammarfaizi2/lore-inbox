Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSFTPyg>; Thu, 20 Jun 2002 11:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSFTPyf>; Thu, 20 Jun 2002 11:54:35 -0400
Received: from herald.cc.purdue.edu ([128.210.11.29]:17042 "EHLO
	herald.cc.purdue.edu") by vger.kernel.org with ESMTP
	id <S315182AbSFTPyd>; Thu, 20 Jun 2002 11:54:33 -0400
Message-ID: <3D11FA8F.7080808@purdue.edu>
Date: Thu, 20 Jun 2002 10:53:51 -0500
From: "Christopher A. Baumbauer" <cbaumba1@purdue.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Rolf Eike Beer <eike@euklid.math.uni-mannheim.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - patch-kernel 2.4.18
References: <3D116E19.6060108@purdue.edu> <1142957.qPl0MRWbmq@newssend.sf-tec.de>
Content-Type: multipart/mixed;
 boundary="------------090605070704060608050400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090605070704060608050400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Grr, it showed up fine before I sent it (fameous last words), but I'll 
attempt to resend it.

Thanks,
Chris

Rolf Eike Beer wrote:

>Von Christopher A. Baumbauer:
>
>  
>
>>-#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx
>>] ] ]
>>    
>>
>
>I don't think that this will work, your mailer did his own line breaks!
>
>Eike
>  
>

-- 
-------
Christopher A. Baumbauer
cbaumba1@purdue.edu, cab105@yahoo.com

There are 10 types of people in the world:
Those who understand binary, and those who don't



--------------090605070704060608050400
Content-Type: text/plain;
 name="patch-kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-kernel.patch"

--- scripts/patch-kernel.orig	Thu Jun 20 10:09:38 2002
+++ scripts/patch-kernel	Thu Jun 20 10:45:51 2002
@@ -1,6 +1,6 @@
 #! /bin/sh
 # Script to apply kernel patches.
-#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
+#   usage: patch-kernel [ sourcedir [ patchdir [ stopversion ] [ -acxx ] [ -prexx ] ] ]
 #     The source directory defaults to /usr/src/linux, and the patch
 #     directory defaults to the current directory.
 # e.g.
@@ -41,18 +41,24 @@
 # Added -ac option, use -ac or -ac9 (say) to stop at a particular version
 #       Dave Gilbert <linux@treblig.org>, 29th September 2001.
 
+# Added -pre option to work similar to the -ac option.
+#	Chris Baumbauer <baumbaca@cs.purdue.edu>, 20th June 2002.
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
+		  ;;
+	  -pre*)
+		  gotpre=$PARM;
+		  ;;
 	esac;
 done
 
@@ -188,6 +194,50 @@
 		}
 		applyPatch patch-${CURRENTFULLVERSION}${gotac}
 	fi
+elif [ x$gotpre != x ]; then
+  # Living dangerously with the -pre patches
+  # I know this is a direct rip from the -ac code, but it should be the same: in theory
+
+        # Lets determine if this is our first -pre patch or if we've already included some in the past
+        if [ -f $patchdir/patch-${CURRENTFULLVERSION}-pre*\.* ]
+	  then
+	      PREVERSION=$CURRENTFULLVERSION
+	else
+	      PREVERSION=$FULLVERSION
+	fi
+
+	# They could have done -pre (get latest) or -prexx where xx=version they want
+	if [ $gotpre == "-pre" ]
+	then
+	  # They want the latest version
+		HIGHESTPATCH=0
+		for PATCHNAMES in $patchdir/patch-${PREVERSION}-pre*\.*
+		do
+			ACVALUE=`echo $PATCHNAMES | sed -e 's/^.*patch-[0-9.]*-pre\([0-9]*\).*/\1/'`
+			# Check it is actually a recognised patch type
+			findFile $patchdir/patch-${PREVERSION}-pre${ACVALUE} || break
+
+		  if [ $ACVALUE -gt $HIGHESTPATCH ]
+			then
+			  HIGHESTPATCH=$ACVALUE
+		  fi
+		done
+
+		if [ $HIGHESTPATCH -ne 0 ]
+		then
+			findFile $patchdir/patch-${PREVERSION}-pre${HIGHESTPATCH} || break
+			applyPatch patch-${PREVERSION}-pre${HIGHESTPATCH}
+		else
+		  echo "No pre release patches found"
+		fi
+	else
+	  # They want an exact version
+		findFile $patchdir/patch-${PREVERSION}${gotpre} || {
+		  echo "Sorry, I couldn't find the $gotpre patch for $PREVERSION.  Hohum."
+			exit 1
+		}
+		applyPatch patch-${PREVERSION}${gotpre}
+	fi
 fi
 
 

--------------090605070704060608050400--

