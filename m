Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751539AbWDYCfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbWDYCfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWDYCfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:35:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:52944 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751539AbWDYCf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:35:29 -0400
From: sekharan@us.ibm.com
To: akpm@osdl.org, torvalds@osdl.org
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu
Date: Mon, 24 Apr 2006 19:35:27 -0700
Message-Id: <20060425023527.7529.9096.sendpatchset@localhost.localdomain>
In-Reply-To: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
References: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
Subject: [PATCH 3/3] Assert notifier_block and notifier_call are not in init section
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

	Feel free to drop this patch if you think it is not needed.

regards,

chandra
--

This patch ASSERTS that the notifier_block data structure and the
notifier_call funtion are not in the init section.

--
Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>

 sys.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2617-rc2/kernel/sys.c
===================================================================
--- linux-2617-rc2.orig/kernel/sys.c	2006-04-24 11:29:30.000000000 -0700
+++ linux-2617-rc2/kernel/sys.c	2006-04-24 11:36:35.000000000 -0700
@@ -97,6 +97,11 @@ int cad_pid = 1;
 
 static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
 
+static inline int addr_in_init_section(void *addr)
+{
+	return ((addr >= (void *)__init_begin) && (addr < (void *)__init_end));
+}
+
 /*
  *	Notifier chain core routines.  The exported routines below
  *	are layered on top of these, with appropriate locking added.
@@ -105,6 +110,8 @@ static BLOCKING_NOTIFIER_HEAD(reboot_not
 static int notifier_chain_register(struct notifier_block **nl,
 		struct notifier_block *n)
 {
+	BUG_ON(addr_in_init_section(n)
+		 || addr_in_init_section(n->notifier_call));
 	while ((*nl) != NULL) {
 		if (n->priority > (*nl)->priority)
 			break;

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
