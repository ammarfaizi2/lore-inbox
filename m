Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUGLSMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUGLSMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUGLSMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:12:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:47765 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266910AbUGLSMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:12:40 -0400
Date: Mon, 12 Jul 2004 11:11:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: torvalds@osdl.org, dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: struct_cpy() and kAFS (was: Re: Linux 2.6.8-rc1)
Message-Id: <20040712111120.2094f089.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0407121519380.17199@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
	<Pine.GSO.4.58.0407121519380.17199@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sun, 11 Jul 2004, Linus Torvalds wrote:
>  > David Howells:
>  >   o kAFS automount support
> 
>  After this change, all archs need to provide struct_cpy() to make AFS compile,
>  while currently only ia32 and amd64 provide it.

Seems a strange thing to do.  Why not rely on the type system?

diff -puN fs/afs/mntpt.c~kafs-struct_cpy fs/afs/mntpt.c
--- 25/fs/afs/mntpt.c~kafs-struct_cpy	2004-07-12 11:08:39.125941824 -0700
+++ 25-akpm/fs/afs/mntpt.c	2004-07-12 11:08:55.972380776 -0700
@@ -250,7 +250,7 @@ static int afs_mntpt_follow_link(struct 
 	if (IS_ERR(newmnt))
 		return PTR_ERR(newmnt);
 
-	struct_cpy(&newnd, nd);
+	newnd = *nd;
 	newnd.dentry = dentry;
 	err = do_add_mount(newmnt, &newnd, 0, &afs_vfsmounts);
 
diff -puN fs/afs/vlocation.c~kafs-struct_cpy fs/afs/vlocation.c
--- 25/fs/afs/vlocation.c~kafs-struct_cpy	2004-07-12 11:08:39.141939392 -0700
+++ 25-akpm/fs/afs/vlocation.c	2004-07-12 11:09:31.815931728 -0700
@@ -906,7 +906,7 @@ static cachefs_match_val_t afs_vlocation
 		if (!vlocation->valid ||
 		    vlocation->vldb.rtime == vldb->rtime
 		    ) {
-			struct_cpy(&vlocation->vldb, vldb);
+			vlocation->vldb = *vldb;
 			vlocation->valid = 1;
 			_leave(" = SUCCESS [c->m]");
 			return CACHEFS_MATCH_SUCCESS;
@@ -947,7 +947,7 @@ static void afs_vlocation_cache_update(v
 
 	_enter("");
 
-	struct_cpy(vldb,&vlocation->vldb);
+	*vldb = vlocation->vldb;
 
 } /* end afs_vlocation_cache_update() */
 #endif
_

