Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVEZTt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVEZTt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVEZTtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:49:35 -0400
Received: from mail.dvmed.net ([216.237.124.58]:14811 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261714AbVEZTtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:49:11 -0400
Message-ID: <42962833.4000000@pobox.com>
Date: Thu, 26 May 2005 15:49:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050526170658.GT1419@suse.de>
In-Reply-To: <20050526170658.GT1419@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, May 26 2005, Jeff Garzik wrote:
>>>+int ata_read_log_page(struct ata_port *ap, unsigned int device, char page,
>>>+		      char *buffer, unsigned int sectors)
>>>+{
>>>+	struct ata_device *dev = &ap->device[device];
>>>+	DECLARE_COMPLETION(wait);
>>>+	struct ata_queued_cmd *qc;
>>>+	unsigned long flags;
>>>+	u8 status;
>>>+	int rc;
>>>+
>>>+	assert(dev->class == ATA_DEV_ATA);
>>>+
>>>+	ata_dev_select(ap, device, 1, 1);
>>
>>is this needed?  These types of calls need to be removed, in general, as 
>>they don't make sense on FIS-based hardware at all.
> 
> 
> You tell me, this read_log_page() was mainly copy-pasted from the pio
> driven function above it. I'll try and kill the select when doing error
> testing.
> 
> 
>>>+	printk("RLP issue\n");
>>>+	spin_lock_irqsave(&ap->host_set->lock, flags);
>>>+	rc = ata_qc_issue(qc);
>>>+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
>>>+	printk("RLP issue done\n");
>>>+
>>>+	if (rc)
>>>+		return -EIO;
>>>+
>>>+	wait_for_completion(&wait);
>>>+
>>>+	printk("RLP wait done\n");
>>>+
>>>+	status = ata_chk_status(ap);
>>>+	if (status & (ATA_ERR | ATA_ABORTED))
>>>+		return -EIO;
>>
>>we need to get rid of this too for AHCI-like devices
> 
> 
> Can you expand on that?

(this covers both quoted questions above)

The PIO function assumes that PCI IDE-like ATA register blocks (command 
registers, control registers) are available.  The read-log-page function 
can make no such assumptions.

dev-select and check-status should both be done by the machinery that 
occurs once you start things in motion by calling ata_qc_issue().

Doing things this way is necessary for FIS-based hardware like AHCI or 
SiI 3124.


>>>#ifdef CONFIG_PCI
>>>EXPORT_SYMBOL_GPL(pci_test_config_bits);
>>>Index: drivers/scsi/libata-scsi.c
>>>===================================================================
>>>--- f5c58b6b0cfd2a92fb3b1d1f4cbfdfb3df6f45d6/drivers/scsi/libata-scsi.c  
>>>(mode:100644)
>>>+++ uncommitted/drivers/scsi/libata-scsi.c  (mode:100644)
>>>@@ -336,6 +336,7 @@
>>>	if (sdev->id < ATA_MAX_DEVICES) {
>>>		struct ata_port *ap;
>>>		struct ata_device *dev;
>>>+		int depth;
>>>
>>>		ap = (struct ata_port *) &sdev->host->hostdata[0];
>>>		dev = &ap->device[sdev->id];
>>>@@ -353,6 +354,13 @@
>>>			 */
>>>			blk_queue_max_sectors(sdev->request_queue, 2048);
>>>		}
>>>+
>>>+		if (dev->flags & ATA_DFLAG_NCQ) {
>>>+			int ddepth = ata_id_queue_depth(dev->id) + 1;
>>>+
>>>+			depth = min(sdev->host->can_queue, ddepth);
>>>+			scsi_adjust_queue_depth(sdev, MSG_ORDERED_TAG, 
>>>depth);
>>
>>For all hardware that uses SActive (all NCQ), the max is 31 not 32.
> 
> 
> That's not true, the max is 32 counting 0 as a valid tag. So 31 is
> indeed th max tag value, but 32 is the depth.

I was talking about depth.  In libata, it's a policy decision to never 
use more than 31 tags at any given time.

You can change it from 31 to 32 in SuSE for value-add, if you wish :)

Note also that error handling occasionally needs a command slot, so the 
limit may even be 30 (or 31 at most).



> The two depths were added because we need to differentiate between the
> two for issuing new commands. ncq_depth > 0 is fine for issuing a new
> FPDMA request, where as non-FPDMA commands need both !ncq_depth and
> !depth.

You can definitely handle both FPDMA and non-FPDMA with a single 
variable.  Think harder on this one.  You have flags to work with, you 
know...

	Jeff


