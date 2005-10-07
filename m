Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbVJGQ5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbVJGQ5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbVJGQ5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:57:23 -0400
Received: from pat.qlogic.com ([198.70.193.2]:39778 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1030506AbVJGQ5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:57:22 -0400
Date: Fri, 7 Oct 2005 09:57:17 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add sysfs to dynamically control blk request tag maintenance
Message-ID: <20051007165717.GB8370@plap.qlogic.org>
References: <B05667366EE6204181EABE9C1B1C0EB5086AEC33@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB5086AEC33@scsmsx401.amr.corp.intel.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 07 Oct 2005 16:57:18.0139 (UTC) FILETIME=[2CF3A0B0:01C5CB60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2005, Chen, Kenneth W wrote:

> Jens Axboe wrote on Friday, October 07, 2005 1:08 AM
> > > It's probably a very small number that I'm chasing with avoiding blk
> > > layer tagging.  Nevertheless, any number no matter how small, is a
> gold
> > > mine to me :-)
> > > 
> > > Latest execution profile taken with 2.6.14-rc2 kernel with "industry
> > > standard transaction processing database workload".  First column is
> > > clock ticks (a direct measure of time), 2nd column is instruction
> > > retired,
> > > and 3rd column is number of L3 misses occurred inside the function.
> > > 
> > > Symbol			Clockticks	Inst. Retired	L3
> Misses
> > > scsi_request_fn		8.12%	9.27%	11.18%
> > > Schedule			6.52%	4.93%	7.26%
> > > scsi_end_request		4.44%	3.59%	6.76%
> > > __blockdev_direct_IO	4.28%	4.38%	3.98%
> > > __make_request		3.59%	4.16%	3.47%
> > > __wake_up			2.46%	1.56%	3.33%
> > > dio_bio_end_io		2.14%	1.67%	3.18%
> > > aio_complete		2.05%	1.27%	3.56%
> > > kmem_cache_free		1.95%	1.70%	0.71%
> > > kmem_cache_alloc		1.45%	1.84%	0.45%
> > > put_page			1.42%	0.60%	1.27%
> > > follow_hugetlb_page	1.41%	0.75%	1.27%
> > > __generic_file_aio_read	1.37%	0.36%	1.68%
> > 
> > The above looks pretty much as expected. What change in profile did
> you
> > see when eliminating the blk_queue_end_tag() call?
> 
> I haven't make any measurement yet.  The original patch was an RFC, and
> I want to hear opinions from the experts first.  I will do a measurement
> with the change in qla2x00 driver and I will let you know how much
> difference does it make.  Most likely, clock ticks in scsi_request_fn
> and
> scsi_end_request should be reduced.  It will be interesting to see L3
> misses stats as well.

Yes, please let us know what your benchmarking measurements show.  I
take it you are planning on doing something like:

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1101,10 +1101,7 @@ qla2xxx_slave_configure(struct scsi_devi
 	scsi_qla_host_t *ha = to_qla_host(sdev->host);
 	struct fc_rport *rport = starget_to_rport(sdev->sdev_target);
 
-	if (sdev->tagged_supported)
-		scsi_activate_tcq(sdev, 32);
-	else
-		scsi_deactivate_tcq(sdev, 32);
+	scsi_adjust_queue_depth(sdev, scsi_get_tag_type(sdev), depth);
 
 	rport->dev_loss_tmo = ha->port_down_retry_count + 5;
 



Thanks,
Andrew Vasquez
