Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVFWChl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVFWChl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVFWChk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:37:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261930AbVFWChY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:37:24 -0400
Date: Wed, 22 Jun 2005 19:39:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42BA1B68.9040505@pobox.com>
Message-ID: <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
 <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com>
 <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
> The problem is still that nothing says "oh, btw, I created 'xyz' tag for 
> you" AFAICS?
> 
> IMO the user (GregKH and me, at least) just wants to know their set of 
> tags and heads is up-to-date on local disk.  Wants to know what tags are 
> out there.  It's quite annoying when two data sets are out of sync 
> (.git/objects and .git/refs/tags).

Well, I really think this is the exact same issue as when you write any 
annoucement, and say "please pull from branch xyz of repo abc".

What I'm saying is that for a tagged release, that really translates to
"please pull tag xyz from repo abc" and the tools like git-ssh-pull will 
just do the right thing: they'll pull the tag itself _and_ they'll pull 
the objects it points to.

Of course, right now "git fetch" is hardcoded to always write FETCH_HEAD 
(not the tag name), but I'm saying ythat _literally_ you can do this 
already:

	git fetch repo-name tags/xyz &&
		( cat .git/FETCH_HEAD > .git/tags/xyz )

and it should do exactly what you want. Hmm?

So if we script this (maybe teach "git-fetch-script" to take "tag" as its 
first argument and do this on its own), and people learn to just do

	git fetch tag v2.6.18.5

when Chris or Greg make an announcement about "v2.6.18.5", then you're all
done, no?

The change to "git-fetch-script" would look something like the appended.. 
Totally untested, of course. Give it a try,

			Linus

---
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,5 +1,12 @@
 #!/bin/sh
 #
+destination=FETCH_HEAD
+
+if [ "$1" = "tag" ]; then
+	shift
+	destination="refs/tags/$2"
+fi
+
 merge_repo=$1
 merge_name=${2:-HEAD}
 
@@ -35,7 +42,7 @@ download_objects () {
 }
 
 echo "Getting remote $merge_name"
-download_one "$merge_repo/$merge_name" "$GIT_DIR"/FETCH_HEAD || exit 1
+download_one "$merge_repo/$merge_name" "$GIT_DIR/$dest" || exit 1
 
 echo "Getting object database"
-download_objects "$merge_repo" "$(cat "$GIT_DIR"/FETCH_HEAD)" || exit 1
+download_objects "$merge_repo" "$(cat "$GIT_DIR/$dest")" || exit 1
