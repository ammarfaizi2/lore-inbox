Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVKKIqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVKKIqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVKKIqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:46:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932253AbVKKIp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:45:58 -0500
Date: Fri, 11 Nov 2005 00:45:54 -0800
From: Chris Wright <chrisw@osdl.org>
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local denial-of-service with file leases
Message-ID: <20051111084554.GZ7991@shell0.pdx.osdl.net>
References: <43737CBE.2030005@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43737CBE.2030005@argo.co.il>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Avi Kivity (avi@argo.co.il) wrote:
> the following program will oom a the 2.6.14.1 kernel, running as an 
> ordinary user:

I don't have a good mechanism for testing leases, but this should fix
the leak.  Mind testing?

thanks,
-chris
--

When unlocking lease make sure to release fasync_struct.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/fs/locks.c b/fs/locks.c
index a1e8b22..abba0f6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1412,7 +1412,7 @@ int fcntl_setlease(unsigned int fd, stru
 	struct file_lock fl, *flp = &fl;
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
-	int error;
+	int error, on = 1;
 
 	if ((current->fsuid != inode->i_uid) && !capable(CAP_LEASE))
 		return -EACCES;
@@ -1433,7 +1433,10 @@ int fcntl_setlease(unsigned int fd, stru
 	if (error)
 		goto out_unlock;
 
-	error = fasync_helper(fd, filp, 1, &flp->fl_fasync);
+	if (arg == F_UNLCK)
+		on = 0;
+
+	error = fasync_helper(fd, filp, on, &flp->fl_fasync);
 	if (error < 0) {
 		/* remove lease just inserted by __setlease */
 		flp->fl_type = F_UNLCK | F_INPROGRESS;
