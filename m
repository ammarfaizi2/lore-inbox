Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbUDWVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUDWVVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUDWVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:21:55 -0400
Received: from firewall.indigita.com ([65.211.227.66]:49630 "EHLO
	control2.indigita.com") by vger.kernel.org with ESMTP
	id S261472AbUDWVVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:21:54 -0400
Date: Fri, 23 Apr 2004 14:21:44 -0700
From: Jim Radford <radford@indigita.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.6-rc2 nfs_fsync() breaks "cvs update"
Message-ID: <20040423212135.GA1780@indigita.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

This patch keeps the positive return values of nfs_commit_inode() from
leaking out to fsync().  Without this "cvs update" to an nfs dir
breaks.

-Jim

--- linux-2.6/fs/nfs/write.c.orig	2004-04-16 16:22:19.000000000 -0700
+++ linux-2.6/fs/nfs/write.c	2004-04-23 14:04:26.000000000 -0700
@@ -357,8 +357,10 @@
 			goto out;
 	}
 	err = nfs_commit_inode(inode, 0, 0, wb_priority(wbc));
-	if (err > 0)
+	if (err > 0) {
 		wbc->nr_to_write -= err;
+		err = 0;
+	}
 out:
 	clear_bit(BDI_write_congested, &bdi->state);
 	wake_up_all(&nfs_write_congestion);

