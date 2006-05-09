Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWEIS6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWEIS6d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWEIS6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:58:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751101AbWEIS6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:58:32 -0400
Date: Tue, 9 May 2006 12:01:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
Message-Id: <20060509120105.7255e265.akpm@osdl.org>
In-Reply-To: <1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com>
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

	for (i = 0

> +		ssize_t this = min(priv->iv[i].iov_len, (size_t)total);

min_t().

Strange mixture of size_t and ssize_t there.

> +		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this))
> +			break;
> +
> +		total -= this;
> +		len += this;
> +		if (total <= 0)
> +			break;
> +	}
> +
> +	if (unlikely(len != 0))
> +		len = -EFAULT;

This looks wrong.  I think you meant (total != 0).




Together these three patches shrink the kernel by 113 lines.  I don't know
what the effect is on text size, but that's a pretty modest saving, at a
pretty high risk level.

What else do we get in return for this risk?
