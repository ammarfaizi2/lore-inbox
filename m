Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUHYNli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUHYNli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 09:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHYNli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 09:41:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:30355 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267423AbUHYNl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 09:41:29 -0400
Date: Wed, 25 Aug 2004 15:41:29 +0200
From: Olaf Kirch <okir@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent memory leak in devpts
Message-ID: <20040825134129.GJ24572@suse.de>
References: <20040825105252.GA24572@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20040825105252.GA24572@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a lame self-followup. Kurt Garloff pointed out that I should
obviously handle the error case more gracefully than by oopsing.
Improved patch attached.

Olaf
-- 
Olaf Kirch     |  The Hardware Gods hate me.
okir@suse.de   |
---------------+ 

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=devpts-dentry-refcount

Index: linux-2.6.5/fs/devpts/inode.c
===================================================================
--- linux-2.6.5.orig/fs/devpts/inode.c
+++ linux-2.6.5/fs/devpts/inode.c
@@ -178,9 +178,13 @@ struct tty_struct *devpts_get_tty(int nu
 {
 	struct dentry *dentry = get_node(number);
 	struct tty_struct *tty;
-
-	tty = (IS_ERR(dentry) || !dentry->d_inode) ? NULL :
-			dentry->d_inode->u.generic_ip;
+	
+	tty = NULL;
+	if (!IS_ERR(dentry)) {
+		if (dentry->d_inode)
+			tty = dentry->d_inode->u.generic_ip;
+		dput(dentry);
+	}
 
 	up(&devpts_root->d_inode->i_sem);
 

--4ZLFUWh1odzi/v6L--
