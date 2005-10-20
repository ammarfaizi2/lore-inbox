Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVJTQub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVJTQub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVJTQub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:50:31 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:48010 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932477AbVJTQua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:50:30 -0400
Date: Thu, 20 Oct 2005 12:50:28 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [PATCH] SELinux - handle sel_make_bools() failure in selinuxfs
Message-ID: <Pine.LNX.4.63.0510201245130.3536@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes error handling in sel_make_bools(), where currently we'd 
get a memory leak via security_get_bools() and try to kfree() the wrong 
pointer if called again.

Please apply.

Author: Davi Arnaut <davi.arnaut@gmail.com>
Signed-off-by: James Morris <jmorris@namei.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/selinuxfs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -879,7 +879,7 @@ static ssize_t sel_commit_bools_write(st
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;

-	if (new_value) {
+	if (new_value && bool_pending_values) {
 		security_set_bools(bool_num, bool_pending_values);
 	}

@@ -952,6 +952,7 @@ static int sel_make_bools(void)

 	/* remove any existing files */
 	kfree(bool_pending_values);
+	bool_pending_values = NULL;

 	sel_remove_bools(dir);

@@ -1002,6 +1003,7 @@ out:
 	}
 	return ret;
 err:
+	kfree(values);
 	d_genocide(dir);
 	ret = -ENOMEM;
 	goto out;
