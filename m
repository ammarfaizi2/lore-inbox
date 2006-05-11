Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWEKUpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWEKUpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWEKUpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:45:36 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:1932 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750782AbWEKUpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:45:35 -0400
Message-ID: <4463A269.2080601@us.ibm.com>
Date: Thu, 11 May 2006 13:45:29 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, hch@lst.de, bcrl@kvack.org,
       cel@citi.umich.edu
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>	<1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>	<20060511114743.53120432.akpm@osdl.org>	<1147374464.12421.24.camel@dyn9047017100.beaverton.ibm.com> <20060511132136.569d59c1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>>On Thu, 2006-05-11 at 11:47 -0700, Andrew Morton wrote:
>>
>>>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>>
>>>> static ssize_t ep_aio_read_retry(struct kiocb *iocb)
>>>> {
>>>> 	struct kiocb_priv	*priv = iocb->private;
>>>>-	ssize_t			status = priv->actual;
>>>>+	ssize_t			len, total;
>>>> 
>>>> 	/* we "retry" to get the right mm context for this: */
>>>>-	status = copy_to_user(priv->ubuf, priv->buf, priv->actual);
>>>>-	if (unlikely(0 != status))
>>>>-		status = -EFAULT;
>>>>-	else
>>>>-		status = priv->actual;
>>>>+
>>>>+	/* copy stuff into user buffers */
>>>>+	total = priv->actual;
>>>>+	len = 0;
>>>>+	for (i=0; i < priv->count; i++) {
>>>>+		ssize_t this = min(priv->iv[i].iov_len, total);
>>>>+
>>>>+		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this))
>>>>+			break;
>>>>+
>>>>+		total -= this;
>>>>+		len += this;
>>>>+		if (total <= 0)
>>>>+			break;
>>>>+	}
>>>>+
>>>>+	if (unlikely(len == 0))
>>>>+		len = -EFAULT;
>>>>
>>>This is still wrong, isn't it?  Or am I looking at the same patch?
>>>
>>>There's no way in which `total' can go negative, so it'd be nicer to just
>>>test it for equality with zero.  Because if it goes unexpectedly negative,
>>>we _want_ the kernel to malfunction, rather than mysteriously covering
>>>things up.
>>>
>>>The final test there should be
>>>
>>>	if (unlikely(total != 0))
>>>
>>>yes?
>>>
>>No. The original check is correct - we want to return EFAULT if
>>copy_to_user() failed and we haven't copied anything so far.
>>If we copied anything so far, we should return, that many bytes.
>>(like short-io).
>>
>
>oic.  And we're sure that we cannot call into this code if someone's trying
>a zero-sized read?
>
>Either way, the below (which is faster!) will fix, yes?
>
>--- 25/drivers/usb/gadget/inode.c~vectorize-aio_read-aio_write-methods-fix	Thu May 11 11:53:41 2006
>+++ 25-akpm/drivers/usb/gadget/inode.c	Thu May 11 13:19:45 2006
>@@ -567,18 +567,18 @@ static ssize_t ep_aio_read_retry(struct 
> 	for (i = 0; i < priv->count; i++) {
> 		ssize_t this = min(priv->iv[i].iov_len, total);
> 
>-		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this))
>+		if (copy_to_user(priv->iv[i].iov_buf, priv->buf, this)) {
>+			if (len == 0)
>+				len = -EFAULT;
> 			break;
>+		}
> 
> 		total -= this;
> 		len += this;
>-		if (total <= 0)
>+		if (total == 0)
> 			break;
> 	}
> 
>-	if (unlikely(len == 0))
>-		len = -EFAULT;
>-
> 	kfree(priv->buf);
> 	kfree(priv);
> 	aio_put_req(iocb);
>_
>
Yes, this is good.

No one should call into this code with size == 0, since we should have 
returned
success without doing any IO in the first place.

Thanks,
Badari


