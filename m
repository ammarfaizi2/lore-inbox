Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWCVXFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWCVXFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWCVXFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:05:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:47017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751426AbWCVXFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:05:31 -0500
X-Authenticated: #704063
Subject: [Patch] Possible NULL pointer dereference in fs/configfs/dir.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: joel.becker@oracle.com
Content-Type: text/plain
Date: Thu, 23 Mar 2006 00:05:29 +0100
Message-Id: <1143068729.27276.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug #845, if group is NULL,
we dereference it when setting up dentry.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16/fs/configfs/dir.c.orig	2006-03-23 00:02:23.000000000 +0100
+++ linux-2.6.16/fs/configfs/dir.c	2006-03-23 00:03:49.000000000 +0100
@@ -500,7 +500,7 @@ static int create_default_group(struct c
 static int populate_groups(struct config_group *group)
 {
 	struct config_group *new_group;
-	struct dentry *dentry = group->cg_item.ci_dentry;
+	struct dentry *dentry;
 	int ret = 0;
 	int i;
 
@@ -512,6 +512,8 @@ static int populate_groups(struct config
 		 * parent to find us, let alone mess with our tree.
 		 * That said, taking our i_mutex is closer to mkdir
 		 * emulation, and shouldn't hurt. */
+		dentry = group->cg_item.ci_dentry;
+
 		mutex_lock(&dentry->d_inode->i_mutex);
 
 		for (i = 0; group->default_groups[i]; i++) {


