Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWEDNBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWEDNBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWEDNBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:01:03 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:34134 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750974AbWEDNBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:01:01 -0400
Message-ID: <4459FB04.3090302@voltaire.com>
Date: Thu, 04 May 2006 16:00:52 +0300
From: Or Gerlitz <ogerlitz@voltaire.com>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Or Gerlitz <ogerlitz@voltaire.com>
CC: Sean Hefty <sean.hefty@intel.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH 5/6] iser RDMA CM (CMA) and IB verbs
 interaction
References: <ORSMSX401EXUIEAOeIi0000001c@orsmsx401.amr.corp.intel.com> <445606D5.20907@voltaire.com>
In-Reply-To: <445606D5.20907@voltaire.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2006 13:00:59.0723 (UTC) FILETIME=[CA4AC9B0:01C66F7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or Gerlitz wrote:
> Sean Hefty wrote:
>>> +static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
>>> +{
>>> +    struct iser_conn *ib_conn;
>>> +
>>> +    ib_conn = (struct iser_conn *)cma_id->context;
>>> +    ib_conn->disc_evt_flag = 1;
>>> +
>>> +    /* If this event is unsolicited this means that the conn is 
>>> being */
>>> +    /* terminated asynchronously from the iSCSI layer's 
>>> perspective.  */
>>> +    if (atomic_read(&ib_conn->state) == ISER_CONN_PENDING) {
>>> +        atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>>> +        wake_up_interruptible(&ib_conn->wait);
>>> +    } else {
>>> +        if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
>>> +            atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
>>> +            iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
>>> +                        ISCSI_ERR_CONN_FAILED);
>>> +        }
>>> +        /* Complete the termination process if no posts are pending */
>>> +        if ((atomic_read(&ib_conn->post_recv_buf_count) == 0) &&
>>> +            (atomic_read(&ib_conn->post_send_buf_count) == 0)) {
>>> +            atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>>> +            wake_up_interruptible(&ib_conn->wait);
>>> +        }
>>> +    }

>> Are there races here between reading ib_conn->state and setting it?  
>> Could it have changed in between the atomic_read() and atomic_set()?

> It seems that indeed a race is possible here, i am rethinking now on the 
> implementation of the ib connection states moves, thanks for pointing this.

Following a review and the clarification i have got from you re cma 
callbacks serialization, i have committed this change which removes 
unneeded state checks from two flows (disconnect handler and connect error)

Or.

r6900 | ogerlitz | 2006-05-04 11:06:24 +0300 (Thu, 04 May 2006) | 7 lines

two fixes to iser ib conn state management:

+1 when getting DISCONNECTED cma event, iser's state can't be PENDING
+2 when connect_error is called, iser's state is PENDING, no need to 
check it

Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com

Index: iser_verbs.c
===================================================================
--- iser_verbs.c	(revision 6802)
+++ iser_verbs.c	(revision 6900)
@@ -309,12 +309,8 @@ static void iser_connect_error(struct rd
  	struct iser_conn *ib_conn;
  	ib_conn = (struct iser_conn *)cma_id->context;

-	if (atomic_read(&ib_conn->state) == ISER_CONN_PENDING) {
-		atomic_set(&ib_conn->state, ISER_CONN_DOWN);
-		wake_up_interruptible(&ib_conn->wait);
-	} else
-		iser_err("Unexpected evt for conn.state: %d\n",
-			 atomic_read(&ib_conn->state));
+	atomic_set(&ib_conn->state, ISER_CONN_DOWN);
+	wake_up_interruptible(&ib_conn->wait);
  }

  static void iser_addr_handler(struct rdma_cm_id *cma_id)
@@ -386,21 +382,16 @@ static void iser_disconnected_handler(st

  	/* If this event is unsolicited this means that the conn is being */
  	/* terminated asynchronously from the iSCSI layer's perspective.  */
-	if (atomic_read(&ib_conn->state) == ISER_CONN_PENDING) {
+	if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
+		atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
+		iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
+				   ISCSI_ERR_CONN_FAILED);
+	}
+	/* Complete the termination process if no posts are pending */
+	if ((atomic_read(&ib_conn->post_recv_buf_count) == 0) &&
+	    (atomic_read(&ib_conn->post_send_buf_count) == 0)) {
  		atomic_set(&ib_conn->state, ISER_CONN_DOWN);
  		wake_up_interruptible(&ib_conn->wait);
-	} else {
-		if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
-			atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
-			iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
-						ISCSI_ERR_CONN_FAILED);
-		}
-		/* Complete the termination process if no posts are pending */
-		if ((atomic_read(&ib_conn->post_recv_buf_count) == 0) &&
-		    (atomic_read(&ib_conn->post_send_buf_count) == 0)) {
-			atomic_set(&ib_conn->state, ISER_CONN_DOWN);
-			wake_up_interruptible(&ib_conn->wait);
-		}
  	}
  }


