Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbUCaXMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUCaXMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:12:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:12028 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262773AbUCaXMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:12:37 -0500
Date: Wed, 31 Mar 2004 17:12:13 -0600
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ibmvscsi driver - sixth version
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org
References: <opr3u0ffo7l6e53g@us.ibm.com> <20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com> <1079027038.2820.57.camel@mulgrave> <opr5qwiyw4l6e53g@us.ibm.com> <406B3FDA.9010507@pobox.com>
From: Dave Boutcher <sleddog@us.ibm.com>
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5q1enb6l6e53g@us.ibm.com>
In-Reply-To: <406B3FDA.9010507@pobox.com>
User-Agent: Opera7.23/Win32 M2 build 3227
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 17:02:02 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Comments:
>
> 1) Would be nice to eliminate  module options for commands-per-lun, 
> max-requests etc. and actually have the driver figure out the real 
> needs.  One or two options could fall into the "performance tuning" 
> category, and stay, but the others are really dependent on the 
> underlying configuration and underlying limits.
Hmmm...well, I could collapse the two together, since commands_per_lun
is not limited by anything specific for this adapter.  I would prefer
to leave them broken out to handle users who have extreme requirements.

> 2) why is one-descriptor a special case in map_sg_data()?  You proceed 
> to do the same thing in a loop, right below that...  AFAICS you can just 
> use the loop, and clamp the number of scatterlist elements to one.
The SRP spec has two different buffer formats: SRP_DIRECT_BUFFER for a
single buffer, and SRP_INDIRECT_BUFFER for lists of buffers, and the
layout of the buffers in the request is different for those two cases.

> 3) in the following code...
>
> +	if ((evt_struct->crq.format == VIOSRP_SRP_FORMAT) &&
> +	    (atomic_dec_if_positive(&hostdata->request_limit) < 0)) {
> +		printk("ibmvscsi: Warning, request_limit exceeded\n");
> +		unmap_cmd_data(&evt_struct->evt->srp.cmd, hostdata->dev);
> +		ibmvscsi_free_event_struct(&hostdata->pool, evt_struct);
> +		return SCSI_MLQUEUE_HOST_BUSY;
> +	}
>
> is the code prepared to deal with hostdata->request_limit being negative?
Yes....that is one of the things that would drive you down that path.
There are a couple of places in the code where request_limit is explicitly
set to -1 to force all requests to be rejected.

> 4) style: don't bother with unneeded brackets...
>
> +	if (!evt_struct) {
> +		return SCSI_MLQUEUE_HOST_BUSY;
> +	}
> +
Fair enough.

>
> 5) two issues with your abort handler...
>
> +	spin_unlock_irq(hostdata->host->host_lock);
> +	wait_for_completion(&evt->comp);
> +	spin_lock_irq(hostdata->host->host_lock);
>
> 5a) are there recursion or deadlock issues, when you release the lock 
> like this?
>
> 5b) IMO unconditional spin_{un}lock_irq() is unwise...  the 
> ->eh_abort_handler() saved the flags, so you might be restoring things 
> to an incorrect state.
>
> Since you're already inside spin_lock_irqsave(), and #5a is not an 
> issue, just use spin_unlock() and spin_lock().
OK, two issues.  There are a bunch of SCSI LLDDs that use this same
logic in abort and reset handlers to wait for adapter events to
complete, so I think the logic is OK.  The issue of spin_lock_irq
vs spin_lock is a good one...and points out that there are a bunch
of LLDDs that are broke :-)  I'll resubmit without the _irq

>
> 6) ditto ibmvscsi_eh_device_reset_handler

> 7) style: the names of many of the structures defined by this driver are 
> IN ALL CAPS AND SHOUTING :)  Structs should not be in all caps.
Ya, copied from less sane operating systems.  I'll fix.

> 8) purge_requests() locking looks bogus.  It is safe to complete a SCSI 
> command inside the host lock.
I'll fix.

> 9) ibmvscsi_do_host_config() continues, after a DMA mapping error
Oops.

> 10) what the heck is this???  do some people not know they are running 
> Linux???
> +static ssize_t show_host_os_type(struct class_device *class_dev, char 
> *buf)
This whole driver has to do with adapter sharing....and this answers
the question with whom you are sharing it.  Which may in fact NOT
be Linux.

> 11) I'm not sure ".emulated = 1" is correct, since you are really 
> talking SCSI.  But this is arguable, as is the value of 'emulated' flag 
> itself...
Agreed...I'll walk either side of the street on that one.

> 12) in ibmvscsi_probe(), you want to use TASK_UNINTERRUPTIBLE here:
>
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(5);
>
> 13) in the code pasted in #12, you should pass a value calculated using 
> the 'HZ' constant.
Hmmm...above code copied from the qlogic driver...and it looked reasonable
to me, but I'll tweak it.

> 14) why are you faking a PCI bus?  The following is very, very wrong:
>
> +static struct pci_dev iseries_vscsi_dev = {
> +	.dev.bus = &pci_bus_type,
> +	.dev.bus_id = "vscsi",
> +	.dev.release = noop_release
>
> Did I mention "very" wrong?  :)
Because for iseries it is implemented in the pci code.  While it may
look wrong, it is actually correct.  Check out
arch/ppc64/kernel/iSeries_iommu.c and arch/ppc64/kernel/dma.c.
This device has to have dev->bus == &pci_bus_type otherwise the
dma_mapping_foo functions won't work correctly.

Thanks for the comments!!!!!!!!!!!!!!

Dave B
