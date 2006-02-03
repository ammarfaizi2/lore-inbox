Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945976AbWBCVW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945976AbWBCVW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945977AbWBCVW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:22:28 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:15060 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1945976AbWBCVW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:22:27 -0500
Subject: [patch 1/1] selinux: simplify sel_read_bool
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 03 Feb 2006 16:28:15 -0500
Message-Id: <1139002095.24638.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify sel_read_bool to use the simple_read_from_buffer helper,
like the other selinuxfs functions.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: James Morris <jmorris@namei.org>

---

 security/selinux/selinuxfs.c |   20 +-------------------
 1 files changed, 1 insertion(+), 19 deletions(-)

Index: linux-2.6/security/selinux/selinuxfs.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/selinuxfs.c,v
retrieving revision 1.58
diff -u -p -r1.58 selinuxfs.c
--- linux-2.6/security/selinux/selinuxfs.c	3 Jan 2006 16:37:00 -0000	1.58
+++ linux-2.6/security/selinux/selinuxfs.c	3 Feb 2006 19:49:10 -0000
@@ -709,7 +709,6 @@ static ssize_t sel_read_bool(struct file
 {
 	char *page = NULL;
 	ssize_t length;
-	ssize_t end;
 	ssize_t ret;
 	int cur_enforcing;
 	struct inode *inode;
@@ -740,24 +739,7 @@ static ssize_t sel_read_bool(struct file
 
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
 			  bool_pending_values[inode->i_ino - BOOL_INO_OFFSET]);
-	if (length < 0) {
-		ret = length;
-		goto out;
-	}
-
-	if (*ppos >= length) {
-		ret = 0;
-		goto out;
-	}
-	if (count + *ppos > length)
-		count = length - *ppos;
-	end = count + *ppos;
-	if (copy_to_user(buf, (char *) page + *ppos, count)) {
-		ret = -EFAULT;
-		goto out;
-	}
-	*ppos = end;
-	ret = count;
+	ret = simple_read_from_buffer(buf, count, ppos, page, length);
 out:
 	up(&sel_sem);
 	if (page)

-- 
Stephen Smalley
National Security Agency

