Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWCUHGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWCUHGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWCUHGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:06:48 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30393 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932270AbWCUHGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:06:47 -0500
Date: Tue, 21 Mar 2006 12:36:40 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       "'Zach Brown'" <zach.brown@oracle.com>, pbadari@gmail.com
Subject: Re: [patch] bug fix in dio handling write error - v2
Message-ID: <20060321070640.GA18895@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060319115458.GA29422@in.ibm.com> <200603192227.k2JMRNg30260@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603192227.k2JMRNg30260@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 02:27:33PM -0800, Chen, Kenneth W wrote:
> Suparna Bhattacharya wrote on Sunday, March 19, 2006 3:55 AM
> > On Sun, Mar 19, 2006 at 01:27:33AM -0800, Chen, Kenneth W wrote:
> > > Referring to original posting:
> > > http://marc.theaimsgroup.com/?t=113752710100001&r=1&w=2
> > > 
> > > Suparna pointed out that this fix has a potential race window.  I think
> > > the race condition also exists on the READ side currently. The fundamental
> > > problem is that dio->result is overloaded with dual use: an indicator of
> > > fall back path for partial dio write, and an error indicator used in the
> > > I/O completion path.  In the event of device error, the setting of -EIO
> > > to dio->result clashes with value used to track partial write that activates
> > > the fall back path.
> > 
> > Isn't there a possibility that part of the IO for the overall request
> > may already have been submitted at this point ? (i.e. within
> > do_direct_IO->submit_page_section ->dio_send_cur_page->dio_bio_submit) 
> > This is what I was referring to in my earlier response to Zach's patch.
> 
> I suppose it is possible there.  What you are saying here is effectively
> that it is impossible to use dio->result to track partial write and at the
> same time to track error returned from device driver. Because direct_io_work
> can only determines whether it is a partial write at the end of io submission
> and in mid stream of those io submission, a return code could be coming back
> from the driver.  Thus messing up all the subsequent logic.
> 
> Taking one of your earlier idea, how about the following patch: separating
> out IO completion code from partial IO tracking?

Yup, this looks like the right fix. Hopefully you've had a chance to pound
on it a bit with all the tests since verifying this code by mere eyeballs
alone is beyond mere mortals :)

Regards
Suparna 

> 
> 
> --- ./fs/direct-io.c.orig	2006-03-19 13:36:52.000000000 -0800
> +++ ./fs/direct-io.c	2006-03-19 13:47:42.000000000 -0800
> @@ -129,6 +129,7 @@ struct dio {
>  	/* AIO related stuff */
>  	struct kiocb *iocb;		/* kiocb */
>  	int is_async;			/* is IO async ? */
> +	int completion_code;		/* IO completion code */
>  	ssize_t result;                 /* IO result */
>  };
>  
> @@ -250,6 +251,10 @@ static void finished_one_bio(struct dio 
>  			    ((offset + transferred) > dio->i_size))
>  				transferred = dio->i_size - offset;
>  
> +			/* check for error in completion path */
> +			if (dio->completion_code)
> +				transferred = dio->completion_code;
> +
>  			dio_complete(dio, offset, transferred);
>  
>  			/* Complete AIO later if falling back to buffered i/o */
> @@ -406,7 +411,7 @@ static int dio_bio_complete(struct dio *
>  	int page_no;
>  
>  	if (!uptodate)
> -		dio->result = -EIO;
> +		dio->completion_code = -EIO;
>  
>  	if (dio->is_async && dio->rw == READ) {
>  		bio_check_pages_dirty(bio);	/* transfers ownership */
> @@ -964,6 +969,7 @@ direct_io_worker(int rw, struct kiocb *i
>  	dio->next_block_for_io = -1;
>  
>  	dio->page_errors = 0;
> +	dio->completion_code = 0;
>  	dio->result = 0;
>  	dio->iocb = iocb;
>  	dio->i_size = i_size_read(inode);
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

