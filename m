Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRDJRK6>; Tue, 10 Apr 2001 13:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDJRKj>; Tue, 10 Apr 2001 13:10:39 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:18195 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129143AbRDJRKb>; Tue, 10 Apr 2001 13:10:31 -0400
Message-Id: <200104101710.f3AHAHs34083@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix scsi_unblock_requests() 
In-Reply-To: Your message of "Tue, 10 Apr 2001 17:06:26 BST."
             <E14n0ey-0004W9-00@the-village.bc.nu> 
Date: Tue, 10 Apr 2001 11:10:16 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In its current implementation, scsi_unblock_requests() simply
>> clears host_self_blocked in the SCSI host struct.  This means
>> that either a transaction must complete or a new transaction
>
>Suppose the queue is unblocked from inside the functions called to process
>the request. In that situation the old code is correct and your code might
>introduce other problems

Re-entrancy is only prevented by holding the io-request lock or in
some cases a per-controller or per-controller driver lock.
As the comment in scsi_unblock_requests() states, this API assumes
that no locks are held.  If you hold a lock in calling this routine,
you may deadlock.

>> unblocks.  scsi_queue_next_request() verifies all other state
>> to ensure queuing new transactions is safe prior to proceeding.
>
>Including recursion ?

I suppose a poorly implemented use of this API could tail recurse.
The aic7xxx driver calls this routine from a timeout handler so
there is no risk of stack explosion.

>The patch seems right apart from checking these details out further. 

Well, the patch was written to have minimal impact to an API that
has never been used.  A more correct solution might be to queue the
affected host controller to a queue drained by a bottom-half handler.

--
Justin
