Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTFLQgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbTFLQgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:36:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264890AbTFLQgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:36:41 -0400
Date: Thu, 12 Jun 2003 09:49:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: dipankar@in.ibm.com, John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <16104.43445.918001.683257@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0306120947570.2742-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jun 2003, Trond Myklebust wrote:
> 
> I still need a real fix for d_move().

How about something like this.. It still breaks if the _target_ is 
unhashed, but quite frankly, if you have unhashed the target, I think 
something is seriously wrong.

		Linus

---
===== fs/dcache.c 1.57 vs edited =====
--- 1.57/fs/dcache.c	Sat Jun  7 10:17:01 2003
+++ edited/fs/dcache.c	Thu Jun 12 09:42:48 2003
@@ -1221,10 +1221,14 @@
 	}
 
 	/* Move the dentry to the target hash queue, if on different bucket */
+	if (dentry->d_vfs_flags & DCACHE_UNHASHED)
+		goto already_unhashed;
 	if (dentry->d_bucket != target->d_bucket) {
-		dentry->d_bucket = target->d_bucket;
 		hlist_del_rcu(&dentry->d_hash);
+already_unhashed:
+		dentry->d_bucket = target->d_bucket;
 		hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
+		dentry->d_vfs_flags &= ~DCACHE_UNHASHED;
 	}
 
 	/* Unhash the target: dput() will then get rid of it */

