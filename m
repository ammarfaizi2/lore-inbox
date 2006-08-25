Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWHYNRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWHYNRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHYNRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:17:04 -0400
Received: from pat.uio.no ([129.240.10.4]:15520 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751253AbWHYNRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:17:01 -0400
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow 
	writeback.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Neil Brown <neilb@suse.de>
Cc: Jens Axboe <axboe@suse.de>, David Chinner <dgc@sgi.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <17646.32332.572865.919526@cse.unsw.edu.au>
References: <20060815230050.GB51703024@melbourne.sgi.com>
	 <17635.60378.733953.956807@cse.unsw.edu.au>
	 <20060816231448.cc71fde7.akpm@osdl.org>
	 <20060818001102.GW51703024@melbourne.sgi.com>
	 <20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de>
	 <p73hd0998is.fsf@verdi.suse.de> <17640.65491.458305.525471@cse.unsw.edu.au>
	 <20060821031505.GQ51703024@melbourne.sgi.com>
	 <17641.24478.496091.79901@cse.unsw.edu.au> <20060821135132.GG4290@suse.de>
	 <17646.32332.572865.919526@cse.unsw.edu.au>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 09:16:50 -0400
Message-Id: <1156511810.5575.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.933, required 12,
	autolearn=disabled, AWL 0.56, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 14:36 +1000, Neil Brown wrote:
> The 'bugs' I am currently aware of are:
>  - nfs doesn't put a limit on the request queue
>  - the ext3 journal often writes out dirty data without clearing
>    the Dirty flag on the page - so the nr_dirty count ends up wrong.
>    ext3 writes the buffers out and marks them clean.  So when
>    the VM tried to flush a page, it finds all the buffers are clean
>    and so marks the page clean, so the nr_dirty count eventually
>    gets correct again, but I think this can cause write throttling to
>    be very unfair at times.
> 
> I think we need a queue limit on NFS requests.....

That is simply not happening until someone can give a cogent argument
for _why_ it is necessary. Such a cogent argument must, among other
things, allow us to determine what would be a sensible queue limit. It
should also point out _why_ the filesystem should be doing this instead
of the VM.

Furthermore, I'd like to point out that NFS has a "third" state for
pages: following an UNSTABLE write the data on them is marked as
'uncommitted'. Such pages are tracked using the NR_UNSTABLE_NFS counter.
The question is: if we want to set limits on the write queue, what does
that imply for the uncommitted writes?
If you go back and look at the 2.4 NFS client, we actually had an
arbitrary queue limit. That limit covered the sum of writes+uncommitted
pages. Performance sucked, 'cos we were not able to use server side
caching efficiently. The number of COMMIT requests (causes the server to
fsync() the client's data to disk) on the wire kept going through the
roof as we tried to free up pages in order to satisfy the hard limit.
For those reasons and others, the filesystem queue limit was removed for
2.6 in favour of allowing the VM to control the limits based on its
extra knowledge of the state of global resources.

Trond

