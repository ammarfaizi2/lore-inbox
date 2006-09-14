Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWINKub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWINKub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWINKua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:50:30 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:37348 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751159AbWINKua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:50:30 -0400
Date: Thu, 14 Sep 2006 12:50:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Alignment of fields in struct dentry
Message-ID: <20060914105029.GA1702@wohnheim.fh-wedel.de>
References: <20060914093123.GA10431@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060914093123.GA10431@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 September 2006 11:31:23 +0200, Jörn Engel wrote:
> 
> After taking a look at struct dentry, Arnd noted an alignment
> problem.  The first four fields currently are:
> 	atomic_t d_count;
> 	unsigned int d_flags;		/* protected by d_lock */
> 	spinlock_t d_lock;		/* per dentry lock */
> 	struct inode *d_inode;		/* Where the name belongs to - NULL is
> 					 * negative */
> On 64bit architectures, the first three take 12 bytes and d_inode is
> not naturally aligned, so it can be aligned to byte 16.  This grows a
> struct dentry from 196 to 200 Bytes (assuming no funky config options
> like DEBUG_*, PROFILING or PREEMT && SMP are set).
> 
> One possible solution would be to exchange d_inode with d_mounted, but
> I fear that d_inode would move from a hot cacheline to a cold one,
> reducing performance.  Could there be a good solution or would any
> rearrangement here only cause regressions?
> 
> Also, both 196 and 200 bytes are fairly close to 192 bytes, so I could
> imagine performance improvements on 64bit machines with 64 Byte
> cachelines.  Might it make sense to trim DNAME_INLINE_LEN_MIN by 4 or
> 8 bytes for such machines?

And here is a patch for those who prefer talking code

Jörn

-- 
Joern's library part 8:
http://citeseer.ist.psu.edu/plank97tutorial.html

--- slab/include/linux/dcache.h~dentry_alignment	2006-09-14 10:52:51.000000000 +0200
+++ slab/include/linux/dcache.h	2006-09-14 12:44:56.000000000 +0200
@@ -77,14 +77,17 @@ full_name_hash(const unsigned char *name
 
 struct dcookie_struct;
 
+#if BITS_PER_LONG == 64
+#define DNAME_INLINE_LEN_MIN 32
+#else
 #define DNAME_INLINE_LEN_MIN 36
+#endif
 
 struct dentry {
 	atomic_t d_count;
 	unsigned int d_flags;		/* protected by d_lock */
 	spinlock_t d_lock;		/* per dentry lock */
-	struct inode *d_inode;		/* Where the name belongs to - NULL is
-					 * negative */
+	int d_mounted;
 	/*
 	 * The next three fields are touched by __d_lookup.  Place them here
 	 * so they all fit in a cache line.
@@ -93,6 +96,8 @@ struct dentry {
 	struct dentry *d_parent;	/* parent directory */
 	struct qstr d_name;
 
+	struct inode *d_inode;		/* Where the name belongs to - NULL is
+					 * negative */
 	struct list_head d_lru;		/* LRU list */
 	/*
 	 * d_child and d_rcu can share memory
@@ -110,7 +115,6 @@ struct dentry {
 #ifdef CONFIG_PROFILING
 	struct dcookie_struct *d_cookie; /* cookie, if any */
 #endif
-	int d_mounted;
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
 };
 
