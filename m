Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTFKXUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFKXUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:20:50 -0400
Received: from pat.uio.no ([129.240.130.16]:55032 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264605AbTFKXUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:20:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16103.48257.400430.785367@charged.uio.no>
Date: Wed, 11 Jun 2003 16:34:25 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] First casuality of hlist poisoning in 2.5.70
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

  This patch removes the Oops that occurs when either the source or
the target of a d_move() operation is unhashed. It is currently
triggered by the NFS sillyrename code.

Cheers,
  Trond

--- linux-2.5.70-up/fs/dcache.c.orig	2003-06-07 10:17:01.000000000 -0700
+++ linux-2.5.70-up/fs/dcache.c	2003-06-11 16:11:56.000000000 -0700
@@ -1223,8 +1223,13 @@
 	/* Move the dentry to the target hash queue, if on different bucket */
 	if (dentry->d_bucket != target->d_bucket) {
 		dentry->d_bucket = target->d_bucket;
-		hlist_del_rcu(&dentry->d_hash);
-		hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
+		if (!hlist_unhashed(&dentry->d_hash))
+			hlist_del_rcu(&dentry->d_hash);
+		if (!hlist_unhashed(&target->d_hash)) {
+			hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
+			dentry->d_vfs_flags &= ~DCACHE_UNHASHED;
+		} else
+			dentry->d_vfs_flags |= DCACHE_UNHASHED;
 	}
 
 	/* Unhash the target: dput() will then get rid of it */
