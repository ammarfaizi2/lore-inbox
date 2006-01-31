Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWAaAp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWAaAp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWAaApm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:45:42 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:55337 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965053AbWAaApk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:45:40 -0500
X-IronPort-AV: i="4.01,236,1136188800"; 
   d="scan'208"; a="1771745832:sNHT2153518770"
Subject: [git patch review 3/4] IB/mthca: Don't cancel commands on a signal
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 31 Jan 2006 00:45:32 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1138668332064-ea39a6f0ffa0f630@cisco.com>
In-Reply-To: <1138668332064-f9cb54cbde95165a@cisco.com>
X-OriginalArrivalTime: 31 Jan 2006 00:45:36.0068 (UTC) FILETIME=[A6209840:01C625FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have run into the following problem: if a task receives a signal
while in the process of e.g. destroying a resource (which could be
because the relevant file was closed) mthca could bail out from trying
to take a command interface semaphore without performing the
appropriate command to tell hardware that the resource is being
destroyed.

As a result we see messages like
 ib_mthca 0000:04:00.0: HW2SW_CQ failed (-4)

In this case, hardware could access the resource after the memory has
been freed, possibly causing memory corruption.

A simple solution is to replace down_interruptible() by down() in
command interface activation.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
[ It's also not safe to bail out on multicast table operations, since
  they may be invoked on the cleanup path too.  So use down() for
  mcg_table.sem too. ]
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_cmd.c |    9 +++------
 drivers/infiniband/hw/mthca/mthca_mcg.c |   14 ++++----------
 2 files changed, 7 insertions(+), 16 deletions(-)

e3aa31c517cb6fd0a3d8b23e6a7e71a6aafc2393
diff --git a/drivers/infiniband/hw/mthca/mthca_cmd.c b/drivers/infiniband/hw/mthca/mthca_cmd.c
index be1791b..69128fe 100644
--- a/drivers/infiniband/hw/mthca/mthca_cmd.c
+++ b/drivers/infiniband/hw/mthca/mthca_cmd.c
@@ -199,8 +199,7 @@ static int mthca_cmd_post(struct mthca_d
 {
 	int err = 0;
 
-	if (down_interruptible(&dev->cmd.hcr_sem))
-		return -EINTR;
+	down(&dev->cmd.hcr_sem);
 
 	if (event) {
 		unsigned long end = jiffies + GO_BIT_TIMEOUT;
@@ -255,8 +254,7 @@ static int mthca_cmd_poll(struct mthca_d
 	int err = 0;
 	unsigned long end;
 
-	if (down_interruptible(&dev->cmd.poll_sem))
-		return -EINTR;
+	down(&dev->cmd.poll_sem);
 
 	err = mthca_cmd_post(dev, in_param,
 			     out_param ? *out_param : 0,
@@ -333,8 +331,7 @@ static int mthca_cmd_wait(struct mthca_d
 	int err = 0;
 	struct mthca_cmd_context *context;
 
-	if (down_interruptible(&dev->cmd.event_sem))
-		return -EINTR;
+	down(&dev->cmd.event_sem);
 
 	spin_lock(&dev->cmd.context_lock);
 	BUG_ON(dev->cmd.free_head < 0);
diff --git a/drivers/infiniband/hw/mthca/mthca_mcg.c b/drivers/infiniband/hw/mthca/mthca_mcg.c
index 77bc6c7..55ff5e5 100644
--- a/drivers/infiniband/hw/mthca/mthca_mcg.c
+++ b/drivers/infiniband/hw/mthca/mthca_mcg.c
@@ -154,10 +154,7 @@ int mthca_multicast_attach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	if (down_interruptible(&dev->mcg_table.sem)) {
-		err = -EINTR;
-		goto err_sem;
-	}
+	down(&dev->mcg_table.sem);
 
 	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
@@ -242,7 +239,7 @@ int mthca_multicast_attach(struct ib_qp 
 		mthca_free(&dev->mcg_table.alloc, index);
 	}
 	up(&dev->mcg_table.sem);
- err_sem:
+
 	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
@@ -263,10 +260,7 @@ int mthca_multicast_detach(struct ib_qp 
 		return PTR_ERR(mailbox);
 	mgm = mailbox->buf;
 
-	if (down_interruptible(&dev->mcg_table.sem)) {
-		err = -EINTR;
-		goto err_sem;
-	}
+	down(&dev->mcg_table.sem);
 
 	err = find_mgm(dev, gid->raw, mailbox, &hash, &prev, &index);
 	if (err)
@@ -372,7 +366,7 @@ int mthca_multicast_detach(struct ib_qp 
 
  out:
 	up(&dev->mcg_table.sem);
- err_sem:
+
 	mthca_free_mailbox(dev, mailbox);
 	return err;
 }
-- 
1.1.3
