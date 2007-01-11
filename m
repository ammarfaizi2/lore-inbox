Return-Path: <linux-kernel-owner+w=401wt.eu-S1751426AbXAKT3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbXAKT3p (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbXAKT3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:29:45 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56760 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbXAKT3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:29:44 -0500
Date: Thu, 11 Jan 2007 11:29:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Reed <mdr@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Zach Brown'" <zach.brown@oracle.com>,
       "'Chris Mason'" <chris.mason@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeremy Higdon <jeremy@sgi.com>, David Chinner <dgc@sgi.com>
Subject: Re: [patch] optimize o_direct on block device - v3
Message-Id: <20070111112901.28085adf.akpm@osdl.org>
In-Reply-To: <45A68E55.10601@sgi.com>
References: <000101c7198d$9a9fde40$ff0da8c0@amr.corp.intel.com>
	<45A68E55.10601@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 13:21:57 -0600
Michael Reed <mdr@sgi.com> wrote:

> Testing on my ia64 system reveals that this patch introduces a
> data integrity error for direct i/o to a block device.  Device
> errors which result in i/o failure do not propagate to the
> process issuing direct i/o to the device.
> 
> This can be reproduced by doing writes to a fibre channel block
> device and then disabling the switch port connecting the host
> adapter to the switch.
> 

Does this fix it?

<thwaps Ken>
<thwaps compiler>
<adds new entry to Documentation/SubmitChecklist>

diff -puN fs/block_dev.c~a fs/block_dev.c
--- a/fs/block_dev.c~a
+++ a/fs/block_dev.c
@@ -146,7 +146,7 @@ static int blk_end_aio(struct bio *bio, 
 		iocb->ki_nbytes = -EIO;
 
 	if (atomic_dec_and_test(bio_count)) {
-		if (iocb->ki_nbytes < 0)
+		if ((long)iocb->ki_nbytes < 0)
 			aio_complete(iocb, iocb->ki_nbytes, 0);
 		else
 			aio_complete(iocb, iocb->ki_left, 0);
_


