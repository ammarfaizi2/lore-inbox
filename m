Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVEPMMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVEPMMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVEPMMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:12:30 -0400
Received: from ns.suse.de ([195.135.220.2]:32988 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261568AbVEPMMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:12:25 -0400
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: finding out whether a device supports ordered writes ahead of time
Date: Mon, 16 May 2005 08:12:13 -0400
User-Agent: KMail/1.8
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
References: <20050516112722.GA9736@lst.de>
In-Reply-To: <20050516112722.GA9736@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505160812.15362.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 07:27, Christoph Hellwig wrote:
> Currently ext3 and reiserfs submit bios with BIO_RW_BARRIER and when the
> device doesn't support it it returns EOPNOTUPP.  This scheme doesn't
> work at all for XFS because our I/O submission path keeps around far too
> much state (XFS supports multi-page metadata buffers).  From looking at
> the code it seems that we can assume such a submission will just work
> if q->ordered is not QUEUE_ORDERED_NONE.  Is that a valid assumption?
> and if yes should we look directly at the queue or provide an assecor?

I think Jens currently has things set to trust the drive's advertisement of 
the cache flush feature.  But I don't think we've looked hard for drives that 
advertise and then fail the barriers, it wouldn't surprise me if one existed.

What you could do is issue a barrier write during mount to test things.  If 
that works any failed barrier later could be considered an io error.  Don't 
use blkdev_issue_flush for this, since it will work on scsi drives that don't 
support the BIO_RW_BARRIER.

-chris
