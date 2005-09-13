Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVIMIU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVIMIU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVIMIU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:20:29 -0400
Received: from mail.autoweb.net ([198.172.237.26]:52122 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932440AbVIMIU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:20:28 -0400
Date: Tue, 13 Sep 2005 04:20:24 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Auto-localversion doesn't detect tags correctly
Message-ID: <20050913082020.GF5276@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The first version of scripts/setlocalversion failed to notice tags
correctly, and such would always append the -gXXXXXXXX version
identifier.  This converts it to use git-rev-parse and the magic
notation to reduce a tag to the commit it refers to ("$tag^0").

Signed-off-by: Ryan Anderson <ryan@michonline.com>

Index: linux-git/scripts/setlocalversion
===================================================================
--- linux-git.orig/scripts/setlocalversion	2005-09-13 04:03:19.000000000 -0400
+++ linux-git/scripts/setlocalversion	2005-09-13 04:17:28.000000000 -0400
@@ -36,13 +36,38 @@ sub do_git_checks {
 	chomp $head;
 	close(H);
 
-	opendir(D,".git/refs/tags") or return;
+	unless (opendir(D,".git/refs/tags")) {
+		warn "Failed to open .git/refs/tags : " . $!;
+		return;
+	}
 	foreach my $tagfile (grep !/^\.{1,2}$/, readdir(D)) {
-		open(F,"<.git/refs/tags/" . $tagfile) or return;
+		unless (open(F,"<",".git/refs/tags/" . $tagfile)) {
+			warn "Failed to open .git/refs/tags/$tagfile : " . $!;
+			return;
+		}
 		my $tag = <F>;
 		chomp $tag;
 		close(F);
-		return if ($tag eq $head);
+
+		local(*oldstderr) = *STDERR;
+		open(STDERR,">","/dev/null")
+			or die "Failed to reopen stderr: $!";
+
+		unless (open(P,"-|","git-rev-parse",sprintf("%s^0",$tag))) {
+			*STDERR = *oldstderr;
+			die "Failed to open pipe from git-rev-parse: $!";
+		}
+
+		*STDERR = *oldstderr;
+
+		my $commit = <P>;
+		chomp $commit;
+
+		if ($tag eq $head) {
+			warn "$tagfile refers to commit $head (maybe indirectly)";
+			return;
+		}
+		#return if ($tag eq $head);
 	}
 	closedir(D);
 
-- 

Ryan Anderson
  sometimes Pug Majere
