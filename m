Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266164AbTGDU0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbTGDU0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:26:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11282 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266164AbTGDU0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:26:05 -0400
Date: Fri, 4 Jul 2003 22:40:33 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module autoloading for quota
Message-ID: <20030704204033.GC17560@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm sending you a patch which implements autoloading of quota modules.
The patch should apply well against all recent kernels. Please apply.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

diff -ruNX ../kerndiffexclude linux-2.5.69-um/fs/dquot.c linux-2.5.69-qmodautoload/fs/dquot.c
--- linux-2.5.69-um/fs/dquot.c	Mon May  5 01:53:35 2003
+++ linux-2.5.69-qmodautoload/fs/dquot.c	Fri Jul  4 21:47:56 2003
@@ -74,6 +74,7 @@
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/security.h>
+#include <linux/kmod.h>
 
 #include <asm/uaccess.h>
 
@@ -96,6 +97,7 @@
 
 static char *quotatypes[] = INITQFNAMES;
 static struct quota_format_type *quota_formats;	/* List of registered formats */
+static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 
 int register_quota_format(struct quota_format_type *fmt)
 {
@@ -123,8 +125,19 @@
 
 	spin_lock(&dq_list_lock);
 	for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
-	if (actqf && !try_module_get(actqf->qf_owner))
-		actqf = NULL;
+	if (!actqf || !try_module_get(actqf->qf_owner)) {
+		int qm;
+
+		for (qm = 0; module_names[qm].qm_fmt_id && module_names[qm].qm_fmt_id != id; qm++);
+		if (!module_names[qm].qm_fmt_id || request_module(module_names[qm].qm_mod_name)) {
+			actqf = NULL;
+			goto out;
+		}
+		for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
+		if (actqf && !try_module_get(actqf->qf_owner))
+			actqf = NULL;
+	}
+out:
 	spin_unlock(&dq_list_lock);
 	return actqf;
 }
diff -ruNX ../kerndiffexclude linux-2.5.69-um/include/linux/quota.h linux-2.5.69-qmodautoload/include/linux/quota.h
--- linux-2.5.69-um/include/linux/quota.h	Mon May  5 01:53:36 2003
+++ linux-2.5.69-qmodautoload/include/linux/quota.h	Fri Jul  4 21:36:26 2003
@@ -306,6 +306,16 @@
 void unregister_quota_format(struct quota_format_type *fmt);
 void init_dquot_operations(struct dquot_operations *fsdqops);
 
+struct quota_module_name {
+	int qm_fmt_id;
+	char *qm_mod_name;
+};
+
+#define INIT_QUOTA_MODULE_NAMES {\
+	{QFMT_VFS_OLD, "quota_v1"},\
+	{QFMT_VFS_V0, "quota_v2"},\
+	{0, NULL}}
+
 #else
 
 # /* nodep */ include <sys/cdefs.h>
