Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWFNADG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWFNADG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWFNACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:02:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:4523 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964814AbWFNACD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:02:03 -0400
Subject: [PATCH 05/11] Task watchers:  Allow task watchers to block
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
References: <20060613235122.130021000@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:54:44 -0700
Message-Id: <1150242884.21787.145.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches task_watchers to from atomic to blocking notifier chains,
allowing notifier_calls to sleep.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
--

 drivers/connector/cn_proc.c |    2 +-
 kernel/sys.c                |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.17-rc6-mm2/kernel/sys.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sys.c
+++ linux-2.6.17-rc6-mm2/kernel/sys.c
@@ -434,29 +434,29 @@ int unregister_reboot_notifier(struct no
 }
 
 EXPORT_SYMBOL(unregister_reboot_notifier);
 
 /* task watchers notifier chain */
-static ATOMIC_NOTIFIER_HEAD(task_watchers);
+static BLOCKING_NOTIFIER_HEAD(task_watchers);
 
 int register_task_watcher(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&task_watchers, nb);
+	return blocking_notifier_chain_register(&task_watchers, nb);
 }
 
 EXPORT_SYMBOL_GPL(register_task_watcher);
 
 int unregister_task_watcher(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&task_watchers, nb);
+	return blocking_notifier_chain_unregister(&task_watchers, nb);
 }
 
 EXPORT_SYMBOL_GPL(unregister_task_watcher);
 
 int notify_watchers(unsigned long val, void *v)
 {
-	return atomic_notifier_call_chain(&task_watchers, val, v);
+	return blocking_notifier_call_chain(&task_watchers, val, v);
 }
 

 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
Index: linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/drivers/connector/cn_proc.c
+++ linux-2.6.17-rc6-mm2/drivers/connector/cn_proc.c
@@ -193,11 +193,11 @@ static int cn_proc_watch_task(struct not
 	get_seq(&msg->seq, &ev->cpu);
 	ktime_get_ts(&ev->timestamp); /* get high res monotonic timestamp */
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
 	msg->len = sizeof(*ev);
-	cn_netlink_send(msg, CN_IDX_PROC, GFP_ATOMIC);
+	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
 	/* If cn_netlink_send() fails, drop data */
 	return rc;
 }
 
 static struct notifier_block __read_mostly cn_proc_nb = {

--

