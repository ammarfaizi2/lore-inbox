Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVI3Lay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVI3Lay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVI3Lay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 07:30:54 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:64553 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751283AbVI3Lay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 07:30:54 -0400
Message-ID: <433D2361.6000805@sw.ru>
Date: Fri, 30 Sep 2005 15:37:05 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, den@sw.ru,
       st@sw.ru
Subject: [PATCH] proc: fix of error path in proc_get_inode()
Content-Type: multipart/mixed;
 boundary="------------010505030307000100050008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010505030307000100050008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes incorrect error path in proc_get_inode(),
when module can't be get due to being unloaded.
When try_module_get() fails, this function puts de(!) and
still returns inode with non-getted de.

There are still unresolved known bugs in proc yet to be fixed:
- proc_dir_entry tree is managed without any serialization
- create_proc_entry() doesn't setup de->owner anyhow,
   so setting it later manually is inatomic.
- looks like almost all modules do not care whether
   it's de->owner is set...

Signed-Off-By: Denis Lunev <den@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>

--------------010505030307000100050008
Content-Type: text/plain;
 name="diff-proc-moduleget-20050930"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-proc-moduleget-20050930"

--- ./fs/proc/inode.c.procino	2005-09-30 13:17:21.000000000 +0400
+++ ./fs/proc/inode.c	2005-09-30 13:17:55.000000000 +0400
@@ -205,10 +205,13 @@ struct inode *proc_get_inode(struct supe
 
 	WARN_ON(de && de->deleted);
 
+	if (de != NULL && !try_module_get(de->owner))
+		goto out_mod;
+
 	inode = iget(sb, ino);
 	if (!inode)
-		goto out_fail;
-	
+		goto out_ino;
+
 	PROC_I(inode)->pde = de;
 	if (de) {
 		if (de->mode) {
@@ -220,20 +223,20 @@ struct inode *proc_get_inode(struct supe
 			inode->i_size = de->size;
 		if (de->nlink)
 			inode->i_nlink = de->nlink;
-		if (!try_module_get(de->owner))
-			goto out_fail;
 		if (de->proc_iops)
 			inode->i_op = de->proc_iops;
 		if (de->proc_fops)
 			inode->i_fop = de->proc_fops;
 	}
 
-out:
 	return inode;
 
-out_fail:
+out_ino:
+	if (de != NULL)
+		module_put(de->owner);
+out_mod:
 	de_put(de);
-	goto out;
+	return NULL;
 }			
 
 int proc_fill_super(struct super_block *s, void *data, int silent)

--------------010505030307000100050008--

