Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWD1XFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWD1XFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWD1XFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:05:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:25244 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932085AbWD1XFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:05:43 -0400
X-IronPort-AV: i="4.04,165,1144047600"; 
   d="scan'208"; a="30083485:sNHT33014464"
From: "Sean Hefty" <sean.hefty@intel.com>
To: "'Or Gerlitz'" <ogerlitz@voltaire.com>, <rdreier@cisco.com>
Cc: <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
Subject: RE: [openib-general] [PATCH 5/6] iser RDMA CM (CMA) and IB verbsinteraction
Date: Fri, 28 Apr 2006 16:05:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZp9sNKDF/hJ355R4yjrO9yYyylAQBHyJLg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <Pine.LNX.4.44.0604271532310.16463-100000@zuben>
Message-ID: <ORSMSX401EXUIEAOeIi0000001c@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 28 Apr 2006 23:05:41.0626 (UTC) FILETIME=[458355A0:01C66B18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>+static int iser_free_device_ib_res(struct iser_device *device)
>+{
>+	BUG_ON(device->mr == NULL);
>+
>+	tasklet_kill(&device->cq_tasklet);
>+
>+	(void)ib_dereg_mr(device->mr);
>+	(void)ib_destroy_cq(device->cq);
>+	(void)ib_dealloc_pd(device->pd);
>+
>+	device->mr = NULL;
>+	device->cq = NULL;
>+	device->pd = NULL;
>+	return 0;
>+}

Can you eliminate the return code?

>+static int iser_free_ib_conn_res(struct iser_conn *ib_conn)
>+{
>+	BUG_ON(ib_conn == NULL);
>+
>+	iser_err("freeing conn %p cma_id %p fmr pool %p qp %p\n",
>+		 ib_conn, ib_conn->cma_id,
>+		 ib_conn->fmr_pool, ib_conn->qp);
>+
>+	/* qp is created only once both addr & route are resolved */
>+	if (ib_conn->fmr_pool != NULL)
>+		ib_destroy_fmr_pool(ib_conn->fmr_pool);
>+
>+	if (ib_conn->qp != NULL)
>+		rdma_destroy_qp(ib_conn->cma_id);
>+
>+	if (ib_conn->cma_id != NULL)
>+		rdma_destroy_id(ib_conn->cma_id);

Are the NULL checks needed above?  Neither iser_create_device_ib_res() or
iser_create_ib_conn_res() set the values to NULL if an error occurred.

>+
>+	ib_conn->fmr_pool = NULL;
>+	ib_conn->qp	  = NULL;
>+	ib_conn->cma_id   = NULL;
>+	kfree(ib_conn->page_vec);
>+
>+	return 0;
>+}
>+
>+/**
>+ * based on the resolved device node GUID see if there already allocated
>+ * device for this device. If there's no such, create one.
>+ */
>+static
>+struct iser_device *iser_device_find_by_ib_device(struct rdma_cm_id *cma_id)
>+{
>+	struct list_head    *p_list;
>+	struct iser_device  *device = NULL;
>+
>+	mutex_lock(&ig.device_list_mutex);
>+
>+	p_list = ig.device_list.next;
>+	while (p_list != &ig.device_list) {
>+		device = list_entry(p_list, struct iser_device, ig_list);
>+		/* find if there's a match using the node GUID */
>+		if (device->ib_device->node_guid == cma_id->device->node_guid)
>+			break;
>+	}
>+
>+	if (device == NULL) {
>+		device = kzalloc(sizeof *device, GFP_KERNEL);
>+		if (device == NULL)
>+			goto end;

goto out;  // see below

>+		/* assign this device to the device */
>+		device->ib_device = cma_id->device;
>+		/* init the device and link it into ig device list */
>+		if (iser_create_device_ib_res(device)) {
>+			kfree(device);
>+			device = NULL;
>+			goto end;
>+		}
>+		list_add(&device->ig_list, &ig.device_list);
>+	}
>+end:
>+	BUG_ON(device == NULL);
>+	device->refcount++;

out:

>+	mutex_unlock(&ig.device_list_mutex);
>+	return device;
>+}
>+

>+static void iser_disconnected_handler(struct rdma_cm_id *cma_id)
>+{
>+	struct iser_conn *ib_conn;
>+
>+	ib_conn = (struct iser_conn *)cma_id->context;
>+	ib_conn->disc_evt_flag = 1;
>+
>+	/* If this event is unsolicited this means that the conn is being */
>+	/* terminated asynchronously from the iSCSI layer's perspective.  */
>+	if (atomic_read(&ib_conn->state) == ISER_CONN_PENDING) {
>+		atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>+		wake_up_interruptible(&ib_conn->wait);
>+	} else {
>+		if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
>+			atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
>+			iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
>+						ISCSI_ERR_CONN_FAILED);
>+		}
>+		/* Complete the termination process if no posts are pending */
>+		if ((atomic_read(&ib_conn->post_recv_buf_count) == 0) &&
>+		    (atomic_read(&ib_conn->post_send_buf_count) == 0)) {
>+			atomic_set(&ib_conn->state, ISER_CONN_DOWN);
>+			wake_up_interruptible(&ib_conn->wait);
>+		}
>+	}

Are there races here between reading ib_conn->state and setting it?  Could it
have changed in between the atomic_read() and atomic_set()?

>+	src = (struct sockaddr *)src_addr;
>+	dst = (struct sockaddr *)dst_addr;
>+	err = rdma_resolve_addr(ib_conn->cma_id, src, dst, 1000);
>+	if (err) {
>+		iser_err("rdma_resolve_addr failed: %d\n", err);
>+		goto addr_failure;
>+	}
>+
>+	if (!non_blocking) {
>+		wait_event_interruptible(ib_conn->wait,
>+			 atomic_read(&ib_conn->state) != ISER_CONN_PENDING);
>+
>+		if (atomic_read(&ib_conn->state) != ISER_CONN_UP) {
>+			err =  -EIO;
>+			goto connect_failure;
>+		}
>+	}
>+
>+	mutex_lock(&ig.connlist_mutex);
>+	list_add(&ib_conn->conn_list, &ig.connlist);
>+	mutex_unlock(&ig.connlist_mutex);

Not sure if there's a race here or not, but rdma_resolve_addr() will result in a
callback from a separate thread.  That callback could occur before the ib_conn
is added to the ig.connlist.  Do you assume that ib_conn is in the connlist in
any of the callbacks?

>+int iser_post_recv(struct iser_desc *rx_desc)
>+{
>+	int		  ib_ret, ret_val = 0;
>+	struct ib_recv_wr recv_wr, *recv_wr_failed;
>+	struct ib_sge	  iov[2];
>+	struct iser_conn  *ib_conn;
>+	struct iser_dto   *recv_dto = &rx_desc->dto;
>+
>+	/* Retrieve conn */
>+	ib_conn = recv_dto->conn->ib_conn;
>+
>+	iser_dto_to_iov(recv_dto, iov, 2);
>+
>+	recv_wr.next	= NULL;
>+	recv_wr.sg_list = iov;
>+	recv_wr.num_sge = recv_dto->regd_vector_len;
>+	recv_wr.wr_id	= (unsigned long)rx_desc;

Nit - position of "=" signs above is weird.

>+static void iser_comp_error_worker(void *data)
>+{
>+	struct iser_conn *ib_conn = data;
>+
>+	if (atomic_read(&ib_conn->state) == ISER_CONN_UP) {
>+		atomic_set(&ib_conn->state, ISER_CONN_TERMINATING);
>+		iscsi_conn_failure(ib_conn->iser_conn->iscsi_conn,
>+					ISCSI_ERR_CONN_FAILED);
>+	}

Potential race reading/setting state?

- Sean
