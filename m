Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285255AbRLMXY3>; Thu, 13 Dec 2001 18:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285257AbRLMXYU>; Thu, 13 Dec 2001 18:24:20 -0500
Received: from colorfullife.com ([216.156.138.34]:32521 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285255AbRLMXYC>;
	Thu, 13 Dec 2001 18:24:02 -0500
Message-ID: <3C193897.893088D9@colorfullife.com>
Date: Fri, 14 Dec 2001 00:24:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: optimize DNAME_INLINE_LEN
In-Reply-To: <3C192A37.4547D2A7@colorfullife.com> <20011213160706.E940@lynx.no>
Content-Type: multipart/mixed;
 boundary="------------7D1CDA7038AA77A7C6AD60BE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7D1CDA7038AA77A7C6AD60BE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andreas Dilger wrote:
> 
> You can also do preprocessor macro tricks to get something like an unnamed
> union in a struct, but it is also a bit ugly.
>
I'd prefer that (patch attached, tested with egcs-1.1.2)

Unless I receive complaints, I'll send it to Linus tomorrow, and then
backport to 2.4 after Linus merged it.

--
	Manfred
--------------7D1CDA7038AA77A7C6AD60BE
Content-Type: text/plain; charset=us-ascii;
 name="patch-dcache"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-dcache"

--- 2.5/include/linux/dcache.h	Thu Oct 11 15:20:18 2001
+++ build-2.5/include/linux/dcache.h	Thu Dec 13 23:39:32 2001
@@ -61,25 +61,33 @@
 	return end_name_hash(hash);
 }
 
-#define DNAME_INLINE_LEN 16
+#define DENTRY_MEMBERS \
+	atomic_t d_count; \
+	unsigned int d_flags; \
+	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */ \
+	struct dentry * d_parent;	/* parent directory */ \
+	struct list_head d_hash;	/* lookup hash list */ \
+	struct list_head d_lru;		/* d_count = 0 LRU list */ \
+	struct list_head d_child;	/* child of parent list */ \
+	struct list_head d_subdirs;	/* our children */ \
+	struct list_head d_alias;	/* inode alias list */ \
+	int d_mounted; \
+	struct qstr d_name; \
+	unsigned long d_time;		/* used by d_revalidate */ \
+	struct dentry_operations  *d_op; \
+	struct super_block * d_sb;	/* The root of the dentry tree */ \
+	unsigned long d_vfs_flags; \
+	void * d_fsdata;		/* fs-specific data */
+
+struct dentry_nameless {
+	DENTRY_MEMBERS
+};
+/* +15 to guarantee a minimal inline len of 16 bytes */
+#define DNAME_INLINE_LEN \
+	(15 + L1_CACHE_BYTES - (15+sizeof(struct dentry_nameless))%L1_CACHE_BYTES)
 
 struct dentry {
-	atomic_t d_count;
-	unsigned int d_flags;
-	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
-	struct dentry * d_parent;	/* parent directory */
-	struct list_head d_hash;	/* lookup hash list */
-	struct list_head d_lru;		/* d_count = 0 LRU list */
-	struct list_head d_child;	/* child of parent list */
-	struct list_head d_subdirs;	/* our children */
-	struct list_head d_alias;	/* inode alias list */
-	int d_mounted;
-	struct qstr d_name;
-	unsigned long d_time;		/* used by d_revalidate */
-	struct dentry_operations  *d_op;
-	struct super_block * d_sb;	/* The root of the dentry tree */
-	unsigned long d_vfs_flags;
-	void * d_fsdata;		/* fs-specific data */
+	DENTRY_MEMBERS
 	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
 };
 

--------------7D1CDA7038AA77A7C6AD60BE--

