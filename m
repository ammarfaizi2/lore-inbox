Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWHPQnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWHPQnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWHPQnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:43:49 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:10089 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750865AbWHPQns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:43:48 -0400
X-IronPort-AV: i="4.08,133,1154934000"; 
   d="scan'208"; a="336583992:sNHT33457548"
To: openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] IB/uverbs: Fix lockdep warning when QP is created with 2 CQs
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 16 Aug 2006 09:43:46 -0700
Message-ID: <adau04ceim5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Aug 2006 16:43:47.0603 (UTC) FILETIME=[25216630:01C6C153]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan, here's a case that disproves your rule of thumb that rwsems
are equivalent to mutexes as far as correctness goes: you can't have
an AB-BA deadlock with nested rwsems when using down_read().  In other
words, the following:

	down_read(&lock_1);
					down_read(&lock_2);
	down_read(&lock_2);
					down_read(&lock_1);

is perfectly safe, but it cannot be converted to

	mutex_lock(&lock_1);
					mutex_lock(&lock_2);
	mutex_lock(&lock_2);
					mutex_lock(&lock_1);

But this is a pretty small corner case I guess...

---

Lockdep warns when userspace creates a QP that uses different CQs for
send completions and receive completions, because both CQs are locked
and their mutexes belong to the same lock class.  However, we know
that the mutexes are distinct and the nesting is safe (there is no
possibility of AB-BA deadlock because the mutexes are locked with
down_read()), so annotate the situation with SINGLE_DEPTH_NESTING to
get rid of the lockdep warning.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b81307b..8b6df7c 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -155,7 +155,7 @@ static struct ib_uobject *__idr_get_uobj
 }
 
 static struct ib_uobject *idr_read_uobj(struct idr *idr, int id,
-					struct ib_ucontext *context)
+					struct ib_ucontext *context, int nested)
 {
 	struct ib_uobject *uobj;
 
@@ -163,7 +163,10 @@ static struct ib_uobject *idr_read_uobj(
 	if (!uobj)
 		return NULL;
 
-	down_read(&uobj->mutex);
+	if (nested)
+		down_read_nested(&uobj->mutex, SINGLE_DEPTH_NESTING);
+	else
+		down_read(&uobj->mutex);
 	if (!uobj->live) {
 		put_uobj_read(uobj);
 		return NULL;
@@ -190,17 +193,18 @@ static struct ib_uobject *idr_write_uobj
 	return uobj;
 }
 
-static void *idr_read_obj(struct idr *idr, int id, struct ib_ucontext *context)
+static void *idr_read_obj(struct idr *idr, int id, struct ib_ucontext *context,
+			  int nested)
 {
 	struct ib_uobject *uobj;
 
-	uobj = idr_read_uobj(idr, id, context);
+	uobj = idr_read_uobj(idr, id, context, nested);
 	return uobj ? uobj->object : NULL;
 }
 
 static struct ib_pd *idr_read_pd(int pd_handle, struct ib_ucontext *context)
 {
-	return idr_read_obj(&ib_uverbs_pd_idr, pd_handle, context);
+	return idr_read_obj(&ib_uverbs_pd_idr, pd_handle, context, 0);
 }
 
 static void put_pd_read(struct ib_pd *pd)
@@ -208,9 +212,9 @@ static void put_pd_read(struct ib_pd *pd
 	put_uobj_read(pd->uobject);
 }
 
-static struct ib_cq *idr_read_cq(int cq_handle, struct ib_ucontext *context)
+static struct ib_cq *idr_read_cq(int cq_handle, struct ib_ucontext *context, int nested)
 {
-	return idr_read_obj(&ib_uverbs_cq_idr, cq_handle, context);
+	return idr_read_obj(&ib_uverbs_cq_idr, cq_handle, context, nested);
 }
 
 static void put_cq_read(struct ib_cq *cq)
@@ -220,7 +224,7 @@ static void put_cq_read(struct ib_cq *cq
 
 static struct ib_ah *idr_read_ah(int ah_handle, struct ib_ucontext *context)
 {
-	return idr_read_obj(&ib_uverbs_ah_idr, ah_handle, context);
+	return idr_read_obj(&ib_uverbs_ah_idr, ah_handle, context, 0);
 }
 
 static void put_ah_read(struct ib_ah *ah)
@@ -230,7 +234,7 @@ static void put_ah_read(struct ib_ah *ah
 
 static struct ib_qp *idr_read_qp(int qp_handle, struct ib_ucontext *context)
 {
-	return idr_read_obj(&ib_uverbs_qp_idr, qp_handle, context);
+	return idr_read_obj(&ib_uverbs_qp_idr, qp_handle, context, 0);
 }
 
 static void put_qp_read(struct ib_qp *qp)
@@ -240,7 +244,7 @@ static void put_qp_read(struct ib_qp *qp
 
 static struct ib_srq *idr_read_srq(int srq_handle, struct ib_ucontext *context)
 {
-	return idr_read_obj(&ib_uverbs_srq_idr, srq_handle, context);
+	return idr_read_obj(&ib_uverbs_srq_idr, srq_handle, context, 0);
 }
 
 static void put_srq_read(struct ib_srq *srq)
@@ -867,7 +871,7 @@ ssize_t ib_uverbs_resize_cq(struct ib_uv
 		   (unsigned long) cmd.response + sizeof resp,
 		   in_len - sizeof cmd, out_len - sizeof resp);
 
-	cq = idr_read_cq(cmd.cq_handle, file->ucontext);
+	cq = idr_read_cq(cmd.cq_handle, file->ucontext, 0);
 	if (!cq)
 		return -EINVAL;
 
@@ -914,7 +918,7 @@ ssize_t ib_uverbs_poll_cq(struct ib_uver
 		goto out_wc;
 	}
 
-	cq = idr_read_cq(cmd.cq_handle, file->ucontext);
+	cq = idr_read_cq(cmd.cq_handle, file->ucontext, 0);
 	if (!cq) {
 		ret = -EINVAL;
 		goto out;
@@ -962,7 +966,7 @@ ssize_t ib_uverbs_req_notify_cq(struct i
 	if (copy_from_user(&cmd, buf, sizeof cmd))
 		return -EFAULT;
 
-	cq = idr_read_cq(cmd.cq_handle, file->ucontext);
+	cq = idr_read_cq(cmd.cq_handle, file->ucontext, 0);
 	if (!cq)
 		return -EINVAL;
 
@@ -1060,9 +1064,9 @@ ssize_t ib_uverbs_create_qp(struct ib_uv
 
 	srq = cmd.is_srq ? idr_read_srq(cmd.srq_handle, file->ucontext) : NULL;
 	pd  = idr_read_pd(cmd.pd_handle, file->ucontext);
-	scq = idr_read_cq(cmd.send_cq_handle, file->ucontext);
+	scq = idr_read_cq(cmd.send_cq_handle, file->ucontext, 0);
 	rcq = cmd.recv_cq_handle == cmd.send_cq_handle ?
-		scq : idr_read_cq(cmd.recv_cq_handle, file->ucontext);
+		scq : idr_read_cq(cmd.recv_cq_handle, file->ucontext, 1);
 
 	if (!pd || !scq || !rcq || (cmd.is_srq && !srq)) {
 		ret = -EINVAL;
