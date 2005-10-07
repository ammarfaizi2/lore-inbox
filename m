Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030177AbVJGXzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030177AbVJGXzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVJGXzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:55:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:26070 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964933AbVJGXzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:55:25 -0400
Date: Fri, 7 Oct 2005 16:55:00 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, viro@ftp.linux.org.uk
Subject: [patch 6/7] Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL
Message-ID: <20051007235500.GG23111@kroah.com>
References: <20051007234348.631583000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="plug-names_cache-memleak.patch"
In-Reply-To: <20051007235353.GA23111@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>

Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL

The nameidata "last.name" is always allocated with "__getname()", and
should always be free'd with "__putname()".

Using "putname()" without the underscores will leak memory, because the
allocation will have been hidden from the AUDITSYSCALL code.

Arguably the real bug is that the AUDITSYSCALL code is really broken,
but in the meantime this fixes the problem people see.

Reported by Robert Derr, patch by Rick Lindsley.

Acked-by: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/namei.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.13.y.orig/fs/namei.c
+++ linux-2.6.13.y/fs/namei.c
@@ -1557,19 +1557,19 @@ do_link:
 	if (nd->last_type != LAST_NORM)
 		goto exit;
 	if (nd->last.name[nd->last.len]) {
-		putname(nd->last.name);
+		__putname(nd->last.name);
 		goto exit;
 	}
 	error = -ELOOP;
 	if (count++==32) {
-		putname(nd->last.name);
+		__putname(nd->last.name);
 		goto exit;
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
 	path.dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 	path.mnt = nd->mnt;
-	putname(nd->last.name);
+	__putname(nd->last.name);
 	goto do_last;
 }
 

--
