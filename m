Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbTLQX7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTLQX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:59:40 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:34322
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S264870AbTLQX7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:59:37 -0500
Date: Wed, 17 Dec 2003 15:59:10 -0800
From: Brad Boyer <flar@allandria.com>
To: jshankar <jshankar@CS.ColoState.EDU>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Mike Fedyk <mfedyk@matchmail.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 file system
Message-ID: <20031217235910.GA29489@pants.nu>
References: <3FF18FD8@webmail.colostate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF18FD8@webmail.colostate.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think the big thing that you're missing is that block device requests
are totally asynchronous. In general, a block gets sent down to the
block layer as needing to be transfered one way or the other. It gets
queued up in the driver for that block device, such as sd.o for SCSI.
That driver will be notified that it has requests to process, and
can handle them however it wants. When it is done with any specific
request, it calls back up and sets that request as done. You could
have multiple requests in the queue at the same time, and a driver
can be working on more than one at a time if it supports that.

In the specific case of SCSI, the host adapter and disk drives may
support various queues along the way, with any number of outstanding
requests in various buffers. The controller may be able to merge
requests on the fly in order to improve performance.

Obviously this is a fairly abstract view of the whole process. For
details you would need to read the code. You can trace the process
down (filesystem -> page buffers -> block devices -> block driver).
In the SCSI case, the block driver is sd.o, and you then can follow
down into the generic SCSI mid-layer and the controller driver.

	Brad Boyer
	flar@allandria.com

On Wed, Dec 17, 2003 at 04:25:11PM -0700, jshankar wrote:
> Please provide some more insight.
> 
> Suppose a filesystem issues a write command to the disk with around 10 4K 
> Blocks  to be written. SCSI device point of view i don't get what is the 
> parallel I/O.
> It has only 1 write command. If some other sends a write request it needs to 
> be queued. But the next question arises how the write data would be handled. 
> Does it mean the SCSI does not give a response for the block of data written. 
> In otherwords does it mean that the response would be given after all the 
> block of data is written for a single write request.
