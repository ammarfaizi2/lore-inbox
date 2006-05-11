Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWEKTGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWEKTGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWEKTGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:06:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:16779 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750714AbWEKTGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:06:34 -0400
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu
In-Reply-To: <20060511114743.53120432.akpm@osdl.org>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060511114743.53120432.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 11 May 2006 12:07:44 -0700
Message-Id: <1147374464.12421.24.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 11:47 -0700, Andrew Morton wrote:
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
> > +		ssize_t this = min(priv->iv[i].iov_len, total);
> > +
> > +		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this))
> > +			break;
> > +
> > +		total -= this;
> > +		len += this;
> > +		if (total <= 0)
> > +			break;
> > +	}
> > +
> > +	if (unlikely(len == 0))
> > +		len = -EFAULT;
> 
> This is still wrong, isn't it?  Or am I looking at the same patch?
> 
> There's no way in which `total' can go negative, so it'd be nicer to just
> test it for equality with zero.  Because if it goes unexpectedly negative,
> we _want_ the kernel to malfunction, rather than mysteriously covering
> things up.
> 
> The final test there should be
> 
> 	if (unlikely(total != 0))
> 
> yes?

No. The original check is correct - we want to return EFAULT if
copy_to_user() failed and we haven't copied anything so far.
If we copied anything so far, we should return, that many bytes.
(like short-io).


Thanks,
Badari

