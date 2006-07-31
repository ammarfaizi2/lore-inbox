Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWGaKLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWGaKLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWGaKLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:11:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:7896 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751330AbWGaKLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:11:34 -0400
Date: Mon, 31 Jul 2006 15:41:57 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Zach Brown <zach.brown@oracle.com>,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9_=3Csebastien=2Edugue=40bull=2Enet?=.=?iso-8859-1?Q?=3E?=@qubit.in.ibm.com,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
Message-ID: <20060731101157.GA10499@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru> <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com> <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686> <44C8DB80.6030007@us.ibm.com> <44C9029A.4090705@oracle.com> <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com> <44C90987.1040200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44C90987.1040200@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 11:44:23AM -0700, Ulrich Drepper wrote:
> Badari Pulavarty wrote:
> > Before we spend too much time cleaning up and merging into mainline -
> > I would like an agreement that what we add is good enough for glibc
> > POSIX AIO.
> 
> I haven't seen a description of the interface so far.  Would be good if

Did Sébastien's mail with the description help ? 

> it existed.  But I briefly mentioned one quirk in the interface about
> which Suparna wasn't sure whether it's implemented/implementable in the
> current interface.
> 
> If a lio_listio call is made the individual requests are handle just as
> if they'd be issue separately.  I.e., the notification specified in the
> individual aiocb is performed when the specific request is done.  Then,
> once all requests are done, another notification is made, this time
> controlled by the sigevent parameter if lio_listio.

Looking at the code in lio kernel patch, this should be already covered:

        if (iocb->ki_signo)
                __aio_send_signal(iocb);

+       if (iocb->ki_lio)
+               lio_check(iocb->ki_lio);

That is, it first checks the notification in the individual iocb, and then
the one for the LIO.

> 
> 
> Another feature which I always wanted: the current lio_listio call
> returns in blocking mode only if all requests are done.  In non-blocking
> mode it returns immediately and the program needs to poll the aiocbs.
> What is needed is something in the middle.  For instance, if multiple
> read requests are issued the program might be able to start working as
> soon as one request is satisfied.  I.e., a call similar to lio_listio
> would be nice which also takes another parameter specifying how many of
> the NENT aiocbs have to finish before the call returns.

I imagine the kernel could enable this by incorporating this additional
parameter for IOCB_CMD_GROUP in the ABI (in the default case this should be the
same as the total number of iocbs submitted to lio_listio). Now should the
at least NENT check apply only to LIO_WAIT or also to the LIO_NOWAIT
notification case ? 

BTW, the native io_getevents does support a min_nr wakeup already, except that
it applies to any iocb on the io_context, and not just a given lio_listio call.

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

