Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264429AbUEYBtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUEYBtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 21:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUEYBtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 21:49:14 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:55224 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264429AbUEYBtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 21:49:12 -0400
From: "braam" <braam@clusterfs.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <torvalds@osdl.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: RE: [PATCH/RFC] Lustre VFS patch
Date: Tue, 25 May 2004 09:48:37 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRBhNSCy6zHsuEvRIutYE8iOKWKwQAdCzKw
In-Reply-To: <20040524114650.GV1952@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <20040525014902.245C8310127@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

We use this patch on servers as follows. 

Lustre servers give an immediate response for RPC's to clients, and later
indicate what transactions numbers have been committed to disk. At known
points in the execution we sync all transactions to disk, execute our ioctl.
When the ioctl is issues Lustre is also instructed not to send disk commit
confirmation to clients. Then the system continues to execute some
transactions, but only in memory, and send responses to clients.   We are
sure they are lost if we powercycle that system.  This enables tests for
replay of transactions by client nodes in the cluster.

If we were to return errors, (which, I agree, _seems_ much more sane, and we
_did_ try that for a while!) then there is a good chance, namely immediately
when something is flushed to disk, that the system will detect the errors
and not continue to execute transactions making consistent testing of our
replay mechanisms impossible.

I hope that this explains why we do not return errors.  Now if you tell me
that I can turn off I/O, and not get errors, with existing ioctls then I
certainly should existing ioctls. Can you clarify that.

Am I making sense to you now?

- Peter -


> -----Original Message-----
> From: Jens Axboe [mailto:axboe@suse.de] 
> Sent: Monday, May 24, 2004 7:47 PM
> To: Peter J. Braam
> Cc: torvalds@osdl.org; akpm@osdl.org; 
> linux-kernel@vger.kernel.org; 'Phil Schwan'
> Subject: Re: [PATCH/RFC] Lustre VFS patch
> 
> On Mon, May 24 2004, Peter J. Braam wrote:
> > dev_read_only-vanilla-2.6.patch
> >  
> >   This introduces an ioctl on block devices to stop doing I/O. The
> >   only purpose of the patch is automated recovery 
> regression testing,
> >   it is very convenient to have this available.
> 
> You still keep pushing this on, without having clarified why 
> you can't just use the genhd functions for this instead of 
> adding some array of block_devices. And while you fixed the 
> bio->bi_rw check, you still don't indicate error when you 
> call bio_endio() for this case. So submitter of that io 
> thinks it completes successfully, while you just tossed it away.
> Irk.
> 
> --
> Jens Axboe
> 

