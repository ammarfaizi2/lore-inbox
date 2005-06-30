Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbVF3Uev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbVF3Uev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVF3UVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:21:09 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13457 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263035AbVF3TtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:49:12 -0400
Date: Thu, 30 Jun 2005 14:55:04 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: [patch 11/12] lsm stacking v0.2: /proc/$$/attr/ sharing
Message-ID: <20050630195504.GK23538@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630194458.GA23439@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables sharing of the /proc/<pid>/attr files.  Input and
output now takes the form of
	"whatever_data_is_expected (module_name)"
For writes, the data section (minus " (module_name)") is sent to the
module identified as "module_name".  For reads, stacker appends the
" (module_name)" to whatever modules send.  If any module returns
an error other than -EINVAL, that error and no data is returned.

If data is written to a procattr file without " (module_name)"
the data is sent to the selinux module.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 stacker.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 100 insertions(+), 25 deletions(-)

Index: linux-2.6.13-rc1/security/stacker.c
===================================================================
--- linux-2.6.13-rc1.orig/security/stacker.c	2005-06-30 15:32:43.000000000 -0500
+++ linux-2.6.13-rc1/security/stacker.c	2005-06-30 15:40:19.000000000 -0500
@@ -966,24 +966,116 @@ static void stacker_d_instantiate (struc
 	CALL_ALL(d_instantiate,d_instantiate(dentry,inode));
 }
 
+/*
+ * Query all LSMs.
+ * If all return EINVAL, we return EINVAL.  If any returns any other
+ * error, then we return that error.  Otherwise, we concatenate all
+ * modules' results.
+ */
 static int
 stacker_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
 {
-	if (!selinux_module)
-		return -EINVAL;
-	if (!selinux_module->module_operations.getprocattr)
+	struct module_entry *m;
+	int len = 0, ret;
+	int found_noneinval = 0;
+
+
+	if (list_empty(&stacked_modules))
 		return -EINVAL;
-	return selinux_module->module_operations.getprocattr(p, name, value, size);
+
+	rcu_read_lock();
+	stack_for_each_entry(m, &stacked_modules, lsm_list) {
+		if (!m->module_operations.getprocattr)
+			continue;
+		rcu_read_unlock();
+		ret = m->module_operations.getprocattr(p, name,
+					value+len, size-len);
+		rcu_read_lock();
+		if (ret == -EINVAL)
+			continue;
+		found_noneinval = 1;
+		if (ret < 0) {
+			memset(value, 0, len);
+			len = ret;
+			break;
+		}
+		if (ret == 0)
+			continue;
+		len += ret;
+		if (len+m->namelen+4 < size) {
+			char *v = value;
+			if (v[len-1]=='\n')
+				len--;
+			len += sprintf(value+len, " (%s)\n", m->module_name);
+		}
+	}
+	rcu_read_unlock();
+
+	return found_noneinval ? len : -EINVAL;
+}
+
+static struct module_entry *
+find_active_lsm(const char *name, int len)
+{
+	struct module_entry *m, *ret = NULL;
+
+	rcu_read_lock();
+	stack_for_each_entry(m, &stacked_modules, lsm_list) {
+		if (m->namelen == len && !strncmp(m->module_name, name, len)) {
+			ret = m;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return ret;
 }
 
-static int stacker_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+/*
+ * We assume input will be either
+ * "data" - in which case it goes to selinux, or
+ * "data (mod_name)" in which case the data goes to module mod_name.
+ */
+static int
+stacker_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
 {
+	struct module_entry *callm = selinux_module;
+	char *realv = (char *)value;
+	size_t dsize = size;
+	int loc = 0, end_data = size;
 
-	if (!selinux_module)
+	if (list_empty(&stacked_modules))
 		return -EINVAL;
-	if (!selinux_module->module_operations.setprocattr)
+
+	if (dsize && realv[dsize-1] == '\n')
+		dsize--;
+
+	if (!dsize || realv[dsize-1]!=')')
+		goto call;
+
+	dsize--;
+	loc = dsize-1;
+	while (loc && realv[loc]!='(')
+		loc--;
+	if (!loc)
+		goto call;
+
+	callm = find_active_lsm(realv+loc+1, dsize-loc-1);
+	if (!callm)
+		goto call;
+
+
+	loc--;
+	while (loc && realv[loc]==' ')
+		loc--;
+
+	end_data = loc+1;
+call:
+	if (!callm || !callm->module_operations.setprocattr)
 		return -EINVAL;
-	return selinux_module->module_operations.setprocattr(p, name, value, size);
+
+	return callm->module_operations.setprocattr(p, name, value, end_data) +
+			(size-end_data);
 }
 
 /*
@@ -1048,23 +1140,6 @@ out:
 	return ret;
 }
 
-static struct module_entry *
-find_active_lsm(const char *name, int len)
-{
-	struct module_entry *m, *ret = NULL;
-
-	rcu_read_lock();
-	stack_for_each_entry(m, &stacked_modules, lsm_list) {
-		if (m->namelen == len && !strncmp(m->module_name, name, len)) {
-			ret = m;
-			break;
-		}
-	}
-
-	rcu_read_unlock();
-	return ret;
-}
-
 /*
  * Currently this version of stacker does not allow for module
  * unregistering.
