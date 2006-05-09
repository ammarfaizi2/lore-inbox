Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWEIXwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWEIXwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWEIXwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:52:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:41660 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932287AbWEIXwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:52:17 -0400
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu
In-Reply-To: <20060509120105.7255e265.akpm@osdl.org>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com>
	 <20060509120105.7255e265.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 09 May 2006 16:53:26 -0700
Message-Id: <1147218806.30738.2.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 12:01 -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> >  static ssize_t ep_aio_read_retry(struct kiocb *iocb)
> >  {
> >  	struct kiocb_priv	*priv = iocb->private;
> > -	ssize_t			status = priv->actual;
> > +	ssize_t			len, total;
> >  
> >  	/* we "retry" to get the right mm context for this: */
> > -	status = copy_to_user(priv->ubuf, priv->buf, priv->actual);
> > -	if (unlikely(0 != status))
> > -		status = -EFAULT;
> > -	else
> > -		status = priv->actual;
> > +
> > +	/* copy stuff into user buffers */
> > +	total = priv->actual;
> > +	len = 0;
> > +	for (i=0; i < priv->count; i++) {
> 
> 	for (i = 0
> 
> > +		ssize_t this = min(priv->iv[i].iov_len, (size_t)total);
> 
> min_t().
> 
> Strange mixture of size_t and ssize_t there.

Borrowed it from somewhere :( 
I will clean it up.

> 
> > +		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this))
> > +			break;
> > +
> > +		total -= this;
> > +		len += this;
> > +		if (total <= 0)
> > +			break;
> > +	}
> > +
> > +	if (unlikely(len != 0))
> > +		len = -EFAULT;
> 
> This looks wrong.  I think you meant (total != 0).

Yes. It should be "total".

Thanks,
Badari



