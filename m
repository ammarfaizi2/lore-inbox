Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVGMQkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVGMQkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbVGMQko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:40:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:46829 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262708AbVGMQkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:40:10 -0400
Date: Wed, 13 Jul 2005 11:39:41 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050713163941.GB2824@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <1121092828.12334.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121092828.12334.94.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> These hooks pose a similar problem for stacking as with the
> [gs]etprocattr hooks, although [gs]etsecurity have the benefit of
> already taking a distinguishing name suffix (the part after the
> security. prefix).  Note also that inode_getsecurity returns the number
> of bytes used/required on success.

The attached patch tries to handle the get,set, and listsecurity hooks.

> The proposed inode_init_security hook will likewise have an issue for
> stacking.

I guess I'll wait to patch that until the hook shows up in 2.6.13-rc?,
since my patches are generally against that tree.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 stacker.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 76 insertions(+), 3 deletions(-)

Index: linux-2.6.13-rc3/security/stacker.c
===================================================================
--- linux-2.6.13-rc3.orig/security/stacker.c	2005-07-13 15:21:01.000000000 -0500
+++ linux-2.6.13-rc3/security/stacker.c	2005-07-13 15:21:05.000000000 -0500
@@ -569,19 +569,92 @@ static int stacker_inode_removexattr (st
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
+ * the newline-separated list of security names defined for this inode.
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
+		buffer[ret++] = '\n';
+	}
+	rcu_read_unlock();
+
+	return ret;
 }
 
 static int stacker_file_permission (struct file *file, int mask)
