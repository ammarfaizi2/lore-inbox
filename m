Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWCUQy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWCUQy6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWCUQy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:54:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:3799 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932133AbWCUQy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:54:57 -0500
Subject: Re: [patch] direct-io: bug fix in dio handling write error
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: akpm@osdl.org, suparna@in.ibm.com, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200603210851.k2L8pHg21393@unix-os.sc.intel.com>
References: <200603210851.k2L8pHg21393@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 08:56:43 -0800
Message-Id: <1142960203.6086.4.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 00:51 -0800, Chen, Kenneth W wrote:
....
> 
> Andrew - please merge this version.  Thank you.
> 
> 
> --- ./fs/direct-io.c.orig	2006-01-02 19:21:10.000000000 -0800
> +++ ./fs/direct-io.c	2006-03-21 01:28:48.704475280 -0800
> @@ -129,6 +129,7 @@ struct dio {
>  	/* AIO related stuff */
>  	struct kiocb *iocb;		/* kiocb */
>  	int is_async;			/* is IO async ? */
> +	int io_error;			/* IO error in completion path */
>  	ssize_t result;                 /* IO result */
>  };
>  
> @@ -250,6 +251,10 @@ static void finished_one_bio(struct dio 
>  			    ((offset + transferred) > dio->i_size))
>  				transferred = dio->i_size - offset;
>  
> +			/* check for error in completion path */
> +			if (dio->io_error)
> +				transferred = dio->io_error;
> +
>  			dio_complete(dio, offset, transferred);
>  
>  			/* Complete AIO later if falling back to buffered i/o */
> @@ -406,7 +411,7 @@ static int dio_bio_complete(struct dio *
>  	int page_no;
>  
>  	if (!uptodate)
> -		dio->result = -EIO;
> +		dio->io_error = -EIO;
>  
>  	if (dio->is_async && dio->rw == READ) {
>  		bio_check_pages_dirty(bio);	/* transfers ownership */
> @@ -964,6 +969,7 @@ direct_io_worker(int rw, struct kiocb *i
>  	dio->next_block_for_io = -1;
>  
>  	dio->page_errors = 0;
> +	dio->io_error = 0;
>  	dio->result = 0;
>  	dio->iocb = iocb;
>  	dio->i_size = i_size_read(inode);
> 

Ken,

I hate to do this you - but your patch breaks error handling on
synchronous DIO requests.

Since you are using "dio->io_error" instead of "dio->result" to
represent an error - you need to make sure to check that (also ?)
instead of dio->result in direct_io_worker() before calling 
dio_complete().

Isn't it ? Am I missing something ?

Thanks,
Badari

