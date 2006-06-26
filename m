Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933100AbWFZW2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbWFZW2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933101AbWFZW2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:28:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:9161 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S933100AbWFZW2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:28:16 -0400
Message-ID: <44A05F4F.8060503@watson.ibm.com>
Date: Mon, 26 Jun 2006 18:27:27 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Balbir Singh <balbir@in.ibm.com>, Jay Lan <jlan@engr.sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] per-task delay accounting: avoid send without listeners
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't send taskstats (per-pid or per-tgid) on thread exit when no one is
listening for such data.

Currently the taskstats interface allocates a structure, fills it in
and calls netlink to send out per-pid and per-tgid stats regardless of whether
a userspace listener for the data exists (netlink layer would check for that
and avoid the multicast).

As a result of this patch, the check for the no-listener case is performed
early, avoiding the redundant allocation and filling up of the taskstats
structures.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

---

 include/linux/taskstats_kern.h |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-2.6.17/include/linux/taskstats_kern.h
===================================================================
--- linux-2.6.17.orig/include/linux/taskstats_kern.h	2006-06-26 16:45:33.000000000 -0400
+++ linux-2.6.17/include/linux/taskstats_kern.h	2006-06-26 16:47:08.000000000 -0400
@@ -9,6 +9,7 @@

 #include <linux/taskstats.h>
 #include <linux/sched.h>
+#include <net/genetlink.h>

 enum {
 	TASKSTATS_MSG_UNICAST,		/* send data only to requester */
@@ -19,9 +20,19 @@ enum {
 extern kmem_cache_t *taskstats_cache;
 extern struct mutex taskstats_exit_mutex;

+static inline int taskstats_has_listeners(void)
+{
+	if (!genl_sock)
+		return 0;
+	return netlink_has_listeners(genl_sock, TASKSTATS_LISTEN_GROUP);
+}
+
+
 static inline void taskstats_exit_alloc(struct taskstats **ptidstats)
 {
-	*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+	*ptidstats = NULL;
+	if (taskstats_has_listeners())
+		*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
 }

 static inline void taskstats_exit_free(struct taskstats *tidstats)
