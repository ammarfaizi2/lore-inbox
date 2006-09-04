Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWIDRDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWIDRDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWIDRDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:03:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6669 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964901AbWIDRDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:03:54 -0400
Date: Mon, 4 Sep 2006 19:03:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [-mm patch] drivers/infiniband/hw/amso1100/: possible cleanups
Message-ID: <20060904170350.GR4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm3:
>...
>  git-infiniband.patch
>...
>  git trees.
>...

This patch contains the following possible cleanups:
- make the following needlessly global functions static:
  - c2_ae.c: to_qp_state_str()
  - c2_cq.c: c2_cq_get()
  - c2_cq.c: c2_cq_put()
  - c2_qp.c: to_ib_state()
  - c2_qp.c: to_ib_state_str()
  - c2_rnic.c: c2_rnic_query()
- #if 0 the following unused global function:
  - c2_mq.c: c2_mq_count()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/infiniband/hw/amso1100/c2.h      |    1 -
 drivers/infiniband/hw/amso1100/c2_ae.c   |    2 +-
 drivers/infiniband/hw/amso1100/c2_cq.c   |    4 ++--
 drivers/infiniband/hw/amso1100/c2_mq.c   |    3 ++-
 drivers/infiniband/hw/amso1100/c2_mq.h   |    1 -
 drivers/infiniband/hw/amso1100/c2_qp.c   |    4 ++--
 drivers/infiniband/hw/amso1100/c2_rnic.c |    3 +--
 7 files changed, 8 insertions(+), 10 deletions(-)

--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_ae.c.old	2006-09-01 21:02:16.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_ae.c	2006-09-01 21:02:23.000000000 +0200
@@ -125,7 +125,7 @@
 	return event_str[event];
 }
 
-const char *to_qp_state_str(int state)
+static const char *to_qp_state_str(int state)
 {
 	switch (state) {
 	case C2_QP_STATE_IDLE:
--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_cq.c.old	2006-09-01 21:02:45.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_cq.c	2006-09-01 21:03:06.000000000 +0200
@@ -41,7 +41,7 @@
 
 #define C2_CQ_MSG_SIZE ((sizeof(struct c2wr_ce) + 32-1) & ~(32-1))
 
-struct c2_cq *c2_cq_get(struct c2_dev *c2dev, int cqn)
+static struct c2_cq *c2_cq_get(struct c2_dev *c2dev, int cqn)
 {
 	struct c2_cq *cq;
 	unsigned long flags;
@@ -57,7 +57,7 @@
 	return cq;
 }
 
-void c2_cq_put(struct c2_cq *cq)
+static void c2_cq_put(struct c2_cq *cq)
 {
 	if (atomic_dec_and_test(&cq->refcount))
 		wake_up(&cq->wait);
--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_mq.h.old	2006-09-01 21:03:23.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_mq.h	2006-09-01 21:03:30.000000000 +0200
@@ -98,7 +98,6 @@
 extern void c2_mq_produce(struct c2_mq *q);
 extern void *c2_mq_consume(struct c2_mq *q);
 extern void c2_mq_free(struct c2_mq *q);
-extern u32 c2_mq_count(struct c2_mq *q);
 extern void c2_mq_req_init(struct c2_mq *q, u32 index, u32 q_size, u32 msg_size,
 		       u8 __iomem *pool_start, u16 __iomem *peer, u32 type);
 extern void c2_mq_rep_init(struct c2_mq *q, u32 index, u32 q_size, u32 msg_size,
--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_mq.c.old	2006-09-01 21:03:37.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_mq.c	2006-09-01 21:03:49.000000000 +0200
@@ -121,7 +121,7 @@
 	}
 }
 
-
+#if 0
 u32 c2_mq_count(struct c2_mq *q)
 {
 	s32 count;
@@ -138,6 +138,7 @@
 
 	return (u32) count;
 }
+#endif  /*  0  */
 
 void c2_mq_req_init(struct c2_mq *q, u32 index, u32 q_size, u32 msg_size,
 		    u8 __iomem *pool_start, u16 __iomem *peer, u32 type)
--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_qp.c.old	2006-09-01 21:04:06.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_qp.c	2006-09-01 21:04:22.000000000 +0200
@@ -75,7 +75,7 @@
 	}
 }
 
-int to_ib_state(enum c2_qp_state c2_state)
+static int to_ib_state(enum c2_qp_state c2_state)
 {
 	switch (c2_state) {
 	case C2_QP_STATE_IDLE:
@@ -95,7 +95,7 @@
 	}
 }
 
-const char *to_ib_state_str(int ib_state)
+static const char *to_ib_state_str(int ib_state)
 {
 	static const char *state_str[] = {
 		"IB_QPS_RESET",
--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2.h.old	2006-09-01 21:04:49.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2.h	2006-09-01 21:04:54.000000000 +0200
@@ -485,7 +485,6 @@
 extern int c2_rnic_init(struct c2_dev *c2dev);
 extern void c2_rnic_term(struct c2_dev *c2dev);
 extern void c2_rnic_interrupt(struct c2_dev *c2dev);
-extern int c2_rnic_query(struct c2_dev *c2dev, struct ib_device_attr *props);
 extern int c2_del_addr(struct c2_dev *c2dev, u32 inaddr, u32 inmask);
 extern int c2_add_addr(struct c2_dev *c2dev, u32 inaddr, u32 inmask);
 
--- linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_rnic.c.old	2006-09-01 21:05:03.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/infiniband/hw/amso1100/c2_rnic.c	2006-09-01 21:05:17.000000000 +0200
@@ -118,8 +118,7 @@
 /*
  * Query the adapter
  */
-int c2_rnic_query(struct c2_dev *c2dev,
-		  struct ib_device_attr *props)
+static int c2_rnic_query(struct c2_dev *c2dev, struct ib_device_attr *props)
 {
 	struct c2_vq_req *vq_req;
 	struct c2wr_rnic_query_req wr;

