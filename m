Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267732AbUHRU7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267732AbUHRU7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUHRU7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:59:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:58263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267732AbUHRU7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:59:16 -0400
Date: Wed, 18 Aug 2004 13:57:51 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Greg Norris <haphazard@kc.rr.com>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>, sam@ravnborg.org
Subject: [PATCH] scripts/patch-kernel: use EXTRAVERSION
Message-Id: <20040818135751.197ce3c9.rddunlap@osdl.org>
In-Reply-To: <20040814205707.GA11936@yggdrasil.localdomain>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
	<20040814101039.GA27163@alpha.home.local>
	<Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org>
	<20040814115548.A19527@infradead.org>
	<Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
	<411E0A37.5040507@anomalistic.org>
	<20040814205707.GA11936@yggdrasil.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(was:  Re: Linux v2.6.8 - Oops on NFSv3)

On Sat, 14 Aug 2004 15:57:07 -0500 Greg Norris wrote:

| On Sat, Aug 14, 2004 at 08:48:55PM +0800, Nur Hussein wrote:
| > I hear the first victim of the breakage may be the kernel.org front 
| > page. 2.6.8.1 is not showing up as "latest".
| 
| The `patch-kernel' script needs updating as well.
| 
|    $ scripts/patch-kernel . ~/kernel/
|    Current kernel version is 2.6.0
|    Applying patch-2.6.1 (bzip2)... done.
|    Applying patch-2.6.2 (bzip2)... done.
|    Applying patch-2.6.3 (bzip2)... done.
|    Applying patch-2.6.4 (bzip2)... done.
|    Applying patch-2.6.5 (bzip2)... done.
|    Applying patch-2.6.6 (bzip2)... done.
|    Applying patch-2.6.7 (bzip2)... done.
|    Applying patch-2.6.8 (bzip2)... done.

Here's a patch for scripts/patch-kernel that uses EXTRAVERSION.
Works for me.  Comments/corrections/testing ??

--



Update 'scripts/patch-kernel' to support EXTRAVERSION.
Update usage message text.
Fix some whitespace.
Handle command line arg3 (stop-version) more carefully.
No changes to -ac patch updates.

EXTRAVERSION handling:
any leading '.' and any trailing modifier (beginning with any
punctuation, like "-ac" or "_kexec" or "+mm") are stripped,
trying to get down to just a number.
Then 'patch-kernel' increments EXTRAVERSION as long as it can
apply "patch-V.P.S.X*".  When that file isn't found, it resets
EXTRAVERSION to "" and increments SUBLEVEL (as before this patch).

Works for me.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 scripts/patch-kernel |  113 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 84 insertions(+), 29 deletions(-)

diff -Naurp ./scripts/patch-kernel~all_vers ./scripts/patch-kernel
--- ./scripts/patch-kernel~all_vers	2004-08-14 03:55:09.000000000 -0700
+++ ./scripts/patch-kernel	2004-08-18 12:12:19.358719440 -0700
@@ -40,17 +40,24 @@
 #
 # Added -ac option, use -ac or -ac9 (say) to stop at a particular version
 #       Dave Gilbert <linux@treblig.org>, 29th September 2001.
+#
+# Add support for (use of) EXTRAVERSION (to support 2.6.8.x, e.g.);
+# update usage message;
+# fix some whitespace damage;
+# be smarter about stopping when current version is larger than requested;
+#	Randy Dunlap <rddunlap@osdl.org>, 2004-AUG-18.
 
 # Set directories from arguments, or use defaults.
 sourcedir=${1-/usr/src/linux}
 patchdir=${2-.}
-stopvers=${3-imnotaversion}
+stopvers=${3-default}
 
-if [ "$1" = -h -o "$1" = --help -o ! -r "$sourcedir/Makefile" ]; then
+if [ "$1" == -h -o "$1" == --help -o ! -r "$sourcedir/Makefile" ]; then
 cat << USAGE
 usage: patch-kernel [-h] [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
-  The source directory defaults to /usr/src/linux, and
-  the patch directory defaults to the current directory.
+  source directory defaults to /usr/src/linux,
+  patch directory defaults to the current directory,
+  stopversion defaults to <all in patchdir>.
 USAGE
 exit 1
 fi
@@ -77,7 +84,7 @@ findFile () {
 		uncomp="gunzip -dc"
   elif [ -r ${filebase}.bz  ]; then
 		ext=".bz"
-    name="bzip"
+		name="bzip"
 		uncomp="bunzip -dc"
   elif [ -r ${filebase}.bz2 ]; then
 		ext=".bz2"
@@ -96,8 +103,8 @@ findFile () {
 		name="plaintext"
 		uncomp="cat"
   else
-	  return 1;
-	fi
+	return 1;
+  fi
 
   return 0;
 }
@@ -126,48 +133,100 @@ applyPatch () {
   return 0;
 }
 
-# set current VERSION, PATCHLEVEL, SUBLEVEL, EXTERVERSION
-eval `sed -n -e 's/^\([A-Z]*\) = \([0-9]*\)$/\1=\2/p' -e 's/^\([A-Z]*\) = \(-[-a-z0-9]*\)$/\1=\2/p' $sourcedir/Makefile`
+# set current VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION
+TMPFILE=`mktemp .tmpver.XXXXXX` || { echo "cannot make temp file" ; exit 1; }
+grep -E "^(VERSION|PATCHLEVEL|SUBLEVEL|EXTRAVERSION)" $sourcedir/Makefile > $TMPFILE
+tr -d [:blank:] < $TMPFILE > $TMPFILE.1
+source $TMPFILE.1
+rm -f $TMPFILE*
 if [ -z "$VERSION" -o -z "$PATCHLEVEL" -o -z "$SUBLEVEL" ]
 then
     echo "unable to determine current kernel version" >&2
     exit 1
 fi
 
-echo "Current kernel version is $VERSION.$PATCHLEVEL.$SUBLEVEL${EXTRAVERSION}"
+NAME=`grep ^NAME $sourcedir/Makefile`
+NAME=${NAME##*=}
 
+echo "Current kernel version is $VERSION.$PATCHLEVEL.$SUBLEVEL${EXTRAVERSION} ($NAME)"
+
+# strip EXTRAVERSION to just a number (drop leading '.' and trailing additions)
+EXTRAVER=
 if [ x$EXTRAVERSION != "x" ]
 then
-  echo "I'm sorry but patch-kernel can't work with a kernel source tree that is not a base version"
-	exit 1;
+	if [ ${EXTRAVERSION:0:1} == "." ]; then
+		EXTRAVER=${EXTRAVERSION:1}
+	else
+		EXTRAVER=$EXTRAVERSION
+	fi
+	EXTRAVER=${EXTRAVER%%[[:punct:]]*}
+	#echo "patch-kernel: changing EXTRAVERSION from $EXTRAVERSION to $EXTRAVER"
+fi
+
+#echo "stopvers=$stopvers"
+if [ $stopvers != "default" ]; then
+	STOPSUBLEVEL=`echo $stopvers | cut -d. -f3`
+	STOPEXTRA=`echo $stopvers | cut -d. -f4`
+	#echo "STOPSUBLEVEL=$STOPSUBLEVEL, STOPEXTRA=$STOPEXTRA"
+else
+	STOPSUBLEVEL=9999
+	STOPEXTRA=9999
 fi
 
-while :
+while :				# incrementing SUBLEVEL (s in v.p.s)
 do
-    CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
-    if [ $stopvers = $CURRENTFULLVERSION ]
-    then
-        echo "Stoping at $CURRENTFULLVERSION base as requested."
+    if [ x$EXTRAVER != "x" ]; then
+	CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL.$EXTRAVER"
+    else
+	CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
+    fi
+
+    if [ $stopvers == $CURRENTFULLVERSION ]; then
+        echo "Stopping at $CURRENTFULLVERSION base as requested."
         break
     fi
 
-    SUBLEVEL=`expr $SUBLEVEL + 1`
+    while :			# incrementing EXTRAVER (x in v.p.s.x)
+    do
+	EXTRAVER=$((EXTRAVER + 1))
+	FULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL.$EXTRAVER"
+	#echo "... trying $FULLVERSION ..."
+
+	patch=patch-$FULLVERSION
+
+	# See if the file exists and find extension
+	findFile $patchdir/${patch} || break
+
+	# Apply the patch and check all is OK
+	applyPatch $patch || break
+
+	continue 2
+    done
+
+    EXTRAVER=
+    SUBLEVEL=$((SUBLEVEL + 1))
     FULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
+    #echo "___ trying $FULLVERSION ___"
+
+    if [ $((SUBLEVEL)) -gt $((STOPSUBLEVEL)) ]; then
+	echo "Stopping since sublevel ($SUBLEVEL) is beyond stop-sublevel ($STOPSUBLEVEL)"
+	exit 1
+    fi
 
     patch=patch-$FULLVERSION
 
-		# See if the file exists and find extension
-		findFile $patchdir/${patch} || break
+    # See if the file exists and find extension
+    findFile $patchdir/${patch} || break
 
     # Apply the patch and check all is OK
     applyPatch $patch || break
 done
+#echo "base all done"
 
 if [ x$gotac != x ]; then
   # Out great user wants the -ac patches
 	# They could have done -ac (get latest) or -acxx where xx=version they want
-	if [ $gotac == "-ac" ]
-	then
+	if [ $gotac == "-ac" ]; then
 	  # They want the latest version
 		HIGHESTPATCH=0
 		for PATCHNAMES in $patchdir/patch-${CURRENTFULLVERSION}-ac*\.*
@@ -176,18 +235,16 @@ if [ x$gotac != x ]; then
 			# Check it is actually a recognised patch type
 			findFile $patchdir/patch-${CURRENTFULLVERSION}-ac${ACVALUE} || break
 
-		  if [ $ACVALUE -gt $HIGHESTPATCH ]
-			then
+		  if [ $ACVALUE -gt $HIGHESTPATCH ]; then
 			  HIGHESTPATCH=$ACVALUE
 		  fi
 		done
 
-		if [ $HIGHESTPATCH -ne 0 ]
-		then
+		if [ $HIGHESTPATCH -ne 0 ]; then
 			findFile $patchdir/patch-${CURRENTFULLVERSION}-ac${HIGHESTPATCH} || break
 			applyPatch patch-${CURRENTFULLVERSION}-ac${HIGHESTPATCH}
 		else
-		  echo "No ac patches found"
+		  echo "No -ac patches found"
 		fi
 	else
 	  # They want an exact version
@@ -198,5 +255,3 @@ if [ x$gotac != x ]; then
 		applyPatch patch-${CURRENTFULLVERSION}${gotac}
 	fi
 fi
-
-

