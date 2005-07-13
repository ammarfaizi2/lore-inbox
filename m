Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVGMSas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVGMSas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGMS2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:28:51 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:2727 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261483AbVGMS14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:27:56 -0400
Date: Wed, 13 Jul 2005 13:27:29 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050713182729.GA26392@vino.hallyn.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <1121092828.12334.94.camel@moss-spartans.epoch.ncsc.mil> <20050713163941.GB2824@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713163941.GB2824@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen points out listsecurity results should simply be separated by
the \0 which modules already append.  New patch appended.

Thanks, Stephen.

-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 stacker.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 75 insertions(+), 3 deletions(-)

Index: linux-2.6.13-rc3/security/stacker.c
===================================================================
--- linux-2.6.13-rc3.orig/security/stacker.c	2005-07-13 15:37:29.000000000 -0500
+++ linux-2.6.13-rc3/security/stacker.c	2005-07-13 18:08:03.000000000 -0500
@@ -569,19 +569,91 @@ static int stacker_inode_removexattr (st
 	RETURN_ERROR_IF_ANY_ERROR(inode_removexattr,inode_removexattr(dentry,name));
 }
 
+/*
+ * inode_getsecurity: We loop through all modules until one does not return
+ * -EOPNOTSUPP.
+ * Note that if some LSM returns -EPERM, stacker assumes the LSM knows what
+ * it's doing.  If you don't want to control the name, then return
+ * -EOPNOTSUPP!
+ */
 static int stacker_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
-	RETURN_ERROR_IF_ANY_ERROR(inode_getsecurity,inode_getsecurity(inode,name,buffer,size));
+	struct module_entry *m;
+	int ret = -EOPNOTSUPP;
+
+	rcu_read_lock();
+	stack_for_each_entry(m, &stacked_modules, lsm_list) {
+		if (!m->module_operations.inode_getsecurity)
+			continue;
+		rcu_read_unlock();
+		ret = m->module_operations.inode_getsecurity(inode,name,buffer,size);
+		rcu_read_lock();
+		if (ret != -EOPNOTSUPP)
+			break;
+	}
+	rcu_read_unlock();
+
+	return ret;
 }
 
+/*
+ * inode_setsecurity: We loop through all modules until one does not return
+ * -EOPNOTSUPP.
+ * Note that if some LSM returns -EPERM, stacker assumes the LSM knows what
+ * it's doing.  If you don't want to control the name, then return
+ * -EOPNOTSUPP!
+ */
 static int stacker_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
-	RETURN_ERROR_IF_ANY_ERROR(inode_setsecurity,inode_setsecurity(inode,name,value,size,flags));
+	struct module_entry *m;
+	int ret = -EOPNOTSUPP;
+
+	rcu_read_lock();
+	stack_for_each_entry(m, &stacked_modules, lsm_list) {
+		if (!m->module_operations.inode_setsecurity)
+			continue;
+		rcu_read_unlock();
+		ret = m->module_operations.inode_setsecurity(inode, name,
+						value, size, flags);
+		rcu_read_lock();
+		if (ret != -EOPNOTSUPP)
+			break;
+	}
+	rcu_read_unlock();
+
+	return ret;
 }
 
+/*
+ * inode_listsecurity: We loop through all modules appending to buffer, and return
+ * the \0-separated list of security names defined for this inode.
+ */
 static int stacker_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
-	RETURN_ERROR_IF_ANY_ERROR(inode_listsecurity,inode_listsecurity(inode,buffer, buffer_size));
+	int ret = 0;
+	struct module_entry *m;
+
+	rcu_read_lock();
+	stack_for_each_entry(m, &stacked_modules, lsm_list) {
+		int thislen;
+
+		if (!m->module_operations.inode_listsecurity)
+			continue;
+		rcu_read_unlock();
+		thislen = m->module_operations.inode_listsecurity(inode,
+				buffer+ret, buffer_size-ret);
+		rcu_read_lock();
+		if (thislen < 0)
+			continue;
+		ret += thislen;
+		if (ret >= buffer_size) {
+			ret = -ERANGE;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
 }
 
 static int stacker_file_permission (struct file *file, int mask)
