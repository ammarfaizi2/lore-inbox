Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTFOHuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTFOHuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:50:54 -0400
Received: from pat.uio.no ([129.240.130.16]:39641 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261985AbTFOHup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:50:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16108.10350.294138.850242@charged.uio.no>
Date: Sun, 15 Jun 2003 01:03:58 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Florin Iucha <florin@iucha.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
In-Reply-To: <Pine.LNX.4.44.0306141849290.20728-100000@home.transmeta.com>
References: <20030615014221.GA25303@iucha.net>
	<Pine.LNX.4.44.0306141849290.20728-100000@home.transmeta.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > Trond, any ideas?

Here's the patch I posted to Bugzilla earlier today. The problem is
that whereas using the dentry->d_hash list for private purposes was
previously harmless, it is not allowed with the RCU lists, because we
depend on the unhashed node continuing to point back to the original
list.

Cheers,
   Trond

diff -u --recursive --new-file linux-2.5.71/net/sunrpc/rpc_pipe.c linux-2.5.71-fix_rpcpipe/net/sunrpc/rpc_pipe.c
--- linux-2.5.71/net/sunrpc/rpc_pipe.c	2003-06-11 19:24:29.000000000 -0700
+++ linux-2.5.71-fix_rpcpipe/net/sunrpc/rpc_pipe.c	2003-06-14 16:58:21.000000000 -0700
@@ -472,30 +472,37 @@
 rpc_depopulate(struct dentry *parent)
 {
 	struct inode *dir = parent->d_inode;
-	HLIST_HEAD(head);
 	struct list_head *pos, *next;
-	struct dentry *dentry;
+	struct dentry *dentry, *dvec[10];
+	int n = 0;
 
 	down(&dir->i_sem);
+repeat:
 	spin_lock(&dcache_lock);
 	list_for_each_safe(pos, next, &parent->d_subdirs) {
 		dentry = list_entry(pos, struct dentry, d_child);
+		spin_lock(&dentry->d_lock);
 		if (!d_unhashed(dentry)) {
 			dget_locked(dentry);
 			__d_drop(dentry);
-			hlist_add_head(&dentry->d_hash, &head);
-		}
+			spin_unlock(&dentry->d_lock);
+			dvec[n++] = dentry;
+			if (n == ARRAY_SIZE(dvec))
+				break;
+		} else
+			spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&dcache_lock);
-	while (!hlist_empty(&head)) {
-		dentry = list_entry(head.first, struct dentry, d_hash);
-		/* Private list, so no dcache_lock needed and use __d_drop */
-		__d_drop(dentry);
-		if (dentry->d_inode) {
-			rpc_inode_setowner(dentry->d_inode, NULL);
-			simple_unlink(dir, dentry);
-		}
-		dput(dentry);
+	if (n) {
+		do {
+			dentry = dvec[--n];
+			if (dentry->d_inode) {
+				rpc_inode_setowner(dentry->d_inode, NULL);
+				simple_unlink(dir, dentry);
+			}
+			dput(dentry);
+		} while (n);
+		goto repeat;
 	}
 	up(&dir->i_sem);
 }
