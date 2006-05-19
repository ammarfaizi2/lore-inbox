Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWESSTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWESSTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWESSTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:19:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24453 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751351AbWESSTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:19:47 -0400
Date: Fri, 19 May 2006 11:22:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Lever <cel@citi.umich.edu>
Cc: cel@netapp.com, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: [PATCH 5/6] nfs: check all iov segments for correct memory
 access rights
Message-Id: <20060519112231.5ed3d565.akpm@osdl.org>
In-Reply-To: <20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
	<20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <cel@netapp.com> wrote:
>
> +/*
> + * Check:
> + * 1.  All bytes in the user buffers are properly accessible
> + * 2.  The resulting number of bytes won't overflow ssize_t
> + */

hm.

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

do_readv_writev() already checked for negative iov_len, and that's the more
appropriate place to do it, rather than duplicating it in each filesystem
(or forgetting to!)

So is this check really needed?

> +		if (unlikely(!access_ok(type, buf, len))) {
> +			retval = -EFAULT;
> +			goto out;
> +		}

Now what's up here?  Why does NFS, at this level, care about the page's
virtual address?  get_user_pages() will handle that?

