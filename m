Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTAMOmn>; Mon, 13 Jan 2003 09:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTAMOmn>; Mon, 13 Jan 2003 09:42:43 -0500
Received: from gate.perex.cz ([194.212.165.105]:60427 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261426AbTAMOmj>;
	Mon, 13 Jan 2003 09:42:39 -0500
Date: Mon, 13 Jan 2003 15:51:04 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP update - drivers
In-Reply-To: <Pine.LNX.4.44.0301121139450.14031-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0301131524230.501-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Linus Torvalds wrote:

> 
> On Sun, 12 Jan 2003, Jaroslav Kysela wrote:
> >
> > You can import this changeset into BK by piping this whole message to:
> > '| bk receive [path to repository]' or apply the patch as usual.
> 
> STOP THIS F*CKING MADNESS ALREADY.
> 
> If you send BK patches, at least do it right, and make sure your BK patch 
> is a proper child of something I actually _have_, so that I don't get 
> results like:
> 
> 	takepatch: can't find parent ID
> 	        perex@suse.cz|ChangeSet|20030111100546|48939
> 	        in RESYNC/SCCS/s.ChangeSet
> 
> and if you only want to send the patch and not use BK merges, then don't 
> even bother to _use_ the BK merge stuff.

I'm sorry. The empty changesets are evil. I've overlooked one. I've 
modified the bksend script to compare repositories and generate all 
missing changesets (including empty ones). Code is attached.

						Jaroslav

--- linux/Documentation/BK-usage/bksend.old	Mon Jan 13 15:34:02 2003
+++ linux/Documentation/BK-usage/bksend	Mon Jan 13 13:42:02 2003
@@ -3,34 +3,86 @@
 # Andreas Dilger <adilger@turbolabs.com>  13/02/2002
 #
 # Add diffstat output after Changelog <adilger@turbolabs.com>   21/02/2002
+# Add compare and compare_split commands to compare and show changes with
+# another repository  Jaroslav Kysela <perex@suse.cz>
 
 PROG=bksend
+REPOSITORY="http://linux.bkbits.net/linux-2.5"
 
 usage() {
 	echo "usage: $PROG -r<rev>"
 	echo -e "\twhere <rev> is of the form '1.23', '1.23..', '1.23..1.27',"
 	echo -e "\tor '+' to indicate the most recent revision"
+	echo "usage: $PROG [-S] -R<repository>"
+	echo -e "\twhere <repository> is parent repository to sync with"
+	echo -e "\tand -S means split output"
 
 	exit 1
 }
 
-case $1 in
--r) REV=$2; shift ;;
--r*) REV=`echo $1 | sed 's/^-r//'` ;;
-*) echo "$PROG: no revision given, you probably don't want that";;
-esac
-
-[ -z "$REV" ] && usage
-
-echo "You can import this changeset into BK by piping this whole message to:"
-echo "'| bk receive [path to repository]' or apply the patch as usual."
+while [ ! -z $1 ]; do
+	case $1 in
+	-r) REV=$2; [ -z "$CMD" ] && CMD=rev; shift ;;
+	-r*) REV=`echo $1 | sed 's/^-r//'`; [ -z "$CMD" ] && CMD=rev ;;
+	-R) REP=$2; [ -z "$CMD" ] && CMD=compare; shift ;;
+	-R*) REP=`echo $1 | sed 's/^-R//'`; [ -z "$CMD" ] && CMD=compare ;;
+	-S) ([ -z "$CMD" ] || [ "$CMD" = "compare" ]) && CMD=compare_split ;;
+	-H) NOHEADER=1 ;;
+	*) echo "$PROG: no option given, you probably don't want that";;
+	esac
+	shift
+done
+
+[ -z "$CMD" ] && usage
+
+if [ "$CMD" = "compare" ] && [ ! -z "$REP" ]; then
+  REPOSITORY="$REP"
+fi
+
+if [ -z "$NOHEADER" ]; then
+  echo "You can import this changeset into BK by piping this whole message to:"
+  echo "'| bk receive [path to repository]' or apply the patch as usual."
+fi
 
 SEP="\n===================================================================\n\n"
-echo -e $SEP
-bk changes -r$REV
-echo
-bk export -tpatch -du -h -r$REV | diffstat
-echo; echo
-bk export -tpatch -du -h -r$REV
-echo -e $SEP
-bk send -wgzip_uu -r$REV -
+
+case $CMD in
+rev)
+	echo -e $SEP
+	bk changes -r$REV
+	echo
+	bk export -tpatch -du -h -r$REV | diffstat
+	echo; echo
+	bk export -tpatch -du -h -r$REV
+	echo -e $SEP
+	bk send -wgzip_uu -r$REV -
+	;;
+compare)
+	bk changes -e -f -L -d':CSETREV:\n' $REPOSITORY |
+		while read rev; do
+			echo -e $SEP
+			bk changes -r$rev
+			echo
+			bk export -tpatch -du -h -r$rev | diffstat
+		done
+	bk changes -e -f -L -d':CSETREV:\n' $REPOSITORY |
+		while read rev; do
+			echo
+			echo -e $SEP
+			echo "This patch contains changeset $rev"
+			echo; echo
+			bk export -tpatch -du -h -r$rev
+		done
+	bk changes -e -f -L -d':CSETREV:\n' $REPOSITORY |
+		while read rev; do
+			echo -e $SEP
+			bk send -wgzip_uu -r$rev -
+		done
+	;;
+compare_split)
+	bk changes -e -f -L -d':CSETREV:\n' $REPOSITORY |
+		while read rev; do \
+			$0 -H -r$rev ; \
+		done
+	;;
+esac

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


