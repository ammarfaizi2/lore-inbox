Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUCaWDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUCaWDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:03:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2766 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261684AbUCaWCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:02:18 -0500
Message-ID: <406B3FDA.9010507@pobox.com>
Date: Wed, 31 Mar 2004 17:02:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Boutcher <sleddog@us.ibm.com>
CC: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibmvscsi driver - sixth version
References: <opr3u0ffo7l6e53g@us.ibm.com> <20040225134518.A4238@infradead.org>  <opr3xta6gbl6e53g@us.ibm.com> <1079027038.2820.57.camel@mulgrave> <opr5qwiyw4l6e53g@us.ibm.com>
In-Reply-To: <opr5qwiyw4l6e53g@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Boutcher wrote:
> James,
> 
> Here is the next version of the ibmvscsi lldd.  I know you were waiting 
> for the fix that correctly checks for errors on the dma_map_foo calls, 
> which is included.  The other functional changes are to implement 
> device_reset, and to surface a bunch of adapter attributes through 
> shost_attrs.
> 
> This driver has been under test for the last couple of months, and is 
> scheduled to ship in a couple of distributions shortly.  There are a few 
> bug fixes included in this patch as well, mostly in the area of abort 
> processing and correctly handling edge conditions (freeing buffers in 
> error paths etc.)
> 
> Comments always welcomed.  I would like to get this upstream if I can, 
> since the linux distributors are complaining slightly that it is not.

Comments:

1) Would be nice to eliminate  module options for commands-per-lun, 
max-requests etc. and actually have the driver figure out the real 
needs.  One or two options could fall into the "performance tuning" 
category, and stay, but the others are really dependent on the 
underlying configuration and underlying limits.

2) why is one-descriptor a special case in map_sg_data()?  You proceed 
to do the same thing in a loop, right below that...  AFAICS you can just 
use the loop, and clamp the number of scatterlist elements to one.

3) in the following code...

+	if ((evt_struct->crq.format == VIOSRP_SRP_FORMAT) &&
+	    (atomic_dec_if_positive(&hostdata->request_limit) < 0)) {
+		printk("ibmvscsi: Warning, request_limit exceeded\n");
+		unmap_cmd_data(&evt_struct->evt->srp.cmd, hostdata->dev);
+		ibmvscsi_free_event_struct(&hostdata->pool, evt_struct);
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}

is the code prepared to deal with hostdata->request_limit being negative?

4) style: don't bother with unneeded brackets...

+	if (!evt_struct) {
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+

5) two issues with your abort handler...

+	spin_unlock_irq(hostdata->host->host_lock);
+	wait_for_completion(&evt->comp);
+	spin_lock_irq(hostdata->host->host_lock);

5a) are there recursion or deadlock issues, when you release the lock 
like this?

5b) IMO unconditional spin_{un}lock_irq() is unwise...  the 
->eh_abort_handler() saved the flags, so you might be restoring things 
to an incorrect state.

Since you're already inside spin_lock_irqsave(), and #5a is not an 
issue, just use spin_unlock() and spin_lock().

6) ditto ibmvscsi_eh_device_reset_handler

7) style: the names of many of the structures defined by this driver are 
IN ALL CAPS AND SHOUTING :)  Structs should not be in all caps.

8) purge_requests() locking looks bogus.  It is safe to complete a SCSI 
command inside the host lock.

9) ibmvscsi_do_host_config() continues, after a DMA mapping error

10) what the heck is this???  do some people not know they are running 
Linux???

+static ssize_t show_host_os_type(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct ibmvscsi_host_data *hostdata =
+	    (struct ibmvscsi_host_data *)shost->hostdata;
+	int len;
+
+	len = snprintf(buf, PAGE_SIZE, "%d\n", hostdata->madapter_info.os_type);
+	return len;
+}
+
+static struct class_device_attribute ibmvscsi_host_os_type = {
+	.attr = {
+		 .name = "os_type",
+		 .mode = S_IRUGO,
+		 },
+	.show = show_host_os_type,
+};
+


11) I'm not sure ".emulated = 1" is correct, since you are really 
talking SCSI.  But this is arguable, as is the value of 'emulated' flag 
itself...


12) in ibmvscsi_probe(), you want to use TASK_UNINTERRUPTIBLE here:

+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(5);

13) in the code pasted in #12, you should pass a value calculated using 
the 'HZ' constant.

14) why are you faking a PCI bus?  The following is very, very wrong:

+static struct pci_dev iseries_vscsi_dev = {
+	.dev.bus = &pci_bus_type,
+	.dev.bus_id = "vscsi",
+	.dev.release = noop_release

Did I mention "very" wrong?  :)


