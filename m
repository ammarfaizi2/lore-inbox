Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWDZK5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWDZK5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWDZK5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:57:09 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:14772 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932386AbWDZK5I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:57:08 -0400
Date: Wed, 26 Apr 2006 13:57:04 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Arjan van de Ven <arjan@infradead.org>
cc: "=?ISO-8859-1?Q?J=F6rn?= Engel" <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
In-Reply-To: <1146046118.7016.5.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> 
 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> 
 <1146038324.5956.0.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> 
 <1146040038.7016.0.camel@laptopd505.fenrus.org>  <20060426100559.GC29108@wohnheim.fh-wedel.de>
 <1146046118.7016.5.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 April 2006 10:27:18 +0200, Arjan van de Ven wrote:
> > > what I would like is kfree to become an inline wrapper that does the
> > > null check inline, that way gcc can optimize it out (and it will in 4.1
> > > with the VRP pass) if gcc can prove it's not NULL.

On Wed, 2006-04-26 at 12:05 +0200, Jörn Engel wrote:
> > How well can gcc optimize this case? 

On Wed, 26 Apr 2006, Arjan van de Ven wrote:
> if you deref'd the pointer it'll optimize it away (assuming a new enough
> gcc, like 4.1)

Here are the numbers for allyesconfig on my setup.

				Pekka

gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)

    text    data     bss     dec      hex filename
24910301 6946478 2092332 33949111 20605b7 vmlinux
24934157 6946530 2092332 33973019 206631b vmlinux-inline-kfree


diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3af03b1..1b4b3bb 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -148,7 +148,14 @@ static inline void *kcalloc(size_t n, si
 	return kzalloc(n * size, flags);
 }
 
-extern void kfree(const void *);
+extern void __kfree(const void *);
+
+static inline void kfree(const void *p)
+{
+	if (unlikely(p))
+		__kfree(p);
+}
+
 extern unsigned int ksize(const void *);
 
 #ifdef CONFIG_NUMA
diff --git a/mm/slab.c b/mm/slab.c
index e6ef9bd..1f63787 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3367,7 +3367,7 @@ void kmem_cache_free(struct kmem_cache *
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
- * kfree - free previously allocated memory
+ * __kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
  * If @objp is NULL, no operation is performed.
@@ -3375,13 +3375,11 @@ EXPORT_SYMBOL(kmem_cache_free);
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
  */
-void kfree(const void *objp)
+void __kfree(const void *objp)
 {
 	struct kmem_cache *c;
 	unsigned long flags;
 
-	if (unlikely(!objp))
-		return;
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
@@ -3389,7 +3387,7 @@ void kfree(const void *objp)
 	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(kfree);
+EXPORT_SYMBOL(__kfree);
 
 #ifdef CONFIG_SMP
 /**
