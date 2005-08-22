Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVHVVwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVHVVwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVHVVwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:52:30 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:42883 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751257AbVHVVw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:52:29 -0400
Date: Mon, 22 Aug 2005 03:19:14 -0500
From: serue@us.ibm.com
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       linux-security-module@wirex.com, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH -mm 2/3] [LSM] Stacking support for inode_init_security
Message-ID: <20050822081914.GA25390@sergelap.austin.ibm.com>
References: <20050822080401.GA26125@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822080401.GA26125@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, against the 2.6.13-rc6-mm1 stacker, defines the
inode_init_security() hook.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 stacker.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+)

Index: linux-2.6.13-rc6-mm1/security/stacker.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/security/stacker.c	2005-08-19 17:00:39.000000000 -0500
+++ linux-2.6.13-rc6-mm1/security/stacker.c	2005-08-19 17:01:54.000000000 -0500
@@ -443,6 +443,40 @@ static void stacker_inode_free_security 
 		security_disown_value(h);
 }
 
+static int stacker_inode_init_security(struct inode *inode, struct inode *dir,
+				       struct list_head *head)
+{
+	int ret, succ_ret = -EOPNOTSUPP;
+	struct xattr_data *p, *n;
+	struct module_entry *m;
+
+	rcu_read_lock();
+	stack_for_each_entry(m, &stacked_modules, lsm_list) {
+		if (!m->module_operations.inode_init_security)
+			continue;
+		rcu_read_unlock();
+		ret = m->module_operations.inode_init_security(inode,dir,head);
+		rcu_read_lock();
+		if (ret && ret != -EOPNOTSUPP)
+			goto out_free_data;
+		if (ret == 0)
+			succ_ret = 0;
+	}
+	rcu_read_unlock();
+	return succ_ret;
+
+out_free_data:
+	if (!head)
+		return ret;
+	list_for_each_entry_safe(p, n, head, list) {
+		list_del(&p->list);
+		kfree(p->value);
+		kfree(p->name);
+		kfree(p);
+	}
+	return ret;
+}
+
 static int stacker_inode_create (struct inode *inode, struct dentry *dentry,
 			       int mask)
 {
@@ -1315,6 +1349,7 @@ static struct security_operations stacke
 
 	.inode_alloc_security		= stacker_inode_alloc_security,
 	.inode_free_security		= stacker_inode_free_security,
+	.inode_init_security		= stacker_inode_init_security,
 	.inode_create			= stacker_inode_create,
 	.inode_link			= stacker_inode_link,
 	.inode_unlink			= stacker_inode_unlink,
