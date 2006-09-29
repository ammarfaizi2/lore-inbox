Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWI2DJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWI2DJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161302AbWI2DJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:09:21 -0400
Received: from mail.suse.de ([195.135.220.2]:47761 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161166AbWI2DJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:09:13 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:09:04 +1000
Message-Id: <1060929030904.24096@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 8] knfsd: nfsd: store export path in export
References: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

Store the export path in the svc_export structure instead of storing only
the dentry.  This will prevent the need for additional d_path calls to
provide NFSv4 fs_locations support.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c            |   10 ++++++++++
 ./include/linux/nfsd/export.h |    1 +
 2 files changed, 11 insertions(+)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-09-29 12:57:30.000000000 +1000
+++ ./fs/nfsd/export.c	2006-09-29 12:57:47.000000000 +1000
@@ -325,6 +325,7 @@ static void svc_export_put(struct kref *
 	dput(exp->ex_dentry);
 	mntput(exp->ex_mnt);
 	auth_domain_put(exp->ex_client);
+	kfree(exp->ex_path);
 	kfree(exp);
 }
 
@@ -398,6 +399,7 @@ static int svc_export_parse(struct cache
 	int an_int;
 
 	nd.dentry = NULL;
+	exp.ex_path = NULL;
 
 	if (mesg[mlen-1] != '\n')
 		return -EINVAL;
@@ -428,6 +430,10 @@ static int svc_export_parse(struct cache
 	exp.ex_client = dom;
 	exp.ex_mnt = nd.mnt;
 	exp.ex_dentry = nd.dentry;
+	exp.ex_path = kstrdup(buf, GFP_KERNEL);
+	err = -ENOMEM;
+	if (!exp.ex_path)
+		goto out;
 
 	/* expiry */
 	err = -EINVAL;
@@ -473,6 +479,7 @@ static int svc_export_parse(struct cache
 	else
 		exp_put(expp);
  out:
+ 	kfree(exp.ex_path);
 	if (nd.dentry)
 		path_release(&nd);
  out_no_path:
@@ -524,6 +531,7 @@ static void svc_export_init(struct cache
 	new->ex_client = item->ex_client;
 	new->ex_dentry = dget(item->ex_dentry);
 	new->ex_mnt = mntget(item->ex_mnt);
+	new->ex_path = NULL;
 }
 
 static void export_update(struct cache_head *cnew, struct cache_head *citem)
@@ -535,6 +543,8 @@ static void export_update(struct cache_h
 	new->ex_anon_uid = item->ex_anon_uid;
 	new->ex_anon_gid = item->ex_anon_gid;
 	new->ex_fsid = item->ex_fsid;
+	new->ex_path = item->ex_path;
+	item->ex_path = NULL;
 }
 
 static struct cache_head *svc_export_alloc(void)

diff .prev/include/linux/nfsd/export.h ./include/linux/nfsd/export.h
--- .prev/include/linux/nfsd/export.h	2006-09-29 12:57:30.000000000 +1000
+++ ./include/linux/nfsd/export.h	2006-09-29 12:57:47.000000000 +1000
@@ -51,6 +51,7 @@ struct svc_export {
 	int			ex_flags;
 	struct vfsmount *	ex_mnt;
 	struct dentry *		ex_dentry;
+	char *			ex_path;
 	uid_t			ex_anon_uid;
 	gid_t			ex_anon_gid;
 	int			ex_fsid;
