Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWAZDyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWAZDyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWAZDtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:35 -0500
Received: from [202.53.187.9] ([202.53.187.9]:16875 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932227AbWAZDtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:11 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 03/23] [Suspend2] Allow a notifier to remove itself from the notifier list.
Date: Thu, 26 Jan 2006 13:45:33 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034532.3178.62115.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is Christoph Lameter's original patch, posted to LKML some time ago,
but as yet unmerged.

Allow a notifier to remove itself from the notifier list.

If the next pointer is retrieved before notifier_call then the notifier can
remove itself from the chain.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/sys.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index d09cac2..46455fa 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -174,15 +174,18 @@ int __kprobes notifier_call_chain(struct
 {
 	int ret=NOTIFY_DONE;
 	struct notifier_block *nb = *n;
+	struct notifier_block *next;
 
 	while(nb)
 	{
-		ret=nb->notifier_call(nb,val,v);
+		/* Determining next here allows the notifier to unregister itself */
+		next = nb->next;
+		ret = nb->notifier_call(nb,val,v);
 		if(ret&NOTIFY_STOP_MASK)
 		{
 			return ret;
 		}
-		nb=nb->next;
+		nb = next;
 	}
 	return ret;
 }

--
Nigel Cunningham		nigel at suspend2 dot net
