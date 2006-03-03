Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752142AbWCCBsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbWCCBsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWCCBsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:32 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:13268 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1752133AbWCCBsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:21 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 10/15] EDAC: edac_mc_add_mc() fix [1/2]
Date: Thu, 2 Mar 2006 17:48:07 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.07381.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 1 of a 2-part patch set.  The code changes are split into
two parts to make the patches more readable.

Move complete_mc_list_del() and del_mc_from_global_list() so we can
call del_mc_from_global_list() from edac_mc_add_mc() without forward
declarations.  Perhaps using forward declarations would be better?
I'm doing things this way because the rest of the code is missing
them.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/edac_mc.c	2006-02-27 17:05:48.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/edac_mc.c	2006-02-27 17:06:17.000000000 -0800
@@ -1405,6 +1405,24 @@ static int add_mc_to_global_list (struct
 }
 
 
+static void complete_mc_list_del (struct rcu_head *head)
+{
+	struct mem_ctl_info *mci;
+
+	mci = container_of(head, struct mem_ctl_info, rcu);
+	INIT_LIST_HEAD(&mci->link);
+	complete(&mci->complete);
+}
+
+
+static void del_mc_from_global_list (struct mem_ctl_info *mci)
+{
+	list_del_rcu(&mci->link);
+	init_completion(&mci->complete);
+	call_rcu(&mci->rcu, complete_mc_list_del);
+	wait_for_completion(&mci->complete);
+}
+
 
 EXPORT_SYMBOL(edac_mc_add_mc);
 
@@ -1466,24 +1484,6 @@ finish:
 }
 
 
-
-static void complete_mc_list_del (struct rcu_head *head)
-{
-	struct mem_ctl_info *mci;
-
-	mci = container_of(head, struct mem_ctl_info, rcu);
-	INIT_LIST_HEAD(&mci->link);
-	complete(&mci->complete);
-}
-
-static void del_mc_from_global_list (struct mem_ctl_info *mci)
-{
-	list_del_rcu(&mci->link);
-	init_completion(&mci->complete);
-	call_rcu(&mci->rcu, complete_mc_list_del);
-	wait_for_completion(&mci->complete);
-}
-
 EXPORT_SYMBOL(edac_mc_del_mc);
 
 /**
