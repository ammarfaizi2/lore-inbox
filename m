Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUHOVui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUHOVui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUHOVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:50:38 -0400
Received: from ozlabs.org ([203.10.76.45]:27077 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266912AbUHOVug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:50:36 -0400
Date: Mon, 16 Aug 2004 07:45:47 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jrsantos@austin.ibm.com
Subject: [PATCH] reduce size of struct dentry on 64bit
Message-ID: <20040815214547.GJ5637@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce size of struct dentry from 248 to 232 bytes on 64bit.

- Reduce size of qstr by 8 bytes, placing int hash and int len together.
  We gain a further 4 byte saving when qstr is used in struct dentry
  since qstr goes from 24 to 16 bytes and the next member (d_lru)
  requires 8 byte alignment (which means 4 bytes of padding).
  
- Move d_mounted to the end, since char d_iname[] only requires 1 byte
  alignment. This reduces struct dentry by another 4 bytes.

With these changes the number of objects we can fit into a 4kB slab
goes from 16 to 17 on ppc64.

Note the above assumes the architecture naturally aligns types.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/linux/dcache.h~optimize_structs include/linux/dcache.h
--- gr_work/include/linux/dcache.h~optimize_structs	2004-08-14 10:51:08.700491559 -0500
+++ gr_work-anton/include/linux/dcache.h	2004-08-14 10:51:08.718488705 -0500
@@ -33,8 +33,8 @@ struct vfsmount;
  */
 struct qstr {
 	unsigned int hash;
-	const unsigned char *name;
 	unsigned int len;
+	const unsigned char *name;
 };
 
 struct dentry_stat_t {
@@ -101,11 +101,11 @@ struct dentry {
 	unsigned long d_time;		/* used by d_revalidate */
 	struct dentry_operations *d_op;
 	struct super_block *d_sb;	/* The root of the dentry tree */
-	int d_mounted;
 	void *d_fsdata;			/* fs-specific data */
  	struct rcu_head d_rcu;
 	struct dcookie_struct *d_cookie; /* cookie, if any */
 	struct hlist_node d_hash;	/* lookup hash list */	
+	int d_mounted;
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
 };
 
