Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWD3Ma2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWD3Ma2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWD3Ma2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:30:28 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:38995 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750784AbWD3Ma1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:30:27 -0400
Message-ID: <4454ADD9.20909@voltaire.com>
Date: Sun, 30 Apr 2006 15:30:17 +0300
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
X-OriginalArrivalTime: 30 Apr 2006 12:30:25.0704 (UTC) FILETIME=[DB7AB280:01C66C51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hefty wrote:
>> +static int iser_free_device_ib_res(struct iser_device *device)
>> +{
>> +	BUG_ON(device->mr == NULL);
>> +
>> +	tasklet_kill(&device->cq_tasklet);
>> +
>> +	(void)ib_dereg_mr(device->mr);
>> +	(void)ib_destroy_cq(device->cq);
>> +	(void)ib_dealloc_pd(device->pd);
>> +
>> +	device->mr = NULL;
>> +	device->cq = NULL;
>> +	device->pd = NULL;
>> +	return 0;
>> +}
> 
> Can you eliminate the return code?

Yes

>> +static int iser_free_ib_conn_res(struct iser_conn *ib_conn)
>> +{
>> +	BUG_ON(ib_conn == NULL);
>> +
>> +	iser_err("freeing conn %p cma_id %p fmr pool %p qp %p\n",
>> +		 ib_conn, ib_conn->cma_id,
>> +		 ib_conn->fmr_pool, ib_conn->qp);
>> +
>> +	/* qp is created only once both addr & route are resolved */
>> +	if (ib_conn->fmr_pool != NULL)
>> +		ib_destroy_fmr_pool(ib_conn->fmr_pool);
>> +
>> +	if (ib_conn->qp != NULL)
>> +		rdma_destroy_qp(ib_conn->cma_id);
>> +
>> +	if (ib_conn->cma_id != NULL)
>> +		rdma_destroy_id(ib_conn->cma_id);

> Are the NULL checks needed above?  Neither iser_create_device_ib_res() or
> iser_create_ib_conn_res() set the values to NULL if an error occurred.

we are dealing here with connection resources so the (shared among ib 
conns) device resources are irrelevant. The ib conn struct is kzallec-ed 
on creation, where later iser_free_ib_conn_res() can be called when only 
a ***subset*** of the resources was allocated. Examples are instant 
error from rdma_addr_resolve() or getting ADDR/ROUTE ERROR vs. CONNECT 
ERROR cma events, in the first three cases only the cma id should be 
destroyed while on the latter there's a need to destroy the fmr pool and 
the qp.

>> +/**
>> + * based on the resolved device node GUID see if there already allocated
>> + * device for this device. If there's no such, create one.
>> + */
>> +static
>> +struct iser_device *iser_device_find_by_ib_device(struct rdma_cm_id *cma_id)
>> +{
>> +	struct list_head    *p_list;
>> +	struct iser_device  *device = NULL;
>> +
>> +	mutex_lock(&ig.device_list_mutex);
>> +
>> +	p_list = ig.device_list.next;
>> +	while (p_list != &ig.device_list) {
>> +		device = list_entry(p_list, struct iser_device, ig_list);
>> +		/* find if there's a match using the node GUID */
>> +		if (device->ib_device->node_guid == cma_id->device->node_guid)
>> +			break;
>> +	}
>> +
>> +	if (device == NULL) {
>> +		device = kzalloc(sizeof *device, GFP_KERNEL);
>> +		if (device == NULL)
>> +			goto end;

> goto out;  // see below

>> +		/* assign this device to the device */
>> +		device->ib_device = cma_id->device;
>> +		/* init the device and link it into ig device list */
>> +		if (iser_create_device_ib_res(device)) {
>> +			kfree(device);
>> +			device = NULL;
>> +			goto end;
>> +		}
>> +		list_add(&device->ig_list, &ig.device_list);
>> +	}
>> +end:
>> +	BUG_ON(device == NULL);
>> +	device->refcount++;
> 
> out:

OK

Or.

