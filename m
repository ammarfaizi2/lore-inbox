Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266345AbSISLbp>; Thu, 19 Sep 2002 07:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266469AbSISLbp>; Thu, 19 Sep 2002 07:31:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:23771 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266345AbSISLbo>;
	Thu, 19 Sep 2002 07:31:44 -0400
Date: Thu, 19 Sep 2002 17:06:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async
Message-ID: <20020919170618.B2285@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <200209181630.g8IGUGe15097@eng2.beaverton.ibm.com> <200209182047.g8IKl6T27992@eng2.beaverton.ibm.com> <20020919162214.A2285@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020919162214.A2285@in.ibm.com>; from suparna@in.ibm.com on Thu, Sep 19, 2002 at 04:22:14PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 04:22:14PM +0530, Suparna Bhattacharya wrote:
> On Wed, Sep 18, 2002 at 01:47:06PM -0700, Badari Pulavarty wrote:
> > Ben,
> > 
> > aio_read/aio_write() are now working with a minor fix to fs/aio.c
> > 
> > io_submit_one():
> > 	
> > 	if (likely(EIOCBQUEUED == ret))
> > 
> > 		needs to be changed to
> > 
> > 	if (likely(-EIOCBQUEUED == ret))
> > 		  ^^^
> > 
> > 
> > I was wondering what happens to following case (I think this
> > happend in my test program).
> > 
> > Lets say, I did an sys_io_submit() and my test program did exit().
> > When the IO complete happend, it tried to do following and got
> > an OOPS in aio_complete().
> > 
> > 	if (ctx == &ctx->mm->default_kioctx) { 
> > 
> > I think "mm" is freed up, when process exited. Do you think this is
> > possible ?  How do we handle this ?
> 
> Do you see this only in the sync case ?
> init_sync_iocb ought to increment ctx->reqs_active, so that
> exit_aio waits for the iocb's to complete.

Sorry, guess in the sync case, exit_aio shouldn't happen since 
the current thread still has a reference to the mm. 

And your problem is with the io_submit case ... have to look closely
to find out why.

> 
> Regards
> Suparna
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
