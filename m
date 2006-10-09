Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWJIHat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWJIHat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWJIHas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:30:48 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:18379 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932287AbWJIHas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:30:48 -0400
Date: Mon, 9 Oct 2006 09:29:20 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Greg KH <greg@kroah.com>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 1/2] sysfs: allow removal of nonexistent sysfs groups.
Message-ID: <20061009072920.GB6936@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com> <20061005081705.GA6920@osiris.boeblingen.de.ibm.com> <4524E983.6010208@garzik.org> <20061005124848.GB6920@osiris.boeblingen.de.ibm.com> <45250161.4060002@garzik.org> <20061005131623.GC6920@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005131623.GC6920@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This patch makes it safe to call sysfs_remove_group() with a name group
that doesn't exist. Needed to make fix cpu hotplug stuff in topology code.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 fs/sysfs/group.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/fs/sysfs/group.c
===================================================================
--- linux-2.6.orig/fs/sysfs/group.c	2006-10-09 09:15:25.000000000 +0200
+++ linux-2.6/fs/sysfs/group.c	2006-10-09 09:25:23.000000000 +0200
@@ -68,9 +68,12 @@
 {
 	struct dentry * dir;
 
-	if (grp->name)
+	if (grp->name) {
+		if (!sysfs_dirent_exist(kobj->dentry->d_fsdata, grp->name))
+			return;
 		dir = lookup_one_len(grp->name, kobj->dentry,
 				strlen(grp->name));
+	}
 	else
 		dir = dget(kobj->dentry);
 
