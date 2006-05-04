Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWEDNGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWEDNGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWEDNGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:06:14 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:19031 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751029AbWEDNGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:06:14 -0400
Message-ID: <4459FC41.3070700@voltaire.com>
Date: Thu, 04 May 2006 16:06:09 +0300
From: Or Gerlitz <ogerlitz@voltaire.com>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Sean Hefty <sean.hefty@intel.com>
CC: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 5/6] iser RDMA CM (CMA) and IB verbs
 interaction
References: <ORSMSX401EXUIEAOeIi0000001c@orsmsx401.amr.corp.intel.com> <445606D5.20907@voltaire.com> <4459FB04.3090302@voltaire.com>
In-Reply-To: <4459FB04.3090302@voltaire.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2006 13:06:12.0572 (UTC) FILETIME=[84C3C1C0:01C66F7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or Gerlitz wrote:
> Or Gerlitz wrote:
>> Sean Hefty wrote:
>>>> +static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
>>>> +{
>>>> +    struct iser_conn *ib_conn;
>>>> +
>>>> +    ib_conn = (struct iser_conn *)cma_id->context;
>>>> +    ib_conn->disc_evt_flag = 1;
>>>> +
>>>> +    /* If this event is unsolicited this means that the conn is 
>>>> being */
>>>> +    /* terminated asynchronously from the iSCSI layer's 
>>>> perspective.  */
>>>> +    if (atomic_read(&ib_conn->state) == ISER_CONN_PENDING) {
>>>> +        atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>>>> +        wake_up_interruptible(&ib_conn->wait);
>>>> +    } else {
>>>> +        if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
>>>> +            atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
>>>> +            iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
>>>> +                        ISCSI_ERR_CONN_FAILED);
>>>> +        }
>>>> +        /* Complete the termination process if no posts are pending */
>>>> +        if ((atomic_read(&ib_conn->post_recv_buf_count) == 0) &&
>>>> +            (atomic_read(&ib_conn->post_send_buf_count) == 0)) {
>>>> +            atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>>>> +            wake_up_interruptible(&ib_conn->wait);
>>>> +        }
>>>> +    }
> 
>>> Are there races here between reading ib_conn->state and setting it?  
>>> Could it have changed in between the atomic_read() and atomic_set()?

>> It seems that indeed a race is possible here, i am rethinking now on 
>> the implementation of the ib connection states moves, thanks for 
>> pointing this.

> Following a review and the clarification i have got from you re cma 
> callbacks serialization, i have committed this change which removes 
> unneeded state checks from two flows (disconnect handler and connect error)

This is the actual fix to the possible races you were pointing on, 
thanks for your feedback.

Or.

r6924 | ogerlitz | 2006-05-04 16:03:21 +0300 (Thu, 04 May 2006) | 7 lines

changed iser ib conn state management to be done with an int variable 
keeping the state and a lock. When a related race is possible the lock 
is used to check (comp) or change (comp_exch) the state. When no race 
can happen the state is just examined or changed.

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com

$ diffstat /tmp/6900-6924
  iscsi_iser.c     |   13 +++------
  iscsi_iser.h     |    6 +++-
  iser_initiator.c |    6 ++--
  iser_verbs.c     |   77 
++++++++++++++++++++++++++++++++++++++-----------------
  4 files changed, 67 insertions(+), 35 deletions(-)


Index: iscsi_iser.h
===================================================================
--- iscsi_iser.h	(revision 6900)
+++ iscsi_iser.h	(revision 6924)
@@ -235,7 +235,8 @@ struct iser_device {
  struct iser_conn
  {
  	struct iscsi_iser_conn       *iser_conn; /* iser conn for upcalls  */
-	atomic_t		     state;	    /* rdma connection state   */
+	enum iser_ib_conn_state	     state;	    /* rdma connection state   */
+	spinlock_t		     lock;	    /* used for state changes  */
  	struct iser_device           *device;       /* device context          */
  	struct rdma_cm_id            *cma_id;       /* CMA ID		       */
  	struct ib_qp	             *qp;           /* QP 		       */
@@ -352,4 +353,7 @@ void iser_unreg_mem(struct iser_mem_reg

  int  iser_post_recv(struct iser_desc *rx_desc);
  int  iser_post_send(struct iser_desc *tx_desc);
+
+int iser_conn_state_comp(struct iser_conn *ib_conn,
+			 enum iser_ib_conn_state comp);
  #endif
Index: iser_verbs.c
===================================================================
--- iser_verbs.c	(revision 6900)
+++ iser_verbs.c	(revision 6924)
@@ -287,6 +287,30 @@ static void iser_device_try_release(stru
  	mutex_unlock(&ig.device_list_mutex);
  }

+int iser_conn_state_comp(struct iser_conn *ib_conn,
+			 enum iser_ib_conn_state comp)
+{
+        int ret;
+
+	spin_lock_bh(&ib_conn->lock);
+	ret = (ib_conn->state == comp);
+	spin_unlock_bh(&ib_conn->lock);
+	return ret;
+}
+
+static int iser_conn_state_comp_exch(struct iser_conn *ib_conn,
+				     enum iser_ib_conn_state comp,
+				     enum iser_ib_conn_state exch)
+{
+        int ret;
+
+        spin_lock_bh(&ib_conn->lock);
+        if ((ret = (ib_conn->state == comp)))
+                ib_conn->state = exch;
+        spin_unlock_bh(&ib_conn->lock);
+        return ret;
+}
+
  /**
   * triggers start of the disconnect procedures and wait for them to be 
done
   */
@@ -294,12 +318,17 @@ void iser_conn_terminate(struct iser_con
  {
  	int err = 0;

-	atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
-	err = rdma_disconnect(ib_conn->cma_id);
-	if (err)
-		iser_bug("Failed to disconnect, conn: 0x%p err %d\n",ib_conn,err);
+	if (iser_conn_state_comp_exch(ib_conn, ISER_CONN_UP,
+				      ISER_CONN_TERMINATING)) {
+		err = rdma_disconnect(ib_conn->cma_id);
+		if (err)
+			iser_err("Failed to disconnect, conn: 0x%p err %d\n",
+				 ib_conn,err);
+
+	}
+
  	wait_event_interruptible(ib_conn->wait,
-				 (atomic_read(&ib_conn->state) == ISER_CONN_DOWN));
+				 ib_conn->state == ISER_CONN_DOWN);

  	iser_conn_release(ib_conn);
  }
@@ -309,7 +338,7 @@ static void iser_connect_error(struct rd
  	struct iser_conn *ib_conn;
  	ib_conn = (struct iser_conn *)cma_id->context;

-	atomic_set(&ib_conn->state, ISER_CONN_DOWN);
+	ib_conn->state = ISER_CONN_DOWN;
  	wake_up_interruptible(&ib_conn->wait);
  }

@@ -369,7 +398,7 @@ static void iser_connected_handler(struc
  	struct iser_conn *ib_conn;

  	ib_conn = (struct iser_conn *)cma_id->context;
-	atomic_set(&ib_conn->state, ISER_CONN_UP);
+	ib_conn->state = ISER_CONN_UP;
  	wake_up_interruptible(&ib_conn->wait);
  }

@@ -380,17 +409,17 @@ static void iser_disconnected_handler(st
  	ib_conn = (struct iser_conn *)cma_id->context;
  	ib_conn->disc_evt_flag = 1;

-	/* If this event is unsolicited this means that the conn is being */
-	/* terminated asynchronously from the iSCSI layer's perspective.  */
-	if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
-		atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
+	/* getting here when the state is UP means that the conn is being *
+	 * terminated asynchronously from the iSCSI layer's perspective.  */
+	if (iser_conn_state_comp_exch(ib_conn, ISER_CONN_UP,
+				      ISER_CONN_TERMINATING))
  		iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
  				   ISCSI_ERR_CONN_FAILED);
-	}
+	
  	/* Complete the termination process if no posts are pending */
  	if ((atomic_read(&ib_conn->post_recv_buf_count) == 0) &&
  	    (atomic_read(&ib_conn->post_send_buf_count) == 0)) {
-		atomic_set(&ib_conn->state, ISER_CONN_DOWN);
+		ib_conn->state = ISER_CONN_DOWN;
  		wake_up_interruptible(&ib_conn->wait);
  	}
  }
@@ -444,13 +473,14 @@ int iser_conn_init(struct iser_conn **ib
  		iser_err("can't alloc memory for struct iser_conn\n");
  		return -ENOMEM;
  	}
-	atomic_set(&ib_conn->state, ISER_CONN_INIT);
+	ib_conn->state = ISER_CONN_INIT;
  	init_waitqueue_head(&ib_conn->wait);
  	atomic_set(&ib_conn->post_recv_buf_count, 0);
  	atomic_set(&ib_conn->post_send_buf_count, 0);
  	INIT_WORK(&ib_conn->comperror_work, iser_comp_error_worker,
  		  ib_conn);
  	INIT_LIST_HEAD(&ib_conn->conn_list);
+	spin_lock_init(&ib_conn->lock);

  	*ibconn = ib_conn;
  	return 0;
@@ -477,7 +507,7 @@ int iser_connect(struct iser_conn   *ib_
  	iser_err("connecting to: %d.%d.%d.%d, port 0x%x\n",
  		 NIPQUAD(dst_addr->sin_addr), dst_addr->sin_port);

-	atomic_set(&ib_conn->state, ISER_CONN_PENDING);
+	ib_conn->state = ISER_CONN_PENDING;

  	ib_conn->cma_id = rdma_create_id(iser_cma_handler,
  					     (void *)ib_conn,
@@ -498,9 +528,9 @@ int iser_connect(struct iser_conn   *ib_

  	if (!non_blocking) {
  		wait_event_interruptible(ib_conn->wait,
-			 atomic_read(&ib_conn->state) != ISER_CONN_PENDING);
+					 (ib_conn->state != ISER_CONN_PENDING));

-		if (atomic_read(&ib_conn->state) != ISER_CONN_UP) {
+		if (ib_conn->state != ISER_CONN_UP) {
  			err =  -EIO;
  			goto connect_failure;
  		}
@@ -514,7 +544,7 @@ int iser_connect(struct iser_conn   *ib_
  id_failure:
  	ib_conn->cma_id = NULL;
  addr_failure:
-	atomic_set(&ib_conn->state, ISER_CONN_DOWN);
+	ib_conn->state = ISER_CONN_DOWN;
  connect_failure:
  	iser_conn_release(ib_conn);
  	return err;
@@ -527,7 +557,7 @@ void iser_conn_release(struct iser_conn
  {
  	struct iser_device  *device = ib_conn->device;

-	BUG_ON(atomic_read(&ib_conn->state) != ISER_CONN_DOWN);
+	BUG_ON(ib_conn->state != ISER_CONN_DOWN);

  	mutex_lock(&ig.connlist_mutex);
  	list_del(&ib_conn->conn_list);
@@ -719,16 +749,17 @@ static void iser_comp_error_worker(void
  {
  	struct iser_conn *ib_conn = data;

-	if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
-		atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
+	/* getting here when the state is UP means that the conn is being *
+	 * terminated asynchronously from the iSCSI layer's perspective.  */
+	if (iser_conn_state_comp_exch(ib_conn, ISER_CONN_UP,
+				      ISER_CONN_TERMINATING))
  		iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
  					ISCSI_ERR_CONN_FAILED);
-	}

  	/* complete the termination process if disconnect event was delivered *
  	 * note there are no more non completed posts to the QP               */
  	if (ib_conn->disc_evt_flag) {
-		atomic_set(&ib_conn->state, ISER_CONN_DOWN);
+		ib_conn->state = ISER_CONN_DOWN;
  		wake_up_interruptible(&ib_conn->wait);
  	}
  }
Index: iser_initiator.c
===================================================================
--- iser_initiator.c	(revision 6900)
+++ iser_initiator.c	(revision 6924)
@@ -370,7 +370,7 @@ int iser_send_command(struct iscsi_conn
  	struct iscsi_cmd *hdr =  ctask->hdr;
  	struct scsi_cmnd *sc  =  ctask->sc;

-	if (atomic_read(&iser_conn->ib_conn->state) != ISER_CONN_UP) {
+	if (!iser_conn_state_comp(iser_conn->ib_conn, ISER_CONN_UP)) {
  		iser_err("Failed to send, conn: 0x%p is not up\n", iser_conn->ib_conn);
  		return -EPERM;
  	}
@@ -454,7 +454,7 @@ int iser_send_data_out(struct iscsi_conn
  	unsigned int itt;
  	int err = 0;

-	if (atomic_read(&iser_conn->ib_conn->state) != ISER_CONN_UP) {
+	if (!iser_conn_state_comp(iser_conn->ib_conn, ISER_CONN_UP)) {
  		iser_err("Failed to send, conn: 0x%p is not up\n", iser_conn->ib_conn);
  		return -EPERM;
  	}
@@ -528,7 +528,7 @@ int iser_send_control(struct iscsi_conn
  	struct iser_regd_buf *regd_buf;
  	struct iser_device *device;

-	if (atomic_read(&iser_conn->ib_conn->state) != ISER_CONN_UP) {
+	if (!iser_conn_state_comp(iser_conn->ib_conn, ISER_CONN_UP)) {
  		iser_err("Failed to send, conn: 0x%p is not up\n", iser_conn->ib_conn);
  		return -EPERM;
  	}
Index: iscsi_iser.c
===================================================================
--- iscsi_iser.c	(revision 6900)
+++ iscsi_iser.c	(revision 6924)
@@ -649,13 +649,13 @@ iscsi_iser_ep_poll(__u64 ep_handle, int
  		return -EINVAL;

  	rc = wait_event_interruptible_timeout(ib_conn->wait,
-			     atomic_read(&ib_conn->state) == ISER_CONN_UP,
+			     ib_conn->state == ISER_CONN_UP,
  			     msecs_to_jiffies(timeout_ms));

  	/* if conn establishment failed, return error code to iscsi */
  	if (!rc &&
-	    (atomic_read(&ib_conn->state) == ISER_CONN_TERMINATING ||
-	     atomic_read(&ib_conn->state) == ISER_CONN_DOWN))
+	    (ib_conn->state == ISER_CONN_TERMINATING ||
+	     ib_conn->state == ISER_CONN_DOWN))
  		rc = -1;

  	iser_err("ib conn %p rc = %d\n", ib_conn, rc);
@@ -676,12 +676,9 @@ iscsi_iser_ep_disconnect(__u64 ep_handle
  	if (!ib_conn)
  		return;

-	iser_err("ib conn %p state %d\n",ib_conn, atomic_read(&ib_conn->state));
+	iser_err("ib conn %p state %d\n",ib_conn, ib_conn->state);

-	if (atomic_read(&ib_conn->state) == ISER_CONN_UP)
-		iser_conn_terminate(ib_conn);
-	else
-		iser_conn_release(ib_conn);
+	iser_conn_terminate(ib_conn);
  }

  static struct scsi_host_template iscsi_iser_sht = {







