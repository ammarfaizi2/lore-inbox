Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUFQOI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUFQOI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUFQOI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:08:56 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:26569 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266506AbUFQOIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:08:52 -0400
Subject: Proposal for new generic device API: dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 17 Jun 2004 09:08:51 -0500
Message-Id: <1087481331.2210.27.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background:

We have a large number of devices in scsi: aacraid, aic7xxx, qla1280,
qla2xxx which can all do full 64 bit DMA, but which pay a performance
penalty for using the larger descriptors (aic7xxx is stranger in that it
has three modes of operation: 32 bit, 39 bit and 64 bit each with an
increasing performance penalty).

What all these devices would like to do is instead of simply trying the
64 bit mask first and having the platform accept it, even if it only has
< 4GB of memory, they'd like to be able to have the platform tell them,
given my current dma mask setting, what's the actual number of bits you
need me to DMA to.

This is precisely what the API would do.  It would return a bit mask
(never over the current dma_mask) that the platform considers optimal. 
The platform has complete freedom in this: it may return a mask covering
the total physical memory, or a mask covering all the bits it needs
setting for some weird numa scheme.

If the driver decides to use the mask, it would do another
dma_set_mask() to confirm it (this gives the platform the opportunity if
it so chooses to return a mask that doesn't quite cover memory, but
would be more optimal...say for platforms that have all memory under 4GB
bar one small chunk at 64GB or something).

Once the driver has the platform's optimal mask, it can use this to
decide on the correct descriptor size.

Comments?

James



