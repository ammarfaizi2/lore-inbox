Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbVIZGnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbVIZGnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVIZGnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:43:07 -0400
Received: from mail.autoweb.net ([198.172.237.26]:29058 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932412AbVIZGnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:43:05 -0400
Date: Mon, 26 Sep 2005 02:43:03 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Auto-localversion should use git commands and behaviors
Message-ID: <20050926064302.GA23034@mythryan2.michonline.com>
References: <20050913082020.GF5276@mythryan2.michonline.com> <20050914044623.GA8099@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914044623.GA8099@mars.ravnborg.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auto-localversion support should use git commands and behaviors whenever possible.

This fully switches to using git-rev-parse to dereference tags and
symbolic heads (HEAD, for example), and emulates the behavior of git
with respect to the use of the environment variable GIT_DIR.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

Index: linux-git/scripts/setlocalversion
===================================================================
--- linux-git.orig/scripts/setlocalversion	2005-09-25 15:00:49.000000000 -0400
+++ linux-git/scripts/setlocalversion	2005-09-26 02:36:33.000000000 -0400
@@ -23,51 +23,61 @@ my @LOCALVERSIONS = ();
 # currently assume that all meaningful version boundaries are marked by a tag.
 # We don't care what the tag is, just that something exists.
 
-# Git/Cogito store the top-of-tree "commit" in .git/HEAD
+# Git/Cogito store the top-of-tree "committish" in .git/HEAD
 # A list of known tags sits in .git/refs/tags/
 #
 # The simple trick here is to just compare the two of these, and if we get a
 # match, return nothing, otherwise, return a subset of the SHA-1 hash in
 # .git/HEAD
 
+# First, a helper routine to convert symbolic names into
+# git committish values.
+
+sub git_rev_parse {
+	my ($rev) = @_;
+
+	local(*oldstderr) = *STDERR;
+	open(STDERR,">","/dev/null")
+		or die "Failed to reopen stderr: $!";
+
+	unless (open(P,"-|","git-rev-parse",sprintf("%s^0",$rev))) {
+		*STDERR = *oldstderr;
+		die "Failed to open pipe from git-rev-parse: $!";
+	}
+
+	*STDERR = *oldstderr;
+
+	my $commit = <P>;
+	chomp $commit;
+
+	close(P);
+
+	return $commit;
+}
+
+# Next, the guts, as outlined above.
+# git-rev-parse $tag^0 evaluates $tag and dereferences it until
+# we get to a committish
+
 sub do_git_checks {
-	open(H,"<.git/HEAD") or return;
-	my $head = <H>;
-	chomp $head;
-	close(H);
+	my $sanity_check = `which git-rev-parse`;
+	return unless $sanity_check =~ m/git-rev-parse/;
+
+	my $head = git_rev_parse("HEAD");
+
+	my $GITDIR = exists $ENV{'GIT_DIR'} ? $ENV{'GIT_DIR'} : ".git";
 
-	unless (opendir(D,".git/refs/tags")) {
-		warn "Failed to open .git/refs/tags : " . $!;
+
+	unless (opendir(D,"$GITDIR/refs/tags")) {
+		warn "Failed to open $GITDIR/refs/tags : " . $!;
 		return;
 	}
 	foreach my $tagfile (grep !/^\.{1,2}$/, readdir(D)) {
-		unless (open(F,"<",".git/refs/tags/" . $tagfile)) {
-			warn "Failed to open .git/refs/tags/$tagfile : " . $!;
-			return;
-		}
-		my $tag = <F>;
-		chomp $tag;
-		close(F);
-
-		local(*oldstderr) = *STDERR;
-		open(STDERR,">","/dev/null")
-			or die "Failed to reopen stderr: $!";
-
-		unless (open(P,"-|","git-rev-parse",sprintf("%s^0",$tag))) {
-			*STDERR = *oldstderr;
-			die "Failed to open pipe from git-rev-parse: $!";
-		}
-
-		*STDERR = *oldstderr;
-
-		my $commit = <P>;
-		chomp $commit;
+		my $commit = git_rev_parse($tagfile);
 
-		if ($tag eq $head) {
-			warn "$tagfile refers to commit $head (maybe indirectly)";
+		if ($commit eq $head) {
 			return;
 		}
-		#return if ($tag eq $head);
 	}
 	closedir(D);
 

-- 

Ryan Anderson
  sometimes Pug Majere
