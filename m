Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTKESjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTKESjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:39:40 -0500
Received: from [198.70.193.2] ([198.70.193.2]:51243 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S263106AbTKESj3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:39:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Date: Wed, 5 Nov 2003 10:39:32 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B060ED64@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Thread-Index: AcOjfRfiD4xAR99YRv+b5lOkDGY5UQARu1XQ
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Mike Anderson" <andmike@us.ibm.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 05 Nov 2003 18:39:33.0277 (UTC) FILETIME=[27CAE4D0:01C3A3CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

> > A new version of the 8.x series driver for Linux 2.6.x kernels has
> > been uploaded to SourceForge:
> 
> Thanks for the update.
> 
> Can you give more information on why clustering was turned off
> starting in b5?
> 

This change was part of a relatively large performance-patch that was
originally against the 6.x series driver.  There were two main reasons
for disabling clustering support:

	o Given the ability of the ISP to efficiently DMA to and from
	  a significant number of data segment descriptors (via
	  command/continuation type IOCBs), there were some questions
	  regarding the benefits that clustering provided given the
	  overhead incurred by the mid-layer attempting merge the
	  requests.

	o Given the ISPs inability to handle data segments that cross
	  32-bit page boundaries, and the overhead in defensive logic
	  within the driver to prevent these cases (compare the 6.x
	  code to the 8.x code and you will see what I mean), by
	  disabling clustering we guarantee that a single SG element
	  never crosses a 4GB boundary.

Now, in 2.6 there are some significant changes.  For one, with the
block layer rewrite and the ability to limit segment boundaries of a
block queue request with the blk_queue_segment_boundary() call, a LLDD
need not concern itself with any defensive fast-path logic to handle
the 4GB cross.

So, we're left with the benefits of the overhead of this merge process
done by the block layer.  I'm certainly receptive to the notion of
reexamining the use of clustering given some solid data points showing
an (significant -- this is subjective) increase in performance and/or a
resounding 'yeah, enable it!' from those in the block-layer 'know.'

Regards,
Andrew Vasquez
