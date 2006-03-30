Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWC3KNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWC3KNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWC3KNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:13:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37036 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751335AbWC3KNB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:13:01 -0500
Date: Thu, 30 Mar 2006 11:12:56 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, bharata@in.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: dcache leak in 2.6.16-git8 II
Message-ID: <20060330101256.GX27946@ftp.linux.org.uk>
References: <200603270750.28174.ak@suse.de> <200603271822.28043.ak@suse.de> <20060327190027.24498e3a.akpm@osdl.org> <200603300026.59131.ak@suse.de> <20060330095048.GW27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330095048.GW27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 10:50:48AM +0100, Al Viro wrote:
> FWIW...  One thing that might be useful here:

Here's what I had in mind:

Allow explictly mark allocated objects as "allocated here", so that they'll
show up that way for all slab debugging purposes.  New helpers:
	slab_charge_here(objp, cachep)
	slab_charge_caller(objp, cachep)
mark object as allocated resp. by place where we have ...charge_here() called
and by the caller of function that calls slab_charge_caller().

It's useful when call chain leading to allocation in given cache always
ends the same way, making normal caller accounting uninformative.  E.g.
allocation of struct socket is always done via sock_alloc() => new_inode() =>
alloc_inode() => sock_alloc_inode() => kmem_cache_alloc().  The last step
has no chance to give any useful information about the caller; adding
slab_charge_caller() in sock_alloc() will give us much more useful picture.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3af03b1..6cc2f96 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -151,6 +151,16 @@ static inline void *kcalloc(size_t n, si
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
+#ifndef CONFIG_DEBUG_SLAB
+#define slab_set_creator(objp, cachep, address)
+#define slab_charge_here(objp, cachep)
+#else
+extern void slab_set_creator(void *objp, struct kmem_cache *cachep, void *address);
+extern void slab_charge_here(void *objp, struct kmem_cache *cachep);
+#endif
+#define slab_charge_caller(objp, cachep) \
+	slab_set_creator((objp), (cachep), __builtin_return_address(0))
+
 #ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
 extern void *kmalloc_node(size_t size, gfp_t flags, int node);
@@ -189,6 +199,10 @@ void kfree(const void *m);
 unsigned int ksize(const void *m);
 unsigned int kmem_cache_size(struct kmem_cache *c);
 
+#define slab_set_creator(objp, cachep, address)
+#define slab_charge_here(objp, cachep)
+#define slab_charge_caller(objp, cachep)
+
 static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
 {
 	return __kzalloc(n * size, flags);
diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..db21301 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3144,6 +3144,23 @@ void *kmem_cache_zalloc(struct kmem_cach
 }
 EXPORT_SYMBOL(kmem_cache_zalloc);
 
+#ifdef CONFIG_DEBUG_SLAB
+void slab_set_creator(void *objp, struct kmem_cache *cachep, void *address)
+{
+	if (cachep->flags & SLAB_STORE_USER)
+		*dbg_userword(cachep, objp) = address;
+}
+
+EXPORT_SYMBOL(slab_set_creator);
+
+void slab_charge_here(void *objp, struct kmem_cache *cachep)
+{
+	slab_set_creator(objp, cachep, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(slab_charge_here);
+
+#endif
+
 /**
  * kmem_ptr_validate - check if an untrusted pointer might
  *	be a slab entry.
diff --git a/net/socket.c b/net/socket.c
index fcd77ea..0c4d61b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -517,6 +517,9 @@ static struct socket *sock_alloc(void)
 	if (!inode)
 		return NULL;
 
+	slab_charge_caller(container_of(inode, struct socket_alloc, vfs_inode),
+			   sock_inode_cachep);
+
 	sock = SOCKET_I(inode);
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
