Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUITRAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUITRAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUITRAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 13:00:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20631 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264954AbUITQ76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:59:58 -0400
Date: Mon, 20 Sep 2004 22:34:39 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 1/3] Fix dcache lookup
Message-ID: <20040920170439.GA5181@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a few things left over from the last changes
Andrew made to dcache lookup. I have tested them on a 2-way system
using normal sanity tests, dcachebench and a very heavy rename
test that we had earlier used for testing RCU-based dcache patches.
These should spend some longish time in -mm.

Thanks
Dipankar



__d_lookup() has leftover stuff from earlier code to protect
it against rename. The smp_rmb() there was needed for the
sequence counter logic.

Original dcache_rcu had :

+               move_count = dentry->d_move_count;
+               smp_rmb();
+
                if (dentry->d_name.hash != hash)
                        continue;
                if (dentry->d_parent != parent)
                        continue;

This was to make sure that comparisons didn't happen before
before the sequence counter was snapshotted. This logic is now
gone and memory barrier is not needed. Removing this should also
improve performance.

The other change is the leftover smp_read_barrier_depends(),
later converted to rcu_dereference(). Originally, the name
comparison was not protected against d_move() and there could
have been a mismatch of allocation size of the name string and  
dentry->d_name.len. This was avoided by making the qstr update
in dentry atomic using a d_qstr pointer. Now, we do ->d_compare()
or memcmp() with the d_lock held and it is safe against d_move().
So, there is no need to rcu_dereference() anything. In fact,
the current code is meaningless.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 fs/dcache.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -puN fs/dcache.c~dcache-fix-lookup fs/dcache.c
--- linux-2.6.9-rc2-dcache/fs/dcache.c~dcache-fix-lookup	2004-09-17 23:35:44.000000000 +0530
+++ linux-2.6.9-rc2-dcache-dipankar/fs/dcache.c	2004-09-17 23:39:29.000000000 +0530
@@ -978,8 +978,6 @@ struct dentry * __d_lookup(struct dentry
 
 		dentry = hlist_entry(node, struct dentry, d_hash);
 
-		smp_rmb();
-
 		if (dentry->d_name.hash != hash)
 			continue;
 		if (dentry->d_parent != parent)
@@ -1002,7 +1000,11 @@ struct dentry * __d_lookup(struct dentry
 		if (dentry->d_parent != parent)
 			goto next;
 
-		qstr = rcu_dereference(&dentry->d_name);
+		/*
+		 * It is safe to compare names since d_move() cannot
+		 * change the qstr (protected by d_lock).
+		 */
+		qstr = &dentry->d_name;
 		if (parent->d_op && parent->d_op->d_compare) {
 			if (parent->d_op->d_compare(parent, qstr, name))
 				goto next;

_
