Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315258AbSEEAIs>; Sat, 4 May 2002 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSEEAIr>; Sat, 4 May 2002 20:08:47 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:6160 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315258AbSEEAIq>; Sat, 4 May 2002 20:08:46 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
cc: pmenage@ensim.com
Subject: [PATCH] Avoid cache bounce in __d_lookup()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 May 2002 17:08:28 -0700
Message-Id: <E1749Zk-00012g-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__d_lookup() sets DCACHE_REFERENCED in d->d_vfs_flags. In the vast
majority of lookups, this bit will already be set. To avoid unecessary
writes, and unnecessarily dirtying and bouncing the cache line
containing d_vfs_flags (which depending on the architecture, can also
contain d_op, and parts of d_name and d_iname) this patch only sets the
bit if it wasn't already set.

d_vfs_flags itself seems a bit of a waste - the only bit used in it
currently is DCACHE_REFERENCED. It might be better to move it to part of
d_flags, which is also mostly unused for local filesystems. But d_flags
appears to be protected by the BKL, rather than the dcache_lock, so the
two sets of bits might be incompatible unless we switched to using
set_bit()/clear_bit() for d_flags.

--- linux-2.5.13/fs/dcache.c	Thu May  2 17:22:42 2002
+++ linux-2.5.13-nodref/fs/dcache.c	Sat May  4 16:36:38 2002
@@ -883,7 +883,8 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+		if(!(dentry->d_vfs_flags & DCACHE_REFERENCED))
+			dentry->d_vfs_flags |= DCACHE_REFERENCED;
 		return dentry;
 	}
 	return NULL;



