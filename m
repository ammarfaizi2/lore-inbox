Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVK3CHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVK3CHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVK3CHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:07:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:48847 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750810AbVK3CHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:07:19 -0500
Date: Tue, 29 Nov 2005 18:06:53 -0800
From: Paul Jackson <pj@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrinks dentry struct
Message-Id: <20051129180653.f8d40e9a.pj@sgi.com>
In-Reply-To: <438C7218.8030109@cosmosbay.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	<20051129000916.6306da8b.akpm@osdl.org>
	<438C7218.8030109@cosmosbay.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Would the following accomplish the same thing as your patch, to shrink
UP dentry structs back to 128 bytes, with a smaller and less intrusive
patch?

---

 include/linux/dcache.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

--- 2.6.15-rc2-mm1.orig/include/linux/dcache.h	2005-11-29 17:45:51.977352268 -0800
+++ 2.6.15-rc2-mm1/include/linux/dcache.h	2005-11-29 18:04:59.151307979 -0800
@@ -95,19 +95,24 @@ struct dentry {
 	struct qstr d_name;
 
 	struct list_head d_lru;		/* LRU list */
-	struct list_head d_child;	/* child of parent list */
+	union {				/* Fit 32 bit UP dentry in 128 bytes */
+		struct list_head du_child;	/* child of parent list */
+ 		struct rcu_head du_rcu;
+	} d_du;
 	struct list_head d_subdirs;	/* our children */
 	struct list_head d_alias;	/* inode alias list */
 	unsigned long d_time;		/* used by d_revalidate */
 	struct dentry_operations *d_op;
 	struct super_block *d_sb;	/* The root of the dentry tree */
 	void *d_fsdata;			/* fs-specific data */
- 	struct rcu_head d_rcu;
 	struct dcookie_struct *d_cookie; /* cookie, if any */
 	int d_mounted;
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
 };
 
+#define d_child d_du.du_child
+#define d_rcu d_du.du_rcu
+
 struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, struct nameidata *);
 	int (*d_hash) (struct dentry *, struct qstr *);


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
