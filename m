Return-Path: <linux-kernel-owner+w=401wt.eu-S932739AbWLSJ57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWLSJ57 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWLSJ57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:57:59 -0500
Received: from mx1.suse.de ([195.135.220.2]:50427 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932739AbWLSJ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:57:58 -0500
Date: Tue, 19 Dec 2006 10:57:56 +0100
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Vandana Rungta <vandana@novell.com>
Subject: [PATCH] igrab() should check for I_CLEAR
Message-ID: <20061219095756.GE24584@hasse.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When igrab() is calling __iget() on an inode it should check if clear_inode()
has been called on the inode already. Otherwise there is a race window between
clear_inode() and destroy_inode() where igrab() calls __iget() which leads to
already free inodes on the inode lists.

Signed-off-by: Vandana Rungta <vandana@novell.com>
Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/fs/inode.c
===================================================================
--- linux-2.6.orig/fs/inode.c
+++ linux-2.6/fs/inode.c
@@ -709,7 +709,7 @@ EXPORT_SYMBOL(iunique);
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode_lock);
-	if (!(inode->i_state & (I_FREEING|I_WILL_FREE)))
+	if (!(inode->i_state & (I_FREEING|I_CLEAR|I_WILL_FREE)))
 		__iget(inode);
 	else
 		/*
