Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWBVO4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWBVO4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWBVO4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:56:00 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:25039 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751044AbWBVOz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:55:59 -0500
Date: Wed, 22 Feb 2006 09:55:57 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] selinuxfs cleanups - sel_make_bools
In-Reply-To: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
Message-ID: <Pine.LNX.4.64.0602220954340.30349@excalibur.intercode>
References: <Pine.LNX.4.64.0602220948530.30349@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the call to sel_make_bools() from sel_fill_super(), as policy needs 
to be loaded before the boolean files can be created.  Policy will never 
be loaded during sel_fill_super() as selinuxfs is kernel mounted during 
init and the only means to load policy is via selinuxfs.

Also, the call to d_genocide() on the error path of sel_make_bools() is 
incorrect and replaced with sel_remove_bools().

Please apply.


Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>


---
 security/selinux/selinuxfs.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff -purN -X dontdiff linux-2.6.16-rc4.p/security/selinux/selinuxfs.c linux-2.6.16-rc4.w/security/selinux/selinuxfs.c
--- linux-2.6.16-rc4.p/security/selinux/selinuxfs.c	2006-02-21 19:56:52.000000000 -0500
+++ linux-2.6.16-rc4.w/security/selinux/selinuxfs.c	2006-02-21 20:33:28.000000000 -0500
@@ -987,7 +987,7 @@ out:
 	return ret;
 err:
 	kfree(values);
-	d_genocide(dir);
+	sel_remove_bools(dir);
 	ret = -ENOMEM;
 	goto out;
 }
@@ -1243,9 +1243,6 @@ static int sel_fill_super(struct super_b
 		goto err;
 
 	bool_dir = dentry;
-	ret = sel_make_bools();
-	if (ret)
-		goto err;
 
 	dentry = d_alloc_name(sb->s_root, NULL_FILE_NAME);
 	if (!dentry) {
