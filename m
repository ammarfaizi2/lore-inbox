Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWEOUvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWEOUvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWEOUvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:51:52 -0400
Received: from xenotime.net ([66.160.160.81]:27330 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932072AbWEOUvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:51:52 -0400
Date: Mon, 15 May 2006 13:54:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
       MEDER@de.ibm.com, schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 14/16] ehca: queue page table handling
Message-Id: <20060515135419.f77a1d8b.rdunlap@xenotime.net>
In-Reply-To: <4468BDAD.3020701@de.ibm.com>
References: <4468BDAD.3020701@de.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 19:43:09 +0200 Heiko J Schick wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   drivers/infiniband/hw/ehca/ipz_pt_fn.c |  177 ++++++++++++++++++++++
>   drivers/infiniband/hw/ehca/ipz_pt_fn.h |  254 +++++++++++++++++++++++++++++++++
>   2 files changed, 431 insertions(+)
> 
> 
> 
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ipz_pt_fn.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ipz_pt_fn.h	2006-05-12 12:25:43.000000000 +0200
> @@ -0,0 +1,254 @@

> +/*  return current Queue Page , increment Queue Page iterator from
> + *   page to page in struct ipz_queue, last increment will return 0! and
> + *   NOT wrap
> + *   returns address (kv) of Queue Page
> + *   warning don't use in parallel with ipz_QE_get_inc()
> + */

When not using kernel-doc format... the preferred multi-line
comment format is:

/*
 * foo foo foo ........
 * bar bar bar .......
 * blahz ..........
 */

repeat below.

> +void *ipz_qpageit_get_inc(struct ipz_queue *queue);
> +
> +/*  return current Queue Entry, increment Queue Entry iterator by one
> + *   step in struct ipz_queue, will wrap in ringbuffer
> + *   @returns address (kv) of Queue Entry BEFORE increment
> + *   warning don't use in parallel with ipz_qpageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + */
> +static inline void *ipz_qeit_get_inc(struct ipz_queue *queue)
> +{
> +	void *ret = NULL;
> +
> +	ret = ipz_qeit_get(queue);
> +	queue->current_q_offset += queue->qe_size;
> +	if (queue->current_q_offset >= queue->queue_length) {
> +		queue->current_q_offset = 0;
> +		/* toggle the valid flag */
> +		queue->toggle_state = (~queue->toggle_state) & 1;
> +	}
> +
> +	EDEB(7, "queue=%p ret=%p new current_q_addr=%lx qe_size=%x",
> +	     queue, ret, queue->current_q_offset, queue->qe_size);
> +
> +	return ret;
> +}
> +
> +/*  return current Queue Entry, increment Queue Entry iterator by one
> + *   step in struct ipz_queue, will wrap in ringbuffer
> + *   returns address (kv) of Queue Entry BEFORE increment
> + *   returns 0 and does not increment, if wrong valid state
> + *   warning don't use in parallel with ipz_qpageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + */
> +static inline void *ipz_qeit_get_inc_valid(struct ipz_queue *queue)
> +{
> +	struct ehca_cqe *cqe = ipz_qeit_get(queue);
> +	u32 cqe_flags = cqe->cqe_flags;
> +
> +	if ((cqe_flags >> 7) != (queue->toggle_state & 1))
> +		return NULL;
> +
> +	ipz_qeit_get_inc(queue);
> +	return cqe;
> +}
> +

> +/* destructor for a ipz_queue_t
> + *  -# free queue
> + *  see ipz_queue_ctor()
> + *  returns true if ok, false if queue was NULL-ptr of free failed
> + */
> +int ipz_queue_dtor(struct ipz_queue *queue);
> +
> +/* constructor for a ipz_qpt_t,
> + * placement new for struct ipz_queue, new for all dependent datastructors
> + *
> + *  all QP Tables are the same,
> + *  flow:
> + *  -# allocate+pin queue
> + *  -# initialise ptcb
> + *  -# allocate+pin PTs
> + *  -# link PTs to a ring, according to HCA Arch, set bit62 id needed
> + *  -# the ring must have room for exactly nr_of_PTEs
> + *  see ipz_qpt_ctor()
> + */
> +void ipz_qpt_ctor(struct ipz_qpt *qpt,
> +		  const u32 nr_of_QEs,
> +		  const u32 pagesize,
> +		  const u32 qe_size,
> +		  const u8 lowbyte, const u8 toggle,
> +		  u32 * act_nr_of_QEs, u32 * act_nr_of_pages);
> +
> +/*  return current Queue Entry, increment Queue Entry iterator by one
> + *   step in struct ipz_queue, will wrap in ringbuffer
> + *   returns address (kv) of Queue Entry BEFORE increment
> + *   warning don't use in parallel with ipz_qpageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + *
> + *   fix EQ page problems
> + */
> +void *ipz_qeit_eq_get_inc(struct ipz_queue *queue);
> +
> +/*  return current Event Queue Entry, increment Queue Entry iterator
> + *   by one step in struct ipz_queue if valid, will wrap in ringbuffer
> + *   returns address (kv) of Queue Entry BEFORE increment
> + *   returns 0 and does not increment, if wrong valid state
> + *   warning don't use in parallel with ipz_queue_QPageit_get_inc()
> + *   warning unpredictable results may occur if steps>act_nr_of_queue_entries
> + */
> +static inline void *ipz_eqit_eq_get_inc_valid(struct ipz_queue *queue)
> +{
> +	void *ret = ipz_qeit_get(queue);
> +	u32 qe = *(u8 *) ret;
> +	EDEB(7, "ipz_QEit_EQ_get_inc_valid qe=%x", qe);
> +	if ((qe >> 7) == (queue->toggle_state & 1))
> +		ipz_qeit_eq_get_inc(queue); /* this is a good one */
> +	else
> +		ret = NULL;
> +	return ret;
> +}


---
~Randy
