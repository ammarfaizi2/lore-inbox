Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVGSVgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVGSVgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVGSVgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:36:33 -0400
Received: from relay03.pair.com ([209.68.5.17]:23050 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261635AbVGSVgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:36:32 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42DD7260.1060905@cybsft.com>
Date: Tue, 19 Jul 2005 16:36:32 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] 'patchview' script
References: <20050719115103.3e10ce0a.rdunlap@xenotime.net>
In-Reply-To: <20050719115103.3e10ce0a.rdunlap@xenotime.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070601070800040900070209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601070800040900070209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

randy_dunlap wrote:
> Hi,
> 
> Someone asked me about a tool like this and I didn't know of one,
> so I made this little script.
> 
> 'patchview' merges a patch file and a source tree to a set of
> temporary modified files.  This enables better patch (re)viewing
> and more viewable context.  (hopefully)
> 
> Are there already other tools that do something similar to this?
> (other than SCMs)
> 
> 
> The patchview script is here:
>   http://www.xenotime.net/linux/scripts/patchview
> 
> usage: patchview [-f] patchfile srctree
>   -f : force tkdiff even if 'patch' has errors
> 
> 
> It uses (requires) lsdiff (from patchutils) and tkdiff.
> 
> patchutils:  http://cyberelk.net/tim/patchutils/
> tkdiff:      http://sourceforge.net/projects/tkdiff/
> 
> ---
> ~Randy

Randy,

As Nick already pointed out, mktemp fails if the parent dir doesn't 
exist. The attached patch tries to create the parent if it doesn't 
exist. It also accepts a [-s] argument to bring up a single viewer at a 
time. Otherwise, if there are many different files being touched by the 
patch it dies a horrible death on my machine. Nice utility, btw.

-- 
    kr

--------------070601070800040900070209
Content-Type: text/plain;
 name="patchview.patch01"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patchview.patch01"

--- patchview.orig	2005-07-19 16:08:21.000000000 -0500
+++ patchview	2005-07-19 16:30:07.000000000 -0500
@@ -3,7 +3,6 @@
 # License:  GPL v2.
 #
 # uses patchutils (lsdiff) and tkdiff
-
 # returns 'base'
 function strip_filename()
 {
@@ -25,20 +24,55 @@
 }
 
 force=0
-patchfile=$1
-srctree=$2
+single=0
 VIEWER="tkdiff"
 # or maybe "sh -c colordiff" would work
 
-if [ "$patchfile" == "-f" ]; then
-	force=1
-	patchfile=$2
-	srctree=$3
-fi
+while [ -n "$1" ]
+do
+	case $1 in
+	-f)
+		force=1
+	;;
+
+	-s)
+		single=1
+	;;
+    	-*)
+		if [ "${1#-}" = '?' ]
+		then
+			echo "usage: patchview [-f] [-s] patchfile srctree"
+			echo "  -f : force tkdiff even if 'patch' has errors"
+			echo "  -s : single tkdiff even if 'patch' contains multiple files"
+	   		exit 0
+		fi
+	;;
+	
+    	*)
+		# Accept filename or report a warning
+		if [ -z "${patchfile}" ]
+		then
+			patchfile=$1
+			srctree=$2
+			break
+		else
+			echo "usage: patchview [-f] [-s] patchfile srctree"
+			echo "  -f : force tkdiff even if 'patch' has errors"
+			echo "  -s : single tkdiff even if 'patch' contains multiple files"
+	   		exit 0
+		fi
+	;;
+    	esac
+
+    	# Shift argument 2 into argument 1's slot.  Loop to check the argument.
+    	shift
+done
+
 
 if [ "$patchfile" = "" -o "$srctree" = "" ]; then
 	echo "usage: patchview [-f] patchfile srctree"
 	echo "  -f : force tkdiff even if 'patch' has errors"
+	echo "  -s : single tkdiff even if 'patch' contains multiple files"
 	exit 1
 fi
 
@@ -48,6 +82,10 @@
 else
 	TMPDIR=/tmp
 fi
+if [ ! -d ${TMPDIR}/XXXXXX ];then
+   mkdir ${TMPDIR}/XXXXXX || echo "failed mktemp for patch files dir."
+fi
+
 WORKDIR=`mktemp -d -p ${TMPDIR}/XXXXXX` || echo "failed mktemp for patch files dir."
 
 pfiles=`lsdiff --strip 1 $patchfile`
@@ -73,8 +111,13 @@
 
 for pf in $pfiles ; do
 	$VIEWER $WORKDIR/$pf.orig $WORKDIR/$pf &
+	if [ ${single} -eq 1 ];then
+		wait # for viewer to exit
+	fi
 done
 
-wait # for all viewers to exit
+if [ ${single} -eq 0 ];then
+	wait # for all viewers to exit
+fi
 
 rm -rf $WORKDIR

--------------070601070800040900070209--
