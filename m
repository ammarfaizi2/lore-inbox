Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbWADTrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbWADTrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbWADTrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:47:39 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:56767 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S965275AbWADTrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:47:39 -0500
Date: Wed, 4 Jan 2006 20:42:03 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Ryan Anderson <ryan@michonline.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Use git in scripts/setlocalversion
Message-ID: <20060104194203.GA2359@lsrfire.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently scripts/setlocalversion is a Perl script that tries to figure
out the current git commit ID of a repo without using git.  It also
imports Digest::MD5 without using it and generally is too big for the
small task it does. :]  And it always reports a git ID, even when the
HEAD is tagged -- this is a bug.

This patch replaces it with a Bourne Shell script that uses git
commands to do the same.  I can't come up with a scenario where someone
would use a git repo and refuse to install git core at the same time,
so I think it's reasonable to assume git is available.

The new script also reports uncommitted changes by adding -git_dirty to
the version string.  Obviously you can't see from that _what_ has been
changed from the last commit, so it's more of a reminder that you
forgot to commit something.

The script is easily extensible: simply add a check for Mercurial (or
whatever) below the git check.

Note: the script doesn't print a newline char anymore.  That's only
because it was easier to implement it that way, not a feature (or bug).
'make kernelrelease' doesn't care.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 7c805c8..f54dac8 100644
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -1,56 +1,22 @@
-#!/usr/bin/perl
-# Copyright 2004 - Ryan Anderson <ryan@michonline.com>  GPL v2
+#!/bin/sh
+# Print additional version information for non-release trees.
 
-use strict;
-use warnings;
-use Digest::MD5;
-require 5.006;
-
-if (@ARGV != 1) {
-	print <<EOT;
-Usage: setlocalversion <srctree>
-EOT
-	exit(1);
-}
-
-my ($srctree) = @ARGV;
-chdir($srctree);
-
-my @LOCALVERSIONS = ();
-
-# We are going to use the following commands to try and determine if this
-# repository is at a Version boundary (i.e, 2.6.10 vs 2.6.10 + some patches) We
-# currently assume that all meaningful version boundaries are marked by a tag.
-# We don't care what the tag is, just that something exists.
-
-# Git/Cogito store the top-of-tree "commit" in .git/HEAD
-# A list of known tags sits in .git/refs/tags/
-#
-# The simple trick here is to just compare the two of these, and if we get a
-# match, return nothing, otherwise, return a subset of the SHA-1 hash in
-# .git/HEAD
-
-sub do_git_checks {
-	open(H,"<.git/HEAD") or return;
-	my $head = <H>;
-	chomp $head;
-	close(H);
-
-	opendir(D,".git/refs/tags") or return;
-	foreach my $tagfile (grep !/^\.{1,2}$/, readdir(D)) {
-		open(F,"<.git/refs/tags/" . $tagfile) or return;
-		my $tag = <F>;
-		chomp $tag;
-		close(F);
-		return if ($tag eq $head);
-	}
-	closedir(D);
-
-	push @LOCALVERSIONS, "g" . substr($head,0,8);
+usage() {
+	echo "Usage: $0 [srctree]" >&2
+	exit 1
 }
 
-if ( -d ".git") {
-	do_git_checks();
-}
+cd "${1:-.}" || usage
 
-printf "-%s\n", join("-",@LOCALVERSIONS) if (scalar @LOCALVERSIONS > 0);
+# Check for git and a git repo.
+if head=`git rev-parse --verify HEAD 2>/dev/null`; then
+	# Do we have an untagged version?
+	if  [ "`git name-rev --tags HEAD`" = "HEAD undefined" ]; then
+		printf '%s%s' -g `echo "$head" | cut -c1-8`
+	fi
+
+	# Are there uncommitted changes?
+	if git diff-files | read dummy; then
+		printf '%s' -git_dirty
+	fi
+fi
