Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVHKV2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVHKV2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbVHKV2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:28:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60668 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750986AbVHKV2d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:28:33 -0400
Date: Thu, 11 Aug 2005 16:26:15 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] [LSM - stacker] implement stacker_inode_init_security
Message-ID: <20050811212615.GE28004@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the inode_init_security hook in stacker.

With this patch, stacker passes the test program which Stephen sent out
on July 5.  (Without it it does not)

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 stacker.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 112 insertions(+)

Index: linux-2.6.13-rc5-mm1/security/stacker.c
===================================================================
--- linux-2.6.13-rc5-mm1.orig/security/stacker.c	2005-08-11 18:57:05.000000000 -0500
+++ linux-2.6.13-rc5-mm1/security/stacker.c	2005-08-11 19:08:18.000000000 -0500
@@ -443,6 +443,117 @@ static void stacker_inode_free_security 
 		security_disown_value(h);
 }
 
+/*
+ * this will only be called if *name or *value in inode_init_security
+ * is > 500.  Don't really expect that to ever happen.
+ */
+static int increase_bufsize(char **b1, char **b2, size_t *len)
+{
+	char *newb1;
+	char *newb2;
+	size_t newlen;
+
+	newlen = *len + 500;
+
+	newb1 = kmalloc(newlen, GFP_KERNEL);
+	if (!newb1)
+		return -ENOMEM;
+
+	newb2 = kmalloc(newlen, GFP_KERNEL);
+	if (!newb2) {
+		kfree(newb1);
+		return -ENOMEM;
+	}
+
+	strncpy(newb1, *b1, *len);
+	strncpy(newb2, *b2, *len);
+
+	kfree(*b1);
+	*b1 = newb1;
+	kfree(*b2);
+	*b2 = newb2;
+	*len = newlen;
+
+	return 0;
+}
+
+/*
+ * Called by fs code to query LSMs for initial security xattr values.
+ * Stacker will query all LSMs.  Return values of -EOPNOTSUPP are
+ * ignored.  Other errors will result in returning no value, and returning
+ * the error.  If no LSMs return a real error, and at least one LSM returns
+ * 0, then all values will be concatenated.  The length will be the total
+ * length of all values, and **value will contain the \0-separated list
+ * of values.
+ */
+static int stacker_inode_init_security(struct inode *inode, struct inode *dir,
+				       char **name, void **value,
+				       size_t *len)
+{
+	char *retn; /* hold the return values from LSMs */
+	char *retv; /* hold the return values from LSMs */
+	char *valuep = NULL;
+	size_t retlen;	   /* hold retunred length from LSMs */
+	int ret = -EOPNOTSUPP;
+	size_t maxsize = 500;
+	int curn = 0, tmpn; /* current size of *name */
+	struct module_entry *m;
+	size_t plen = 0;
+
+	if (name)
+		*name = kmalloc(maxsize, GFP_KERNEL);
+	if (value)
+		valuep = kmalloc(maxsize, GFP_KERNEL);
+	rcu_read_lock();
+	stack_for_each_entry(m, &stacked_modules, lsm_list) {
+		if (!m->module_operations.inode_init_security)
+			continue;
+		rcu_read_unlock();
+		ret = m->module_operations.inode_init_security(inode, dir,
+				&retn, (void **)&retv, &retlen);
+		rcu_read_lock();
+		if (ret < 0 && ret != -EOPNOTSUPP)
+			break;
+		tmpn = strlen(retn);
+		while (plen+retlen+1 > maxsize || tmpn+curn > maxsize) {
+			if (increase_bufsize(&retn, &retv, &maxsize)<0) {
+				kfree(retn);
+				kfree(retv);
+				if (name) kfree(*name);
+				kfree(valuep);
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+
+		if (name) {
+			/* name must already be \0-terminated */
+			strcpy(*name+curn, retn);
+			curn += tmpn;
+		}
+
+		if (valuep) {
+			/* value may not be \0-terminated */
+			strncpy(valuep+plen, retv, retlen);
+			plen += retlen;
+			(valuep)[plen] = '\0';
+			plen++;
+		}
+
+		kfree(retn);
+		kfree(retv);
+	}
+out:
+	rcu_read_unlock();
+
+	if (value && len) {
+		*value = valuep;
+		*len = plen;
+	}
+
+	return ret;
+}
+
 static int stacker_inode_create (struct inode *inode, struct dentry *dentry,
 			       int mask)
 {
@@ -1315,6 +1426,7 @@ static struct security_operations stacke
 
 	.inode_alloc_security		= stacker_inode_alloc_security,
 	.inode_free_security		= stacker_inode_free_security,
+	.inode_init_security		= stacker_inode_init_security,
 	.inode_create			= stacker_inode_create,
 	.inode_link			= stacker_inode_link,
 	.inode_unlink			= stacker_inode_unlink,
