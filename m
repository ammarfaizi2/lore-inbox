Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752139AbWCOQhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbWCOQhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbWCOQhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:37:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26387 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752139AbWCOQhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:37:33 -0500
Date: Wed, 15 Mar 2006 17:37:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: fs/namespace.c:dup_namespace(): fix a use after free
Message-ID: <20060315163732.GY13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following bug in dup_namespace():

<--  snip  -->

        if (!new_ns->root) {
                up_write(&namespace_sem);
                kfree(new_ns);
                goto out;
        }
...
out:
        return new_ns;

<--  snip  -->


Callers expect a non-NULL result to not be freed.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm1-full/fs/namespace.c.old	2006-03-14 03:22:30.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/fs/namespace.c	2006-03-14 03:23:14.000000000 +0100
@@ -1389,7 +1389,7 @@ struct namespace *dup_namespace(struct t
 
 	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
-		goto out;
+		return NULL;
 
 	atomic_set(&new_ns->count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
@@ -1403,7 +1403,7 @@ struct namespace *dup_namespace(struct t
 	if (!new_ns->root) {
 		up_write(&namespace_sem);
 		kfree(new_ns);
-		goto out;
+		return NULL;
 	}
 	spin_lock(&vfsmount_lock);
 	list_add_tail(&new_ns->list, &new_ns->root->mnt_list);
@@ -1444,7 +1444,6 @@ struct namespace *dup_namespace(struct t
 	if (altrootmnt)
 		mntput(altrootmnt);
 
-out:
 	return new_ns;
 }
 

