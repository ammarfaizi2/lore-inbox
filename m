Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWF0T73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWF0T73 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWF0T73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:59:29 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:14522 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161251AbWF0T72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:59:28 -0400
From: David Brownell <david-b@pacbell.net>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] fix static linking of NFS
Date: Tue, 27 Jun 2006 12:59:15 -0700
User-Agent: KMail/1.7.1
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <yq04py7j699.fsf@jaguar.mkp.net> <44A1809F.5030306@sgi.com> <200606271221.31927.david-b@pacbell.net>
In-Reply-To: <200606271221.31927.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_U4YoEBZYqH/rJ4o"
Message-Id: <200606271259.16408.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_U4YoEBZYqH/rJ4o
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 27 June 2006 12:21 pm, David Brownell wrote:
> OK here's a version of my patch that I edited to remove the
> comments Jes objected to ... /* init or exit */ to remind
> about the omitted section annotation.  Having one of those
> would save multiple kbytes throughout the kernel, and I had
> include the comments as reminders for an eventual fix...
> 
> - Dave
> 


Once more, with patch.

--Boundary-00=_U4YoEBZYqH/rJ4o
Content-Type: text/x-diff;
  charset="us-ascii";
  name="nfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nfs.patch"

Builds on ARM report link problems with common configurations like
statically linked NFS (for nfsroot).  The symptom is that __init
section code references __exit section code; that won't work since
the exit sections are discarded (since they can never be called).

The best fix for these particular cases would be an "__init_or_exit"
section annotation.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: at91/fs/nfs/direct.c
===================================================================
--- at91.orig/fs/nfs/direct.c	2006-06-26 14:28:55.000000000 -0700
+++ at91/fs/nfs/direct.c	2006-06-26 14:32:39.000000000 -0700
@@ -909,7 +909,7 @@ int __init nfs_init_directcache(void)
  * nfs_destroy_directcache - destroy the slab cache for nfs_direct_req structures
  *
  */
-void __exit nfs_destroy_directcache(void)
+void nfs_destroy_directcache(void)
 {
 	if (kmem_cache_destroy(nfs_direct_cachep))
 		printk(KERN_INFO "nfs_direct_cache: not all structures were freed\n");
Index: at91/fs/nfs/inode.c
===================================================================
--- at91.orig/fs/nfs/inode.c	2006-06-26 14:28:55.000000000 -0700
+++ at91/fs/nfs/inode.c	2006-06-26 14:32:39.000000000 -0700
@@ -1132,7 +1132,7 @@ static int __init nfs_init_inodecache(vo
 	return 0;
 }
 
-static void __exit nfs_destroy_inodecache(void)
+static void nfs_destroy_inodecache(void)
 {
 	if (kmem_cache_destroy(nfs_inode_cachep))
 		printk(KERN_INFO "nfs_inode_cache: not all structures were freed\n");
Index: at91/fs/nfs/internal.h
===================================================================
--- at91.orig/fs/nfs/internal.h	2006-06-26 14:28:55.000000000 -0700
+++ at91/fs/nfs/internal.h	2006-06-26 14:32:39.000000000 -0700
@@ -31,15 +31,15 @@ extern struct svc_version nfs4_callback_
 
 /* pagelist.c */
 extern int __init nfs_init_nfspagecache(void);
-extern void __exit nfs_destroy_nfspagecache(void);
+extern void nfs_destroy_nfspagecache(void);
 extern int __init nfs_init_readpagecache(void);
-extern void __exit nfs_destroy_readpagecache(void);
+extern void nfs_destroy_readpagecache(void);
 extern int __init nfs_init_writepagecache(void);
-extern void __exit nfs_destroy_writepagecache(void);
+extern void nfs_destroy_writepagecache(void);
 
 #ifdef CONFIG_NFS_DIRECTIO
 extern int __init nfs_init_directcache(void);
-extern void __exit nfs_destroy_directcache(void);
+extern void nfs_destroy_directcache(void);
 #else
 #define nfs_init_directcache() (0)
 #define nfs_destroy_directcache() do {} while(0)
Index: at91/fs/nfs/pagelist.c
===================================================================
--- at91.orig/fs/nfs/pagelist.c	2006-06-26 14:28:55.000000000 -0700
+++ at91/fs/nfs/pagelist.c	2006-06-26 14:32:39.000000000 -0700
@@ -390,7 +390,7 @@ int __init nfs_init_nfspagecache(void)
 	return 0;
 }
 
-void __exit nfs_destroy_nfspagecache(void)
+void nfs_destroy_nfspagecache(void)
 {
 	if (kmem_cache_destroy(nfs_page_cachep))
 		printk(KERN_INFO "nfs_page: not all structures were freed\n");
Index: at91/fs/nfs/read.c
===================================================================
--- at91.orig/fs/nfs/read.c	2006-06-26 14:28:55.000000000 -0700
+++ at91/fs/nfs/read.c	2006-06-26 14:32:39.000000000 -0700
@@ -711,7 +711,7 @@ int __init nfs_init_readpagecache(void)
 	return 0;
 }
 
-void __exit nfs_destroy_readpagecache(void)
+void nfs_destroy_readpagecache(void)
 {
 	mempool_destroy(nfs_rdata_mempool);
 	if (kmem_cache_destroy(nfs_rdata_cachep))
Index: at91/fs/nfs/write.c
===================================================================
--- at91.orig/fs/nfs/write.c	2006-06-26 14:28:55.000000000 -0700
+++ at91/fs/nfs/write.c	2006-06-26 14:32:39.000000000 -0700
@@ -1551,7 +1551,7 @@ int __init nfs_init_writepagecache(void)
 	return 0;
 }
 
-void __exit nfs_destroy_writepagecache(void)
+void nfs_destroy_writepagecache(void)
 {
 	mempool_destroy(nfs_commit_mempool);
 	mempool_destroy(nfs_wdata_mempool);

--Boundary-00=_U4YoEBZYqH/rJ4o--
