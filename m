Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVCYWNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVCYWNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVCYWNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:13:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:41911 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261836AbVCYWJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:09:52 -0500
Date: Fri, 25 Mar 2005 23:11:45 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@osdl.org>
Cc: adilger@clusterfs.com, ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kfree() NULL pointer cleanups - no need to check - fs/ext3/
Message-ID: <Pine.LNX.4.62.0503252309020.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() handles NULL pointers fine - checking is redundant.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/ext3/acl.c	2005-03-02 08:37:55.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/ext3/acl.c	2005-03-25 22:41:41.000000000 +0100
@@ -197,8 +197,7 @@ ext3_get_acl(struct inode *inode, int ty
 		acl = NULL;
 	else
 		acl = ERR_PTR(retval);
-	if (value)
-		kfree(value);
+	kfree(value);
 
 	if (!IS_ERR(acl)) {
 		switch(type) {
@@ -267,8 +266,7 @@ ext3_set_acl(handle_t *handle, struct in
 	error = ext3_xattr_set_handle(handle, inode, name_index, "",
 				      value, size, 0);
 
-	if (value)
-		kfree(value);
+	kfree(value);
 	if (!error) {
 		switch(type) {
 			case ACL_TYPE_ACCESS:
--- linux-2.6.12-rc1-mm3-orig/fs/ext3/super.c	2005-03-25 15:28:59.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/ext3/super.c	2005-03-25 22:42:53.000000000 +0100
@@ -395,10 +395,8 @@ static void ext3_put_super (struct super
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
-	for (i = 0; i < MAXQUOTAS; i++) {
-		if (sbi->s_qf_names[i])
-			kfree(sbi->s_qf_names[i]);
-	}
+	for (i = 0; i < MAXQUOTAS; i++)
+		kfree(sbi->s_qf_names[i]);
 #endif
 
 	/* Debugging code just in case the in-memory inode orphan list
@@ -883,10 +881,8 @@ clear_qf_name:
 					"quota turned on.\n");
 				return 0;
 			}
-			if (sbi->s_qf_names[qtype]) {
-				kfree(sbi->s_qf_names[qtype]);
-				sbi->s_qf_names[qtype] = NULL;
-			}
+			kfree(sbi->s_qf_names[qtype]);
+			sbi->s_qf_names[qtype] = NULL;
 			break;
 		case Opt_jqfmt_vfsold:
 			sbi->s_jquota_fmt = QFMT_VFS_OLD;



