Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290516AbSAYCrJ>; Thu, 24 Jan 2002 21:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290519AbSAYCq7>; Thu, 24 Jan 2002 21:46:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22010 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290516AbSAYCqn>;
	Thu, 24 Jan 2002 21:46:43 -0500
Date: Thu, 24 Jan 2002 21:46:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 FS corruption in 2.5.3-pre[3-5]
In-Reply-To: <200201250035.BAA27730@harpo.it.uu.se>
Message-ID: <Pine.GSO.4.21.0201242135520.23657-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Jan 2002, Mikael Pettersson wrote:

> Since -pre3, ext2 (and perhaps other FSs, I haven't checked) uses an
> in-core inode layout consisting of an FS-specific head followed by the
> generic inode. ext2 allocates these in fs/ext2/super.c:ext2_alloc_inode(),
> but doesn't clear the ext2-specific fields. fs/inode.c:alloc_inode()
> neither knows about these fields nor clears them, so the ext2-specific
> data remains uninitialised when the new inode is returned for use. Ouch.
> 
> The patch below fixes this by adding the missing memset() to
> fs/ext2/super.c:ext2_alloc_inode(). Works fine over here.

This is very odd, since ext2_new_inode() and ext2_read_inode() _do_
clean (or otherwise set) them.  Let me check...

Arrgh.  1 missing in ext2_new_inode()  and 1 (harmless) in ext2_read_inode()

--- C3-pre4/fs/ext2/ialloc.c	Wed Jan 23 20:45:32 2002
+++ /tmp/ialloc.c	Thu Jan 24 21:41:52 2002
@@ -392,6 +392,7 @@
 		ei->i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
 	ei->i_faddr = 0;
 	ei->i_frag_no = 0;
+	ei->i_frag_size = 0;
 	ei->i_osync = 0;
 	ei->i_file_acl = 0;
 	ei->i_dir_acl = 0;

and

--- C3-pre4/fs/ext2/inode.c	Wed Jan 23 20:45:32 2002
+++ /tmp/inode.c	Thu Jan 24 21:44:48 2002
@@ -963,6 +963,7 @@
 	ei->i_frag_size = raw_inode->i_fsize;
 	ei->i_osync = 0;
 	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
+	ei->i_dir_acl = 0;
 	if (S_ISREG(inode->i_mode))
 		inode->i_size |= ((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32;
 	else

resp.


