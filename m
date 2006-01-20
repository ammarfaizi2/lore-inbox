Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWATVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWATVOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWATVOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:14:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15325 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932202AbWATVOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:14:18 -0500
Date: Fri, 20 Jan 2006 21:14:04 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] device-mapper ioctl: reduce PF_MEMALLOC usage
Message-ID: <20060120211404.GD4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce substantially the amount of code using PF_MEMALLOC, as envisaged 
in the original FIXME.

If you're using lvm2, for this patch to work correctly you should
update to lvm2 version 2.02.01 or later and device-mapper version 
1.02.02 or later.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-ioctl.c
+++ linux-2.6.16-rc1/drivers/md/dm-ioctl.c
@@ -1359,16 +1359,11 @@ static int ctl_ioctl(struct inode *inode
 	 * Copy the parameters into kernel space.
 	 */
 	r = copy_params(user, &param);
-	if (r) {
-		current->flags &= ~PF_MEMALLOC;
-		return r;
-	}
 
-	/*
-	 * FIXME: eventually we will remove the PF_MEMALLOC flag
-	 * here.  However the tools still do nasty things like
-	 * 'load' while a device is suspended.
-	 */
+	current->flags &= ~PF_MEMALLOC;
+
+	if (r)
+		return r;
 
 	r = validate_params(cmd, param);
 	if (r)
@@ -1386,7 +1381,6 @@ static int ctl_ioctl(struct inode *inode
 
  out:
 	free_params(param);
-	current->flags &= ~PF_MEMALLOC;
 	return r;
 }
 
