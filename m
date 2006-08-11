Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWHKAFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWHKAFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWHKAFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:05:45 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:54252 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932351AbWHKAFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:05:42 -0400
To: Jan-Bernd Themann <ossthema@de.ibm.com>
cc: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/6] ehea: queue management 
In-reply-to: <44D99F38.8010306@de.ibm.com> 
References: <44D99F38.8010306@de.ibm.com>
Comments: In-reply-to Jan-Bernd Themann <ossthema@de.ibm.com>
   message dated "Wed, 09 Aug 2006 10:39:20 +0200."
Reply-to: Michael Neuling <mikey@neuling.org>
X-Mailer: MH-E 7.85; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 11 Aug 2006 10:05:39 +1000
Message-Id: <20060811000540.200CE67B6B@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add comments to make the code more readable, especially at the
start of functions/structures to describe what they do.  A large readme
at the start of ehea_main.c which gave an overview of the driver design
would be really useful.

Comments inline below... 

> +static void *ipz_qpageit_get_inc(struct ipz_queue *queue)
> +{
> +	void *retvalue = ipz_qeit_get(queue);
> +	queue->current_q_offset += queue->pagesize;
> +	if (queue->current_q_offset > queue->queue_length) {
> +		queue->current_q_offset -= queue->pagesize;
> +		retvalue = NULL;
> +	}
> +	else if ((((u64) retvalue) & (EHEA_PAGESIZE-1)) != 0) {
> +		EDEB(4, "ERROR!! not at PAGE-Boundary");
> +		return NULL;
> +	}
> +	EDEB(7, "queue=%p retvalue=%p", queue, retvalue);

Don't redefine these debugging macros, but if so, what is EDEB?

> +	return retvalue;
> +}
> +
> +static int ipz_queue_ctor(struct ipz_queue *queue,
> +			  const u32 nr_of_pages,
> +			  const u32 pagesize, const u32 qe_size,
> +			  const u32 nr_of_sg)
> +{
> +	int f;
> +	EDEB_EN(7, "nr_of_pages=%x pagesize=%x qe_size=%x",
> +		nr_of_pages, pagesize, qe_size);
> +	queue->queue_length = nr_of_pages * pagesize;
> +	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));

> +	if (!queue->queue_pages) {
> +		EDEB(4, "ERROR!! didn't get the memory");
> +		return 0;
> +	}
> +	memset(queue->queue_pages, 0, nr_of_pages * sizeof(void *));
> +
> +	for (f = 0; f < nr_of_pages; f++) {
> +		(queue->queue_pages)[f] =
> +		    (struct ipz_page *)get_zeroed_page(GFP_KERNEL);
> +		if (!(queue->queue_pages)[f]) {
> +			break;
> +		}
> +	}
> +	if (f < nr_of_pages) {
> +		int g;
> +		EDEB_ERR(4, "couldn't get 0ed pages queue=%p f=%x "
> +			 "nr_of_pages=%x", queue, f, nr_of_pages);
> +		for (g = 0; g < f; g++) {
> +			free_page((unsigned long)(queue->queue_pages)[g]);
> +		}
> +		return 0;

If you return here when calling from ehea_create_eq, I think you are
leaking the queue->queue_pages allocation (the pages they point to are
freed correctly).

Either way these allocations/deallocations seem too complicated.  Can
you write to dtor so it can be called to free the structure in any state?

> +	}
> +	queue->current_q_offset = 0;
> +	queue->qe_size = qe_size;
> +	queue->act_nr_of_sg = nr_of_sg;
> +	queue->pagesize = pagesize;
> +	queue->toggle_state = 1;
> +	EDEB_EX(7, "queue_length=%x queue_pages=%p qe_size=%x"
> +		" act_nr_of_sg=%x", queue->queue_length, queue->queue_pages,
> +		queue->qe_size, queue->act_nr_of_sg);
> +	return 1;
> +}
> +
> +static int ipz_queue_dtor(struct ipz_queue *queue)
> +{
> +	int g;
> +	EDEB_EN(7, "ipz_queue pointer=%p", queue);
> +	if (!queue) {
> +		return 0;
> +	}
> +	if (!queue->queue_pages) {
> +		return 0;
> +	}

if (!queue || !queue->queue_pages) 
      return 0;

> +	EDEB(7, "destructing a queue with the following properties:\n"
> +	     "queue_length=%x act_nr_of_sg=%x pagesize=%x qe_size=%x",
> +	     queue->queue_length, queue->act_nr_of_sg, queue->pagesize,
> +	     queue->qe_size);
> +	for (g = 0; g < (queue->queue_length / queue->pagesize); g++) {
> +		free_page((unsigned long)(queue->queue_pages)[g]);
> +	}
> +	vfree(queue->queue_pages);
> +
> +	EDEB_EX(7, "queue freed!");
> +	return 1;
> +}
> +
> +struct ehea_cq *ehea_cq_new(void)
> +{
> +	struct ehea_cq *cq = vmalloc(sizeof(*cq));
> +	if (cq)
> +		memset(cq, 0, sizeof(*cq));
> +	return cq;
> +}
> +
> +void ehea_cq_delete(struct ehea_cq *cq)
> +{
> +	vfree(cq);
> +}

This is used in only two places.  Do we need it?  

If we do... can we static inline?

> +struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
> +			       int nr_of_cqe, u64 eq_handle, u32 cq_token)
> +{
> +	struct ehea_cq *cq = NULL;
> +	struct h_galpa gal;
> +
> +	u64 *cq_handle_ref;
> +	u32 act_nr_of_entries;
> +	u32 act_pages;
> +	u64 hret = H_HARDWARE;
> +	int ipz_rc;
> +	u32 counter;
> +	void *vpage = NULL;
> +	u64 rpage = 0;
> +
> +	EDEB_EN(7, "adapter=%p nr_of_cqe=%x , eq_handle: %016lX",
> +		adapter, nr_of_cqe, eq_handle);
> +
> +	cq = ehea_cq_new();
> +	if (!cq) {
> +		cq = NULL;
> +		EDEB_ERR(4, "ehea_create_cq ret=%p (-ENOMEM)", cq);
> +		goto create_cq_exit0;
> +	}
> +
> +	cq->attr.max_nr_of_cqes = nr_of_cqe;
> +	cq->attr.cq_token = cq_token;
> +	cq->attr.eq_handle = eq_handle;
> +
> +	cq->adapter = adapter;
> +
> +	cq_handle_ref = &cq->ipz_cq_handle;
> +	act_nr_of_entries = 0;
> +	act_pages = 0;
> +
> +	hret = ehea_h_alloc_resource_cq(adapter->handle,
> +					cq,
> +					&cq->attr,
> +					&cq->ipz_cq_handle, &cq->galpas);

hret set twice...



> +	if (hret != H_SUCCESS) {
> +		EDEB_ERR(4, "ehea_h_alloc_resource_cq failed. hret=%lx", hret);
> +		goto create_cq_exit1;
> +	}
> +
> +	ipz_rc = ipz_queue_ctor(&cq->ipz_queue, cq->attr.nr_pages,
> +				EHEA_PAGESIZE, sizeof(struct ehea_cqe), 0);
> +	if (!ipz_rc)
> +		goto create_cq_exit2;
> +
> +	hret = H_SUCCESS;
> +
> +	for (counter = 0; counter < cq->attr.nr_pages; counter++) {
> +		vpage = ipz_qpageit_get_inc(&cq->ipz_queue);

vpga set twice...

> +		if (!vpage) {
> +			EDEB_ERR(4, "ipz_qpageit_get_inc() "
> +				 "returns NULL adapter=%p", adapter);
> +			goto create_cq_exit3;
> +		}
> +
> +		rpage = virt_to_abs(vpage);
> +
> +		hret = ehea_h_register_rpage_cq(adapter->handle,
> +						cq->ipz_cq_handle,
> +						0,
> +						HIPZ_CQ_REGISTER_ORIG,
> +						rpage, 1, cq->galpas.kernel);
> +
> +		if (hret < H_SUCCESS) {
> +			EDEB_ERR(4, "ehea_h_register_rpage_cq() failed "
> +				 "ehea_cq=%p hret=%lx "
> +				 "counter=%i act_pages=%i",
> +				 cq, hret, counter, cq->attr.nr_pages);
> +			goto create_cq_exit3;
> +		}
> +
> +		if (counter == (cq->attr.nr_pages - 1)) {
> +			vpage = ipz_qpageit_get_inc(&cq->ipz_queue);
> +
> +			if ((hret != H_SUCCESS) || (vpage)) {
> +				EDEB_ERR(4, "Registration of pages not "
> +					 "complete ehea_cq=%p hret=%lx",
> +					 cq, hret)
> +				goto create_cq_exit3;
> +			}
> +		} else {
> +			if ((hret != H_PAGE_REGISTERED) || (vpage == 0)) {
> +				EDEB_ERR(4, "Registration of page failed "
> +					 "ehea_cq=%p hret=%lx"
> +					 "counter=%i act_pages=%i",
> +					 cq, hret, counter, cq->attr.nr_pages);
> +				goto create_cq_exit3;
> +			}
> +		}
> +	}
> +
> +	ipz_qeit_reset(&cq->ipz_queue);
> +	gal = cq->galpas.kernel;
> +	ehea_reset_cq_ep(cq);
> +	ehea_reset_cq_n1(cq);
> +
> +	EDEB_EX(7, "ret=%p ", cq);
> +	return cq;
> +
> +create_cq_exit3:
> +	ipz_queue_dtor(&cq->ipz_queue);
> +
> +create_cq_exit2:
> +	hret = ehea_h_destroy_cq(adapter->handle, cq, cq->ipz_cq_handle,
> +				 &cq->galpas);
> +	EDEB(7, "return code of ehea_cq_destroy=%lx", hret);
> +
> +create_cq_exit1:
> +	ehea_cq_delete(cq);
> +
> +create_cq_exit0:
> +	EDEB_EX(7, "ret=NULL");
> +	return NULL;
> +}
> +
> +int ehea_destroy_cq(struct ehea_cq *cq)
> +{
> +	int ret = 0;
> +	u64 adapter_handle;
> +	u64 hret = H_HARDWARE;
> +
> +	adapter_handle = cq->adapter->handle;
> +	EDEB_EN(7, "adapter=%p cq=%p", cq->adapter, cq);
> +
> +	/* deregister all previous registered pages */
> +	hret = ehea_h_destroy_cq(adapter_handle, cq, cq->ipz_cq_handle,
> +				 &cq->galpas);
> +	if (hret != H_SUCCESS) {
> +		EDEB_ERR(4, "destroy CQ failed!");
> +		return -EINVAL;
> +	}
> +	ipz_queue_dtor(&cq->ipz_queue);
> +	ehea_cq_delete(cq);
> +
> +	EDEB_EX(7, "ret=%x ", ret);
> +	return ret;
> +}
> +
> +struct ehea_eq *ehea_eq_new(void)
> +{
> +	struct ehea_eq *eq = vmalloc(sizeof(*eq));
> +	if (eq)
> +		memset(eq, 0, sizeof(*eq));
> +	return eq;
> +}
> +
> +void ehea_eq_delete(struct ehea_eq *eq)
> +{
> +	vfree(eq);
> +}

Again, is this really needed and what about static inline?

> +struct ehea_eq *ehea_create_eq(struct ehea_adapter *adapter,
> +			       const enum ehea_eq_type type,
> +			       const u32 max_nr_of_eqes, const u8 eqe_gen)
> +{
> +	u64 hret = H_HARDWARE;
> +	int ret = 0;
> +	u32 i;
> +	void *vpage = NULL;
> +	struct ehea_eq *eq;
> +
> +	EDEB_EN(7, "adapter=%p, max_nr_of_eqes=%x", adapter, max_nr_of_eqes);
> +
> +	eq = ehea_eq_new();
> +	if (!eq)
> +		return NULL;
> +
> +	eq->adapter = adapter;
> +	eq->attr.type = type;
> +	eq->attr.max_nr_of_eqes = max_nr_of_eqes;
> +	eq->attr.eqe_gen = eqe_gen;
> +	spin_lock_init(&eq->spinlock);
> +
> +	hret = ehea_h_alloc_resource_eq(adapter->handle,
> +					eq, &eq->attr, &eq->ipz_eq_handle);
> +
> +	if (hret != H_SUCCESS) {
> +		EDEB_ERR(4, "ehea_h_alloc_resource_eq failed. hret=%lx", hret);
> +		goto free_eq_mem;
> +	}
> +
> +	ret = ipz_queue_ctor(&eq->ipz_queue, eq->attr.nr_pages,
> +			      EHEA_PAGESIZE, sizeof(struct ehea_eqe), 0);
> +	if (!ret) {
> +		EDEB_ERR(4, "can't allocate EQ pages");
> +		goto alloc_pages_failed;
> +	}
> +
> +	for (i = 0; i < eq->attr.nr_pages; i++) {
> +		u64 rpage;
> +
> +		if (!(vpage = ipz_qpageit_get_inc(&eq->ipz_queue))) {
> +			hret = H_RESOURCE;
> +			goto register_page_failed;
> +		}
> +
> +		rpage = virt_to_abs(vpage);
> +
> +		hret = ehea_h_register_rpage_eq(adapter->handle,
> +						eq->ipz_eq_handle,
> +						0,
> +						HIPZ_EQ_REGISTER_ORIG,
> +						rpage, 1);
> +
> +		if (i == (eq->attr.nr_pages - 1)) {
> +			/* last page */
> +			vpage = ipz_qpageit_get_inc(&eq->ipz_queue);
> +			if ((hret != H_SUCCESS) || (vpage)) {
> +				goto register_page_failed;
> +			}
> +		} else {
> +			if ((hret != H_PAGE_REGISTERED) || (!vpage)) {
> +				goto register_page_failed;
> +			}
> +		}
> +	}
> +
> +	ipz_qeit_reset(&eq->ipz_queue);
> +
> +	EDEB_EX(7, "hret=%lx", hret);
> +	return eq;
> +
> +register_page_failed:
> +	ipz_queue_dtor(&eq->ipz_queue);
> +
> +alloc_pages_failed:
> +	ehea_h_destroy_eq(adapter->handle, eq, eq->ipz_eq_handle, &eq->galpas);
> +free_eq_mem:
> +	ehea_eq_delete(eq);
> +
> +	EDEB_EX(7, "return with error hret=%lx", hret);
> +	return NULL;
> +}
> +
> +void *ehea_poll_eq(struct ehea_eq *eq)
> +{
> +	void *eqe = NULL;
> +	unsigned long flags = 0;
> +
> +	EDEB_EN(7, "adapter=%p  eq=%p", eq->adapter, eq);
> +
> +	spin_lock_irqsave(&eq->spinlock, flags);
> +	eqe = ipz_eqit_eq_get_inc_valid(&eq->ipz_queue);
> +	spin_unlock_irqrestore(&eq->spinlock, flags);
> +
> +	EDEB_EX(7, "eqe=%p", eqe);
> +
> +	return eqe;
> +}
> +
> +int ehea_destroy_eq(struct ehea_eq *eq)
> +{
> +	unsigned long flags = 0;
> +	u64 hret = H_HARDWARE;
> +
> +	EDEB_EN(7, "adapter=%p  eq=%p", eq->adapter, eq);
> +
> +	spin_lock_irqsave(&eq->spinlock, flags);
> +
> +	hret = ehea_h_destroy_eq(eq->adapter->handle, eq, eq->ipz_eq_handle,
> +				 &eq->galpas);
> +	spin_unlock_irqrestore(&eq->spinlock, flags);
> +
> +	if (hret != H_SUCCESS) {
> +		EDEB_ERR(4, "Failed freeing EQ resources. hret=%lx", hret);
> +		return -EINVAL;
> +	}
> +	ipz_queue_dtor(&eq->ipz_queue);
> +	ehea_eq_delete(eq);
> +	EDEB_EX(7, "");
> +
> +	return 0;
> +}
> +
> +struct ehea_qp *ehea_qp_new(void) {
> +	struct ehea_qp *qp = vmalloc(sizeof(*qp));
> +	if (qp != 0) {

if (qp) ??

> +		memset(qp, 0, sizeof(*qp));
> +	}
> +	return qp;
> +}
> +
> +void ehea_qp_delete(struct ehea_qp *qp)
> +{
> +	vfree(qp);
> +}
> +
> +/**
> + * allocates memory for a queue and registers pages in phyp
> + */
> +int ehea_qp_alloc_register(struct ehea_qp *qp,
> +			   struct ipz_queue *ipz_queue,
> +			   int nr_pages,
> +			   int wqe_size,
> +			   int act_nr_sges,
> +			   struct ehea_adapter *adapter, int h_call_q_selector)
> +{
> +	u64 hret = H_HARDWARE;
> +	u64 rpage = 0;
> +	int iret = 0;
> +	int cnt = 0;
> +	void *vpage = NULL;
> +
> +	iret = ipz_queue_ctor(ipz_queue,
> +			      nr_pages, EHEA_PAGESIZE, wqe_size, act_nr_sges);
> +	if (!iret) {
> +		EDEB_ERR(4, "Cannot allocate page for queue. iret=%x", iret);
> +		return -ENOMEM;
> +	}
> +
> +	EDEB(7, "queue_size=%x, alloc_len=%x, toggle_state=%d",
> +	     ipz_queue->qe_size,
> +	     ipz_queue->queue_length, ipz_queue->toggle_state);
> +
> +	for (cnt = 0; cnt < nr_pages; cnt++) {
> +		vpage = ipz_qpageit_get_inc(ipz_queue);
> +		if (!vpage) {
> +			EDEB_ERR(4, "SQ ipz_qpageit_get_inc() "
> +				 "failed p_vpage= %p", vpage);
> +			goto qp_alloc_register_exit0;
> +		}
> +		rpage = virt_to_abs(vpage);
> +
> +		hret = ehea_h_register_rpage_qp(adapter->handle,
> +						qp->ipz_qp_handle,
> +						0,
> +						h_call_q_selector,
> +						rpage,
> +						1, qp->galpas.kernel);
> +
> +		if (hret < H_SUCCESS) {
> +			EDEB_ERR(4, "ehea_h_register_rpage_qp failed. hret=%lx"
,
> +				 hret);
> +			goto qp_alloc_register_exit0;
> +		}
> +	}
> +	ipz_qeit_reset(ipz_queue);
> +
> +	return 0;
> +
> +qp_alloc_register_exit0:
> +	ipz_queue_dtor(ipz_queue);
> +	return -EINVAL;
> +}
> +
> +static inline u32 map_swqe_size(u8 swqe_enc_size)
> +{
> +	return 128 << swqe_enc_size;
> +}
> +
> +static inline u32 map_rwqe_size(u8 rwqe_enc_size)
> +{
> +	return 128 << rwqe_enc_size;
> +}

Snap!  These are identical...

Name the function after what it does, not after the functions you expect
to call it.  

> +
> +struct ehea_qp *ehea_create_qp(struct ehea_adapter *adapter,
> +			       u32 pd, struct ehea_qp_init_attr *init_attr)
> +{
> +	struct ehea_qp *qp;
> +	u64 hret = H_HARDWARE;
> +
> +	u32 wqe_size_in_bytes_sq = 0;
> +	u32 wqe_size_in_bytes_rq1 = 0;
> +	u32 wqe_size_in_bytes_rq2 = 0;
> +	u32 wqe_size_in_bytes_rq3 = 0;
> +
> +	int ret = -1;
> +
> +	EDEB_EN(7, "init_attr=%p", init_attr);
> +
> +	qp = ehea_qp_new();
> +
> +	if (!qp) {
> +		EDEB_ERR(4, "pd=%X not enough memory to alloc qp", pd);
> +		return NULL;
> +	}
> +	qp->adapter = adapter;
> +
> +	EDEB(7, "send_ehea_cq->ipz_cq_handle=0x%lX"
> +	     "recv_ehea_cq->ipz_cq_handle=0x%lX", init_attr->send_cq_handle,
> +	     init_attr->recv_cq_handle);
> +
> +
> +	hret = ehea_h_alloc_resource_qp(adapter->handle, qp,
> +					init_attr,
> +					pd,
> +					&qp->ipz_qp_handle,
> +					&qp->galpas);
> +
> +	if (hret != H_SUCCESS) {
> +		EDEB_ERR(4, "ehea_h_alloc_resource_qp failed. hret=%lx", hret);
> +		goto create_qp_exit1;
> +	}
> +
> +	wqe_size_in_bytes_sq = map_swqe_size(init_attr->act_wqe_size_enc_sq);
> +	EDEB(7, "SWQE SG %d", init_attr->wqe_size_enc_sq);
> +
> +	wqe_size_in_bytes_rq1 = map_rwqe_size(init_attr->act_wqe_size_enc_rq1);
> +	wqe_size_in_bytes_rq2 = map_rwqe_size(init_attr->act_wqe_size_enc_rq2);
> +	wqe_size_in_bytes_rq3 = map_rwqe_size(init_attr->act_wqe_size_enc_rq3);
> +
> +	EDEB(7, "SQ pages: %d, SQ WQE size:%d, max SWQE size enc: %d",
> +	     init_attr->nr_sq_pages,
> +	     wqe_size_in_bytes_sq, init_attr->act_wqe_size_enc_sq);
> +
> +	EDEB(7, "RQ1 pages: %d, RQ1 WQE size:%d, max RWQE size enc: %d",
> +	     init_attr->nr_rq1_pages,
> +	     wqe_size_in_bytes_rq1, init_attr->act_wqe_size_enc_rq1);
> +
> +	EDEB(7, "RQ2 pages: %d, RQ2 WQE size:%d, max RWQE size enc: %d",
> +	     init_attr->nr_rq2_pages,
> +	     wqe_size_in_bytes_rq2, init_attr->act_wqe_size_enc_rq2);
> +
> +	EDEB(7, "RQ3 pages: %d, RQ3 WQE size:%d, max RWQE size enc: %d",
> +	     init_attr->nr_rq3_pages,
> +	     wqe_size_in_bytes_rq3, init_attr->act_wqe_size_enc_rq3);
> +
> +	ret = ehea_qp_alloc_register(qp,
> +				     &qp->ipz_squeue,
> +				     init_attr->nr_sq_pages,
> +				     wqe_size_in_bytes_sq,
> +				     init_attr->act_wqe_size_enc_sq, adapter,
> +				     0);
> +	if (ret < H_SUCCESS) {
> +		EDEB_ERR(4, "can't register for sq hret=%x", ret);
> +		goto create_qp_exit2;
> +	}
> +
> +	ret = ehea_qp_alloc_register(qp,
> +				     &qp->ipz_rqueue1,
> +				     init_attr->nr_rq1_pages,
> +				     wqe_size_in_bytes_rq1,
> +				     init_attr->act_wqe_size_enc_rq1,
> +				     adapter, 1);
> +
> +	if (ret < 0) {
> +		EDEB_ERR(4, "can't register for rq1 hret=%x", ret);
> +		goto create_qp_exit3;
> +	}
> +
> +	if (init_attr->rq_count > 1) {
> +		ret = ehea_qp_alloc_register(qp,
> +					     &qp->ipz_rqueue2,
> +					     init_attr->nr_rq2_pages,
> +					     wqe_size_in_bytes_rq2,
> +					     init_attr->act_wqe_size_enc_rq2,
> +					     adapter, 2);
> +
> +		if (ret < 0) {
> +			EDEB_ERR(4, "can't register for rq2 hret=%x", ret);
> +			goto create_qp_exit4;
> +		}
> +	}
> +
> +	if (init_attr->rq_count > 2) {
> +		ret = ehea_qp_alloc_register(qp,
> +					     &qp->ipz_rqueue3,
> +					     init_attr->nr_rq3_pages,
> +					     wqe_size_in_bytes_rq3,
> +					     init_attr->act_wqe_size_enc_rq3,
> +					     adapter, 3);
> +
> +		if (ret != 0) {
> +			EDEB_ERR(4, "can't register for rq3 hret=%x", ret);
> +			goto create_qp_exit5;
> +		}
> +	}
> +
> +	qp->init_attr = *init_attr;
> +
> +	EDEB_EX(7, "");
> +	return qp;
> +
> +create_qp_exit5:
> +	ipz_queue_dtor(&qp->ipz_rqueue2);
> +
> +create_qp_exit4:
> +	ipz_queue_dtor(&qp->ipz_rqueue1);
> +
> +create_qp_exit3:
> +	ipz_queue_dtor(&qp->ipz_squeue);
> +
> +create_qp_exit2:
> +	hret = ehea_h_destroy_qp(adapter->handle, qp, qp->ipz_qp_handle,
> +				 &qp->galpas);
> +
> +create_qp_exit1:
> +	ehea_qp_delete(qp);
> +
> +	EDEB_EX(7, "hret=NULL");
> +	return NULL;
> +
> +}
> +
> +int ehea_destroy_qp(struct ehea_qp *qp)
> +{
> +	int ret = 0;
> +	u64 hret = H_HARDWARE;
> +	struct ehea_qp_init_attr *qp_attr = &qp->init_attr;
> +	EDEB_EX(7, "");
> +
> +	hret = ehea_h_destroy_qp(qp->adapter->handle, qp, qp->ipz_qp_handle,
> +				 &qp->galpas);
> +	if (hret != H_SUCCESS) {
> +		EDEB_ERR(4, "destroy QP failed!");
> +		ret = -EINVAL;
> +	}
> +
> +	ipz_queue_dtor(&qp->ipz_squeue);
> +	ipz_queue_dtor(&qp->ipz_rqueue1);
> +
> +   	if(qp_attr->rq_count > 1)
> +		ipz_queue_dtor(&qp->ipz_rqueue2);
> +   	if(qp_attr->rq_count > 2)
> +		ipz_queue_dtor(&qp->ipz_rqueue3);
> +	ehea_qp_delete(qp);
> +
> +	EDEB_EX(7, "hret=%lx", hret);
> +
> +	return ret;
> +}
> +
> +int ehea_reg_mr_adapter(struct ehea_adapter *adapter)
> +{
> +	int i = 0;
> +	int k = 0;
> +	u64 hret = H_HARDWARE;
> +	u64 start = KERNELBASE;
> +	u64 end = (u64) high_memory;
> +	u64 nr_pages = (end - start) / PAGE_SIZE;
> +	u32 acc_ctrl = EHEA_MR_ACC_CTRL;
> +	u64 pt_abs = 0;
> +	u64 *pt;
> +
> +	EDEB_EN(7, "adapter=%p", adapter);
> +	pt =  kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!pt) {
> +		EDEB_ERR(4, "allocating page failed");
> +		return -EINVAL;
> +	}
> +	pt_abs = virt_to_abs(pt);
> +
> +	hret = ehea_h_alloc_resource_mr(adapter->handle,
> +					start,
> +					end - start,
> +					acc_ctrl,
> +					adapter->pd,
> +					&adapter->mr.handle,
> +					&adapter->mr.lkey);
> +	if (hret != H_SUCCESS) {
> +		EDEB_EX(4, "Error: hret=%lX\n", hret);
> +		return -EINVAL;
> +	}
> +
> +	adapter->mr.vaddr = KERNELBASE;
> +
> +	while (nr_pages > 0) {
> +		if (nr_pages > 1) {
> +			u64 num_pages = min(nr_pages, (u64)512);
> +			for (i = 0; i < num_pages; i++)
> +				pt[i] = virt_to_abs((void *)(((u64)start)
> +							     + ((k++) *
> +								PAGE_SIZE)));
> +
> +			hret = ehea_h_register_rpage_mr(adapter->handle,
> +							adapter->mr.handle,
> +							0,
> +							0,
> +							(u64)pt_abs,
> +							num_pages);

They probably don't all need their own line.

> +			nr_pages -= num_pages;
> +		} else {
> +			u64 abs_adr = virt_to_abs((void *)(((u64)start)
> +							   + (k * PAGE_SIZE)));
> +			hret = ehea_h_register_rpage_mr(adapter->handle,
> +							adapter->mr.handle,
> +							0,
> +							0,
> +							abs_adr,
> +							1);

Ditto.

> +			nr_pages--;
> +		}
> +
> +		if ((hret != H_SUCCESS) && (hret != H_PAGE_REGISTERED)) {
> +			ehea_h_free_resource_mr(adapter->handle,
> +						adapter->mr.handle);
> +			EDEB_EX(4, " register rpage_mr: hret=%lX\n", hret);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (hret != H_SUCCESS) {
> +		ehea_h_free_resource_mr(adapter->handle, adapter->mr.handle);
> +		EDEB_EX(4, " register rpage_mr failed for last page: hret=%lX",
> +			hret);
> +		return -EINVAL;
> +	}
> +
> +	EDEB_EX(7, "lkey=0x%X, mr_handle=0x%lX", adapter->mr.lkey,
> +		adapter->mr.handle);
> +	return 0;
> +}
> +
> +int ehea_reg_mr_pages(struct ehea_adapter *adapter,
> +		      struct ehea_mr *mr,
> +		      u64 start, u64 *pt, int nr_pages)
> +{
> +	u64 hret = H_HARDWARE;
> +	u32 acc_ctrl = EHEA_MR_ACC_CTRL;
> +
> +	u64 pt_abs = virt_to_abs(pt);
> +	u64 first_page = pt[0];
> +
> +	hret = ehea_h_alloc_resource_mr(adapter->handle,
> +					start,
> +					PAGE_SIZE * nr_pages,
> +					acc_ctrl,
> +					adapter->pd,
> +					&mr->handle,
> +					&mr->lkey);
> +	if (hret != H_SUCCESS) {
> +		EDEB_EX(4, "Error: hret=%lX\n", hret);
> +		return -EINVAL;
> +	}
> +
> +	if (nr_pages > 1)
> +		hret = ehea_h_register_rpage_mr(adapter->handle,
> +						mr->handle,
> +						0,
> +						0,
> +						(u64)pt_abs,
> +						nr_pages);
> +	else
> +		hret = ehea_h_register_rpage_mr(adapter->handle,
> +						mr->handle,
> +						0,
> +						0,
> +						first_page,
> +						1);

hret = ehea_h_register_rpage_mr(adapter->handle, mr->handle, 0,
				0, (nr_pages > 1)?(u64)pt_abs:first_page,
				nr_pages);
Simpler?

Or get ehea_h_register_rpage_mr to do this for you?  You seem to do this
same decode twice?


> +
> +	if (hret != H_SUCCESS) {
> +		ehea_h_free_resource_mr(adapter->handle, mr->handle);
> +		EDEB_EX(4, " register rpage_mr failed for last page:"
> +			"hret=%lX\n", hret);
> +		return -EINVAL;
> +	}
> +	mr->vaddr = start;
> +
> +	EDEB_EX(7, "");
> +	return 0;
> +}
> +
> +
> +
> +int ehea_dereg_mr_adapter(struct ehea_adapter *adapter)
> +{
> +	u64 hret = H_HARDWARE;
> +	EDEB_EN(7, "adapter=%p", adapter);
> +	hret = ehea_h_free_resource_mr(adapter->handle, adapter->mr.handle);
> +	if (hret != H_SUCCESS) {
> +		EDEB_EX(4, "deregistering memory region failed");
> +		return -EINVAL;
> +	}
> +	EDEB_EX(7, "");
> +	return 0;
> +}
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_qmr.h	1969-12-31 16:00:00.000
000000 -0800
> +++ kernel/drivers/net/ehea/ehea_qmr.h	2006-08-08 23:59:38.108463416 -
0700
> @@ -0,0 +1,381 @@
> +/*
> + *  linux/drivers/net/ehea/ehea_qmr.h
> + *
> + *  eHEA ethernet device driver for IBM eServer System p
> + *
> + *  (C) Copyright IBM Corp. 2006
> + *
> + *  Authors:
> + *       Christoph Raisch <raisch@de.ibm.com>
> + *       Jan-Bernd Themann <themann@de.ibm.com>
> + *       Heiko-Joerg Schick <schickhj@de.ibm.com>
> + *       Thomas Klein <tklein@de.ibm.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __EHEA_QMR_H__
> +#define __EHEA_QMR_H__
> +
> +#include "ehea.h"
> +#include "ehea_hw.h"
> +
> +/* Use of WR_ID field for EHEA */
> +#define EHEA_WR_ID_COUNT   EHEA_BMASK_IBM(0, 19)
> +#define EHEA_WR_ID_TYPE    EHEA_BMASK_IBM(20, 23)
> +#define EHEA_SWQE2_TYPE    0x1
> +#define EHEA_SWQE3_TYPE    0x2
> +#define EHEA_RWQE2_TYPE    0x3	/* RQ2  */
> +#define EHEA_RWQE3_TYPE    0x4	/* RQ3  */
> +#define EHEA_WR_ID_INDEX   EHEA_BMASK_IBM(24, 47)
> +#define EHEA_WR_ID_REFILL  EHEA_BMASK_IBM(48, 63)
> +
> +struct ehea_vsgentry {
> +	u64 vaddr;
> +	u32 l_key;
> +	u32 len;
> +};
> +
> +/* maximum number of sg entries allowed in a WQE */
> +#define EHEA_MAX_WQE_SG_ENTRIES  252
> +#define SWQE2_MAX_IMM            (0xD0 - 0x30)	/* (160-14) ? */
> +#define SWQE3_MAX_IMM            224
> +
> +/* tx control flags for swqe */
> +#define EHEA_SWQE_CRC                    0x8000
> +#define EHEA_SWQE_IP_CHECKSUM            0x4000
> +#define EHEA_SWQE_TCP_CHECKSUM           0x2000
> +#define EHEA_SWQE_TSO                    0x1000
> +#define EHEA_SWQE_SIGNALLED_COMPLETION   0x0800
> +#define EHEA_SWQE_VLAN_INSERT            0x0400
> +#define EHEA_SWQE_IMM_DATA_PRESENT 	 0x0200
> +#define EHEA_SWQE_DESCRIPTORS_PRESENT    0x0100
> +#define EHEA_SWQE_WRAP_CTL_REC           0x0080
> +#define EHEA_SWQE_WRAP_CTL_FORCE         0x0040
> +#define EHEA_SWQE_BIND                   0x0020
> +#define EHEA_SWQE_PURGE                  0x0010
> +
> +#define SWQE_HEADER_SIZE 32

This is never used...  

Would be nice to document some of the names here.  What are SWQE, RWQE,
WQE, CQE, IPZ etc?

> +
> +struct ehea_swqe {
> +	u64 wr_id;
> +	u16 tx_control;
> +	u16 vlan_tag;
> +	u8 reserved1;
> +	u8 ip_start;
> +	u8 ip_end;
> +	u8 immediate_data_length;
> +	u8 tcp_offset;
> +	u8 reserved2;
> +	u16 tcp_end;
> +	u8 wrap_tag;
> +	u8 descriptors;		/* number of valid descriptors in WQE */
> +	u16 reserved3;
> +	u16 reserved4;
> +	u16 mss;
> +	u32 reserved5;
> +	union {
> +		/*  Send WQE Format 1 */
> +		struct {
> +			struct ehea_vsgentry sg_list[EHEA_MAX_WQE_SG_ENTRIES];
> +		} no_immediate_data;
> +
> +		/*  Send WQE Format 2 */
> +		struct {
> +			struct ehea_vsgentry sg_entry;
> +			/* 0x30 */
> +			u8 immediate_data[SWQE2_MAX_IMM];
> +			/* 0xd0 */
> +			struct ehea_vsgentry sg_list[EHEA_MAX_WQE_SG_ENTRIES-1]
;
> +		} immdata_desc __attribute__ ((packed));
> +
> +		/*  Send WQE Format 3 */
> +		struct {
> +			u8 immediate_data[SWQE3_MAX_IMM];
> +		} immdata_nodesc;
> +	} u;
> +};
> +
> +struct ehea_rwqe {
> +	u64 wr_id;		/* work request ID */
> +	u8 reserved1[5];
> +	u8 data_segments;
> +	u16 reserved2;
> +	u64 reserved3;
> +	u64 reserved4;
> +	struct ehea_vsgentry sg_list[EHEA_MAX_WQE_SG_ENTRIES];
> +};
> +
> +#define EHEA_CQE_VLAN_TAG_XTRACT  0x0400
> +
> +#define EHEA_CQE_TYPE_RQ          0x60
> +#define EHEA_CQE_STAT_ERR_MASK    0x7300
> +#define EHEA_CQE_STAT_ERR_TCP     0x4000
> +
> +struct ehea_cqe {
> +	u64 wr_id;		/* work request ID from WQE */
> +	u8 type;
> +	u8 valid;
> +	u16 status;
> +	u16 reserved1;
> +	u16 num_bytes_transfered;
> +	u16 vlan_tag;
> +	u16 inet_checksum_value;
> +	u8 reserved2;
> +	u8 header_length;
> +	u16 reserved3;
> +	u16 page_offset;
> +	u16 wqe_count;
> +	u32 qp_token;
> +	u32 timestamp;
> +	u32 reserved4;
> +	u64 reserved5[3];
> +};
> +
> +#define EHEA_EQE_VALID           EHEA_BMASK_IBM(0, 0)
> +#define EHEA_EQE_IS_CQE          EHEA_BMASK_IBM(1, 1)
> +#define EHEA_EQE_IDENTIFIER      EHEA_BMASK_IBM(2, 7)
> +#define EHEA_EQE_QP_CQ_NUMBER    EHEA_BMASK_IBM(8, 31)
> +#define EHEA_EQE_QP_TOKEN        EHEA_BMASK_IBM(32, 63)
> +#define EHEA_EQE_CQ_TOKEN        EHEA_BMASK_IBM(32, 63)
> +#define EHEA_EQE_KEY             EHEA_BMASK_IBM(32, 63)

3 the same here?

> +#define EHEA_EQE_PORT_NUMBER     EHEA_BMASK_IBM(56, 63)
> +#define EHEA_EQE_EQ_NUMBER       EHEA_BMASK_IBM(48, 63)
> +#define EHEA_EQE_SM_ID           EHEA_BMASK_IBM(48, 63)

2 the same here?

> +#define EHEA_EQE_SM_MECH_NUMBER  EHEA_BMASK_IBM(48, 55)
> +#define EHEA_EQE_SM_PORT_NUMBER  EHEA_BMASK_IBM(56, 63)
> +
> +struct ehea_eqe {
> +	u64 entry;
> +};

ehea_ege.. what is that and why a struct if only 1 item?  Comments
please.  

In ehea_main.c you use this with a ehea_poll_eq which returns a void *
Mostly you cast to a (struct ehea_eqe *) but you don't need to.


> +
> +static inline void *ipz_qeit_calc(struct ipz_queue *queue, u64 q_offset)
> +{
> +	struct ipz_page *current_page = NULL;
> +	if (q_offset >= queue->queue_length)
> +		q_offset -= queue->queue_length;
> +	current_page = (queue->queue_pages)[q_offset >> EHEA_PAGESHIFT];
> +	return &current_page->entries[q_offset & (EHEA_PAGESIZE - 1)];
> +}
> +
> +static inline void *ipz_qeit_get(struct ipz_queue *queue)
> +{
> +	return ipz_qeit_calc(queue, queue->current_q_offset);
> +}
> +
> +static inline void ipz_qeit_inc(struct ipz_queue *queue)
> +{
> +	queue->current_q_offset += queue->qe_size;
> +	if (queue->current_q_offset >= queue->queue_length) {
> +		queue->current_q_offset = 0;
> +		/* toggle the valid flag */
> +		queue->toggle_state = (~queue->toggle_state) & 1;
> +	}
> +}
> +
> +static inline void *ipz_qeit_get_inc(struct ipz_queue *queue)
> +{
> +	void *retvalue = ipz_qeit_get(queue);
> +	ipz_qeit_inc(queue);
> +	EDEB(8, "queue=%p retvalue=%p new current_q_addr=%lx qe_size=%x",
> +	     queue, retvalue, queue->current_q_offset, queue->qe_size);
> +
> +	return retvalue;
> +}
> +
> +static inline void *ipz_qeit_get_inc_valid(struct ipz_queue *queue)
> +{
> +	struct ehea_cqe *retvalue = ipz_qeit_get(queue);
> +	void *pref;
> +	u8 valid = retvalue->valid;
> +	if ((valid >> 7) == (queue->toggle_state & 1)) {
> +		/* this is a good one */
> +		ipz_qeit_inc(queue);
> +		pref = ipz_qeit_calc(queue, queue->current_q_offset);
> +		prefetch(pref);
> +		prefetch(pref + 128);
> +	} else
> +		retvalue = NULL;
> +	return retvalue;
> +}
> +
> +static inline void *ipz_qeit_get_valid(struct ipz_queue *queue)
> +{
> +	u8 valid = 0;
> +
> +	struct ehea_cqe *retvalue = ipz_qeit_get(queue);
> +	void *pref;
> +	pref = ipz_qeit_calc(queue, queue->current_q_offset);
> +	prefetch(pref);
> +	prefetch(pref + 128);
> +	prefetch(pref + 256);
> +	valid = retvalue->valid;
> +	if (!((valid >> 7) == (queue->toggle_state & 1)))
> +		retvalue = NULL;
> +	return retvalue;
> +}
> +
> +static inline void *ipz_qeit_reset(struct ipz_queue *queue)
> +{
> +	queue->current_q_offset = 0;
> +	return ipz_qeit_get(queue);
> +}
> +
> +static inline void *ipz_qeit_eq_get_inc(struct ipz_queue *queue)
> +{
> +	void *retvalue = NULL;
> +	u64 last_entry_in_q = queue->queue_length - queue->qe_size;
> +
> +	retvalue = ipz_qeit_get(queue);
> +	queue->current_q_offset += queue->qe_size;
> +	if (queue->current_q_offset > last_entry_in_q) {
> +		queue->current_q_offset = 0;
> +		queue->toggle_state = (~queue->toggle_state) & 1;
> +	}
> +
> +	EDEB(7, "queue=%p retvalue=%p new current_q_offset=%lx qe_size=%x",
> +	     queue, retvalue, queue->current_q_offset, queue->qe_size);
> +
> +	return retvalue;
> +}
> +
> +static inline void *ipz_eqit_eq_get_inc_valid(struct ipz_queue *queue)
> +{
> +	void *retvalue = ipz_qeit_get(queue);
> +	u32 qe = *(u8 *) retvalue;
> +	EDEB(7, "ipz_eqit_eq_get_inc_valid qe=%x", qe);
> +	if ((qe >> 7) == (queue->toggle_state & 1))
> +		ipz_qeit_eq_get_inc(queue);
> +	else
> +		retvalue = NULL;
> +	return retvalue;
> +}
> +
> +static inline struct ehea_rwqe *ehea_get_next_rwqe(struct ehea_qp *qp,
> +						   int rq_nr)
> +{
> +
> +	struct ehea_rwqe *wqe_p = NULL;
> +	struct ipz_queue *queue = NULL;
> +	struct ehea_qp *my_qp = qp;
> +	EDEB_EN(8, "QP=%p, RQ_nr=%d", qp, rq_nr);
> +
> +	if (rq_nr == 1)
> +		queue = &my_qp->ipz_rqueue1;
> +	else if (rq_nr == 2)
> +		queue = &my_qp->ipz_rqueue2;
> +	else
> +		queue = &my_qp->ipz_rqueue3;
> +	wqe_p = (struct ehea_rwqe *)ipz_qeit_get_inc(queue);
> +
> +	EDEB_EX(8, "&RWQE=%p, queue=%p", wqe_p, queue);
> +	return wqe_p;
> +}
> +
> +static inline struct ehea_swqe *ehea_get_swqe(struct ehea_qp *my_qp,
> +					      int *wqe_index)
> +{
> +	struct ipz_queue *queue = &my_qp->ipz_squeue;
> +	struct ehea_swqe *wqe_p = NULL;
> +	EDEB_EN(7, "QP=%p, queue=%p", my_qp, &my_qp->ipz_squeue);
> +	*wqe_index = (queue->current_q_offset) >> (7 + EHEA_SG_SQ);
> +	wqe_p = (struct ehea_swqe *)ipz_qeit_get_inc(&my_qp->ipz_squeue);
> +	EDEB_EX(7, "");
> +	return wqe_p;
> +}
> +
> +static inline void ehea_post_swqe(struct ehea_qp *my_qp, struct ehea_swqe *s
wqe)
> +{
> +
> +	EDEB_EN(7, "QP=%p, SWQE=%p", my_qp, swqe);
> +	EDEB(6, "SWQE workreqid = 0x%lX, imm_data_len=%d, descriptors=%d",
> +	     (u64) swqe->wr_id, swqe->immediate_data_length, swqe->descriptors)
;
> +	iosync();
> +	ehea_update_sqa(my_qp, 1);
> +	EDEB_EX(7, "");
> +}
> +
> +static inline struct ehea_cqe *ehea_poll_rq1(struct ehea_qp *qp, int *wqe_in
dex)
> +{
> +	struct ipz_queue *queue = &qp->ipz_rqueue1;
> +	struct ehea_cqe *cqe = NULL;
> +
> +	EDEB_EN(7, "QP=%p, RQ1 toggle state = %d, current_q_offset=%lx", qp,
> +		queue->toggle_state, queue->current_q_offset);
> +	*wqe_index = (queue->current_q_offset) >> (7 + EHEA_SG_RQ1);
> +	cqe = (struct ehea_cqe *)ipz_qeit_get_valid(queue);
> +	EDEB_EX(7, "cqe=%p, new toggle state %d, wqe_index = %d",
> +		cqe, queue->toggle_state, *wqe_index);
> +	return cqe;
> +}
> +
> +static inline void ehea_inc_rq1(struct ehea_qp *qp)
> +{
> +	struct ipz_queue *queue = &qp->ipz_rqueue1;
> +	ipz_qeit_inc(queue);
> +}
> +
> +static inline struct ehea_cqe *ehea_poll_cq(struct ehea_cq *my_cq)
> +{
> +
> +	struct ehea_cqe *wqe_p = NULL;
> +	EDEB_EN(7, "CQ=%p", my_cq);
> +
> +	EDEB(7, "queue_element_size=%x, alloc_len=%x, queue=%p",
> +	     my_cq->ipz_queue.qe_size,
> +	     my_cq->ipz_queue.queue_length, &my_cq->ipz_queue);
> +	wqe_p = (struct ehea_cqe *)ipz_qeit_get_inc_valid(&my_cq->ipz_queue);
> +
> +	EDEB_EX(7, "wqe_p=%p", wqe_p);
> +	return wqe_p;
> +};

Can we stick all these functions in the .c and put only the prototypes here?

> +
> +#define HIPZ_CQ_REGISTER_ORIG 0
> +#define HIPZ_EQ_REGISTER_ORIG 0
> +
> +enum ehea_eq_type {
> +	EHEA_EQ = 0,		/* event queue              */
> +	EHEA_NEQ		/* notification event queue */
> +};
> +
> +struct ehea_eq *ehea_create_eq(struct ehea_adapter *adapter,
> +			       enum ehea_eq_type type,
> +			       const u32 length, const u8 eqe_gen);
> +
> +int ehea_destroy_eq(struct ehea_eq *eq);
> +
> +void *ehea_poll_eq(struct ehea_eq *eq);
> +
> +struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter, int cqe,
> +			       u64 eq_handle, u32 cq_token);
> +
> +int ehea_destroy_cq(struct ehea_cq *cq);
> +
> +
> +struct ehea_qp *ehea_create_qp(struct ehea_adapter * adapter,
> +			       u32 pd,
> +			       struct ehea_qp_init_attr *init_attr);
> +
> +int ehea_destroy_qp(struct ehea_qp *qp);
> +
> +int ehea_reg_mr_adapter(struct ehea_adapter *adapter);
> +int ehea_dereg_mr_adapter(struct ehea_adapter *adapter);
> +
> +int ehea_reg_mr_pages(struct ehea_adapter *adapter,
> +		      struct ehea_mr *mr,
> +		      u64 start, u64 *pt, int nr_pages);
> +
> +#endif	/* __EHEA_QMR_H__ */
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_ethtool.c	1969-12-31 16:0
0:00.000000000 -0800
> +++ kernel/drivers/net/ehea/ehea_ethtool.c	2006-08-08 23:59:38.092465848 -
0700

Why is the ethtool stuff in the queue management patch?

> @@ -0,0 +1,325 @@
> +/*
> + *  linux/drivers/net/ehea/ehea_ethtool.c
> + *
> + *  eHEA ethernet device driver for IBM eServer System p
> + *
> + *  (C) Copyright IBM Corp. 2006
> + *
> + *  Authors:
> + *       Christoph Raisch <raisch@de.ibm.com>
> + *       Jan-Bernd Themann <themann@de.ibm.com>
> + *       Heiko-Joerg Schick <schickhj@de.ibm.com>
> + *       Thomas Klein <tklein@de.ibm.com>
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include "ehea.h"
> +#include "ehea_phyp.h"
> +
> +
> +static int netdev_get_settings(struct net_device *dev, struct ethtool_cmd *c
md)
> +{
> +	u64 hret = H_HARDWARE;
> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
> +	struct ehea_adapter *adapter = port->adapter;
> +	struct hcp_query_ehea_port_cb_4 *cb4 = NULL;
> +
> +	EDEB_EN(7, "net_device=%p", dev);
> +
> +	cb4 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if(!cb4) {
> +		EDEB_ERR(4, "No memory for cb4");
> +		goto get_settings_exit;
> +	}
> +
> +	hret = ehea_h_query_ehea_port(adapter->handle,
> +				      port->logical_port_id,
> +				      H_PORT_CB4,
> +				      H_PORT_CB4_ALL,
> +				      cb4);

As mpe noted as well... hret is set twice..

> +
> +	if (hret != H_SUCCESS) {
> +		EDEB_ERR(4, "query_ehea_port failed for cb4");
> +		kfree(cb4);
> +		goto get_settings_exit;
> +	}
> +
> +	EDEB_DMP(7, (u8*)cb4,
> +		 sizeof(struct hcp_query_ehea_port_cb_4), "After HCALL");
> +
> +	if (netif_carrier_ok(dev)) {
> +		switch(cb4->port_speed){
> +		case H_PORT_SPEED_10M_H:
> +			cmd->speed = SPEED_10;
> +			cmd->duplex = DUPLEX_HALF;
> +			break;
> +		case H_PORT_SPEED_10M_F:
> +			cmd->speed = SPEED_10;
> +			cmd->duplex = DUPLEX_FULL;
> +			break;
> +		case H_PORT_SPEED_100M_H:
> +			cmd->speed = SPEED_100;
> +			cmd->duplex = DUPLEX_HALF;
> +			break;
> +		case H_PORT_SPEED_100M_F:
> +			cmd->speed = SPEED_100;
> +			cmd->duplex = DUPLEX_FULL;
> +			break;
> +		case H_PORT_SPEED_1G_F:
> +			cmd->speed = SPEED_1000;
> +			cmd->duplex = DUPLEX_FULL;
> +			break;
> +		case H_PORT_SPEED_10G_F:
> +			cmd->speed = SPEED_10000;
> +			cmd->duplex = DUPLEX_FULL;
> +			break;
> +		}
> +	} else {
> +		cmd->speed = -1;
> +		cmd->duplex = -1;
> +	}
> +
> +	cmd->supported =
> +	    (SUPPORTED_10000baseT_Full | SUPPORTED_1000baseT_Full
> +	     | SUPPORTED_100baseT_Full |  SUPPORTED_100baseT_Half
> +	     | SUPPORTED_10baseT_Full | SUPPORTED_10baseT_Half
> +	     | SUPPORTED_Autoneg | SUPPORTED_FIBRE);
> +	cmd->advertising =
> +	    (ADVERTISED_10000baseT_Full | ADVERTISED_Autoneg
> +	     | ADVERTISED_FIBRE);
> +	cmd->port = PORT_FIBRE;
> +	cmd->autoneg = AUTONEG_ENABLE;
> +
> +	kfree(cb4);
> +	return 0;
> +
> +get_settings_exit:
> +	EDEB_EX(7, "");
> +	return 1;
> +}
> +
> +static int netdev_set_settings(struct net_device *dev, struct ethtool_cmd *c
md)
> +{
> +	printk("set settings\n");
> +	return 0;
> +}
> +
> +static void netdev_get_drvinfo(struct net_device *dev,
> +			       struct ethtool_drvinfo *info)
> +{
> +	printk("get drvinfo\n");
> +	strncpy(info->driver, EHEA_DRIVER_NAME, sizeof(info->driver) - 1);
> +	strncpy(info->version, EHEA_DRIVER_VERSION, sizeof(info->version) - 1);
> +}
> +
> +static u32 netdev_get_msglevel(struct net_device *dev)
> +{
> +	EDEB(7, "");
> +	return (u32)ehea_trace_level;
> +}
> +
> +static void netdev_set_msglevel(struct net_device *dev, u32 value)
> +{
> +	EDEB(7, "trace level set to %x", value);
> +	ehea_trace_level = (int)value;
> +}
> +
> +static int netdev_nway_reset(struct net_device *dev)
> +{
> +	printk("nway reset\n");
> +	return 0;
> +}
> +
> +static void netdev_get_pauseparam(struct net_device *dev,
> +				  struct ethtool_pauseparam *pauseparam)
> +{
> +	printk("get pauseparam\n");
> +}
> +
> +static int netdev_set_pauseparam(struct net_device *dev,
> +				 struct ethtool_pauseparam *pauseparam)
> +{
> +	printk("set pauseparam\n");
> +	return 0;
> +}
> +
> +static u32 netdev_get_rx_csum(struct net_device *dev)
> +{
> +	printk("set rx_csum\n");
> +	return 0;
> +}
> +
> +static int netdev_set_rx_csum(struct net_device *dev, u32 value)
> +{
> +	printk("set rx_csum\n");
> +	return 0;
> +}
> +
> +static int netdev_self_test_count(struct net_device *dev)
> +{
> +	printk("self test count\n");
> +	return 0;
> +}
> +
> +static void netdev_self_test(struct net_device *dev, struct ethtool_test *te
st,
> +			     u64 *value)
> +{
> +	printk("self test\n");
> +}
> +
> +static int netdev_phys_id(struct net_device *dev, u32 value)
> +{
> +	printk("physical id\n");
> +	return 0;
> +}

These are yet to be done?


> +
> +static char ehea_ethtool_stats_keys[][ETH_GSTRING_LEN] = {
> +	{"poll_max_processed"},
> +	{"queue_stopped"},
> +	{"min_swqe_avail"},
> +	{"poll_receive_err"},
> +	{"pkt_send"},
> +	{"pkt_xmit"},
> +	{"send_tasklet"},
> +	{"ehea_poll"},
> +	{"nwqe"},
> +	{"swqe_available_0"},
> +	{"rxo"},
> +	{"rx64"},
> +	{"rx65"},
> +	{"rx128"},
> +	{"rx256"},
> +	{"rx512"},
> +	{"rx1024"},
> +	{"txo"},
> +	{"tx64"},
> +	{"tx65"},
> +	{"tx128"},
> +	{"tx256"},
> +	{"tx512"},
> +	{"tx1024"},
> +};
> +
> +static void netdev_get_strings(struct net_device *dev,
> +				     u32 stringset, u8 * data)
> +{
> +	switch (stringset) {
> +	case ETH_SS_TEST:
> +		break;
> +	case ETH_SS_STATS:
> +		memcpy(data, &ehea_ethtool_stats_keys,
> +		       sizeof(ehea_ethtool_stats_keys));
> +	}
> +}
> +
> +static int netdev_get_stats_count(struct net_device *dev)
> +{
> +	return ARRAY_SIZE(ehea_ethtool_stats_keys);
> +}
> +
> +
> +static void netdev_get_ethtool_stats(struct net_device *dev,
> +				     struct ethtool_stats *stats, u64 *data)
> +{
> +	int i = 0;
> +	u64 hret = H_HARDWARE;
> +	struct ehea_port *port = (struct ehea_port*)dev->priv;
> +	struct ehea_adapter *adapter = port->adapter;
> +	struct ehea_port_res *pr = &port->port_res[0];
> +	struct port_state *p_state = &pr->p_state;
> +	struct hcp_query_ehea_port_cb_6 *cb6 = NULL;
> +
> +	EDEB_EN(7, "net_device=%p", dev);
> +
> +	cb6 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
> +	if(!cb6) {
> +		EDEB_ERR(4, "No memory for cb6");
> +		goto stats_exit;
> +	}
> +
> +	hret = ehea_h_query_ehea_port(adapter->handle,
> +				      port->logical_port_id,
> +				      H_PORT_CB6,
> +				      H_PORT_CB6_ALL,
> +				      cb6);
> +
> +	if (hret != H_SUCCESS)
> +		EDEB_ERR(4, "query_ehea_port failed for cb6");
> +
> +	EDEB_DMP(7, (u8*)cb6,
> +		 sizeof(struct hcp_query_ehea_port_cb_6), "After HCALL");
> +	data[i++] = p_state->poll_max_processed;
> +	data[i++] = p_state->queue_stopped;
> +	data[i++] = p_state->min_swqe_avail;
> +	data[i++] = p_state->poll_receive_errors;
> +	data[i++] = p_state->pkt_send;
> +	data[i++] = p_state->pkt_xmit;
> +	data[i++] = p_state->send_tasklet;
> +	data[i++] = p_state->ehea_poll;
> +	data[i++] = p_state->nwqe;
> +	data[i++] = atomic_read(&port->port_res[0].swqe_avail);
> +
> +	data[i++] = cb6->rxo;
> +	data[i++] = cb6->rx64;
> +	data[i++] = cb6->rx65;
> +	data[i++] = cb6->rx128;
> +	data[i++] = cb6->rx256;
> +	data[i++] = cb6->rx512;
> +	data[i++] = cb6->rx1024;
> +	data[i++] = cb6->txo;
> +	data[i++] = cb6->tx64;
> +	data[i++] = cb6->tx65;
> +	data[i++] = cb6->tx128;
> +	data[i++] = cb6->tx256;
> +	data[i++] = cb6->tx512;
> +	data[i++] = cb6->tx1024;
> +
> +	kfree(cb6);
> +stats_exit:
> +	EDEB_EX(7, "");
> +}
> +
> +struct ethtool_ops ehea_ethtool_ops = {
> +	.get_settings = netdev_get_settings,
> +	.set_settings = netdev_set_settings,
> +	.get_drvinfo = netdev_get_drvinfo,
> +	.get_msglevel = netdev_get_msglevel,
> +	.set_msglevel = netdev_set_msglevel,
> +	.nway_reset = netdev_nway_reset,
> +	.get_link = ethtool_op_get_link,
> +	.get_pauseparam = netdev_get_pauseparam,
> +	.set_pauseparam = netdev_set_pauseparam,
> +	.get_rx_csum = netdev_get_rx_csum,
> +	.set_rx_csum = netdev_set_rx_csum,
> +	.get_tx_csum = ethtool_op_get_tx_csum,
> +	.set_tx_csum = ethtool_op_set_tx_csum,
> +	.get_sg = ethtool_op_get_sg,
> +	.set_sg = ethtool_op_set_sg,
> +	.get_tso = ethtool_op_get_tso,
> +	.set_tso = ethtool_op_set_tso,
> +	.self_test_count = netdev_self_test_count,
> +	.self_test = netdev_self_test,
> +	.get_strings = netdev_get_strings,
> +	.phys_id = netdev_phys_id,
> +	.get_stats_count = netdev_get_stats_count,
> +	.get_ethtool_stats = netdev_get_ethtool_stats
> +};
> +
> +void ehea_set_ethtool_ops(struct net_device *netdev)
> +{
> +	SET_ETHTOOL_OPS(netdev, &ehea_ethtool_ops);
> +}
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

I hope this helps...

Mikey
