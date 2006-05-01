Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWEANCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWEANCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWEANCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:02:16 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:11462 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932082AbWEANCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:02:16 -0400
Message-ID: <445606D5.20907@voltaire.com>
Date: Mon, 01 May 2006 16:02:13 +0300
From: Or Gerlitz <ogerlitz@voltaire.com>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Sean Hefty <sean.hefty@intel.com>
CC: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 5/6] iser RDMA CM (CMA) and IB verbsinteraction
References: <ORSMSX401EXUIEAOeIi0000001c@orsmsx401.amr.corp.intel.com>
In-Reply-To: <ORSMSX401EXUIEAOeIi0000001c@orsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2006 13:02:14.0555 (UTC) FILETIME=[77A7FEB0:01C66D1F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hefty wrote:
>> +static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
>> +{
>> +	struct iser_conn *ib_conn;
>> +
>> +	ib_conn = (struct iser_conn *)cma_id->context;
>> +	ib_conn->disc_evt_flag = 1;
>> +
>> +	/* If this event is unsolicited this means that the conn is being */
>> +	/* terminated asynchronously from the iSCSI layer's perspective.  */
>> +	if (atomic_read(&ib_conn->state) == ISER_CONN_PENDING) {
>> +		atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>> +		wake_up_interruptible(&ib_conn->wait);
>> +	} else {
>> +		if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
>> +			atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
>> +			iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
>> +						ISCSI_ERR_CONN_FAILED);
>> +		}
>> +		/* Complete the termination process if no posts are pending */
>> +		if ((atomic_read(&ib_conn->post_recv_buf_count) == 0) &&
>> +		    (atomic_read(&ib_conn->post_send_buf_count) == 0)) {
>> +			atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>> +			wake_up_interruptible(&ib_conn->wait);
>> +		}
>> +	}

> Are there races here between reading ib_conn->state and setting it?  Could it
> have changed in between the atomic_read() and atomic_set()?

It seems that indeed a race is possible here, i am rethinking now on the 
implementation of the ib connection states moves, thanks for pointing this.

>> +	src = (struct sockaddr *)src_addr;
>> +	dst = (struct sockaddr *)dst_addr;
>> +	err = rdma_resolve_addr(ib_conn->cma_id, src, dst, 1000);
>> +	if (err) {
>> +		iser_err("rdma_resolve_addr failed: %d\n", err);
>> +		goto addr_failure;
>> +	}
>> +
>> +	if (!non_blocking) {
>> +		wait_event_interruptible(ib_conn->wait,
>> +			 atomic_read(&ib_conn->state) != ISER_CONN_PENDING);
>> +
>> +		if (atomic_read(&ib_conn->state) != ISER_CONN_UP) {
>> +			err =  -EIO;
>> +			goto connect_failure;
>> +		}
>> +	}
>> +
>> +	mutex_lock(&ig.connlist_mutex);
>> +	list_add(&ib_conn->conn_list, &ig.connlist);
>> +	mutex_unlock(&ig.connlist_mutex);

> Not sure if there's a race here or not, but rdma_resolve_addr() will result in a
> callback from a separate thread.  That callback could occur before the ib_conn
> is added to the ig.connlist.  Do you assume that ib_conn is in the connlist in
> any of the callbacks?

No, i don't assume this in the callbacks. ib_conn is inserted to the 
list in iser_connect and being lookup-ed in ep_poll, conn_bind and 
ep_disconnect where each subset of the latter three functions are 
serialized are iser_connect since they are called by the same user space 
process (iscsid, via iscsi netlink u/k IPC mechanism).

However, in a review i have made to fully answer your question i have 
found a possible double call to iser_conn_release where the fix below 
handles it.

------------------------------------------------------------------------
r6802 | ogerlitz | 2006-05-01 12:27:12 +0300 (Mon, 01 May 2006) | 5 lines

move the ib conn deletion from the global connlist to iser_conn_release,
fix ep_disconnect to call conn_terminate or conn_release but not both.

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>

Index: iser_verbs.c
===================================================================
--- iser_verbs.c	(revision 6761)
+++ iser_verbs.c	(revision 6802)
@@ -301,10 +301,6 @@ void iser_conn_terminate(struct iser_con
  	wait_event_interruptible(ib_conn->wait,
  				 (atomic_read(&ib_conn->state) == ISER_CONN_DOWN));

-	mutex_lock(&ig.connlist_mutex);
-	list_del(&ib_conn->conn_list);
-	mutex_unlock(&ig.connlist_mutex);
-
  	iser_conn_release(ib_conn);
  }

@@ -463,6 +459,7 @@ int iser_conn_init(struct iser_conn **ib
  	atomic_set(&ib_conn->post_send_buf_count, 0);
  	INIT_WORK(&ib_conn->comperror_work, iser_comp_error_worker,
  		  ib_conn);
+	INIT_LIST_HEAD(&ib_conn->conn_list);

  	*ibconn = ib_conn;
  	return 0;
@@ -541,6 +538,10 @@ void iser_conn_release(struct iser_conn

  	BUG_ON(atomic_read(&ib_conn->state) != ISER_CONN_DOWN);

+	mutex_lock(&ig.connlist_mutex);
+	list_del(&ib_conn->conn_list);
+	mutex_unlock(&ig.connlist_mutex);
+
  	iser_free_ib_conn_res(ib_conn);
  	ib_conn->device = NULL;
  	/* on EVENT_ADDR_ERROR there's no device yet for this conn */
Index: iscsi_iser.c
===================================================================
--- iscsi_iser.c	(revision 6761)
+++ iscsi_iser.c	(revision 6802)
@@ -680,8 +680,8 @@ iscsi_iser_ep_disconnect(__u64 ep_handle

  	if (atomic_read(&ib_conn->state) == ISER_CONN_UP)
  		iser_conn_terminate(ib_conn);
-
-	iser_conn_release(ib_conn);
+	else
+		iser_conn_release(ib_conn);
  }

  static struct scsi_host_template iscsi_iser_sht = {




