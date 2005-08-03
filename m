Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVHCATl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVHCATl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 20:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVHCATl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 20:19:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:20874 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261931AbVHCATk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 20:19:40 -0400
Subject: Re: [PATCH] sunrpc: cache_register can use wrong module reference
From: Bruce Allan <bwa@us.ibm.com>
Reply-To: bwa@us.ibm.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       linux-nfs <nfs@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050802215100.GA19079@infradead.org>
References: <1123018176.3954.118.camel@w-bwa3.beaverton.ibm.com>
	 <20050802215100.GA19079@infradead.org>
Content-Type: text/plain
Organization: IBM, Corp.
Message-Id: <1123028374.3954.142.camel@w-bwa3.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 02 Aug 2005 17:19:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 14:51, Christoph Hellwig wrote:
> On Tue, Aug 02, 2005 at 02:29:36PM -0700, Bruce Allan wrote:
> > [resending to Neil, Trond and linux-nfs list; initial copy to lkml]
> > 
> > When registering an RPC cache, cache_register() always sets the owner as
> > the sunrpc module.  However, there are RPC caches owned by other modules. 
> > With the incorrect owner setting, the real owning module can be removed
> > potentially with an open reference to the cache from userspace.
> > 
> > For example, if one were to stop the nfs server and unmount the nfsd
> > filesystem, the nfsd module could be removed eventhough rpc.idmapd had
> > references to the idtoname and nametoid caches (i.e.
> > /proc/net/rpc/nfs4.<cachename>/channel is still open).  This resulted in
> > a system panic on one of our machines when attempting to restart the nfs
> > services after reloading the nfsd module.
> > 
> > The following patch fixes this by passing the address of the owning
> > struct module to cache_register().  In addition, printk's were added to
> > functions calling cache_unregister() to dump an error message on
> > failure.
> > 
> > Signed-off-by: Bruce Allan <bwa@us.ibm.com>
> 
> Please put a
> 
> 	struct module	*owner;
> 
> field into struct cache_detail instead, that's how it works for other
> methods tables like that.
Yes, that is more appropriate.  Updated patch below...
> 
> And while we're at it, cache_detail is an awfully generic name for a sunrpc
> data structure.
Agreed, but would prefer to have this addressed in a different patch.

The following patch adds a 'struct module *owner' field in struct
cache_detail.  The owner is further assigned to the struct
proc_dir_entry in cache_register() so that the module cannot be unloaded
while user-space daemons have an open reference on the associated file
under /proc.

Signed-off-by: Bruce Allan <bwa@us.ibm.com>

diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/fs/nfsd/export.c linux-2.6.13-rc5-rpc_cache_register/fs/nfsd/export.c
--- linux-2.6.13-rc5/fs/nfsd/export.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/fs/nfsd/export.c	2005-08-02 16:14:53.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/hash.h>
+#include <linux/module.h>
 
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
@@ -221,6 +222,7 @@ static int expkey_show(struct seq_file *
 }
 	
 struct cache_detail svc_expkey_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= EXPKEY_HASHMAX,
 	.hash_table	= expkey_table,
 	.name		= "nfsd.fh",
@@ -456,6 +458,7 @@ static int svc_export_show(struct seq_fi
 	return 0;
 }
 struct cache_detail svc_export_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= EXPORT_HASHMAX,
 	.hash_table	= export_table,
 	.name		= "nfsd.export",
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/fs/nfsd/nfs4idmap.c linux-2.6.13-rc5-rpc_cache_register/fs/nfsd/nfs4idmap.c
--- linux-2.6.13-rc5/fs/nfsd/nfs4idmap.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/fs/nfsd/nfs4idmap.c	2005-08-02 15:55:59.000000000 -0700
@@ -187,6 +187,7 @@ static int         idtoname_parse(struct
 static struct ent *idtoname_lookup(struct ent *, int);
 
 static struct cache_detail idtoname_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= ENT_HASHMAX,
 	.hash_table	= idtoname_table,
 	.name		= "nfs4.idtoname",
@@ -320,6 +321,7 @@ static struct ent *nametoid_lookup(struc
 static int         nametoid_parse(struct cache_detail *, char *, int);
 
 static struct cache_detail nametoid_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= ENT_HASHMAX,
 	.hash_table	= nametoid_table,
 	.name		= "nfs4.nametoid",
@@ -404,8 +406,10 @@ nfsd_idmap_init(void)
 void
 nfsd_idmap_shutdown(void)
 {
-	cache_unregister(&idtoname_cache);
-	cache_unregister(&nametoid_cache);
+	if (cache_unregister(&idtoname_cache))
+		printk(KERN_ERR "nfsd: failed to unregister idtoname cache\n");
+	if (cache_unregister(&nametoid_cache))
+		printk(KERN_ERR "nfsd: failed to unregister nametoid cache\n");
 }
 
 /*
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/include/linux/sunrpc/cache.h linux-2.6.13-rc5-rpc_cache_register/include/linux/sunrpc/cache.h
--- linux-2.6.13-rc5/include/linux/sunrpc/cache.h	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/include/linux/sunrpc/cache.h	2005-08-02 15:54:39.000000000 -0700
@@ -60,6 +60,7 @@ struct cache_head {
 #define	CACHE_NEW_EXPIRY 120	/* keep new things pending confirmation for 120 seconds */
 
 struct cache_detail {
+	struct module *		owner;
 	int			hash_size;
 	struct cache_head **	hash_table;
 	rwlock_t		hash_lock;
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/net/sunrpc/auth_gss/svcauth_gss.c linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/auth_gss/svcauth_gss.c
--- linux-2.6.13-rc5/net/sunrpc/auth_gss/svcauth_gss.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/auth_gss/svcauth_gss.c	2005-08-02 16:41:16.000000000 -0700
@@ -250,6 +250,7 @@ out:
 }
 
 static struct cache_detail rsi_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= RSI_HASHMAX,
 	.hash_table     = rsi_table,
 	.name           = "auth.rpcsec.init",
@@ -436,6 +437,7 @@ out:
 }
 
 static struct cache_detail rsc_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= RSC_HASHMAX,
 	.hash_table	= rsc_table,
 	.name		= "auth.rpcsec.context",
@@ -1074,7 +1076,9 @@ gss_svc_init(void)
 void
 gss_svc_shutdown(void)
 {
-	cache_unregister(&rsc_cache);
-	cache_unregister(&rsi_cache);
+	if (cache_unregister(&rsc_cache))
+		printk(KERN_ERR "auth_rpcgss: failed to unregister rsc cache\n");
+	if (cache_unregister(&rsi_cache))
+		printk(KERN_ERR "auth_rpcgss: failed to unregister rsi cache\n");
 	svc_auth_unregister(RPC_AUTH_GSS);
 }
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/net/sunrpc/cache.c linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/cache.c
--- linux-2.6.13-rc5/net/sunrpc/cache.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/cache.c	2005-08-02 15:53:45.000000000 -0700
@@ -177,7 +177,7 @@ void cache_register(struct cache_detail 
 	cd->proc_ent = proc_mkdir(cd->name, proc_net_rpc);
 	if (cd->proc_ent) {
 		struct proc_dir_entry *p;
-		cd->proc_ent->owner = THIS_MODULE;
+		cd->proc_ent->owner = cd->owner;
 		cd->channel_ent = cd->content_ent = NULL;
 		
  		p = create_proc_entry("flush", S_IFREG|S_IRUSR|S_IWUSR,
@@ -185,7 +185,7 @@ void cache_register(struct cache_detail 
 		cd->flush_ent =  p;
  		if (p) {
  			p->proc_fops = &cache_flush_operations;
- 			p->owner = THIS_MODULE;
+ 			p->owner = cd->owner;
  			p->data = cd;
  		}
  
@@ -195,7 +195,7 @@ void cache_register(struct cache_detail 
 			cd->channel_ent = p;
 			if (p) {
 				p->proc_fops = &cache_file_operations;
-				p->owner = THIS_MODULE;
+				p->owner = cd->owner;
 				p->data = cd;
 			}
 		}
@@ -205,7 +205,7 @@ void cache_register(struct cache_detail 
 			cd->content_ent = p;
  			if (p) {
  				p->proc_fops = &content_file_operations;
- 				p->owner = THIS_MODULE;
+ 				p->owner = cd->owner;
  				p->data = cd;
  			}
  		}
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/net/sunrpc/sunrpc_syms.c linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/sunrpc_syms.c
--- linux-2.6.13-rc5/net/sunrpc/sunrpc_syms.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/sunrpc_syms.c	2005-08-02 15:54:03.000000000 -0700
@@ -176,8 +176,10 @@ cleanup_sunrpc(void)
 {
 	unregister_rpc_pipefs();
 	rpc_destroy_mempool();
-	cache_unregister(&auth_domain_cache);
-	cache_unregister(&ip_map_cache);
+	if (cache_unregister(&auth_domain_cache))
+		printk(KERN_ERR "sunrpc: failed to unregister auth_domain cache\n");
+	if (cache_unregister(&ip_map_cache))
+		printk(KERN_ERR "sunrpc: failed to unregister ip_map cache\n");
 #ifdef RPC_DEBUG
 	rpc_unregister_sysctl();
 #endif
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/net/sunrpc/svcauth.c linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/svcauth.c
--- linux-2.6.13-rc5/net/sunrpc/svcauth.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/svcauth.c	2005-08-02 16:01:01.000000000 -0700
@@ -143,6 +143,7 @@ static void auth_domain_drop(struct cach
 
 
 struct cache_detail auth_domain_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= DN_HASHMAX,
 	.hash_table	= auth_domain_table,
 	.name		= "auth.domain",
diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/net/sunrpc/svcauth_unix.c linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/svcauth_unix.c
--- linux-2.6.13-rc5/net/sunrpc/svcauth_unix.c	2005-08-01 21:45:48.000000000 -0700
+++ linux-2.6.13-rc5-rpc_cache_register/net/sunrpc/svcauth_unix.c	2005-08-02 16:01:34.000000000 -0700
@@ -242,6 +242,7 @@ static int ip_map_show(struct seq_file *
 	
 
 struct cache_detail ip_map_cache = {
+	.owner		= THIS_MODULE,
 	.hash_size	= IP_HASHMAX,
 	.hash_table	= ip_table,
 	.name		= "auth.unix.ip",


