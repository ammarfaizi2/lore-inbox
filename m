Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVI2VgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVI2VgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVI2VgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:36:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030247AbVI2VgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:36:15 -0400
Date: Thu, 29 Sep 2005 14:35:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
In-Reply-To: <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0509291433040.5362@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Sep 2005, Linus Torvalds wrote:
> 
> Gaah. Using a new pine version, and it is back to corrupting whitespace.

Ok, disabling "text flowing" seems to have fixed it. It still leaves empty 
spaces at the end of lines when doing normal word-wrapping in the editor 
(and then seems to use those empty spaces as a "marker" for flowing), but 
that's at least just a small silly detail.

So how about this patch now? With it you can do

	git fetch --tags <linus-kernel-repo>

and it should fetch all my tags automatically.

		Linus
---
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -5,6 +5,8 @@
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
+all=
+tags=
 append=
 force=
 update_head_ok=
@@ -17,6 +19,12 @@ do
 	-f|--f|--fo|--for|--forc|--force)
 		force=t
 		;;
+	--tags)
+		tags=t
+		;;
+	--all)
+		all=t
+		;;
 	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
 	--update-he|--update-hea|--update-head|--update-head-|\
 	--update-head-o|--update-head-ok)
@@ -158,7 +166,16 @@ case "$update_head_ok" in
 	;;
 esac
 
-for ref in $(get_remote_refs_for_fetch "$@")
+taglist=
+if [ "$tags$all" ]; then
+	pattern='/refs\/tags/'
+	if [ "$all" ]; then
+		pattern='/refs/'
+	fi
+	taglist=$(git-ls-remote "$remote" | awk "$pattern"' { print $2":"$2 }')
+fi
+
+for ref in $(get_remote_refs_for_fetch "$@" $taglist)
 do
     refs="$refs $ref"
 
