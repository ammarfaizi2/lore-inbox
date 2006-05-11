Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWEKSpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWEKSpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWEKSpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:45:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750932AbWEKSpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:45:11 -0400
Date: Thu, 11 May 2006 11:47:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
Message-Id: <20060511114743.53120432.akpm@osdl.org>
In-Reply-To: <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>  static ssize_t ep_aio_read_retry(struct kiocb *iocb)
>  {
>  	struct kiocb_priv	*priv = iocb->private;
> -	ssize_t			status = priv->actual;
> +	ssize_t			len, total;
>  
>  	/* we "retry" to get the right mm context for this: */
> -	status = copy_to_user(priv->ubuf, priv->buf, priv->actual);
> -	if (unlikely(0 != status))
> -		status = -EFAULT;
> -	else
> -		status = priv->actual;
> +
> +	/* copy stuff into user buffers */
> +	total = priv->actual;
> +	len = 0;
> +	for (i=0; i < priv->count; i++) {
> +		ssize_t this = min(priv->iv[i].iov_len, total);
> +
> +		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this))
> +			break;
> +
> +		total -= this;
> +		len += this;
> +		if (total <= 0)
> +			break;
> +	}
> +
> +	if (unlikely(len == 0))
> +		len = -EFAULT;

This is still wrong, isn't it?  Or am I looking at the same patch?

There's no way in which `total' can go negative, so it'd be nicer to just
test it for equality with zero.  Because if it goes unexpectedly negative,
we _want_ the kernel to malfunction, rather than mysteriously covering
things up.

The final test there should be

	if (unlikely(total != 0))

yes?
