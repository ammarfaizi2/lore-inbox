Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSJPW5z>; Wed, 16 Oct 2002 18:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbSJPW5y>; Wed, 16 Oct 2002 18:57:54 -0400
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:43909 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S261439AbSJPW5x>;
	Wed, 16 Oct 2002 18:57:53 -0400
Date: Wed, 16 Oct 2002 18:03:50 -0500
From: Matt Reppert <arashi@arashi.yi.org>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AFS compile breakage in 2.5.43
Message-Id: <20021016180350.52bc09ad.arashi@arashi.yi.org>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this valid? gcc-2.95.3 doesn't like it at all.
[fs/afs/dir.c line 65]

typedef union afs_dirent {
        struct {
                u8      valid;
                u8      unused[1];
                u16     hash_next;
                u32     vnode;
                u32     unique;
                u8      name[16];
                u8      overflow[4];    /* if any char of the name (inc NUL) reaches here, consume
                                         * the next dirent too */
        };
        u8      extended_name[32];
} afs_dirent_t;

This breaks compile of AFS due to members of the unnamed struct being
used as members of afs_dirent_t objects:
fs/afs/dir.c:75: warning: unnamed struct/union that defines no instances
fs/afs/dir.c: In function `afs_dir_iterate_block':
fs/afs/dir.c:261: union has no member named `name'
fs/afs/dir.c:293: union has no member named `name'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:297: union has no member named `unique'

The following makes it compile.

--- linux-2.5.43-orig/fs/afs/dir	2002-10-16 17:54:04 -0500
+++ linux-2.5.43/fs/afs/dir.c	2002-10-16 17:55:07 -0500
@@ -72,7 +72,7 @@
 		u8	name[16];
 		u8	overflow[4];	/* if any char of the name (inc NUL) reaches here, consume
 					 * the next dirent too */
-	};
+	} ent;
 	u8	extended_name[32];
 } afs_dirent_t;
 
@@ -258,7 +258,7 @@
 
 		/* got a valid entry */
 		dire = &block->dirents[offset];
-		nlen = strnlen(dire->name,sizeof(*block) - offset*sizeof(afs_dirent_t));
+		nlen = strnlen(dire->ent.name,sizeof(*block) - offset*sizeof(afs_dirent_t));
 
 		_debug("ENT[%u.%u]: %s %u \"%.*s\"\n",
 		       blkoff/sizeof(afs_dir_block_t),offset,
@@ -290,11 +290,11 @@
 
 		/* found the next entry */
 		ret = filldir(cookie,
-			      dire->name,
+			      dire->ent.name,
 			      nlen,
 			      blkoff + offset * sizeof(afs_dirent_t),
-			      ntohl(dire->vnode),
-			      filldir==afs_dir_lookup_filldir ? dire->unique : DT_UNKNOWN);
+			      ntohl(dire->ent.vnode),
+			      filldir==afs_dir_lookup_filldir ? dire->ent.unique : DT_UNKNOWN);
 		if (ret<0) {
 			_leave(" = 0 [full]");
 			return 0;


Matt
