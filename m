Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbTFSMzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbTFSMzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:55:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33242 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265490AbTFSMzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:55:32 -0400
Date: Thu, 19 Jun 2003 18:40:13 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [patch 1/3] dentry->d_count fixes
Message-ID: <20030619131013.GJ1204@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030619130943.GI1204@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619130943.GI1204@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- d_invalidate() can incorrectly return success instead of returning -EBUSY
  as we can have situations where lockless d_lookup has found a dentry
  successfully before d_invalidate drops it



 fs/dcache.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN fs/dcache.c~d_invalidate-fix fs/dcache.c
--- linux-2.5.72-mm2/fs/dcache.c~d_invalidate-fix	2003-06-19 17:34:38.000000000 +0530
+++ linux-2.5.72-mm2-maneesh/fs/dcache.c	2003-06-19 17:35:14.000000000 +0530
@@ -232,14 +232,17 @@ int d_invalidate(struct dentry * dentry)
 	 * we might still populate it if it was a
 	 * working directory or similar).
 	 */
+	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count) > 1) {
 		if (dentry->d_inode && S_ISDIR(dentry->d_inode->i_mode)) {
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			return -EBUSY;
 		}
 	}
 
 	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 	return 0;
 }

_
-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
