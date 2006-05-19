Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWESSYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWESSYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWESSYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:24:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:60104 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932457AbWESSYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:24:07 -0400
Subject: Re: [PATCH 5/6] nfs: check all iov segments for correct memory
	access rights
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Chuck Lever <cel@citi.umich.edu>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no
In-Reply-To: <20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
	 <20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain
Date: Fri, 19 May 2006 11:25:06 -0700
Message-Id: <1148063106.7214.21.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 14:00 -0400, Chuck Lever wrote:

>  
> +/*
> + * Check:
> + * 1.  All bytes in the user buffers are properly accessible
> + * 2.  The resulting number of bytes won't overflow ssize_t
> + */
> +static ssize_t check_access_ok(int type, const struct iovec *iov, unsigned long nr_segs)
> +{
> +	ssize_t count = 0;
> +	ssize_t retval = -EINVAL;
> +	unsigned long seg;
> +
> +	for (seg = 0; seg < nr_segs; seg++) {
> +		void __user *buf = iov[seg].iov_base;
> +		ssize_t len = (ssize_t) iov[seg].iov_len;
> +
> +		if (len < 0)		/* size_t not fitting an ssize_t .. */
> +			goto out;
> +		if (unlikely(!access_ok(type, buf, len))) {
> +			retval = -EFAULT;
> +			goto out;
> +		}
> +		count += len;
> +		if (count < 0)		/* math overflow on the ssize_t */
> +			goto out;
> +	}
> +	retval = count;
> +out:
> +	return retval;
> +}
> +

May be move this to fs/read_write.c and export it - since we do the same
thing there also ?

Thanks,
Badari

