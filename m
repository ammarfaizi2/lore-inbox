Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVKRDeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVKRDeQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVKRDeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:34:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59398 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932297AbVKRDdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:33:46 -0500
Date: Fri, 18 Nov 2005 04:33:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ext2/bitmap.c: ext2_count_free() is only required #ifdef EXT2FS_DEBUG
Message-ID: <20051118033345.GW11494@stusta.de>
References: <20050513004731.GU3603@stusta.de> <20050513224004.3f68a1e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513224004.3f68a1e8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 10:40:04PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >  --- linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h.old	2005-04-20 23:08:52.000000000 +0200
> >  +++ linux-2.6.12-rc2-mm3-full/fs/ext2/ext2.h	2005-04-20 23:14:21.000000000 +0200
> >  @@ -1,5 +1,6 @@
> >   #include <linux/fs.h>
> >   #include <linux/ext2_fs.h>
> >  +#include <linux/buffer_head.h>
> >   
> >   /*
> >    * second extended file system inode data in memory
> >  @@ -79,6 +80,22 @@
> >   	return container_of(inode, struct ext2_inode_info, vfs_inode);
> >   }
> >   
> >  +static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
> >  +
> 
> This will cause a copy of `nibblemap' to be included in each compilation
> unit which uses ext2.h.  Unless the compiler is sufficiently smart to elide
> it, which it might be.  But then it might be sufficiently smart to generate
> a "you're not usig this" warning too.
> 
> If it's only needed for EXT2_DEBUG then I'd be inclined to move it into one
> of the other .c files, inside EXT2_DEBUG.  Or just leave it as-is.

Patch below.

cu
Adrian


<--  snip  -->


There's no need for ext2_count_free() #ifndef EXT2FS_DEBUG.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ext2/bitmap.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.15-rc1-mm1-full/fs/ext2/bitmap.c.old	2005-11-18 02:48:33.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/fs/ext2/bitmap.c	2005-11-18 02:50:16.000000000 +0100
@@ -7,8 +7,12 @@
  * Universite Pierre et Marie Curie (Paris VI)
  */
 
+#ifdef EXT2FS_DEBUG
+
 #include <linux/buffer_head.h>
 
+#include "ext2.h"
+
 static int nibblemap[] = {4, 3, 3, 2, 3, 2, 2, 1, 3, 2, 2, 1, 2, 1, 1, 0};
 
 unsigned long ext2_count_free (struct buffer_head * map, unsigned int numchars)
@@ -23,3 +27,6 @@
 			nibblemap[(map->b_data[i] >> 4) & 0xf];
 	return (sum);
 }
+
+#endif  /*  EXT2FS_DEBUG  */
+

