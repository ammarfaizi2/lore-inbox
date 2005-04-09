Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVDICyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVDICyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 22:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVDICyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 22:54:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61373 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261194AbVDICx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 22:53:59 -0400
Date: Sat, 9 Apr 2005 04:53:57 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ross@jose.lug.udel.edu, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Kernel SCM saga..
Message-ID: <20050409025357.GA9052@pasky.ji.cz>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	ross@jose.lug.udel.edu,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071720.GA23128@jose.lug.udel.edu> <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

Dear diary, on Fri, Apr 08, 2005 at 05:50:21PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Fri, 8 Apr 2005 ross@jose.lug.udel.edu wrote:
> > 
> > Here's a partial solution.  It does depend on a modified version of
> > cat-file that behaves like cat.  I found it easier to have cat-file
> > just dump the object indicated on stdout.  Trivial patch for that is included.
> 
> Your trivial patch is trivially incorrect, though. First off, some files
> may be binary (and definitely are - the "tree" type object contains
> pathnames, and in order to avoid having to worry about special characters
> they are NUL-terminated), and your modified "cat-file" breaks that.  
> 
> Secondly, it doesn't check or print the tag.

  FWIW, I made few small fixes (to prevent some trivial usage errors to
cause cache corruption) and added scripts gitcommit.sh, gitadd.sh and
gitlog.sh - heavily inspired by what already went through the mailing
list. Everything is available at http://pasky.or.cz/~pasky/dev/git/
(including .dircache, even though it isn't shown in the index), the
cumulative patch can be found below. The scripts aim to provide some
(obviously very interim) more high-level interface for git.

  I'm now working on tree-diff.c which will (surprise!) produce a diff
of two trees (I'll finish it after I get some sleep, though), and then I
will probably do some dwimmy gitdiff.sh wrapper for tree-diff and
show-diff. At that point I might get my hand on some pull more kind to
local changes.

  Kind regards,
				Petr Baudis

diff -ruN git-0.03/gitadd.sh git-devel-clean/gitadd.sh
--- git-0.03/gitadd.sh	1970-01-01 01:00:00.000000000 +0100
+++ git-devel-clean/gitadd.sh	2005-04-09 03:17:34.220577000 +0200
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# Add new file to a GIT repository.
+# Copyright (c) Petr Baudis, 2005
+#
+# Takes a list of file names at the command line, and schedules them
+# for addition to the GIT repository at the next commit.
+#
+# FIXME: Those files are omitted from show-diff output!
+
+for file in "$@"; do
+	echo $file >>.dircache/add-queue
+done
diff -ruN git-0.03/gitcommit.sh git-devel-clean/gitcommit.sh
--- git-0.03/gitcommit.sh	1970-01-01 01:00:00.000000000 +0100
+++ git-devel-clean/gitcommit.sh	2005-04-09 03:17:34.220577000 +0200
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Commit into a GIT repository.
+# Copyright (c) Petr Baudis, 2005
+# Based on an example script fragment sent to LKML by Linus Torvalds.
+#
+# Ignores any parameters for now, excepts changelog entry on stdin.
+#
+# FIXME: Gets it wrong for filenames containing spaces.
+
+
+if [ -r .dircache/add-queue ]; then
+	mv .dircache/add-queue .dircache/add-queue-progress
+	addedfiles=$(cat .dircache/add-queue-progress)
+else
+	addedfiles=
+fi
+changedfiles=$(show-diff -s | grep -v ': ok$' | cut -d : -f 1)
+commitfiles="$addedfiles $changedfiles"
+if [ ! "$commitfiles" ]; then
+	echo 'Nothing to commit.' >&2
+	exit
+fi
+update-cache $commitfiles
+rm -f .dircache/add-queue-progress
+
+
+oldhead=$(cat .dircache/HEAD)
+treeid=$(write-tree)
+newhead=$(commit-tree $treeid -p $oldhead)
+
+if [ "$newhead" ]; then
+	echo $newhead >.dircache/HEAD
+else
+	echo "Error during commit (oldhead $oldhead, treeid $treeid)" >&2
+fi
diff -ruN git-0.03/gitlog.sh git-devel-clean/gitlog.sh
--- git-0.03/gitlog.sh	1970-01-01 01:00:00.000000000 +0100
+++ git-devel-clean/gitlog.sh	2005-04-09 04:28:51.227791000 +0200
@@ -0,0 +1,61 @@
+#!/bin/sh
+####
+#### Call this script with an object and it will produce the change
+#### information for all the parents of that object
+####
+#### This script was originally written by Ross Vandegrift.
+# multiple parents test 1d0f4aec21e5b66c441213643426c770dc6dedc0
+# parents: ffa098b2e187b71b86a76d3cd5eb77d074a2503c
+# 6860e0d9197c7f52155466c225baf39b42d62f63
+
+# regex for parent declarations
+PARENTS="^parent [A-z0-9]{40}$"
+
+TMPCL="/tmp/gitlog.$$"
+
+# takes an object and generates the object's parent(s)
+function unpack_parents () {
+	echo "me $1"
+	echo "me $1" >>$TMPCL
+	RENTS=""
+
+	TMPCM=$(mktemp)
+	cat-file commit $1 >$TMPCM
+	while read line; do
+		if echo "$line" | egrep -q "$PARENTS"; then
+			RENTS="$RENTS "$(echo $line | sed 's/parent //g')
+		fi
+		echo $line
+	done <$TMPCM
+	rm $TMPCM
+
+	echo -e "\n--------------------------\n"
+
+	# if the last object had no parents, return
+	if [ ! "$RENTS" ]; then
+		return;
+	fi
+
+	#useful for testing
+	#echo $RENTS
+	#read
+	for i in `echo $RENTS`; do
+		# break cycles
+		if grep -q "me $i" $TMPCL; then
+			echo "Already visited $i" >&2
+			continue
+		else
+			unpack_parents $i
+		fi
+	done
+}
+
+base=$1
+if [ ! "$base" ]; then
+	base=$(cat .dircache/HEAD)
+fi
+
+rm -f $TMPCL
+unpack_parents $base
+rm -f $TMPCL
+
diff -ruN git-0.03/read-cache.c git-devel-clean/read-cache.c
--- git-0.03/read-cache.c	2005-04-08 22:51:35.000000000 +0200
+++ git-devel-clean/read-cache.c	2005-04-09 03:53:44.049642000 +0200
@@ -264,11 +264,12 @@
 	size = 0; // avoid gcc warning
 	map = (void *)-1;
 	if (!fstat(fd, &st)) {
-		map = NULL;
 		size = st.st_size;
 		errno = EINVAL;
 		if (size > sizeof(struct cache_header))
 			map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		else
+			return (!hdr->entries) ? 0 : error("inconsistent cache");
 	}
 	close(fd);
 	if (-1 == (int)(long)map)
diff -ruN git-0.03/show-diff.c git-devel-clean/show-diff.c
--- git-0.03/show-diff.c	2005-04-08 17:55:09.000000000 +0200
+++ git-devel-clean/show-diff.c	2005-04-09 03:53:44.063638000 +0200
@@ -49,9 +49,17 @@
 
 int main(int argc, char **argv)
 {
+	int silent = 0;
 	int entries = read_cache();
 	int i;
 
+	while (argc-- > 1) {
+		if (!strcmp(argv[1], "-s"))
+			silent = 1;
+		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+			usage("show-diff [-s]");
+	}
+
 	if (entries < 0) {
 		perror("read_cache");
 		exit(1);
@@ -77,6 +85,9 @@
 		for (n = 0; n < 20; n++)
 			printf("%02x", ce->sha1[n]);
 		printf("\n");
+		if (silent)
+			continue;
+
 		new = read_sha1_file(ce->sha1, type, &size);
 		show_differences(ce, &st, new, size);
 		free(new);
diff -ruN git-0.03/update-cache.c git-devel-clean/update-cache.c
--- git-0.03/update-cache.c	2005-04-08 17:53:44.000000000 +0200
+++ git-devel-clean/update-cache.c	2005-04-09 03:53:44.069637000 +0200
@@ -231,6 +231,9 @@
 		return -1;
 	}
 
+	if (argc < 2)
+		usage("update-cache <file>*");
+
 	newfd = open(".dircache/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0) {
 		perror("unable to create new cachefile");
