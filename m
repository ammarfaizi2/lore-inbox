Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWHUEMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWHUEMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 00:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWHUEMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 00:12:52 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:2244 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP id S932599AbWHUEMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 00:12:51 -0400
Date: Mon, 21 Aug 2006 12:12:48 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] autofs4 - pending flag not cleared on mount fail
Message-ID: <Pine.LNX.4.64.0608211202530.24684@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

During testing I've found that the mount pending flag can be left set at 
exit from autofs4_lookup after a failed mount request. This shouldn't be 
allowed to happen and causes incorrect error returns.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian

-- 

--- linux-2.6.18-rc4-mm2/fs/autofs4/root.c.clear-pending	2006-08-20 13:20:23.000000000 +0800
+++ linux-2.6.18-rc4-mm2/fs/autofs4/root.c	2006-08-20 13:21:30.000000000 +0800
@@ -281,9 +281,6 @@ static int try_to_fill_dentry(struct den
 
 		DPRINTK("mount done status=%d", status);
 
-		if (status && dentry->d_inode)
-			return status; /* Try to get the kernel to invalidate this dentry */
-
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
 			spin_lock(&dentry->d_lock);
@@ -540,6 +537,9 @@ static struct dentry *autofs4_lookup(str
 			    return ERR_PTR(-ERESTARTNOINTR);
 			}
 		}
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+		spin_unlock(&dentry->d_lock);
 	}
 
 	/*
