Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285230AbRLMWXO>; Thu, 13 Dec 2001 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285233AbRLMWXE>; Thu, 13 Dec 2001 17:23:04 -0500
Received: from colorfullife.com ([216.156.138.34]:16649 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285230AbRLMWW5>;
	Thu, 13 Dec 2001 17:22:57 -0500
Message-ID: <3C192A37.4547D2A7@colorfullife.com>
Date: Thu, 13 Dec 2001 23:22:47 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ak@suse.de
Subject: optimize DNAME_INLINE_LEN
Content-Type: multipart/mixed;
 boundary="------------D62923DC8347475E35E3D70B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D62923DC8347475E35E3D70B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The dcache entries are allocated with SLAB_HWCACHE_ALIGN. For better
memory usage, we should increase DNAME_INLINE_LEN so that sizeof(struct
dentry) becomes a multiple of the L1 cache line size.

On i386 the DNAME_INLINE_LEN becomes 36 bytes instead of 16, which saves
thousands of kmallocs for external file names. (12818 on my debug
system, after updatedb)

The attached patch is preliminary, it doesn't compile with egcs-1.1.2.
Which gcc version added support for unnamed structures?

--
	Manfred
--------------D62923DC8347475E35E3D70B
Content-Type: text/plain; charset=us-ascii;
 name="patch-dcache"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-dcache"

--- 2.5/include/linux/dcache.h	Thu Oct 11 15:20:18 2001
+++ build-2.5/include/linux/dcache.h	Thu Dec 13 22:55:50 2001
@@ -61,9 +61,7 @@
 	return end_name_hash(hash);
 }
 
-#define DNAME_INLINE_LEN 16
-
-struct dentry {
+struct dentry_nameless {
 	atomic_t d_count;
 	unsigned int d_flags;
 	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
@@ -80,6 +78,12 @@
 	struct super_block * d_sb;	/* The root of the dentry tree */
 	unsigned long d_vfs_flags;
 	void * d_fsdata;		/* fs-specific data */
+};
+#define DNAME_INLINE_LEN \
+	(16 + L1_CACHE_BYTES - (16+sizeof(struct dentry_nameless))%L1_CACHE_BYTES)
+
+struct dentry {
+	struct dentry_nameless;
 	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
 };
 

--------------D62923DC8347475E35E3D70B--

