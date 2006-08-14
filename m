Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWHNHBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWHNHBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWHNHBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:01:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33689 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751907AbWHNHB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:01:29 -0400
Date: Mon, 14 Aug 2006 12:32:10 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: sebastien.dugue@bull.net, Badari Pulavarty <pbadari@us.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, linux-aio@kvack.org, mingo@elte.hu
Subject: Re: Kernel patches enabling better POSIX AIO (Was Re: [3/4] kevent: AIO, aio_sendfile)
Message-ID: <20060814070210.GA27005@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1153982954.3887.9.camel@frecb000686> <44C8DB80.6030007@us.ibm.com> <44C9029A.4090705@oracle.com> <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com> <44C90987.1040200@redhat.com> <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com> <1154091500.13577.14.camel@frecb000686> <44DCDE73.9030901@redhat.com> <20060812182928.GA1989@in.ibm.com> <44DE27AB.7040507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44DE27AB.7040507@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 12:10:35PM -0700, Ulrich Drepper wrote:
> Suparna Bhattacharya wrote:
> > I am wondering about that too. IIRC, the IO_NOTIFY_* constants are not
> > part of the ABI, but only internal to the kernel implementation. I think
> > Zach had suggested inferring THREAD_ID notification if the pid specified
> > is not zero. But, I don't see why ->sigev_notify couldn't used directly
> > (just like the POSIX timers code does) thus doing away with the 
> > new constants altogether. Sebestian/Laurent, do you recall?
> 
> I suggest to model the implementation after the timer code which does
> exactly what we need.

Agreed.

> 
> 
> > I'm guessing they are being used for validation of permissions at the time
> > of sending the signal, but maybe saving the task pointer in the iocb instead
> > of the pid would suffice ?
> 
> Why should any verification be necessary?  The requests are generated in
> the same process which will receive the notification.  Even if the POSIX
> process (aka, kernel process group) changes the IDs the notifications
> should be set.  The key is that notifications cannot be sent to another
> POSIX process.

Is there a (remote) possibility that the thread could have died and its
pid got reused by a new thread in another process ? Or is there a mechanism
that prevents such a possibility from arising (not just in NPTL library,
but at the kernel level) ?

I think the timer code saves a reference to the task pointer instead of
the pid, which is what I was suggesting above (instead of the euid checks),
as way to avoid the above situation.

> 
> Adding this as a feature just makes things so much more complicated.
> 
> 
> > So I think the
> > intended behaviour is as you describe it should be
> 
> Then the documentation needs to be adjusted.

*Nod*

> 
> 
> > The way it works (and better ideas are welcome) is that, since the io_submit()
> > syscall already accepts an array of iocbs[], no new syscall was introduced.
> > To implement lio_listio, one has to set up such an array, with the first iocb
> > in the array having the special (new) grouping opcode of IOCB_CMD_GROUP which
> > specifies the sigev notification to be associated with group completion
> > (a NULL value of the sigev notification pointer would imply equivalent of
> > LIO_WAIT).
> 
> OK, this seems OK.  We have to construct the iocb arrays dynamically anyway.
> 
> 
> > My thought here was that it should be possible to include M as a parameter
> > to the IOCB_CMD_GROUP opcode iocb, and thus incorporated in the lio control
> > block ... then whatever semantics are agreed upon can be implemented.
> 
> If you have room for the parameter this is fine.  For the beginning we
> can enforce the number to be the same as the total number of requests.
> 

Sounds good.

> 
> > Let us know what you think about the listio interface ... hopefully the
> > other issues are mostly simple to resolve.
> 
> It should be fine and I would support adding all this assuming the
> normal file support (as opposed to direct I/O only) is added, too.

OK. I updated my patchset against 2618-rc3 just after OLS.

> 
> 
> But I have one last question: sockets, pipes and the like are already
> supported, right?  If this is not the case we have a problem with the
> currently proposed  lio_listio interface.

AIO for pipes should not be a problem - Chris Mason had a patch, so we can
just bring it up to the current levels, possibly with some additional
improvements.

I'm not sure what would be the right thing to do for the sockets case. While
we could put together a patch for basic aio_read/write (based on the same
model used for files), given the whole ongoing kevent effort, its not yet
clear to me what would make the most sense ...  

Ben had a patch to do a fallback to kernel threads for AIO operations that
are not yet supported natively. I had some concerns about the approach, but
I guess he had intended it as an interim path for cases like this.

Suggestions would be much appreciated ?  DaveM, Ingo, Andrew ?

Regards
Suparna

> 
> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
> 



-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

