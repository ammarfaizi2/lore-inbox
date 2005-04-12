Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVDLAIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVDLAIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDLAIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:08:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:52108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261753AbVDLAHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:07:18 -0400
Date: Mon, 11 Apr 2005 17:07:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: David Greaves <david@dgreaves.com>
Cc: sam@ravnborg.org, greg@kroah.com, haphazard@kc.rr.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] scripts/patch-kernel: EXTRAVERSION patches are not
 incremental
Message-Id: <20050411170706.3c244b62.rddunlap@osdl.org>
In-Reply-To: <42370A3A.6020206@dgreaves.com>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
	<20040814101039.GA27163@alpha.home.local>
	<Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org>
	<20040814115548.A19527@infradead.org>
	<Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org>
	<411E0A37.5040507@anomalistic.org>
	<20040814205707.GA11936@yggdrasil.localdomain>
	<20040818135751.197ce3c9.rddunlap@osdl.org>
	<20040822204002.GB8639@mars.ravnborg.org>
	<42370A3A.6020206@dgreaves.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__11_Apr_2005_17_07_06_-0700_lFU1kW9cO4UmCNXw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__11_Apr_2005_17_07_06_-0700_lFU1kW9cO4UmCNXw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Mar 2005 16:15:54 +0000 David Greaves wrote:

| Old thread (!) but this is the last time I could find patch-kernel updated.

I found a little time to update patch-kernel if anyone wants
to use it.  OTOH, using Matt Mackall's "ketchup" is OK too.

I also use 'kcurrent' to keep up with the latest kernel vesions
available -- as noted on www.kernel.org.  It's also attached
and both scripts are available at
  http://developer.osdl.org/rddunlap/scripts/

---

patch-kernel: support non-incremental 2.6.x.y 'stable' patches

# Add better support for (non-incremental) 2.6.x.y patches;
# If an ending version number if not specified, the script automatically
# increments the SUBLEVEL (x in 2.6.x.y) until no more patch files are found;
# however, EXTRAVERSION (y in 2.6.x.y) is never automatically incremented
# but must be specified fully.
#
# patch-kernel does not normally support reverse patching, but does so when
# applying EXTRAVERSION (x.y) patches, so that moving from 2.6.11.y to 2.6.11.z
# is easy and handled by the script (reverse 2.6.11.y and apply 2.6.11.z).

 patch-kernel |  131 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 101 insertions(+), 30 deletions(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

--- patch-kernel-004	2004-08-18 12:12:19.000000000 -0700
+++ patch-kernel	2005-04-11 17:02:38.000000000 -0700
@@ -46,6 +46,19 @@
 # fix some whitespace damage;
 # be smarter about stopping when current version is larger than requested;
 #	Randy Dunlap <rddunlap@osdl.org>, 2004-AUG-18.
+#
+# Add better support for (non-incremental) 2.6.x.y patches;
+# If an ending version number if not specified, the script automatically
+# increments the SUBLEVEL (x in 2.6.x.y) until no more patch files are found;
+# however, EXTRAVERSION (y in 2.6.x.y) is never automatically incremented
+# but must be specified fully.
+#
+# patch-kernel does not normally support reverse patching, but does so when
+# applying EXTRAVERSION (x.y) patches, so that moving from 2.6.11.y to 2.6.11.z
+# is easy and handled by the script (reverse 2.6.11.y and apply 2.6.11.z).
+#	Randy Dunlap <rddunlap@osdl.org>, 2005-APR-08.
+
+PNAME=patch-kernel
 
 # Set directories from arguments, or use defaults.
 sourcedir=${1-/usr/src/linux}
@@ -54,7 +67,7 @@ stopvers=${3-default}
 
 if [ "$1" == -h -o "$1" == --help -o ! -r "$sourcedir/Makefile" ]; then
 cat << USAGE
-usage: patch-kernel [-h] [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
+usage: $PNAME [-h] [ sourcedir [ patchdir [ stopversion ] [ -acxx ] ] ]
   source directory defaults to /usr/src/linux,
   patch directory defaults to the current directory,
   stopversion defaults to <all in patchdir>.
@@ -73,6 +86,19 @@ do
 done
 
 # ---------------------------------------------------------------------------
+# arg1 is filename
+noFile () {
+	echo "cannot find patch file: ${patch}"
+	exit 1
+}
+
+# ---------------------------------------------------------------------------
+backwards () {
+	echo "$PNAME does not support reverse patching"
+	exit 1
+}
+
+# ---------------------------------------------------------------------------
 # Find a file, first parameter is basename of file
 # it tries many compression mechanisms and sets variables to say how to get it
 findFile () {
@@ -133,6 +159,28 @@ applyPatch () {
   return 0;
 }
 
+# ---------------------------------------------------------------------------
+# arg1 is patch filename
+reversePatch () {
+	echo -n "Reversing $1 (${name}) ... "
+	if $uncomp ${patchdir}/"$1"${ext} | patch -p1 -Rs -N -E -d $sourcedir
+	then
+		echo "done."
+	else
+		echo "failed.  Clean it up."
+		exit 1
+	fi
+	if [ "`find $sourcedir/ '(' -name '*.rej' -o -name '.*.rej' ')' -print`" ]
+	then
+		echo "Aborting.  Reject files found."
+		return 1
+	fi
+	# Remove backup files
+	find $sourcedir/ '(' -name '*.orig' -o -name '.*.orig' ')' -exec rm -f {} \;
+
+	return 0
+}
+
 # set current VERSION, PATCHLEVEL, SUBLEVEL, EXTRAVERSION
 TMPFILE=`mktemp .tmpver.XXXXXX` || { echo "cannot make temp file" ; exit 1; }
 grep -E "^(VERSION|PATCHLEVEL|SUBLEVEL|EXTRAVERSION)" $sourcedir/Makefile > $TMPFILE
@@ -160,53 +208,57 @@ then
 		EXTRAVER=$EXTRAVERSION
 	fi
 	EXTRAVER=${EXTRAVER%%[[:punct:]]*}
-	#echo "patch-kernel: changing EXTRAVERSION from $EXTRAVERSION to $EXTRAVER"
+	#echo "$PNAME: changing EXTRAVERSION from $EXTRAVERSION to $EXTRAVER"
 fi
 
 #echo "stopvers=$stopvers"
 if [ $stopvers != "default" ]; then
 	STOPSUBLEVEL=`echo $stopvers | cut -d. -f3`
 	STOPEXTRA=`echo $stopvers | cut -d. -f4`
-	#echo "STOPSUBLEVEL=$STOPSUBLEVEL, STOPEXTRA=$STOPEXTRA"
+	#echo "#___STOPSUBLEVEL=/$STOPSUBLEVEL/, STOPEXTRA=/$STOPEXTRA/"
 else
 	STOPSUBLEVEL=9999
 	STOPEXTRA=9999
 fi
 
-while :				# incrementing SUBLEVEL (s in v.p.s)
-do
-    if [ x$EXTRAVER != "x" ]; then
+# This all assumes a 2.6.x[.y] kernel tree.
+# Don't allow backwards/reverse patching.
+if [ $STOPSUBLEVEL -lt $SUBLEVEL ]; then
+	backwards
+fi
+
+if [ x$EXTRAVER != "x" ]; then
 	CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL.$EXTRAVER"
-    else
+else
 	CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
-    fi
+fi
+
+if [ x$EXTRAVER != "x" ]; then
+	echo "backing up to: $VERSION.$PATCHLEVEL.$SUBLEVEL"
+	patch="patch-${CURRENTFULLVERSION}"
+	findFile $patchdir/${patch} || noFile ${patch}
+	reversePatch ${patch} || exit 1
+fi
+
+# now current is 2.6.x, with no EXTRA applied,
+# so update to target SUBLEVEL (2.6.SUBLEVEL)
+# and then to target EXTRAVER (2.6.SUB.EXTRAVER) if requested.
+# If not ending sublevel is specified, it is incremented until
+# no further sublevels are found.
 
+if [ $STOPSUBLEVEL -gt $SUBLEVEL ]; then
+while :				# incrementing SUBLEVEL (s in v.p.s)
+do
+    CURRENTFULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
+    EXTRAVER=
     if [ $stopvers == $CURRENTFULLVERSION ]; then
         echo "Stopping at $CURRENTFULLVERSION base as requested."
         break
     fi
 
-    while :			# incrementing EXTRAVER (x in v.p.s.x)
-    do
-	EXTRAVER=$((EXTRAVER + 1))
-	FULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL.$EXTRAVER"
-	#echo "... trying $FULLVERSION ..."
-
-	patch=patch-$FULLVERSION
-
-	# See if the file exists and find extension
-	findFile $patchdir/${patch} || break
-
-	# Apply the patch and check all is OK
-	applyPatch $patch || break
-
-	continue 2
-    done
-
-    EXTRAVER=
     SUBLEVEL=$((SUBLEVEL + 1))
     FULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL"
-    #echo "___ trying $FULLVERSION ___"
+    #echo "#___ trying $FULLVERSION ___"
 
     if [ $((SUBLEVEL)) -gt $((STOPSUBLEVEL)) ]; then
 	echo "Stopping since sublevel ($SUBLEVEL) is beyond stop-sublevel ($STOPSUBLEVEL)"
@@ -214,14 +266,33 @@ do
     fi
 
     patch=patch-$FULLVERSION
-
     # See if the file exists and find extension
-    findFile $patchdir/${patch} || break
+    findFile $patchdir/${patch} || noFile ${patch}
 
     # Apply the patch and check all is OK
     applyPatch $patch || break
 done
-#echo "base all done"
+#echo "#___sublevel all done"
+fi
+
+# There is no incremental searching for extraversion...
+if [ "$STOPEXTRA" != "" ]; then
+while :				# just to allow break
+do
+# apply STOPEXTRA directly (not incrementally) (x in v.p.s.x)
+	FULLVERSION="$VERSION.$PATCHLEVEL.$SUBLEVEL.$STOPEXTRA"
+	#echo "#... trying $FULLVERSION ..."
+	patch=patch-$FULLVERSION
+
+	# See if the file exists and find extension
+	findFile $patchdir/${patch} || noFile ${patch}
+
+	# Apply the patch and check all is OK
+	applyPatch $patch || break
+	#echo "#___extraver all done"
+	break
+done
+fi
 
 if [ x$gotac != x ]; then
   # Out great user wants the -ac patches

--Multipart=_Mon__11_Apr_2005_17_07_06_-0700_lFU1kW9cO4UmCNXw
Content-Type: application/octet-stream;
 name="kcurrent"
Content-Disposition: attachment;
 filename="kcurrent"
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaAoKZWNobwp3Z2V0IC1xIC1PIC0gaHR0cDovL3d3dy5rZXJuZWwub3JnL2tkaXN0
L2Zpbmdlcl9iYW5uZXIKZWNobwo=

--Multipart=_Mon__11_Apr_2005_17_07_06_-0700_lFU1kW9cO4UmCNXw--
