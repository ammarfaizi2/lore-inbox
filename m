Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWAQX1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWAQX1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAQX1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:27:15 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:61050 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750888AbWAQX1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:27:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CPSBGGT64imzyDpl5hk60dDKN+vieRPTkh6mNAdZLySvBDeeeWqIXpdl/WFKnjT3dv7oP58u5VVGzAFNmoY/4cyRnO9p+pYFmS1HHJdnVXblzVJrFGCvVCR4oV2cBz6+6plR/mGEWkW+aXI3s/wcqAGSKpylbo4mD6SbkrARNBY=
Subject: Re: [patch] bug fix in dio handling write error
From: Badari Pulavarty <pbadari@gmail.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, suparna@in.ibm.com
In-Reply-To: <200601171941.k0HJfwg14084@unix-os.sc.intel.com>
References: <200601171941.k0HJfwg14084@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 15:27:41 -0800
Message-Id: <1137540461.4966.155.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 11:41 -0800, Chen, Kenneth W wrote:
> There is a bug in direct-io on propagating write error up to the
> higher I/O layer.  When performing an async ODIRECT write to a
> block device, if a device error occurred (like media error or disk
> is pulled), the error code is only propagated from device driver
> to the DIO layer.  The error code stops at finished_one_bio(). The
> aysnc write, however, is supposedly have a corresponding AIO event
> with appropriate return code (in this case -EIO).  Application
> which waits on the async write event, will hang forever since such
> AIO event is lost forever (if such app did not use the timeout
> option in io_getevents call. Regardless, an AIO event is lost).
> 
> The problem is that calls to aio_complete() is conditioned upon
> READ, but it should've handle WRITE error as well.
> 
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> 
> 
> --- linux-2.6.15/fs/direct-io.c.orig	2006-01-17 11:54:17.010422462 -0800
> +++ linux-2.6.15/fs/direct-io.c	2006-01-17 12:08:00.444982688 -0800
> @@ -253,8 +253,7 @@ static void finished_one_bio(struct dio 
>  			dio_complete(dio, offset, transferred);
>  
>  			/* Complete AIO later if falling back to buffered i/o */
> -			if (dio->result == dio->size ||
> -				((dio->rw == READ) && dio->result)) {
> +			if (dio->result == dio->size || dio->result) {
>  				aio_complete(dio->iocb, transferred, 0);
>  				kfree(dio);
>  				return;
> 
> 

I vaguely remember adding the explicit "dio->rw == READ" check for a
reason (which escapes me right now). Suparna, do you remember ? Let me
think and get back to you.

Thanks,
Badari

