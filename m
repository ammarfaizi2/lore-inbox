Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263655AbUJ3JXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUJ3JXm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 05:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263659AbUJ3JXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 05:23:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:269 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263655AbUJ3JXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 05:23:34 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] reduce stack usage of NFS (was Re: How to safely reduce...)
Date: Sat, 30 Oct 2004 12:23:03 +0300
User-Agent: KMail/1.5.4
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Arjan van de Ven <arjan@infradead.org>,
       Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua> <200410300059.06497.vda@port.imtp.ilyichevsk.odessa.ua> <4183040B.3030201@osdl.org>
In-Reply-To: <4183040B.3030201@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_311gBSojHa9ssAx"
Message-Id: <200410301223.03243.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_311gBSojHa9ssAx
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 30 October 2004 06:01, Randy.Dunlap wrote:
> > This patch reduces stack usage to below 100 bytes for
> > the following functions:
> > 
> >                        stack usage in 2.6.9
> > nfs3_proc_create:             544
> > _nfs4_do_open:                516
> > nfs_readdir:                  412
> > nfs_symlink:                  368
> > _nfs4_open_delegation_recall: 368
> > nfs3_proc_rename:             364
> > _nfs4_open_reclaim:           364
> > nfs_mknod:                    352
> > nfs_mkdir:                    352
> > nfs_proc_create:              344
> > nfs3_proc_link:               328
> > nfs_lookup_revalidate:        312
> > nfs_lookup:                   292
> > 
> > (btw: in function nfs_readdir: local variable 'desc' seem to be
> > easily replaceable with &my_desc, or am I missing something?)
> > 
> > Compile tested only. I can't run test it until next Wednesday :(
> > 
> > Please review, especially for leaks on error paths.
> 
> Hi Denis,
> I checked all of it.  Looks right & it builds.

Thanks!

Small cleanup on top of previous: nfs_readdir():

* kill local variable 'desc'  bacause loc->my_desc
  evaluates to the same lvalue now, we can use it instead
* avoid checking for res<0 when we know that it is true
--
vda

--Boundary-00=_311gBSojHa9ssAx
Content-Type: text/x-diff;
  charset="koi8-r";
  name="nfs269_dir.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nfs269_dir.c.diff"

diff -urpN linux-2.6.9.src/fs/nfs/dir.c.old linux-2.6.9.src/fs/nfs/dir.c >nfs269_dir.c.diff
--- linux-2.6.9.src/fs/nfs/dir.c.old	Sat Oct 30 00:43:59 2004
+++ linux-2.6.9.src/fs/nfs/dir.c	Sat Oct 30 12:17:39 2004
@@ -423,12 +423,11 @@ static int nfs_readdir(struct file *filp
 {
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
-	nfs_readdir_descriptor_t *desc;
 	struct {
+		nfs_readdir_descriptor_t my_desc;
 		struct nfs_entry my_entry;
 		struct nfs_fh	 fh;
 		struct nfs_fattr fattr;
-		nfs_readdir_descriptor_t my_desc;
 	} *loc;
 	long res;
 
@@ -436,8 +435,6 @@ static int nfs_readdir(struct file *filp
 	if (!loc)
 		return -ENOMEM;
 
-	desc = &loc->my_desc;
-
 	lock_kernel();
 
 	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
@@ -453,54 +450,54 @@ static int nfs_readdir(struct file *filp
 	 * read from the last dirent to revalidate f_pos
 	 * itself.
 	 */
-	memset(desc, 0, sizeof(*desc));
 
-	desc->file = filp;
-	desc->target = filp->f_pos;
-	desc->decode = NFS_PROTO(inode)->decode_dirent;
-	desc->plus = NFS_USE_READDIRPLUS(inode);
+	memset(&loc->my_desc, 0, sizeof(loc->my_desc));
+	loc->my_desc.file = filp;
+	loc->my_desc.target = filp->f_pos;
+	loc->my_desc.decode = NFS_PROTO(inode)->decode_dirent;
+	loc->my_desc.plus = NFS_USE_READDIRPLUS(inode);
+	loc->my_desc.entry = &loc->my_entry;
 
 	loc->my_entry.cookie = loc->my_entry.prev_cookie = 0;
 	loc->my_entry.eof = 0;
 	loc->my_entry.fh = &loc->fh;
 	loc->my_entry.fattr = &loc->fattr;
-	desc->entry = &loc->my_entry;
 
-	while(!desc->entry->eof) {
-		res = readdir_search_pagecache(desc);
+	while(!loc->my_desc.entry->eof) {
+		res = readdir_search_pagecache(&loc->my_desc);
 		if (res == -EBADCOOKIE) {
 			/* This means either end of directory */
-			if (desc->entry->cookie != desc->target) {
+			if (loc->my_desc.entry->cookie != loc->my_desc.target) {
 				/* Or that the server has 'lost' a cookie */
-				res = uncached_readdir(desc, dirent, filldir);
+				res = uncached_readdir(&loc->my_desc, dirent, filldir);
 				if (res >= 0)
 					continue;
 			}
 			res = 0;
 			break;
 		}
-		if (res == -ETOOSMALL && desc->plus) {
+		if (res == -ETOOSMALL && loc->my_desc.plus) {
 			NFS_FLAGS(inode) &= ~NFS_INO_ADVISE_RDPLUS;
 			nfs_zap_caches(inode);
-			desc->plus = 0;
-			desc->entry->eof = 0;
+			loc->my_desc.plus = 0;
+			loc->my_desc.entry->eof = 0;
 			continue;
 		}
 		if (res < 0)
 			break;
 
-		res = nfs_do_filldir(desc, dirent, filldir);
+		res = nfs_do_filldir(&loc->my_desc, dirent, filldir);
 		if (res < 0) {
 			res = 0;
 			break;
 		}
 	}
 	unlock_kernel();
-	if (desc->error < 0)
-		res = desc->error;
-	kfree(loc);
-	if (res > 0)
+	if (loc->my_desc.error < 0)
+		res = loc->my_desc.error;
+	else if (res > 0)
 		res = 0;
+	kfree(loc);
 	return res;
 }
 

--Boundary-00=_311gBSojHa9ssAx--

