Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270595AbTGNMdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270613AbTGNMby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49796
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270595AbTGNMOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:14:35 -0400
Date: Mon, 14 Jul 2003 13:28:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141228.h6ECSXeP030955@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: add quota autoload
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/fs/dquot.c linux.22-pre5-ac1/fs/dquot.c
--- linux.22-pre5/fs/dquot.c	2003-07-14 12:27:40.000000000 +0100
+++ linux.22-pre5-ac1/fs/dquot.c	2003-07-14 13:01:17.000000000 +0100
@@ -68,11 +68,13 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
+#include <linux/kmod.h>
 
 #include <asm/uaccess.h>
 
 static char *quotatypes[] = INITQFNAMES;
 static struct quota_format_type *quota_formats;	/* List of registered formats */
+static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 
 int register_quota_format(struct quota_format_type *fmt)
 {
@@ -100,8 +102,19 @@
 
 	lock_kernel();
 	for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
-	if (actqf && !try_inc_mod_count(actqf->qf_owner))
-		actqf = NULL;
+	if (!actqf || !try_inc_mod_count(actqf->qf_owner)) {
+		int qm;
+
+		for (qm = 0; module_names[qm].qm_fmt_id && module_names[qm].qm_fmt_id != id; qm++);
+		if (!module_names[qm].qm_fmt_id || request_module(module_names[qm].qm_mod_name)) {
+			actqf = NULL;
+			goto out;
+		}
+		for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
+		if (actqf && !try_inc_mod_count(actqf->qf_owner))
+			actqf = NULL;
+	}
+out:
 	unlock_kernel();
 	return actqf;
 }
