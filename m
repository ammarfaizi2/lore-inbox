Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWHPWYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWHPWYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHPWYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:24:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:21207 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932287AbWHPWYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:24:02 -0400
Subject: [PATCH] rcu: Avoid kthread_stop on invalid pointer if rcutorture
	reader startup fails
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Paul McKenney <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 15:24:02 -0700
Message-Id: <1155767042.9175.41.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_torture_init kmallocs the array of reader threads, then creates each one
with kthread_run, cleaning up with rcu_torture_cleanup if this fails.
rcu_torture_cleanup calls kthread_stop on any non-NULL pointer in the array;
however, any readers after the one that failed to start up will have invalid
pointers, not null pointers.  Avoid this by using kzalloc instead.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/rcutorture.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index aff0064..8b09c95 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -779,7 +779,7 @@ rcu_torture_init(void)
 		writer_task = NULL;
 		goto unwind;
 	}
-	reader_tasks = kmalloc(nrealreaders * sizeof(reader_tasks[0]),
+	reader_tasks = kzalloc(nrealreaders * sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
 		VERBOSE_PRINTK_ERRSTRING("out of memory");
-- 
1.4.1.1


