Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVJaWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVJaWfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVJaWfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:35:04 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:59658 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932166AbVJaWet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:34:49 -0500
Subject: [git patch review 3/5] [IB] uverbs: Avoid NULL pointer deref on CQ
	async event
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 31 Oct 2005 22:34:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1130798082548-f241f7f48ee0a31b@cisco.com>
In-Reply-To: <1130798082548-c351d7732f360685@cisco.com>
X-OriginalArrivalTime: 31 Oct 2005 22:34:43.0729 (UTC) FILETIME=[4A2D8010:01C5DE6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace CQs that have no completion event channel attached end up
with their cq_context set to NULL.  However, asynchronous events like
"CQ overrun" can still occur on such CQs, so add a uverbs_file member
to struct ib_ucq_object that we can follow to deliver these events.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs.h      |    1 +
 drivers/infiniband/core/uverbs_cmd.c  |    1 +
 drivers/infiniband/core/uverbs_main.c |    9 +++------
 3 files changed, 5 insertions(+), 6 deletions(-)

applies-to: e7fbd856e7522b65d309e9dfd425541d8f45a0bd
7162a3e0db34e914a8bc5bf74bbae0b386310cf8
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 031cdf3..ecb8301 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -113,6 +113,7 @@ struct ib_uevent_object {
 
 struct ib_ucq_object {
 	struct ib_uobject	uobject;
+	struct ib_uverbs_file  *uverbs_file;
 	struct list_head	comp_list;
 	struct list_head	async_list;
 	u32			comp_events_reported;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 8c89abc..63a7415 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -602,6 +602,7 @@ ssize_t ib_uverbs_create_cq(struct ib_uv
 
 	uobj->uobject.user_handle   = cmd.user_handle;
 	uobj->uobject.context       = file->ucontext;
+	uobj->uverbs_file	    = file;
 	uobj->comp_events_reported  = 0;
 	uobj->async_events_reported = 0;
 	INIT_LIST_HEAD(&uobj->comp_list);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 0eb38f4..e58a7b2 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -442,13 +442,10 @@ static void ib_uverbs_async_handler(stru
 
 void ib_uverbs_cq_event_handler(struct ib_event *event, void *context_ptr)
 {
-	struct ib_uverbs_event_file *ev_file = context_ptr;
-	struct ib_ucq_object *uobj;
+	struct ib_ucq_object *uobj = container_of(event->element.cq->uobject,
+						  struct ib_ucq_object, uobject);
 
-	uobj = container_of(event->element.cq->uobject,
-			    struct ib_ucq_object, uobject);
-
-	ib_uverbs_async_handler(ev_file->uverbs_file, uobj->uobject.user_handle,
+	ib_uverbs_async_handler(uobj->uverbs_file, uobj->uobject.user_handle,
 				event->event, &uobj->async_list,
 				&uobj->async_events_reported);
 				
---
0.99.9
