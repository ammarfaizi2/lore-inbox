Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUCBTPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUCBTPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:15:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63619 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261742AbUCBTPF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:15:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Subject: Re: AIO Oops on 2.6.3-mm3
Date: Tue, 2 Mar 2004 11:09:03 -0800
User-Agent: KMail/1.4.1
Cc: Tobias Diedrich <ranma@gmx.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
References: <20040228024815.GA2835@melchior.yamamaya.is-a-geek.org> <200403020954.44886.pbadari@us.ibm.com> <1078253824.3632.4.camel@ibm-c.pdx.osdl.net>
In-Reply-To: <1078253824.3632.4.camel@ibm-c.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403021109.03994.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 March 2004 10:57 am, Daniel McNeil wrote:
> I fixed reference counting when the i/o completed before the
> submit path was done referencing the iocb.  This looks
> similar except it is getting a fault. 

I wonder whats different here. Even in this case, IO did complete
with EFAULT. 

Just for argument, if the IO completed correctly (without errors) -
how would it not run into this ? io_submit_one() will call
aio_complete() is the return code is NOT -EIOCBQUEUED.
Isn't it ? How do we prevent calling aio_complete() twice ?

Thanks,
Badari



> > I found the problem.. But no fix yet !!
> >
> > Here is whats happening..
> >
> > io_submit_one() :
> >
> > 	gets iocb with 2 refs
> > 	calls file->f_op->aio_write() which returns EFAULT...
> > 		This calls aio_complete() with EFAULT. aio_complete() drops a ref.
> > 	calls  aio_put_req() which drops a ref - since the count is
> > 			zero it frees iocb.
> > 	Since we got EFAULT, io_submit_one() calls aio_complete()
> > 			with freed up iocb - so we get OOPS.
> >
> > The problem here is we are calling aio_complete() twice.
> >
> > Daneil, didn't you fix this earlier ?
> >
> > int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
> > {
> >
> > 	...
> > 	 req = aio_get_req(ctx);         /* returns with 2 references to req */
> > 	..
> > 	case IOCB_CMD_PWRITE:
> > 		...
> > 		ret = file->f_op->aio_write(req, buf,
> >                                         iocb->aio_nbytes, req->ki_pos);
> > 	...
> > 	aio_put_req(req);       /* drop extra ref to req */
> >         if (likely(-EIOCBQUEUED == ret))
> >                 return 0;
> >         aio_complete(req, ret, 0);      /* will drop i/o ref to req */
> >         return 0;
> > 	....
> >
> > }
> >
> >
> >
> > Thanks,
> > Badari

