Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUEEArQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUEEArQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUEEArQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:47:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:65462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261891AbUEEArO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:47:14 -0400
Date: Tue, 4 May 2004 17:47:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: manfred@colorfullife.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix queues_count accounting in mqueue_delete_inode()
Message-ID: <20040504174713.E21045@build.pdx.osdl.net>
References: <20040504174214.D21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040504174214.D21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 04, 2004 at 05:42:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During mqueue_get_inode(), it's possible that kmalloc() of the
info->messages array will fail.  This failure mode will cause the
queues_count to be (incorrectly) decremented twice.  This patch uses
info->messages on mqueue_delete_inode() to determine whether the
mqueue was every truly created, and hence proper accounting is needed
on destruction.

--- ./ipc/mqueue.c~fix_queues_count	2004-05-04 15:10:59.000000000 -0700
+++ ./ipc/mqueue.c	2004-05-04 15:16:34.000000000 -0700
@@ -215,9 +215,11 @@ static void mqueue_delete_inode(struct i
 
 	clear_inode(inode);
 
-	spin_lock(&mq_lock);
-	queues_count--;
-	spin_unlock(&mq_lock);
+	if (info->messages) {
+		spin_lock(&mq_lock);
+		queues_count--;
+		spin_unlock(&mq_lock);
+	}
 }
 
 static int mqueue_create(struct inode *dir, struct dentry *dentry,
